From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue, 25 May 2010 10:20:08 +0200
Subject: [PATCH 13/16 v2] arm/mx3/mx31_3ds: fold board header in its only user
In-Reply-To: <1274730951-29106-14-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1274730951-29106-14-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1274775608-16771-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Moreover remove unused definitions.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
Hello Sascha, hello Alberto,

thanks for your feedback.  This patch additionally removes board-mx31_3ds.h.

Best regards
Uwe

 arch/arm/mach-mx3/mach-mx31_3ds.c               |   41 +++++++++++++--
 arch/arm/plat-mxc/include/mach/board-mx31_3ds.h |   59 -----------------------
 2 files changed, 35 insertions(+), 65 deletions(-)
 delete mode 100644 arch/arm/plat-mxc/include/mach/board-mx31_3ds.h

diff --git a/arch/arm/mach-mx3/mach-mx31_3ds.c b/arch/arm/mach-mx3/mach-mx31_3ds.c
index f54af1e..7ec2e81 100644
--- a/arch/arm/mach-mx3/mach-mx31_3ds.c
+++ b/arch/arm/mach-mx3/mach-mx31_3ds.c
@@ -41,12 +41,41 @@
 #include <mach/spi.h>
 #include "devices.h"
 
-/*!
- * @file mx31_3ds.c
- *
- * @brief This file contains the board-specific initialization routines.
- *
- * @ingroup System
+/* Definitions for components on the Debug board */
+
+/* Base address of CPLD controller on the Debug board */
+#define DEBUG_BASE_ADDRESS		CS5_IO_ADDRESS(MX3x_CS5_BASE_ADDR)
+
+/* LAN9217 ethernet base address */
+#define LAN9217_BASE_ADDR		MX3x_CS5_BASE_ADDR
+
+/* CPLD config and interrupt base address */
+#define CPLD_ADDR			(DEBUG_BASE_ADDRESS + 0x20000)
+
+/* status, interrupt */
+#define CPLD_INT_STATUS_REG		(CPLD_ADDR + 0x10)
+#define CPLD_INT_MASK_REG		(CPLD_ADDR + 0x38)
+#define CPLD_INT_RESET_REG		(CPLD_ADDR + 0x20)
+/* magic word for debug CPLD */
+#define CPLD_MAGIC_NUMBER1_REG		(CPLD_ADDR + 0x40)
+#define CPLD_MAGIC_NUMBER2_REG		(CPLD_ADDR + 0x48)
+/* CPLD code version */
+#define CPLD_CODE_VER_REG		(CPLD_ADDR + 0x50)
+/* magic word for debug CPLD */
+#define CPLD_MAGIC_NUMBER3_REG		(CPLD_ADDR + 0x58)
+
+/* CPLD IRQ line for external uart, external ethernet etc */
+#define EXPIO_PARENT_INT	IOMUX_TO_IRQ(MX31_PIN_GPIO1_1)
+
+#define MXC_EXP_IO_BASE		(MXC_BOARD_IRQ_START)
+#define MXC_IRQ_TO_EXPIO(irq)	((irq) - MXC_EXP_IO_BASE)
+
+#define EXPIO_INT_ENET		(MXC_EXP_IO_BASE + 0)
+
+#define MXC_MAX_EXP_IO_LINES	16
+
+/*
+ * This file contains the board-specific initialization routines.
  */
 
 static int mx31_3ds_pins[] = {
diff --git a/arch/arm/plat-mxc/include/mach/board-mx31_3ds.h b/arch/arm/plat-mxc/include/mach/board-mx31_3ds.h
deleted file mode 100644
index da92933..0000000
--- a/arch/arm/plat-mxc/include/mach/board-mx31_3ds.h
+++ /dev/null
@@ -1,59 +0,0 @@
-/*
- * Copyright 2008 Freescale Semiconductor, Inc. All Rights Reserved.
- */
-
-/*
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef __ASM_ARCH_MXC_BOARD_MX31_3DS_H__
-#define __ASM_ARCH_MXC_BOARD_MX31_3DS_H__
-
-/* Definitions for components on the Debug board */
-
-/* Base address of CPLD controller on the Debug board */
-#define DEBUG_BASE_ADDRESS		CS5_IO_ADDRESS(CS5_BASE_ADDR)
-
-/* LAN9217 ethernet base address */
-#define LAN9217_BASE_ADDR		CS5_BASE_ADDR
-
-/* CPLD config and interrupt base address */
-#define CPLD_ADDR			(DEBUG_BASE_ADDRESS + 0x20000)
-
-/* LED switchs */
-#define CPLD_LED_REG			(CPLD_ADDR + 0x00)
-/* buttons */
-#define CPLD_SWITCH_BUTTONS_REG	(EXPIO_ADDR + 0x08)
-/* status, interrupt */
-#define CPLD_INT_STATUS_REG		(CPLD_ADDR + 0x10)
-#define CPLD_INT_MASK_REG		(CPLD_ADDR + 0x38)
-#define CPLD_INT_RESET_REG		(CPLD_ADDR + 0x20)
-/* magic word for debug CPLD */
-#define CPLD_MAGIC_NUMBER1_REG		(CPLD_ADDR + 0x40)
-#define CPLD_MAGIC_NUMBER2_REG		(CPLD_ADDR + 0x48)
-/* CPLD code version */
-#define CPLD_CODE_VER_REG		(CPLD_ADDR + 0x50)
-/* magic word for debug CPLD */
-#define CPLD_MAGIC_NUMBER3_REG		(CPLD_ADDR + 0x58)
-/* module reset register */
-#define CPLD_MODULE_RESET_REG		(CPLD_ADDR + 0x60)
-/* CPU ID and Personality ID */
-#define CPLD_MCU_BOARD_ID_REG		(CPLD_ADDR + 0x68)
-
-/* CPLD IRQ line for external uart, external ethernet etc */
-#define EXPIO_PARENT_INT	IOMUX_TO_IRQ(MX31_PIN_GPIO1_1)
-
-#define MXC_EXP_IO_BASE		(MXC_BOARD_IRQ_START)
-#define MXC_IRQ_TO_EXPIO(irq)	((irq) - MXC_EXP_IO_BASE)
-
-#define EXPIO_INT_ENET		(MXC_EXP_IO_BASE + 0)
-#define EXPIO_INT_XUART_A	(MXC_EXP_IO_BASE + 1)
-#define EXPIO_INT_XUART_B	(MXC_EXP_IO_BASE + 2)
-#define EXPIO_INT_BUTTON_A	(MXC_EXP_IO_BASE + 3)
-#define EXPIO_INT_BUTTON_B	(MXC_EXP_IO_BASE + 4)
-
-#define MXC_MAX_EXP_IO_LINES	16
-
-#endif /* __ASM_ARCH_MXC_BOARD_MX31_3DS_H__ */
-- 
1.7.0
