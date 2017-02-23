From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 23 Feb 2017 18:11:57 +0100
Subject: [PATCH v2] soc/tegra: Implement Tegra186 PMC support
Message-ID: <20170223171157.13860-1-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

The power management controller on Tegra186 has changed in backwards-
incompatible ways with respect to earlier generations. This implements a
new driver that supports inversion of the PMU interrupt as well as the
"recovery", "bootloader" and "forced-recovery" reboot commands.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v2:
- add Kconfig symbol for old and Tegra186 drivers, build conditionally

 .../bindings/arm/tegra/nvidia,tegra186-pmc.txt     |  34 ++++
 drivers/soc/tegra/Kconfig                          |  13 ++
 drivers/soc/tegra/Makefile                         |   3 +-
 drivers/soc/tegra/pmc-tegra186.c                   | 185 +++++++++++++++++++++
 4 files changed, 234 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-pmc.txt
 create mode 100644 drivers/soc/tegra/pmc-tegra186.c

diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-pmc.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-pmc.txt
new file mode 100644
index 000000000000..078a58b0302f
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-pmc.txt
@@ -0,0 +1,34 @@
+NVIDIA Tegra Power Management Controller (PMC)
+
+Required properties:
+- compatible: Should contain one of the following:
+  - "nvidia,tegra186-pmc": for Tegra186
+- reg: Must contain an (offset, length) pair of the register set for each
+  entry in reg-names.
+- reg-names: Must include the following entries:
+  - "pmc"
+  - "wake"
+  - "aotag"
+  - "scratch"
+
+Optional properties:
+- nvidia,invert-interrupt: If present, inverts the PMU interrupt signal.
+
+Example:
+
+SoC DTSI:
+
+	pmc at c3600000 {
+		compatible = "nvidia,tegra186-pmc";
+		reg = <0 0x0c360000 0 0x10000>,
+		      <0 0x0c370000 0 0x10000>,
+		      <0 0x0c380000 0 0x10000>,
+		      <0 0x0c390000 0 0x10000>;
+		reg-names = "pmc", "wake", "aotag", "scratch";
+	};
+
+Board DTS:
+
+	pmc at c360000 {
+		nvidia,invert-interrupt;
+	};
diff --git a/drivers/soc/tegra/Kconfig b/drivers/soc/tegra/Kconfig
index e5e124c07066..208d6edb3fdb 100644
--- a/drivers/soc/tegra/Kconfig
+++ b/drivers/soc/tegra/Kconfig
@@ -12,6 +12,7 @@ config ARCH_TEGRA_2x_SOC
 	select PINCTRL_TEGRA20
 	select PL310_ERRATA_727915 if CACHE_L2X0
 	select PL310_ERRATA_769419 if CACHE_L2X0
+	select SOC_TEGRA_PMC
 	select TEGRA_TIMER
 	help
 	  Support for NVIDIA Tegra AP20 and T20 processors, based on the
@@ -23,6 +24,7 @@ config ARCH_TEGRA_3x_SOC
 	select ARM_ERRATA_764369 if SMP
 	select PINCTRL_TEGRA30
 	select PL310_ERRATA_769419 if CACHE_L2X0
+	select SOC_TEGRA_PMC
 	select TEGRA_TIMER
 	help
 	  Support for NVIDIA Tegra T30 processor family, based on the
@@ -33,6 +35,7 @@ config ARCH_TEGRA_114_SOC
 	select ARM_ERRATA_798181 if SMP
 	select HAVE_ARM_ARCH_TIMER
 	select PINCTRL_TEGRA114
+	select SOC_TEGRA_PMC
 	select TEGRA_TIMER
 	help
 	  Support for NVIDIA Tegra T114 processor family, based on the
@@ -42,6 +45,7 @@ config ARCH_TEGRA_124_SOC
 	bool "Enable support for Tegra124 family"
 	select HAVE_ARM_ARCH_TIMER
 	select PINCTRL_TEGRA124
+	select SOC_TEGRA_PMC
 	select TEGRA_TIMER
 	help
 	  Support for NVIDIA Tegra T124 processor family, based on the
@@ -55,6 +59,7 @@ if ARM64
 config ARCH_TEGRA_132_SOC
 	bool "NVIDIA Tegra132 SoC"
 	select PINCTRL_TEGRA124
