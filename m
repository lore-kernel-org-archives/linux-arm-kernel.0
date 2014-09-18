From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Wed, 17 Sep 2014 18:32:23 -0700
Subject: [PATCH v5 11/12] sched: replace capacity_factor by utilization
In-Reply-To: <20140917222553.GD2848@worktop.localdomain>
References: <1409051215-16788-1-git-send-email-vincent.guittot@linaro.org>
 <1409051215-16788-12-git-send-email-vincent.guittot@linaro.org>
 <20140911161517.GA3190@worktop.ger.corp.intel.com>
 <CAKfTPtDFuzxzGBKi_n6v_F8FUkQ84MW+dQBX4WNXo-o54mksGA@mail.gmail.com>
 <20140914194156.GC2832@worktop.localdomain>
 <20140915114229.GB3037@worktop.localdomain>
 <CAKfTPtDHSWs8xumOSfWkyucAtkBvvbJkOVTQkoYXYCBpmHrMZg@mail.gmail.com>
 <20140917222553.GD2848@worktop.localdomain>
Message-ID: <CAKfTPtA_=MvAVya6JR3M+qs-kLapZgGknBqo=87MVbihCCXF9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 September 2014 15:25, Peter Zijlstra <peterz@infradead.org> wrote:
> On Tue, Sep 16, 2014 at 12:14:54AM +0200, Vincent Guittot wrote:
>> On 15 September 2014 13:42, Peter Zijlstra <peterz@infradead.org> wrote:
>
>> > OK, I've reconsidered _again_, I still don't get it.
>> >
>> > So fundamentally I think its wrong to scale with the capacity; it just
>> > doesn't make any sense. Consider big.little stuff, their CPUs are
>> > inherently asymmetric in capacity, but that doesn't matter one whit for
>> > utilization numbers. If a core is fully consumed its fully consumed, no
>> > matter how much work it can or can not do.
>> >
>> >
>> > So the only thing that needs correcting is the fact that these
>> > statistics are based on clock_task and some of that time can end up in
>> > other scheduling classes, at which point we'll never get 100% even
>> > though we're 'saturated'. But correcting for that using capacity doesn't
>> > 'work'.
>>
>> I'm not sure to catch your last point because the capacity is the only
>> figures that take into account the "time" consumed by other classes.
>> Have you got in mind another way to take into account the other
>> classes ?
>
> So that was the entire point of stuffing capacity in? Note that that
> point was not at all clear.
>
> This is very much like 'all we have is a hammer, and therefore
> everything is a nail'. The rt fraction is a 'small' part of what the
> capacity is.
>
>> So we have cpu_capacity that is the capacity that can be currently
>> used by cfs class
>> We have cfs.usage_load_avg that is the sum of running time of cfs
>> tasks on the CPU and reflect the % of usage of this CPU by CFS tasks
>> We have to use the same metrics to compare available capacity for CFS
>> and current cfs usage
>
> -ENOPARSE
>
>> Now we have to use the same unit so we can either weight the
>> cpu_capacity_orig with the cfs.usage_load_avg and compare it with
>> cpu_capacity
>> or with divide cpu_capacity by cpu_capacity_orig and scale it into the
>> SCHED_LOAD_SCALE range. Is It what you are proposing ?
>
> I'm so not getting it; orig vs capacity still includes
> arch_scale_freq_capacity(), so that is not enough to isolate the rt
> fraction.

This patch does not try to solve any scale invariance issue. This
patch removes capacity_factor because it rarely works correctly.
capacity_factor tries to compute how many tasks a group of CPUs can
handle at the time we are doing the load balance. The capacity_factor
is hardly working for SMT system: it sometimes works for big cores and
but fails to do the right thing for little cores.

Below are two examples to illustrate the problem that this patch solves:

capacity_factor makes the assumption that max capacity of a CPU is
SCHED_CAPACITY_SCALE and the load of a thread is always is
SCHED_LOAD_SCALE. It compares the output of these figures with the sum
of nr_running to decide if a group is overloaded or not.

But if the default capacity of a CPU is less than SCHED_CAPACITY_SCALE
(640 as an example), a group of 3 CPUS will have a max capacity_factor
of 2 ( div_round_closest(3x640/1024) = 2) which means that it will be
seen as overloaded if we have only one task per CPU.

Then, if the default capacity of a CPU is greater than
SCHED_CAPACITY_SCALE (1512 as an example), a group of 4 CPUs will have
a capacity_factor of 4 (at max and thanks to the fix[0] for SMT system
that prevent the apparition of ghost CPUs) but if one CPU is fully
used by a rt task (and its capacity is reduced to nearly nothing), the
capacity factor of the group will still be 4
(div_round_closest(3*1512/1024) = 5).

So, this patch tries to solve this issue by removing capacity_factor
and replacing it with the 2 following metrics :
-the available CPU capacity for CFS tasks which is the one currently
used by load_balance
-the capacity that are effectively used by CFS tasks on the CPU. For
that, i have re-introduced the usage_avg_contrib which is in the range
[0..SCHED_CPU_LOAD] whatever the capacity of the CPU on which the task
is running, is. This usage_avg_contrib doesn't solve the scaling
in-variance problem, so i have to scale the usage with original
capacity in get_cpu_utilization (that will become get_cpu_usage in the
next version) in order to compare it with available capacity.

Once the scaling invariance will have been added in usage_avg_contrib,
we can remove the scale by cpu_capacity_orig in get_cpu_utilization.
But the scaling invariance will come in another patchset.

Hope that this explanation makes the goal of this patchset clearer.
And I can add this explanation in the commit log if you found it clear
enough

Vincent

[0] https://lkml.org/lkml/2013/8/28/194
