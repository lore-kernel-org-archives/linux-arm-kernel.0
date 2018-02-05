From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 5 Feb 2018 14:15:39 +0000
Subject: Runqueue spinlock recursion on arm64 v4.15
In-Reply-To: <20180205140201.GY2269@hirez.programming.kicks-ass.net>
References: <20180202192704.nqwjsthl3agszhzt@lakrids.cambridge.arm.com>
 <20180202195506.GP2269@hirez.programming.kicks-ass.net>
 <20180202220726.23d4ljxxdysafbxd@salmiak>
 <20180205133600.etr32unq6amsa6af@lakrids.cambridge.arm.com>
 <20180205140201.GY2269@hirez.programming.kicks-ass.net>
Message-ID: <20180205141538.4l3nbdmkejys7ok4@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 05, 2018 at 03:02:01PM +0100, Peter Zijlstra wrote:
> On Mon, Feb 05, 2018 at 01:36:00PM +0000, Mark Rutland wrote:
> > On Fri, Feb 02, 2018 at 10:07:26PM +0000, Mark Rutland wrote:
> > > On Fri, Feb 02, 2018 at 08:55:06PM +0100, Peter Zijlstra wrote:
> > > > On Fri, Feb 02, 2018 at 07:27:04PM +0000, Mark Rutland wrote:
> > > > > ... in some cases, owner_cpu is -1, so I guess we're racing with an
> > > > > unlock. I only ever see this on the runqueue locks in wake up functions.
> > > > 
> > > > So runqueue locks are special in that the owner changes over a contex
> > > > switch, maybe something goes funny there?
> > > 
> > > Aha! I think that's it!
> > > 
> > > In finish_lock_switch() we do:
> > > 
> > > 	smp_store_release(&prev->on_cpu, 0);
> > > 	...
> > > 	rq->lock.owner = current;
> > > 
> > > As soon as we update prev->on_cpu, prev can be scheduled on another CPU, and
> > > can thus see a stale value for rq->lock.owner (e.g. if it tries to wake up
> > > another task on that rq).
> > 
> > I hacked in a forced vCPU preemption between the two using a sled of WFE
> > instructions, and now I can trigger the problem in seconds rather than
> > hours.
> > 
> > With the patch below applied, things seem to fine so far.
> > 
> > So I'm pretty sure this is it. I'll clean up the patch text and resend
> > that in a bit.
> 
> Also try and send it against an up-to-date scheduler tree, we just
> moved some stuff around just about there.

Ah, will do. I guess I should base on TIP sched/urgent?

Thanks,
Mark.
