From: will.deacon@arm.com (Will Deacon)
Date: Thu, 6 Jun 2013 11:27:03 +0100
Subject: [PATCH v3 1/2] ARM PJ4B: Add support for errata 4742
In-Reply-To: <1370511044-31900-2-git-send-email-gregory.clement@free-electrons.com>
References: <1370511044-31900-1-git-send-email-gregory.clement@free-electrons.com>
 <1370511044-31900-2-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20130606102703.GM15208@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 06, 2013 at 10:30:43AM +0100, Gregory CLEMENT wrote:
> This commit fixes the regression on Armada 370 (the kernal hang during
> boot) introduced by the commit: "ARM: 7691/1: mm: kill unused
> TLB_CAN_READ_FROM_L1_CACHE and use ALT_SMP instead".
> 
> When coming out of either a Wait for Interrupt (WFI) or a Wait for
> Event (WFE) IDLE states, a specific timing sensitivity exists between
> the retiring WFI/WFE instructions and the newly issued subsequent
> instructions. This sensitivity can result in a CPU hang scenario.  The
> workaround is to insert either a Data Synchronization Barrier (DSB) or
> Data Memory Barrier (DMB) command immediately after the WFI/WFE
> instruction.
> 
> This commit was based on the work of Lior Amsalem, but heavily
> modified to apply the errata fix dynamically according to the
> processor type thanks to the suggestions of Russell King and Nicolas
> Pitre.
> 
> This commit fixes also the ID and mask for the PJ4B which was too
> restrictive and didn't match the CPU of the Armada 370 SoC.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  arch/arm/Kconfig                 | 13 +++++++++++++
>  arch/arm/include/asm/glue-proc.h |  9 +++++++++
>  arch/arm/mm/proc-v7.S            | 38 +++++++++++++++++++++++++++++++++-----
>  3 files changed, 55 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 49d993c..95cbe9d 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1087,6 +1087,19 @@ if !MMU
>  source "arch/arm/Kconfig-nommu"
>  endif
>  
> +config PJ4B_ERRATA_4742
> +	bool "PJ4B Errata 4742: IDLE Wake Up Commands can Cause the CPU Core to Cease Operation"
> +	depends on CPU_PJ4B && MACH_ARMADA_370
> +	help
> +	  When coming out of either a Wait for Interrupt (WFI) or a Wait for
> +	  Event (WFE) IDLE states, a specific timing sensitivity exists between
> +	  the retiring WFI/WFE instructions and the newly issued subsequent
> +	  instructions.  This sensitivity can result in a CPU hang scenario.
> +	  Workaround:
> +	  The software must insert either a Data Synchronization Barrier (DSB)
> +	  or Data Memory Barrier (DMB) command immediately after the WFI/WFE
> +	  instruction
> +
>  config ARM_ERRATA_326103
>  	bool "ARM errata: FSR write bit incorrect on a SWP to read-only memory"
>  	depends on CPU_V6
> diff --git a/arch/arm/include/asm/glue-proc.h b/arch/arm/include/asm/glue-proc.h
> index ac1dd54..8017e94 100644
> --- a/arch/arm/include/asm/glue-proc.h
> +++ b/arch/arm/include/asm/glue-proc.h
> @@ -230,6 +230,15 @@
>  # endif
>  #endif
>  
> +#ifdef CONFIG_CPU_PJ4B
> +# ifdef CPU_NAME
> +#  undef  MULTI_CPU
> +#  define MULTI_CPU
> +# else
> +#  define CPU_NAME cpu_pj4b
> +# endif
> +#endif
> +
>  #ifndef MULTI_CPU
>  #define cpu_proc_init			__glue(CPU_NAME,_proc_init)
>  #define cpu_proc_fin			__glue(CPU_NAME,_proc_fin)
> diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
> index 2c73a73..4a4df33 100644
> --- a/arch/arm/mm/proc-v7.S
> +++ b/arch/arm/mm/proc-v7.S
> @@ -342,6 +342,33 @@ __v7_setup:
>  	mov	pc, lr				@ return to head.S:__ret
>  ENDPROC(__v7_setup)
>  
> +#ifdef CONFIG_CPU_PJ4B
> +.macro globl_equ x, y
> +	.globl	\x
> +	.equ	\x, \y
> +.endm

I guess you could put this in proc-macros.S, since there are potentially
other users of it (the louis stuff is implemented with globl, equ directives
for older CPUs).

>  __v7_pj4b_proc_info:
> -	.long	0x562f5840
> -	.long	0xfffffff0
> -	__v7_proc __v7_pj4b_setup
> +	.long   0x560f5800
> +	.long	0xff0fff00
> +	__v7_proc __v7_pj4b_setup, proc_fns = pj4b_processor_functions

Probably best as a separate patch.

Will
