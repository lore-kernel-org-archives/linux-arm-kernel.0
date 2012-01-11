From: rmallon@gmail.com (Ryan Mallon)
Date: Wed, 11 Jan 2012 14:14:26 +1100
Subject: [PATCH 01/11] ep93xx: Move PHYS_BASE defines to local SoC header file
In-Reply-To: <1326251676-7593-1-git-send-email-rmallon@gmail.com>
References: <1326251676-7593-1-git-send-email-rmallon@gmail.com>
Message-ID: <1326251676-7593-2-git-send-email-rmallon@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PHYS_BASE defines in arch/arm/mach-ep93xx/include/mach-ep93xx-regs.h are
only used in the SoC code. Move the defines to a local header file.

Cc: Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Mika Westerberg <mika.westerberg@iki.fi>
Signed-off-by: Ryan Mallon <rmallon@gmail.com>
---
 arch/arm/mach-ep93xx/adssphere.c                |    1 +
 arch/arm/mach-ep93xx/edb93xx.c                  |    2 +
 arch/arm/mach-ep93xx/gesbc9312.c                |    1 +
 arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h |   34 ---------------
 arch/arm/mach-ep93xx/micro9.c                   |    1 +
 arch/arm/mach-ep93xx/simone.c                   |    2 +
 arch/arm/mach-ep93xx/snappercl15.c              |    2 +
 arch/arm/mach-ep93xx/soc.h                      |   50 +++++++++++++++++++++++
 arch/arm/mach-ep93xx/ts72xx.c                   |    2 +
 arch/arm/mach-ep93xx/vision_ep9307.c            |    2 +
 10 files changed, 63 insertions(+), 34 deletions(-)
 create mode 100644 arch/arm/mach-ep93xx/soc.h

