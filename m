From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 20 Oct 2015 10:43:14 -0600
Subject: [PATCH V2 22/30] coresight: etm-perf: new PMU driver for ETM
 tracers
In-Reply-To: <87io62hnsn.fsf@ashishki-desk.ger.corp.intel.com>
References: <1445192687-24112-1-git-send-email-mathieu.poirier@linaro.org>
 <1445192687-24112-23-git-send-email-mathieu.poirier@linaro.org>
 <87io62hnsn.fsf@ashishki-desk.ger.corp.intel.com>
Message-ID: <CANLsYkxk6shqkqd6Omzo5J4zeeSJ-uxhk0MDdiQ3mrmGmmBFpQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 October 2015 at 09:37, Alexander Shishkin
<alexander.shishkin@linux.intel.com> wrote:
> Mathieu Poirier <mathieu.poirier@linaro.org> writes:
>
>> +static int etm_event_pmu_start(struct perf_event *event)
>> +{
>> +     int cpu, ret;
>> +     cpumask_t mask;
>> +     struct coresight_device *csdev;
>> +
>> +     cpumask_clear(&mask);
>> +     if (event->cpu != -1)
>> +             cpumask_set_cpu(event->cpu, &mask);
>> +     else
>> +             cpumask_copy(&mask, cpu_online_mask);
>> +
>> +     for_each_cpu(cpu, &mask) {
>> +             csdev = per_cpu(csdev_src, cpu);
>> +
>> +             if (!source_ops(csdev)->perf_start)
>> +                     continue;
>> +
>> +             ret = source_ops(csdev)->perf_start(csdev);
>> +             if (ret)
>> +                     goto err;
>
> So long as "perf_start" and "perf_stop" here mean
> "pm_runtime_get()/put()", this can work, but in that case maybe a better
> name should be used, because no real starting or stopping of anything
> takes place here.

You're correct, nothing else than pm_runtime operations should be
happening in there.  I will revise the naming convention.

> Since pmu::event_init and event::destroy happen in
> allocation/deallocation paths and at event scheduling, it's not a good
> idea to actually start anything here.
>
> Regards,
> --
> Alex
