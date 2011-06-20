From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon, 20 Jun 2011 16:32:32 +0530
Subject: [PATCH 6/6] arm: exynos4: Add a new Exynos4 device tree enabled
	machine
In-Reply-To: <1308567752-13451-1-git-send-email-thomas.abraham@linaro.org>
References: <1308567752-13451-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1308567752-13451-7-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Basic Exynos4 machine with device tree support that can boot on a Exynos4
based smdkv310 board and bring up the console.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 Documentation/devicetree/bindings/arm/samsung.txt |    3 +-
 arch/arm/mach-exynos4/Kconfig                     |   11 +++
 arch/arm/mach-exynos4/Makefile                    |    1 +
 arch/arm/mach-exynos4/mach-exynos4-dt.c           |   94 +++++++++++++++++++++
 4 files changed, 108 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-exynos4/mach-exynos4-dt.c

diff --git a/Documentation/devicetree/bindings/arm/samsung.txt b/Documentation/devicetree/bindings/arm/samsung.txt
index 594cb97..80d29bb 100644
--- a/Documentation/devicetree/bindings/arm/samsung.txt
+++ b/Documentation/devicetree/bindings/arm/samsung.txt
@@ -4,6 +4,7 @@ Samsung Exynos4 S5PV310 SoC based SMDKV310 eval board
     Samsung's Exynos4 family of application processors.
 
 Required root node properties:
-    - compatible = "samsung,smdkv310","samsung,s5pv310"
+    - compatible = "samsung,smdkv310","samsung,s5pv310", "samsung,exynos4210'.
         (a) "samsung,smdkv310" - for Samsung's SMDKV310 eval board.
         (b) "samsung,s5pv310"  - for boards based on S5PV310 SoC.
+	(c) "samsung,exynos4210" - for boards based on Exynos4210 processor.
diff --git a/arch/arm/mach-exynos4/Kconfig b/arch/arm/mach-exynos4/Kconfig
index 1435fc3..412e0c5 100644
--- a/arch/arm/mach-exynos4/Kconfig
+++ b/arch/arm/mach-exynos4/Kconfig
@@ -186,6 +186,17 @@ config MACH_NURI
 	help
 	  Machine support for Samsung Mobile NURI Board.
 
+config MACH_EXYNOS4_DT
+	bool "Samsung's Exynos4 Machine with DT support"
+	select CPU_EXYNOS4210
+	select USE_OF
+	select S3C_DEV_WDT
+	select S3C_DEV_HSMMC
+	select S3C_DEV_HSMMC2
+	select EXYNOS4_SETUP_SDHCI
+	help
+	  Machine support for Samsung Exynos4 machine with device tree enabled.
+
 endmenu
 
 comment "Configuration for HSMMC bus width"
diff --git a/arch/arm/mach-exynos4/Makefile b/arch/arm/mach-exynos4/Makefile
index 60fe5ec..6491e5b 100644
--- a/arch/arm/mach-exynos4/Makefile
+++ b/arch/arm/mach-exynos4/Makefile
@@ -36,6 +36,7 @@ obj-$(CONFIG_MACH_SMDKV310)		+= mach-smdkv310.o
 obj-$(CONFIG_MACH_ARMLEX4210)		+= mach-armlex4210.o
 obj-$(CONFIG_MACH_UNIVERSAL_C210)	+= mach-universal_c210.o
 obj-$(CONFIG_MACH_NURI)			+= mach-nuri.o
+obj-$(CONFIG_MACH_EXYNOS4_DT)		+= mach-exynos4-dt.o
 
 # device support
 
diff --git a/arch/arm/mach-exynos4/mach-exynos4-dt.c b/arch/arm/mach-exynos4/mach-exynos4-dt.c
new file mode 100644
index 0000000..34267d8
--- /dev/null
+++ b/arch/arm/mach-exynos4/mach-exynos4-dt.c
@@ -0,0 +1,94 @@
+/*
+ * Samsung's Exynos4210 device tree enabled machine.
+ *
+ * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ * Copyright (c) 2010-2011 Linaro Ltd.
+ * 		www.linaro.org
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
+static struct s3c_sdhci_platdata smdkv310_hsmmc0_pdata __initdata = {
+	.cd_type		= S3C_SDHCI_CD_INTERNAL,
+	.clk_type		= S3C_SDHCI_CLK_DIV_EXTERNAL,
+#ifdef CONFIG_EXYNOS4_SDHCI_CH0_8BIT
+	.max_width		= 8,
+	.host_caps		= MMC_CAP_8_BIT_DATA,
+#endif
+};
+
+static struct s3c_sdhci_platdata smdkv310_hsmmc2_pdata __initdata = {
+	.cd_type		= S3C_SDHCI_CD_INTERNAL,
+	.clk_type		= S3C_SDHCI_CLK_DIV_EXTERNAL,
+#ifdef CONFIG_EXYNOS4_SDHCI_CH2_8BIT
+	.max_width		= 8,
+	.host_caps		= MMC_CAP_8_BIT_DATA,
+#endif
+};
+
+static const struct of_dev_auxdata exynos4_auxdata_lookup[] __initconst = {
+	OF_DEV_AUXDATA("samsung,s3c-sdhci", EXYNOS4_PA_HSMMC(2),
+				"s3c-sdhci.2", &s3c_hsmmc2_def_platdata),
+	OF_DEV_AUXDATA("samsung,s3c-sdhci", EXYNOS4_PA_HSMMC(0),
+				"s3c-sdhci.0", &s3c_hsmmc0_def_platdata),
+	OF_DEV_AUXDATA("samsung,s5pv210-uart", S5P_PA_UART0,
+				"s5pv210-uart.0", NULL),
+	OF_DEV_AUXDATA("samsung,s5pv210-uart", S5P_PA_UART1,
+				"s5pv210-uart.1", NULL),
+	{},
+};
+
+static void __init exynos4_dt_map_io(void)
+{
+	s5p_init_io(NULL, 0, S5P_VA_CHIPID);
+	s3c24xx_init_clocks(24000000);
+}
+
+static const struct of_device_id intc_of_match[] __initconst = {
+	{ .compatible = "samsung,exynos4-gic", },
+	{}
+};
+
+static void __init exynos4_dt_machine_init(void)
+{
+	s3c_sdhci0_set_platdata(&smdkv310_hsmmc0_pdata);
+	s3c_sdhci2_set_platdata(&smdkv310_hsmmc2_pdata);
+
+	irq_domain_generate_simple(intc_of_match, EXYNOS4_PA_GIC_DIST, 0);
+	of_platform_populate(NULL, of_default_bus_match_table,
+				exynos4_auxdata_lookup, NULL);
+}
+
+static char const *exynos4_dt_compat[] __initdata = {
+	"samsung,exynos4210",
+	NULL
+};
+
+DT_MACHINE_START(SMDKV310, "Samsung Exynos4 DT")
+	/* Maintainer: Kukjin Kim <kgene.kim@samsung.com> */
+	.boot_params	= S5P_PA_SDRAM + 0x100,
+	.init_irq	= exynos4_init_irq,
+	.map_io		= exynos4_dt_map_io,
+	.init_machine	= exynos4_dt_machine_init,
+	.timer		= &exynos4_timer,
+	.dt_compat	= exynos4_dt_compat,
+MACHINE_END
-- 
1.6.6.rc2
