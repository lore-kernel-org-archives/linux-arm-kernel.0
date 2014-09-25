From: dietmar.eggemann@arm.com (Dietmar Eggemann)
Date: Thu, 25 Sep 2014 20:19:42 +0100
Subject: [PATCH v6 5/6] sched: replace capacity_factor by usage
In-Reply-To: <CAKfTPtB3-M+pXaurDeWkWGNJ3_mU-FN+EnshGE-eg_r41Hppag@mail.gmail.com>
References: <1411488485-10025-1-git-send-email-vincent.guittot@linaro.org>
 <1411488485-10025-6-git-send-email-vincent.guittot@linaro.org>
 <542303DF.8010606@arm.com>
 <CAKfTPtB3-M+pXaurDeWkWGNJ3_mU-FN+EnshGE-eg_r41Hppag@mail.gmail.com>
Message-ID: <54246ACE.1080502@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/09/14 09:35, Vincent Guittot wrote:
> On 24 September 2014 19:48, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>> On 23/09/14 17:08, Vincent Guittot wrote:
>>
> 
> [snip]
> 
>>
>> This review (by PeterZ) during v5 of your patch-set recommended some
>> renaming (e.g. s/group_has_free_capacity/group_has_capacity and
>> s/group_out_of_capacity/group_no_capacity as well as reordering of the
>> parameters which I agree with:
>>
>> https://lkml.org/lkml/2014/9/11/706
> 
> Ah... you're right, these changes have passed through my seance of renaming

What about the ordering of the function parameters in
group_has_capacity, group_is_overloaded and group_type group_classify?

All the existing *load balance* related functions in fair.c seem to
follow this (struct lb_env *env, struct sd_lb_stats *sds, struct
sched_group *group, struct sg_lb_stats *sgs) order.

> 
>>
>>>
>>> -/*
> 
> [snip]
> 
>>> -       if (sgs->group_capacity_factor > sgs->sum_nr_running)
>>> -               sgs->group_has_free_capacity = 1;
>>> +       sgs->group_type = group_classify(group, sgs, env);
>>> +
>>> +       sgs->group_out_of_capacity = group_is_overloaded(sgs, env);
>>
>> In case sgs->group_type is group_overloaded you could set
>> sgs->group_out_of_capacity to 1 without calling group_is_overloaded again.
> 
> I prefer to keep sgs->group_out_of_capacity = group_is_overloaded(sgs,
> env) and use it in group_classify in case of future changes in the
> classification order

Ok, but than group_is_overloaded is called twice at the end of
update_sg_lb_stats with exactly the same result. Looks weird in my traces.

> 
[...]
