From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Fri, 8 Apr 2016 17:13:52 +0800
Subject: [PATCH] phy: phy-mt65xx-usb3: add support for mt2701 platform
Message-ID: <1460106832-25360-1-git-send-email-chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A new compatible string, "mediatek,mt2701-u3phy", is added.

Some register settings to avoid RX sensitivity level degradation
which may arise on mt8173 platform are separated from other
platforms.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 .../devicetree/bindings/phy/phy-mt65xx-usb.txt     |    4 +-
 drivers/phy/Kconfig                                |    5 +-
 drivers/phy/phy-mt65xx-usb3.c                      |   77 +++++++++++++-------
 3 files changed, 57 insertions(+), 29 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/phy-mt65xx-usb.txt b/Documentation/devicetree/bindings/phy/phy-mt65xx-usb.txt
index 00100cf..8d2a62f 100644
--- a/Documentation/devicetree/bindings/phy/phy-mt65xx-usb.txt
+++ b/Documentation/devicetree/bindings/phy/phy-mt65xx-usb.txt
@@ -4,7 +4,9 @@ mt65xx USB3.0 PHY binding
 This binding describes a usb3.0 phy for mt65xx platforms of Medaitek SoC.
 
 Required properties (controller (parent) node):
- - compatible	: should be "mediatek,mt8173-u3phy"
+ - compatible	: should be one or more of
+		  "mediatek,mt2701-u3phy"
+		  "mediatek,mt8173-u3phy"
  - reg		: offset and length of register for phy, exclude port's
 		  register.
  - clocks	: a list of phandle + clock-specifier pairs, one for each
diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 26566db..3037f28 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -218,9 +218,8 @@ config PHY_MT65XX_USB3
 	depends on ARCH_MEDIATEK && OF
 	select GENERIC_PHY
 	help
-	  Say 'Y' here to add support for Mediatek USB3.0 PHY driver
-	  for mt65xx SoCs. it supports two usb2.0 ports and
-	  one usb3.0 port.
+	  Say 'Y' here to add support for Mediatek USB3.0 PHY driver,
+	  it supports multiple usb2.0 and usb3.0 ports.
 
 config PHY_HI6220_USB
 	tristate "hi6220 USB PHY support"
diff --git a/drivers/phy/phy-mt65xx-usb3.c b/drivers/phy/phy-mt65xx-usb3.c
index c0e7b4b..4d85e73 100644
--- a/drivers/phy/phy-mt65xx-usb3.c
+++ b/drivers/phy/phy-mt65xx-usb3.c
@@ -134,6 +134,11 @@
 #define U3P_SR_COEF_DIVISOR	1000
 #define U3P_FM_DET_CYCLE_CNT	1024
 
