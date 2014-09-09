From: jingchang.lu@freescale.com (Jingchang Lu)
Date: Tue, 9 Sep 2014 17:12:31 +0800
Subject: [PATCHv3 5/6] ARM: imx: Add initial support for Freescale LS1021A
In-Reply-To: <1410253952-15631-1-git-send-email-jingchang.lu@freescale.com>
References: <1410253952-15631-1-git-send-email-jingchang.lu@freescale.com>
Message-ID: <1410253952-15631-6-git-send-email-jingchang.lu@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jingchang Lu <b35083@freescale.com>

The LS1021A SoC is a dual-core Cortex-A7 based processor,
this add the initial support for it.

Signed-off-by: Jingchang Lu <b35083@freescale.com>
---
 arch/arm/mach-imx/Kconfig        | 14 ++++++++++++++
 arch/arm/mach-imx/Makefile       |  2 ++
 arch/arm/mach-imx/mach-ls1021a.c | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 49 insertions(+)
 create mode 100644 arch/arm/mach-imx/mach-ls1021a.c

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 3da9f71..ba7a089 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -651,6 +651,20 @@ config SOC_VF610
 	help
 	  This enable support for Freescale Vybrid VF610 processor.
 
+config SOC_LS1021A
+	bool "Freescale LS1021A support"
+	select CPU_V7
+	select ARM_GIC
+	select CLKSRC_OF
+	select HAVE_ARM_ARCH_TIMER
+	select HAVE_SMP
+	select MIGHT_HAVE_PCI
+	select PCI_DOMAINS if PCI
+	select ZONE_DMA if ARM_LPAE
+
+	help
+	  This enable support for Freescale LS1021A processor.
+
 endif
 
 source "arch/arm/mach-imx/devices/Kconfig"
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index dd674c7..3e12532 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -111,4 +111,6 @@ obj-$(CONFIG_SOC_IMX53) += mach-imx53.o
 
 obj-$(CONFIG_SOC_VF610) += clk-vf610.o mach-vf610.o
 
+obj-$(CONFIG_SOC_LS1021A) += mach-ls1021a.o
+
 obj-y += devices/
diff --git a/arch/arm/mach-imx/mach-ls1021a.c b/arch/arm/mach-imx/mach-ls1021a.c
new file mode 100644
index 0000000..2ffc20f
--- /dev/null
+++ b/arch/arm/mach-imx/mach-ls1021a.c
@@ -0,0 +1,33 @@
+/*
+ * Copyright 2013-2014 Freescale Semiconductor, Inc.
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
+static void __init ls1021a_init_machine(void)
+{
+	mxc_arch_reset_init_dt();
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+}
+
+static const char *ls1021a_dt_compat[] __initdata = {
+	"fsl,ls1021a",
+	NULL,
+};
+
+DT_MACHINE_START(LS1021A, "Freescale LS1021A")
+#ifdef CONFIG_ZONE_DMA
+	.dma_zone_size	= SZ_128M,
+#endif
+	.init_machine   = ls1021a_init_machine,
+	.dt_compat	= ls1021a_dt_compat,
+	.restart	= mxc_restart,
+MACHINE_END
-- 
1.8.0
