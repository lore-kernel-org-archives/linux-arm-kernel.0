From: peterz@infradead.org (Peter Zijlstra)
Date: Fri, 26 Apr 2013 12:18:49 +0200
Subject: [RFC PATCH v3 3/6] sched: pack small tasks
In-Reply-To: <5152C83F.6060509@linux.vnet.ibm.com>
References: <1363955155-18382-1-git-send-email-vincent.guittot@linaro.org>
 <1363955155-18382-4-git-send-email-vincent.guittot@linaro.org>
 <1364300782.5053.6.camel@laptop>
 <5152C83F.6060509@linux.vnet.ibm.com>
Message-ID: <20130426101849.GD8669@dyad.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 27, 2013 at 03:51:51PM +0530, Preeti U Murthy wrote:
> Hi,
> 
> On 03/26/2013 05:56 PM, Peter Zijlstra wrote:
> > On Fri, 2013-03-22 at 13:25 +0100, Vincent Guittot wrote:
> >> +static bool is_buddy_busy(int cpu)
> >> +{
> >> +       struct rq *rq = cpu_rq(cpu);
> >> +
> >> +       /*
> >> +        * A busy buddy is a CPU with a high load or a small load with
> >> a lot of
> >> +        * running tasks.
> >> +        */
> >> +       return (rq->avg.runnable_avg_sum >
> >> +                       (rq->avg.runnable_avg_period / (rq->nr_running
> >> + 2)));
> >> +}
> > 
> > Why does the comment talk about load but we don't see it in the
> > equation. Also, why does nr_running matter at all? I thought we'd
> > simply bother with utilization, if fully utilized we're done etc..
> > 
> 
> Peter, lets say the run-queue has 50% utilization and is running 2
> tasks. And we wish to find out if it is busy. We would compare this
> metric with the cpu power, which lets say is 100.
> 
> rq->util * 100 < cpu_of(rq)->power.
> 
> In the above scenario would we declare the cpu _not_busy? Or would we do
> the following:
> 
> (rq->util * 100) * #nr_running <  cpu_of(rq)->power and conclude that it
> is just enough _busy_ to not take on more processes?

That is just confused... ->power doesn't have anything to do with a per-cpu
measure. ->power is a inter-cpu measure of relative compute capacity.

Mixing in nr_running confuses things even more; it doesn't matter how many
tasks it takes to push utilization up to 100%; once its there the cpu simply
cannot run more.

So colour me properly confused..