+struct mt65xx_phy_pdata {
+	/* avoid RX sensitivity level degradation only for mt8173 */
+	bool avoid_rx_sen_degradation;
+};
+
 struct mt65xx_phy_instance {
 	struct phy *phy;
 	void __iomem *port_base;
@@ -145,6 +150,7 @@ struct mt65xx_u3phy {
 	struct device *dev;
 	void __iomem *sif_base;	/* include sif2, but exclude port's */
 	struct clk *u3phya_ref;	/* reference clock of usb3 anolog phy */
+	const struct mt65xx_phy_pdata *pdata;
 	struct mt65xx_phy_instance **phys;
 	int nphys;
 };
@@ -241,22 +247,26 @@ static void phy_instance_init(struct mt65xx_u3phy *u3phy,
 		tmp = readl(port_base + U3P_U2PHYACR4);
 		tmp &= ~P2C_U2_GPIO_CTR_MSK;
 		writel(tmp, port_base + U3P_U2PHYACR4);
+	}
 
-		tmp = readl(port_base + U3P_USBPHYACR2);
-		tmp |= PA2_RG_SIF_U2PLL_FORCE_EN;
-		writel(tmp, port_base + U3P_USBPHYACR2);
-
-		tmp = readl(port_base + U3D_U2PHYDCR0);
-		tmp &= ~P2C_RG_SIF_U2PLL_FORCE_ON;
-		writel(tmp, port_base + U3D_U2PHYDCR0);
-	} else {
-		tmp = readl(port_base + U3D_U2PHYDCR0);
-		tmp |= P2C_RG_SIF_U2PLL_FORCE_ON;
-		writel(tmp, port_base + U3D_U2PHYDCR0);
-
-		tmp = readl(port_base + U3P_U2PHYDTM0);
-		tmp |= P2C_RG_SUSPENDM | P2C_FORCE_SUSPENDM;
-		writel(tmp, port_base + U3P_U2PHYDTM0);
+	if (u3phy->pdata->avoid_rx_sen_degradation) {
+		if (!index) {
+			tmp = readl(port_base + U3P_USBPHYACR2);
+			tmp |= PA2_RG_SIF_U2PLL_FORCE_EN;
+			writel(tmp, port_base + U3P_USBPHYACR2);
+
+			tmp = readl(port_base + U3D_U2PHYDCR0);
+			tmp &= ~P2C_RG_SIF_U2PLL_FORCE_ON;
+			writel(tmp, port_base + U3D_U2PHYDCR0);
+		} else {
+			tmp = readl(port_base + U3D_U2PHYDCR0);
+			tmp |= P2C_RG_SIF_U2PLL_FORCE_ON;
+			writel(tmp, port_base + U3D_U2PHYDCR0);
+
+			tmp = readl(port_base + U3P_U2PHYDTM0);
+			tmp |= P2C_RG_SUSPENDM | P2C_FORCE_SUSPENDM;
+			writel(tmp, port_base + U3P_U2PHYDTM0);
+		}
 	}
 
 	tmp = readl(port_base + U3P_USBPHYACR6);
@@ -318,7 +328,7 @@ static void phy_instance_power_on(struct mt65xx_u3phy *u3phy,
 		tmp |= XC3_RG_U3_XTAL_RX_PWD | XC3_RG_U3_FRC_XTAL_RX_PWD;
 		writel(tmp, u3phy->sif_base + U3P_XTALCTL3);
 
-		/* [mt8173]switch 100uA current to SSUSB */
+		/* switch 100uA current to SSUSB */
 		tmp = readl(port_base + U3P_USBPHYACR5);
 		tmp |= PA5_RG_U2_HS_100U_U3_EN;
 		writel(tmp, port_base + U3P_USBPHYACR5);
@@ -335,7 +345,7 @@ static void phy_instance_power_on(struct mt65xx_u3phy *u3phy,
 	tmp |= PA5_RG_U2_HSTX_SRCTRL_VAL(4);
 	writel(tmp, port_base + U3P_USBPHYACR5);
 
-	if (index) {
+	if (u3phy->pdata->avoid_rx_sen_degradation && index) {
 		tmp = readl(port_base + U3D_U2PHYDCR0);
 		tmp |= P2C_RG_SIF_U2PLL_FORCE_ON;
 		writel(tmp, port_base + U3D_U2PHYDCR0);
@@ -386,7 +396,9 @@ static void phy_instance_power_off(struct mt65xx_u3phy *u3phy,
 		tmp = readl(port_base + U3P_U3_PHYA_REG0);
 		tmp &= ~P3A_RG_U3_VUSB10_ON;
 		writel(tmp, port_base + U3P_U3_PHYA_REG0);
-	} else {
+	}
+
+	if (u3phy->pdata->avoid_rx_sen_degradation && index) {
 		tmp = readl(port_base + U3D_U2PHYDCR0);
 		tmp &= ~P2C_RG_SIF_U2PLL_FORCE_ON;
 		writel(tmp, port_base + U3D_U2PHYDCR0);
@@ -402,7 +414,7 @@ static void phy_instance_exit(struct mt65xx_u3phy *u3phy,
 	u32 index = instance->index;
 	u32 tmp;
 
-	if (index) {
+	if (u3phy->pdata->avoid_rx_sen_degradation && index) {
 		tmp = readl(port_base + U3D_U2PHYDCR0);
 		tmp &= ~P2C_RG_SIF_U2PLL_FORCE_ON;
 		writel(tmp, port_base + U3D_U2PHYDCR0);
@@ -502,8 +514,24 @@ static struct phy_ops mt65xx_u3phy_ops = {
 	.owner		= THIS_MODULE,
 };
 
+static const struct mt65xx_phy_pdata mt2701_pdata = {
+	.avoid_rx_sen_degradation = false,
+};
+
+static const struct mt65xx_phy_pdata mt8173_pdata = {
+	.avoid_rx_sen_degradation = true,
+};
+
+static const struct of_device_id mt65xx_u3phy_id_table[] = {
+	{ .compatible = "mediatek,mt2701-u3phy", .data = &mt2701_pdata },
+	{ .compatible = "mediatek,mt8173-u3phy", .data = &mt8173_pdata },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, mt65xx_u3phy_id_table);
+
 static int mt65xx_u3phy_probe(struct platform_device *pdev)
 {
+	const struct of_device_id *match;
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	struct device_node *child_np;
@@ -513,10 +541,15 @@ static int mt65xx_u3phy_probe(struct platform_device *pdev)
 	struct resource res;
 	int port, retval;
 
+	match = of_match_node(mt65xx_u3phy_id_table, pdev->dev.of_node);
+	if (!match)
+		return -EINVAL;
+
 	u3phy = devm_kzalloc(dev, sizeof(*u3phy), GFP_KERNEL);
 	if (!u3phy)
 		return -ENOMEM;
 
+	u3phy->pdata = match->data;
 	u3phy->nphys = of_get_child_count(np);
 	u3phy->phys = devm_kcalloc(dev, u3phy->nphys,
 				       sizeof(*u3phy->phys), GFP_KERNEL);
@@ -587,12 +620,6 @@ put_child:
 	return retval;
 }
 
-static const struct of_device_id mt65xx_u3phy_id_table[] = {
-	{ .compatible = "mediatek,mt8173-u3phy", },
-	{ },
-};
-MODULE_DEVICE_TABLE(of, mt65xx_u3phy_id_table);
-
 static struct platform_driver mt65xx_u3phy_driver = {
 	.probe		= mt65xx_u3phy_probe,
 	.driver		= {
-- 
1.7.9.5
