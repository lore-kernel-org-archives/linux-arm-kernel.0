From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Thu, 11 Sep 2014 19:26:48 +0200
Subject: [PATCH v5 11/12] sched: replace capacity_factor by utilization
In-Reply-To: <20140911161517.GA3190@worktop.ger.corp.intel.com>
References: <1409051215-16788-1-git-send-email-vincent.guittot@linaro.org>
 <1409051215-16788-12-git-send-email-vincent.guittot@linaro.org>
 <20140911161517.GA3190@worktop.ger.corp.intel.com>
Message-ID: <CAKfTPtDFuzxzGBKi_n6v_F8FUkQ84MW+dQBX4WNXo-o54mksGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 September 2014 18:15, Peter Zijlstra <peterz@infradead.org> wrote:
> On Tue, Aug 26, 2014 at 01:06:54PM +0200, Vincent Guittot wrote:
>> +static inline int group_has_free_capacity(struct sg_lb_stats *sgs,
>> +                     struct lb_env *env)
>>  {
>> +     if ((sgs->group_capacity_orig * 100) >
>> +                     (sgs->group_utilization * env->sd->imbalance_pct))
>> +             return 1;
>> +
>> +     if (sgs->sum_nr_running < sgs->group_weight)
>> +             return 1;
>>
>> +     return 0;
>> +}
>>
>> +static inline int group_is_overloaded(struct sg_lb_stats *sgs,
>> +                     struct lb_env *env)
>> +{
>> +     if (sgs->sum_nr_running <= sgs->group_weight)
>> +             return 0;
>>
>> +     if ((sgs->group_capacity_orig * 100) <
>> +                     (sgs->group_utilization * env->sd->imbalance_pct))
>> +             return 1;
>>
>> +     return 0;
>>  }
>
> I'm confused about the utilization vs capacity_orig. I see how we should

1st point is that I should compare utilization vs capacity and not
capacity_orig.
I should have replaced capacity_orig by capacity in the functions
above when i move the utilization statistic from
rq->avg.runnable_avg_sum to cfs.usage_load_avg.
rq->avg.runnable_avg_sum was measuring all activity on the cpu whereas
cfs.usage_load_avg integrates only cfs tasks

With this change, we don't need sgs->group_capacity_orig anymore but
only sgs->group_capacity. So sgs->group_capacity_orig can be removed
as it's no more used in the code as sg_capacity_factor has been
removed

> maybe scale things with the capacity when comparing between CPUs/groups,
> but not on the same CPU/group.
>
> I would have expected something simple like:
>
> static inline bool group_has_capacity()
> {
>         /* Is there a spare cycle? */
>         if (sgs->group_utilization < sgs->group_weight * SCHED_LOAD_SCALE)
>                 return true;
>
>         /* Are there less tasks than logical CPUs? */
>         if (sgs->sum_nr_running < sgs->group_weight)
>                 return true;
>
>         return false;
> }
>
> Where group_utilization a pure sum of running_avg.
>
> Now this has a hole when there are RT tasks on the system, in that case
> the utilization will never hit 1, but we could fix that another way. I
> don't think the capacity_orig thing is right.
