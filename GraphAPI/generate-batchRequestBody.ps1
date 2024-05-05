function Create-UrlListBatchOutput {
    param (
        [System.Collections.Generic.List[string]] $urlList
    )

    $chunks = Chunk-List $urlList 20
    $outputJsonStrings = @()

    foreach ($chunk in $chunks) {
        $outputObject = @{
            requests = @()
        }

        $requestId = 1
        foreach ($urlValue in $chunk) {
            $request = @{
                id = $requestId++
                method = "GET"
                url = $urlValue
            }
            $outputObject.requests += $request
        }
        $outputJsonStrings += ($outputObject | ConvertTo-Json)
    }
    return ,$outputJsonStrings
}

function Chunk-List {
    param (
        [System.Collections.Generic.List[string]] $list,
        [int] $chunkSize
    )

    $chunks = @()
    for ($i = 0; $i -lt $list.Count; $i += $chunkSize) {
        $chunks += ,$list[$i..($i + $chunkSize - 1)]
    }
    return ,$chunks
}
