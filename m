From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Wed, 27 Mar 2013 12:00:40 +0100
Subject: [RFC PATCH v3 3/6] sched: pack small tasks
In-Reply-To: <5152C83F.6060509@linux.vnet.ibm.com>
References: <1363955155-18382-1-git-send-email-vincent.guittot@linaro.org>
 <1363955155-18382-4-git-send-email-vincent.guittot@linaro.org>
 <1364300782.5053.6.camel@laptop>
 <5152C83F.6060509@linux.vnet.ibm.com>
Message-ID: <CAKfTPtCphgnT6_WSdHJR+_GcdfroL+OFhiqsr_rBFx5=apkTVQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 March 2013 11:21, Preeti U Murthy <preeti@linux.vnet.ibm.com> wrote:
> Hi,
>
> On 03/26/2013 05:56 PM, Peter Zijlstra wrote:
>> On Fri, 2013-03-22 at 13:25 +0100, Vincent Guittot wrote:
>>> +static bool is_buddy_busy(int cpu)
>>> +{
>>> +       struct rq *rq = cpu_rq(cpu);
>>> +
>>> +       /*
>>> +        * A busy buddy is a CPU with a high load or a small load with
>>> a lot of
>>> +        * running tasks.
>>> +        */
>>> +       return (rq->avg.runnable_avg_sum >
>>> +                       (rq->avg.runnable_avg_period / (rq->nr_running
>>> + 2)));
>>> +}
>>
>> Why does the comment talk about load but we don't see it in the
>> equation. Also, why does nr_running matter at all? I thought we'd
>> simply bother with utilization, if fully utilized we're done etc..
>>
>
> Peter, lets say the run-queue has 50% utilization and is running 2
> tasks. And we wish to find out if it is busy. We would compare this
> metric with the cpu power, which lets say is 100.
>
> rq->util * 100 < cpu_of(rq)->power.

I don't use cpu_of(rq)->power in the definition of the business

>
> In the above scenario would we declare the cpu _not_busy? Or would we do
> the following:

In the above scenario, the CPU is busy

By load, I mean : 100 * avg.runnable_avg_sum / avg.runnable_avg_period
In addition, i take into account the number of tasks already in the
runqueue in order to define the business of a CPU. A CPU with a load
of 50% without any tasks in the runqeue in not busy at this time and
we can migrate tasks on it but if the CPU already has 2 tasks in its
runqueue, it means that newly wake up task will have to share the CPU
with other tasks so we consider that the CPU is already busy and we
will fall back to default behavior. The equation considers that a CPU
is not busy if
100 * avg.runnable_avg_sum / avg.runnable_avg_period < 100 / (nr_running + 2)

>
> (rq->util * 100) * #nr_running <  cpu_of(rq)->power and conclude that it
> is just enough _busy_ to not take on more processes?
>
>
> @Vincent: Yes the comment above needs to be fixed. A busy buddy is a CPU
> with *high rq utilization*, as far as the equation goes.

I can update the comment. Is the comment below more clear ?

/*
 * A busy buddy is a CPU with a high average running time or a small
average running time but a lot of
 * running tasks in its runqueue which are already sharing this CPU time.
 */

Vincent

>
> Regards
> Preeti U Murthy
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
