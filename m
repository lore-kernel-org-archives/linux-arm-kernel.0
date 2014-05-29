From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Thu, 29 May 2014 21:44:09 +0200
Subject: [PATCH v2 10/11] sched: move cfs task on a CPU with higher
 capacity
In-Reply-To: <20140529140427.GI11074@laptop.programming.kicks-ass.net>
References: <1400860385-14555-1-git-send-email-vincent.guittot@linaro.org>
 <1400860385-14555-11-git-send-email-vincent.guittot@linaro.org>
 <20140529140427.GI11074@laptop.programming.kicks-ass.net>
Message-ID: <CAKfTPtAC_qpK5SgSQHHTzKw+Mm_EzdufdhQUoTfbjr74vwUjsw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29 May 2014 16:04, Peter Zijlstra <peterz@infradead.org> wrote:
> On Fri, May 23, 2014 at 05:53:04PM +0200, Vincent Guittot wrote:
>> @@ -7282,6 +7289,12 @@ static inline int nohz_kick_needed(struct rq *rq)
>>
>>               if (nr_busy > 1)
>>                       goto need_kick_unlock;
>> +
>> +             if ((rq->cfs.h_nr_running >= 1)
>> +              && ((rq->cpu_power * sd->imbalance_pct) <
>> +                                     (rq->cpu_power_orig * 100)))
>> +                     goto need_kick_unlock;
>> +
>>       }
>>
>>       sd = rcu_dereference(per_cpu(sd_asym, cpu));
>
> So what happens when a cpu is consistently low on power (say due to a
> pinned RT task) the balancer would quickly adjust the load level, but
> this would endlessly kick things into action, even though we're balanced
> just fine.

If there is more than 1 running task or more than 1 busy CPU, we will
kick the ilb because of the former conditions. Then, if there is only
1 task and no other busy cpu, we should trig the ILB. Nevertheless, I
can add a test to check that there is an idle cpu in the sched_domain
