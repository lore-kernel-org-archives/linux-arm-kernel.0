From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 4 Aug 2015 22:45:23 +0100
Subject: [PATCH] arm64: mm: ensure patched kernel text is fetched from PoC
In-Reply-To: <1438715013-4625-1-git-send-email-will.deacon@arm.com>
References: <1438715013-4625-1-git-send-email-will.deacon@arm.com>
Message-ID: <20150804214522.GA14625@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

I assume that you meant PoU rather than PoC in the subject.

On Tue, Aug 04, 2015 at 08:03:33PM +0100, Will Deacon wrote:
> The arm64 booting document requires that the bootloader has cleaned the
> kernel image to the PoC. However, when a CPU re-enters the kernel due to
> either a CPU hotplug "on" event or resuming from a low-power state (e.g.
> cpuidle), the kernel text may in-fact be dirty at the PoU due to things
> like alternative patching or even module loading.
> 
> Thanks to I-cache speculation with the MMU off, stale instructions could
> be fetched prior to enabling the MMU, potentially leading to crashes
> when executing regions of code that have been modified at runtime.
> 
> This patch addresses the issue by ensuring that the local I-cache is
> invalidated immediately after a CPU has enabled its MMU but before
> jumping out of the identity mapping. Any stale instructions fetched from
> the PoC will then be discarded and refetched correctly from the PoU.

It may be worth mentioning that none of the instructions executed up to
this point will have been patched, so we know that they have remained
clean to the PoC. Otherwise we'd need to flush those to the PoC
explicitly.

Other than the typo in the subject, this looks good to me. With that
fixed:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.

> 
> Tested-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/kernel/head.S  | 8 ++++++++
>  arch/arm64/kernel/sleep.S | 8 ++++++++
>  arch/arm64/mm/proc.S      | 1 -
>  3 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index 3a0654173997..a055be6125cf 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -634,5 +634,13 @@ __enable_mmu:
>  	isb
>  	msr	sctlr_el1, x0
>  	isb
> +	/*
> +	 * Invalidate the local I-cache so that any instructions fetched
> +	 * speculatively from the PoC are discarded, since they may have
> +	 * been dynamically patched at the PoU.
> +	 */
> +	ic	iallu
> +	dsb	nsh
> +	isb
>  	br	x27
>  ENDPROC(__enable_mmu)
> diff --git a/arch/arm64/kernel/sleep.S b/arch/arm64/kernel/sleep.S
> index 5686a3ae3940..38d37c539a30 100644
> --- a/arch/arm64/kernel/sleep.S
> +++ b/arch/arm64/kernel/sleep.S
> @@ -133,6 +133,14 @@ ENTRY(cpu_resume_mmu)
>  	ldr	x3, =cpu_resume_after_mmu
>  	msr	sctlr_el1, x0		// restore sctlr_el1
>  	isb
> +	/*
> +	 * Invalidate the local I-cache so that any instructions fetched
> +	 * speculatively from the PoC are discarded, since they may have
> +	 * been dynamically patched at the PoU.
> +	 */
> +	ic	iallu
> +	dsb	nsh
> +	isb
>  	br	x3			// global jump to virtual address
>  ENDPROC(cpu_resume_mmu)
>  	.popsection
> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> index eff4f627358a..716c673cbd8e 100644
> --- a/arch/arm64/mm/proc.S
> +++ b/arch/arm64/mm/proc.S
> @@ -146,7 +146,6 @@ ENDPROC(cpu_do_switch_mm)
>   *	value of the SCTLR_EL1 register.
>   */
>  ENTRY(__cpu_setup)
> -	ic	iallu				// I+BTB cache invalidate
>  	tlbi	vmalle1is			// invalidate I + D TLBs
>  	dsb	ish
>  
> -- 
> 2.1.4
> 
