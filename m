From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 16 Feb 2013 18:37:39 +0100
Subject: [PATCH v3 2/4] ARM: s3c64xx: Add board file for boot using Device Tree
In-Reply-To: <1361036261-8315-1-git-send-email-tomasz.figa@gmail.com>
References: <1361036261-8315-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <1361036261-8315-3-git-send-email-tomasz.figa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds board file that will be used to boot S3C64xx-based boards
using Device Tree.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 arch/arm/mach-s3c64xx/Kconfig           | 14 +++++
 arch/arm/mach-s3c64xx/Makefile          |  1 +
 arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c | 94 +++++++++++++++++++++++++++++++++
 3 files changed, 109 insertions(+)
 create mode 100644 arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c

diff --git a/arch/arm/mach-s3c64xx/Kconfig b/arch/arm/mach-s3c64xx/Kconfig
index 283cb77..771e2c2 100644
--- a/arch/arm/mach-s3c64xx/Kconfig
+++ b/arch/arm/mach-s3c64xx/Kconfig
@@ -311,3 +311,17 @@ config MACH_WLF_CRAGG_6410
 	select SAMSUNG_GPIO_EXTRA128
 	help
 	  Machine support for the Wolfson Cragganmore S3C6410 variant.
+
+config MACH_S3C64XX_DT
+	bool "Samsung S3C6400/S3C6410 machine using Device Tree"
+	select CLKSRC_OF
+	select CPU_S3C6400
+	select CPU_S3C6410
+	select USE_OF
+	help
+	  Machine support for Samsung S3C6400/S3C6410 machines with Device Tree
+	  enabled.
+	  Select this if a fdt blob is available for your S3C64XX SoC based
+	  board.
+	  Note: This is under development and not all peripherals can be
+	  supported with this machine file.
diff --git a/arch/arm/mach-s3c64xx/Makefile b/arch/arm/mach-s3c64xx/Makefile
index f9ce1dc..59b3d06 100644
--- a/arch/arm/mach-s3c64xx/Makefile
+++ b/arch/arm/mach-s3c64xx/Makefile
@@ -58,3 +58,4 @@ obj-$(CONFIG_MACH_SMARTQ7)		+= mach-smartq7.o
 obj-$(CONFIG_MACH_SMDK6400)		+= mach-smdk6400.o
 obj-$(CONFIG_MACH_SMDK6410)		+= mach-smdk6410.o
 obj-$(CONFIG_MACH_WLF_CRAGG_6410)	+= mach-crag6410.o mach-crag6410-module.o
+obj-$(CONFIG_MACH_S3C64XX_DT)		+= mach-s3c64xx-dt.o
diff --git a/arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c b/arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c
new file mode 100644
index 0000000..c2e56aa
--- /dev/null
+++ b/arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c
@@ -0,0 +1,94 @@
+/*
+ * Samsung's S3C64XX flattened device tree enabled machine
+ *
+ * Copyright (c) 2013 Tomasz Figa <tomasz.figa@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/clocksource.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+#include <linux/serial_core.h>
+
+#include <asm/mach/arch.h>
+#include <asm/hardware/vic.h>
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
+ * device tree support addition for the S3C64xx architecture.
+ *
+ * For drivers that require platform data to be provided from the machine
+ * file, a platform data pointer can also be supplied along with the
+ * devices names. Usually, the platform data elements that cannot be parsed
+ * from the device tree by the drivers (example: function pointers) are
+ * supplied. But it should be noted that this is a temporary mechanism and
+ * at some point, the drivers should be capable of parsing all the platform
+ * data from the device tree.
+ */
+static const struct of_dev_auxdata s3c64xx_auxdata_lookup[] __initconst = {
+	OF_DEV_AUXDATA("samsung,s3c6400-uart", 0x7f005000,
+				"s3c6400-uart.0", NULL),
+	OF_DEV_AUXDATA("samsung,s3c6400-uart", 0x7f005400,
+				"s3c6400-uart.1", NULL),
+	OF_DEV_AUXDATA("samsung,s3c6400-uart", 0x7f005800,
+				"s3c6400-uart.2", NULL),
+	OF_DEV_AUXDATA("samsung,s3c6400-uart", 0x7f005c00,
+				"s3c6400-uart.3", NULL),
+	OF_DEV_AUXDATA("samsung,s3c6410-sdhci", 0x7c200000,
+				"s3c-sdhci.0", NULL),
+	OF_DEV_AUXDATA("samsung,s3c6410-sdhci", 0x7c300000,
+				"s3c-sdhci.1", NULL),
+	OF_DEV_AUXDATA("samsung,s3c6410-sdhci", 0x7c400000,
+				"s3c-sdhci.2", NULL),
+	{},
+};
+
+static void __init s3c64xx_dt_init_irq(void)
+{
+	static const struct of_device_id vic_of_match[] = {
+		{ .compatible = "arm,pl192-vic", .data = vic_of_init, },
+		{},
+	};
+
+	of_irq_init(vic_of_match);
+}
+
+static void __init s3c64xx_dt_map_io(void)
+{
+	s3c64xx_init_io(NULL, 0);
+	s3c24xx_init_clocks(12000000);
+}
+
+static void __init s3c64xx_dt_machine_init(void)
+{
+	of_platform_populate(NULL, of_default_bus_match_table,
+				s3c64xx_auxdata_lookup, NULL);
+}
+
+static char const *s3c64xx_dt_compat[] __initdata = {
+	"samsung,s3c6400",
+	"samsung,s3c6410",
+	NULL
+};
+
+DT_MACHINE_START(S3C6400_DT, "Samsung S3C64xx (Flattened Device Tree)")
+	/* Maintainer: Tomasz Figa <tomasz.figa@gmail.com> */
+	.init_irq	= s3c64xx_dt_init_irq,
+	.map_io		= s3c64xx_dt_map_io,
+	.handle_irq	= vic_handle_irq,
+	.init_machine	= s3c64xx_dt_machine_init,
+	.init_late	= s3c64xx_init_late,
+	.init_time	= clocksource_of_init,
+	.dt_compat	= s3c64xx_dt_compat,
+	.restart        = s3c64xx_restart,
+MACHINE_END
-- 
1.8.1.2
