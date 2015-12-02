From: carlo@caione.org (Carlo Caione)
Date: Wed,  2 Dec 2015 18:22:32 +0100
Subject: [PATCH v2 6/7] ARM: Amlogic: Add SMP bringup code for Meson8b
In-Reply-To: <1449076953-5058-1-git-send-email-carlo@caione.org>
References: <1449076953-5058-1-git-send-email-carlo@caione.org>
Message-ID: <1449076953-5058-7-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Carlo Caione <carlo@endlessm.com>

This adds the necessary SMP-operations and startup code to use the
additional cores on the Amlogic Meson8b SoCs.

Signed-off-by: Carlo Caione <carlo@endlessm.com>
---
 arch/arm/Makefile             |   1 +
 arch/arm/mach-meson/Kconfig   |   1 +
 arch/arm/mach-meson/Makefile  |   1 +
 arch/arm/mach-meson/platsmp.c | 234 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 237 insertions(+)
 create mode 100644 arch/arm/mach-meson/platsmp.c

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 2c2b28e..ec0609a 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -150,6 +150,7 @@ textofs-$(CONFIG_SA1111) := 0x00208000
 endif
 textofs-$(CONFIG_ARCH_MSM8X60) := 0x00208000
 textofs-$(CONFIG_ARCH_MSM8960) := 0x00208000
+textofs-$(CONFIG_ARCH_MESON) := 0x00208000
 textofs-$(CONFIG_ARCH_AXXIA) := 0x00308000
 
 # Machine directory name.  This list is sorted alphanumerically
diff --git a/arch/arm/mach-meson/Kconfig b/arch/arm/mach-meson/Kconfig
index 5d56f86..e171744 100644
--- a/arch/arm/mach-meson/Kconfig
+++ b/arch/arm/mach-meson/Kconfig
@@ -6,6 +6,7 @@ menuconfig ARCH_MESON
 	select CACHE_L2X0
 	select PINCTRL
 	select PINCTRL_MESON
+	select HAVE_ARM_SCU if SMP
 
 if ARCH_MESON
 
diff --git a/arch/arm/mach-meson/Makefile b/arch/arm/mach-meson/Makefile
index 9d7380e..bc26c85 100644
--- a/arch/arm/mach-meson/Makefile
+++ b/arch/arm/mach-meson/Makefile
@@ -1 +1,2 @@
 obj-$(CONFIG_ARCH_MESON) += meson.o
