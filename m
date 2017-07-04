From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Wed,  5 Jul 2017 01:32:18 +0200
Subject: [PATCH] ARM: owl: smp: Drop owl_secondary_boot()
In-Reply-To: <DC4E6E803E914F4B8AFE57F1456019F10364478E@srv-mail-02.actions.com.cn>
References: <DC4E6E803E914F4B8AFE57F1456019F10364478E@srv-mail-02.actions.com.cn>
Message-ID: <20170704233219.18790-1-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 18cfd9429d8a82c49add8f3ca9d366599bfcac45 ("ARM: owl: smp: Drop
bogus holding pen") simplified the S500 SMP code by removing a loop for
pen_release in owl_secondary_boot(). Since then it is only calling
owl_v7_invalidate_l1() before branching to secondary_startup().

The owl_v7_invalidate_l1() assembler function is superfluous, too.
Therefore drop owl_secondary_boot() and use secondary_boot() directly.

Cc: David Liu <liuwei@actions-semi.com>
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 arch/arm/mach-actions/Makefile  |  4 +---
 arch/arm/mach-actions/headsmp.S | 52 -----------------------------------------
 arch/arm/mach-actions/platsmp.c |  2 +-
 3 files changed, 2 insertions(+), 56 deletions(-)
 delete mode 100644 arch/arm/mach-actions/headsmp.S

diff --git a/arch/arm/mach-actions/Makefile b/arch/arm/mach-actions/Makefile
index c0f116241da7..13831037d8cd 100644
--- a/arch/arm/mach-actions/Makefile
+++ b/arch/arm/mach-actions/Makefile
@@ -1,3 +1 @@
-obj-${CONFIG_SMP} += platsmp.o headsmp.o
-
-AFLAGS_headsmp.o := -Wa,-march=armv7-a
+obj-${CONFIG_SMP} += platsmp.o
diff --git a/arch/arm/mach-actions/headsmp.S b/arch/arm/mach-actions/headsmp.S
deleted file mode 100644
index 65f53bdb69e7..000000000000
--- a/arch/arm/mach-actions/headsmp.S
+++ /dev/null
@@ -1,52 +0,0 @@
-/*
- * Copyright 2012 Actions Semi Inc.
- * Author: Actions Semi, Inc.
- *
- * Copyright (c) 2017 Andreas F?rber
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
-
-#include <linux/linkage.h>
-#include <linux/init.h>
-
-ENTRY(owl_v7_invalidate_l1)
-	mov	r0, #0
-	mcr	p15, 0, r0, c7, c5, 0	@ invalidate I cache
-	mcr	p15, 2, r0, c0, c0, 0
-	mrc	p15, 1, r0, c0, c0, 0
-
-	ldr	r1, =0x7fff
-	and	r2, r1, r0, lsr #13
-
-	ldr	r1, =0x3ff
-
-	and	r3, r1, r0, lsr #3	@ NumWays - 1
-	add	r2, r2, #1		@ NumSets
-
-	and	r0, r0, #0x7
-	add	r0, r0, #4	@ SetShift
-
-	clz	r1, r3		@ WayShift
-	add	r4, r3, #1	@ NumWays
-1:	sub	r2, r2, #1	@ NumSets--
-	mov	r3, r4		@ Temp = NumWays
-2:	subs	r3, r3, #1	@ Temp--
-	mov	r5, r3, lsl r1
-	mov	r6, r2, lsl r0
-	orr	r5, r5, r6	@ Reg = (Temp<<WayShift)|(NumSets<<SetShift)
-	mcr	p15, 0, r5, c7, c6, 2
-	bgt	2b
-	cmp	r2, #0
-	bgt	1b
-	dsb
-	isb
-	mov	pc, lr
-ENDPROC(owl_v7_invalidate_l1)
-
-ENTRY(owl_secondary_startup)
-	bl	owl_v7_invalidate_l1
-	b	secondary_startup
diff --git a/arch/arm/mach-actions/platsmp.c b/arch/arm/mach-actions/platsmp.c
index 12a9e331b432..506ba32f235d 100644
--- a/arch/arm/mach-actions/platsmp.c
+++ b/arch/arm/mach-actions/platsmp.c
@@ -71,7 +71,7 @@ static int s500_wakeup_secondary(unsigned int cpu)
 	/* wait for CPUx to run to WFE instruction */
 	udelay(200);
 
-	writel(virt_to_phys(owl_secondary_startup),
+	writel(virt_to_phys(secondary_startup),
 	       timer_base_addr + OWL_CPU1_ADDR + (cpu - 1) * 4);
 	writel(OWL_CPUx_FLAG_BOOT,
 	       timer_base_addr + OWL_CPU1_FLAG + (cpu - 1) * 4);
-- 
2.12.3
