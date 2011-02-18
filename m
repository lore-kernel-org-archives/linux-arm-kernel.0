From: GNUtoo@no-log.org (Denis 'GNUtoo' Carikli)
Date: Fri, 18 Feb 2011 22:22:23 +0100
Subject: [PATCH] mx31: add support for the bugbase 1.3 from buglabs
In-Reply-To: <20110213211855.GC13279@pengutronix.de>
References: <20110213211855.GC13279@pengutronix.de>
Message-ID: <1298064143-27158-1-git-send-email-GNUtoo@no-log.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Note that the hardware schematics and documentations can be obtained
  here: http://www.bugcommunity.com/wiki/index.php/BUGbase

Signed-off-by: Denis 'GNUtoo' Carikli <GNUtoo@no-log.org>
---
 arch/arm/mach-mx3/Kconfig                   |    9 ++++
 arch/arm/mach-mx3/Makefile                  |    1 +
 arch/arm/mach-mx3/mach-bug.c                |   66 +++++++++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/uncompress.h |    4 ++
 4 files changed, 80 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-mx3/mach-bug.c

diff --git a/arch/arm/mach-mx3/Kconfig b/arch/arm/mach-mx3/Kconfig
index 5000ac1..3daf1fe 100644
--- a/arch/arm/mach-mx3/Kconfig
+++ b/arch/arm/mach-mx3/Kconfig
@@ -160,6 +160,15 @@ config MACH_KZM_ARM11_01
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
 	select ARCH_MX35
diff --git a/arch/arm/mach-mx3/Makefile b/arch/arm/mach-mx3/Makefile
index 8a182d0..95a45e8 100644
--- a/arch/arm/mach-mx3/Makefile
+++ b/arch/arm/mach-mx3/Makefile
@@ -23,5 +23,6 @@ obj-$(CONFIG_MACH_PCM043)	+= mach-pcm043.o
 obj-$(CONFIG_MACH_ARMADILLO5X0) += mach-armadillo5x0.o
 obj-$(CONFIG_MACH_MX35_3DS)	+= mach-mx35_3ds.o
 obj-$(CONFIG_MACH_KZM_ARM11_01)	+= mach-kzm_arm11_01.o
+obj-$(CONFIG_MACH_BUG)		+= mach-bug.o
 obj-$(CONFIG_MACH_EUKREA_CPUIMX35)	+= mach-cpuimx35.o
 obj-$(CONFIG_MACH_EUKREA_MBIMXSD35_BASEBOARD)	+= eukrea_mbimxsd-baseboard.o
diff --git a/arch/arm/mach-mx3/mach-bug.c b/arch/arm/mach-mx3/mach-bug.c
new file mode 100644
index 0000000..d137d70
--- /dev/null
+++ b/arch/arm/mach-mx3/mach-bug.c
@@ -0,0 +1,66 @@
+/*
+ * Copyright (C) 2000 Deep Blue Solutions Ltd
+ * Copyright (C) 2002 Shane Nay (shane at minirl.com)
+ * Copyright 2005-2007 Freescale Semiconductor, Inc. All Rights Reserved.
+ * Copyright 2011 Denis 'GNUtoo' Carikli <GNUtoo@no-log.org>
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
+static const struct imxuart_platform_data uart_pdata __initconst = {
+	.flags = IMXUART_HAVE_RTSCTS,
+};
+
+static const unsigned int bug_pins[] __initconst = {
+	MX31_PIN_PC_RST__CTS5,
+	MX31_PIN_PC_VS2__RTS5,
+	MX31_PIN_PC_BVD2__TXD5,
+	MX31_PIN_PC_BVD1__RXD5,
+};
+
+static void __init bug_board_init(void)
+{
+	mxc_iomux_setup_multiple_pins(bug_pins,
+				      ARRAY_SIZE(bug_pins), "uart-4");
+	imx31_add_imx_uart4(&uart_pdata);
+}
+
+static void __init bug_timer_init(void)
+{
+	mx31_clocks_init(26000000);
+}
+
+static struct sys_timer bug_timer = {
+	.init = bug_timer_init,
+};
+
+MACHINE_START(BUG, "BugLabs BUGBase")
+	.map_io = mx31_map_io,
+	.init_early = imx31_init_early,
+	.init_irq = mx31_init_irq,
+	.timer = &bug_timer,
+	.init_machine = bug_board_init,
+MACHINE_END
diff --git a/arch/arm/plat-mxc/include/mach/uncompress.h b/arch/arm/plat-mxc/include/mach/uncompress.h
index 9dd9c20..c3b155c 100644
--- a/arch/arm/plat-mxc/include/mach/uncompress.h
+++ b/arch/arm/plat-mxc/include/mach/uncompress.h
@@ -62,6 +62,7 @@ static inline void flush(void)
 #define MX2X_UART1_BASE_ADDR	0x1000a000
 #define MX3X_UART1_BASE_ADDR	0x43F90000
 #define MX3X_UART2_BASE_ADDR	0x43F94000
+#define MX3X_UART5_BASE_ADDR	0x43FB4000
 #define MX51_UART1_BASE_ADDR	0x73fbc000
 
 static __inline__ void __arch_decomp_setup(unsigned long arch_id)
@@ -98,6 +99,9 @@ static __inline__ void __arch_decomp_setup(unsigned long arch_id)
 	case MACH_TYPE_MAGX_ZN5:
 		uart_base = MX3X_UART2_BASE_ADDR;
 		break;
+	case MACH_TYPE_BUG:
+		uart_base = MX3X_UART5_BASE_ADDR;
+		break;
 	case MACH_TYPE_MX51_BABBAGE:
 	case MACH_TYPE_EUKREA_CPUIMX51SD:
 		uart_base = MX51_UART1_BASE_ADDR;
-- 
1.7.0.4
