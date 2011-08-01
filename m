From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon,  1 Aug 2011 17:20:36 +0100
Subject: [PATCH 1/2] arm: exynos4: Add a new Exynos4 device tree enabled
	machine
In-Reply-To: <1312215637-716-1-git-send-email-thomas.abraham@linaro.org>
References: <1312215637-716-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1312215637-716-2-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a new basic Exynos4 machine with device tree support that can boot
on a Exynos4 processor based board and bring up the console. This acts
as a stating point to add device tree support for Exynos4 architecture.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/mach-exynos4/Kconfig           |   10 +++
 arch/arm/mach-exynos4/Makefile          |    1 +
 arch/arm/mach-exynos4/mach-exynos4-dt.c |  118 +++++++++++++++++++++++++++++++
 3 files changed, 129 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-exynos4/mach-exynos4-dt.c

diff --git a/arch/arm/mach-exynos4/Kconfig b/arch/arm/mach-exynos4/Kconfig
index 0c77ab9..c29de4e 100644
--- a/arch/arm/mach-exynos4/Kconfig
+++ b/arch/arm/mach-exynos4/Kconfig
@@ -218,6 +218,16 @@ config MACH_NURI
 	help
 	  Machine support for Samsung Mobile NURI Board.
 
+config MACH_EXYNOS4_DT
+	bool "Samsung Exynos4 Machine using device tree"
+	select CPU_EXYNOS4210
+	select USE_OF
+	select S3C_DEV_HSMMC
+	select S3C_DEV_HSMMC2
+	select EXYNOS4_SETUP_SDHCI
+	help
+	  Machine support for Samsung Exynos4 machine with device tree enabled.
+
 endmenu
 
 comment "Configuration for HSMMC bus width"
diff --git a/arch/arm/mach-exynos4/Makefile b/arch/arm/mach-exynos4/Makefile
index b7fe1d7..d2bf5bf 100644
--- a/arch/arm/mach-exynos4/Makefile
+++ b/arch/arm/mach-exynos4/Makefile
@@ -30,6 +30,7 @@ obj-$(CONFIG_MACH_SMDKV310)		+= mach-smdkv310.o
 obj-$(CONFIG_MACH_ARMLEX4210)		+= mach-armlex4210.o
 obj-$(CONFIG_MACH_UNIVERSAL_C210)	+= mach-universal_c210.o
 obj-$(CONFIG_MACH_NURI)			+= mach-nuri.o
+obj-$(CONFIG_MACH_EXYNOS4_DT)		+= mach-exynos4-dt.o
 
 # device support
 
diff --git a/arch/arm/mach-exynos4/mach-exynos4-dt.c b/arch/arm/mach-exynos4/mach-exynos4-dt.c
new file mode 100644
index 0000000..8e9d2d7
--- /dev/null
+++ b/arch/arm/mach-exynos4/mach-exynos4-dt.c
@@ -0,0 +1,118 @@
+/*
+ * Samsung's Exynos4 device tree enabled machine.
+ *
+ * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ * Copyright (c) 2010-2011 Linaro Ltd.
+ *		www.linaro.org
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/serial_core.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+#include <linux/of_platform.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+
+#include <asm/mach/arch.h>
+#include <asm/mach-types.h>
+
+#include <plat/regs-serial.h>
+#include <plat/exynos4.h>
+#include <plat/cpu.h>
+#include <plat/sdhci.h>
+
+#include <mach/map.h>
+
+/* Following are default values for UCON, ULCON and UFCON UART registers */
+#define SMDKV310_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
+				 S3C2410_UCON_RXILEVEL |	\
+				 S3C2410_UCON_TXIRQMODE |	\
+				 S3C2410_UCON_RXIRQMODE |	\
+				 S3C2410_UCON_RXFIFO_TOI |	\
+				 S3C2443_UCON_RXERR_IRQEN)
+
+#define SMDKV310_UFCON_DEFAULT	(S3C2410_UFCON_FIFOMODE |	\
+				 S5PV210_UFCON_TXTRIG4 |	\
+				 S5PV210_UFCON_RXTRIG4)
+
+static struct s3c2410_uartcfg smdkv310_uartcfgs[] __initdata = {
+	[0] = {
+		.hwport		= 0,
+		.ucon		= SMDKV310_UCON_DEFAULT,
+		.ufcon		= SMDKV310_UFCON_DEFAULT,
+	},
+	[1] = {
+		.hwport		= 1,
+		.ucon		= SMDKV310_UCON_DEFAULT,
+		.ufcon		= SMDKV310_UFCON_DEFAULT,
+	},
+	[2] = {
+		.hwport		= 2,
+		.ucon		= SMDKV310_UCON_DEFAULT,
+		.ufcon		= SMDKV310_UFCON_DEFAULT,
+	},
+	[3] = {
+		.hwport		= 3,
+		.ucon		= SMDKV310_UCON_DEFAULT,
+		.ufcon		= SMDKV310_UFCON_DEFAULT,
+	},
+};
+
+/*
+ * The following lookup table is used to override device names when devices
+ * are registered from device tree. This is temporarily added to enable
+ * device tree support addition for the Exynos4 architecture.
+ *
+ * For drivers that require platform data to be provided from the machine
+ * file, a platform data pointer can also be supplied along with the
+ * devices names. Usually, the platform data elements that cannot be parsed
+ * from the device tree by the drivers (example: function pointers) are
+ * supplied. But it should be noted that this is a temporary mechanism and
+ * at some point, the drivers should be capable of parsing all the platform
+ * data from the device tree.
+ */
+static const struct of_dev_auxdata exynos4_auxdata_lookup[] __initconst = {
+	OF_DEV_AUXDATA("samsung,s3c6410-sdhci", EXYNOS4_PA_HSMMC(2),
+				"s3c-sdhci.2", &s3c_hsmmc2_def_platdata),
+	OF_DEV_AUXDATA("samsung,s3c6410-sdhci", EXYNOS4_PA_HSMMC(0),
+				"s3c-sdhci.0", &s3c_hsmmc0_def_platdata),
+	{},
+};
+
+static void __init exynos4_dt_map_io(void)
+{
+	s5p_init_io(NULL, 0, S5P_VA_CHIPID);
+	s3c24xx_init_clocks(24000000);
+	s3c24xx_init_uarts(smdkv310_uartcfgs, ARRAY_SIZE(smdkv310_uartcfgs));
+}
+
+static const struct of_device_id intc_of_match[] __initconst = {
+	{ .compatible = "samsung,exynos4-gic", },
+	{},
+};
+
+static void __init exynos4_dt_machine_init(void)
+{
+	irq_domain_generate_simple(intc_of_match, EXYNOS4_PA_GIC_DIST, 0);
+	of_platform_populate(NULL, of_default_bus_match_table,
+				exynos4_auxdata_lookup, NULL);
+}
+
+static char const *exynos4_dt_compat[] __initdata = {
+	"samsung,exynos4",
+	NULL
+};
+
+DT_MACHINE_START(SMDKV310, "Samsung Exynos4 DT")
+	/* Maintainer: Kukjin Kim <kgene.kim@samsung.com> */
+	.init_irq	= exynos4_init_irq,
+	.map_io		= exynos4_dt_map_io,
+	.init_machine	= exynos4_dt_machine_init,
+	.timer		= &exynos4_timer,
+	.dt_compat	= exynos4_dt_compat,
+MACHINE_END
-- 
1.7.4.1
