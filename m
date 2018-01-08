From: david@lechnology.com (David Lechner)
Date: Sun,  7 Jan 2018 20:17:28 -0600
Subject: [PATCH v5 29/44] ARM: da8xx: add new USB PHY clock init using common
 clock framework
In-Reply-To: <1515377863-20358-1-git-send-email-david@lechnology.com>
References: <1515377863-20358-1-git-send-email-david@lechnology.com>
Message-ID: <1515377863-20358-30-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the new USB PHY clock init in mach-davinci/usb-da8xx.c using
the new common clock framework drivers.

The #ifdefs are needed to prevent compile errors until the entire
ARCH_DAVINCI is converted.

Signed-off-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/usb-da8xx.c | 84 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 83 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-davinci/usb-da8xx.c b/arch/arm/mach-davinci/usb-da8xx.c
index d480a02..d7340670 100644
--- a/arch/arm/mach-davinci/usb-da8xx.c
+++ b/arch/arm/mach-davinci/usb-da8xx.c
@@ -2,28 +2,36 @@
 /*
  * DA8xx USB
  */
+#include <linux/clk-provider.h>
 #include <linux/clk.h>
+#include <linux/clk/davinci.h>
+#include <linux/clkdev.h>
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
 #include <linux/init.h>
 #include <linux/mfd/da8xx-cfgchip.h>
+#include <linux/mfd/syscon.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_data/usb-davinci.h>
 #include <linux/platform_device.h>
 #include <linux/usb/musb.h>
 
-#include <mach/clock.h>
 #include <mach/common.h>
 #include <mach/cputype.h>
 #include <mach/da8xx.h>
 #include <mach/irqs.h>
 
+#ifndef CONFIG_COMMON_CLK
+#include <mach/clock.h>
 #include "clock.h"
+#endif
 
 #define DA8XX_USB0_BASE		0x01e00000
 #define DA8XX_USB1_BASE		0x01e25000
 
+#ifndef CONFIG_COMMON_CLK
 static struct clk *usb20_clk;
+#endif
 
 static struct platform_device da8xx_usb_phy = {
 	.name		= "da8xx-usb-phy",
@@ -128,6 +136,7 @@ int __init da8xx_register_usb11(struct da8xx_ohci_root_hub *pdata)
 	return platform_device_register(&da8xx_usb11_device);
 }
 
+#ifndef CONFIG_COMMON_CLK
 static struct clk usb_refclkin = {
 	.name		= "usb_refclkin",
 	.set_rate	= davinci_simple_set_rate,
@@ -354,3 +363,76 @@ int __init da8xx_register_usb11_phy_clk(bool use_usb_refclkin)
 
 	return ret;
 }
+#else
+/**
+ * da8xx_register_usb20_phy_clk - register USB0PHYCLKMUX clock
+ *
+ * @use_usb_refclkin: Selects the parent clock - either "usb_refclkin" if true
+ *	or "pll0_aux_clk" if false.
+ */
+int __init da8xx_register_usb20_phy_clk(bool use_usb_refclkin)
+{
+	struct regmap *cfgchip;
+	struct clk *usb0_psc_clk, *clk;
+	struct clk_hw *parent;
+
+	cfgchip = syscon_regmap_lookup_by_compatible("ti,da830-cfgchip");
+	if (IS_ERR(cfgchip))
+		cfgchip = syscon_regmap_lookup_by_pdevname("syscon");
+	if (IS_ERR(cfgchip))
+		return PTR_ERR(cfgchip);
+
+	usb0_psc_clk = clk_get_sys("musb-da8xx", NULL);
+	if (IS_ERR(usb0_psc_clk))
+		return PTR_ERR(usb0_psc_clk);
+
+	clk = da8xx_usb0_phy_clk_register("usb0_phy_clk", "usb_refclkin",
+					  "pll0_aux_clk", usb0_psc_clk, cfgchip);
+	if (IS_ERR(clk)) {
+		clk_put(usb0_psc_clk);
+		return PTR_ERR(clk);
+	}
+
+	parent = clk_hw_get_parent_by_index(__clk_get_hw(clk),
+					    use_usb_refclkin ? 0 : 1);
+	if (parent)
+		clk_set_parent(clk, parent->clk);
+	else
+		pr_warn("%s: Failed to find parent clock\n", __func__);
+
+	return clk_register_clkdev(clk, "usb20_phy", "da8xx-usb-phy");
+}
+
+/**
+ * da8xx_register_usb11_phy_clk - register USB1PHYCLKMUX clock
+ *
+ * @use_usb_refclkin: Selects the parent clock - either "usb_refclkin" if true
+ *	or "usb0_phy_clk" if false.
+ */
+int __init da8xx_register_usb11_phy_clk(bool use_usb_refclkin)
+{
+	struct regmap *cfgchip;
+	struct clk *clk;
+	struct clk_hw *parent;
+
+	cfgchip = syscon_regmap_lookup_by_compatible("ti,da830-cfgchip");
+	if (IS_ERR(cfgchip))
+		cfgchip = syscon_regmap_lookup_by_pdevname("syscon");
+	if (IS_ERR(cfgchip))
+		return PTR_ERR(cfgchip);
+
+	clk = da8xx_usb1_phy_clk_register("usb1_phy_clk", "usb0_phy_clk",
+					  "usb_refclkin", cfgchip);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	parent = clk_hw_get_parent_by_index(__clk_get_hw(clk),
+					    use_usb_refclkin ? 1 : 0);
+	if (parent)
+		clk_set_parent(clk, parent->clk);
+	else
+		pr_warn("%s: Failed to find parent clock\n", __func__);
+
+	return clk_register_clkdev(clk, "usb11_phy", "da8xx-usb-phy");
+}
+#endif
-- 
2.7.4
