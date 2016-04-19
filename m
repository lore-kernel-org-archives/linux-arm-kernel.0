From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 19 Apr 2016 10:16:22 -0600
Subject: [PATCH V2 11/15] coresight: tmc: make sysFS and Perf mode
 mutually exclusive
In-Reply-To: <571635C6.9070903@arm.com>
References: <1460483692-25061-1-git-send-email-mathieu.poirier@linaro.org>
 <1460483692-25061-12-git-send-email-mathieu.poirier@linaro.org>
 <571635C6.9070903@arm.com>
Message-ID: <CANLsYkwOkF3Huzjxr6Pds4_e3m9kC03Qu1t-8xUg7fyFQGOvzg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 April 2016 at 07:42, Suzuki K Poulose <Suzuki.Poulose@arm.com> wrote:
> On 12/04/16 18:54, Mathieu Poirier wrote:
>>
>> The sysFS and Perf access methods can't be allowed to interfere
>> with one another.  As such introducing guards to access
>> functions that prevents moving forward if a TMC is already
>> being used.
>>
>> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>> ---
>>   drivers/hwtracing/coresight/coresight-tmc-etf.c | 59
>> +++++++++++++++++++++-
>>   drivers/hwtracing/coresight/coresight-tmc-etr.c | 67
>> +++++++++++++++++++++++--
>>   2 files changed, 119 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c
>> b/drivers/hwtracing/coresight/coresight-tmc-etf.c
>> index 9b4cdaed09f5..50d32e8ef4ea 100644
>> --- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
>> +++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
>> @@ -111,7 +111,7 @@ static void tmc_etf_disable_hw(struct tmc_drvdata
>> *drvdata)
>>         CS_LOCK(drvdata->base);
>>   }
>>
>> -static int tmc_enable_etf_sink(struct coresight_device *csdev, u32 mode)
>> +static int tmc_enable_etf_sink_sysfs(struct coresight_device *csdev, u32
>> mode)
>>   {
>>         bool allocated = false;
>>         char *buf = NULL;
>> @@ -189,6 +189,53 @@ out:
>>         return 0;
>>   }
>>
>> +static int tmc_enable_etf_sink_perf(struct coresight_device *csdev, u32
>> mode)
>> +{
>> +       int ret = 0;
>> +       u32 val;
>
>
> To be on the safer side, I believe 'val' should be unsigned long, to match
> the size of local_t.
>
>> +       unsigned long flags;
>> +       struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>> +
>> +        /* This shouldn't be happening */
>> +       WARN_ON(mode != CS_MODE_PERF);
>
>
> I think the above check, and the mode parameter itself is superfluous, given
> that this is a static function used internally only for the PERF mode.
> Similarly for the _sysfs version.

We definitely misunderstood each other then - the only reason I added
the checks is after what (I thought) you suggested in the previous
revision.

>
>> +
>> +       spin_lock_irqsave(&drvdata->spinlock, flags);
>> +       if (drvdata->reading) {
>> +               ret = -EINVAL;
>> +               goto out;
>> +       }
>> +
>> +       val = local_xchg(&drvdata->mode, mode);
>
>
> We should be using local_cmpxchg() here. Otherwise, we could corrupt the
> mode.

The newly added (above) check allows us to do that now.  There can
only be one value coming in (CS_MODE_PERF) and the current type can
only be CS_MODE_PERF/DISABLED.

> Similarly for the _sysfs version. I though the previous version of your
> series
> did that.
>
>> +       /*
>> +        * In Perf mode there can be only one writer per sink.  There
>> +        * is also no need to continue if the ETB/ETR is already operated
>> +        * from sysFS.
>> +        */
>> +       if (val != CS_MODE_DISABLED) {
>> +               ret = -EINVAL;
>> +               goto out;
>> +       }
>
>
>
>>   static void tmc_disable_etf_sink(struct coresight_device *csdev)
>>   {
>>         u32 val;
>> @@ -271,6 +318,7 @@ const struct coresight_ops tmc_etf_cs_ops = {
>>
>>   int tmc_read_prepare_etb(struct tmc_drvdata *drvdata)
>>   {
>> +       u32 val;
>>         enum tmc_mode mode;
>>         int ret = 0;
>>         unsigned long flags;
>> @@ -289,6 +337,13 @@ int tmc_read_prepare_etb(struct tmc_drvdata *drvdata)
>>                 goto out;
>>         }
>>
>> +       val = local_read(&drvdata->mode);
>> +       /* Don't interfere if operated from Perf */
>> +       if (val == CS_MODE_PERF) {
>> +               ret = -EINVAL;
>> +               goto out;
>> +       }
>
>
> Could we get here when CS_DISABLED ? If not, we could get rid of the check
> for CS_MODE_SYSFS below.
>
>> +
>>         /* If drvdata::buf is NULL the trace data has been read already */
>>         if (drvdata->buf == NULL) {
>>                 ret = -EINVAL;
>> @@ -296,7 +351,7 @@ int tmc_read_prepare_etb(struct tmc_drvdata *drvdata)
>>         }
>>
>>         /* Disable the TMC if need be */
>> -       if (local_read(&drvdata->mode) == CS_MODE_SYSFS)
>> +       if (val == CS_MODE_SYSFS)
>>                 tmc_etb_disable_hw(drvdata);
>
> See above

Yes, we can get here when mode is set to CS_MODE_DISABLED.  Someone
can read the /dev/xyz entry whenever they want, including when a sink
hasn't been enabled.

Thanks,
Mathieu

>
>>         drvdata->reading = true;
>> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c
>> b/drivers/hwtracing/coresight/coresight-tmc-etr.c
>> index de5cf0056802..04fc63d85696 100644
>> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
>> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
>> @@ -87,7 +87,7 @@ static void tmc_etr_disable_hw(struct tmc_drvdata
>> *drvdata)
>>         CS_LOCK(drvdata->base);
>>   }
>>
>> -static int tmc_enable_etr_sink(struct coresight_device *csdev, u32 mode)
>> +static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev, u32
>> mode)
>>   {
>>         bool allocated = false;
>>         u32 val;
>> @@ -166,6 +166,53 @@ out:
>>         return 0;
>>   }
>>
>
>> +static int tmc_enable_etr_sink_perf(struct coresight_device *csdev, u32
>> mode)
>
> ...
>
>>   static void tmc_disable_etr_sink(struct coresight_device *csdev)
>
>
> Same comments as for the etb side.
>
> Suzuki
>
>  {
>
