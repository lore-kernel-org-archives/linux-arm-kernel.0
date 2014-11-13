From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 13 Nov 2014 10:32:56 +0100
Subject: [PATCH 4/4] soc: move SoC driver for the ARM Integrator
In-Reply-To: <1415871176-11368-1-git-send-email-linus.walleij@linaro.org>
References: <1415871176-11368-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1415871176-11368-4-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This creates a new SoC bus driver for the ARM Integrator
family core modules to register the SoC bus and provide
sysfs info for the core module. We delete the corresponding
code from the Integrator machine and select this driver to
get a clean result.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-integrator/Kconfig         |   1 +
 arch/arm/mach-integrator/common.h        |   1 -
 arch/arm/mach-integrator/core.c          |  95 -------------------
 arch/arm/mach-integrator/integrator_ap.c |  27 ------
 arch/arm/mach-integrator/integrator_cp.c |  27 ------
 drivers/soc/versatile/Kconfig            |   9 ++
 drivers/soc/versatile/Makefile           |   1 +
 drivers/soc/versatile/soc-integrator.c   | 154 +++++++++++++++++++++++++++++++
 8 files changed, 165 insertions(+), 150 deletions(-)
 create mode 100644 drivers/soc/versatile/soc-integrator.c

diff --git a/arch/arm/mach-integrator/Kconfig b/arch/arm/mach-integrator/Kconfig
index 62e6db4bd533..02d083489a26 100644
--- a/arch/arm/mach-integrator/Kconfig
+++ b/arch/arm/mach-integrator/Kconfig
@@ -14,6 +14,7 @@ config ARCH_INTEGRATOR
 	select POWER_RESET
 	select POWER_RESET_VERSATILE
 	select POWER_SUPPLY
+	select SOC_INTEGRATOR_CM
 	select SPARSE_IRQ
 	select USE_OF
 	select VERSATILE_FPGA_IRQ
diff --git a/arch/arm/mach-integrator/common.h b/arch/arm/mach-integrator/common.h
index 27a627aa1e8f..96c9dc56cabf 100644
--- a/arch/arm/mach-integrator/common.h
+++ b/arch/arm/mach-integrator/common.h
@@ -4,4 +4,3 @@ extern struct amba_pl010_data ap_uart_data;
 void integrator_init_early(void);
 int integrator_init(bool is_cp);
 void integrator_reserve(void);
-void integrator_init_sysfs(struct device *parent, u32 id);
diff --git a/arch/arm/mach-integrator/core.c b/arch/arm/mach-integrator/core.c
index b06fd9f99a46..948872a419c1 100644
--- a/arch/arm/mach-integrator/core.c
+++ b/arch/arm/mach-integrator/core.c
@@ -60,40 +60,6 @@ void cm_control(u32 mask, u32 set)
 	raw_spin_unlock_irqrestore(&cm_lock, flags);
 }
 
