From: ian@opensource.wolfsonmicro.com (Ian Lartey)
Date: Thu, 23 Sep 2010 16:32:01 +0100
Subject: [PATCH] Fixing ethernet driver compilation error for i.MX31 ADS board
Message-ID: <1285255921.1864.24.camel@Tapajos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From 581b35e4bf37a0467dfb419d67217808eb238fd5 Mon Sep 17 00:00:00 2001
From: Ian Lartey <ian@opensource.wolfsonmicro.com>
Date: Thu, 23 Sep 2010 11:36:08 +0100
Subject: [PATCH] Fixing ethernet driver compilation error for i.MX31 ADS board

Revert "ARM: mx3/mx31ads: fold board header in its only user"

This reverts commit ccfa7c269843001077df02d98918c6c9bde91395.
As the board header is also used cs89x0 ethernet driver by the i.MX31 ADS.

Signed-off-by: Ian Lartey <ian@opensource.wolfsonmicro.com>
---
 Resend due to error in To: list.

 arch/arm/mach-mx3/mach-mx31ads.c               |   43 ++-------
 arch/arm/plat-mxc/include/mach/board-mx31ads.h |  117 ++++++++++++++++++++++++
 2 files changed, 124 insertions(+), 36 deletions(-)
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
index 0000000..095a199
--- /dev/null
+++ b/arch/arm/plat-mxc/include/mach/board-mx31ads.h
@@ -0,0 +1,117 @@
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
+/* PBC Board status register offset */
+#define PBC_BSTAT               0x000002
+
+/* PBC Board control register 1 set address */
+#define PBC_BCTRL1_SET          0x000004
+
+/* PBC Board control register 1 clear address */
+#define PBC_BCTRL1_CLEAR        0x000006
+
+/* PBC Board control register 2 set address */
+#define PBC_BCTRL2_SET          0x000008
+
+/* PBC Board control register 2 clear address */
+#define PBC_BCTRL2_CLEAR        0x00000A
+
+/* PBC Board control register 3 set address */
+#define PBC_BCTRL3_SET          0x00000C
+
+/* PBC Board control register 3 clear address */
+#define PBC_BCTRL3_CLEAR        0x00000E
+
+/* PBC Board control register 4 set address */
+#define PBC_BCTRL4_SET          0x000010
+
+/* PBC Board control register 4 clear address */
+#define PBC_BCTRL4_CLEAR        0x000012
+
+/* PBC Board status register 1 */
+#define PBC_BSTAT1              0x000014
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
+/* Ethernet Controller Memory base address */
+#define PBC_CS8900A_MEMBASE     0x021000
+
+/* Ethernet Controller DMA base address */
+#define PBC_CS8900A_DMABASE     0x022000
+
+/* External chip select 0 */
+#define PBC_XCS0                0x040000
+
+/* LCD Display enable */
+#define PBC_LCD_EN_B            0x060000
+
+/* Code test debug enable */
+#define PBC_CODE_B              0x070000
+
+/* PSRAM memory select */
+#define PBC_PSRAM_B             0x5000000
+
+#define PBC_INTSTATUS_REG	(PBC_INTSTATUS + PBC_BASE_ADDRESS)
+#define PBC_INTCURR_STATUS_REG	(PBC_INTCURR_STATUS + PBC_BASE_ADDRESS)
+#define PBC_INTMASK_SET_REG	(PBC_INTMASK_SET + PBC_BASE_ADDRESS)
+#define PBC_INTMASK_CLEAR_REG	(PBC_INTMASK_CLEAR + PBC_BASE_ADDRESS)
+#define EXPIO_PARENT_INT	IOMUX_TO_IRQ(MX31_PIN_GPIO1_4)
+
+#define MXC_EXP_IO_BASE		(MXC_BOARD_IRQ_START)
+#define MXC_IRQ_TO_EXPIO(irq)	((irq) - MXC_EXP_IO_BASE)
+
+#define EXPIO_INT_LOW_BAT	(MXC_EXP_IO_BASE + 0)
+#define EXPIO_INT_PB_IRQ	(MXC_EXP_IO_BASE + 1)
+#define EXPIO_INT_OTG_FS_OVR	(MXC_EXP_IO_BASE + 2)
+#define EXPIO_INT_FSH_OVR	(MXC_EXP_IO_BASE + 3)
+#define EXPIO_INT_RES4		(MXC_EXP_IO_BASE + 4)
+#define EXPIO_INT_RES5		(MXC_EXP_IO_BASE + 5)
+#define EXPIO_INT_RES6		(MXC_EXP_IO_BASE + 6)
+#define EXPIO_INT_RES7		(MXC_EXP_IO_BASE + 7)
+#define EXPIO_INT_ENET_INT	(MXC_EXP_IO_BASE + 8)
+#define EXPIO_INT_OTG_FS_INT	(MXC_EXP_IO_BASE + 9)
+#define EXPIO_INT_XUART_INTA	(MXC_EXP_IO_BASE + 10)
+#define EXPIO_INT_XUART_INTB	(MXC_EXP_IO_BASE + 11)
+#define EXPIO_INT_SYNTH_IRQ	(MXC_EXP_IO_BASE + 12)
+#define EXPIO_INT_CE_INT1	(MXC_EXP_IO_BASE + 13)
+#define EXPIO_INT_CE_INT2	(MXC_EXP_IO_BASE + 14)
+#define EXPIO_INT_RES15		(MXC_EXP_IO_BASE + 15)
+
+#define MXC_MAX_EXP_IO_LINES	16
+
+#endif /* __ASM_ARCH_MXC_BOARD_MX31ADS_H__ */
-- 
1.7.0.4
