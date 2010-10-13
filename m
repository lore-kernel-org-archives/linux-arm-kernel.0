From: sbkim73@samsung.com (Sangbeom Kim)
Date: Wed, 13 Oct 2010 21:15:43 +0900
Subject: [PATCH 1/2] ARM: S5PV310: Add support SROMC
In-Reply-To: <1286972144-763-1-git-send-email-sbkim73@samsung.com>
References: <1286972144-763-1-git-send-email-sbkim73@samsung.com>
Message-ID: <1286972144-763-2-git-send-email-sbkim73@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Daein Moon <moon9124@samsung.com>

This patch adds support SROMC for S5PV310 and S5PC210.

Signed-off-by: Daein Moon <moon9124@samsung.com>
Signed-off-by: Sangbeom Kim <sbkim73@samsung.com>
---
 arch/arm/mach-s5pv310/cpu.c                    |    5 ++
 arch/arm/mach-s5pv310/include/mach/map.h       |    4 ++
 arch/arm/mach-s5pv310/include/mach/regs-srom.h |   50 ++++++++++++++++++++++++
 3 files changed, 59 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-s5pv310/include/mach/regs-srom.h

diff --git a/arch/arm/mach-s5pv310/cpu.c b/arch/arm/mach-s5pv310/cpu.c
index ffed262..873783a 100644
--- a/arch/arm/mach-s5pv310/cpu.c
+++ b/arch/arm/mach-s5pv310/cpu.c
@@ -81,6 +81,11 @@ static struct map_desc s5pv310_iodesc[] __initdata = {
 		.pfn		= __phys_to_pfn(S3C_PA_UART),
 		.length		= SZ_512K,
 		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)S5P_VA_SROMC,
+		.pfn		= __phys_to_pfn(S5PV310_PA_SROMC),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE,
 	},
 };
 
diff --git a/arch/arm/mach-s5pv310/include/mach/map.h b/arch/arm/mach-s5pv310/include/mach/map.h
index 1429510..37294f1 100644
--- a/arch/arm/mach-s5pv310/include/mach/map.h
+++ b/arch/arm/mach-s5pv310/include/mach/map.h
@@ -25,6 +25,8 @@
 
 #define S5PV310_PA_SYSRAM		(0x02025000)
 
+#define S5PV310_PA_SROM_BANK(x)		(0x04000000 + ((x) * 0x01000000))
+
 #define S5PC210_PA_ONENAND		(0x0C000000)
 #define S5P_PA_ONENAND			S5PC210_PA_ONENAND
 
@@ -58,6 +60,8 @@
 
 #define S5PV310_PA_HSMMC(x)		(0x12510000 + ((x) * 0x10000))
 
+#define S5PV310_PA_SROMC		(0x12570000)
+
 #define S5PV310_PA_UART			(0x13800000)
 
 #define S5P_PA_UART(x)			(S5PV310_PA_UART + ((x) * S3C_UART_OFFSET))
diff --git a/arch/arm/mach-s5pv310/include/mach/regs-srom.h b/arch/arm/mach-s5pv310/include/mach/regs-srom.h
new file mode 100644
index 0000000..1898b3e
--- /dev/null
+++ b/arch/arm/mach-s5pv310/include/mach/regs-srom.h
@@ -0,0 +1,50 @@
+/* linux/arch/arm/mach-s5pv310/include/mach/regs-srom.h
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * S5PV310 - SROMC register definitions
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_ARCH_REGS_SROM_H
+#define __ASM_ARCH_REGS_SROM_H __FILE__
+
+#include <mach/map.h>
+
+#define S5PV310_SROMREG(x)	(S5P_VA_SROMC + (x))
+
+#define S5PV310_SROM_BW		S5PV310_SROMREG(0x0)
+#define S5PV310_SROM_BC0	S5PV310_SROMREG(0x4)
+#define S5PV310_SROM_BC1	S5PV310_SROMREG(0x8)
+#define S5PV310_SROM_BC2	S5PV310_SROMREG(0xc)
+#define S5PV310_SROM_BC3	S5PV310_SROMREG(0x10)
+
+/* one register BW holds 4 x 4-bit packed settings for NCS0 - NCS3 */
+
+#define S5PV310_SROM_BW__DATAWIDTH__SHIFT	0
+#define S5PV310_SROM_BW__ADDRMODE__SHIFT	1
+#define S5PV310_SROM_BW__WAITENABLE__SHIFT	2
+#define S5PV310_SROM_BW__BYTEENABLE__SHIFT	3
+
+#define S5PV310_SROM_BW__CS_MASK		0xf
+
+#define S5PV310_SROM_BW__NCS0__SHIFT		0
+#define S5PV310_SROM_BW__NCS1__SHIFT		4
+#define S5PV310_SROM_BW__NCS2__SHIFT		8
+#define S5PV310_SROM_BW__NCS3__SHIFT		12
+
+/* applies to same to BCS0 - BCS3 */
+
+#define S5PV310_SROM_BCX__PMC__SHIFT		0
+#define S5PV310_SROM_BCX__TACP__SHIFT		4
+#define S5PV310_SROM_BCX__TCAH__SHIFT		8
+#define S5PV310_SROM_BCX__TCOH__SHIFT		12
+#define S5PV310_SROM_BCX__TACC__SHIFT		16
+#define S5PV310_SROM_BCX__TCOS__SHIFT		24
+#define S5PV310_SROM_BCX__TACS__SHIFT		28
+
+#endif /* __ASM_ARCH_REGS_SROM_H */
-- 
1.6.2.5
