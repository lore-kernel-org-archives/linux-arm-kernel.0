From: josephl@nvidia.com (Joseph Lo)
Date: Tue, 17 Dec 2013 17:26:39 +0800
Subject: [PATCH 3/4] memory: tegra20-emc: move out Tegra20 EMC driver from
 mach-tegra
In-Reply-To: <1387272400-4689-1-git-send-email-josephl@nvidia.com>
References: <1387272400-4689-1-git-send-email-josephl@nvidia.com>
Message-ID: <1387272400-4689-4-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves out the Tegra20 EMC driver from mach-tegra to the
drivers/memory folder. And register the EMC driver to the EMC interface
of the Tegra CCF driver.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/mach-tegra/Makefile                       |  1 -
 arch/arm/mach-tegra/tegra2_emc.h                   | 24 ----------------------
 drivers/memory/Kconfig                             | 10 +++++++++
 drivers/memory/Makefile                            |  1 +
 .../tegra2_emc.c => drivers/memory/tegra20-emc.c   | 14 +++++++++----
 5 files changed, 21 insertions(+), 29 deletions(-)
 delete mode 100644 arch/arm/mach-tegra/tegra2_emc.h
 rename arch/arm/mach-tegra/tegra2_emc.c => drivers/memory/tegra20-emc.c (95%)

diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index 019bb1758662..6fbfbb77dcd9 100644
--- a/arch/arm/mach-tegra/Makefile
+++ b/arch/arm/mach-tegra/Makefile
@@ -14,7 +14,6 @@ obj-y					+= sleep.o
 obj-y					+= tegra.o
 obj-$(CONFIG_CPU_IDLE)			+= cpuidle.o
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= tegra20_speedo.o
-obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= tegra2_emc.o
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= sleep-tegra20.o
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= pm-tegra20.o
 ifeq ($(CONFIG_CPU_IDLE),y)
diff --git a/arch/arm/mach-tegra/tegra2_emc.h b/arch/arm/mach-tegra/tegra2_emc.h
deleted file mode 100644
index f61409b54cb7..000000000000
--- a/arch/arm/mach-tegra/tegra2_emc.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/*
- * Copyright (C) 2011 Google, Inc.
- *
- * Author:
- *	Colin Cross <ccross@android.com>
- *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- */
-
-#ifndef __MACH_TEGRA_TEGRA2_EMC_H_
-#define __MACH_TEGRA_TEGRA2_EMC_H
-
-int tegra_emc_set_rate(unsigned long rate);
-long tegra_emc_round_rate(unsigned long rate);
-
-#endif
diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
index 29a11db365bc..55017b9bdb6b 100644
--- a/drivers/memory/Kconfig
+++ b/drivers/memory/Kconfig
@@ -40,6 +40,16 @@ config TEGRA20_MC
 	  analysis, especially for IOMMU/GART(Graphics Address
 	  Relocation Table) module.
 
+config TEGRA20_EMC
+	bool "Tegra20 External Memory Controller(EMC) driver"
+	default y
+	depends on ARCH_TEGRA_2x_SOC
+	help
+	  This driver is for the External Memory Controller(EMC) module
+	  available in Tegra20 SoCs. It was used for setting up the timing
+	  in the EMC registers when scaling the memory frequency. To enable
+	  the function, you should also say Y in TEGRA_EMC_SCALING_ENABLE.
+
 config TEGRA30_MC
 	bool "Tegra30 Memory Controller(MC) driver"
 	default y
diff --git a/drivers/memory/Makefile b/drivers/memory/Makefile
index 969d923dad93..23e920dd4ebf 100644
--- a/drivers/memory/Makefile
+++ b/drivers/memory/Makefile
@@ -7,5 +7,6 @@ obj-$(CONFIG_OF)		+= of_memory.o
 endif
 obj-$(CONFIG_TI_EMIF)		+= emif.o
 obj-$(CONFIG_MVEBU_DEVBUS)	+= mvebu-devbus.o
+obj-$(CONFIG_TEGRA20_EMC)	+= tegra20-emc.o
 obj-$(CONFIG_TEGRA20_MC)	+= tegra20-mc.o
 obj-$(CONFIG_TEGRA30_MC)	+= tegra30-mc.o
diff --git a/arch/arm/mach-tegra/tegra2_emc.c b/drivers/memory/tegra20-emc.c
similarity index 95%
rename from arch/arm/mach-tegra/tegra2_emc.c
rename to drivers/memory/tegra20-emc.c
index 26e4edbd8a6a..de2a89089b1a 100644
--- a/arch/arm/mach-tegra/tegra2_emc.c
+++ b/drivers/memory/tegra20-emc.c
@@ -26,8 +26,6 @@
 #include <linux/platform_data/tegra_emc.h>
 #include <linux/tegra-soc.h>
 
-#include "tegra2_emc.h"
-
 #ifdef CONFIG_TEGRA_EMC_SCALING_ENABLE
 static bool emc_enable = true;
 #else
@@ -98,7 +96,7 @@ static const unsigned long emc_reg_addr[TEGRA_EMC_NUM_REGS] = {
 };
 
 /* Select the closest EMC rate that is higher than the requested rate */
-long tegra_emc_round_rate(unsigned long rate)
+static long tegra20_emc_round_rate(unsigned long rate)
 {
 	struct tegra_emc_pdata *pdata;
 	int i;
@@ -142,7 +140,7 @@ long tegra_emc_round_rate(unsigned long rate)
  * and relies on the clock lock on the emc clock to avoid races between
  * multiple frequency changes
  */
-int tegra_emc_set_rate(unsigned long rate)
+static int tegra20_emc_set_rate(unsigned long rate)
 {
 	struct tegra_emc_pdata *pdata;
 	int i;
@@ -296,6 +294,11 @@ static struct tegra_emc_pdata *tegra_emc_fill_pdata(struct platform_device *pdev
 	return pdata;
 }
 
+static const struct emc_clk_ops tegra20_emc_clk_ops = {
+	.emc_round_rate = tegra20_emc_round_rate,
+	.emc_set_rate = tegra20_emc_set_rate,
+};
+
 static int tegra_emc_probe(struct platform_device *pdev)
 {
 	struct tegra_emc_pdata *pdata;
@@ -323,6 +326,9 @@ static int tegra_emc_probe(struct platform_device *pdev)
 
 	emc_pdev = pdev;
 
+	tegra_register_emc_clk_ops(clk_get_sys(NULL, "emc"),
+				   &tegra20_emc_clk_ops);
+
 	return 0;
 }
 
-- 
1.8.5
