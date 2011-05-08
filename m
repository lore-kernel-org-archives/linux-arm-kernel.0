From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 8 May 2011 22:41:01 +0100
Subject: [PATCH v5 02/19] ARM: LPAE: add ISBs around MMU enabling code
In-Reply-To: <1304859098-10760-3-git-send-email-catalin.marinas@arm.com>
References: <1304859098-10760-1-git-send-email-catalin.marinas@arm.com>
	<1304859098-10760-3-git-send-email-catalin.marinas@arm.com>
Message-ID: <20110508214101.GO27807@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 08, 2011 at 01:51:21PM +0100, Catalin Marinas wrote:
> From: Will Deacon <will.deacon@arm.com>
> 
> Before we enable the MMU, we must ensure that the TTBR registers contain
> sane values. After the MMU has been enabled, we jump to the *virtual*
> address of the following function, so we also need to ensure that the
> SCTLR write has taken effect.
> 
> This patch adds ISB instructions around the SCTLR write to ensure the
> visibility of the above.

Maybe this should be extended to the arch/arm/kernel/sleep.S code too?

>  __turn_mmu_on:
>  	mov	r0, r0
> +	instr_sync
>  	mcr	p15, 0, r0, c1, c0, 0		@ write control reg
>  	mrc	p15, 0, r3, c0, c0, 0		@ read id reg
> +	instr_sync
>  	mov	r3, r3
>  	mov	r3, r13
>  	mov	pc, r3

Could we avoid the second isb by doing something like this instead:

	mrc	p15, 0, r3, c0, c0, 0		@ read id reg
	and	r3, r3, r13
	orr	r3, r3, r13
	mov	pc, r3

The read from the ID register must complete before the branch can be
taken as the value is involved in computing the address to jump to
(even though that value has no actual effect on that address.)  This
assumes that the read from CP15 can't complete until the previous
write has completed.

What I'm concerned about is adding additional code to this path - we
know it has some strict alignment requirements on some CPUs which
otherwise misbehave, normally by faulting in some way.
