From: olof@lixom.net (Olof Johansson)
Date: Thu, 22 Dec 2011 16:17:48 -0800
Subject: [PATCH 9/9] arm/tegra: emc: device tree support
In-Reply-To: <1324599468-12845-1-git-send-email-olof@lixom.net>
References: <1324599468-12845-1-git-send-email-olof@lixom.net>
Message-ID: <1324599468-12845-10-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device tree support to the emc driver, filling in the platform data
based on the DT bindings.

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/arm/mach-tegra/apbio.c      |    2 +-
 arch/arm/mach-tegra/tegra2_emc.c |  154 ++++++++++++++++++++++++++++++++-----
 2 files changed, 134 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-tegra/apbio.c b/arch/arm/mach-tegra/apbio.c
index 7af9a4e..ee0ea89 100644
--- a/arch/arm/mach-tegra/apbio.c
+++ b/arch/arm/mach-tegra/apbio.c
@@ -64,7 +64,7 @@ out:
 
 out_fail:
 	mutex_unlock(&tegra_apb_dma_lock);
-	return true;
+	return false;
 }
 
 static void apb_dma_complete(struct tegra_dma_req *req)
diff --git a/arch/arm/mach-tegra/tegra2_emc.c b/arch/arm/mach-tegra/tegra2_emc.c
index 9ef61e8..34749fa 100644
--- a/arch/arm/mach-tegra/tegra2_emc.c
+++ b/arch/arm/mach-tegra/tegra2_emc.c
@@ -20,12 +20,14 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/platform_data/tegra_emc.h>
 
 #include <mach/iomap.h>
 
 #include "tegra2_emc.h"
+#include "fuse.h"
 
 #ifdef CONFIG_TEGRA_EMC_SCALING_ENABLE
 static bool emc_enable = true;
@@ -175,27 +177,135 @@ int tegra_emc_set_rate(unsigned long rate)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static struct device_node *tegra_emc_ramcode_devnode(struct device_node *np)
+{
+	struct device_node *iter;
+	u32 reg;
+
+	for_each_child_of_node(np, iter) {
+		if (!of_property_read_u32(np, "nvidia,ram-code", &reg))
+			continue;
+		if (reg == tegra_bct_strapping)
+			return of_node_get(iter);
+	}
+
+	return NULL;
+}
+
+static struct tegra_emc_pdata *tegra_emc_dt_parse_pdata(
+		struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct device_node *tnp, *iter;
+	struct tegra_emc_pdata *pdata;
+	int ret, i, num_tables;
+
+	if (!np)
+		return NULL;
+
+	if (of_find_property(np, "nvidia,use-ram-code", NULL)) {
+		tnp = tegra_emc_ramcode_devnode(np);
+		if (!tnp)
+			dev_warn(&pdev->dev,
+				 "can't find emc table for ram-code 0x%02x\n",
+				 tegra_bct_strapping);
+	} else
+		tnp = of_node_get(np);
+
+	if (!tnp)
+		return NULL;
+
+	num_tables = 0;
+	for_each_child_of_node(tnp, iter)
+		if (of_device_is_compatible(iter, "nvidia,tegra20-emc-table"))
+			num_tables++;
+
+	if (!num_tables) {
+		pdata = NULL;
+		goto out;
+	}
+
+	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
+	pdata->tables = devm_kzalloc(&pdev->dev,
+				     sizeof(struct tegra_emc_table) * num_tables,
+				     GFP_KERNEL);
+
+	i = 0;
+	for_each_child_of_node(tnp, iter) {
+		u32 prop;
+
+		ret = of_property_read_u32(iter, "clock-frequency", &prop);
+		if (ret) {
+			dev_err(&pdev->dev, "no clock-frequency in %s\n",
+				iter->full_name);
+			continue;
+		}
+		pdata->tables[i].rate = prop;
+
+		ret = of_property_read_u32_array(iter, "nvidia,emc-registers",
+						 pdata->tables[i].regs,
+						 TEGRA_EMC_NUM_REGS);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"malformed emc-registers property in %s\n",
+				iter->full_name);
+			continue;
+		}
+
+		i++;
+	}
+	pdata->num_tables = i;
+
+out:
+	of_node_put(tnp);
+	return pdata;
+}
+#else
+static struct tegra_emc_pdata *tegra_emc_dt_parse_pdata(
+		struct platform_device *pdev)
+{
+	return NULL;
+}
+#endif
+
+static struct tegra_emc_pdata __devinit *tegra_emc_fill_pdata(struct platform_device *pdev)
+{	
+	struct clk *c = clk_get_sys(NULL, "emc");
+	struct tegra_emc_pdata *pdata;
+	int i;
+
+	WARN_ON(pdev->dev.platform_data);
+	BUG_ON(IS_ERR_OR_NULL(c));
+
+	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
+	pdata->tables = devm_kzalloc(&pdev->dev,
+				     sizeof(struct tegra_emc_table),
+				     GFP_KERNEL);
+
+	pdata->tables[0].rate = clk_get_rate(c);
+
+	for (i = 0; i < TEGRA_EMC_NUM_REGS; i++)
+		pdata->tables[0].regs[i] = emc_readl(emc_reg_addr[i]);
+
+	pdata->num_tables = 1;
+
+	dev_info(&pdev->dev, "no tables provided, using settings for %ld kHz\n",
+		 pdata->tables[0].rate / 2000);
+
+	return pdata;
+}
+
 static int __devinit tegra_emc_probe(struct platform_device *pdev)
 {
 	struct tegra_emc_pdata *pdata;
-	struct clk *c = clk_get_sys("emc", NULL);
-	struct clk *user;
 	struct resource *res;
-	unsigned long max = 0;
-	int i;
 
 	if (!emc_enable) {
 		dev_err(&pdev->dev, "disabled per module parameter\n");
 		return -ENODEV;
 	}
 
-	pdata = pdev->dev.platform_data;
-
-	if (!pdata) {
-		dev_err(&pdev->dev, "missing platform data\n");
-		return -ENXIO;
-	}
-
         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
         if (!res) {
 		dev_err(&pdev->dev, "missing register base\n");
@@ -209,28 +319,30 @@ static int __devinit tegra_emc_probe(struct platform_device *pdev)
 
 	emc_regbase = ioremap(res->start, resource_size(res));
 
-	/* Since default max_rate on emc clock is the same as firmware set
-	 * it to before booting, raise it up here based on known timings.
-	 */
-
-	for (i = 0; i < pdata->num_tables; i++)
-		if (pdata->tables[i].rate > max)
-			max = pdata->tables[i].rate;
+	pdata = pdev->dev.platform_data;
 
-	c->max_rate = max * 2 * 1000;
+	if (!pdata)
+		pdata = tegra_emc_dt_parse_pdata(pdev);
 
-	list_for_each_entry(user, &c->shared_bus_list, u.shared_bus_user.node)
-		user->max_rate = c->max_rate;
+	if (!pdata)
+		pdata = tegra_emc_fill_pdata(pdev);
 
+	pdev->dev.platform_data = pdata;
 	emc_pdev = pdev;
 
 	return 0;
 }
 
+static struct of_device_id tegra_emc_of_match[] __devinitdata = {
+	{ .compatible = "nvidia,tegra20-emc", },
+	{ },
+};
+
 static struct platform_driver tegra_emc_driver = {
 	.driver         = {
 		.name   = "tegra-emc",
 		.owner  = THIS_MODULE,
+		.of_match_table = tegra_emc_of_match,
 	},
 	.probe          = tegra_emc_probe,
 };
-- 
1.7.8.GIT
