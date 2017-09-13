From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 13 Sep 2017 06:32:06 -0700
Subject: [PATCH v2 10/28] arm64/sve: Low-level CPU setup
In-Reply-To: <1504198860-12951-11-git-send-email-Dave.Martin@arm.com>
References: <1504198860-12951-1-git-send-email-Dave.Martin@arm.com>
 <1504198860-12951-11-git-send-email-Dave.Martin@arm.com>
Message-ID: <20170913133206.rwobtu7ft5nrsh4p@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 31, 2017 at 06:00:42PM +0100, Dave P Martin wrote:
> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> index 877d42f..dd22ef2 100644
> --- a/arch/arm64/mm/proc.S
> +++ b/arch/arm64/mm/proc.S
> @@ -27,6 +27,7 @@
>  #include <asm/pgtable-hwdef.h>
>  #include <asm/cpufeature.h>
>  #include <asm/alternative.h>
> +#include <asm/sysreg.h>
>  
>  #ifdef CONFIG_ARM64_64K_PAGES
>  #define TCR_TG_FLAGS	TCR_TG0_64K | TCR_TG1_64K
> @@ -186,8 +187,17 @@ ENTRY(__cpu_setup)
>  	tlbi	vmalle1				// Invalidate local TLB
>  	dsb	nsh
>  
> -	mov	x0, #3 << 20
> -	msr	cpacr_el1, x0			// Enable FP/ASIMD
> +	mov	x0, #3 << 20			// FEN
> +
> +	/* SVE */
> +	mrs	x5, id_aa64pfr0_el1
> +	ubfx	x5, x5, #ID_AA64PFR0_SVE_SHIFT, #4
> +	cbz	x5, 1f
> +
> +	bic	x0, x0, #CPACR_EL1_ZEN
> +	orr	x0, x0, #CPACR_EL1_ZEN_EL1EN	// SVE: trap for EL0, not EL1
> +1:	msr	cpacr_el1, x0			// Enable FP/ASIMD

For EL1, I wonder whether we could move this later to cpufeature.c. IIRC
I tried to do the same with FPSIMD but hit an issue with EFI run-time
services (I may be wrong though).

-- 
Catalin
