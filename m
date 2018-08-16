From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Thu, 16 Aug 2018 16:45:32 +0100
Subject: [PATCH 05/13] coresight: etm3: Add support for handling errors
In-Reply-To: <20180815193456.GA17954@xps15>
References: <1533562915-21558-1-git-send-email-suzuki.poulose@arm.com>
 <1533562915-21558-6-git-send-email-suzuki.poulose@arm.com>
 <20180815193456.GA17954@xps15>
Message-ID: <21cdb867-ece1-7da4-810a-da22f1268d90@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/08/18 20:34, Mathieu Poirier wrote:
> On Mon, Aug 06, 2018 at 02:41:47PM +0100, Suzuki K Poulose wrote:
>> Add support for reporting errors back from the SMP cross
>> function call for enabling ETM.
>>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-etm3x.c | 42 ++++++++++++++++++---------
>>   1 file changed, 28 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
>> index 9ce8fba..771691c 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm3x.c
>> +++ b/drivers/hwtracing/coresight/coresight-etm3x.c
>> @@ -355,11 +355,10 @@ static int etm_parse_event_config(struct etm_drvdata *drvdata,
>>   	return 0;
>>   }
>>   
>> -static void etm_enable_hw(void *info)
>> +static int etm_enable_hw(struct etm_drvdata *drvdata)
>>   {
>>   	int i;
>>   	u32 etmcr;
>> -	struct etm_drvdata *drvdata = info;
>>   	struct etm_config *config = &drvdata->config;
>>   
>>   	CS_UNLOCK(drvdata->base);
>> @@ -421,6 +420,21 @@ static void etm_enable_hw(void *info)
>>   	CS_LOCK(drvdata->base);
>>   
>>   	dev_dbg(drvdata->dev, "cpu: %d enable smp call done\n", drvdata->cpu);
>> +	return 0;
>> +}
>> +
>> +struct etm_enable_arg {
>> +	struct etm_drvdata *drvdata;
>> +	int rc;
>> +}
> 
> This doesn't compile a ';' is missing.

Oops. Sorry about that. I will give the series a spin on arm32.

Suzuki
