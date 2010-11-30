From: will.deacon@arm.com (Will Deacon)
Date: Tue, 30 Nov 2010 13:49:32 -0000
Subject: ARM perf events spin locks
In-Reply-To: <20101130105856.GC4398@pulham.picochip.com>
References: <20101130100802.GB4398@pulham.picochip.com>
	<004101cb907b$16f911b0$44eb3510$@deacon@arm.com>
	<20101130105856.GC4398@pulham.picochip.com>
Message-ID: <004401cb9095$6b1fbcc0$415f3640$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jamie,

> On Tue, Nov 30, 2010 at 10:41:04AM -0000, Will Deacon wrote:
> > > Hi Will,
> >
> > Hello,
> >
> > > I think we should convert the spinlocks in the ARM perf events code to raw
> > > spinlocks for realtime. Should we wait for your split set to get merged first
> > > before doing this?
> >
> > Since this is a logically separate change, I think we're better off waiting
> > until the split stuff has been merged. As for the raw spinlocks, by realtime
> > do you mean PREEMPT_RT? Also, do we actually *need* raw spinlocks in the perf
> > code?
> Yes, I meant PREEMPT_RT. It won't stop working without raw spinlocks but I'm
> not convinced that we couldn't lose too much accuracy with normal spinlocks. I
> am however willing to be convinced otherwise!

Well struct perf_event_ctx has a lock field which is of type raw_spinlock_t.
I *think* this is always held by the core perf code before calling the backend,
however IRQs may still be enabled so we probably do need to change our pmu_lock.

Is that a sane analysis?

Will
