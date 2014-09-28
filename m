From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sun, 28 Sep 2014 12:18:46 +0200
Subject: [PATCH v4] ARM: zImage: add support for ARMv7-M
In-Reply-To: <1411817149-5135-1-git-send-email-manabian@gmail.com>
References: <1411057343-20861-1-git-send-email-manabian@gmail.com>
 <1411817149-5135-1-git-send-email-manabian@gmail.com>
Message-ID: <20140928101846.GE31554@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Joachim,

On Sat, Sep 27, 2014 at 01:25:49PM +0200, Joachim Eastwood wrote:
> This patch makes it possible to enter zImage in Thumb mode for ARMv7M
The official spelling is ARMv7-M.

> (Cortex-M) CPUs that does not support ARM mode. The kernel entry is
> also made in Thumb mode.
> 
> Signed-off-by: Joachim Eastwood <manabian@gmail.com>
> ---
> Hi,
> 
> Updated patch with comments from Uwe Kleine-K?nig.
> 
> Changes
> v4: Preserve r1/r2. Add comment about class A/R.
> v3: Use defines for ARMv7M CPU registers.
> v2: Introduce AR_CLASS/M_CLASS macros. This reduces the amount
>     of ifdefs needed in compressed/head.S.
> 
> Successfully tested on NXP LPC4357 (Cortex-M4).
> 
> regards,
> Joachim Eastwood
> 
>  arch/arm/boot/compressed/head.S | 28 ++++++++++++++++++++++------
>  arch/arm/include/asm/unified.h  |  8 ++++++++
>  2 files changed, 30 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
> index 413fd94b5301..0afcbb1e1d7d 100644
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
> @@ -790,6 +800,9 @@ __common_mmu_cache_on:
>  call_cache_fn:	adr	r12, proc_types
>  #ifdef CONFIG_CPU_CP15
>  		mrc	p15, 0, r9, c0, c0	@ get processor ID
> +#elif defined(CONFIG_CPU_V7M)
> +		ldr	r9, =BASEADDR_V7M_SCB
> +		ldr	r9, [r9, V7M_SCB_CPUID]
>  #else
>  		ldr	r9, =CONFIG_PROCESSOR_ID
>  #endif
> @@ -945,11 +958,13 @@ proc_types:
>  		W(b)	__armv4_mmu_cache_off
>  		W(b)	__armv6_mmu_cache_flush
>  
> +#ifndef CONFIG_CPU_V7M
>  		.word	0x000f0000		@ new CPU Id
>  		.word	0x000f0000
>  		W(b)	__armv7_mmu_cache_on
>  		W(b)	__armv7_mmu_cache_off
>  		W(b)	__armv7_mmu_cache_flush
> +#endif
this #ifndef is needed because it is matched for V7-M CPU, but
__armv7_mmu_cache_\* is wrong for these, right?

So I suggest adding a comment here, something like:

		/*
		 * v7-M CPUs match this entry, but the cache handling is
		 * different to v7-A and v7-R. So this entry has to be
		 * skipped for v7-M builds.
		 */

Alternatives are:
 - Find a way to differentiate the AR and M classes.
   I think you cannot by just looking at the CPU ID value, so the
   selection of the right functions would need to become more
   (compl|sophist)icated.
 - As there is no v7-M cache architecurally defined, return early in the
   #elif branch above (line 803).

I think the first option isn't practicable. The second is IMHO a nice
alternative.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
