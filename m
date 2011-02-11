From: GNUtoo@no-log.org (Denis 'GNUtoo' Carikli)
Date: Fri, 11 Feb 2011 22:06:28 +0100
Subject: [PATCH] mx31: add support for the bugbase 1.3 from buglabs
In-Reply-To: <20110211081050.GD27982@pengutronix.de>
References: <20110211081050.GD27982@pengutronix.de>
Message-ID: <1297458388-23361-1-git-send-email-GNUtoo@no-log.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This work was based on bug-linux-2.6.30.patch that can be found
  in buglabs's svn here:
  svn://bugcamp.net/bug/branches/izzy/experimental

Note that the hardware schematics and documentations can be obtained
  here: http://www.bugcommunity.com/wiki/index.php/BUGbase

Signed-off-by: Denis 'GNUtoo' Carikli <GNUtoo@no-log.org>
---
 arch/arm/mach-mx3/Kconfig                   |    9 +++
 arch/arm/mach-mx3/Makefile                  |    1 +
 arch/arm/mach-mx3/mach-mx31bugbase.c        |   75 +++++++++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/uncompress.h |    4 ++
 4 files changed, 89 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-mx3/mach-mx31bugbase.c

diff --git a/arch/arm/mach-mx3/Kconfig b/arch/arm/mach-mx3/Kconfig
index de80d98..4f57f13 100644
--- a/arch/arm/mach-mx3/Kconfig
+++ b/arch/arm/mach-mx3/Kconfig
@@ -199,6 +199,15 @@ config MACH_KZM_ARM11_01
 	  Include support for KZM-ARM11-01. This includes specific
 	  configurations for the board and its peripherals.
 
+config MACH_BUG
+	bool "Support Buglabs BUGBase platform"
+	select SOC_IMX31
+	select IMX_HAVE_PLATFORM_IMX_UART
+	default y
+	help
+	  Include support for BUGBase 1.3 platform. This includes specific
+	  configurations for the board and its peripherals.
+
 config MACH_EUKREA_CPUIMX35
 	bool "Support Eukrea CPUIMX35 Platform"
 	select SOC_IMX35
diff --git a/arch/arm/mach-mx3/Makefile b/arch/arm/mach-mx3/Makefile
index bc7294f..98e5eb3 100644
--- a/arch/arm/mach-mx3/Makefile
+++ b/arch/arm/mach-mx3/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_MACH_PCM043)	+= mach-pcm043.o
 obj-$(CONFIG_MACH_ARMADILLO5X0) += mach-armadillo5x0.o
 obj-$(CONFIG_MACH_MX35_3DS)	+= mach-mx35_3ds.o
 obj-$(CONFIG_MACH_KZM_ARM11_01)	+= mach-kzm_arm11_01.o
+obj-$(CONFIG_MACH_BUG)          += mach-mx31bugbase.o
 obj-$(CONFIG_MACH_EUKREA_CPUIMX35)	+= mach-cpuimx35.o
 obj-$(CONFIG_MACH_EUKREA_MBIMXSD35_BASEBOARD)	+= eukrea_mbimxsd-baseboard.o
 obj-$(CONFIG_MACH_VPR200)	+= mach-vpr200.o
diff --git a/arch/arm/mach-mx3/mach-mx31bugbase.c b/arch/arm/mach-mx3/mach-mx31bugbase.c
new file mode 100644
index 0000000..1d8ca1c
--- /dev/null
+++ b/arch/arm/mach-mx3/mach-mx31bugbase.c
@@ -0,0 +1,75 @@
+/*
+ * Copyright (C) 2000 Deep Blue Solutions Ltd
+ * Copyright (C) 2002 Shane Nay (shane at minirl.com)
+ * Copyright 2005-2007 Freescale Semiconductor, Inc. All Rights Reserved.
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
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+
+#include <mach/iomux-mx3.h>
+#include <mach/imx-uart.h>
+#include <mach/hardware.h>
+#include <mach/common.h>
+
+#include <asm/mach/time.h>
+#include <asm/mach/arch.h>
+#include <asm/mach-types.h>
+
+#include "devices-imx31.h"
+
+static struct imxuart_platform_data uart_pdata = {
+	.flags = IMXUART_HAVE_RTSCTS,
+};
+
+static unsigned int uart5_pins[] = {
+	MX31_PIN_PC_RST__CTS5,
+	MX31_PIN_PC_VS2__RTS5,
+	MX31_PIN_PC_BVD2__TXD5,
+	MX31_PIN_PC_BVD1__RXD5,
+};
+
+static inline void mx31bug_init_imx_uart(void)
+{
+	mxc_iomux_setup_multiple_pins(uart5_pins,
+				ARRAY_SIZE(uart5_pins), "uart-4");
+	imx31_add_imx_uart4(&uart_pdata);
+}
+
+/*!
+ * Board specific initialization.
+ */
+static void __init mx31bug_board_init(void)
+{
+	mx31bug_init_imx_uart();
+}
+
+
+static void __init mx31bug_timer_init(void)
+{
+	mx31_clocks_init(26000000);
+}
+
+static struct sys_timer mx31bug_timer = {
+	.init	= mx31bug_timer_init,
+};
+
+MACHINE_START(BUG, "BugLabs BUGBase")
+	.boot_params = MX3x_PHYS_OFFSET + 0x100,
+	.map_io = mx31_map_io,
+        .init_early = imx31_init_early,
+	.init_irq = mx31_init_irq,
+        .timer = &mx31bug_timer,
+	.init_machine = mx31bug_board_init,
+MACHINE_END
diff --git a/arch/arm/plat-mxc/include/mach/uncompress.h b/arch/arm/plat-mxc/include/mach/uncompress.h
index e634d6c..b45f534 100644
--- a/arch/arm/plat-mxc/include/mach/uncompress.h
+++ b/arch/arm/plat-mxc/include/mach/uncompress.h
@@ -62,6 +62,7 @@ static inline void flush(void)
 #define MX2X_UART1_BASE_ADDR	0x1000a000
 #define MX3X_UART1_BASE_ADDR	0x43F90000
 #define MX3X_UART2_BASE_ADDR	0x43F94000
+#define MX3X_UART5_BASE_ADDR	0x43FB4000
 #define MX51_UART1_BASE_ADDR	0x73fbc000
 #define MX50_UART1_BASE_ADDR	0x53fbc000
 #define MX53_UART1_BASE_ADDR	0x53fbc000
@@ -102,6 +103,9 @@ static __inline__ void __arch_decomp_setup(unsigned long arch_id)
 	case MACH_TYPE_MAGX_ZN5:
 		uart_base = MX3X_UART2_BASE_ADDR;
 		break;
+	case MACH_TYPE_BUG:
+		uart_base = MX3X_UART5_BASE_ADDR;
+		break;
 	case MACH_TYPE_MX51_BABBAGE:
 	case MACH_TYPE_EUKREA_CPUIMX51SD:
 	case MACH_TYPE_MX51_3DS:
-- 
1.7.0.4
