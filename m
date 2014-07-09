From: preeti@linux.vnet.ibm.com (Preeti U Murthy)
Date: Wed, 09 Jul 2014 09:24:54 +0530
Subject: [PATCH v3 01/12] sched: fix imbalance flag reset
In-Reply-To: <CAKfTPtA8BVPtRRLzomqnGp7_uaSbFYmFTrrt4fpQTOb7qyjddg@mail.gmail.com>
References: <1404144343-18720-1-git-send-email-vincent.guittot@linaro.org>
 <1404144343-18720-2-git-send-email-vincent.guittot@linaro.org>
 <53BB61E9.80200@linux.vnet.ibm.com>
 <CAKfTPtA8BVPtRRLzomqnGp7_uaSbFYmFTrrt4fpQTOb7qyjddg@mail.gmail.com>
Message-ID: <53BCBD0E.2070609@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vincent,

On 07/08/2014 03:42 PM, Vincent Guittot wrote:
> On 8 July 2014 05:13, Preeti U Murthy <preeti@linux.vnet.ibm.com> wrote:
>> On 06/30/2014 09:35 PM, Vincent Guittot wrote:
>>> The imbalance flag can stay set whereas there is no imbalance.
>>>
>>> Let assume that we have 3 tasks that run on a dual cores /dual cluster system.
>>> We will have some idle load balance which are triggered during tick.
>>> Unfortunately, the tick is also used to queue background work so we can reach
>>> the situation where short work has been queued on a CPU which already runs a
>>> task. The load balance will detect this imbalance (2 tasks on 1 CPU and an idle
>>> CPU) and will try to pull the waiting task on the idle CPU. The waiting task is
>>> a worker thread that is pinned on a CPU so an imbalance due to pinned task is
>>> detected and the imbalance flag is set.
>>> Then, we will not be able to clear the flag because we have at most 1 task on
>>> each CPU but the imbalance flag will trig to useless active load balance
>>> between the idle CPU and the busy CPU.
>>>
>>> We need to reset of the imbalance flag as soon as we have reached a balanced
>>> state.
>>>
>>> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
>>> ---
>>>  kernel/sched/fair.c | 14 +++++++++++---
>>>  1 file changed, 11 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>> index d3c73122..0c48dff 100644
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>> @@ -6615,10 +6615,8 @@ more_balance:
>>>               if (sd_parent) {
>>>                       int *group_imbalance = &sd_parent->groups->sgc->imbalance;
>>>
>>> -                     if ((env.flags & LBF_SOME_PINNED) && env.imbalance > 0) {
>>> +                     if ((env.flags & LBF_SOME_PINNED) && env.imbalance > 0)
>>>                               *group_imbalance = 1;
>>> -                     } else if (*group_imbalance)
>>> -                             *group_imbalance = 0;
>>>               }
>>>
>>>               /* All tasks on this runqueue were pinned by CPU affinity */
>>> @@ -6703,6 +6701,16 @@ more_balance:
>>>       goto out;
>>>
>>>  out_balanced:
>>> +     /*
>>> +      * We reach balance although we may have faced some affinity
>>> +      * constraints. Clear the imbalance flag if it was set.
>>> +      */
>>> +     if (sd_parent) {
>>> +             int *group_imbalance = &sd_parent->groups->sgc->imbalance;
>>> +             if (*group_imbalance)
>>> +                     *group_imbalance = 0;
>>> +     }
>>> +
>>>       schedstat_inc(sd, lb_balanced[idle]);
>>>
>>>       sd->nr_balance_failed = 0;
>>>
>> I am not convinced that we can clear the imbalance flag here. Lets take
>> a simple example. Assume at a particular level of sched_domain, there
>> are two sched_groups with one cpu each. There are 2 tasks on the source
>> cpu, one of which is running(t1) and the other thread(t2) does not have
>> the dst_cpu in the tsk_allowed_mask. Now no task can be migrated to the
>> dst_cpu due to affinity constraints. Note that t2 is *not pinned, it
>> just cannot run on the dst_cpu*. In this scenario also we reach the
>> out_balanced tag right? If we set the group_imbalance flag to 0, we are
> 
> No we will not. If we have 2 tasks on 1 CPU in one sched_group and the
> other group with an idle CPU,  we are not balanced so we will not go
> to out_balanced and the group_imbalance will staty set until we reach
> a balanced state (by migrating t1).

In the example that I mention above, t1 and t2 are on the rq of cpu0;
while t1 is running on cpu0, t2 is on the rq but does not have cpu1 in
its cpus allowed mask. So during load balance, cpu1 tries to pull t2,
cannot do so, and hence LBF_ALL_PINNED flag is set and it jumps to
out_balanced. Note that there are only two sched groups at this level of
sched domain.one with cpu0 and the other with cpu1. In this scenario we
do not try to do active load balancing, atleast thats what the code does
now if LBF_ALL_PINNED flag is set.

> 
>> ruling out the possibility of migrating t2 to any other cpu in a higher
>> level sched_domain by saying that all is well, there is no imbalance.
>> This is wrong, isn't it?
>>
>> My point is that by clearing the imbalance flag in the out_balanced
>> case, you might be overlooking the fact that the tsk_cpus_allowed mask
>> of the tasks on the src_cpu may not be able to run on the dst_cpu in
>> *this* level of sched_domain, but can potentially run on a cpu at any
>> higher level of sched_domain. By clearing the flag, we are not
> 
> The imbalance flag is per sched_domain level so we will not clear
> group_imbalance flag of other levels if the imbalance is also detected
> at a higher level it will migrate t2

Continuing with the above explanation; when LBF_ALL_PINNED flag is
set,and we jump to out_balanced, we clear the imbalance flag for the
sched_group comprising of cpu0 and cpu1,although there is actually an
imbalance. t2 could still be migrated to say cpu2/cpu3 (t2 has them in
its cpus allowed mask) in another sched group when load balancing is
done at the next sched domain level.

Elaborating on this, when cpu2 in another socket,lets say, begins load
balancing and update_sd_pick_busiest() is called, the group with cpu0
and cpu1 may not be picked as a potential imbalanced group. Had we not
cleared the imbalance flag for this group, we could have balanced out t2
to cpu2/3.

Is the scenario I am describing clear?

Regards
Preeti U Murthy
> 
> Regards,
> Vincent
> 
>> encouraging load balance at that level for t2.
>>
>> Am I missing something?
>>
>> Regards
>> Preeti U Murthy
>>
> 
