From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Thu, 29 May 2014 21:56:24 +0200
Subject: [PATCH v2 11/11] sched: replace capacity by activity
In-Reply-To: <20140529140204.GH11074@laptop.programming.kicks-ass.net>
References: <1400860385-14555-1-git-send-email-vincent.guittot@linaro.org>
 <1400860385-14555-12-git-send-email-vincent.guittot@linaro.org>
 <20140529140204.GH11074@laptop.programming.kicks-ass.net>
Message-ID: <CAKfTPtACXf+c01O+dCU2ZTc-Mrs+nTKYsu0_aBt8awxSg5WD=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29 May 2014 16:02, Peter Zijlstra <peterz@infradead.org> wrote:
> On Fri, May 23, 2014 at 05:53:05PM +0200, Vincent Guittot wrote:
>> @@ -6052,8 +6006,8 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
>>                * with a large weight task outweighs the tasks on the system).
>>                */
>>               if (prefer_sibling && sds->local &&
>> -                 sds->local_stat.group_has_capacity)
>> -                     sgs->group_capacity = min(sgs->group_capacity, 1U);
>> +                 sds->local_stat.group_capacity > 0)
>> +                     sgs->group_capacity = min(sgs->group_capacity, 1L);
>>
>>               if (update_sd_pick_busiest(env, sds, sg, sgs)) {
>>                       sds->busiest = sg;
>> @@ -6228,7 +6182,7 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
>>                * have to drop below capacity to reach cpu-load equilibrium.
>>                */
>>               load_above_capacity =
>> -                     (busiest->sum_nr_running - busiest->group_capacity);
>> +                     (busiest->sum_nr_running - busiest->group_weight);
>>
>>               load_above_capacity *= (SCHED_LOAD_SCALE * SCHED_POWER_SCALE);
>>               load_above_capacity /= busiest->group_power;
>
> I think you just broke PREFER_SIBLING here..

you mean by replacing the capacity which was reflecting the number of
core for SMT by the group_weight ?

>
> So we want PREFER_SIBLING to work on nr_running, not utilization because
> we want to spread single tasks around, regardless of their utilization.
>
