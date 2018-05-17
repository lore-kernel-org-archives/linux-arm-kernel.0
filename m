From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Thu, 17 May 2018 10:20:51 +0100
Subject: [PATCH] dmaengine: qcom: bam_dma: check if the runtime pm enabled
In-Reply-To: <20180517052107.GT13271@vkoul-mobl>
References: <20180514161852.9620-1-srinivas.kandagatla@linaro.org>
 <20180517052107.GT13271@vkoul-mobl>
Message-ID: <2136d6a5-c039-d319-0d32-b0f6ef81e4e0@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 17/05/18 06:21, Vinod wrote:
> On 14-05-18, 17:18, Srinivas Kandagatla wrote:
>> Disabling pm runtime at probe is not sufficient to get BAM working
>> on remotely controller instances. pm_runtime_get_sync() would return
>> -EACCES in such cases.
>> So check if runtime pm is enabled before returning error from bam functions.
>>
>> Fixes: 5b4a68952a89 ("dmaengine: qcom: bam_dma: disable runtime pm on remote controlled")
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   drivers/dma/qcom/bam_dma.c | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
>> index d29275b97e84..5f4babebc508 100644
>> --- a/drivers/dma/qcom/bam_dma.c
>> +++ b/drivers/dma/qcom/bam_dma.c
>> @@ -540,7 +540,7 @@ static void bam_free_chan(struct dma_chan *chan)
>>   	int ret;
>>   
>>   	ret = pm_runtime_get_sync(bdev->dev);
>> -	if (ret < 0)
>> +	if (pm_runtime_enabled(bdev->dev) && ret < 0)
> 
> would it make sense to first check enabled and do _get_sync()
>
Both of them check the disable_depth, however doing it the way you 
suggested would avoid some additional calls.

>          if (pm_runtime_enabled()) {
>                  ret = pm_runtime_get_sync() {
>                  ...
>                  }
>          }
sound like good idea!
> 
Just noticed that some of the drivers use:

         err = pm_runtime_get_sync(dev);
         if (err < 0 && err !=-EACCES)
		return;

others warp up this into local function.

Will send a v2!


thanks,
srini

> thus making clear in code that we do calls only when it is enabled. Also you can
> add a local macro for this code and use that rather than copy pasting :)
> 
