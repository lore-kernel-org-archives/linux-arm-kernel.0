From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 13 Oct 2011 22:54:42 -0400 (EDT)
Subject: [RFC/PATCH 5/7] ARM: Move get_thread_info macro definition to
	<asm/assembler.h>
In-Reply-To: <D53F6A34-89FF-4DE3-96D2-AE415413AB84@mvista.com>
References: <1317877714-11355-1-git-send-email-gdavis@mvista.com>
	<1317955121-28047-1-git-send-email-gdavis@mvista.com>
	<1317955121-28047-6-git-send-email-gdavis@mvista.com>
	<20111011095639.GB23848@arm.com> <20111012060433.GE188@mvista.com>
	<20111013143420.GB21648@n2100.arm.linux.org.uk>
	<D53F6A34-89FF-4DE3-96D2-AE415413AB84@mvista.com>
Message-ID: <alpine.LFD.2.02.1110132249290.17040@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 13 Oct 2011, George G. Davis wrote:

> 
> On Oct 13, 2011, at 10:34 AM, Russell King - ARM Linux wrote:
> 
> > On Wed, Oct 12, 2011 at 02:04:33AM -0400, gdavis at mvista.com wrote:
> >> diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
> >> index 78397d0..eaf4939 100644
> >> --- a/arch/arm/include/asm/assembler.h
> >> +++ b/arch/arm/include/asm/assembler.h
> >> @@ -36,6 +36,20 @@
> >> 	.endm
> >> #endif  /* !CONFIG_THUMB2_KERNEL */
> >> 
> >> +	.macro	preempt_disable, tsk, cnt
> >> +	get_thread_info \tsk
> >> +	ldr	\cnt, [\tsk, #TI_PREEMPT]
> >> +	add	\cnt, \cnt, #1
> >> +	str	\cnt, [\tsk, #TI_PREEMPT]
> >> +	.endm
> >> +
> >> +	.macro	preempt_enable, tsk, cnt
> >> +	get_thread_info \tsk
> >> +	ldr	\cnt, [\tsk, #TI_PREEMPT]
> >> +	sub	\cnt, \cnt, #1
> >> +	str	\cnt, [\tsk, #TI_PREEMPT]
> >> +	.endm
> >> +
> >> /*
> >>  * Endian independent macros for shifting bytes within registers.
> >>  */
> >> 
> >> 
> >> Not as efficient as it could be but I imagine the macros could
> >> be written to support optional load of \tsk and/or optional \tmp
> >> parameters to cover other common cases.
> > 
> > It's actually not that simple either: if you disable preemption, then you
> > need to check for a preempt event after re-enabling preemption.  The
> > C level code does this:
> > 
> > #define preempt_enable_no_resched() \
> > do { \
> >        barrier(); \
> >        dec_preempt_count(); \
> > } while (0)
> > 
> > #define preempt_check_resched() \
> > do { \
> >        if (unlikely(test_thread_flag(TIF_NEED_RESCHED))) \
> >                preempt_schedule(); \
> > } while (0)
> > 
> > #define preempt_enable() \
> > do { \
> >        preempt_enable_no_resched(); \
> >        barrier(); \
> >        preempt_check_resched(); \
> > } while (0)
> > 
> > Note that preempt_schedule() will check the preempt count itself and
> > return immediately if non-zero or irqs are disabled.
> 
> It would be easier to just insert preempt_disable/preempt_enable in
> the cache and proc function call macros.  I did that in an earlier test
> patch but moved it into the cache-v6.S and proc-v6.S files instead
> since it only affects ARM11 MPCore as far as I'm aware.

Alternately, why don't you simply disable IRQs locally?  No preemption 
can happen until enabled again, just like preempt_disable() would do, 
and the IRQ off period should be short enough not to visibly affect IRQ 
latency.  And that is easily done in assembly too, without preventing 
rescheduling if needed afterwards.


Nicolas
