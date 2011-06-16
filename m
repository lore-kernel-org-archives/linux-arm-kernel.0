From: will.deacon@arm.com (Will Deacon)
Date: Thu, 16 Jun 2011 11:15:10 +0100
Subject: [RFC PATCH v2 2/5] ARM: proc-v7: Use new generic struct
	definition macros
In-Reply-To: <1308049105-16080-3-git-send-email-dave.martin@linaro.org>
References: <1308049105-16080-1-git-send-email-dave.martin@linaro.org>
	<1308049105-16080-3-git-send-email-dave.martin@linaro.org>
Message-ID: <20110616101510.GB4028@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 14, 2011 at 11:58:22AM +0100, Dave Martin wrote:
> diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
> index b3b566e..c5cf6ea 100644
> --- a/arch/arm/mm/proc-v7.S
> +++ b/arch/arm/mm/proc-v7.S
> @@ -171,8 +171,6 @@ ENTRY(cpu_v7_set_pte_ext)
>  	mov	pc, lr
>  ENDPROC(cpu_v7_set_pte_ext)
>  
> -cpu_v7_name:
> -	.ascii	"ARMv7 Processor"
>  	.align
>  
>  	/*
> @@ -403,36 +401,8 @@ v7_crval:
>  __v7_setup_stack:
>  	.space	4 * 11				@ 11 registers
>  
> -	__INITDATA
> -
> -	.type	v7_processor_functions, #object
> -ENTRY(v7_processor_functions)
> -	.word	v7_early_abort
> -	.word	v7_pabort
> -	.word	cpu_v7_proc_init
> -	.word	cpu_v7_proc_fin
> -	.word	cpu_v7_reset
> -	.word	cpu_v7_do_idle
> -	.word	cpu_v7_dcache_clean_area
> -	.word	cpu_v7_switch_mm
> -	.word	cpu_v7_set_pte_ext
> -	.word	0
> -	.word	0
> -	.word	0
> -	.size	v7_processor_functions, . - v7_processor_functions
> -
> -	.section ".rodata"
> -
> -	.type	cpu_arch_name, #object
> -cpu_arch_name:
> -	.asciz	"armv7"
> -	.size	cpu_arch_name, . - cpu_arch_name
> -
> -	.type	cpu_elf_name, #object
> -cpu_elf_name:
> -	.asciz	"v7"
> -	.size	cpu_elf_name, . - cpu_elf_name
> -	.align
> +	define_processor_functions v7, dabort=v7_early, pabort=v7
> +	define_proc_names v7, "armv7", "v7", "ARMv7 Processor"

It's not required, but it might be nice to use named arguments here anyway
since v7, "armv7", "v7" and "ARMv7 Processor" are all quite similar and it
would be easier to read if it's explicitly stated what's what.

Will
