From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Thu, 23 Nov 2017 10:03:33 -0700
Subject: [PATCH v2 4/4] coresight: etm4x: Hook panic dump callback for
 etmv4
In-Reply-To: <20171122190905.GB17705@xps15>
References: <1511233724-11867-1-git-send-email-leo.yan@linaro.org>
 <1511233724-11867-5-git-send-email-leo.yan@linaro.org>
 <20171122190905.GB17705@xps15>
Message-ID: <CANLsYkzp47dshP_4PfEdEKFfjZD4VsMr7rn5Y=WrKv_RX5dzKw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 November 2017 at 12:09, Mathieu Poirier
<mathieu.poirier@linaro.org> wrote:
> On Tue, Nov 21, 2017 at 11:08:44AM +0800, Leo Yan wrote:
>> We need to dump etmv4 info as metadata, so the data can be used for
>> offline checking for configuration and generate 'perf' compatible
>> file.  This commit hooks etmv4 callback for panic dump.
>>
>> Signed-off-by: Leo Yan <leo.yan@linaro.org>
>> ---
>>  drivers/hwtracing/coresight/coresight-etm4x.c | 22 ++++++++++++++++++++++
>>  drivers/hwtracing/coresight/coresight-etm4x.h | 15 +++++++++++++++
>>  2 files changed, 37 insertions(+)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
>> index cf364a5..bf9608b 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm4x.c
>> +++ b/drivers/hwtracing/coresight/coresight-etm4x.c
>> @@ -418,11 +418,33 @@ static void etm4_disable(struct coresight_device *csdev,
>>               local_set(&drvdata->mode, CS_MODE_DISABLED);
>>  }
>>
>> +static void etm4_panic_cb(void *data)
>> +{
>> +     struct coresight_device *csdev = (struct coresight_device *)data;
>> +     int cpu = smp_processor_id();
>> +     struct etmv4_drvdata *drvdata = etmdrvdata[cpu];
>> +     struct etmv4_config *config = &drvdata->config;
>> +     struct etmv4_metadata *metadata = &drvdata->metadata;
>> +
>> +     metadata->magic = ETM4_METADATA_MAGIC;
>> +     metadata->cpu = cpu;
>> +     metadata->trcconfigr = config->cfg;
>> +     metadata->trctraceidr = drvdata->trcid;
>> +     metadata->trcidr0 = readl_relaxed(drvdata->base + TRCIDR0);
>> +     metadata->trcidr1 = readl_relaxed(drvdata->base + TRCIDR1);
>> +     metadata->trcidr2 = readl_relaxed(drvdata->base + TRCIDR2);
>> +     metadata->trcidr8 = readl_relaxed(drvdata->base + TRCIDR8);
>
> I'm pretty sure this won't work on all architecture.  This tracer may not be
> powered when this is called and depending on the power domain the TRCIDRx
> registers are in it may lock.
>
> Simply read those at boot time as part of the _probe() function.

Thinking about this will work when operating from sysFS but
theoretically inaccurate from perf.  Say we have a 4 CPU system where
for a perf session only 2 CPUs were used for trace acquisition - the
process was simply not scheduled on the other 2 CPU.  With the above
code 2 CPUs (the ones that were actually used) will have the right
configuration while the other two will have the default tracer
configuration (since etm4_parse_event_config() was never called on
them).

Values in TRCIDR{0, 1, 2, 8} and TRCAUTHSTATUS is RO and won't change.
So those can be filled at _probe() time when tracers are instantiated.
Values for trcconfigr ang trctraceidr are trickier.

When operating from sysFS tracer configuration should be recorded in
etm4_enable_sysfs(), probably just before smp_call_function_single().
When operating from perf adding all tracers to the dump list should be
done in etm_setup_aux() and an update for the configuration in
etm4_enable_perf(), just before etm4_enable_hw().  When circling
through tracers to communicate the metadata to the kdump mechanic
check if buf != NULL, what way we only communicate information about
tracers that were used.

Removal of the tracers from the dump list should be done in etm_free_aux()

This will need testing :o)

Mathieu

>
>> +     metadata->trcauthstatus = readl_relaxed(drvdata->base + TRCAUTHSTATUS);
>> +
>> +     coresight_dump_update(csdev, (char *)metadata, sizeof(*metadata));
>> +}
>> +
>>  static const struct coresight_ops_source etm4_source_ops = {
>>       .cpu_id         = etm4_cpu_id,
>>       .trace_id       = etm4_trace_id,
>>       .enable         = etm4_enable,
>>       .disable        = etm4_disable,
>> +     .panic_cb       = etm4_panic_cb,
>>  };
>>
>>  static const struct coresight_ops etm4_cs_ops = {
>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
>> index b3b5ea7..08dc8b7 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm4x.h
>> +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
>> @@ -198,6 +198,20 @@
>>  #define ETM_EXLEVEL_NS_HYP           BIT(14)
>>  #define ETM_EXLEVEL_NS_NA            BIT(15)
>>
>> +#define ETM4_METADATA_MAGIC          0x4040404040404040ULL
>> +
>> +struct etmv4_metadata {
>> +     u64 magic;
>> +     u64 cpu;
>> +     u64 trcconfigr;
>> +     u64 trctraceidr;
>> +     u64 trcidr0;
>> +     u64 trcidr1;
>> +     u64 trcidr2;
>> +     u64 trcidr8;
>> +     u64 trcauthstatus;
>> +};
>> +
>>  /**
>>   * struct etmv4_config - configuration information related to an ETMv4
>>   * @mode:    Controls various modes supported by this ETM.
>> @@ -393,6 +407,7 @@ struct etmv4_drvdata {
>>       bool                            atbtrig;
>>       bool                            lpoverride;
>>       struct etmv4_config             config;
>> +     struct etmv4_metadata           metadata;
>>  };
>>
>>  /* Address comparator access types */
>> --
>> 2.7.4
>>
