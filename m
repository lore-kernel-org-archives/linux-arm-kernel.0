From: eric@eukrea.com (=?UTF-8?q?Eric=20B=C3=A9nard?=)
Date: Tue,  5 Oct 2010 14:00:12 +0200
Subject: [PATCH v2] i.MX31 and i.MX35 : fix errate TLSbo65953 and ENGcm09472
In-Reply-To: <20101005094510.GJ28242@pengutronix.de>
References: <20101005094510.GJ28242@pengutronix.de>
Message-ID: <1286280012-19809-1-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without this exiting WFI can result in cache corruption.
Code taken from Freescale's 2.6.27 BSP and tested on i.MX35

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
v2 : use cpu_ismx3x() and add comments.

 arch/arm/plat-mxc/include/mach/system.h |   32 ++++++++++++++++++++++++++++--
 1 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/system.h b/arch/arm/plat-mxc/include/mach/system.h
index 4acd114..70e66d3 100644
--- a/arch/arm/plat-mxc/include/mach/system.h
+++ b/arch/arm/plat-mxc/include/mach/system.h
@@ -1,7 +1,7 @@
 /*
  *  Copyright (C) 1999 ARM Limited
  *  Copyright (C) 2000 Deep Blue Solutions Ltd
- *  Copyright 2004-2007 Freescale Semiconductor, Inc. All Rights Reserved.
+ *  Copyright 2004-2008 Freescale Semiconductor, Inc. All Rights Reserved.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -28,8 +28,34 @@ static inline void arch_idle(void)
 		mxc91231_prepare_idle();
 	}
 #endif
-
-	cpu_do_idle();
+	/* fix i.MX31 errata TLSbo65953 and i.MX35 errata ENGcm09472 */
+	if (cpu_is_mx31() || cpu_is_mx35()) {
+		unsigned long reg = 0;
+		__asm__ __volatile__(
+			/* disable I and D cache */
+			"mrc p15, 0, %0, c1, c0, 0\n"
+			"bic %0, %0, #0x00001000\n"
+			"bic %0, %0, #0x00000004\n"
+			"mcr p15, 0, %0, c1, c0, 0\n"
+			/* invalidate I cache */
+			"mov %0, #0\n"
+			"mcr p15, 0, %0, c7, c5, 0\n"
+			/* clear and invalidate D cache */
+			"mov %0, #0\n"
+			"mcr p15, 0, %0, c7, c14, 0\n"
+			/* WFI */
+			"mov %0, #0\n"
+			"mcr p15, 0, %0, c7, c0, 4\n"
+			"nop\n" "nop\n" "nop\n" "nop\n"
+			"nop\n" "nop\n" "nop\n"
+			/* enable I and D cache */
+			"mrc p15, 0, %0, c1, c0, 0\n"
+			"orr %0, %0, #0x00001000\n"
+			"orr %0, %0, #0x00000004\n"
+			"mcr p15, 0, %0, c1, c0, 0\n"
+			:: "r" (reg));
+	} else
+		cpu_do_idle();
 }
 
 void arch_reset(char mode, const char *cmd);
-- 
1.7.0.4
