From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Wed, 30 Sep 2015 12:43:00 +0300
Subject: [RFC PATCH 14/20] coresight: etm-perf: implementing
 'event_init()' API
In-Reply-To: <CANLsYkxZ83554k+7sgS6dPp4iyaN1qEUzFNLUg6m=uo+S0ArZA@mail.gmail.com>
References: <1442593594-10665-1-git-send-email-mathieu.poirier@linaro.org>
 <1442593594-10665-15-git-send-email-mathieu.poirier@linaro.org>
 <87eghq4jf7.fsf@ashishki-desk.ger.corp.intel.com>
 <CANLsYkxZ83554k+7sgS6dPp4iyaN1qEUzFNLUg6m=uo+S0ArZA@mail.gmail.com>
Message-ID: <87twqcjl97.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mathieu Poirier <mathieu.poirier@linaro.org> writes:

> On 22 September 2015 at 08:29, Alexander Shishkin
> <alexander.shishkin@linux.intel.com> wrote:
>> Mathieu Poirier <mathieu.poirier@linaro.org> writes:
>>
>>> +static void etm_event_destroy(struct perf_event *event)
>>> +{
>>> +     /* switching off the source will also tear down the path */
>>> +     etm_event_power_sources(event->cpu, false);
>>> +}
>>> +
>>> +static int etm_event_init(struct perf_event *event)
>>> +{
>>> +     int ret;
>>> +
>>> +     if (event->attr.type != etm_pmu.type)
>>> +             return -ENOENT;
>>> +
>>> +     if (event->cpu >= nr_cpu_ids)
>>> +             return -EINVAL;
>>> +
>>> +     /* only one session at a time */
>>> +     if (etm_event_source_enabled(event->cpu))
>>> +             return -EBUSY;
>>
>> Why is this the case? If you were to configure the event in pmu::add()
>> and deconfigure it in pmu::del(), like you already do with the buffer
>> part, you could handle as many sessions as you want.
>
> Apologies for the late reply, I was travelling.
>
> We certainly don't want to have more than once trace session going on
> at any given time, especially if the sessions have different
> configuration parameters.  Moreover doing the tracer configuration as
> part of pmu::add() is highly redundant.

But why?

The whole point of using perf for this is that it does all the tricky
context switching for us, all the cross-cpu calling to enable/disable
the events etc so that we can run multiple sessions in parallel without
having to worry (much) about scheduling. (Aside, of course, from other
useful things like sideband events, but that's another topic).

>> This can be done in pmu::add(), if you can call directly into
>> etm_configure_cpu() or etm_config_enable() so that there's no cross-cpu
>> calling in between.
>
> As per my comment above, reconfiguring the tracers every time it is
> about to run is redundant and extensive (etm_configure_cpu() isn't
> exactly short),  incurring a cost that is likely to be higher than
> calling get_online_cpus().

I was actually referring to synchronous smp_function_call*()s that
obviously won't work here. But the good news is that they are also
redundant.

But I don't see anything expensive in configuring etm and etb in
pmu::add(), as far as I can tell, it's just a bunch of register
writes. If you want to optimize those, you could compare the new context
against the previous one and only update registers that need to be
updated. The spinlock you also could get rid of, because there won't be
any local racing (again, afaict neither ETM nor ETB generate
interrupts).

That said, one expensive thing is reading out the ETB buffer on every
sched out, and that is the real problem, because it slows down the fast
path by a loop of arbitrary length reading out hw registers. Iirc, ETBs
could be up to 64K?

But a TMC-enabled coresight should do much better in this regard.

Thanks,
--
Alex
