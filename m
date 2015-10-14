From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 14 Oct 2015 18:24:18 +0100
Subject: [PATCHv3 08/11] arm64: Check for selected granule support
In-Reply-To: <1444821634-1689-9-git-send-email-suzuki.poulose@arm.com>
References: <1444821634-1689-1-git-send-email-suzuki.poulose@arm.com>
 <1444821634-1689-9-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20151014172418.GI5041@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> @@ -613,10 +614,28 @@ ENDPROC(__secondary_switched)
>   *  x0  = SCTLR_EL1 value for turning on the MMU.
>   *  x27 = *virtual* address to jump to upon completion
>   *
> - * other registers depend on the function called upon completion
> + * Other registers depend on the function called upon completion.
> + *
> + * Checks if the selected granule size is supported by the CPU.
> + * If it doesn't park the CPU

Nit: "If it isn't, park the CPU."

>   */
> +#if	defined(CONFIG_ARM64_64K_PAGES)
> +
> +#define id_aa64mmfr0_tgran_shift	ID_AA64MMFR0_TGRAN64_SHIFT
> +#define id_aa64mmfr0_tgran_on		ID_AA64MMFR0_TGRAN64_ON
> +
> +#else
> +
> +#define id_aa64mmfr0_tgran_shift	ID_AA64MMFR0_TGRAN4_SHIFT
> +#define id_aa64mmfr0_tgran_on		ID_AA64MMFR0_TGRAN4_ON

Any reason for not using upper-case names for the macros?

Given they're local you could just call them TGRAN_SHIFT and TRGRAN_ON
to make the asm slightly nicer.

> +
> +#endif
>  	.section	".idmap.text", "ax"
>  __enable_mmu:
> +	mrs	x1, ID_AA64MMFR0_EL1
> +	ubfx	x2, x1, #id_aa64mmfr0_tgran_shift, 4
> +	cmp	x2, #id_aa64mmfr0_tgran_on
> +	b.ne	__no_granule_support
>  	ldr	x5, =vectors
>  	msr	vbar_el1, x5
>  	msr	ttbr0_el1, x25			// load TTBR0
> @@ -634,3 +653,8 @@ __enable_mmu:
>  	isb
>  	br	x27
>  ENDPROC(__enable_mmu)
> +
> +__no_granule_support:
> +	wfe
> +	b __no_granule_support
> +ENDPROC(__no_granule_support)

Other than the above, this loogs fine to me.

In future it would be nice if we could somehow signal that these dead
CPUs are trapped in the kernel -- we should have some kind of canary
mechanism for that. That needn't block this patch, though.

Thanks,
Mark.
