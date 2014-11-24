From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Mon, 24 Nov 2014 11:16:09 +0100
Subject: [PATCH v7 6/7] sched: replace capacity_factor by usage
In-Reply-To: <54713254.9020601@gmail.com>
References: <1412684017-16595-1-git-send-email-vincent.guittot@linaro.org>
 <1412684017-16595-7-git-send-email-vincent.guittot@linaro.org>
 <20141009121643.GQ4750@worktop.programming.kicks-ass.net>
 <CAKfTPtCX687FkGgxLO7spfGvDxhDWeFDERLRZ-NakO2Jrpmnhw@mail.gmail.com>
 <54713254.9020601@gmail.com>
Message-ID: <CAKfTPtDspf4ozpejACB8Lrc2B7vmF1sN28+H+iGnCsQs_k3L4w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23 November 2014 at 02:03, Wanpeng Li <kernellwp@gmail.com> wrote:
> Hi Vincent,
> On 10/9/14, 10:18 PM, Vincent Guittot wrote:
>>
>> On 9 October 2014 14:16, Peter Zijlstra <peterz@infradead.org> wrote:
>>>
>>> On Tue, Oct 07, 2014 at 02:13:36PM +0200, Vincent Guittot wrote:
>>>>
>>>> +static inline bool
>>>> +group_has_capacity(struct lb_env *env, struct sg_lb_stats *sgs)
>>>>   {
>>>> +     if ((sgs->group_capacity * 100) >
>>>> +                     (sgs->group_usage * env->sd->imbalance_pct))
>>>> +             return true;
>>>
>>> Why the imb_pct there? We're looking for 100% utilization, not 130 or
>>> whatnot, right?
>>
>> Having exactly 100% is quite difficult because of various rounding.
>
>
> Could you give some examples about the various rounding?

As an example while I was monitoring the runnable_load_sum and the
runnable_load_period, they were varying a bit around the max value but
was not always the same which can change the load_avg_contrib by few
unit

Regards,
Vincent

>
> Regards,
> Wanpeng Li
>
>> So i have added a margin/threshold to prevent any excessive change of the
>> state.
>> I have just to use the same margin/threshold than in other place in
>> load balance.
>>
>> so the current threshold depends of the sched_level. it's around 14% at MC
>> level
>>
>>>> +     if (sgs->sum_nr_running < sgs->group_weight)
>>>> +             return true;
>>>
>>> With the code as it stands, this is the cheaper test (no mults) so why
>>> is it second?
>>>
>>>> +     return false;
>>>> +}
>>>>
>>>> +static inline bool
>>>> +group_is_overloaded(struct lb_env *env, struct sg_lb_stats *sgs)
>>>> +{
>>>> +     if (sgs->sum_nr_running <= sgs->group_weight)
>>>> +             return false;
>>>> +
>>>> +     if ((sgs->group_capacity * 100) <
>>>> +                     (sgs->group_usage * env->sd->imbalance_pct))
>>>> +             return true;
>>>>
>>>> +     return false;
>>>>   }
>>>
>>> Same thing here wrt imb_pct
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>
>
