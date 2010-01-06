From: jamie@jamieiles.com (Jamie Iles)
Date: Wed, 6 Jan 2010 00:18:31 +0000
Subject: [PATCH 5/5] arm/perfevents: implement perf event support for ARMv6
In-Reply-To: <20100105223147.GB10941@n2100.arm.linux.org.uk>
References: <1262602122-10373-1-git-send-email-jamie.iles@picochip.com>
	<1262602122-10373-2-git-send-email-jamie.iles@picochip.com>
	<1262602122-10373-3-git-send-email-jamie.iles@picochip.com>
	<1262602122-10373-4-git-send-email-jamie.iles@picochip.com>
	<1262602122-10373-5-git-send-email-jamie.iles@picochip.com>
	<1262602122-10373-6-git-send-email-jamie.iles@picochip.com>
	<20100105222657.GK4179@wear.picochip.com>
	<20100105223147.GB10941@n2100.arm.linux.org.uk>
Message-ID: <20100106001831.GM4179@wear.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 05, 2010 at 10:31:47PM +0000, Russell King - ARM Linux wrote:
> On Tue, Jan 05, 2010 at 10:26:58PM +0000, Jamie Iles wrote:
> > Hi Will,
> > 
> > On Tue, Jan 05, 2010 at 06:07:44PM -0000, Will Deacon wrote:
> > > I've been trying to test your patches with a quad-core ARM 11MPCore on a
> > > Realview PB11MP board.
> > > 
> > > Unfortunately, I occasionally experience a complete system hang during some
> > > profiling runs. I don't think it's your fault however, as it can occur even
> > > when monitoring only software events. I've managed to reproduce this on the 
> > > tip/master branch and got the following information [I enabled lock debugging]:
> > Could it be to do with the fact that perf_event_task_sched_in() expects
> > interrupts to be disabled but on ARM we have __ARCH_WANT_INTERRUPTS_ON_CTXSW
> > defined and therefore run with interrupts enabled? If so, I'm not sure what
> > the fix is!
> > 
> > At the moment, ARM is the only platform that context switches with interrupts
> > enabled and has perf event support.
> 
> If perf event support is only safe with interrupts disabled, it should
> disable them.  Maybe a patch to do that conditional on
> __ARCH_WANT_INTERRUPTS_ON_CTXSW would be more acceptable than an
> unconditional one - don't know.
> 
> We could only define __ARCH_WANT_INTERRUPTS_ON_CTXSW for VIVT supporting
> kernels, which is the reason for it existing (the interrupt latency for
> VIVT would otherwise be unacceptable.)  This approach would mean that
> perf events wouldn't be usable on VIVT CPUs (which includes Xscale CPUs.)
Ok, I've tried 2 things:
	1. disabling interrupts around perf_event_task_sched_in()
	2. undefining __ARCH_WANT_INTERRUPTS_ON_CTXSW

As far as I can tell, both of these solutions work, although with 2, I had to
define __ARCH_WANT_INTERRUPTS_ON_CTXSW.

Will, Jean - could you give the patch below a go and see if it works on your
systems? I don't get any lockdep warnings on my platform with this and it
still runs without the lock debugging.

It's not a nice patch but at least perf events could be used on all ARM
platforms. Also, I guess that this could be a local_irq_{disable,enable} pair
without the need of saving the flags when we know interrupts are enabled.

Thanks,

Jamie

diff --git a/kernel/sched.c b/kernel/sched.c
index 918f343..f110994 100644
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -2767,6 +2767,9 @@ static void finish_task_switch(struct rq *rq, struct task_struct *prev)
 {
 	struct mm_struct *mm = rq->prev_mm;
 	long prev_state;
+#ifdef __ARCH_WANT_INTERRUPTS_ON_CTXSW
+	unsigned long flags;
+#endif /* __ARCH_WANT_INTERRUPTS_ON_CTXSW */
 
 	rq->prev_mm = NULL;
 
@@ -2783,7 +2786,14 @@ static void finish_task_switch(struct rq *rq, struct task_struct *prev)
 	 */
 	prev_state = prev->state;
 	finish_arch_switch(prev);
+#ifdef __ARCH_WANT_INTERRUPTS_ON_CTXSW
+	local_irq_save(flags);
 	perf_event_task_sched_in(current);
+	local_irq_restore(flags);
+#else /* __ARCH_WANT_INTERRUPTS_ON_CTXSW */
+	perf_event_task_sched_in(current);
+#endif /* __ARCH_WANT_INTERRUPTS_ON_CTXSW */
+
 	finish_lock_switch(rq, prev);
 
 	fire_sched_in_preempt_notifiers(current);
