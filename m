From: david@lechnology.com (David Lechner)
Date: Sat, 20 Jan 2018 11:14:05 -0600
Subject: [PATCH v6 26/41] ARM: da8xx: add new USB PHY clock init using common
 clock framework
In-Reply-To: <1516468460-4908-1-git-send-email-david@lechnology.com>
References: <1516468460-4908-1-git-send-email-david@lechnology.com>
Message-ID: <1516468460-4908-27-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the new USB PHY clock init in mach-davinci/usb-da8xx.c using
the new common clock framework drivers.

The #ifdefs are needed to prevent compile errors until the entire
ARCH_DAVINCI is converted.

Signed-off-by: David Lechner <david@lechnology.com>
---

v6 changes:
- rename stuff to match changes in "clk: davinci: New driver for TI DA8XX USB
  PHY clocks"
- take advantage of syscon lookup changes in "mfd: syscon: Add syscon_register()
  function"

 arch/arm/mach-davinci/usb-da8xx.c | 78 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 77 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-davinci/usb-da8xx.c b/arch/arm/mach-davinci/usb-da8xx.c
index fb31f6e..b960609 100644
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
@@ -354,3 +363,70 @@ int __init da8xx_register_usb11_phy_clk(bool use_usb_refclkin)
 
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
+	struct clk *fck_clk, *clk;
+	struct clk_hw *parent;
+
+	cfgchip = syscon_regmap_lookup_by_compatible("ti,da830-cfgchip");
+	if (IS_ERR(cfgchip))
+		return PTR_ERR(cfgchip);
+
+	fck_clk = clk_get_sys("musb-da8xx", NULL);
+	if (IS_ERR(fck_clk))
+		return PTR_ERR(fck_clk);
+
+	clk = da8xx_cfgchip_register_usb0_clk48(cfgchip, fck_clk);
+	if (IS_ERR(clk)) {
+		clk_put(fck_clk);
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
+	return clk_register_clkdev(clk, "usb0_clk48", "da8xx-usb-phy");
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
+		return PTR_ERR(cfgchip);
+
+	clk = da8xx_cfgchip_register_usb1_clk48(cfgchip);
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
+	return clk_register_clkdev(clk, "usb1_clk48", "da8xx-usb-phy");
+}
+#endif
-- 
2.7.4
