From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 17 Sep 2014 08:11:10 +0200
Subject: Cortex-M and zImage
In-Reply-To: <CAGhQ9VzzSq4P5BKM3UBBCPT61g3T1RHFhttfA-KkWGCcrjaW6A@mail.gmail.com>
References: <CAGhQ9VzzSq4P5BKM3UBBCPT61g3T1RHFhttfA-KkWGCcrjaW6A@mail.gmail.com>
Message-ID: <20140917061110.GM3755@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Joachim,

On Tue, Sep 16, 2014 at 10:25:02PM +0200, Joachim Eastwood wrote:
> I am working on Linux support for the NXP LPC18xx/43xx family of
> Cortex-M3/M4 microcontrollers. Building zImage for Cortex-M fails
> with the following two errors:
> error: arch/arm/boot/compressed/piggy.gzip.o: Conflicting architecture
> profiles M/A
> linux/arch/arm/boot/compressed/head.S:794: undefined reference to
> `CONFIG_PROCESSOR_ID'
> 
> The last error is easy to fix. But the first about conflicting arch is
> harder.
Do you send a patch?

I was able to compile a zImage with the patch below. For the
"Conflicting architecture profiles" error the most relevant hunk is the
first. And of course this needs some #ifdefs.

Best regards
Uwe

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 413fd94b5301..abad996484f1 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -11,7 +11,7 @@
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 
-	.arch	armv7-a
+	.arch	armv7-m
 /*
  * Debugging stuff
  *
@@ -114,7 +114,7 @@
  * sort out different calling conventions
  */
 		.align
-		.arm				@ Always enter in ARM state
+		@.arm				@ Always enter in ARM state
 start:
 		.type	start,#function
 		.rept	7
@@ -133,7 +133,7 @@ start:
  THUMB(		.thumb			)
 1:
  ARM_BE8(	setend	be )			@ go BE8 if compiled for BE8
-		mrs	r9, cpsr
+		@mrs	r9, cpsr
 #ifdef CONFIG_ARM_VIRT_EXT
 		bl	__hyp_stub_install	@ get into SVC mode, reversibly
 #endif
@@ -145,7 +145,7 @@ start:
 		 * FIQs/IRQs (numeric definitions from angel arm.h source).
 		 * We only do this if we were in user mode on entry.
 		 */
-		mrs	r2, cpsr		@ get current mode
+		@mrs	r2, cpsr		@ get current mode
 		tst	r2, #3			@ not user?
 		bne	not_angel
 		mov	r0, #0x17		@ angel_SWIreason_EnterSVC
@@ -153,7 +153,7 @@ start:
  THUMB(		svc	0xab		)	@ angel_SWI_THUMB
 not_angel:
 		safe_svcmode_maskall r0
-		msr	spsr_cxsf, r9		@ Save the CPU boot mode in
+		@msr	spsr_cxsf, r9		@ Save the CPU boot mode in
 						@ SPSR
 		/*
 		 * Note that some cache flushing and other stuff may
@@ -366,7 +366,7 @@ dtb_check_done:
 
 /* Relocate the hyp vector base if necessary */
 #ifdef CONFIG_ARM_VIRT_EXT
-		mrs	r0, spsr
+		@mrs	r0, spsr
 		and	r0, r0, #MODE_MASK
 		cmp	r0, #HYP_MODE
 		bne	1f
@@ -500,7 +500,7 @@ not_relocated:	mov	r0, #0
 		mov	r2, r8			@ restore atags pointer
 
 #ifdef CONFIG_ARM_VIRT_EXT
-		mrs	r0, spsr		@ Get saved CPU boot mode
+		@mrs	r0, spsr		@ Get saved CPU boot mode
 		and	r0, r0, #MODE_MASK
 		cmp	r0, #HYP_MODE		@ if not booted in HYP mode...
 		bne	__enter_kernel		@ boot kernel directly
@@ -791,7 +791,7 @@ call_cache_fn:	adr	r12, proc_types
 #ifdef CONFIG_CPU_CP15
 		mrc	p15, 0, r9, c0, c0	@ get processor ID
 #else
-		ldr	r9, =CONFIG_PROCESSOR_ID
+		@ldr	r9, =CONFIG_PROCESSOR_ID
 #endif
 1:		ldr	r1, [r12, #0]		@ get value
 		ldr	r2, [r12, #4]		@ get mask

> As far as I know zImage on Cortex-M is not supported or not tested.
> 
> Are there any plans to support zImage on Cortex-M?
> If so does anyone have an idea how the conflicting arch issue could
> be solved?
> 
> btw, building with 'make Image' works fine and I have been running
> Linux for a while on the NXP LPC4357.

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
