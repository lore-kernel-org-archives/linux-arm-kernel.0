From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  4 Nov 2014 10:50:08 +0900
Subject: [PATCH 3/4] ARM: shmobile: rcar-gen2: Add CA7 arch_timer
 initialization for r8a7794
In-Reply-To: <cover.1415058939.git.horms+renesas@verge.net.au>
References: <cover.1415058939.git.horms+renesas@verge.net.au>
Message-ID: <9ce3fa6816c2fb59d128248c9b0509aef1c5dae7.1415058939.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

On E2, the arch timer is hooked up to a different clock, and the CA7's arch
timer CNTVOFF register must be initialized.

Based on work by Hisashi Nakamura.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-rcar-gen2.c | 72 ++++++++++++++++++++++----------
 1 file changed, 49 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-rcar-gen2.c b/arch/arm/mach-shmobile/setup-rcar-gen2.c
index 42d5b43..7ed9279 100644
--- a/arch/arm/mach-shmobile/setup-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/setup-rcar-gen2.c
@@ -3,6 +3,7 @@
  *
  * Copyright (C) 2013  Renesas Solutions Corp.
  * Copyright (C) 2013  Magnus Damm
+ * Copyright (C) 2014  Ulrich Hecht
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -24,6 +25,7 @@
 #include <linux/dma-contiguous.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/of.h>
 #include <linux/of_fdt.h>
 #include <asm/mach/arch.h>
 #include "common.h"
@@ -54,37 +56,61 @@ void __init rcar_gen2_timer_init(void)
 {
 #if defined(CONFIG_ARM_ARCH_TIMER) || defined(CONFIG_COMMON_CLK)
 	u32 mode = rcar_gen2_read_mode_pins();
+	bool is_e2 = (bool)of_find_compatible_node(NULL, NULL,
+		"renesas,r8a7794");
 #endif
 #ifdef CONFIG_ARM_ARCH_TIMER
 	void __iomem *base;
 	int extal_mhz = 0;
 	u32 freq;
 
-	/* At Linux boot time the r8a7790 arch timer comes up
-	 * with the counter disabled. Moreover, it may also report
-	 * a potentially incorrect fixed 13 MHz frequency. To be
-	 * correct these registers need to be updated to use the
-	 * frequency EXTAL / 2 which can be determined by the MD pins.
-	 */
-
-	switch (mode & (MD(14) | MD(13))) {
-	case 0:
-		extal_mhz = 15;
-		break;
-	case MD(13):
-		extal_mhz = 20;
-		break;
-	case MD(14):
-		extal_mhz = 26;
-		break;
-	case MD(13) | MD(14):
-		extal_mhz = 30;
-		break;
+	if (is_e2) {
+		freq = 260000000 / 8;	/* ZS / 8 */
+		/* CNTVOFF has to be initialized either from non-secure
+		 * Hypervisor mode or secure Monitor mode with SCR.NS==1.
+		 * If TrustZone is enabled then it should be handled by the
+		 * secure code.
+		 */
+		asm volatile(
+		"	cps	0x16\n"
+		"	mrc	p15, 0, r1, c1, c1, 0\n"
+		"	orr	r0, r1, #1\n"
+		"	mcr	p15, 0, r0, c1, c1, 0\n"
+		"	isb\n"
+		"	mov	r0, #0\n"
+		"	mcrr	p15, 4, r0, r0, c14\n"
+		"	isb\n"
+		"	mcr	p15, 0, r1, c1, c1, 0\n"
+		"	isb\n"
+		"	cps	0x13\n"
+			: : : "r0", "r1");
+	} else {
+		/* At Linux boot time the r8a7790 arch timer comes up
+		 * with the counter disabled. Moreover, it may also report
+		 * a potentially incorrect fixed 13 MHz frequency. To be
+		 * correct these registers need to be updated to use the
+		 * frequency EXTAL / 2 which can be determined by the MD pins.
+		 */
+
+		switch (mode & (MD(14) | MD(13))) {
+		case 0:
+			extal_mhz = 15;
+			break;
+		case MD(13):
+			extal_mhz = 20;
+			break;
+		case MD(14):
+			extal_mhz = 26;
+			break;
+		case MD(13) | MD(14):
+			extal_mhz = 30;
+			break;
+		}
+
+		/* The arch timer frequency equals EXTAL / 2 */
+		freq = extal_mhz * (1000000 / 2);
 	}
 
-	/* The arch timer frequency equals EXTAL / 2 */
-	freq = extal_mhz * (1000000 / 2);
-
 	/* Remap "armgcnt address map" space */
 	base = ioremap(0xe6080000, PAGE_SIZE);
 
-- 
2.1.1