+	select SOC_TEGRA_PMC
 	help
 	  Enable support for NVIDIA Tegra132 SoC, based on the Denver
 	  ARMv8 CPU.  The Tegra132 SoC is similar to the Tegra124 SoC,
@@ -64,6 +69,7 @@ config ARCH_TEGRA_132_SOC
 config ARCH_TEGRA_210_SOC
 	bool "NVIDIA Tegra210 SoC"
 	select PINCTRL_TEGRA210
+	select SOC_TEGRA_PMC
 	help
 	  Enable support for the NVIDIA Tegra210 SoC. Also known as Tegra X1,
 	  the Tegra210 has four Cortex-A57 cores paired with four Cortex-A53
@@ -83,6 +89,7 @@ config ARCH_TEGRA_186_SOC
 	select TEGRA_BPMP
 	select TEGRA_HSP_MBOX
 	select TEGRA_IVC
+	select SOC_TEGRA_PMC_TEGRA186
 	help
 	  Enable support for the NVIDIA Tegar186 SoC. The Tegra186 features a
 	  combination of Denver and Cortex-A57 CPU cores and a GPU based on
@@ -93,3 +100,9 @@ config ARCH_TEGRA_186_SOC
 
 endif
 endif
+
+config SOC_TEGRA_PMC
+	bool
+
+config SOC_TEGRA_PMC_TEGRA186
+	bool
diff --git a/drivers/soc/tegra/Makefile b/drivers/soc/tegra/Makefile
index ae857ff7d53d..b4425e4319ff 100644
--- a/drivers/soc/tegra/Makefile
+++ b/drivers/soc/tegra/Makefile
@@ -1,4 +1,5 @@
 obj-y += fuse/
 
 obj-y += common.o
