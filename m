From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 30 Aug 2016 14:45:05 +0100
Subject: [PATCH v2 4/9] arm64: head.S: move KASLR processing out of
 __enable_mmu()
In-Reply-To: <1472049366-10922-5-git-send-email-ard.biesheuvel@linaro.org>
References: <1472049366-10922-1-git-send-email-ard.biesheuvel@linaro.org>
 <1472049366-10922-5-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20160830134505.GH1223@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Aug 24, 2016 at 04:36:01PM +0200, Ard Biesheuvel wrote:
> @@ -742,25 +739,6 @@ ENTRY(__enable_mmu)
>  	ic	iallu
>  	dsb	nsh
>  	isb
> -#ifdef CONFIG_RANDOMIZE_BASE
> -	mov	x19, x0				// preserve new SCTLR_EL1 value
> -	blr	x27
> -
> -	/*
> -	 * If we return here, we have a KASLR displacement in x23 which we need
> -	 * to take into account by discarding the current kernel mapping and
> -	 * creating a new one.
> -	 */
> -	msr	sctlr_el1, x22			// disable the MMU
> -	isb
> -	bl	__create_page_tables		// recreate kernel mapping
> -
> -	msr	sctlr_el1, x19			// re-enable the MMU
> -	isb
> -	ic	iallu				// flush instructions fetched
> -	dsb	nsh				// via old mapping
> -	isb
> -#endif
>  	br	x27
>  ENDPROC(__enable_mmu)

As a heads-up, this clashes with fd363bd417ddb610 ("arm64: avoid TLB
conflict with CONFIG_RANDOMIZE_BASE") [1], which went in for v4.8-rc4.

The fixup (moving the new TLBI; DSB into __primary_switch) is
trivial/obvious, but beyond git's automated resolution capabilities.

> @@ -770,11 +748,11 @@ __no_granule_support:
>  1:
>  	wfe
>  	wfi
> -	b 1b
> +	b	1b
>  ENDPROC(__no_granule_support)

As mentioned in another reply, it might be worth moving the whitespace
fixups into a preparatory patch, so as to make it less distracting when
looking at the diff.

Regardless, FWIW:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-August/451294.html
