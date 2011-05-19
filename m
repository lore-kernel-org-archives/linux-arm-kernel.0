From: will.deacon@arm.com (Will Deacon)
Date: Thu, 19 May 2011 15:10:02 +0100
Subject: [PATCH v2] arm: Add Cortex A5 proc info
In-Reply-To: <1305737066-11900-1-git-send-email-pawel.moll@arm.com>
References: <1305720361.17656.44.camel@hornet.cambridge.arm.com>
	<1305737066-11900-1-git-send-email-pawel.moll@arm.com>
Message-ID: <000d01cc162e$723081b0$56918510$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pawel,

> This patch adds processor info for Cortex A5 (MPCore).
> 
> To reduce code duplicating it converts existing A9 proc info
> into a macro and uses it to define A5 and A9 cores, allowing
> new similar parts (requiring different init function and MMU
> flags) in future.
> 
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>
> ---
>  arch/arm/mm/proc-v7.S |   69 ++++++++++++++++++++++++++++--------------------
>  1 files changed, 40 insertions(+), 29 deletions(-)
> 
> diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
> index babfba0..01256fa 100644
> --- a/arch/arm/mm/proc-v7.S
> +++ b/arch/arm/mm/proc-v7.S
> @@ -270,11 +270,15 @@ cpu_resume_l1_flags:
>   *	Harvard cache control instructions insead of the unified cache
>   *	control instructions.
>   *
> - *	This should be able to cover all ARMv7 cores.
> + *	This should be able to cover all ARMv7 cores. Some MPCore
> + *	implementations require additional code when SMP is to be
> + *	enabled to activate Snoop Control Unit - this is done prior
> + *	to the __v7_setup.
>   *
>   *	It is assumed that:
>   *	- cache type register is implemented
>   */
> +__v7_ca5mp_setup:
>  __v7_ca9mp_setup:
>  #ifdef CONFIG_SMP
>  	ALT_SMP(mrc	p15, 0, r0, c1, c0, 1)
> @@ -436,34 +440,41 @@ cpu_elf_name:
> 
>  	.section ".proc.info.init", #alloc, #execinstr
> 
> -	.type   __v7_ca9mp_proc_info, #object
> -__v7_ca9mp_proc_info:
> -	.long	0x410fc090		@ Required ID value
> -	.long	0xff0ffff0		@ Mask for ID
> -	ALT_SMP(.long \
> -		PMD_TYPE_SECT | \
> -		PMD_SECT_AP_WRITE | \
> -		PMD_SECT_AP_READ | \
> -		PMD_FLAGS_SMP)
> -	ALT_UP(.long \
> -		PMD_TYPE_SECT | \
> -		PMD_SECT_AP_WRITE | \
> -		PMD_SECT_AP_READ | \
> -		PMD_FLAGS_UP)
> -	.long   PMD_TYPE_SECT | \
> -		PMD_SECT_XN | \
> -		PMD_SECT_AP_WRITE | \
> -		PMD_SECT_AP_READ
> -	W(b)	__v7_ca9mp_setup
> -	.long	cpu_arch_name
> -	.long	cpu_elf_name
> -	.long	HWCAP_SWP|HWCAP_HALF|HWCAP_THUMB|HWCAP_FAST_MULT|HWCAP_EDSP|HWCAP_TLS
> -	.long	cpu_v7_name
> -	.long	v7_processor_functions
> -	.long	v7wbi_tlb_fns
> -	.long	v6_user_fns
> -	.long	v7_cache_fns
> -	.size	__v7_ca9mp_proc_info, . - __v7_ca9mp_proc_info
> +	/*
> +	 * ARM Ltd. Cortex cores
> +	 */
> +#define __V7_CORTEX_PROC_INFO(_part, _mm_mmuflags, _io_mmuflags, _initfunc) \
> +	.type   __v7_ca##_part##mp_proc_info, #object; \
> +__v7_ca##_part##mp_proc_info:; \
> +	.long	0x410fc0##_part##0; \
> +	.long	0xff0ffff0; \
> +	ALT_SMP(.long	_mm_mmuflags | PMD_FLAGS_SMP); \
> +	ALT_UP(.long	_mm_mmuflags | PMD_FLAGS_UP); \
> +	.long	_io_mmuflags; \
> +	W(b)	_initfunc; \
> +	.long	cpu_arch_name; \
> +	.long	cpu_elf_name; \
> +	.long	HWCAP_SWP|HWCAP_HALF|HWCAP_THUMB|HWCAP_FAST_MULT|HWCAP_EDSP|HWCAP_TLS; \
> +	.long	cpu_v7_name; \
> +	.long	v7_processor_functions; \
> +	.long	v7wbi_tlb_fns; \
> +	.long	v6_user_fns; \
> +	.long	v7_cache_fns; \
> +	.size	__v7_ca##_part##mp_proc_info, . - __v7_ca##_part##mp_proc_info
> +
> +__V7_CORTEX_PROC_INFO(
> +	5, /* Cortex A5 */
> +	PMD_TYPE_SECT | PMD_SECT_AP_WRITE | PMD_SECT_AP_READ,
> +	PMD_TYPE_SECT | PMD_SECT_XN | PMD_SECT_AP_WRITE | PMD_SECT_AP_READ,
> +	__v7_ca5mp_setup
> +)
> +
> +__V7_CORTEX_PROC_INFO(
> +	9, /* Cortex A9 */
> +	PMD_TYPE_SECT | PMD_SECT_AP_WRITE | PMD_SECT_AP_READ,
> +	PMD_TYPE_SECT | PMD_SECT_XN | PMD_SECT_AP_WRITE | PMD_SECT_AP_READ,
> +	__v7_ca9mp_setup
> +)
> 
>  	/*
>  	 * Match any ARMv7 processor core.

Please can you do the same for the __v7_proc_info struct? On top of that, I
think you should take optional, additional HWCAPs as arguments to the macro
which get ORd with the base v7 HWCAPs. This might be useful for A15 where we
have integer division.

Cheers,

Will
