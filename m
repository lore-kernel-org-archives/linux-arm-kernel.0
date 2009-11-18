From: daniel@caiaq.de (Daniel Mack)
Date: Wed, 18 Nov 2009 14:41:38 +0100
Subject: [PATCH 1/5] ARN: MX3: modularize 'mx31lite' code
Message-ID: <1258551702-8631-1-git-send-email-daniel@caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit splits the support code for LogicPD's mx31lite hardware
into module and board specific parts.

This introduces a new mandatory coreparam called 'mx31lite_baseboard'
which specifies the base board support to use. For now, only the LiteKit
development board is supported, and developers of own boards are
encouraged to use that as reference.

The UART support moved to the board code.
Some comments were amended along the way.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
---
 arch/arm/mach-mx3/Makefile                      |    2 +-
 arch/arm/mach-mx3/mx31lite-db.c                 |   71 +++++++++++++++++++++++
 arch/arm/mach-mx3/mx31lite.c                    |   36 +++++------
 arch/arm/plat-mxc/include/mach/board-mx31lite.h |   39 +++++++++++--
 4 files changed, 121 insertions(+), 27 deletions(-)
 create mode 100644 arch/arm/mach-mx3/mx31lite-db.c

diff --git a/arch/arm/mach-mx3/Makefile b/arch/arm/mach-mx3/Makefile
index be31a9f..68e66a8 100644
--- a/arch/arm/mach-mx3/Makefile
+++ b/arch/arm/mach-mx3/Makefile
@@ -10,7 +10,7 @@ obj-$(CONFIG_ARCH_MX31)		+= clock.o iomux.o
 obj-$(CONFIG_ARCH_MX35)		+= clock-imx35.o
 obj-$(CONFIG_MACH_MX31ADS)	+= mx31ads.o
 obj-$(CONFIG_MACH_MX31LILLY)	+= mx31lilly.o mx31lilly-db.o
-obj-$(CONFIG_MACH_MX31LITE)	+= mx31lite.o
+obj-$(CONFIG_MACH_MX31LITE)	+= mx31lite.o mx31lite-db.o
 obj-$(CONFIG_MACH_PCM037)	+= pcm037.o
 obj-$(CONFIG_MACH_PCM037_EET)	+= pcm037_eet.o
 obj-$(CONFIG_MACH_MX31_3DS)	+= mx31pdk.o
diff --git a/arch/arm/mach-mx3/mx31lite-db.c b/arch/arm/mach-mx3/mx31lite-db.c
new file mode 100644
index 0000000..751d15e
--- /dev/null
+++ b/arch/arm/mach-mx3/mx31lite-db.c
@@ -0,0 +1,71 @@
+/*
+ *  LogicPD i.MX31 SOM-LV development board support
+ *
+ *    Copyright (c) 2009 Daniel Mack <daniel@caiaq.de>
+ *
+ *  based on code for other MX31 boards,
+ *
+ *    Copyright 2005-2007 Freescale Semiconductor
+ *    Copyright (c) 2009 Alberto Panizzo <maramaopercheseimorto@gmail.com>
+ *    Copyright (C) 2009 Valentin Longchamp, EPFL Mobots group
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/init.h>
+#include <linux/gpio.h>
+
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+
+#include <mach/hardware.h>
+#include <mach/common.h>
+#include <mach/imx-uart.h>
+#include <mach/iomux-mx3.h>
+#include <mach/board-mx31lite.h>
+
+#include "devices.h"
+
+/*
+ * This file contains board-specific initialization routines for the
+ * LogicPD i.MX31 SOM-LV development board, aka 'LiteKit'.
+ * If you design an own baseboard for the module, use this file as base
+ * for support code.
+ */
+
+static unsigned int litekit_db_board_pins[] __initdata = {
+	/* UART1 */
+	MX31_PIN_CTS1__CTS1,
+	MX31_PIN_RTS1__RTS1,
+	MX31_PIN_TXD1__TXD1,
+	MX31_PIN_RXD1__RXD1,
+};
+
+/* UART */
+static struct imxuart_platform_data uart_pdata __initdata = {
+	.flags = IMXUART_HAVE_RTSCTS,
+};
+
+void __init mx31lite_db_init(void)
+{
+	mxc_iomux_setup_multiple_pins(litekit_db_board_pins,
+					ARRAY_SIZE(litekit_db_board_pins),
+					"development board pins");
+	mxc_register_device(&mxc_uart_device0, &uart_pdata);
+}
+
diff --git a/arch/arm/mach-mx3/mx31lite.c b/arch/arm/mach-mx3/mx31lite.c
index a8d57de..dc993a8 100644
--- a/arch/arm/mach-mx3/mx31lite.c
+++ b/arch/arm/mach-mx3/mx31lite.c
@@ -42,23 +42,14 @@
 #include "devices.h"
 
 /*
- * This file contains the board-specific initialization routines.
+ * This file contains the module-specific initialization routines.
  */
 
 static unsigned int mx31lite_pins[] = {
-	/* UART1 */
-	MX31_PIN_CTS1__CTS1,
-	MX31_PIN_RTS1__RTS1,
-	MX31_PIN_TXD1__TXD1,
-	MX31_PIN_RXD1__RXD1,
 	/* LAN9117 IRQ pin */
 	IOMUX_MODE(MX31_PIN_SFS6, IOMUX_CONFIG_GPIO),
 };
 
