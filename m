From: heiko@sntech.de (Heiko Stuebner)
Date: Sun,  8 Nov 2015 17:04:37 +0100
Subject: [PATCH v2 4/8] phy: rockchip-usb: expose the phy-internal PLLs
In-Reply-To: <1446998681-26436-1-git-send-email-heiko@sntech.de>
References: <1446998681-26436-1-git-send-email-heiko@sntech.de>
Message-ID: <1446998681-26436-5-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The USB phys on Rockchip SoCs contain their own internal PLLs to create
the 480MHz needed. Additionally this PLL output is also fed back into the
core clock-controller as possible source for clocks like the GPU or others.

Until now this was modelled incorrectly with a "virtual" factor clock in
the clock controller. The one big caveat is that if we turn off the usb phy
via the siddq signal, all analog components get turned off, including the
PLLs. It is therefore possible that a source clock gets disabled without
the clock driver ever knowing, possibly making the system hang.

Therefore register the phy-plls as real clocks that the clock driver can
then reference again normally, making the clock hirarchy finally reflect
the actual hardware.

The phy-ops get converted to simply turning that new clock on and off
which in turn controls the siddq signal of the phy.

Through this the driver gains handling for platform-specific data, to
handle the phy->clock name association.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 .../devicetree/bindings/phy/rockchip-usb-phy.txt   |   6 +-
 drivers/phy/phy-rockchip-usb.c                     | 177 ++++++++++++++++++---
 2 files changed, 160 insertions(+), 23 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/rockchip-usb-phy.txt b/Documentation/devicetree/bindings/phy/rockchip-usb-phy.txt
index 826454a..68498d5 100644
--- a/Documentation/devicetree/bindings/phy/rockchip-usb-phy.txt
+++ b/Documentation/devicetree/bindings/phy/rockchip-usb-phy.txt
@@ -1,7 +1,10 @@
 ROCKCHIP USB2 PHY
 
 Required properties:
- - compatible: rockchip,rk3288-usb-phy
+ - compatible: matching the soc type, one of
+     "rockchip,rk3066a-usb-phy"
+     "rockchip,rk3188-usb-phy"
+     "rockchip,rk3288-usb-phy"
  - rockchip,grf : phandle to the syscon managing the "general
    register files"
  - #address-cells: should be 1
@@ -21,6 +24,7 @@ required properties:
 Optional Properties:
 - clocks : phandle + clock specifier for the phy clocks
 - clock-names: string, clock name, must be "phyclk"
+- #clock-cells: for users of the phy-pll, should be 0
 
 Example:
 
diff --git a/drivers/phy/phy-rockchip-usb.c b/drivers/phy/phy-rockchip-usb.c
index 3b69f61..e4e57d3 100644
--- a/drivers/phy/phy-rockchip-usb.c
+++ b/drivers/phy/phy-rockchip-usb.c
@@ -15,12 +15,14 @@
  */
 
 #include <linux/clk.h>
+#include <linux/clk-provider.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/of_platform.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
@@ -36,18 +38,35 @@
 #define SIDDQ_ON		BIT(13)
 #define SIDDQ_OFF		(0 << 13)
 
+struct rockchip_usb_phys {
+	int reg;
+	const char *pll_name;
+};
+
+struct rockchip_usb_phy_pdata {
+	struct rockchip_usb_phys *phys;
+};
+
 struct rockchip_usb_phy_base {
 	struct device *dev;
 	struct regmap *reg_base;
+	const struct rockchip_usb_phy_pdata *pdata;
 };
 
 struct rockchip_usb_phy {
 	struct rockchip_usb_phy_base *base;
+	struct device_node *np;
 	unsigned int	reg_offset;
 	struct clk	*clk;
+	struct clk      *clk480m;
+	struct clk_hw	clk480m_hw;
 	struct phy	*phy;
 };
 
+/*
+ * Set siddq to 1 to power down usb phy analog blocks,
+ * set to 0 to enable.
+ */
 static int rockchip_usb_phy_power(struct rockchip_usb_phy *phy,
 					   bool siddq)
 {
@@ -55,17 +74,57 @@ static int rockchip_usb_phy_power(struct rockchip_usb_phy *phy,
 			    SIDDQ_WRITE_ENA | (siddq ? SIDDQ_ON : SIDDQ_OFF));
 }
 
