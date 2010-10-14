From: ian@opensource.wolfsonmicro.com (Ian Lartey)
Date: Thu, 14 Oct 2010 12:07:33 +0100
Subject: [PATCH] Fixing ethernet driver compilation error for i.MX31 ADS board
Message-ID: <1287054453.1799.8991.camel@Tapajos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is only a partial revert of "ARM: mx3/mx31ads: fold board
header in its only user"
[commit ccfa7c269843001077df02d98918c6c9bde91395)]

As some of the the board defines are also used in the cs89x0
ethernet driver by the i.MX31 ADS.

Signed-off-by: Ian Lartey <ian@opensource.wolfsonmicro.com>
---
 arch/arm/mach-mx3/mach-mx31ads.c               |    7 +----
 arch/arm/plat-mxc/include/mach/board-mx31ads.h |   33 ++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm/plat-mxc/include/mach/board-mx31ads.h

diff --git a/arch/arm/mach-mx3/mach-mx31ads.c b/arch/arm/mach-mx3/mach-mx31ads.c
index 94b3e7c..18a226b 100644
--- a/arch/arm/mach-mx3/mach-mx31ads.c
+++ b/arch/arm/mach-mx3/mach-mx31ads.c
@@ -22,13 +22,13 @@
 #include <linux/i2c.h>
 #include <linux/irq.h>
 
-#include <mach/hardware.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
 #include <asm/memory.h>
 #include <asm/mach/map.h>
 #include <mach/common.h>
+#include <mach/board-mx31ads.h>
 #include <mach/iomux-mx3.h>
 
 #ifdef CONFIG_MACH_MX31ADS_WM1133_EV1
@@ -40,10 +40,6 @@
 #include "devices-imx31.h"
 #include "devices.h"
 
-/* Base address of PBC controller */
-#define PBC_BASE_ADDRESS        MX31_CS4_BASE_ADDR_VIRT
-/* Offsets for the PBC Controller register */
-
 /* PBC Board interrupt status register */
 #define PBC_INTSTATUS           0x000016
 
@@ -67,7 +63,6 @@
 #define PBC_INTMASK_CLEAR_REG	(PBC_INTMASK_CLEAR + PBC_BASE_ADDRESS)
 #define EXPIO_PARENT_INT	IOMUX_TO_IRQ(MX31_PIN_GPIO1_4)
 
-#define MXC_EXP_IO_BASE		(MXC_BOARD_IRQ_START)
 #define MXC_IRQ_TO_EXPIO(irq)	((irq) - MXC_EXP_IO_BASE)
 
 #define EXPIO_INT_XUART_INTA	(MXC_EXP_IO_BASE + 10)
diff --git a/arch/arm/plat-mxc/include/mach/board-mx31ads.h b/arch/arm/plat-mxc/include/mach/board-mx31ads.h
new file mode 100644
index 0000000..94b60dd
--- /dev/null
+++ b/arch/arm/plat-mxc/include/mach/board-mx31ads.h
@@ -0,0 +1,33 @@
+/*
+ * Copyright 2005-2007 Freescale Semiconductor, Inc. All Rights Reserved.
+ */
+
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __ASM_ARCH_MXC_BOARD_MX31ADS_H__
+#define __ASM_ARCH_MXC_BOARD_MX31ADS_H__
+
+#include <mach/hardware.h>
+
+/*
+ * These symbols are used by drivers/net/cs89x0.c.
+ * This is ugly as hell, but we have to provide them until
+ * someone fixed the driver.
+ */
+
+/* Base address of PBC controller */
+#define PBC_BASE_ADDRESS        MX31_CS4_BASE_ADDR_VIRT
+/* Offsets for the PBC Controller register */
+
+/* Ethernet Controller IO base address */
+#define PBC_CS8900A_IOBASE      0x020000
+
+#define MXC_EXP_IO_BASE		(MXC_BOARD_IRQ_START)
+
+#define EXPIO_INT_ENET_INT	(MXC_EXP_IO_BASE + 8)
+
+#endif /* __ASM_ARCH_MXC_BOARD_MX31ADS_H__ */
-- 
1.7.0.4