+obj-$(CONFIG_SMP) += platsmp.o
diff --git a/arch/arm/mach-meson/platsmp.c b/arch/arm/mach-meson/platsmp.c
new file mode 100644
index 0000000..1235830
--- /dev/null
+++ b/arch/arm/mach-meson/platsmp.c
@@ -0,0 +1,234 @@
+/*
+ * Copyright (C) 2015 Carlo Caione <carlo@endlessm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ */
+
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+#include <linux/smp.h>
+#include <linux/mfd/syscon.h>
+#include <asm/smp_scu.h>
+#include <asm/smp_plat.h>
+
+#define MESON_CPU_CTRL_REG			(0x00)
+#define MESON_CPU_CTRL_ADDR_REG(c)		(0x04 + ((c - 1) << 2))
+
+#define MESON_CPU_AO_RTI_PWR_A9_CNTL0		(0x00)
+#define MESON_CPU_AO_RTI_PWR_A9_CNTL1		(0x04)
+#define MESON_CPU_AO_RTI_PWR_A9_MEM_PD0		(0x14)
+
+#define MESON_CPU_PWR_A9_CNTL0_M(c)		(0x03 << ((c * 2) + 16))
+#define MESON_CPU_PWR_A9_CNTL1_M(c)		(0x03 << ((c + 1) << 1))
+#define MESON_CPU_PWR_A9_MEM_PD0_M(c)		(0x0f << (32 - (c * 4)))
+#define MESON_CPU_PWR_A9_CNTL1_ST(c)		(0x01 << (c + 16))
+
+static void __iomem *sram_base;
+static void __iomem *scu_base;
+static struct regmap *pmu;
+
+static void __init meson8b_smp_prepare_cpus(unsigned int max_cpus)
+{
+	static struct device_node *node;
+
+	/* SMP SRAM */
+	node = of_find_compatible_node(NULL, NULL, "amlogic,meson8b-smp-sram");
+	if (!node) {
+		pr_err("Missing SRAM node\n");
+		return;
+	}
+
+	sram_base = of_iomap(node, 0);
+	if (!sram_base) {
+		pr_err("Couldn't map SRAM registers\n");
+		return;
+	}
+
+	/* PMU */
+	pmu = syscon_regmap_lookup_by_compatible("amlogic,meson8b-pmu");
+	if (IS_ERR(pmu)) {
+		pr_err("Couldn't map PMU registors\n");
+		return;
+	}
+
+	/* SCU */
+	node = of_find_compatible_node(NULL, NULL, "arm,cortex-a5-scu");
+	if (!node) {
+		pr_err("Missing SCU node\n");
+		return;
+	}
+
+	scu_base = of_iomap(node, 0);
+	if (!scu_base) {
+		pr_err("Couln't map SCU registers\n");
+		return;
+	}
+
+	scu_enable(scu_base);
+}
+
+static struct reset_control *meson_get_core_reset(int cpu)
+{
+	struct device_node *np;
+
+	np = of_get_cpu_node(cpu, 0);
+
+	return of_reset_control_get(np, NULL);
+}
+
+static int meson8b_set_cpu_power_ctrl(unsigned int cpu, bool is_power_on)
+{
+	struct reset_control *rstc;
+	int ret;
+	u32 val;
+
+	rstc = meson_get_core_reset(cpu);
+	if (IS_ERR(rstc)) {
+		pr_err("Couldn't get the reset controller\n");
+		return -EINVAL;
+	}
+
+	if (is_power_on) {
+
+		/* CPU power UP */
+		ret = regmap_update_bits(pmu, MESON_CPU_AO_RTI_PWR_A9_CNTL0,
+					 MESON_CPU_PWR_A9_CNTL0_M(cpu), 0);
+		if (ret < 0) {
+			pr_err("Couldn't power up the CPU\n");
+			return ret;
+		}
+
+		udelay(5);
+
+		/* Reset enable */
+		reset_control_assert(rstc);
+
+		/* Memory power UP */
+		ret = regmap_update_bits(pmu, MESON_CPU_AO_RTI_PWR_A9_MEM_PD0,
+					 MESON_CPU_PWR_A9_MEM_PD0_M(cpu), 0);
+		if (ret < 0) {
+			pr_err("Couldn't power up the memory\n");
+			return ret;
+		}
+
+		/* Wake up CPU */
+		ret = regmap_update_bits(pmu, MESON_CPU_AO_RTI_PWR_A9_CNTL1,
+					 MESON_CPU_PWR_A9_CNTL1_M(cpu), 0);
+		if (ret < 0) {
+			pr_err("Couldn't wake up the CPU\n");
+			return ret;
+		}
+
+		udelay(10);
+
+		val = 0;
+		while (!(val & MESON_CPU_PWR_A9_CNTL1_ST(cpu))) {
+			ret = regmap_read(pmu, MESON_CPU_AO_RTI_PWR_A9_CNTL1, &val);
+			if (ret < 0) {
+				pr_err("CPU wake up failed\n");
+				return ret;
+			}
+		}
+
+		/* Isolation disable */
+		ret = regmap_update_bits(pmu, MESON_CPU_AO_RTI_PWR_A9_CNTL0,
+					 BIT(cpu), 0);
+		if (ret < 0) {
+			pr_err("Error when disabling isolation\n");
+			return ret;
+		}
+
+		/* Reset disable */
+		reset_control_deassert(rstc);
+
+	} else {
+
+		/* CPU power DOWN */
+		ret = regmap_update_bits(pmu, MESON_CPU_AO_RTI_PWR_A9_CNTL0,
+					 MESON_CPU_PWR_A9_CNTL0_M(cpu), 0x3);
+		if (ret < 0) {
+			pr_err("Couldn't power down the CPU\n");
+			return ret;
+		}
+
+		/* Isolation enable */
+		ret = regmap_update_bits(pmu, MESON_CPU_AO_RTI_PWR_A9_CNTL0,
+					 BIT(cpu), 0x3);
+		if (ret < 0) {
+			pr_err("Error when enabling isolation\n");
+			return ret;
+		}
+
+		udelay(10);
+
+		/* Sleep status */
+		ret = regmap_update_bits(pmu, MESON_CPU_AO_RTI_PWR_A9_CNTL1,
+					 MESON_CPU_PWR_A9_CNTL1_M(cpu), 0x3);
+		if (ret < 0) {
+			pr_err("Couldn't change sleep status\n");
+			return ret;
+		}
+
+		/* Memory power DOWN */
+		ret = regmap_update_bits(pmu, MESON_CPU_AO_RTI_PWR_A9_MEM_PD0,
+					 MESON_CPU_PWR_A9_MEM_PD0_M(cpu), 0xf);
+		if (ret < 0) {
+			pr_err("Couldn't power down the memory\n");
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int meson8b_smp_boot_secondary(unsigned int cpu, struct task_struct *idle)
+{
+	unsigned long timeout;
+	int ret;
+	u32 reg;
+
+	ret = meson8b_set_cpu_power_ctrl(cpu, 1);
+	if (ret < 0)
+		return ret;
+
+	timeout = jiffies + (10 * HZ);
+	while (readl(sram_base + MESON_CPU_CTRL_ADDR_REG(cpu)))
+		if (!time_before(jiffies, timeout))
+			return -EPERM;
+
+	udelay(100);
+	writel(virt_to_phys(secondary_startup), sram_base + MESON_CPU_CTRL_ADDR_REG(cpu));
+
+	reg = readl(sram_base + MESON_CPU_CTRL_REG);
+	reg |= (BIT(cpu) | BIT(0));
+	writel(reg, sram_base + MESON_CPU_CTRL_REG);
+
+	return 0;
+}
+
+static void meson8b_smp_secondary_init(unsigned int cpu)
+{
+	scu_power_mode(scu_base, SCU_PM_NORMAL);
+}
+
+static struct smp_operations meson8b_smp_ops __initdata = {
+	.smp_prepare_cpus	= meson8b_smp_prepare_cpus,
+	.smp_boot_secondary	= meson8b_smp_boot_secondary,
+	.smp_secondary_init	= meson8b_smp_secondary_init,
+};
+
+CPU_METHOD_OF_DECLARE(meson8b_smp, "amlogic,meson8b-smp", &meson8b_smp_ops);
-- 
2.5.0
