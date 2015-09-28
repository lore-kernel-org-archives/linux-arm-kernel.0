From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon, 28 Sep 2015 15:22:51 -0600
Subject: [RFC PATCH 14/20] coresight: etm-perf: implementing
 'event_init()' API
In-Reply-To: <87eghq4jf7.fsf@ashishki-desk.ger.corp.intel.com>
References: <1442593594-10665-1-git-send-email-mathieu.poirier@linaro.org>
 <1442593594-10665-15-git-send-email-mathieu.poirier@linaro.org>
 <87eghq4jf7.fsf@ashishki-desk.ger.corp.intel.com>
Message-ID: <CANLsYkxZ83554k+7sgS6dPp4iyaN1qEUzFNLUg6m=uo+S0ArZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 September 2015 at 08:29, Alexander Shishkin
<alexander.shishkin@linux.intel.com> wrote:
> Mathieu Poirier <mathieu.poirier@linaro.org> writes:
>
>> +static void etm_event_destroy(struct perf_event *event)
>> +{
>> +     /* switching off the source will also tear down the path */
>> +     etm_event_power_sources(event->cpu, false);
>> +}
>> +
>> +static int etm_event_init(struct perf_event *event)
>> +{
>> +     int ret;
>> +
>> +     if (event->attr.type != etm_pmu.type)
>> +             return -ENOENT;
>> +
>> +     if (event->cpu >= nr_cpu_ids)
>> +             return -EINVAL;
>> +
>> +     /* only one session at a time */
>> +     if (etm_event_source_enabled(event->cpu))
>> +             return -EBUSY;
>
> Why is this the case? If you were to configure the event in pmu::add()
> and deconfigure it in pmu::del(), like you already do with the buffer
> part, you could handle as many sessions as you want.

Apologies for the late reply, I was travelling.

We certainly don't want to have more than once trace session going on
at any given time, especially if the sessions have different
configuration parameters.  Moreover doing the tracer configuration as
part of pmu::add() is highly redundant.

>
>> +
>> +     /*
>> +      * Make sure CPUs don't disappear between the
>> +      * power up sequence and configuration.
>> +      */
>> +     get_online_cpus();
>> +     ret = etm_event_power_sources(event->cpu, true);
>> +     if (ret)
>> +             goto out;
>> +
>> +     ret = etm_event_config_sources(event->cpu);
>
> This can be done in pmu::add(), if you can call directly into
> etm_configure_cpu() or etm_config_enable() so that there's no cross-cpu
> calling in between.

As per my comment above, reconfiguring the tracers every time it is
about to run is redundant and extensive (etm_configure_cpu() isn't
exactly short),  incurring a cost that is likely to be higher than
calling get_online_cpus().

>
>> +
>> +     event->destroy = etm_event_destroy;
>> +out:
>> +     put_online_cpus();
>> +     return ret;
>> +}
>> +
>>  static int __init etm_perf_init(void)
>>  {
>>       etm_pmu.capabilities    = PERF_PMU_CAP_EXCLUSIVE;
>> @@ -59,6 +234,7 @@ static int __init etm_perf_init(void)
>>       etm_pmu.attr_groups     = etm_pmu_attr_groups;
>>       etm_pmu.task_ctx_nr     = perf_sw_context;
>>       etm_pmu.read            = etm_event_read;
>> +     etm_pmu.event_init      = etm_event_init;
>>
>>       return perf_pmu_register(&etm_pmu, CORESIGHT_ETM_PMU_NAME, -1);
>>  }
>
> One general comment -- it would be slightly easier at least for me if
> all the pmu related bits were in one patch.

Ah!  I went to great length to split them up to make the patches
smaller  - I will refactor...

Thanks for the review,
Mathieu

>
> Thanks,
> --
> Alex
