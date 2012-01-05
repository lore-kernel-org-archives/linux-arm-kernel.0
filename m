From: olof@lixom.net (Olof Johansson)
Date: Wed,  4 Jan 2012 22:02:18 -0800
Subject: [PATCH v2] arm/tegra: emc: device tree support
In-Reply-To: <1324599468-12845-10-git-send-email-olof@lixom.net>
References: <1324599468-12845-10-git-send-email-olof@lixom.net>
Message-ID: <1325743338-2533-1-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device tree support to the emc driver, filling in the platform data
based on the DT bindings.

Changes since v1:

* Unmangled some messed up patch squashes, moving changes to earlier patches
* Flipped an of_property_read_u32 return value test
* Clarified clock settings message on case where no table is provided

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/arm/mach-tegra/tegra2_emc.c |  146 ++++++++++++++++++++++++++++++++++++--
 1 files changed, 139 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-tegra/tegra2_emc.c b/arch/arm/mach-tegra/tegra2_emc.c
index ad70180..0a40266 100644
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
@@ -175,6 +177,127 @@ int tegra_emc_set_rate(unsigned long rate)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static struct device_node *tegra_emc_ramcode_devnode(struct device_node *np)
+{
+	struct device_node *iter;
+	u32 reg;
+
+	for_each_child_of_node(np, iter) {
+		if (of_property_read_u32(np, "nvidia,ram-code", &reg))
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
+				     sizeof(*pdata->tables) * num_tables,
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
+	unsigned long khz;
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
+	khz = pdata->tables[0].rate / 1000;
+	dev_info(&pdev->dev, "no tables provided, using %ld kHz emc, "
+		 "%ld kHz mem\n", khz, khz/2);
+
+	return pdata;
+}
+
 static int __devinit tegra_emc_probe(struct platform_device *pdev)
 {
 	struct tegra_emc_pdata *pdata;
@@ -185,13 +308,6 @@ static int __devinit tegra_emc_probe(struct platform_device *pdev)
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
@@ -204,15 +320,31 @@ static int __devinit tegra_emc_probe(struct platform_device *pdev)
 	}
 
 	emc_regbase = ioremap(res->start, resource_size(res));
+
+	pdata = pdev->dev.platform_data;
+
+	if (!pdata)
+		pdata = tegra_emc_dt_parse_pdata(pdev);
+
+	if (!pdata)
+		pdata = tegra_emc_fill_pdata(pdev);
+
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
