From: david.wu@rock-chips.com (David Wu)
Date: Tue, 26 Jun 2018 16:19:33 +0800
Subject: [PATCH v3] net: ethernet: stmmac: dwmac-rk: Add GMAC support for px30
Message-ID: <1530001173-21935-1-git-send-email-david.wu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add constants and callback functions for the dwmac on px30 Soc.
The base structure is the same, but registers and the bits in
them are moved slightly, and add the clk_mac_speed for selecting
mac speed.

Signed-off-by: David Wu <david.wu@rock-chips.com>
---
Change in v3:
- Add the clock enable/disable for clk_mac_speed.

Change in v2:
- Fix some error in commit title and message.

 .../devicetree/bindings/net/rockchip-dwmac.txt     |  1 +
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c     | 71 ++++++++++++++++++++++
 2 files changed, 72 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/rockchip-dwmac.txt b/Documentation/devicetree/bindings/net/rockchip-dwmac.txt
index 9c16ee2..3b71da7 100644
--- a/Documentation/devicetree/bindings/net/rockchip-dwmac.txt
+++ b/Documentation/devicetree/bindings/net/rockchip-dwmac.txt
@@ -4,6 +4,7 @@ The device node has following properties.
 
 Required properties:
  - compatible: should be "rockchip,<name>-gamc"
+   "rockchip,px30-gmac":   found on PX30 SoCs
    "rockchip,rk3128-gmac": found on RK312x SoCs
    "rockchip,rk3228-gmac": found on RK322x SoCs
    "rockchip,rk3288-gmac": found on RK3288 SoCs
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 13133b3..fc5fef7 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -61,6 +61,7 @@ struct rk_priv_data {
 	struct clk *mac_clk_tx;
 	struct clk *clk_mac_ref;
 	struct clk *clk_mac_refout;
+	struct clk *clk_mac_speed;
 	struct clk *aclk_mac;
 	struct clk *pclk_mac;
 	struct clk *clk_phy;
@@ -83,6 +84,64 @@ struct rk_priv_data {
 	(((tx) ? soc##_GMAC_TXCLK_DLY_ENABLE : soc##_GMAC_TXCLK_DLY_DISABLE) | \
 	 ((rx) ? soc##_GMAC_RXCLK_DLY_ENABLE : soc##_GMAC_RXCLK_DLY_DISABLE))
 
+#define PX30_GRF_GMAC_CON1		0x0904
+
+/* PX30_GRF_GMAC_CON1 */
+#define PX30_GMAC_PHY_INTF_SEL_RMII	(GRF_CLR_BIT(4) | GRF_CLR_BIT(5) | \
+					 GRF_BIT(6))
+#define PX30_GMAC_SPEED_10M		GRF_CLR_BIT(2)
+#define PX30_GMAC_SPEED_100M		GRF_BIT(2)
+
+static void px30_set_to_rmii(struct rk_priv_data *bsp_priv)
+{
+	struct device *dev = &bsp_priv->pdev->dev;
+
+	if (IS_ERR(bsp_priv->grf)) {
+		dev_err(dev, "%s: Missing rockchip,grf property\n", __func__);
+		return;
+	}
+
+	regmap_write(bsp_priv->grf, PX30_GRF_GMAC_CON1,
+		     PX30_GMAC_PHY_INTF_SEL_RMII);
+}
+
+static void px30_set_rmii_speed(struct rk_priv_data *bsp_priv, int speed)
+{
+	struct device *dev = &bsp_priv->pdev->dev;
+	int ret;
+
+	if (IS_ERR(bsp_priv->clk_mac_speed)) {
+		dev_err(dev, "%s: Missing clk_mac_speed clock\n", __func__);
+		return;
+	}
+
+	if (speed == 10) {
+		regmap_write(bsp_priv->grf, PX30_GRF_GMAC_CON1,
+			     PX30_GMAC_SPEED_10M);
+
+		ret = clk_set_rate(bsp_priv->clk_mac_speed, 2500000);
+		if (ret)
+			dev_err(dev, "%s: set clk_mac_speed rate 2500000 failed: %d\n",
+				__func__, ret);
+	} else if (speed == 100) {
+		regmap_write(bsp_priv->grf, PX30_GRF_GMAC_CON1,
+			     PX30_GMAC_SPEED_100M);
+
+		ret = clk_set_rate(bsp_priv->clk_mac_speed, 25000000);
+		if (ret)
+			dev_err(dev, "%s: set clk_mac_speed rate 25000000 failed: %d\n",
+				__func__, ret);
+
+	} else {
+		dev_err(dev, "unknown speed value for RMII! speed=%d", speed);
+	}
+}
+
+static const struct rk_gmac_ops px30_ops = {
+	.set_to_rmii = px30_set_to_rmii,
+	.set_rmii_speed = px30_set_rmii_speed,
+};
+
 #define RK3128_GRF_MAC_CON0	0x0168
 #define RK3128_GRF_MAC_CON1	0x016c
 
@@ -1042,6 +1101,10 @@ static int rk_gmac_clk_init(struct plat_stmmacenet_data *plat)
 		}
 	}
 
+	bsp_priv->clk_mac_speed = devm_clk_get(dev, "clk_mac_speed");
+	if (IS_ERR(bsp_priv->clk_mac_speed))
+		dev_err(dev, "cannot get clock %s\n", "clk_mac_speed");
+
 	if (bsp_priv->clock_input) {
 		dev_info(dev, "clock input from PHY\n");
 	} else {
@@ -1094,6 +1157,9 @@ static int gmac_clk_enable(struct rk_priv_data *bsp_priv, bool enable)
 			if (!IS_ERR(bsp_priv->mac_clk_tx))
 				clk_prepare_enable(bsp_priv->mac_clk_tx);
 
+			if (!IS_ERR(bsp_priv->clk_mac_speed))
+				clk_prepare_enable(bsp_priv->clk_mac_speed);
+
 			/**
 			 * if (!IS_ERR(bsp_priv->clk_mac))
 			 *	clk_prepare_enable(bsp_priv->clk_mac);
@@ -1128,6 +1194,10 @@ static int gmac_clk_enable(struct rk_priv_data *bsp_priv, bool enable)
 
 			if (!IS_ERR(bsp_priv->mac_clk_tx))
 				clk_disable_unprepare(bsp_priv->mac_clk_tx);
+
+			if (!IS_ERR(bsp_priv->clk_mac_speed))
+				clk_disable_unprepare(bsp_priv->clk_mac_speed);
+
 			/**
 			 * if (!IS_ERR(bsp_priv->clk_mac))
 			 *	clk_disable_unprepare(bsp_priv->clk_mac);
@@ -1424,6 +1494,7 @@ static int rk_gmac_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(rk_gmac_pm_ops, rk_gmac_suspend, rk_gmac_resume);
 
 static const struct of_device_id rk_gmac_dwmac_match[] = {
+	{ .compatible = "rockchip,px30-gmac",	.data = &px30_ops   },
 	{ .compatible = "rockchip,rk3128-gmac", .data = &rk3128_ops },
 	{ .compatible = "rockchip,rk3228-gmac", .data = &rk3228_ops },
 	{ .compatible = "rockchip,rk3288-gmac", .data = &rk3288_ops },
-- 
2.7.4
