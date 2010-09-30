From: ian@opensource.wolfsonmicro.com (Ian Lartey)
Date: Thu, 30 Sep 2010 13:57:24 +0100
Subject: [PATCH] Fixing ethernet driver compilation error for i.MX31 ADS board
Message-ID: <1285851444-18123-1-git-send-email-ian@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is only a partial revert of "ARM: mx3/mx31ads: fold board header in its only user"
[commit ccfa7c269843001077df02d98918c6c9bde91395)]

As some of the the board defines are also used in the cs89x0 ethernet driver by the i.MX31 ADS.

Signed-off-by: Ian Lartey <ian@opensource.wolfsonmicro.com>
---
 arch/arm/mach-mx3/mach-mx31ads.c               |   43 +++---------------
 arch/arm/plat-mxc/include/mach/board-mx31ads.h |   57 ++++++++++++++++++++++++
 2 files changed, 64 insertions(+), 36 deletions(-)
 create mode 100644 arch/arm/plat-mxc/include/mach/board-mx31ads.h

diff --git a/arch/arm/mach-mx3/mach-mx31ads.c b/arch/arm/mach-mx3/mach-mx31ads.c
index 94b3e7c..7d13e99 100644
--- a/arch/arm/mach-mx3/mach-mx31ads.c
+++ b/arch/arm/mach-mx3/mach-mx31ads.c
@@ -29,6 +29,7 @@
 #include <asm/memory.h>
 #include <asm/mach/map.h>
 #include <mach/common.h>
+#include <mach/board-mx31ads.h>
 #include <mach/iomux-mx3.h>
 
 #ifdef CONFIG_MACH_MX31ADS_WM1133_EV1
@@ -40,42 +41,12 @@
 #include "devices-imx31.h"
 #include "devices.h"
 
-/* Base address of PBC controller */
-#define PBC_BASE_ADDRESS        MX31_CS4_BASE_ADDR_VIRT
-/* Offsets for the PBC Controller register */
-
-/* PBC Board interrupt status register */
-#define PBC_INTSTATUS           0x000016
-
-/* PBC Board interrupt current status register */
-#define PBC_INTCURR_STATUS      0x000018
-
-/* PBC Interrupt mask register set address */
-#define PBC_INTMASK_SET         0x00001A
-
-/* PBC Interrupt mask register clear address */
-#define PBC_INTMASK_CLEAR       0x00001C
-
-/* External UART A */
-#define PBC_SC16C652_UARTA      0x010000
-
-/* External UART B */
-#define PBC_SC16C652_UARTB      0x010010
-
-#define PBC_INTSTATUS_REG	(PBC_INTSTATUS + PBC_BASE_ADDRESS)
-#define PBC_INTMASK_SET_REG	(PBC_INTMASK_SET + PBC_BASE_ADDRESS)
-#define PBC_INTMASK_CLEAR_REG	(PBC_INTMASK_CLEAR + PBC_BASE_ADDRESS)
-#define EXPIO_PARENT_INT	IOMUX_TO_IRQ(MX31_PIN_GPIO1_4)
-
-#define MXC_EXP_IO_BASE		(MXC_BOARD_IRQ_START)
-#define MXC_IRQ_TO_EXPIO(irq)	((irq) - MXC_EXP_IO_BASE)
-
-#define EXPIO_INT_XUART_INTA	(MXC_EXP_IO_BASE + 10)
-#define EXPIO_INT_XUART_INTB	(MXC_EXP_IO_BASE + 11)
-
-#define MXC_MAX_EXP_IO_LINES	16
-/*
- * This file contains the board-specific initialization routines.
+/*!
+ * @file mx31ads.c
+ *
+ * @brief This file contains the board-specific initialization routines.
+ *
+ * @ingroup System
  */
 
 #if defined(CONFIG_SERIAL_8250) || defined(CONFIG_SERIAL_8250_MODULE)
diff --git a/arch/arm/plat-mxc/include/mach/board-mx31ads.h b/arch/arm/plat-mxc/include/mach/board-mx31ads.h
new file mode 100644
index 0000000..6a019bd
--- /dev/null
+++ b/arch/arm/plat-mxc/include/mach/board-mx31ads.h
@@ -0,0 +1,57 @@
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
+/* Base address of PBC controller */
+#define PBC_BASE_ADDRESS        MX31_CS4_BASE_ADDR_VIRT
+/* Offsets for the PBC Controller register */
+
+/* PBC Board interrupt status register */
+#define PBC_INTSTATUS           0x000016
+
+/* PBC Board interrupt current status register */
+#define PBC_INTCURR_STATUS      0x000018
+
+/* PBC Interrupt mask register set address */
+#define PBC_INTMASK_SET         0x00001A
+
+/* PBC Interrupt mask register clear address */
+#define PBC_INTMASK_CLEAR       0x00001C
+
+/* External UART A */
+#define PBC_SC16C652_UARTA      0x010000
+
+/* External UART B */
+#define PBC_SC16C652_UARTB      0x010010
+
+/* Ethernet Controller IO base address */
+#define PBC_CS8900A_IOBASE      0x020000
+
+#define PBC_INTSTATUS_REG	(PBC_INTSTATUS + PBC_BASE_ADDRESS)
+#define PBC_INTMASK_SET_REG	(PBC_INTMASK_SET + PBC_BASE_ADDRESS)
+#define PBC_INTMASK_CLEAR_REG	(PBC_INTMASK_CLEAR + PBC_BASE_ADDRESS)
+#define EXPIO_PARENT_INT	IOMUX_TO_IRQ(MX31_PIN_GPIO1_4)
+
+#define MXC_EXP_IO_BASE		(MXC_BOARD_IRQ_START)
+#define MXC_IRQ_TO_EXPIO(irq)	((irq) - MXC_EXP_IO_BASE)
+
+
+#define EXPIO_INT_ENET_INT	(MXC_EXP_IO_BASE + 8)
+
+#define EXPIO_INT_XUART_INTA	(MXC_EXP_IO_BASE + 10)
+#define EXPIO_INT_XUART_INTB	(MXC_EXP_IO_BASE + 11)
+
+#define MXC_MAX_EXP_IO_LINES	16
+
+#endif /* __ASM_ARCH_MXC_BOARD_MX31ADS_H__ */
-- 
1.7.0.4
