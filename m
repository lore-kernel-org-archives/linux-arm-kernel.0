From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Thu, 16 Aug 2018 16:46:14 +0100
Subject: [PATCH 06/13] coresight: etb10: Handle errors enabling the device
In-Reply-To: <20180815193807.GB17954@xps15>
References: <1533562915-21558-1-git-send-email-suzuki.poulose@arm.com>
 <1533562915-21558-7-git-send-email-suzuki.poulose@arm.com>
 <20180815193807.GB17954@xps15>
Message-ID: <b62fec35-ca6b-acf3-4201-0a2776672798@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/08/18 20:38, Mathieu Poirier wrote:
> On Mon, Aug 06, 2018 at 02:41:48PM +0100, Suzuki K Poulose wrote:
>> Prepare the etb10 driver to return errors in enabling
>> the device.
>>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-etb10.c | 18 +++++++++++++-----
>>   1 file changed, 13 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
>> index 9fd77fd..37d2c88 100644
>> --- a/drivers/hwtracing/coresight/coresight-etb10.c
>> +++ b/drivers/hwtracing/coresight/coresight-etb10.c
>> @@ -107,7 +107,7 @@ static unsigned int etb_get_buffer_depth(struct etb_drvdata *drvdata)
>>   	return depth;
>>   }
>>   
>> -static void etb_enable_hw(struct etb_drvdata *drvdata)
>> +static void __etb_enable_hw(struct etb_drvdata *drvdata)
>>   {
>>   	int i;
>>   	u32 depth;
>> @@ -135,6 +135,12 @@ static void etb_enable_hw(struct etb_drvdata *drvdata)
>>   	CS_LOCK(drvdata->base);
>>   }
>>   
>> +static int etb_enable_hw(struct etb_drvdata *drvdata)
>> +{
>> +	__etb_enable_hw(drvdata);
>> +	return 0;
>> +}
>> +
>>   static int etb_enable(struct coresight_device *csdev, u32 mode, void *data)
>>   {
>>   	int ret = 0;
>> @@ -150,7 +156,7 @@ static int etb_enable(struct coresight_device *csdev, u32 mode, void *data)
>>   	if (mode == CS_MODE_PERF) {
>>   		ret = etb_set_buffer(csdev, (struct perf_output_handle *)data);
>>   		if (ret)
>> -			goto out;
>> +			return ret;
>>   	}
>>   
>>   	val = local_cmpxchg(&drvdata->mode,
>> @@ -172,12 +178,14 @@ static int etb_enable(struct coresight_device *csdev, u32 mode, void *data)
>>   		goto out;
> 
> Leaving this here doesn't compile when 'out' is removed below.

I will fix it for arm32. Sorry about that.

Suzuki
