From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Thu, 1 Oct 2015 16:26:09 -0600
Subject: [RFC PATCH 01/20] coresight: etm3x: splitting 'etm_enable_hw()'
 operations
In-Reply-To: <87r3lgjkjw.fsf@ashishki-desk.ger.corp.intel.com>
References: <1442593594-10665-1-git-send-email-mathieu.poirier@linaro.org>
 <1442593594-10665-2-git-send-email-mathieu.poirier@linaro.org>
 <87r3lgjkjw.fsf@ashishki-desk.ger.corp.intel.com>
Message-ID: <CANLsYkyOvHT1caPMNP0J90c1h9PAUsod7C8+kJg83taw4Ls6HQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 September 2015 at 03:58, Alexander Shishkin
<alexander.shishkin@linux.intel.com> wrote:
> Mathieu Poirier <mathieu.poirier@linaro.org> writes:
>
>> -static void etm_enable_hw(void *info)
>> +static void etm_power_up_cpu(void *info)
>>  {
>> -     int i;
>> -     u32 etmcr;
>> -     struct etm_drvdata *drvdata = info;
>> +     struct coresight_device *csdev = info;
>> +     struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>> +
>> +     WARN_ON(drvdata->cpu != smp_processor_id());
>
> Maybe WARN_ON_ONCE() is sufficient here (and other similar places).

Yes, let's go with that.

>
>> +static void etm_power_down_cpu(void *info)
>> +{
>> +     struct coresight_device *csdev = info;
>> +     struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>> +
>> +     WARN_ON(drvdata->cpu != smp_processor_id());
>
> Likewise.
>
>> +/**
>> + * etm_configure_cpu - configure ETM registers
>> + * @csdev - the etm that needs to be configure.
>> + *
>> + * Applies a configuration set to the ETM registers _without_ enabling the
>> + * tracer.  This function needs to be executed on the CPU who's tracer is
>> + * being configured.
>> + */
>> +static void etm_configure_cpu(void *info)
>> +{
>> +     int i;
>> +     u32 etmcr;
>> +     struct coresight_device *csdev = info;
>> +     struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>> +
>> +     WARN_ON(drvdata->cpu != smp_processor_id());
>
> Likewise.
>
>> +
>> +     CS_UNLOCK(drvdata->base);
>>       etm_set_prog(drvdata);
>>
>>       etmcr = etm_readl(drvdata, ETMCR);
>> -     etmcr &= (ETMCR_PWD_DWN | ETMCR_ETM_PRG);
>>       etmcr |= drvdata->port_size;
>>       etm_writel(drvdata, drvdata->ctrl | etmcr, ETMCR);
>>       etm_writel(drvdata, drvdata->trigger_event, ETMTRIGGER);
>
> Most of these things can also be bypassed, as at least initially perf
> events won't be using trigger/sequencer configurations, so we could
> simply clear all these things out when a first perf event is created
> (which would also disallow any sysfs poking around the etm/etb) and not
> worry about them in the pmu callbacks.

I don't want to restrain configuration options to what is available
through Perf's cmd line.  The sysFS interface is there to complement
what is currently not available.  Poking around in the sysFS registers
is allowed for a long as a tracer hasn't been commissioned by Perf.  I
do agree though that a mechanism need to be set in place to prevent
changing configuration values once Perf has taken control of a tracer.


>
> Regards,
> --
> Alex
