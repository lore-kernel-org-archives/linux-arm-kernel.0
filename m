From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 26 Sep 2011 16:06:45 +0100
Subject: [RFC PATCH 3/3] ARM: mm: add l2x0 suspend/resume support
In-Reply-To: <1317047561-11020-4-git-send-email-lorenzo.pieralisi@arm.com>
References: <1317047561-11020-1-git-send-email-lorenzo.pieralisi@arm.com>
	<1317047561-11020-4-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <20110926150645.GN22455@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 26, 2011 at 03:32:41PM +0100, Lorenzo Pieralisi wrote:
> Context is saved once for all at boot time, along with the L2 physical address
> and cache type.

Why is this assembly code?  As Barry's previous patch shows, it's
entirely possible to save all the state required at init time from
the existing C code without needing any additional functions.

> The resume hook avoids using the stack since it might be called
> before the C environment is up and running and fetches data using
> program counter relative addressing so that it can be run both
> with MMU on or off to simplify its adoption.

What about parts where the security gets in the way of reinitializing
the L2 cache?

> +resume_l210:
> +	ldr	r2, [r0], #4				@ just use scratch regs
> +	str	r2, [r1, #L2X0_AUX_CTRL]
> +	mov	r3, #0
> +	mov	r12, #L2X0_LOCKDOWN_WAY_D_BASE
> +	mov	r2, r12
> +	str	r3, [r1, r2]
> +	add	r2, r2, #4
> +	str	r3, [r1, r2]
> +	movne	r0, #0x1				@ if l210 we are done
> +	strne	r0, [r1, #L2X0_CTRL]			@ enable L2
> +	movne	pc, lr

It's not very obvious where the compare is for this conditional (which is
at the end of l2x0_resume in the .data section.  Also, wouldn't a branch
to the enable at the end of this function be better and a more obvious
flow?

> +resume_l310:
> +	add	r12, r12, r1
> +	add	r12, r12, #L2X0_LOCKDOWN_STRIDE		@ start D lock
> +	mov	r2, #0
> +	mov	r3, #7
> +unlock:
> +	str	r2, [r12, #4]				@ I lock
> +	str	r2, [r12], #L2X0_LOCKDOWN_STRIDE	@ D lock and increment
> +	subs	r3, r3, #1
> +	bne 	unlock

Why not reverse r2 and r3 here?  r3 was already set to zero previously.

And given what you're doing, this code could become:

	mov	r3, #0
	add	r12, r1, #L2X0_LOCKDOWN_WAY_D_BASE
	str	r3, [r12, #4]				@ I lock
	str	r3, [r12], #L2X0_LOCKDOWN_STRIDE	@ D lock and increment
	bne	enable_l2
resume_l310:
	mov	r2, #7
unlock:
	str	r3, [r12, #4]				@ I lock
	str	r3, [r12], #L2X0_LOCKDOWN_STRIDE	@ D lock and increment
	subs	r2, r2, #1
	bne	unlock


> +	ldmia	r0!, {r2, r3, r12}
> +	str	r2, [r1, #L2X0_TAG_LATENCY_CTRL]
> +	str	r3, [r1, #L2X0_DATA_LATENCY_CTRL]
> +	str	r12, [r1, #L2X0_ADDR_FILTER_START]
> +	ldmia	r0!, {r2, r3, r12}
> +	str	r2, [r1, #L2X0_ADDR_FILTER_END]
> +	str	r3, [r1, #L2X0_DEBUG_CTRL]
> +	str	r12, [r1, #L2X0_PREFETCH_CTRL]
> +	ldr	r2, [r0]
> +	str	r2, [r1, #L2X0_POWER_CTRL]

enable_l2:

> +	mov	r0, #0x1
> +	str	r0, [r1, #L2X0_CTRL]			@ enable L2
> +	mov	pc, lr
