From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Fri, 30 May 2014 21:24:48 +0200
Subject: [PATCH v2 10/11] sched: move cfs task on a CPU with higher
 capacity
In-Reply-To: <53888719.70604@arm.com>
References: <1400860385-14555-1-git-send-email-vincent.guittot@linaro.org>
 <1400860385-14555-11-git-send-email-vincent.guittot@linaro.org>
 <53888719.70604@arm.com>
Message-ID: <CAKfTPtDWd5FKqSemFMFMMPz+t+aEnHWL_WH5grRoegtGnfD+bw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 May 2014 15:26, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> On 23/05/14 16:53, Vincent Guittot wrote:
>> If the CPU is used for handling lot of IRQs, trig a load balance to check if
>> it's worth moving its tasks on another CPU that has more capacity
>>
>> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
>> ---
>>  kernel/sched/fair.c | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index e8a30f9..2501e49 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -5948,6 +5948,13 @@ static bool update_sd_pick_busiest(struct lb_env *env,
>>       if (sgs->sum_nr_running > sgs->group_capacity)
>>               return true;
>>
>> +     /*
>> +      * The group capacity is reduced probably because of activity from other
>
> Here 'group capacity' refers to sgs->group_power and not to
> sgs->group_capacity, right?

yes, you're right it's cpu_power, i will correct the comment

>
>> +      * sched class or interrupts which use part of the available capacity
>> +      */
>
> ... 'interrupts' only w/ CONFIG_IRQ_TIME_ACCOUNTING=y, right ?

yes, we need CONFIG_IRQ_TIME_ACCOUNTING in order to scale the
cpu_power with time spent under irq. I have made test with and without
this config to show impact (in the cover letter)

Thanks
Vincent

>
>> +     if ((sg->sgp->power_orig * 100) > (sgs->group_power * env->sd->imbalance_pct))
>> +             return true;
>> +
> [...]
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
