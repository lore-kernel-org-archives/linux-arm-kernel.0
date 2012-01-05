From: olof@lixom.net (Olof Johansson)
Date: Wed,  4 Jan 2012 21:56:34 -0800
Subject: [PATCH v2] arm/tegra: emc: convert tegra2_emc to a platform driver
In-Reply-To: <1324599468-12845-7-git-send-email-olof@lixom.net>
References: <1324599468-12845-7-git-send-email-olof@lixom.net>
Message-ID: <1325742994-1178-1-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the first step in making it device-tree aware and get rid of the
in-kernel EMC tables (of which there are none in mainline, thankfully).

Changes since v1:

* Fixed messed up indentation
* Removed code that should be gone (was added here and removed later in series)

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/arm/mach-tegra/tegra2_emc.c        |   96 +++++++++++++++++++++++-------
 arch/arm/mach-tegra/tegra2_emc.h        |   11 +--
 include/linux/platform_data/tegra_emc.h |   34 +++++++++++
 3 files changed, 111 insertions(+), 30 deletions(-)
 create mode 100644 include/linux/platform_data/tegra_emc.h

diff --git a/arch/arm/mach-tegra/tegra2_emc.c b/arch/arm/mach-tegra/tegra2_emc.c
index 0f7ae6e..604d6fc 100644
--- a/arch/arm/mach-tegra/tegra2_emc.c
+++ b/arch/arm/mach-tegra/tegra2_emc.c
@@ -20,6 +20,8 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/platform_data/tegra_emc.h>
 
 #include <mach/iomap.h>
 
@@ -32,18 +34,17 @@ static bool emc_enable;
 #endif
 module_param(emc_enable, bool, 0644);
 
