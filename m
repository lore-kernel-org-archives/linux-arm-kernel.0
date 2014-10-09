From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Thu, 9 Oct 2014 16:28:58 +0200
Subject: [PATCH v7 6/7] sched: replace capacity_factor by usage
In-Reply-To: <20141009141607.GR4750@worktop.programming.kicks-ass.net>
References: <1412684017-16595-1-git-send-email-vincent.guittot@linaro.org>
 <1412684017-16595-7-git-send-email-vincent.guittot@linaro.org>
 <20141009141607.GR4750@worktop.programming.kicks-ass.net>
Message-ID: <CAKfTPtAGq=zBHNeXZjijM0BxD7g+DYr53CDsF9Cyen1T0FbAMQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9 October 2014 16:16, Peter Zijlstra <peterz@infradead.org> wrote:
> On Tue, Oct 07, 2014 at 02:13:36PM +0200, Vincent Guittot wrote:
>> @@ -6214,17 +6178,21 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
>>
>>               /*
>>                * In case the child domain prefers tasks go to siblings
>> +              * first, lower the sg capacity to one so that we'll try
>>                * and move all the excess tasks away. We lower the capacity
>>                * of a group only if the local group has the capacity to fit
>> +              * these excess tasks, i.e. group_capacity > 0. The
>>                * extra check prevents the case where you always pull from the
>>                * heaviest group when it is already under-utilized (possible
>>                * with a large weight task outweighs the tasks on the system).
>>                */
>>               if (prefer_sibling && sds->local &&
>> +                 group_has_capacity(env, &sds->local_stat)) {
>> +                     if (sgs->sum_nr_running > 1)
>> +                             sgs->group_no_capacity = 1;
>> +                     sgs->group_capacity = min(sgs->group_capacity,
>> +                                             SCHED_CAPACITY_SCALE);
>> +             }
>>
>>               if (update_sd_pick_busiest(env, sds, sg, sgs)) {
>>                       sds->busiest = sg;
>
>> @@ -6490,8 +6460,8 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
>>               goto force_balance;
>>
>>       /* SD_BALANCE_NEWIDLE trumps SMP nice when underutilized */
>> -     if (env->idle == CPU_NEWLY_IDLE && local->group_has_free_capacity &&
>> -         !busiest->group_has_free_capacity)
>> +     if (env->idle == CPU_NEWLY_IDLE && group_has_capacity(env, local) &&
>> +         busiest->group_no_capacity)
>>               goto force_balance;
>>
>>       /*
>
> This is two calls to group_has_capacity() on the local group. Why not
> compute once in update_sd_lb_stats()?

mainly because of the place in the code, so it is not always used
during load balance unlike group_no_capacity

Now that i have said that, i just noticed that it's better to move the
call to the last tested condition

 +     if (env->idle == CPU_NEWLY_IDLE && busiest->group_no_capacity &&
 +         group_has_capacity(env, local))
