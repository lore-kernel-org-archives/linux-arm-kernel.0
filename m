From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Fri, 30 May 2014 22:05:17 +0200
Subject: [PATCH v2 10/11] sched: move cfs task on a CPU with higher
 capacity
In-Reply-To: <20140530062937.GA11096@twins.programming.kicks-ass.net>
References: <1400860385-14555-1-git-send-email-vincent.guittot@linaro.org>
 <1400860385-14555-11-git-send-email-vincent.guittot@linaro.org>
 <20140529095024.GF11074@laptop.programming.kicks-ass.net>
 <CAKfTPtCHhxyugMOCeS0hZoEXWhgRec4uOBexZ2aB2A+Eycgi8w@mail.gmail.com>
 <20140530062937.GA11096@twins.programming.kicks-ass.net>
Message-ID: <CAKfTPtDh_tm6m53N+sXftcWF5fwPFXkDWrb96Xj9iLpu+E1yYQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 May 2014 08:29, Peter Zijlstra <peterz@infradead.org> wrote:
> On Thu, May 29, 2014 at 09:37:39PM +0200, Vincent Guittot wrote:
>> On 29 May 2014 11:50, Peter Zijlstra <peterz@infradead.org> wrote:
>> > On Fri, May 23, 2014 at 05:53:04PM +0200, Vincent Guittot wrote:
>> >> If the CPU is used for handling lot of IRQs, trig a load balance to check if
>> >> it's worth moving its tasks on another CPU that has more capacity
>> >>
>> >> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
>> >> ---
>> >>  kernel/sched/fair.c | 13 +++++++++++++
>> >>  1 file changed, 13 insertions(+)
>> >>
>> >> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> >> index e8a30f9..2501e49 100644
>> >> --- a/kernel/sched/fair.c
>> >> +++ b/kernel/sched/fair.c
>> >> @@ -5948,6 +5948,13 @@ static bool update_sd_pick_busiest(struct lb_env *env,
>> >>       if (sgs->sum_nr_running > sgs->group_capacity)
>> >>               return true;
>> >>
>> >> +     /*
>> >> +      * The group capacity is reduced probably because of activity from other
>> >> +      * sched class or interrupts which use part of the available capacity
>> >> +      */
>> >> +     if ((sg->sgp->power_orig * 100) > (sgs->group_power * env->sd->imbalance_pct))
>> >> +             return true;
>> >> +
>> >>       if (sgs->group_imb)
>> >>               return true;
>> >>
>> >
>> > But we should already do this because the load numbers are scaled with
>> > the power/capacity figures. If one CPU gets significant less time to run
>> > fair tasks, its effective load would spike and it'd get to be selected
>> > here anyway.
>> >
>> > Or am I missing something?
>>
>> The CPU could have been picked when the capacity becomes null (which
>> occurred when the cpu_power goes below half the default
>> SCHED_POWER_SCALE). And even after that, there were some conditions in
>> find_busiest_group that was bypassing this busiest group
>
> Could you detail those conditions? FWIW those make excellent Changelog
> material.

I need to go back to my traces and use case to be sure that I point
the right culprit but IIRC, the imbalance was null. I will come back
with more details once i'll be back in front of the boards.
