From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 17 Feb 2014 11:04:59 +0100
Subject: [PATCH v3 3/7] ARM: imx6: gpc: Add pm clock support to PU power domain
In-Reply-To: <1392631503-17283-1-git-send-email-p.zabel@pengutronix.de>
References: <1392631503-17283-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1392631503-17283-4-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Drivers still handle clocks themselves, we only enable pm clocks of the
GPU and VPU devices in the PU power domain temporarily during powerup
so that the reset machinery can work.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 arch/arm/mach-imx/gpc.c | 74 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/arch/arm/mach-imx/gpc.c b/arch/arm/mach-imx/gpc.c
index c61126c..e16e36a 100644
--- a/arch/arm/mach-imx/gpc.c
+++ b/arch/arm/mach-imx/gpc.c
@@ -18,6 +18,7 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/platform_device.h>
+#include <linux/pm_clock.h>
 #include <linux/pm_domain.h>
 #include <linux/regulator/consumer.h>
 #include <linux/irqchip/arm-gic.h>
@@ -182,6 +183,7 @@ static int imx6q_pm_pu_power_off(struct generic_pm_domain *genpd)
 
 static int imx6q_pm_pu_power_on(struct generic_pm_domain *genpd)
 {
+	struct pm_domain_data *pdd;
 	int ret;
 	u32 val;
 	int sw, sw2iso;
@@ -192,6 +194,10 @@ static int imx6q_pm_pu_power_on(struct generic_pm_domain *genpd)
 		return ret;
 	}
 
+	/* Enable PM clocks for all devices in the PU domain */
+	list_for_each_entry(pdd, &genpd->dev_list, list_node)
+		pm_clk_resume(pdd->dev);
+
 	/* Gate off PU domain when GPU/VPU when powered down */
 	writel_relaxed(0x1, gpc_base + GPC_PGC_GPU_PDN);
 
@@ -208,6 +214,10 @@ static int imx6q_pm_pu_power_on(struct generic_pm_domain *genpd)
 	/* Wait ISO + ISO2SW IPG clock cycles */
 	ndelay((sw + sw2iso) * 1000 / 66);
 
+	/* Disable PM clocks for all devices in the PU domain */
+	list_for_each_entry(pdd, &genpd->dev_list, list_node)
+		pm_clk_suspend(pdd->dev);
+
 	return 0;
 }
 
@@ -217,6 +227,68 @@ static struct generic_pm_domain imx6q_pu_domain = {
 	.power_on = imx6q_pm_pu_power_on,
 };
 
+int imx6q_pm_clk_add(struct device *dev)
+{
+	struct device_node *np = dev->of_node;
+	const char *con_id;
+	struct clk *clk;
+	int i = 0;
+
+	/* Add and prepare named clocks */
+	while (!of_property_read_string_index(np, "clock-names", i, &con_id)) {
+		pm_clk_add(dev, con_id);
+		clk = of_clk_get(np, i);
+		if (!IS_ERR(clk)) {
+			clk_prepare(clk);
+			clk_put(clk);
+		}
+		i++;
+	}
+
+	/* If no named clocks are given, add and prepare unnamed clock */
+	if (i == 1 && of_find_property(dev->of_node, "clocks", NULL)) {
+		pm_clk_add(dev, NULL);
+		clk = of_clk_get(np, 0);
+		if (!IS_ERR(clk)) {
+			clk_prepare(clk);
+			clk_put(clk);
+		}
+	}
+
+	return 0;
+}
+
+int imx6q_pm_clk_remove(struct device *dev)
+{
+	struct device_node *np = dev->of_node;
+	const char *con_id;
+	struct clk *clk;
+	int i = 0;
+
+	/* Remove and unprepare named clocks */
+	while (!of_property_read_string_index(np, "clock-names", i, &con_id)) {
+		pm_clk_remove(dev, con_id);
+		clk = of_clk_get(np, i);
+		if (!IS_ERR(clk)) {
+			clk_unprepare(clk);
+			clk_put(clk);
+		}
+		i++;
+	}
+
+	/* If no named clocks are given, remove and unprepare unnamed clock */
+	if (i == 1 && of_find_property(dev->of_node, "clocks", NULL)) {
+		pm_clk_remove(dev, NULL);
+		clk = of_clk_get(np, 0);
+		if (!IS_ERR(clk)) {
+			clk_unprepare(clk);
+			clk_put(clk);
+		}
+	}
+
+	return 0;
+}
+
 static int imx6q_pm_notifier_call(struct notifier_block *nb,
 				  unsigned long event, void *data)
 {
@@ -235,6 +307,7 @@ static int imx6q_pm_notifier_call(struct notifier_block *nb,
 		if (ret)
 			dev_err(dev, "failed to add to power domain: %d\n",
 				ret);
+		imx6q_pm_clk_add(dev);
 		break;
 	case BUS_NOTIFY_UNBOUND_DRIVER:
 		genpd = dev_to_genpd(dev);
@@ -245,6 +318,7 @@ static int imx6q_pm_notifier_call(struct notifier_block *nb,
 		if (ret)
 			dev_err(dev, "failed to remove from power domain: %d\n",
 				ret);
+		imx6q_pm_clk_remove(dev);
 		break;
 	}
 
-- 
1.8.5.3
