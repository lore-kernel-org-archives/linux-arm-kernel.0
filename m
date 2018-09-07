From: james.morse@arm.com (James Morse)
Date: Fri, 7 Sep 2018 10:57:17 +0100
Subject: [RESEND PATCH v4 2/6] arm64/mm: Pass ttbr1 as a parameter to
 __enable_mmu().
In-Reply-To: <20180822095432.12125-3-yaojun8558363@gmail.com>
References: <20180822095432.12125-1-yaojun8558363@gmail.com>
 <20180822095432.12125-3-yaojun8558363@gmail.com>
Message-ID: <4279135f-393c-d3c1-91dd-cc77159a6062@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jun,

On 22/08/18 10:54, Jun Yao wrote:
> The kernel sets up the initial page table in the init_pg_dir.

(Nit: 'will set up', it doesn't until patch 3.)

> However, it will create the final page table in the swapper_pg_dir
> during the initialization process. We need to let __enable_mmu()
> know which page table to use.

> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index 2c83a8c47e3f..c3e4b1886cde 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -756,6 +757,7 @@ ENDPROC(__secondary_switched)
>   * Enable the MMU.
>   *
>   *  x0  = SCTLR_EL1 value for turning on the MMU.
> + *  x1  = TTBR1_EL1 value for turning on the MMU.
>   *
>   * Returns to the caller via x30/lr. This requires the caller to be covered
>   * by the .idmap.text section.
> @@ -764,15 +766,15 @@ ENDPROC(__secondary_switched)
>   * If it isn't, park the CPU
>   */
>  ENTRY(__enable_mmu)
> -	mrs	x1, ID_AA64MMFR0_EL1
> -	ubfx	x2, x1, #ID_AA64MMFR0_TGRAN_SHIFT, 4
> -	cmp	x2, #ID_AA64MMFR0_TGRAN_SUPPORTED
> +	mrs	x5, ID_AA64MMFR0_EL1
> +	ubfx	x6, x5, #ID_AA64MMFR0_TGRAN_SHIFT, 4
> +	cmp	x6, #ID_AA64MMFR0_TGRAN_SUPPORTED
>  	b.ne	__no_granule_support
> -	update_early_cpu_boot_status 0, x1, x2
> -	adrp	x1, idmap_pg_dir
> -	adrp	x2, swapper_pg_dir
> -	phys_to_ttbr x3, x1
> -	phys_to_ttbr x4, x2
> +	update_early_cpu_boot_status 0, x5, x6
> +	adrp	x5, idmap_pg_dir
> +	mov	x6, x1
> +	phys_to_ttbr x3, x5
> +	phys_to_ttbr x4, x6
>  	msr	ttbr0_el1, x3			// load TTBR0
>  	msr	ttbr1_el1, x4			// load TTBR1
>  	isb
> @@ -791,7 +793,7 @@ ENDPROC(__enable_mmu)
>  
>  __no_granule_support:
>  	/* Indicate that this CPU can't boot and is stuck in the kernel */


> -	update_early_cpu_boot_status CPU_STUCK_IN_KERNEL, x1, x2
> +	update_early_cpu_boot_status CPU_STUCK_IN_KERNEL, x5, x6

(You don't need to change these as they are both temporary registers.)

Reviewed-by: James Morse <james.morse@arm.com>


Thanks,

James
