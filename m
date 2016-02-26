From: ashwin.chaugule@linaro.org (Ashwin Chaugule)
Date: Thu, 25 Feb 2016 19:22:44 -0500
Subject: [PATCH] drivers: perf: arm: implement CPU_PM notifier
In-Reply-To: <20160224223128.GA30750@red-moon>
References: <1456251759-24768-1-git-send-email-lorenzo.pieralisi@arm.com>
 <CANLsYkzvB0GbPeYHrcLtUz8DMHJh4FA5RVwVZ-UAm3BCznB_3w@mail.gmail.com>
 <20160224173511.GF25385@red-moon>
 <CAJ5Y-ea3gxxOEGdJMPZAh78Ap0GBvzGePhBKzQRVoJBwwY6NzA@mail.gmail.com>
 <20160224223128.GA30750@red-moon>
Message-ID: <CAJ5Y-eYmYHU8Z+BBD0brmnx70ynWV8mhSrG36Bmu3yorsfk+4Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 February 2016 at 17:31, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> On Wed, Feb 24, 2016 at 02:53:02PM -0500, Ashwin Chaugule wrote:
>> Hi Lorenzo,
>>
>> On 24 February 2016 at 12:35, Lorenzo Pieralisi
>> <lorenzo.pieralisi@arm.com> wrote:
>> > On Wed, Feb 24, 2016 at 09:20:22AM -0700, Mathieu Poirier wrote:
>> >> On 23 February 2016 at 11:22, Lorenzo Pieralisi
>> >
>> > [...]
>> >
>> >> > +static int cpu_pm_pmu_notify(struct notifier_block *b, unsigned long cmd,
>> >> > +                            void *v)
>> >> > +{
>> >> > +       struct arm_pmu *armpmu = container_of(b, struct arm_pmu, cpu_pm_nb);
>> >> > +       struct pmu_hw_events *hw_events = this_cpu_ptr(armpmu->hw_events);
>> >> > +       int enabled = bitmap_weight(hw_events->used_mask, armpmu->num_events);
>> >> > +
>> >> > +       if (!cpumask_test_cpu(smp_processor_id(), &armpmu->supported_cpus))
>> >> > +               return NOTIFY_DONE;
>> >> > +
>> >> > +       /*
>> >> > +        * Always reset the PMU registers on power-up even if
>> >> > +        * there are no events running.
>> >> > +        */
>> >> > +       if (cmd == CPU_PM_EXIT && armpmu->reset)
>> >> > +               armpmu->reset(armpmu);
>> >>
>> >> I think this patch does the right thing but I can't get the above
>> >> reset.  Wouldn't it be better to do the reset as part of the
>> >> CPU_PM_EXIT case below?  At this point nothing tells us the CPU won't
>> >> go back down before the event is enabled, wasting the cycle needed to
>> >> reset the PMU.
>> >
>> > The logic goes, if the cpu is woken up and it has no events enabled,
>> > if we do not reset it (mind, ->reset here sets the PMU register values
>> > to a sane default, some of them are architecturally UNKNOWN on reset, it
>> > does NOT reset the PMU) _and_ we subsequently install an event on it we
>> > do have a problem, that's why whenever a core gets out of low-power we
>> > have to reset its pmu.
>>
>> Dont we blow out the previous value in the counter when installing an
>> event? Or has that changed lately? IIRC, there was some initial value
>> we'd program into the counter to avoid missing the overflow event.
>> (sorry its been too long) ;)
>
> If you mean there is no need of resetting the value since we are
> overwriting it anyway you should see ->reset from a PMU unit POW
> not just an event. If you look at the ->reset method for eg v8, you
> will see that the reset method operates on all counters and the PMU
> unit as a whole, that's the only sane way of setting up the PMU unit
> before enabling single counters (some registers are UNKNOWN at reset).
>
> To make my reply to Mathieu clearer, the ->reset method contains
> operations (eg writing PMCR counters reset bits) that do carry out
> counters reset, what I wanted to say is that the ->reset method
> does not by itself drive the PMU HW reset signal, that's what the
> power controller does when it resets the CPU on power up.
>
> The PMU ->reset method must be called on a cpu on power-up, to make
> sure PMU HW is set-up to sane default values and ready to be used (ie
> install counters), for instance on v8 all counters must be disabled
> (irq inclusive) and reset, that's what armv8pmu_reset() does.
>
> I hope this makes things clearer.
>

Indeed. Thanks for the explanation. The patch looks good to me.

Acked-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>


> Thanks,
> Lorenzo
