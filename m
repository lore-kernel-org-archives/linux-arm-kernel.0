From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 23 Sep 2014 21:32:51 +0200
Subject: [PATCH v3] ARM: zImage: add support for ARMv7-M
In-Reply-To: <1411494565-29534-1-git-send-email-manabian@gmail.com>
References: <1411057343-20861-1-git-send-email-manabian@gmail.com>
 <1411494565-29534-1-git-send-email-manabian@gmail.com>
Message-ID: <20140923193251.GB3755@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Joachim,

On Tue, Sep 23, 2014 at 07:49:25PM +0200, Joachim Eastwood wrote:
> This patch makes it possible to enter zImage in Thumb mode for ARMv7M
> (Cortex-M) CPUs that does not support ARM mode. The kernel entry is
> also made in Thumb mode.
> 
> Signed-off-by: Joachim Eastwood <manabian@gmail.com>
> ---
> Hi,
> 
> Updated patch per comments from Catalin Marinas.
> 
> Changes
> v3: Use defines for ARMv7M CPU registers.
> v2: Introduce AR_CLASS/M_CLASS macros. This reduces the amount 
>     of ifdefs needed in compressed/head.S.
> 
> Successfully tested on NXP LPC4357 (Cortex-M4).
> 
>  arch/arm/boot/compressed/head.S | 19 +++++++++++++++----
>  arch/arm/include/asm/unified.h  |  8 ++++++++
>  2 files changed, 23 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
> index 413fd94b5301..cd27090625fe 100644
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
> @@ -114,7 +117,7 @@
>   * sort out different calling conventions
>   */
>  		.align
> -		.arm				@ Always enter in ARM state
> + AR_CLASS(	.arm	)		@ Always enter in ARM state for A/R classes
Semantically we don't want .arm when CPU_THUMBONLY is enabled. At least
currently this is equivalent with !AR_CLASS. Maybe this is worth to be
pointed out in a comment?

>  start:
>  		.type	start,#function
>  		.rept	7
> @@ -133,6 +136,7 @@ start:
>   THUMB(		.thumb			)
>  1:
>   ARM_BE8(	setend	be )			@ go BE8 if compiled for BE8
> +#ifndef CONFIG_CPU_V7M
>  		mrs	r9, cpsr
>  #ifdef CONFIG_ARM_VIRT_EXT
>  		bl	__hyp_stub_install	@ get into SVC mode, reversibly
I think you need to be more precious here. The following is #ifdef'd
out:
   #endif
   		mov	r7, r1			@ save architecture ID
   		mov	r8, r2			@ save atags pointer
   
   		/*
   		 * Booting from Angel - need to enter SVC mode and disable
		 * FIQs/IRQs (numeric definitions from angel arm.h source).
		 * We only do this if we were in user mode on entry.
		 */
		mrs	r2, cpsr		@ get current mode
		tst	r2, #3			@ not user?
		bne	not_angel
		mov	r0, #0x17		@ angel_SWIreason_EnterSVC
    ARM(	swi	0x123456	)	@ angel_SWI_ARM
    THUMB(	svc	0xab		)	@ angel_SWI_THUMB
   not_angel:
> @@ -155,6 +159,7 @@ not_angel:
>  		safe_svcmode_maskall r0
>  		msr	spsr_cxsf, r9		@ Save the CPU boot mode in
>  						@ SPSR
> +#endif

At least saving r1 and r2 should be preserved, shouldn't it? I wonder
how this could result in a working kernel because r7 and r8 are passed
to Image which are not initialized with your patch.

Unrelated to Joachim's patch I wonder why we have "mrs	rX, cpsr" twice
here.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
