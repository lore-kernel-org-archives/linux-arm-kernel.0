From: peterz@infradead.org (Peter Zijlstra)
Date: Mon, 14 Jul 2014 18:22:49 +0200
Subject: [PATCH v3 09/12] Revert "sched: Put rq's sched_avg under
 CONFIG_FAIR_GROUP_SCHED"
In-Reply-To: <20140714140435.GO26542@e103034-lin>
References: <1404144343-18720-1-git-send-email-vincent.guittot@linaro.org>
 <1404144343-18720-10-git-send-email-vincent.guittot@linaro.org>
 <20140710131646.GB3935@laptop>
 <CAKfTPtDzxyrzVmX016VB8j_y19wcCBVB1Rj46FYngMA+Ajft6g@mail.gmail.com>
 <20140711151304.GD3935@laptop>
 <CAKfTPtCL6mta75k9eoK724wCm7S3w7E+psa1XDrxhN1YVDONPw@mail.gmail.com>
 <20140711201238.GY20603@laptop.programming.kicks-ass.net>
 <20140714125529.GN26542@e103034-lin>
 <20140714132052.GY9918@twins.programming.kicks-ass.net>
 <20140714140435.GO26542@e103034-lin>
Message-ID: <20140714162249.GE9918@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 14, 2014 at 03:04:35PM +0100, Morten Rasmussen wrote:
> > I'm struggling to fully grasp your intent. We need DVFS like accounting
> > for sure, and that means a current freq hook, but I'm not entirely sure
> > how that relates to capacity.
> 
> We can abstract all the factors that affect current compute capacity
> (frequency, P-states, big.LITTLE,...) in the scheduler by having
> something like capacity_{cur,avail} to tell us how much capacity does a
> particular cpu have in its current state. Assuming that implement scale
> invariance for entity load tracking (we are working on that), we can
> directly compare task utilization with compute capacity for balancing
> decisions. For example, we can figure out how much spare capacity a cpu
> has in its current state by simply:
> 
> spare_capacity(cpu) = capacity_avail(cpu) - \sum_{tasks(cpu)}^{t} util(t)
> 
> If you put more than spare_capacity(cpu) worth of task utilization on
> the cpu, you will cause the cpu (and any affected cpus) to change
> P-state and potentially be less energy-efficient.
> 
> Does that make any sense?
> 
> Instead of dealing with frequencies directly in the scheduler code, we
> can abstract it by just having scalable compute capacity.

Ah, ok. Same thing then.

> > But yes, for application the tipping point is u == 1, up until that
> > point pure utilization makes sense, after that our runnable_avg makes
> > more sense.
> 
> Agreed.
> 
> If you really care about latency/performance you might be interested in
> comparing running_avg and runnable_avg even for u < 1. If the
> running_avg/runnable_avg ratio is significantly less than one, tasks are
> waiting on the rq to be scheduled.

Indeed, that gives a measure of queueing.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140714/cd8fbd65/attachment.sig>
