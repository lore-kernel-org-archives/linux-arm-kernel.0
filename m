From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sun, 12 Feb 2012 02:34:43 +0900
Subject: [PATCH v2 09/11] ARM: EXYNOS: add support device tree enabled board
 file for EXYNOS5
In-Reply-To: <1328981685-8602-1-git-send-email-kgene.kim@samsung.com>
References: <1328981685-8602-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1328981685-8602-10-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a new EXYNOS5 compatible device tree enabled board
When using this, a corresponding device tree blob which describes the
board's properties should be supplied at boot time to the kernel.

Cc: Thomas Abraham <thomas.abraham@linaro.org>
Cc: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-exynos/Kconfig           |   22 +++++++++-
 arch/arm/mach-exynos/Makefile          |    1 +
 arch/arm/mach-exynos/mach-exynos5-dt.c |   78 ++++++++++++++++++++++++++++++++
 3 files changed, 100 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-exynos/mach-exynos5-dt.c

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index 14b3460..deb8e8a 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -364,7 +364,18 @@ config MACH_SMDK4412
 	  Machine support for Samsung SMDK4412
 endif
 
-comment "Flattened Device Tree based board for Exynos4 based SoC"
+if ARCH_EXYNOS5
+
+comment "EXYNOS5250 Boards"
+
+config MACH_SMDK5250
+	bool "SMDK5250"
+	select SOC_EXYNOS5250
+	help
+	  Machine support for Samsung SMDK5250
+endif
+
+comment "Flattened Device Tree based board for EXYNOS SoCs"
 
 config MACH_EXYNOS4_DT
 	bool "Samsung Exynos4 Machine using device tree"
@@ -378,6 +389,15 @@ config MACH_EXYNOS4_DT
 	  Note: This is under development and not all peripherals can be supported
 	  with this machine file.
 
+config MACH_EXYNOS5_DT
+	bool "SAMSUNG EXYNOS5 Machine using device tree"
+	select SOC_EXYNOS5250
+	select USE_OF
+	select ARM_AMBA
+	help
+	  Machine support for Samsung Exynos4 machine with device tree enabled.
+	  Select this if a fdt blob is available for the EXYNOS4 SoC based board.
+
 if ARCH_EXYNOS4
 
 comment "Configuration for HSMMC 8-bit bus width"
diff --git a/arch/arm/mach-exynos/Makefile b/arch/arm/mach-exynos/Makefile
index 7214092..29967ef 100644
--- a/arch/arm/mach-exynos/Makefile
+++ b/arch/arm/mach-exynos/Makefile
@@ -42,6 +42,7 @@ obj-$(CONFIG_MACH_SMDK4212)		+= mach-smdk4x12.o
 obj-$(CONFIG_MACH_SMDK4412)		+= mach-smdk4x12.o
 
 obj-$(CONFIG_MACH_EXYNOS4_DT)		+= mach-exynos4-dt.o
+obj-$(CONFIG_MACH_EXYNOS5_DT)		+= mach-exynos5-dt.o
 
 # device support
 
diff --git a/arch/arm/mach-exynos/mach-exynos5-dt.c b/arch/arm/mach-exynos/mach-exynos5-dt.c
new file mode 100644
index 0000000..0d26f50
--- /dev/null
+++ b/arch/arm/mach-exynos/mach-exynos5-dt.c
@@ -0,0 +1,78 @@
+/*
+ * SAMSUNG EXYNOS5250 Flattened Device Tree enabled machine
+ *
+ * Copyright (c) 2012 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/of_platform.h>
+#include <linux/serial_core.h>
+
+#include <asm/mach/arch.h>
+#include <asm/hardware/gic.h>
+#include <mach/map.h>
+
+#include <plat/cpu.h>
+#include <plat/regs-serial.h>
+
+#include "common.h"
+
+/*
+ * The following lookup table is used to override device names when devices
+ * are registered from device tree. This is temporarily added to enable
+ * device tree support addition for the EXYNOS5 architecture.
+ *
+ * For drivers that require platform data to be provided from the machine
+ * file, a platform data pointer can also be supplied along with the
+ * devices names. Usually, the platform data elements that cannot be parsed
+ * from the device tree by the drivers (example: function pointers) are
+ * supplied. But it should be noted that this is a temporary mechanism and
+ * at some point, the drivers should be capable of parsing all the platform
+ * data from the device tree.
+ */
+static const struct of_dev_auxdata exynos5250_auxdata_lookup[] __initconst = {
+	OF_DEV_AUXDATA("samsung,exynos4210-uart", EXYNOS5_PA_UART0,
+				"exynos4210-uart.0", NULL),
+	OF_DEV_AUXDATA("samsung,exynos4210-uart", EXYNOS5_PA_UART1,
+				"exynos4210-uart.1", NULL),
+	OF_DEV_AUXDATA("samsung,exynos4210-uart", EXYNOS5_PA_UART2,
+				"exynos4210-uart.2", NULL),
+	OF_DEV_AUXDATA("samsung,exynos4210-uart", EXYNOS5_PA_UART3,
+				"exynos4210-uart.3", NULL),
+	OF_DEV_AUXDATA("arm,pl330", EXYNOS5_PA_PDMA0, "dma-pl330.0", NULL),
+	OF_DEV_AUXDATA("arm,pl330", EXYNOS5_PA_PDMA1, "dma-pl330.1", NULL),
+	OF_DEV_AUXDATA("arm,pl330", EXYNOS5_PA_PDMA1, "dma-pl330.2", NULL),
+	{},
+};
+
+static void __init exynos5250_dt_map_io(void)
+{
+	exynos_init_io(NULL, 0);
+	s3c24xx_init_clocks(24000000);
+}
+
+static void __init exynos5250_dt_machine_init(void)
+{
+	of_platform_populate(NULL, of_default_bus_match_table,
+				exynos5250_auxdata_lookup, NULL);
+}
+
+static char const *exynos5250_dt_compat[] __initdata = {
+	"samsung,exynos5250",
+	NULL
+};
+
+DT_MACHINE_START(EXYNOS5_DT, "SAMSUNG EXYNOS5 (Flattened Device Tree)")
+	/* Maintainer: Kukjin Kim <kgene.kim@samsung.com> */
+	.init_irq	= exynos5_init_irq,
+	.map_io		= exynos5250_dt_map_io,
+	.handle_irq	= gic_handle_irq,
+	.init_machine	= exynos5250_dt_machine_init,
+	.timer		= &exynos4_timer,
+	.dt_compat	= exynos5250_dt_compat,
+	.restart        = exynos5_restart,
+MACHINE_END
-- 
1.7.4.4
