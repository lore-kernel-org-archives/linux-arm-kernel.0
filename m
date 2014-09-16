From: dietmar.eggemann@arm.com (Dietmar Eggemann)
Date: Tue, 16 Sep 2014 10:00:58 -0700
Subject: [PATCH v5 11/12] sched: replace capacity_factor by utilization
In-Reply-To: <20140914194156.GC2832@worktop.localdomain>
References: <1409051215-16788-1-git-send-email-vincent.guittot@linaro.org>
 <1409051215-16788-12-git-send-email-vincent.guittot@linaro.org>
 <20140911161517.GA3190@worktop.ger.corp.intel.com>
 <CAKfTPtDFuzxzGBKi_n6v_F8FUkQ84MW+dQBX4WNXo-o54mksGA@mail.gmail.com>
 <20140914194156.GC2832@worktop.localdomain>
Message-ID: <54186CCA.6000108@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/09/14 12:41, Peter Zijlstra wrote:
> On Thu, Sep 11, 2014 at 07:26:48PM +0200, Vincent Guittot wrote:
>> On 11 September 2014 18:15, Peter Zijlstra <peterz@infradead.org> wrote:
>>> On Tue, Aug 26, 2014 at 01:06:54PM +0200, Vincent Guittot wrote:
>>>> +static inline int group_has_free_capacity(struct sg_lb_stats *sgs,
>>>> +                     struct lb_env *env)
>>>>   {
>>>> +     if ((sgs->group_capacity_orig * 100) >
>>>> +                     (sgs->group_utilization * env->sd->imbalance_pct))
>>>> +             return 1;
>>>> +
>>>> +     if (sgs->sum_nr_running < sgs->group_weight)
>>>> +             return 1;
>>>>
>>>> +     return 0;
>>>> +}
>>>>
>>>> +static inline int group_is_overloaded(struct sg_lb_stats *sgs,
>>>> +                     struct lb_env *env)
>>>> +{
>>>> +     if (sgs->sum_nr_running <= sgs->group_weight)
>>>> +             return 0;
>>>>
>>>> +     if ((sgs->group_capacity_orig * 100) <
>>>> +                     (sgs->group_utilization * env->sd->imbalance_pct))
>>>> +             return 1;
>>>>
>>>> +     return 0;
>>>>   }
>>>
>>> I'm confused about the utilization vs capacity_orig. I see how we should
>>
>> 1st point is that I should compare utilization vs capacity and not
>> capacity_orig.
>> I should have replaced capacity_orig by capacity in the functions
>> above when i move the utilization statistic from
>> rq->avg.runnable_avg_sum to cfs.usage_load_avg.
>> rq->avg.runnable_avg_sum was measuring all activity on the cpu whereas
>> cfs.usage_load_avg integrates only cfs tasks
>>
>> With this change, we don't need sgs->group_capacity_orig anymore but
>> only sgs->group_capacity. So sgs->group_capacity_orig can be removed
>> as it's no more used in the code as sg_capacity_factor has been
>> removed
>
> Yes, but.. so I suppose we need to add DVFS accounting and remove
> cpufreq from the capacity thing. Otherwise I don't see it make sense.

My understanding is that uArch scaling of capacacity_orig (therefore of 
capacity too) is done by calling arch_scale_cpu_capacity and frequency 
scaling for capacity is done by calling arch_scale_freq_capacity in 
update_cpu_capacity. I understand that this patch-set does not provide 
an implementation of arch_scale_freq_capacity though.

The uArch and frequency scaling of load & utilization will be added 
later. I know that Morten is currently working on a 'uArch and frequency 
invariant load & utilization tracking' patch-set.

Although I don't know exactly what you mean by DVFS accounting and 
remove cpufreq from the capacity here.

-- Dietmar

> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
