From: rmallon@gmail.com (Ryan Mallon)
Date: Tue, 13 Mar 2012 09:48:12 +1100
Subject: [PATCH v4 01/11] ep93xx: Move PHYS_BASE defines to local SoC header
 file
Message-ID: <1331592502-9083-2-git-send-email-rmallon@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PHYS_BASE defines in arch/arm/mach-ep93xx/include/mach-ep93xx-regs.h are
only used in the SoC code. Move the defines to a local header file.

Signed-off-by: Ryan Mallon <rmallon@gmail.com>
Reviewed-by: Mika Westerberg <mika.westerberg@iki.fi>
Acked-by: Hartley Sweeten <hsweeten@visionengravers.com>
---
 arch/arm/mach-ep93xx/adssphere.c                |    1 +
 arch/arm/mach-ep93xx/edb93xx.c                  |    1 +
 arch/arm/mach-ep93xx/gesbc9312.c                |    1 +
 arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h |   34 ---------------
 arch/arm/mach-ep93xx/micro9.c                   |    1 +
 arch/arm/mach-ep93xx/simone.c                   |    2 +
 arch/arm/mach-ep93xx/snappercl15.c              |    2 +
 arch/arm/mach-ep93xx/soc.h                      |   50 +++++++++++++++++++++++
 arch/arm/mach-ep93xx/ts72xx.c                   |    1 +
 arch/arm/mach-ep93xx/vision_ep9307.c            |    2 +
 10 files changed, 61 insertions(+), 34 deletions(-)
 create mode 100644 arch/arm/mach-ep93xx/soc.h

diff --git a/arch/arm/mach-ep93xx/adssphere.c b/arch/arm/mach-ep93xx/adssphere.c
index 681e939..2d45947 100644
--- a/arch/arm/mach-ep93xx/adssphere.c
+++ b/arch/arm/mach-ep93xx/adssphere.c
@@ -20,6 +20,7 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
+#include "soc.h"
 
 static struct ep93xx_eth_data __initdata adssphere_eth_data = {
 	.phy_id		= 1,
diff --git a/arch/arm/mach-ep93xx/edb93xx.c b/arch/arm/mach-ep93xx/edb93xx.c
index d115653..da9047d 100644
--- a/arch/arm/mach-ep93xx/edb93xx.c
+++ b/arch/arm/mach-ep93xx/edb93xx.c
@@ -43,6 +43,7 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
+#include "soc.h"
 
 static void __init edb93xx_register_flash(void)
 {
diff --git a/arch/arm/mach-ep93xx/gesbc9312.c b/arch/arm/mach-ep93xx/gesbc9312.c
index af46970..fcdffbe 100644
--- a/arch/arm/mach-ep93xx/gesbc9312.c
+++ b/arch/arm/mach-ep93xx/gesbc9312.c
@@ -20,6 +20,7 @@
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
index 7b98084..dc431c5 100644
--- a/arch/arm/mach-ep93xx/micro9.c
+++ b/arch/arm/mach-ep93xx/micro9.c
@@ -22,6 +22,7 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
+#include "soc.h"
 
 /*************************************************************************
  * Micro9 NOR Flash
diff --git a/arch/arm/mach-ep93xx/simone.c b/arch/arm/mach-ep93xx/simone.c
index f4e553e..f40c298 100644
--- a/arch/arm/mach-ep93xx/simone.c
+++ b/arch/arm/mach-ep93xx/simone.c
@@ -29,6 +29,8 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
+#include "soc.h"
+
 static struct ep93xx_eth_data __initdata simone_eth_data = {
 	.phy_id		= 1,
 };
diff --git a/arch/arm/mach-ep93xx/snappercl15.c b/arch/arm/mach-ep93xx/snappercl15.c
index fd84633..0c00852 100644
--- a/arch/arm/mach-ep93xx/snappercl15.c
+++ b/arch/arm/mach-ep93xx/snappercl15.c
@@ -35,6 +35,8 @@
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
index 79f8ecf..5ea7909 100644
--- a/arch/arm/mach-ep93xx/ts72xx.c
+++ b/arch/arm/mach-ep93xx/ts72xx.c
@@ -28,6 +28,7 @@
 #include <asm/mach/map.h>
 #include <asm/mach/arch.h>
 
+#include "soc.h"
 
 static struct map_desc ts72xx_io_desc[] __initdata = {
 	{
diff --git a/arch/arm/mach-ep93xx/vision_ep9307.c b/arch/arm/mach-ep93xx/vision_ep9307.c
index d67d0b4..ba156eb 100644
--- a/arch/arm/mach-ep93xx/vision_ep9307.c
+++ b/arch/arm/mach-ep93xx/vision_ep9307.c
@@ -39,6 +39,8 @@
 #include <asm/mach/map.h>
 #include <asm/mach/arch.h>
 
+#include "soc.h"
+
 /*************************************************************************
  * Static I/O mappings for the FPGA
  *************************************************************************/
-- 
1.7.0.4
