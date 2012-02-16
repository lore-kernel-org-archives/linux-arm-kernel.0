From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 16 Feb 2012 22:20:02 +0000
Subject: [PATCH 5/5] ARM: Cortex-M3: Add support for exception handling
In-Reply-To: <1329423490-15580-5-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20120216200143.GS14173@pengutronix.de>
 <1329423490-15580-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1329423490-15580-5-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20120216222002.GL27825@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 16, 2012 at 09:18:10PM +0100, Uwe Kleine-K?nig wrote:
> +	.macro	v7m_exception_entry
> +	cpsid	i
> +	tst	lr, #0x8		@ check the return stack
> +	bne	1f			@ exception on process stack
> +	add	r12, sp, #32		@ MSP before exception
> +	stmdb	sp!, {r4-r12, lr}	@ push unsaved registers
> +	b	2f
> +1:
> +	mrs	r12, psp		@ get the process stack
> +	sub	sp, #S_FRAME_SIZE
> +	stmia	sp, {r4-r12, lr}	@ push unsaved registers
> +	ldmia	r12, {r0-r3, r6, r8-r10} @ load automatically saved registers
> +	add	r12, sp, #S_R0
> +	stmia	r12, {r0-r3, r6, r8-r10} @ fill in the rest of struct pt_regs

I guess this means that pt_regs no longer contains r0..pc, cpsr, old_r0
on this Cortex-M ?

If so, that's a problem - tools like gdb, strace, and other user programs
which make use of siginfo stuff all expect ARM to have a certain ptrace
layout.  This is major ABI breakage.