-static int rockchip_usb_phy_power_off(struct phy *_phy)
+static unsigned long rockchip_usb_phy480m_recalc_rate(struct clk_hw *hw,
+						unsigned long parent_rate)
 {
-	struct rockchip_usb_phy *phy = phy_get_drvdata(_phy);
-	int ret = 0;
+	return 480000000;
+}
+
+static void rockchip_usb_phy480m_disable(struct clk_hw *hw)
+{
+	struct rockchip_usb_phy *phy = container_of(hw,
+						    struct rockchip_usb_phy,
+						    clk480m_hw);
+
+	rockchip_usb_phy_power(phy, 1);
+}
+
+static int rockchip_usb_phy480m_enable(struct clk_hw *hw)
+{
+	struct rockchip_usb_phy *phy = container_of(hw,
+						    struct rockchip_usb_phy,
+						    clk480m_hw);
 
-	/* Power down usb phy analog blocks by set siddq 1 */
-	ret = rockchip_usb_phy_power(phy, 1);
-	if (ret)
+	return rockchip_usb_phy_power(phy, 0);
+}
+
+static int rockchip_usb_phy480m_is_enabled(struct clk_hw *hw)
+{
+	struct rockchip_usb_phy *phy = container_of(hw,
+						    struct rockchip_usb_phy,
+						    clk480m_hw);
+	int ret;
+	u32 val;
+
+	ret = regmap_read(phy->base->reg_base, phy->reg_offset, &val);
+	if (ret < 0)
 		return ret;
 
-	clk_disable_unprepare(phy->clk);
+	return (val & SIDDQ_ON) ? 0 : 1;
+}
+
+static const struct clk_ops rockchip_usb_phy480m_ops = {
+	.enable = rockchip_usb_phy480m_enable,
+	.disable = rockchip_usb_phy480m_disable,
+	.is_enabled = rockchip_usb_phy480m_is_enabled,
+	.recalc_rate = rockchip_usb_phy480m_recalc_rate,
+};
+
+static int rockchip_usb_phy_power_off(struct phy *_phy)
+{
+	struct rockchip_usb_phy *phy = phy_get_drvdata(_phy);
+
+	clk_disable_unprepare(phy->clk480m);
 
 	return 0;
 }