-obj-y += pmc.o
+obj-$(CONFIG_SOC_TEGRA_PMC) += pmc.o
+obj-$(CONFIG_SOC_TEGRA_PMC_TEGRA186) += pmc-tegra186.o
diff --git a/drivers/soc/tegra/pmc-tegra186.c b/drivers/soc/tegra/pmc-tegra186.c
new file mode 100644
index 000000000000..2e67822a2b22
--- /dev/null
+++ b/drivers/soc/tegra/pmc-tegra186.c
@@ -0,0 +1,185 @@
+/*
+ * Copyright (c) 2016, NVIDIA CORPORATION. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ */
+
+#define pr_fmt(fmt) "tegra-pmc: " fmt
+
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/system-power.h>
+
+#define PMC_CNTRL 0x000
+#define  PMC_CNTRL_MAIN_RST BIT(4)
+
+#define PMC_RST_STATUS 0x070
+
+#define WAKE_AOWAKE_CTRL 0x4f4
+#define  WAKE_AOWAKE_CTRL_INTR_POLARITY BIT(0)
+
+#define SCRATCH_SCRATCH0 0x2000
+#define  SCRATCH_SCRATCH0_MODE_RECOVERY BIT(31)
+#define  SCRATCH_SCRATCH0_MODE_BOOTLOADER BIT(30)
+#define  SCRATCH_SCRATCH0_MODE_RCM BIT(1)
+#define  SCRATCH_SCRATCH0_MODE_MASK (SCRATCH_SCRATCH0_MODE_RECOVERY | \
+				     SCRATCH_SCRATCH0_MODE_BOOTLOADER | \
+				     SCRATCH_SCRATCH0_MODE_RCM)
+
+struct tegra_pmc {
+	struct system_power_chip chip;
+	struct device *dev;
+	void __iomem *regs;
+	void __iomem *wake;
+	void __iomem *aotag;
+	void __iomem *scratch;
+
+	void (*system_restart)(enum reboot_mode mode, const char *cmd);
+	struct notifier_block restart;
+};
+
+static inline struct tegra_pmc *to_pmc(struct system_power_chip *chip)
+{
+	return container_of(chip, struct tegra_pmc, chip);
+}
+
+static int tegra186_pmc_restart_prepare(struct system_power_chip *chip,
+					enum reboot_mode mode, char *cmd)
+{
+	struct tegra_pmc *pmc = to_pmc(chip);
+	u32 value;
+
+	value = readl(pmc->scratch + SCRATCH_SCRATCH0);
+	value &= ~SCRATCH_SCRATCH0_MODE_MASK;
+
+	if (cmd) {
+		if (strcmp(cmd, "recovery") == 0)
+			value |= SCRATCH_SCRATCH0_MODE_RECOVERY;
+
+		if (strcmp(cmd, "bootloader") == 0)
+			value |= SCRATCH_SCRATCH0_MODE_BOOTLOADER;
+
+		if (strcmp(cmd, "forced-recovery") == 0)
+			value |= SCRATCH_SCRATCH0_MODE_RCM;
+	}
+
+	writel(value, pmc->scratch + SCRATCH_SCRATCH0);
+
+	return 0;
+}
+
+static int tegra186_pmc_restart(struct system_power_chip *chip,
+				enum reboot_mode mode, char *cmd)
+{
+	struct tegra_pmc *pmc = to_pmc(chip);
+	u32 value;
+
+	/* reset everything but SCRATCH0_SCRATCH0 and PMC_RST_STATUS */
+	value = readl(pmc->regs + PMC_CNTRL);
+	value |= PMC_CNTRL_MAIN_RST;
+	writel(value, pmc->regs + PMC_CNTRL);
+
+	return 0;
+}
+
+static void tegra186_pmc_setup(struct tegra_pmc *pmc)
+{
+	struct device_node *np = pmc->dev->of_node;
+	bool invert;
+	u32 value;
+
+	invert = of_property_read_bool(np, "nvidia,invert-interrupt");
+
+	value = readl(pmc->wake + WAKE_AOWAKE_CTRL);
+
+	if (invert)
+		value |= WAKE_AOWAKE_CTRL_INTR_POLARITY;
+	else
+		value &= ~WAKE_AOWAKE_CTRL_INTR_POLARITY;
+
+	writel(value, pmc->wake + WAKE_AOWAKE_CTRL);
+}
+
+static int tegra186_pmc_probe(struct platform_device *pdev)
+{
+	struct tegra_pmc *pmc;
+	struct resource *res;
+	int err;
+
+	pmc = devm_kzalloc(&pdev->dev, sizeof(*pmc), GFP_KERNEL);
+	if (!pmc)
+		return -ENOMEM;
+
+	pmc->dev = &pdev->dev;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pmc");
+	pmc->regs = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(pmc->regs))
+		return PTR_ERR(pmc->regs);
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "wake");
+	pmc->wake = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(pmc->wake))
+		return PTR_ERR(pmc->wake);
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "aotag");
+	pmc->aotag = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(pmc->aotag))
+		return PTR_ERR(pmc->aotag);
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "scratch");
+	pmc->scratch = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(pmc->scratch))
+		return PTR_ERR(pmc->scratch);
+
+	pmc->chip.level = SYSTEM_POWER_LEVEL_SOC;
+	pmc->chip.dev = &pdev->dev;
+	pmc->chip.restart_prepare = tegra186_pmc_restart_prepare;
+	pmc->chip.restart = tegra186_pmc_restart;
+
+	err = system_power_chip_add(&pmc->chip);
+	if (err < 0) {
+		dev_err(&pdev->dev,
+			"failed to register system power chip: %d\n",
+			err);
+		return err;
+	}
+
+	tegra186_pmc_setup(pmc);
+
+	platform_set_drvdata(pdev, pmc);
+
+	return 0;
+}
+
+static int tegra186_pmc_remove(struct platform_device *pdev)
+{
+	struct tegra_pmc *pmc = platform_get_drvdata(pdev);
+
+	return system_power_chip_remove(&pmc->chip);
+}
+
+static const struct of_device_id tegra186_pmc_of_match[] = {
+	{ .compatible = "nvidia,tegra186-pmc" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, tegra186_pmc_of_match);
+
+static struct platform_driver tegra186_pmc_driver = {
+	.driver = {
+		.name = "tegra186-pmc",
+		.of_match_table = tegra186_pmc_of_match,
+	},
+	.probe = tegra186_pmc_probe,
+	.remove = tegra186_pmc_remove,
+};
+builtin_platform_driver(tegra186_pmc_driver);
-- 
2.11.1
