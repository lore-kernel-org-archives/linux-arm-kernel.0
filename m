From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Wed, 25 Mar 2015 09:13:28 +0900
Subject: [PATCH v6] ARM: zImage: add support for ARMv7-M
In-Reply-To: <1418806573-14897-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1418806573-14897-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <5511FDA8.5060108@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

I tested this patch for STM32F429 SoC (Cortex-M4) on STM32F429IDISCOVERY board.
After applied this patch on latest Linux Kernel (v4.0-rc4),
I completed the kernel booting (uImage) with u-boot.

Looks good to me of this patch.

Tested-by: Chanwoo Choi <cw00.choi@samsung.com>

Thanks,
Chanwoo Choi

On 12/17/2014 05:56 PM, Uwe Kleine-K?nig wrote:
> From: Joachim Eastwood <manabian@gmail.com>
> 
> This patch makes it possible to enter zImage in Thumb mode for ARMv7-M
> (Cortex-M) CPUs that do not support ARM mode. The kernel entry is also
> made in Thumb mode.
> 
> Signed-off-by: Joachim Eastwood <manabian@gmail.com>
> [ukl: fix spelling in commit log, return early in call_cache_fn]
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
> 
> I just picked up Joachim's patch and fixed the small concerns I had in
> the last round.
> 
> I thought about adding a wrapper for accessing the CPUID registers that
> are located in cp15 on v7-A/R and memory mapped on v7-M. The
> corresponding registers and their address are as follows:
> 
> name		cp15 reg [1] on -A/R	address on -M
> MIDR/CPUID  	CRm=c0, opc2=0  	0xe000ed00              
> PFR0   		CRm=c1, opc2=0  	0xe000ed40
> PFR1   		CRm=c1, opc2=1  	0xe000ed44
> DFR0   		CRm=c1, opc2=2  	0xe000ed48
> AFR0   		CRm=c1, opc2=3  	0xe000ed4c
> MMFR0  		CRm=c1, opc2=4  	0xe000ed50
> MMFR1  		CRm=c1, opc2=5  	0xe000ed54
> MMFR2  		CRm=c1, opc2=6  	0xe000ed58
> MMFR3  		CRm=c1, opc2=7  	0xe000ed5c
> ISAR0  		CRm=c2, opc2=0  	0xe000ed60
> ISAR1  		CRm=c2, opc2=1  	0xe000ed64
> ISAR2  		CRm=c2, opc2=2  	0xe000ed68
> ISAR3  		CRm=c2, opc2=3  	0xe000ed6c
> ISAR4  		CRm=c2, opc2=4  	0xe000ed70
> ISAR5  		CRm=c2, opc2=5  	0xe000ed74
> 
> But there is no nice translation and as cache handling is implementation
> defined on v7-M anyhow there is not much use and I decided to just
> return early in the cache function.
> 
> This patch is only compile tested as I don't have a machine with enough
> RAM to run a non-XIP kernel, so Tested-by tags are welcome.
> 
> Best regards
> Uwe
> 
> [1] all have in common: CRn=c0, opc1=0, so only CRm and opc2 are listed
> 
>  arch/arm/boot/compressed/head.S | 33 +++++++++++++++++++++++++++------
>  arch/arm/include/asm/unified.h  |  8 ++++++++
>  2 files changed, 35 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
> index 68be9017593d..3788eedabb15 100644
> --- a/arch/arm/boot/compressed/head.S
> +++ b/arch/arm/boot/compressed/head.S
> @@ -10,8 +10,11 @@
>   */
>  #include <linux/linkage.h>
>  #include <asm/assembler.h>
> +#include <asm/v7m.h>
> +
> + AR_CLASS(	.arch	armv7-a	)
> + M_CLASS(	.arch	armv7-m	)
>  
> -	.arch	armv7-a
>  /*
>   * Debugging stuff
>   *
> @@ -114,7 +117,12 @@
>   * sort out different calling conventions
>   */
>  		.align
> -		.arm				@ Always enter in ARM state
> +		/*
> +		 * Always enter in ARM state for CPUs that support the ARM ISA.
> +		 * As of today (2014) that's exactly the members of the A and R
> +		 * classes.
> +		 */
> + AR_CLASS(	.arm	)
>  start:
>  		.type	start,#function
>  		.rept	7
> @@ -132,14 +140,15 @@ start:
>  
>   THUMB(		.thumb			)
>  1:
> - ARM_BE8(	setend	be )			@ go BE8 if compiled for BE8
> -		mrs	r9, cpsr
> + ARM_BE8(	setend	be		)	@ go BE8 if compiled for BE8
> + AR_CLASS(	mrs	r9, cpsr	)
>  #ifdef CONFIG_ARM_VIRT_EXT
>  		bl	__hyp_stub_install	@ get into SVC mode, reversibly
>  #endif
>  		mov	r7, r1			@ save architecture ID
>  		mov	r8, r2			@ save atags pointer
>  
> +#ifndef CONFIG_CPU_V7M
>  		/*
>  		 * Booting from Angel - need to enter SVC mode and disable
>  		 * FIQs/IRQs (numeric definitions from angel arm.h source).
> @@ -155,6 +164,7 @@ not_angel:
>  		safe_svcmode_maskall r0
>  		msr	spsr_cxsf, r9		@ Save the CPU boot mode in
>  						@ SPSR
> +#endif
>  		/*
>  		 * Note that some cache flushing and other stuff may
>  		 * be needed here - is there an Angel SWI call for this?
> @@ -789,6 +799,16 @@ __common_mmu_cache_on:
>  call_cache_fn:	adr	r12, proc_types
>  #ifdef CONFIG_CPU_CP15
>  		mrc	p15, 0, r9, c0, c0	@ get processor ID
> +#elif defined(CONFIG_CPU_V7M)
> +		/*
> +		 * On v7-M the processor id is located in the V7M_SCB_CPUID
> +		 * register, but as cache handling is IMPLEMENTATION DEFINED on
> +		 * v7-M (if existant at all) we just return early here.
> +		 * If V7M_SCB_CPUID were used the cpu ID functions (i.e.
> +		 * __armv7_mmu_cache_{on,off,flush}) would be selected which
> +		 * use cp15 registers that are not implemented on v7-M.
> +		 */
> +		bx	lr
>  #else
>  		ldr	r9, =CONFIG_PROCESSOR_ID
>  #endif
> @@ -1289,8 +1309,9 @@ __hyp_reentry_vectors:
>  
>  __enter_kernel:
>  		mov	r0, #0			@ must be 0
> - ARM(		mov	pc, r4	)		@ call kernel
> - THUMB(		bx	r4	)		@ entry point is always ARM
> + ARM(		mov	pc, r4		)	@ call kernel
> + M_CLASS(	add	r4, r4, #1	)	@ enter in Thumb mode for M class
> + THUMB(		bx	r4		)	@ entry point is always ARM for A/R classes
>  
>  reloc_code_end:
>  
> diff --git a/arch/arm/include/asm/unified.h b/arch/arm/include/asm/unified.h
> index b88beaba6b4a..200f9a7cd623 100644
> --- a/arch/arm/include/asm/unified.h
> +++ b/arch/arm/include/asm/unified.h
> @@ -24,6 +24,14 @@
>  	.syntax unified
>  #endif
>  
> +#ifdef CONFIG_CPU_V7M
> +#define AR_CLASS(x...)
> +#define M_CLASS(x...)	x
> +#else
> +#define AR_CLASS(x...)	x
> +#define M_CLASS(x...)
> +#endif
> +
>  #ifdef CONFIG_THUMB2_KERNEL
>  
>  #if __GNUC__ < 4
> 
