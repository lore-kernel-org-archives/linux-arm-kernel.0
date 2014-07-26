From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat, 26 Jul 2014 13:45:28 +0400
Subject: [PATCH 1/2] ARM: i.MX1: Add devicetree support
Message-ID: <1406367929-7643-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds basic devicetree support for i.MX1 based SoCs.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-imx/Kconfig   |  8 ++++++++
 arch/arm/mach-imx/Makefile  |  1 +
 arch/arm/mach-imx/imx1-dt.c | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 43 insertions(+)
 create mode 100644 arch/arm/mach-imx/imx1-dt.c

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 2bc7b97..c6810b8 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -70,6 +70,7 @@ config SOC_IMX1
 	select CPU_ARM920T
 	select IMX_HAVE_IOMUX_V1
 	select MXC_AVIC
+	select PINCTRL_IMX1
 
 config SOC_IMX21
 	bool
@@ -137,6 +138,13 @@ config MACH_APF9328
 	help
 	  Say Yes here if you are using the Armadeus APF9328 development board
 
+config MACH_IMX1_DT
+	bool "Support i.MX1 platforms from device tree"
+	select SOC_IMX1
+	help
+	  Include support for Freescale i.MX1 based platforms
+	  using the device tree for discovery.
+
 endif
 
 if ARCH_MULTI_V5
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index ac88599..2783d27 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -44,6 +44,7 @@ endif
 obj-$(CONFIG_ARCH_MX1ADS) += mach-mx1ads.o
 obj-$(CONFIG_MACH_SCB9328) += mach-scb9328.o
 obj-$(CONFIG_MACH_APF9328) += mach-apf9328.o
+obj-$(CONFIG_MACH_IMX1_DT) += imx1-dt.o
 
 # i.MX21 based machines
 obj-$(CONFIG_MACH_MX21ADS) += mach-mx21ads.o
diff --git a/arch/arm/mach-imx/imx1-dt.c b/arch/arm/mach-imx/imx1-dt.c
new file mode 100644
index 0000000..05da661
--- /dev/null
+++ b/arch/arm/mach-imx/imx1-dt.c
@@ -0,0 +1,34 @@
+/*
+ *  Copyright (C) 2014 Alexander Shiyan <shc_work@mail.ru>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/of_platform.h>
+#include <asm/mach/arch.h>
+
+#include "common.h"
+
+static void __init imx1_dt_init(void)
+{
+	mxc_arch_reset_init_dt();
+
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+}
+
+static const char * const imx1_dt_board_compat[] __initconst = {
+	"fsl,imx1",
+	NULL
+};
+
+DT_MACHINE_START(IMX1_DT, "Freescale i.MX1 (Device Tree Support)")
+	.map_io		= mx1_map_io,
+	.init_early	= imx1_init_early,
+	.init_irq	= mx1_init_irq,
+	.init_machine	= imx1_dt_init,
+	.dt_compat	= imx1_dt_board_compat,
+	.restart	= mxc_restart,
+MACHINE_END
-- 
1.8.5.5
