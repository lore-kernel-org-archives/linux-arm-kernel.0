From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Fri, 3 Nov 2017 10:03:59 +0000
Subject: [PATCH 10/17] coresight: etr: Track if the device is coherent
In-Reply-To: <20171102194022.GC23320@xps15>
References: <20171019171553.24056-1-suzuki.poulose@arm.com>
 <20171019171553.24056-11-suzuki.poulose@arm.com>
 <20171102194022.GC23320@xps15>
Message-ID: <50c2ab4c-7cb9-4f48-d058-9a44c28a81e9@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/11/17 19:40, Mathieu Poirier wrote:
> On Thu, Oct 19, 2017 at 06:15:46PM +0100, Suzuki K Poulose wrote:
>> Track if the ETR is dma-coherent or not. This will be useful
>> in deciding if we should use software buffering for perf.
>>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-tmc.c | 5 ++++-
>>   drivers/hwtracing/coresight/coresight-tmc.h | 1 +
>>   2 files changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
>> index 4939333cc6c7..5a8c41130f96 100644
>> --- a/drivers/hwtracing/coresight/coresight-tmc.c
>> +++ b/drivers/hwtracing/coresight/coresight-tmc.c
>> @@ -347,6 +347,9 @@ static int tmc_etr_setup_caps(struct tmc_drvdata *drvdata,
>>   	if (!(devid & TMC_DEVID_NOSCAT))
>>   		tmc_etr_set_cap(drvdata, TMC_ETR_SG);
>>   
>> +	if (device_get_dma_attr(drvdata->dev) == DEV_DMA_COHERENT)
>> +		tmc_etr_set_cap(drvdata, TMC_ETR_COHERENT);
>> +
>>   	/* Check if the AXI address width is available */
>>   	if (devid & TMC_DEVID_AXIAW_VALID)
>>   		dma_mask = ((devid >> TMC_DEVID_AXIAW_SHIFT) &
>> @@ -397,7 +400,7 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
>>   	if (!drvdata)
>>   		goto out;
>>   
>> -	drvdata->dev = &adev->dev;
>> +	drvdata->dev = dev;
> 
> What is that one for?
> 

Oops, that was a minor cleanup and need not be part of this patch. I will leave things
as it is. It is not worth a separate patch.

Cheers
Suzuki