@@ -73,20 +132,8 @@ static int rockchip_usb_phy_power_off(struct phy *_phy)
 static int rockchip_usb_phy_power_on(struct phy *_phy)
 {
 	struct rockchip_usb_phy *phy = phy_get_drvdata(_phy);
-	int ret = 0;
-
-	ret = clk_prepare_enable(phy->clk);
-	if (ret)
-		return ret;
-
-	/* Power up usb phy analog blocks by set siddq 0 */
-	ret = rockchip_usb_phy_power(phy, 0);
-	if (ret) {
-		clk_disable_unprepare(phy->clk);
-		return ret;
-	}
 
-	return 0;
+	return clk_prepare_enable(phy->clk480m);
 }
 
 static const struct phy_ops ops = {
@@ -99,6 +146,9 @@ static void rockchip_usb_phy_action(void *data)
 {
 	struct rockchip_usb_phy *rk_phy = data;
 
+	of_clk_del_provider(rk_phy->np);
+	clk_unregister(rk_phy->clk480m);
+
 	if (rk_phy->clk)
 		clk_put(rk_phy->clk);
 }
@@ -108,13 +158,16 @@ static int rockchip_usb_phy_init(struct rockchip_usb_phy_base *base,
 {
 	struct rockchip_usb_phy *rk_phy;
 	unsigned int reg_offset;
-	int err;
+	const char *clk_name;
+	struct clk_init_data init;
+	int err, i;
 
 	rk_phy = devm_kzalloc(base->dev, sizeof(*rk_phy), GFP_KERNEL);
 	if (!rk_phy)
 		return -ENOMEM;
 
 	rk_phy->base = base;
+	rk_phy->np = child;
 
 	if (of_property_read_u32(child, "reg", &reg_offset)) {
 		dev_err(base->dev, "missing reg property in node %s\n",
@@ -128,6 +181,46 @@ static int rockchip_usb_phy_init(struct rockchip_usb_phy_base *base,
 	if (IS_ERR(rk_phy->clk))
 		rk_phy->clk = NULL;
 
+	i = 0;
+	init.name = NULL;
+	while (base->pdata->phys[i].reg) {
+		if (base->pdata->phys[i].reg == reg_offset) {
+			init.name = base->pdata->phys[i].pll_name;
+			break;
+		}
+		i++;
+	}
+
+	if (!init.name) {
+		dev_err(base->dev, "phy data not found\n");
+		return -EINVAL;
+	}
+
+	if (rk_phy->clk) {
+		clk_name = __clk_get_name(rk_phy->clk);
+		init.flags = 0;
+		init.parent_names = &clk_name;
+		init.num_parents = 1;
+	} else {
+		init.flags = CLK_IS_ROOT;
+		init.parent_names = NULL;
+		init.num_parents = 0;
+	}
+
+	init.ops = &rockchip_usb_phy480m_ops;
+	rk_phy->clk480m_hw.init = &init;
+
+	rk_phy->clk480m = clk_register(base->dev, &rk_phy->clk480m_hw);
+	if (IS_ERR(rk_phy->clk480m)) {
+		err = PTR_ERR(rk_phy->clk480m);
+		goto err_clk;
+	}
+
+	err = of_clk_add_provider(child, of_clk_src_simple_get,
+				  rk_phy->clk480m);
+	if (err < 0)
+		goto err_clk_prov;
+
 	err = devm_add_action(base->dev, rockchip_usb_phy_action, rk_phy);
 	if (err)
 		goto err_devm_action;
@@ -143,16 +236,46 @@ static int rockchip_usb_phy_init(struct rockchip_usb_phy_base *base,
 	return rockchip_usb_phy_power(rk_phy, 1);
 
 err_devm_action:
+	of_clk_del_provider(child);
+err_clk_prov:
+	clk_unregister(rk_phy->clk480m);
+err_clk:
 	if (rk_phy->clk)
 		clk_put(rk_phy->clk);
 	return err;
 }
 
+static const struct rockchip_usb_phy_pdata rk3066a_pdata = {
+	.phys = (struct rockchip_usb_phys[]){
+		{ .reg = 0x17c, .pll_name = "sclk_otgphy0_480m" },
+		{ .reg = 0x188, .pll_name = "sclk_otgphy1_480m" },
+		{ /* sentinel */ }
+	},
+};
+
+static const struct rockchip_usb_phy_pdata rk3188_pdata = {
+	.phys = (struct rockchip_usb_phys[]){
+		{ .reg = 0x10c, .pll_name = "sclk_otgphy0_480m" },
+		{ .reg = 0x11c, .pll_name = "sclk_otgphy1_480m" },
+		{ /* sentinel */ }
+	},
+};
+
+static const struct rockchip_usb_phy_pdata rk3288_pdata = {
+	.phys = (struct rockchip_usb_phys[]){
+		{ .reg = 0x320, .pll_name = "sclk_otgphy0_480m" },
+		{ .reg = 0x334, .pll_name = "sclk_otgphy1_480m" },
+		{ .reg = 0x348, .pll_name = "sclk_otgphy2_480m" },
+		{ /* sentinel */ }
+	},
+};
+
 static int rockchip_usb_phy_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct rockchip_usb_phy_base *phy_base;
 	struct phy_provider *phy_provider;
+	const struct of_device_id *match;
 	struct device_node *child;
 	int err;
 
@@ -160,6 +283,14 @@ static int rockchip_usb_phy_probe(struct platform_device *pdev)
 	if (!phy_base)
 		return -ENOMEM;
 
+	match = of_match_device(dev->driver->of_match_table, dev);
+	if (!match || !match->data) {
+		dev_err(dev, "missing phy data\n");
+		return -EINVAL;
+	}
+
+	phy_base->pdata = match->data;
+
 	phy_base->dev = dev;
 	phy_base->reg_base = syscon_regmap_lookup_by_phandle(dev->of_node,
 							     "rockchip,grf");
@@ -179,7 +310,9 @@ static int rockchip_usb_phy_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id rockchip_usb_phy_dt_ids[] = {
-	{ .compatible = "rockchip,rk3288-usb-phy" },
+	{ .compatible = "rockchip,rk3066a-usb-phy", .data = &rk3066a_pdata },
+	{ .compatible = "rockchip,rk3188-usb-phy", .data = &rk3188_pdata },
+	{ .compatible = "rockchip,rk3288-usb-phy", .data = &rk3288_pdata },
 	{}
 };
 
-- 
2.6.2