-static const char *integrator_arch_str(u32 id)
-{
-	switch ((id >> 16) & 0xff) {
-	case 0x00:
-		return "ASB little-endian";
-	case 0x01:
-		return "AHB little-endian";
-	case 0x03:
-		return "AHB-Lite system bus, bi-endian";
-	case 0x04:
-		return "AHB";
-	case 0x08:
-		return "AHB system bus, ASB processor bus";
-	default:
-		return "Unknown";
-	}
-}
-
-static const char *integrator_fpga_str(u32 id)
-{
-	switch ((id >> 12) & 0xf) {
-	case 0x01:
-		return "XC4062";
-	case 0x02:
-		return "XC4085";
-	case 0x03:
-		return "XVC600";
-	case 0x04:
-		return "EPM7256AE (Altera PLD)";
-	default:
-		return "Unknown";
-	}
-}
-
 void cm_clear_irqs(void)
 {
 	/* disable core module IRQs */
@@ -109,7 +75,6 @@ static const struct of_device_id cm_match[] = {
 void cm_init(void)
 {
 	struct device_node *cm = of_find_matching_node(NULL, cm_match);
-	u32 val;
 
 	if (!cm) {
 		pr_crit("no core module node found in device tree\n");
@@ -121,13 +86,6 @@ void cm_init(void)
 		return;
 	}
 	cm_clear_irqs();
-	val = readl(cm_base + INTEGRATOR_HDR_ID_OFFSET);
-	pr_info("Detected ARM core module:\n");
-	pr_info("    Manufacturer: %02x\n", (val >> 24));
-	pr_info("    Architecture: %s\n", integrator_arch_str(val));
-	pr_info("    FPGA: %s\n", integrator_fpga_str(val));
-	pr_info("    Build: %02x\n", (val >> 4) & 0xFF);
-	pr_info("    Rev: %c\n", ('A' + (val & 0x03)));
 }
 
 /*
@@ -139,56 +97,3 @@ void __init integrator_reserve(void)
 {
 	memblock_reserve(PHYS_OFFSET, __pa(swapper_pg_dir) - PHYS_OFFSET);
 }
-
-static u32 integrator_id;
-
-static ssize_t intcp_get_manf(struct device *dev,
-			      struct device_attribute *attr,
-			      char *buf)
-{
-	return sprintf(buf, "%02x\n", integrator_id >> 24);
-}
-
-static struct device_attribute intcp_manf_attr =
-	__ATTR(manufacturer,  S_IRUGO, intcp_get_manf,  NULL);
-
-static ssize_t intcp_get_arch(struct device *dev,
-			      struct device_attribute *attr,
-			      char *buf)
-{
-	return sprintf(buf, "%s\n", integrator_arch_str(integrator_id));
-}
-
-static struct device_attribute intcp_arch_attr =
-	__ATTR(architecture,  S_IRUGO, intcp_get_arch,  NULL);
-
-static ssize_t intcp_get_fpga(struct device *dev,
-			      struct device_attribute *attr,
-			      char *buf)
-{
-	return sprintf(buf, "%s\n", integrator_fpga_str(integrator_id));
-}
-
-static struct device_attribute intcp_fpga_attr =
-	__ATTR(fpga,  S_IRUGO, intcp_get_fpga,  NULL);
-
-static ssize_t intcp_get_build(struct device *dev,
-			       struct device_attribute *attr,
-			       char *buf)
-{
-	return sprintf(buf, "%02x\n", (integrator_id >> 4) & 0xFF);
-}
-
-static struct device_attribute intcp_build_attr =
-	__ATTR(build,  S_IRUGO, intcp_get_build,  NULL);
-
-
-
-void integrator_init_sysfs(struct device *parent, u32 id)
-{
-	integrator_id = id;
-	device_create_file(parent, &intcp_manf_attr);
-	device_create_file(parent, &intcp_arch_attr);
-	device_create_file(parent, &intcp_fpga_attr);
-	device_create_file(parent, &intcp_build_attr);
-}
diff --git a/arch/arm/mach-integrator/integrator_ap.c b/arch/arm/mach-integrator/integrator_ap.c
index e6854c3f854e..30003ba447a5 100644
--- a/arch/arm/mach-integrator/integrator_ap.c
+++ b/arch/arm/mach-integrator/integrator_ap.c
@@ -35,7 +35,6 @@
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/stat.h>
-#include <linux/sys_soc.h>
 #include <linux/termios.h>
 
 #include <asm/hardware/arm_timer.h>
@@ -288,10 +287,6 @@ static void __init ap_init_of(void)
 	unsigned long sc_dec;
 	struct device_node *syscon;
 	struct device_node *ebi;
-	struct device *parent;
-	struct soc_device *soc_dev;
-	struct soc_device_attribute *soc_dev_attr;
-	u32 ap_sc_id;
 	int i;
 
 	syscon = of_find_matching_node(NULL, ap_syscon_match);
@@ -311,28 +306,6 @@ static void __init ap_init_of(void)
 	of_platform_populate(NULL, of_default_bus_match_table,
 			ap_auxdata_lookup, NULL);
 
-	ap_sc_id = readl(ap_syscon_base);
-
-	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
-	if (!soc_dev_attr)
-		return;
-
-	soc_dev_attr->soc_id = "XVC";
-	soc_dev_attr->machine = "Integrator/AP";
-	soc_dev_attr->family = "Integrator";
-	soc_dev_attr->revision = kasprintf(GFP_KERNEL, "%c",
-					   'A' + (ap_sc_id & 0x0f));
-
-	soc_dev = soc_device_register(soc_dev_attr);
-	if (IS_ERR(soc_dev)) {
-		kfree(soc_dev_attr->revision);
-		kfree(soc_dev_attr);
-		return;
-	}
-
-	parent = soc_device_to_device(soc_dev);
-	integrator_init_sysfs(parent, ap_sc_id);
-
 	sc_dec = readl(ap_syscon_base + INTEGRATOR_SC_DEC_OFFSET);
 	for (i = 0; i < 4; i++) {
 		struct lm_device *lmdev;
diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
index fa8475b4872d..b5fb71a36ee6 100644
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-integrator/integrator_cp.c
@@ -27,7 +27,6 @@
 #include <linux/of_irq.h>
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
-#include <linux/sys_soc.h>
 #include <linux/sched_clock.h>
 
 #include <asm/setup.h>
@@ -274,10 +273,6 @@ static const struct of_device_id intcp_syscon_match[] = {
 static void __init intcp_init_of(void)
 {
 	struct device_node *cpcon;
-	struct device *parent;
-	struct soc_device *soc_dev;
-	struct soc_device_attribute *soc_dev_attr;
-	u32 intcp_sc_id;
 
 	cpcon = of_find_matching_node(NULL, intcp_syscon_match);
 	if (!cpcon)
@@ -289,28 +284,6 @@ static void __init intcp_init_of(void)
 
 	of_platform_populate(NULL, of_default_bus_match_table,
 			     intcp_auxdata_lookup, NULL);
-
-	intcp_sc_id = readl(intcp_con_base);
-
-	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
-	if (!soc_dev_attr)
-		return;
-
-	soc_dev_attr->soc_id = "XCV";
-	soc_dev_attr->machine = "Integrator/CP";
-	soc_dev_attr->family = "Integrator";
-	soc_dev_attr->revision = kasprintf(GFP_KERNEL, "%c",
-					   'A' + (intcp_sc_id & 0x0f));
-
-	soc_dev = soc_device_register(soc_dev_attr);
-	if (IS_ERR(soc_dev)) {
-		kfree(soc_dev_attr->revision);
-		kfree(soc_dev_attr);
-		return;
-	}
-
-	parent = soc_device_to_device(soc_dev);
-	integrator_init_sysfs(parent, intcp_sc_id);
 }
 
 static const char * intcp_dt_board_compat[] = {
diff --git a/drivers/soc/versatile/Kconfig b/drivers/soc/versatile/Kconfig
index bf5ee9c85330..a928a7fc6be4 100644
--- a/drivers/soc/versatile/Kconfig
+++ b/drivers/soc/versatile/Kconfig
@@ -1,6 +1,15 @@
 #
 # ARM Versatile SoC drivers
 #
+config SOC_INTEGRATOR_CM
+	bool "SoC bus device for the ARM Integrator platform core modules"
+	depends on ARCH_INTEGRATOR
+	select SOC_BUS
+	help
+	  Include support for the SoC bus on the ARM Integrator platform
+	  core modules providing some sysfs information about the ASIC
+	  variant.
+
 config SOC_REALVIEW
 	bool "SoC bus device for the ARM RealView platforms"
 	depends on ARCH_REALVIEW
diff --git a/drivers/soc/versatile/Makefile b/drivers/soc/versatile/Makefile
index ad547435648e..cf612fe3a659 100644
--- a/drivers/soc/versatile/Makefile
+++ b/drivers/soc/versatile/Makefile
@@ -1 +1,2 @@
+obj-$(CONFIG_SOC_INTEGRATOR_CM)	+= soc-integrator.o
 obj-$(CONFIG_SOC_REALVIEW)	+= soc-realview.o
diff --git a/drivers/soc/versatile/soc-integrator.c b/drivers/soc/versatile/soc-integrator.c
new file mode 100644
index 000000000000..ccaa53739ab4
--- /dev/null
+++ b/drivers/soc/versatile/soc-integrator.c
@@ -0,0 +1,154 @@
+/*
+ * Copyright (C) 2014 Linaro Ltd.
+ *
+ * Author: Linus Walleij <linus.walleij@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2, as
+ * published by the Free Software Foundation.
+ *
+ */
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/slab.h>
+#include <linux/sys_soc.h>
+#include <linux/platform_device.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
+#include <linux/of.h>
+
+#define INTEGRATOR_HDR_ID_OFFSET	0x00
+
+static u32 integrator_coreid;
+
+static const struct of_device_id integrator_cm_match[] = {
+	{ .compatible = "arm,core-module-integrator", },
+};
+
+static const char *integrator_arch_str(u32 id)
+{
+	switch ((id >> 16) & 0xff) {
+	case 0x00:
+		return "ASB little-endian";
+	case 0x01:
+		return "AHB little-endian";
+	case 0x03:
+		return "AHB-Lite system bus, bi-endian";
+	case 0x04:
+		return "AHB";
+	case 0x08:
+		return "AHB system bus, ASB processor bus";
+	default:
+		return "Unknown";
+	}
+}
+
+static const char *integrator_fpga_str(u32 id)
+{
+	switch ((id >> 12) & 0xf) {
+	case 0x01:
+		return "XC4062";
+	case 0x02:
+		return "XC4085";
+	case 0x03:
+		return "XVC600";
+	case 0x04:
+		return "EPM7256AE (Altera PLD)";
+	default:
+		return "Unknown";
+	}
+}
+
+static ssize_t integrator_get_manf(struct device *dev,
+			      struct device_attribute *attr,
+			      char *buf)
+{
+	return sprintf(buf, "%02x\n", integrator_coreid >> 24);
+}
+
+static struct device_attribute integrator_manf_attr =
+	__ATTR(manufacturer,  S_IRUGO, integrator_get_manf,  NULL);
+
+static ssize_t integrator_get_arch(struct device *dev,
+			      struct device_attribute *attr,
+			      char *buf)
+{
+	return sprintf(buf, "%s\n", integrator_arch_str(integrator_coreid));
+}
+
+static struct device_attribute integrator_arch_attr =
+	__ATTR(arch,  S_IRUGO, integrator_get_arch,  NULL);
+
+static ssize_t integrator_get_fpga(struct device *dev,
+			      struct device_attribute *attr,
+			      char *buf)
+{
+	return sprintf(buf, "%s\n", integrator_fpga_str(integrator_coreid));
+}
+
+static struct device_attribute integrator_fpga_attr =
+	__ATTR(fpga,  S_IRUGO, integrator_get_fpga,  NULL);
+
+static ssize_t integrator_get_build(struct device *dev,
+			       struct device_attribute *attr,
+			       char *buf)
+{
+	return sprintf(buf, "%02x\n", (integrator_coreid >> 4) & 0xFF);
+}
+
+static struct device_attribute integrator_build_attr =
+	__ATTR(build,  S_IRUGO, integrator_get_build,  NULL);
+
+static int __init integrator_soc_init(void)
+{
+	static struct regmap *syscon_regmap;
+	struct soc_device *soc_dev;
+	struct soc_device_attribute *soc_dev_attr;
+	struct device_node *np;
+	struct device *dev;
+	u32 val;
+	int ret;
+
+	np = of_find_matching_node(NULL, integrator_cm_match);
+	if (!np)
+		return -ENODEV;
+
+	syscon_regmap = syscon_node_to_regmap(np);
+	if (IS_ERR(syscon_regmap))
+		return PTR_ERR(syscon_regmap);
+
+	ret = regmap_read(syscon_regmap, INTEGRATOR_HDR_ID_OFFSET,
+			  &val);
+	if (ret)
+		return -ENODEV;
+	integrator_coreid = val;
+
+	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
+	if (!soc_dev_attr)
+		return -ENOMEM;
+
+	soc_dev_attr->soc_id = "Integrator";
+	soc_dev_attr->machine = "Integrator";
+	soc_dev_attr->family = "Versatile";
+	soc_dev = soc_device_register(soc_dev_attr);
+	if (IS_ERR(soc_dev)) {
+		kfree(soc_dev_attr);
+		return -ENODEV;
+	}
+	dev = soc_device_to_device(soc_dev);
+
+	device_create_file(dev, &integrator_manf_attr);
+	device_create_file(dev, &integrator_arch_attr);
+	device_create_file(dev, &integrator_fpga_attr);
+	device_create_file(dev, &integrator_build_attr);
+
+	dev_info(dev, "Detected ARM core module:\n");
+	dev_info(dev, "    Manufacturer: %02x\n", (val >> 24));
+	dev_info(dev, "    Architecture: %s\n", integrator_arch_str(val));
+	dev_info(dev, "    FPGA: %s\n", integrator_fpga_str(val));
+	dev_info(dev, "    Build: %02x\n", (val >> 4) & 0xFF);
+	dev_info(dev, "    Rev: %c\n", ('A' + (val & 0x03)));
+
+	return 0;
+}
+device_initcall(integrator_soc_init);
-- 
1.9.3
