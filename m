From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Tue, 19 Apr 2016 14:14:59 +0100
Subject: [PATCH V2 07/15] coresight: tmc: allocating memory when needed
In-Reply-To: <57162AA6.3030605@arm.com>
References: <1460483692-25061-1-git-send-email-mathieu.poirier@linaro.org>
 <1460483692-25061-8-git-send-email-mathieu.poirier@linaro.org>
 <57162AA6.3030605@arm.com>
Message-ID: <57162F53.9030308@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/04/16 13:55, Suzuki K Poulose wrote:
> On 12/04/16 18:54, Mathieu Poirier wrote:
>> In it's current form the TMC probe() function allocates
>> trace buffer memory at boot time, event if coresight isn't
>> used.  This is highly inefficient since trace buffers can
>> occupy a lot of memory that could be used otherwised.
>>
>> This patch allocates trace buffers on the fly, when the
>> coresight subsystem is solicited.  Allocated buffers are
>> released when traces are read using the device descriptors
>> under /dev.
>>

>>       /* Wait for TMCSReady bit to be set */
>> @@ -110,19 +108,68 @@ static void tmc_etf_disable_hw(struct tmc_drvdata *drvdata)
>>
>>   static int tmc_enable_etf_sink(struct coresight_device *csdev, u32 mode)
>>   {
>> +    bool allocated = false;
>
> nit: does "used" or buf_used sound more suitable than allocated ?
>
>> +    char *buf = NULL;
>>       unsigned long flags;
>>       struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>>
>> +     /* This shouldn't be happening */
>> +    WARN_ON(mode != CS_MODE_SYSFS);

And we should proceed no further. Return immediately.