-static void __iomem *emc = IO_ADDRESS(TEGRA_EMC_BASE);
-static const struct tegra_emc_table *tegra_emc_table;
-static int tegra_emc_table_size;
+static struct platform_device *emc_pdev;
+static void __iomem *emc_regbase;
 
 static inline void emc_writel(u32 val, unsigned long addr)
 {
-	writel(val, emc + addr);
+	writel(val, emc_regbase + addr);
 }
 
 static inline u32 emc_readl(unsigned long addr)
 {
-	return readl(emc + addr);
+	return readl(emc_regbase + addr);
 }
 
 static const unsigned long emc_reg_addr[TEGRA_EMC_NUM_REGS] = {
@@ -98,15 +99,15 @@ static const unsigned long emc_reg_addr[TEGRA_EMC_NUM_REGS] = {
 /* Select the closest EMC rate that is higher than the requested rate */
 long tegra_emc_round_rate(unsigned long rate)
 {
+	struct tegra_emc_pdata *pdata;
 	int i;
 	int best = -1;
 	unsigned long distance = ULONG_MAX;
 
-	if (!tegra_emc_table)
+	if (!emc_pdev)
 		return -EINVAL;
 
-	if (!emc_enable)
-		return -EINVAL;
+	pdata = emc_pdev->dev.platform_data;
 
 	pr_debug("%s: %lu\n", __func__, rate);
 
@@ -116,10 +117,10 @@ long tegra_emc_round_rate(unsigned long rate)
 	 */
 	rate = rate / 2 / 1000;
 
-	for (i = 0; i < tegra_emc_table_size; i++) {
-		if (tegra_emc_table[i].rate >= rate &&
-		    (tegra_emc_table[i].rate - rate) < distance) {
-			distance = tegra_emc_table[i].rate - rate;
+	for (i = 0; i < pdata->num_tables; i++) {
+		if (pdata->tables[i].rate >= rate &&
+		    (pdata->tables[i].rate - rate) < distance) {
+			distance = pdata->tables[i].rate - rate;
 			best = i;
 		}
 	}
@@ -127,9 +128,9 @@ long tegra_emc_round_rate(unsigned long rate)
 	if (best < 0)
 		return -EINVAL;
 
-	pr_debug("%s: using %lu\n", __func__, tegra_emc_table[best].rate);
+	pr_debug("%s: using %lu\n", __func__, pdata->tables[best].rate);
 
-	return tegra_emc_table[best].rate * 2 * 1000;
+	return pdata->tables[best].rate * 2 * 1000;
 }
 
 /*
@@ -142,37 +143,86 @@ long tegra_emc_round_rate(unsigned long rate)
  */
 int tegra_emc_set_rate(unsigned long rate)
 {
+	struct tegra_emc_pdata *pdata;
 	int i;
 	int j;
 
-	if (!tegra_emc_table)
+	if (!emc_pdev)
 		return -EINVAL;
 
+	pdata = emc_pdev->dev.platform_data;
+
 	/*
 	 * The EMC clock rate is twice the bus rate, and the bus rate is
 	 * measured in kHz
 	 */
 	rate = rate / 2 / 1000;
 
-	for (i = 0; i < tegra_emc_table_size; i++)
-		if (tegra_emc_table[i].rate == rate)
+	for (i = 0; i < pdata->num_tables; i++)
+		if (pdata->tables[i].rate == rate)
 			break;
 
-	if (i >= tegra_emc_table_size)
+	if (i >= pdata->num_tables)
 		return -EINVAL;
 
 	pr_debug("%s: setting to %lu\n", __func__, rate);
 
 	for (j = 0; j < TEGRA_EMC_NUM_REGS; j++)
-		emc_writel(tegra_emc_table[i].regs[j], emc_reg_addr[j]);
+		emc_writel(pdata->tables[i].regs[j], emc_reg_addr[j]);
+
+	emc_readl(pdata->tables[i].regs[TEGRA_EMC_NUM_REGS - 1]);
+
+	return 0;
+}
+
+static int __devinit tegra_emc_probe(struct platform_device *pdev)
+{
+	struct tegra_emc_pdata *pdata;
+	struct clk *c = clk_get_sys("emc", NULL);
+	struct clk *user;
+	struct resource *res;
+	unsigned long max = 0;
+	int i;
+
+	if (!emc_enable) {
+		dev_err(&pdev->dev, "disabled per module parameter\n");
+		return -ENODEV;
+	}
+
+	pdata = pdev->dev.platform_data;
+
+	if (!pdata) {
+		dev_err(&pdev->dev, "missing platform data\n");
+		return -ENXIO;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "missing register base\n");
+		return -ENOMEM;
+	}
+
+	if (!request_mem_region(res->start, resource_size(res), "tegra_emc")) {
+		dev_err(&pdev->dev, "failed to request register region\n");
+		return -EBUSY;
+	}
 
-	emc_readl(tegra_emc_table[i].regs[TEGRA_EMC_NUM_REGS - 1]);
+	emc_regbase = ioremap(res->start, resource_size(res));
+	emc_pdev = pdev;
 
 	return 0;
 }
 
-void tegra_init_emc(const struct tegra_emc_table *table, int table_size)
+static struct platform_driver tegra_emc_driver = {
+	.driver         = {
+		.name   = "tegra-emc",
+		.owner  = THIS_MODULE,
+	},
+	.probe          = tegra_emc_probe,
+};
+
+static int __init tegra_emc_init(void)
 {
-	tegra_emc_table = table;
-	tegra_emc_table_size = table_size;
+	return platform_driver_register(&tegra_emc_driver);
 }
+device_initcall(tegra_emc_init);
diff --git a/arch/arm/mach-tegra/tegra2_emc.h b/arch/arm/mach-tegra/tegra2_emc.h
index 19f08cb..f61409b 100644
--- a/arch/arm/mach-tegra/tegra2_emc.h
+++ b/arch/arm/mach-tegra/tegra2_emc.h
@@ -15,13 +15,10 @@
  *
  */
 
-#define TEGRA_EMC_NUM_REGS 46
-
-struct tegra_emc_table {
-	unsigned long rate;
-	u32 regs[TEGRA_EMC_NUM_REGS];
-};
+#ifndef __MACH_TEGRA_TEGRA2_EMC_H_
+#define __MACH_TEGRA_TEGRA2_EMC_H
 
 int tegra_emc_set_rate(unsigned long rate);
 long tegra_emc_round_rate(unsigned long rate);
-void tegra_init_emc(const struct tegra_emc_table *table, int table_size);
+
+#endif
diff --git a/include/linux/platform_data/tegra_emc.h b/include/linux/platform_data/tegra_emc.h
new file mode 100644
index 0000000..df67505
--- /dev/null
+++ b/include/linux/platform_data/tegra_emc.h
@@ -0,0 +1,34 @@
+/*
+ * Copyright (C) 2011 Google, Inc.
+ *
+ * Author:
+ *	Colin Cross <ccross@android.com>
+ *	Olof Johansson <olof@lixom.net>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#ifndef __TEGRA_EMC_H_
+#define __TEGRA_EMC_H_
+
+#define TEGRA_EMC_NUM_REGS 46
+
+struct tegra_emc_table {
+	unsigned long rate;
+	u32 regs[TEGRA_EMC_NUM_REGS];
+};
+
+struct tegra_emc_pdata {
+	int num_tables;
+	struct tegra_emc_table *tables;
+};
+
+#endif
-- 
1.7.8.GIT
