From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 24 Feb 2012 23:01:22 +0100
Subject: [PATCH 5/5] ARM: Cortex-M3: Add support for exception handling
In-Reply-To: <20120216222002.GL27825@n2100.arm.linux.org.uk>
References: <20120216200143.GS14173@pengutronix.de>
 <1329423490-15580-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1329423490-15580-5-git-send-email-u.kleine-koenig@pengutronix.de>
 <20120216222002.GL27825@n2100.arm.linux.org.uk>
Message-ID: <20120224220122.GD14173@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Catalin,

On Thu, Feb 16, 2012 at 10:20:02PM +0000, Russell King - ARM Linux wrote:
> On Thu, Feb 16, 2012 at 09:18:10PM +0100, Uwe Kleine-K?nig wrote:
> > +	.macro	v7m_exception_entry
> > +	cpsid	i
> > +	tst	lr, #0x8		@ check the return stack
> > +	bne	1f			@ exception on process stack
> > +	add	r12, sp, #32		@ MSP before exception
> > +	stmdb	sp!, {r4-r12, lr}	@ push unsaved registers
> > +	b	2f
> > +1:
> > +	mrs	r12, psp		@ get the process stack
> > +	sub	sp, #S_FRAME_SIZE
> > +	stmia	sp, {r4-r12, lr}	@ push unsaved registers
> > +	ldmia	r12, {r0-r3, r6, r8-r10} @ load automatically saved registers
> > +	add	r12, sp, #S_R0
> > +	stmia	r12, {r0-r3, r6, r8-r10} @ fill in the rest of struct pt_regs
> 
> I guess this means that pt_regs no longer contains r0..pc, cpsr, old_r0
> on this Cortex-M ?
I stared at the code now for some time and I wonder if it wouldn't be
the most nice solution to just do something like this on exception
entry:

	cpsid	i
	sub	sp, #S_FRAME_SIZE
	stmia	sp, {r0-r12}
	put_the_right_sp_to_sp[13]
	put_lr_returnaddr_and_xPSR_from_right_stack_to_sp[14-16]

For returning you could just do:

	add	sp, #S_FRAME_SIZE
	cpsie	i
	bx	lr

after fixing r0 on the right stack in case you need to return something.

The machine takes care to restore {r0-r3,r12,lr} and the remaining
registers should be untouched as everything we called between entry and
exit is AAPCS conformant.

This way we would even need one value less in pt_regs (namely orig_r0).

Does this make sense? (Note it's just before bedtime here, so it might
not.)

Anyhow, I will try to implement that if I still think it could work
after sleeping.

> If so, that's a problem - tools like gdb, strace, and other user programs
> which make use of siginfo stuff all expect ARM to have a certain ptrace
> layout.  This is major ABI breakage.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
