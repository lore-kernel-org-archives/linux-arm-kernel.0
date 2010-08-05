From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 5 Aug 2010 16:42:04 +0200
Subject: thumb2 user binaries with v6/v7 combined kernel
Message-ID: <201008051642.04950.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I've been trying to run a multi-CPU kernel for armv6 and armv7
and noticed that thumb2 binaries sometimes crash with SIGILL.

The only problem appears to be that when __LINUX_ARM_ARCH__
is set to 6, the kernel does not correctly decode some instructions.
The patch below illustrates the problem, if I apply that, I'm
able to run all my thumb2 user space code. Unfortunately,
I can't use the ldrht instruction there, because the kernel
is built with -march=armv6. The patch breaks the exception
handling, and I couldn't figure out how to fix that.

The code in question was originally introduced by Paul Brook,
in order to support thumb2 user space on armv7-only kernels.

Any suggestions?

	Arnd

--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -499,15 +499,15 @@ __und_usr:
 #endif
 	beq	call_fpe
 	@ Thumb instruction
-#if __LINUX_ARM_ARCH__ >= 7
+#ifdef CONFIG_CPU_V7
 2:
- ARM(	ldrht	r5, [r4], #2	)
- THUMB(	ldrht	r5, [r4]	)
+ ARM(	ldrh	r5, [r4], #2	)
+ THUMB(	ldrh	r5, [r4]	)
  THUMB(	add	r4, r4, #2	)
 	and	r0, r5, #0xf800			@ mask bits 111x x... .... ....
 	cmp	r0, #0xe800			@ 32bit instruction if xx != 0
 	blo	__und_usr_unknown
-3:	ldrht	r0, [r4]
+3:	ldrh	r0, [r4]
 	add	r2, r2, #2			@ r2 is PC + 2, make it PC + 4
 	orr	r0, r0, r5, lsl #16
 #else
@@ -528,7 +528,7 @@ ENDPROC(__und_usr)
 	.popsection
 	.pushsection __ex_table,"a"
 	.long	1b, 4b
-#if __LINUX_ARM_ARCH__ >= 7
+#ifdef CONFIG_CPU_V7
 	.long	2b, 4b
 	.long	3b, 4b
 #endif
