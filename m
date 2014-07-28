From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Mon, 28 Jul 2014 20:51:20 +0800
Subject: [PATCH v5 5/8] power: reset: move hisilicon reboot code
In-Reply-To: <1406551883-26154-1-git-send-email-haojian.zhuang@linaro.org>
References: <1406551883-26154-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1406551883-26154-6-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move reboot code from hisilicon platform driver into reset driver.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 arch/arm/mach-hisi/Kconfig        |  3 ++
 arch/arm/mach-hisi/hisilicon.c    | 33 -------------------
 drivers/power/reset/Kconfig       |  6 ++++
 drivers/power/reset/Makefile      |  1 +
 drivers/power/reset/hisi-reboot.c | 67 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 77 insertions(+), 33 deletions(-)
 create mode 100644 drivers/power/reset/hisi-reboot.c

diff --git a/arch/arm/mach-hisi/Kconfig b/arch/arm/mach-hisi/Kconfig
index 90fdbb4..9848829 100644
--- a/arch/arm/mach-hisi/Kconfig
+++ b/arch/arm/mach-hisi/Kconfig
@@ -4,6 +4,9 @@ config ARCH_HISI
 	select ARM_AMBA
 	select ARM_GIC
 	select ARM_TIMER_SP804
+	select POWER_RESET
+	select POWER_RESET_HISI
+	select POWER_SUPPLY
 
 if ARCH_HISI
 
diff --git a/arch/arm/mach-hisi/hisilicon.c b/arch/arm/mach-hisi/hisilicon.c
index 2bfbe3f..7996c6b 100644
--- a/arch/arm/mach-hisi/hisilicon.c
+++ b/arch/arm/mach-hisi/hisilicon.c
@@ -14,10 +14,6 @@
 #include <linux/clk-provider.h>
 #include <linux/clocksource.h>
 #include <linux/irqchip.h>
-#include <linux/of_address.h>
-#include <linux/of_platform.h>
-
-#include <asm/proc-fns.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -51,32 +47,6 @@ static void __init hi3620_map_io(void)
 	iotable_init(hi3620_io_desc, ARRAY_SIZE(hi3620_io_desc));
 }
 
-static void hi3xxx_restart(enum reboot_mode mode, const char *cmd)
-{
-	struct device_node *np;
-	void __iomem *base;
-	int offset;
-
-	np = of_find_compatible_node(NULL, NULL, "hisilicon,sysctrl");
-	if (!np) {
-		pr_err("failed to find hisilicon,sysctrl node\n");
-		return;
-	}
-	base = of_iomap(np, 0);
-	if (!base) {
-		pr_err("failed to map address in hisilicon,sysctrl node\n");
-		return;
-	}
-	if (of_property_read_u32(np, "reboot-offset", &offset) < 0) {
-		pr_err("failed to find reboot-offset property\n");
-		return;
-	}
-	writel_relaxed(0xdeadbeef, base + offset);
-
-	while (1)
-		cpu_do_idle();
-}
-
 static const char *hi3xxx_compat[] __initconst = {
 	"hisilicon,hi3620-hi4511",
 	NULL,
@@ -86,7 +56,6 @@ DT_MACHINE_START(HI3620, "Hisilicon Hi3620 (Flattened Device Tree)")
 	.map_io		= hi3620_map_io,
 	.dt_compat	= hi3xxx_compat,
 	.smp		= smp_ops(hi3xxx_smp_ops),
-	.restart	= hi3xxx_restart,
 MACHINE_END
 
 static const char *hix5hd2_compat[] __initconst = {
@@ -96,7 +65,5 @@ static const char *hix5hd2_compat[] __initconst = {
 
 DT_MACHINE_START(HIX5HD2_DT, "Hisilicon HIX5HD2 (Flattened Device Tree)")
 	.dt_compat	= hix5hd2_compat,
-	.init_late	= hi3xxx_init_late,
 	.smp		= smp_ops(hix5hd2_smp_ops),
-	.restart	= hi3xxx_restart,
 MACHINE_END
diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index bdcf517..4127f49 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -28,6 +28,12 @@ config POWER_RESET_GPIO
 	  If your board needs a GPIO high/low to power down, say Y and
 	  create a binding in your devicetree.
 
+config POWER_RESET_HISI
+	bool "Hisilicon power-off driver"
+	depends on POWER_RESET && ARCH_HISI
+	help
+	  Reboot support for Hisilicon boards.
+
 config POWER_RESET_MSM
 	bool "Qualcomm MSM power-off driver"
 	depends on POWER_RESET && ARCH_QCOM
diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
index dde2e8b..fe0f228 100644
--- a/drivers/power/reset/Makefile
+++ b/drivers/power/reset/Makefile
@@ -1,6 +1,7 @@
 obj-$(CONFIG_POWER_RESET_AS3722) += as3722-poweroff.o
 obj-$(CONFIG_POWER_RESET_AXXIA) += axxia-reset.o
 obj-$(CONFIG_POWER_RESET_GPIO) += gpio-poweroff.o
+obj-$(CONFIG_POWER_RESET_HISI) += hisi-reboot.o
 obj-$(CONFIG_POWER_RESET_MSM) += msm-poweroff.o
 obj-$(CONFIG_POWER_RESET_QNAP) += qnap-poweroff.o
 obj-$(CONFIG_POWER_RESET_RESTART) += restart-poweroff.o
diff --git a/drivers/power/reset/hisi-reboot.c b/drivers/power/reset/hisi-reboot.c
new file mode 100644
index 0000000..0c91d02
--- /dev/null
+++ b/drivers/power/reset/hisi-reboot.c
@@ -0,0 +1,67 @@
+/*
+ * Hisilicon SoC reset code
+ *
+ * Copyright (c) 2014 Hisilicon Ltd.
+ * Copyright (c) 2014 Linaro Ltd.
+ *
+ * Author: Haojian Zhuang <haojian.zhuang@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/reboot.h>
+
+#include <asm/proc-fns.h>
+#include <asm/system_misc.h>
+
+static void __iomem *base;
+static u32 reboot_offset;
+
+static void hisi_restart(enum reboot_mode mode, const char *cmd)
+{
+	writel_relaxed(0xdeadbeef, base + reboot_offset);
+
+	while (1)
+		cpu_do_idle();
+}
+
+static int hisi_reboot_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+
+	base = of_iomap(np, 0);
+	if (!base) {
+		WARN(1, "failed to map base address");
+		return -ENODEV;
+	}
+
+	if (of_property_read_u32(np, "reboot-offset", &reboot_offset) < 0) {
+		pr_err("failed to find reboot-offset property\n");
+		return -EINVAL;
+	}
+
+	arm_pm_restart = hisi_restart;
+
+	return 0;
+}
+
+static struct of_device_id hisi_reboot_of_match[] = {
+	{ .compatible = "hisilicon,sysctrl" },
+	{}
+};
+
+static struct platform_driver hisi_reboot_driver = {
+	.probe = hisi_reboot_probe,
+	.driver = {
+		.name = "hisi-reboot",
+		.of_match_table = hisi_reboot_of_match,
+	},
+};
+module_platform_driver(hisi_reboot_driver);
-- 
1.9.1
