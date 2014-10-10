From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Fri, 10 Oct 2014 09:17:22 +0200
Subject: [PATCH v7 6/7] sched: replace capacity_factor by usage
In-Reply-To: <20141009151820.GX10832@worktop.programming.kicks-ass.net>
References: <1412684017-16595-1-git-send-email-vincent.guittot@linaro.org>
 <1412684017-16595-7-git-send-email-vincent.guittot@linaro.org>
 <20141009121643.GQ4750@worktop.programming.kicks-ass.net>
 <CAKfTPtCX687FkGgxLO7spfGvDxhDWeFDERLRZ-NakO2Jrpmnhw@mail.gmail.com>
 <20141009151820.GX10832@worktop.programming.kicks-ass.net>
Message-ID: <CAKfTPtCQzdDuNmifU3sobqSke0Mri0jDVpJTwuKytaNs_RLM1w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9 October 2014 17:18, Peter Zijlstra <peterz@infradead.org> wrote:
> On Thu, Oct 09, 2014 at 04:18:02PM +0200, Vincent Guittot wrote:
>> On 9 October 2014 14:16, Peter Zijlstra <peterz@infradead.org> wrote:
>> > On Tue, Oct 07, 2014 at 02:13:36PM +0200, Vincent Guittot wrote:
>> >> +static inline bool
>> >> +group_has_capacity(struct lb_env *env, struct sg_lb_stats *sgs)
>> >>  {
>> >> +     if ((sgs->group_capacity * 100) >
>> >> +                     (sgs->group_usage * env->sd->imbalance_pct))
>> >> +             return true;
>> >
>> > Why the imb_pct there? We're looking for 100% utilization, not 130 or
>> > whatnot, right?
>>
>> Having exactly 100% is quite difficult because of various rounding.
>> So i have added a margin/threshold to prevent any excessive change of the state.
>> I have just to use the same margin/threshold than in other place in
>> load balance.
>>
>
> Yet you failed to mention this anywhere. Also does it really matter?

yes i think it latter because it give a more stable view of the
"overload state" and "have  free capacity state" of the CPU.
One additional point is that the imbalance_pct will ensure that a
cpu/group will not been seen as having capacity if its available
capacity is only 1-5% which will generate spurious task migration

I will add these details in the commit log and in a comment in the code
