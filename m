From: eric@eukrea.com (=?UTF-8?q?Eric=20B=C3=A9nard?=)
Date: Tue,  5 Oct 2010 11:25:39 +0200
Subject: [PATCH/RFC] i.MX31 and i.MX35 : fix errate TLSbo65953 and ENGcm09472
In-Reply-To: <4CAAD39C.2010103@eukrea.com>
References: <4CAAD39C.2010103@eukrea.com>
Message-ID: <1286270739-18270-1-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without this exiting WFI can result in cache corruption.
Code taken from Freescale's 2.6.27 BSP and tested on i.MX35

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
 arch/arm/plat-mxc/include/mach/system.h |   26 ++++++++++++++++++++++++--
 1 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/system.h b/arch/arm/plat-mxc/include/mach/system.h
index 4acd114..1661b29 100644
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
@@ -22,14 +22,36 @@
 
 static inline void arch_idle(void)
 {
+#if (defined (CONFIG_ARCH_MX35) || defined (CONFIG_ARCH_MX31))
+	/* fix i.MX31 errata TLSbo65953 and i.MX35 errata ENGcm09472 */
+	unsigned long reg = 0;
+	__asm__ __volatile__(
+		"mrc p15, 0, %0, c1, c0, 0\n"
+		"bic %0, %0, #0x00001000\n"
+		"bic %0, %0, #0x00000004\n"
+		"mcr p15, 0, %0, c1, c0, 0\n"
+		"mov %0, #0\n"
+		"mcr p15, 0, %0, c7, c5, 0\n"
+		"mov %0, #0\n"
+		"mcr p15, 0, %0, c7, c14, 0\n"
+		"mov %0, #0\n"
+		"mcr p15, 0, %0, c7, c0, 4\n"
+		"nop\n" "nop\n" "nop\n" "nop\n"
+		"nop\n" "nop\n" "nop\n"
+		"mrc p15, 0, %0, c1, c0, 0\n"
+		"orr %0, %0, #0x00001000\n"
+		"orr %0, %0, #0x00000004\n"
+		"mcr p15, 0, %0, c1, c0, 0\n"
+		:: "r" (reg));
+#else
 #ifdef CONFIG_ARCH_MXC91231
 	if (cpu_is_mxc91231()) {
 		/* Need this to set DSM low-power mode */
 		mxc91231_prepare_idle();
 	}
 #endif
-
 	cpu_do_idle();
+#endif
 }
 
 void arch_reset(char mode, const char *cmd);
-- 
1.7.0.4
