From: GNUtoo@no-log.org (Denis 'GNUtoo' Carikli)
Date: Sat, 22 Jan 2011 21:42:39 +0100
Subject: [PATCH] mx31: add support for the bugbase 1.3 from buglabs
Message-ID: <1295728959-5790-1-git-send-email-GNUtoo@no-log.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This work was based on bug-linux-2.6.30.patch that can be found
  in buglabs's svn here:
  svn://bugcamp.net/bug/branches/izzy/experimental

Signed-off-by: Denis 'GNUtoo' Carikli <GNUtoo@no-log.org>
---
 arch/arm/mach-mx3/Kconfig            |    9 +++
 arch/arm/mach-mx3/Makefile           |    1 +
 arch/arm/mach-mx3/mach-mx31bugbase.c |   98 ++++++++++++++++++++++++++++++++++
 3 files changed, 108 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-mx3/mach-mx31bugbase.c

diff --git a/arch/arm/mach-mx3/Kconfig b/arch/arm/mach-mx3/Kconfig
index 0717f88..f36b3ef 100644
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
index 8db1329..8a74dcf 100644
--- a/arch/arm/mach-mx3/Makefile
+++ b/arch/arm/mach-mx3/Makefile
@@ -20,5 +20,6 @@ obj-$(CONFIG_MACH_PCM043)	+= mach-pcm043.o
 obj-$(CONFIG_MACH_ARMADILLO5X0) += mach-armadillo5x0.o
 obj-$(CONFIG_MACH_MX35_3DS)	+= mach-mx35_3ds.o
 obj-$(CONFIG_MACH_KZM_ARM11_01)	+= mach-kzm_arm11_01.o
+obj-$(CONFIG_MACH_BUG)          += mach-mx31bugbase.o
 obj-$(CONFIG_MACH_EUKREA_CPUIMX35)	+= mach-cpuimx35.o
 obj-$(CONFIG_MACH_EUKREA_MBIMXSD35_BASEBOARD)	+= eukrea_mbimxsd-baseboard.o
diff --git a/arch/arm/mach-mx3/mach-mx31bugbase.c b/arch/arm/mach-mx3/mach-mx31bugbase.c
new file mode 100644
index 0000000..a839bf0
--- /dev/null
+++ b/arch/arm/mach-mx3/mach-mx31bugbase.c
@@ -0,0 +1,98 @@
+/*
+ *  Copyright (C) 2000 Deep Blue Solutions Ltd
+ *  Copyright (C) 2002 Shane Nay (shane at minirl.com)
+ *  Copyright 2005-2007 Freescale Semiconductor, Inc. All Rights Reserved.
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
+/*!
+ * @file mx31bugbase.c
+ *
+ * @brief This file contains the board-specific initialization routines.
+ *
+ * @ingroup System
+ */
+
+#if defined(CONFIG_SERIAL_IMX) || defined(CONFIG_SERIAL_IMX_MODULE)
+static struct imxuart_platform_data uart_pdata = {
+	.flags = IMXUART_HAVE_RTSCTS,
+};
+
+static unsigned int uart5_pins[] = {
+	MX31_PIN_PC_RST__CTS5,
+	MX31_PIN_PC_VS2__RTS5,
+	MX31_PIN_PC_BVD2__TXD5,
+	MX31_PIN_PC_BVD1__RXD5
+};
+
+static inline void mxc_init_imx_uart(void)
+{
+	mxc_iomux_setup_multiple_pins(uart5_pins,
+				ARRAY_SIZE(uart5_pins), "uart-4");
+	imx31_add_imx_uart4(&uart_pdata);
+}
+#else /* !SERIAL_IMX */
+static inline void mxc_init_imx_uart(void)
+{
+}
+#endif /* !SERIAL_IMX */
+
+/*!
+ * Board specific initialization.
+ */
+static void __init mxc_board_init(void)
+{
+	mxc_init_imx_uart();
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
+/*
+ * The following uses standard kernel macros defined in arch.h in order to
+ * initialize __mach_desc_MX31BUG data structure.
+ */
+
+MACHINE_START(BUG, "BugLabs BUGBase")
+	/* Maintainer: Denis 'GNUtoo' Carikli */
+	.boot_params    = PHYS_OFFSET + 0x100,
+	.timer          = &mx31bug_timer,
+	.map_io         = mx31_map_io,
+	.init_irq       = mx31_init_irq,
+	.init_machine   = mxc_board_init,
+MACHINE_END
-- 
1.7.0.4
