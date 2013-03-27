From: preeti@linux.vnet.ibm.com (Preeti U Murthy)
Date: Wed, 27 Mar 2013 15:51:51 +0530
Subject: [RFC PATCH v3 3/6] sched: pack small tasks
In-Reply-To: <1364300782.5053.6.camel@laptop>
References: <1363955155-18382-1-git-send-email-vincent.guittot@linaro.org>
 <1363955155-18382-4-git-send-email-vincent.guittot@linaro.org>
 <1364300782.5053.6.camel@laptop>
Message-ID: <5152C83F.6060509@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 03/26/2013 05:56 PM, Peter Zijlstra wrote:
> On Fri, 2013-03-22 at 13:25 +0100, Vincent Guittot wrote:
>> +static bool is_buddy_busy(int cpu)
>> +{
>> +       struct rq *rq = cpu_rq(cpu);
>> +
>> +       /*
>> +        * A busy buddy is a CPU with a high load or a small load with
>> a lot of
>> +        * running tasks.
>> +        */
>> +       return (rq->avg.runnable_avg_sum >
>> +                       (rq->avg.runnable_avg_period / (rq->nr_running
>> + 2)));
>> +}
> 
> Why does the comment talk about load but we don't see it in the
> equation. Also, why does nr_running matter at all? I thought we'd
> simply bother with utilization, if fully utilized we're done etc..
> 

Peter, lets say the run-queue has 50% utilization and is running 2
tasks. And we wish to find out if it is busy. We would compare this
metric with the cpu power, which lets say is 100.

rq->util * 100 < cpu_of(rq)->power.

In the above scenario would we declare the cpu _not_busy? Or would we do
the following:

(rq->util * 100) * #nr_running <  cpu_of(rq)->power and conclude that it
is just enough _busy_ to not take on more processes?


@Vincent: Yes the comment above needs to be fixed. A busy buddy is a CPU
with *high rq utilization*, as far as the equation goes.

Regards
Preeti U Murthy
