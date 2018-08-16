From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Thu, 16 Aug 2018 15:47:54 +0100
Subject: [PATCH 03/13] coresight: tmc-etb/etf: Prepare to handle errors
 enabling
In-Reply-To: <20180815192246.GA11625@xps15>
References: <1533562915-21558-1-git-send-email-suzuki.poulose@arm.com>
 <1533562915-21558-4-git-send-email-suzuki.poulose@arm.com>
 <20180815192246.GA11625@xps15>
Message-ID: <0c55731b-b1cb-18ed-bf7c-057d1310cfdc@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/08/18 20:22, Mathieu Poirier wrote:
> On Mon, Aug 06, 2018 at 02:41:45PM +0100, Suzuki K Poulose wrote:
>> Prepare to handle errors in enabling the hardware and
>> report it back to the core driver.
>>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-tmc-etf.c | 71 +++++++++++++++----------
>>   1 file changed, 44 insertions(+), 27 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
>> index 4156c95..ceb4b30 100644
>> --- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
>> +++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c

>> @@ -271,6 +285,7 @@ static void tmc_disable_etf_sink(struct coresight_device *csdev)
>>   static int tmc_enable_etf_link(struct coresight_device *csdev,
>>   			       int inport, int outport)
>>   {
>> +	int ret;
>>   	unsigned long flags;
>>   	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>>   
>> @@ -280,11 +295,13 @@ static int tmc_enable_etf_link(struct coresight_device *csdev,
>>   		return -EBUSY;
>>   	}
>>   
>> -	tmc_etf_enable_hw(drvdata);
>> -	drvdata->mode = CS_MODE_SYSFS;
>> +	ret = tmc_etf_enable_hw(drvdata);
>> +	if (!ret)
>> +		drvdata->mode = CS_MODE_SYSFS;
>>   	spin_unlock_irqrestore(&drvdata->spinlock, flags);
>>   
>> -	dev_dbg(drvdata->dev, "TMC-ETF enabled\n");
>> +	if (!ret)
>> +		dev_dbg(drvdata->dev, "TMC-ETF enabled\n");
>>   	return 0;
> 
> We need to tell the caller if an error as occured:
> 
>          return ret;
> 

Thanks for catching it, will fix.

Suzuki