diff --git a/arch/arm/mach-ep93xx/adssphere.c b/arch/arm/mach-ep93xx/adssphere.c
index 0713448..4e0a776 100644
--- a/arch/arm/mach-ep93xx/adssphere.c
+++ b/arch/arm/mach-ep93xx/adssphere.c
@@ -19,6 +19,7 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
+#include "soc.h"
 
 static struct ep93xx_eth_data __initdata adssphere_eth_data = {
 	.phy_id		= 1,
diff --git a/arch/arm/mach-ep93xx/edb93xx.c b/arch/arm/mach-ep93xx/edb93xx.c
index 70ef8c5..24df3ff 100644
--- a/arch/arm/mach-ep93xx/edb93xx.c
+++ b/arch/arm/mach-ep93xx/edb93xx.c
@@ -42,6 +42,8 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
+#include "soc.h"
+
 
 static void __init edb93xx_register_flash(void)
 {
diff --git a/arch/arm/mach-ep93xx/gesbc9312.c b/arch/arm/mach-ep93xx/gesbc9312.c
index 45ee205..86d36da 100644
--- a/arch/arm/mach-ep93xx/gesbc9312.c
+++ b/arch/arm/mach-ep93xx/gesbc9312.c
@@ -19,6 +19,7 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
+#include "soc.h"
 
 static struct ep93xx_eth_data __initdata gesbc9312_eth_data = {
 	.phy_id		= 1,
diff --git a/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h b/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
index c4a7b84..b029305 100644
--- a/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
+++ b/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
@@ -6,40 +6,6 @@
 #define __ASM_ARCH_EP93XX_REGS_H
 
 /*
- * EP93xx Physical Memory Map:
- *
- * The ASDO pin is sampled at system reset to select a synchronous or
- * asynchronous boot configuration.  When ASDO is "1" (i.e. pulled-up)
- * the synchronous boot mode is selected.  When ASDO is "0" (i.e
- * pulled-down) the asynchronous boot mode is selected.
- *
- * In synchronous boot mode nSDCE3 is decoded starting at physical address
- * 0x00000000 and nCS0 is decoded starting at 0xf0000000.  For asynchronous
- * boot mode they are swapped with nCS0 decoded at 0x00000000 ann nSDCE3
- * decoded at 0xf0000000.
- *
- * There is known errata for the EP93xx dealing with External Memory
- * Configurations.  Please refer to "AN273: EP93xx Silicon Rev E Design
- * Guidelines" for more information.  This document can be found at:
- *
- *	http://www.cirrus.com/en/pubs/appNote/AN273REV4.pdf
- */
-
-#define EP93XX_CS0_PHYS_BASE_ASYNC	0x00000000	/* ASDO Pin = 0 */
-#define EP93XX_SDCE3_PHYS_BASE_SYNC	0x00000000	/* ASDO Pin = 1 */
-#define EP93XX_CS1_PHYS_BASE		0x10000000
-#define EP93XX_CS2_PHYS_BASE		0x20000000
-#define EP93XX_CS3_PHYS_BASE		0x30000000
-#define EP93XX_PCMCIA_PHYS_BASE		0x40000000
-#define EP93XX_CS6_PHYS_BASE		0x60000000
-#define EP93XX_CS7_PHYS_BASE		0x70000000
-#define EP93XX_SDCE0_PHYS_BASE		0xc0000000
-#define EP93XX_SDCE1_PHYS_BASE		0xd0000000
-#define EP93XX_SDCE2_PHYS_BASE		0xe0000000
-#define EP93XX_SDCE3_PHYS_BASE_ASYNC	0xf0000000	/* ASDO Pin = 0 */
-#define EP93XX_CS0_PHYS_BASE_SYNC	0xf0000000	/* ASDO Pin = 1 */
-
-/*
  * EP93xx linux memory map:
  *
  * virt		phys		size
diff --git a/arch/arm/mach-ep93xx/micro9.c b/arch/arm/mach-ep93xx/micro9.c
index e72f736..858c8ec 100644
--- a/arch/arm/mach-ep93xx/micro9.c
+++ b/arch/arm/mach-ep93xx/micro9.c
@@ -21,6 +21,7 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
+#include "soc.h"
 
 /*************************************************************************
  * Micro9 NOR Flash
diff --git a/arch/arm/mach-ep93xx/simone.c b/arch/arm/mach-ep93xx/simone.c
index 52e090d..e1ea38e 100644
--- a/arch/arm/mach-ep93xx/simone.c
+++ b/arch/arm/mach-ep93xx/simone.c
@@ -28,6 +28,8 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
+#include "soc.h"
+
 static struct ep93xx_eth_data __initdata simone_eth_data = {
 	.phy_id		= 1,
 };
diff --git a/arch/arm/mach-ep93xx/snappercl15.c b/arch/arm/mach-ep93xx/snappercl15.c
index 8121e3a..a23c6db 100644
--- a/arch/arm/mach-ep93xx/snappercl15.c
+++ b/arch/arm/mach-ep93xx/snappercl15.c
@@ -34,6 +34,8 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
+#include "soc.h"
+
 #define SNAPPERCL15_NAND_BASE	(EP93XX_CS7_PHYS_BASE + SZ_16M)
 
 #define SNAPPERCL15_NAND_WPN	(1 << 8)  /* Write protect (active low) */
diff --git a/arch/arm/mach-ep93xx/soc.h b/arch/arm/mach-ep93xx/soc.h
new file mode 100644
index 0000000..74703e7
--- /dev/null
+++ b/arch/arm/mach-ep93xx/soc.h
@@ -0,0 +1,50 @@
+/*
+ * arch/arm/mach-ep93xx/soc.h
+ *
+ * Copyright (C) 2012 Open Kernel Labs <www.ok-labs.com>
+ * Copyright (C) 2012 Ryan Mallon <rmallon@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or (at
+ * your option) any later version.
+ */
+
+#ifndef _EP93XX_SOC_H
+#define _EP93XX_SOC_H
+
+/*
+ * EP93xx Physical Memory Map:
+ *
+ * The ASDO pin is sampled at system reset to select a synchronous or
+ * asynchronous boot configuration.  When ASDO is "1" (i.e. pulled-up)
+ * the synchronous boot mode is selected.  When ASDO is "0" (i.e
+ * pulled-down) the asynchronous boot mode is selected.
+ *
+ * In synchronous boot mode nSDCE3 is decoded starting at physical address
+ * 0x00000000 and nCS0 is decoded starting at 0xf0000000.  For asynchronous
+ * boot mode they are swapped with nCS0 decoded at 0x00000000 ann nSDCE3
+ * decoded at 0xf0000000.
+ *
+ * There is known errata for the EP93xx dealing with External Memory
+ * Configurations.  Please refer to "AN273: EP93xx Silicon Rev E Design
+ * Guidelines" for more information.  This document can be found at:
+ *
+ *	http://www.cirrus.com/en/pubs/appNote/AN273REV4.pdf
+ */
+
+#define EP93XX_CS0_PHYS_BASE_ASYNC	0x00000000	/* ASDO Pin = 0 */
+#define EP93XX_SDCE3_PHYS_BASE_SYNC	0x00000000	/* ASDO Pin = 1 */
+#define EP93XX_CS1_PHYS_BASE		0x10000000
+#define EP93XX_CS2_PHYS_BASE		0x20000000
+#define EP93XX_CS3_PHYS_BASE		0x30000000
+#define EP93XX_PCMCIA_PHYS_BASE		0x40000000
+#define EP93XX_CS6_PHYS_BASE		0x60000000
+#define EP93XX_CS7_PHYS_BASE		0x70000000
+#define EP93XX_SDCE0_PHYS_BASE		0xc0000000
+#define EP93XX_SDCE1_PHYS_BASE		0xd0000000
+#define EP93XX_SDCE2_PHYS_BASE		0xe0000000
+#define EP93XX_SDCE3_PHYS_BASE_ASYNC	0xf0000000	/* ASDO Pin = 0 */
+#define EP93XX_CS0_PHYS_BASE_SYNC	0xf0000000	/* ASDO Pin = 1 */
+
+#endif /* _EP93XX_PHYS_BASE_H */
diff --git a/arch/arm/mach-ep93xx/ts72xx.c b/arch/arm/mach-ep93xx/ts72xx.c
index 8b2f143..f5965db 100644
--- a/arch/arm/mach-ep93xx/ts72xx.c
+++ b/arch/arm/mach-ep93xx/ts72xx.c
@@ -27,6 +27,8 @@
 #include <asm/mach/map.h>
 #include <asm/mach/arch.h>
 
+#include "soc.h"
+
 
 static struct map_desc ts72xx_io_desc[] __initdata = {
 	{
diff --git a/arch/arm/mach-ep93xx/vision_ep9307.c b/arch/arm/mach-ep93xx/vision_ep9307.c
index d96e4db..9d763a7 100644
--- a/arch/arm/mach-ep93xx/vision_ep9307.c
+++ b/arch/arm/mach-ep93xx/vision_ep9307.c
@@ -37,6 +37,8 @@
 #include <asm/mach/map.h>
 #include <asm/mach/arch.h>
 
+#include "soc.h"
+
 /*************************************************************************
  * Static I/O mappings for the FPGA
  *************************************************************************/
-- 
1.7.0.4