-static struct imxuart_platform_data uart_pdata = {
-	.flags = IMXUART_HAVE_RTSCTS,
-};
-
 static struct mxc_nand_platform_data mx31lite_nand_board_info = {
 	.width = 1,
 	.hw_ecc = 1,
@@ -118,17 +109,27 @@ void __init mx31lite_map_io(void)
 	iotable_init(mx31lite_io_desc, ARRAY_SIZE(mx31lite_io_desc));
 }
 
-/*
- * Board specific initialization.
- */
+static int mx31lite_baseboard;
+core_param(mx31lite_baseboard, mx31lite_baseboard, int, 0444);
+
 static void __init mxc_board_init(void)
 {
 	int ret;
 
+	switch (mx31lite_baseboard) {
+	case MX31LITE_NOBOARD:
+		break;
+	case MX31LITE_DB:
+		mx31lite_db_init();
+		break;
+	default:
+		printk(KERN_ERR "Illegal mx31lite_baseboard type %d\n",
+				mx31lite_baseboard);
+	}
+
 	mxc_iomux_setup_multiple_pins(mx31lite_pins, ARRAY_SIZE(mx31lite_pins),
 				      "mx31lite");
 
-	mxc_register_device(&mxc_uart_device0, &uart_pdata);
 	mxc_register_device(&mxc_nand_device, &mx31lite_nand_board_info);
 
 	/* SMSC9117 IRQ pin */
@@ -150,12 +151,7 @@ struct sys_timer mx31lite_timer = {
 	.init	= mx31lite_timer_init,
 };
 
-/*
- * The following uses standard kernel macros defined in arch.h in order to
- * initialize __mach_desc_MX31LITE data structure.
- */
-
-MACHINE_START(MX31LITE, "LogicPD MX31 LITEKIT")
+MACHINE_START(MX31LITE, "LogicPD i.MX31 SOM")
 	/* Maintainer: Freescale Semiconductor, Inc. */
 	.phys_io        = AIPS1_BASE_ADDR,
 	.io_pg_offst    = ((AIPS1_BASE_ADDR_VIRT) >> 18) & 0xfffc,
diff --git a/arch/arm/plat-mxc/include/mach/board-mx31lite.h b/arch/arm/plat-mxc/include/mach/board-mx31lite.h
index 8e64325..0184b63 100644
--- a/arch/arm/plat-mxc/include/mach/board-mx31lite.h
+++ b/arch/arm/plat-mxc/include/mach/board-mx31lite.h
@@ -1,15 +1,42 @@
 /*
  * Copyright 2007 Freescale Semiconductor, Inc. All Rights Reserved.
+ * Copyright (C) 2009 Daniel Mack <daniel@caiaq.de>
+ *
+ * Based on code for mobots boards,
+ *   Copyright (C) 2009 Valentin Longchamp, EPFL Mobots group
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+ * MA 02110-1301, USA.
  */
 
+#ifndef __ASM_ARCH_MXC_BOARD_MX31LITE_H__
+#define __ASM_ARCH_MXC_BOARD_MX31LITE_H__
+
+#ifndef __ASSEMBLY__
+
+enum mx31lilly_boards {
+	MX31LITE_NOBOARD	= 0,
+	MX31LITE_DB		= 1,
+};
+
 /*
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
+ * This CPU module needs a baseboard to work. After basic initializing
+ * its own devices, it calls baseboard's init function.
  */
 
-#ifndef __ASM_ARCH_MXC_BOARD_MX31LITE_H__
-#define __ASM_ARCH_MXC_BOARD_MX31LITE_H__
+extern void mx31lite_db_init(void);
 
-#endif /* __ASM_ARCH_MXC_BOARD_MX31LITE_H__ */
+#endif
 
+#endif /* __ASM_ARCH_MXC_BOARD_MX31LITE_H__ */
-- 
1.6.5.2
