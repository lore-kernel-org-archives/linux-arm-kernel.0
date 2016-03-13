From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 14 Mar 2016 08:51:02 +0900
Subject: [RFT 1/2] [media] exynos4-is: Add missing endpoint of_node_put on
 error paths
In-Reply-To: <56E2BA7D.9050500@samsung.com>
References: <1453768906-28979-1-git-send-email-k.kozlowski@samsung.com>
 <56E2BA7D.9050500@samsung.com>
Message-ID: <56E5FCE6.6060508@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11.03.2016 21:30, Sylwester Nawrocki wrote:
> On 01/26/2016 01:41 AM, Krzysztof Kozlowski wrote:
>> In fimc_md_parse_port_node() endpoint node is get with of_get_next_child()
>> but it is not put on error path.
> 
> "is get" doesn't sound right to me, how about rephrasing this to:
> 
> "In fimc_md_parse_port_node() reference count of the endpoint node
> "is incremented by of_get_next_child() but it is not decremented
>  on error path."
> 
>> Fixes: 56fa1a6a6a7d ("[media] s5p-fimc: Change the driver directory name to exynos4-is")
>> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>> ---
>> Not tested on hardware, only built+static checkers.
>> ---
>>  drivers/media/platform/exynos4-is/media-dev.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/media/platform/exynos4-is/media-dev.c 
>> b/drivers/media/platform/exynos4-is/media-dev.c
>> index f3b2dd30ec77..de0977479327 100644
>> --- a/drivers/media/platform/exynos4-is/media-dev.c
>> +++ b/drivers/media/platform/exynos4-is/media-dev.c
>> @@ -339,8 +339,10 @@ static int fimc_md_parse_port_node(struct fimc_md *fmd,
>>  		return 0;
>>  
>>  	v4l2_of_parse_endpoint(ep, &endpoint);
>> -	if (WARN_ON(endpoint.base.port == 0) || index >= FIMC_MAX_SENSORS)
>> +	if (WARN_ON(endpoint.base.port == 0) || index >= FIMC_MAX_SENSORS) {
>> +		of_node_put(ep);
>>  		return -EINVAL;
>> +	}
> 
> Thanks for the patch, it looks correct but it doesn't apply cleanly
> due to patches already in media master branch [1]. Could you refresh
> this patch and resend?
> Also I don't quite like multiple calls to of_node_put(), how about
> doing something like this instead:

How about sending your patch then with my reported-by?

Best regards,
Krzysztof
