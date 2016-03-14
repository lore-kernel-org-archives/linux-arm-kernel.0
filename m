From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 14 Mar 2016 10:29:21 +0000
Subject: [PATCH v10 11/12] arm64: factor work_pending state machine to C
In-Reply-To: <56D9E9E7.9000503@mellanox.com>
References: <1456949376-4910-1-git-send-email-cmetcalf@ezchip.com>
 <1456949376-4910-12-git-send-email-cmetcalf@ezchip.com>
 <20160304163814.GD7886@arm.com> <56D9E9E7.9000503@mellanox.com>
Message-ID: <20160314102746.GA18083@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Mar 04, 2016 at 03:02:47PM -0500, Chris Metcalf wrote:
> On 03/04/2016 11:38 AM, Will Deacon wrote:
> >Hi Chris,
> >
> >On Wed, Mar 02, 2016 at 03:09:35PM -0500, Chris Metcalf wrote:
> >>Currently ret_fast_syscall, work_pending, and ret_to_user form an ad-hoc
> >>state machine that can be difficult to reason about due to duplicated
> >>code and a large number of branch targets.
> >>
> >>This patch factors the common logic out into the existing
> >>do_notify_resume function, converting the code to C in the process,
> >>making the code more legible.
> >>
> >>This patch tries to closely mirror the existing behaviour while using
> >>the usual C control flow primitives. As local_irq_{disable,enable} may
> >>be instrumented, we balance exception entry (where we will almost most
> >>likely enable IRQs) with a call to trace_hardirqs_on just before the
> >>return to userspace.
> >[...]
> >
> >>diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> >>index 1f7f5a2b61bf..966d0d4308f2 100644
> >>--- a/arch/arm64/kernel/entry.S
> >>+++ b/arch/arm64/kernel/entry.S
> >>@@ -674,18 +674,13 @@ ret_fast_syscall_trace:
> >>   * Ok, we need to do extra processing, enter the slow path.
> >>   */
> >>  work_pending:
> >>-	tbnz	x1, #TIF_NEED_RESCHED, work_resched
> >>-	/* TIF_SIGPENDING, TIF_NOTIFY_RESUME or TIF_FOREIGN_FPSTATE case */
> >>  	mov	x0, sp				// 'regs'
> >>-	enable_irq				// enable interrupts for do_notify_resume()
> >>  	bl	do_notify_resume
> >>-	b	ret_to_user
> >>-work_resched:
> >>  #ifdef CONFIG_TRACE_IRQFLAGS
> >>-	bl	trace_hardirqs_off		// the IRQs are off here, inform the tracing code
> >>+	bl	trace_hardirqs_on		// enabled while in userspace
> >This doesn't look right to me. We only get here after running
> >do_notify_resume, which returns with interrupts disabled.
> >
> >Do we not instead need to inform the tracing code that interrupts are
> >disabled prior to calling do_notify_resume?
> 
> I think you are right about the trace_hardirqs_off prior to
> calling into do_notify_resume, given Catalin's recent commit to
> add it.  I dropped it since I was moving schedule() into C code,
> but I suspect we'll see the same problem that Catalin saw with
> CONFIG_TRACE_IRQFLAGS without it.  I'll copy the arch/arm approach
> and add a trace_hardirqs_off() at the top of do_notify_resume().
> 
> The trace_hardirqs_on I was copying from Mark Rutland's earlier patch:
> 
> http://permalink.gmane.org/gmane.linux.ports.arm.kernel/467781
> 
> I don't know if it's necessary to flag that interrupts are enabled
> prior to returning to userspace; it may well not be.  Mark, can you
> comment on what led you to add that trace_hardirqs_on?

>From what I recall, we didn't properly trace enabling IRQs in all the
asm entry paths from userspace, and doing this made things appear
balanced to the tracing code (as the existing behaviour of masking IRQs
in assembly did).

It was more expedient / simpler than fixing all the entry assembly to
update the IRQ tracing state correctly, which I had expected to rework
if/when moving the rest to C.

Thanks,
Mark.
