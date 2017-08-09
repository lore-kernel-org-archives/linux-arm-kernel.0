From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Wed, 9 Aug 2017 13:29:46 +0800
Subject: [PATCH v2 1/4] phy: phy-mt65xx-usb3: add PCIe PHY support
Message-ID: <d58705436a2563b87a67609a472db3c3d84b36f5.1502256365.git.chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ryder Lee <ryder.lee@mediatek.com>

This patch adds PCIe PHY setting part.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/phy/phy-mt65xx-usb3.c | 228 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 206 insertions(+), 22 deletions(-)

diff --git a/drivers/phy/phy-mt65xx-usb3.c b/drivers/phy/phy-mt65xx-usb3.c
index 59b110f..a9a85fa 100644
--- a/drivers/phy/phy-mt65xx-usb3.c
+++ b/drivers/phy/phy-mt65xx-usb3.c
@@ -29,7 +29,7 @@
 #define SSUSB_SIFSLV_V1_U2FREQ		0x100	/* shared by u2 phys */
 /* u2 phy bank */
 #define SSUSB_SIFSLV_V1_U2PHY_COM	0x000
-/* u3 phy banks */
+/* u3/pcie phy banks */
 #define SSUSB_SIFSLV_V1_U3PHYD		0x000
 #define SSUSB_SIFSLV_V1_U3PHYA		0x200
 
@@ -99,6 +99,23 @@
 #define P2C_RG_SESSEND			BIT(4)
 #define P2C_RG_AVALID			BIT(2)
 
+#define U3P_U3_CHIP_GPIO_CTLD		0x0c
+#define P3C_REG_IP_SW_RST		BIT(31)
+#define P3C_MCU_BUS_CK_GATE_EN		BIT(30)
+#define P3C_FORCE_IP_SW_RST		BIT(29)
+
+#define U3P_U3_CHIP_GPIO_CTLE		0x10
+#define P3C_RG_SWRST_U3_PHYD		BIT(25)
+#define P3C_RG_SWRST_U3_PHYD_FORCE_EN	BIT(24)
+
+#define U3P_U3_PHYA_REG0	0x000
+#define P3A_RG_CLKDRV_OFF		GENMASK(3, 2)
+#define P3A_RG_CLKDRV_OFF_VAL(x)	((0x3 & (x)) << 2)
+
+#define U3P_U3_PHYA_REG1	0x004
+#define P3A_RG_CLKDRV_AMP		GENMASK(31, 29)
+#define P3A_RG_CLKDRV_AMP_VAL(x)	((0x7 & (x)) << 29)
+
 #define U3P_U3_PHYA_REG6	0x018
 #define P3A_RG_TX_EIDLE_CM		GENMASK(31, 28)
 #define P3A_RG_TX_EIDLE_CM_VAL(x)	((0xf & (x)) << 28)
@@ -108,9 +125,40 @@
 #define P3A_RG_RX_DAC_MUX_VAL(x)	((0x1f & (x)) << 1)
 
 #define U3P_U3_PHYA_DA_REG0	0x100
+#define P3A_RG_XTAL_EXT_PE2H		GENMASK(17, 16)
+#define P3A_RG_XTAL_EXT_PE2H_VAL(x)	((0x3 & (x)) << 16)
+#define P3A_RG_XTAL_EXT_PE1H		GENMASK(13, 12)
+#define P3A_RG_XTAL_EXT_PE1H_VAL(x)	((0x3 & (x)) << 12)
 #define P3A_RG_XTAL_EXT_EN_U3		GENMASK(11, 10)
 #define P3A_RG_XTAL_EXT_EN_U3_VAL(x)	((0x3 & (x)) << 10)
 
+#define U3P_U3_PHYA_DA_REG4	0x108
+#define P3A_RG_PLL_DIVEN_PE2H		GENMASK(21, 19)
+#define P3A_RG_PLL_BC_PE2H		GENMASK(7, 6)
+#define P3A_RG_PLL_BC_PE2H_VAL(x)	((0x3 & (x)) << 6)
+
+#define U3P_U3_PHYA_DA_REG5	0x10c
+#define P3A_RG_PLL_BR_PE2H		GENMASK(29, 28)
+#define P3A_RG_PLL_BR_PE2H_VAL(x)	((0x3 & (x)) << 28)
+#define P3A_RG_PLL_IC_PE2H		GENMASK(15, 12)
+#define P3A_RG_PLL_IC_PE2H_VAL(x)	((0xf & (x)) << 12)
+
+#define U3P_U3_PHYA_DA_REG6	0x110
+#define P3A_RG_PLL_IR_PE2H		GENMASK(19, 16)
+#define P3A_RG_PLL_IR_PE2H_VAL(x)	((0xf & (x)) << 16)
+
+#define U3P_U3_PHYA_DA_REG7	0x114
+#define P3A_RG_PLL_BP_PE2H		GENMASK(19, 16)
+#define P3A_RG_PLL_BP_PE2H_VAL(x)	((0xf & (x)) << 16)
+
+#define U3P_U3_PHYA_DA_REG20	0x13c
+#define P3A_RG_PLL_DELTA1_PE2H		GENMASK(31, 16)
+#define P3A_RG_PLL_DELTA1_PE2H_VAL(x)	((0xffff & (x)) << 16)
+
+#define U3P_U3_PHYA_DA_REG25	0x148
+#define P3A_RG_PLL_DELTA_PE2H		GENMASK(15, 0)
+#define P3A_RG_PLL_DELTA_PE2H_VAL(x)	(0xffff & (x))
+
 #define U3P_U3_PHYD_LFPS1		0x00c
 #define P3D_RG_FWAKE_TH		GENMASK(21, 16)
 #define P3D_RG_FWAKE_TH_VAL(x)	((0x3f & (x)) << 16)
@@ -322,8 +370,8 @@ static void u3_phy_instance_init(struct mt65xx_u3phy *u3phy,
 	dev_dbg(u3phy->dev, "%s(%d)\n", __func__, instance->index);
 }
 
-static void phy_instance_init(struct mt65xx_u3phy *u3phy,
-	struct mt65xx_phy_instance *instance)
+static void u2_phy_instance_init(struct mt65xx_u3phy *u3phy,
+				 struct mt65xx_phy_instance *instance)
 {
 	struct u2phy_banks *u2_banks = &instance->u2_banks;
 	void __iomem *com = u2_banks->com;
@@ -384,8 +432,8 @@ static void phy_instance_init(struct mt65xx_u3phy *u3phy,
 	dev_dbg(u3phy->dev, "%s(%d)\n", __func__, index);
 }
 
-static void phy_instance_power_on(struct mt65xx_u3phy *u3phy,
-	struct mt65xx_phy_instance *instance)
+static void u2_phy_instance_power_on(struct mt65xx_u3phy *u3phy,
+				     struct mt65xx_phy_instance *instance)
 {
 	struct u2phy_banks *u2_banks = &instance->u2_banks;
 	void __iomem *com = u2_banks->com;
@@ -420,8 +468,8 @@ static void phy_instance_power_on(struct mt65xx_u3phy *u3phy,
 	dev_dbg(u3phy->dev, "%s(%d)\n", __func__, index);
 }
 
-static void phy_instance_power_off(struct mt65xx_u3phy *u3phy,
-	struct mt65xx_phy_instance *instance)
+static void u2_phy_instance_power_off(struct mt65xx_u3phy *u3phy,
+				      struct mt65xx_phy_instance *instance)
 {
 	struct u2phy_banks *u2_banks = &instance->u2_banks;
 	void __iomem *com = u2_banks->com;
@@ -458,8 +506,8 @@ static void phy_instance_power_off(struct mt65xx_u3phy *u3phy,
 	dev_dbg(u3phy->dev, "%s(%d)\n", __func__, index);
 }
 
-static void phy_instance_exit(struct mt65xx_u3phy *u3phy,
-	struct mt65xx_phy_instance *instance)
+static void u2_phy_instance_exit(struct mt65xx_u3phy *u3phy,
+				 struct mt65xx_phy_instance *instance)
 {
 	struct u2phy_banks *u2_banks = &instance->u2_banks;
 	void __iomem *com = u2_banks->com;
@@ -477,21 +525,133 @@ static void phy_instance_exit(struct mt65xx_u3phy *u3phy,
 	}
 }
 
+static void pcie_phy_instance_init(struct mt65xx_u3phy *u3phy,
+				   struct mt65xx_phy_instance *instance)
+{
+	struct u3phy_banks *u3_banks = &instance->u3_banks;
+	u32 tmp;
+
+	if (u3phy->pdata->version != MT_PHY_V1)
+		return;
+
+	tmp = readl(u3_banks->phya + U3P_U3_PHYA_DA_REG0);
+	tmp &= ~(P3A_RG_XTAL_EXT_PE1H | P3A_RG_XTAL_EXT_PE2H);
+	tmp |= P3A_RG_XTAL_EXT_PE1H_VAL(0x2) | P3A_RG_XTAL_EXT_PE2H_VAL(0x2);
+	writel(tmp, u3_banks->phya + U3P_U3_PHYA_DA_REG0);
+
+	/* ref clk drive */
+	tmp = readl(u3_banks->phya + U3P_U3_PHYA_REG1);
+	tmp &= ~P3A_RG_CLKDRV_AMP;
+	tmp |= P3A_RG_CLKDRV_AMP_VAL(0x4);
+	writel(tmp, u3_banks->phya + U3P_U3_PHYA_REG1);
+
+	tmp = readl(u3_banks->phya + U3P_U3_PHYA_REG0);
+	tmp &= ~P3A_RG_CLKDRV_OFF;
+	tmp |= P3A_RG_CLKDRV_OFF_VAL(0x1);
+	writel(tmp, u3_banks->phya + U3P_U3_PHYA_REG0);
+
+	/* SSC delta -5000ppm */
+	tmp = readl(u3_banks->phya + U3P_U3_PHYA_DA_REG20);
+	tmp &= ~P3A_RG_PLL_DELTA1_PE2H;
+	tmp |= P3A_RG_PLL_DELTA1_PE2H_VAL(0x3c);
+	writel(tmp, u3_banks->phya + U3P_U3_PHYA_DA_REG20);
+
+	tmp = readl(u3_banks->phya + U3P_U3_PHYA_DA_REG25);
+	tmp &= ~P3A_RG_PLL_DELTA_PE2H;
+	tmp |= P3A_RG_PLL_DELTA_PE2H_VAL(0x36);
+	writel(tmp, u3_banks->phya + U3P_U3_PHYA_DA_REG25);
+
+	/* change pll BW 0.6M */
+	tmp = readl(u3_banks->phya + U3P_U3_PHYA_DA_REG5);
+	tmp &= ~(P3A_RG_PLL_BR_PE2H | P3A_RG_PLL_IC_PE2H);
+	tmp |= P3A_RG_PLL_BR_PE2H_VAL(0x1) | P3A_RG_PLL_IC_PE2H_VAL(0x1);
+	writel(tmp, u3_banks->phya + U3P_U3_PHYA_DA_REG5);
+
+	tmp = readl(u3_banks->phya + U3P_U3_PHYA_DA_REG4);
+	tmp &= ~(P3A_RG_PLL_DIVEN_PE2H | P3A_RG_PLL_BC_PE2H);
+	tmp |= P3A_RG_PLL_BC_PE2H_VAL(0x3);
+	writel(tmp, u3_banks->phya + U3P_U3_PHYA_DA_REG4);
+
+	tmp = readl(u3_banks->phya + U3P_U3_PHYA_DA_REG6);
+	tmp &= ~P3A_RG_PLL_IR_PE2H;
+	tmp |= P3A_RG_PLL_IR_PE2H_VAL(0x2);
+	writel(tmp, u3_banks->phya + U3P_U3_PHYA_DA_REG6);
+
+	tmp = readl(u3_banks->phya + U3P_U3_PHYA_DA_REG7);
+	tmp &= ~P3A_RG_PLL_BP_PE2H;
+	tmp |= P3A_RG_PLL_BP_PE2H_VAL(0xa);
+	writel(tmp, u3_banks->phya + U3P_U3_PHYA_DA_REG7);
+
+	/* Tx Detect Rx Timing: 10us -> 5us */
+	tmp = readl(u3_banks->phyd + U3P_U3_PHYD_RXDET1);
+	tmp &= ~P3D_RG_RXDET_STB2_SET;
+	tmp |= P3D_RG_RXDET_STB2_SET_VAL(0x10);
+	writel(tmp, u3_banks->phyd + U3P_U3_PHYD_RXDET1);
+
+	tmp = readl(u3_banks->phyd + U3P_U3_PHYD_RXDET2);
+	tmp &= ~P3D_RG_RXDET_STB2_SET_P3;
+	tmp |= P3D_RG_RXDET_STB2_SET_P3_VAL(0x10);
+	writel(tmp, u3_banks->phyd + U3P_U3_PHYD_RXDET2);
+
+	/* wait for PCIe subsys register to active */
+	usleep_range(2500, 3000);
+	dev_dbg(u3phy->dev, "%s(%d)\n", __func__, instance->index);
+}
+
+static void pcie_phy_instance_power_on(struct mt65xx_u3phy *u3phy,
+				       struct mt65xx_phy_instance *instance)
+{
+	struct u3phy_banks *bank = &instance->u3_banks;
+	u32 tmp;
+
+	tmp = readl(bank->chip + U3P_U3_CHIP_GPIO_CTLD);
+	tmp &= ~(P3C_FORCE_IP_SW_RST | P3C_MCU_BUS_CK_GATE_EN |
+		P3C_REG_IP_SW_RST);
+	writel(tmp, bank->chip + U3P_U3_CHIP_GPIO_CTLD);
+
+	tmp = readl(bank->chip + U3P_U3_CHIP_GPIO_CTLE);
+	tmp &= ~(P3C_RG_SWRST_U3_PHYD_FORCE_EN | P3C_RG_SWRST_U3_PHYD);
+	writel(tmp, bank->chip + U3P_U3_CHIP_GPIO_CTLE);
+}
+
+static void pcie_phy_instance_power_off(struct mt65xx_u3phy *u3phy,
+					struct mt65xx_phy_instance *instance)
+
+{
+	struct u3phy_banks *bank = &instance->u3_banks;
+	u32 tmp;
+
+	tmp = readl(bank->chip + U3P_U3_CHIP_GPIO_CTLD);
+	tmp |= P3C_FORCE_IP_SW_RST | P3C_REG_IP_SW_RST;
+	writel(tmp, bank->chip + U3P_U3_CHIP_GPIO_CTLD);
+
+	tmp = readl(bank->chip + U3P_U3_CHIP_GPIO_CTLE);
+	tmp |= P3C_RG_SWRST_U3_PHYD_FORCE_EN | P3C_RG_SWRST_U3_PHYD;
+	writel(tmp, bank->chip + U3P_U3_CHIP_GPIO_CTLE);
+}
+
 static void phy_v1_banks_init(struct mt65xx_u3phy *u3phy,
 			      struct mt65xx_phy_instance *instance)
 {
 	struct u2phy_banks *u2_banks = &instance->u2_banks;
 	struct u3phy_banks *u3_banks = &instance->u3_banks;
 
-	if (instance->type == PHY_TYPE_USB2) {
+	switch (instance->type) {
+	case PHY_TYPE_USB2:
 		u2_banks->misc = NULL;
 		u2_banks->fmreg = u3phy->sif_base + SSUSB_SIFSLV_V1_U2FREQ;
 		u2_banks->com = instance->port_base + SSUSB_SIFSLV_V1_U2PHY_COM;
-	} else if (instance->type == PHY_TYPE_USB3) {
+		break;
+	case PHY_TYPE_USB3:
+	case PHY_TYPE_PCIE:
 		u3_banks->spllc = u3phy->sif_base + SSUSB_SIFSLV_V1_SPLLC;
 		u3_banks->chip = NULL;
 		u3_banks->phyd = instance->port_base + SSUSB_SIFSLV_V1_U3PHYD;
 		u3_banks->phya = instance->port_base + SSUSB_SIFSLV_V1_U3PHYA;
+		break;
+	default:
+		dev_err(u3phy->dev, "incompatible PHY type\n");
+		return;
 	}
 }
 
@@ -501,15 +661,22 @@ static void phy_v2_banks_init(struct mt65xx_u3phy *u3phy,
 	struct u2phy_banks *u2_banks = &instance->u2_banks;
 	struct u3phy_banks *u3_banks = &instance->u3_banks;
 
-	if (instance->type == PHY_TYPE_USB2) {
+	switch (instance->type) {
+	case PHY_TYPE_USB2:
 		u2_banks->misc = instance->port_base + SSUSB_SIFSLV_V2_MISC;
 		u2_banks->fmreg = instance->port_base + SSUSB_SIFSLV_V2_U2FREQ;
 		u2_banks->com = instance->port_base + SSUSB_SIFSLV_V2_U2PHY_COM;
-	} else if (instance->type == PHY_TYPE_USB3) {
+		break;
+	case PHY_TYPE_USB3:
+	case PHY_TYPE_PCIE:
 		u3_banks->spllc = instance->port_base + SSUSB_SIFSLV_V2_SPLLC;
 		u3_banks->chip = instance->port_base + SSUSB_SIFSLV_V2_CHIP;
 		u3_banks->phyd = instance->port_base + SSUSB_SIFSLV_V2_U3PHYD;
 		u3_banks->phya = instance->port_base + SSUSB_SIFSLV_V2_U3PHYA;
+		break;
+	default:
+		dev_err(u3phy->dev, "incompatible PHY type\n");
+		return;
 	}
 }
 
@@ -531,10 +698,20 @@ static int mt65xx_phy_init(struct phy *phy)
 		return ret;
 	}
 
-	if (instance->type == PHY_TYPE_USB2)
-		phy_instance_init(u3phy, instance);
-	else
+	switch (instance->type) {
+	case PHY_TYPE_USB2:
+		u2_phy_instance_init(u3phy, instance);
+		break;
+	case PHY_TYPE_USB3:
 		u3_phy_instance_init(u3phy, instance);
+		break;
+	case PHY_TYPE_PCIE:
+		pcie_phy_instance_init(u3phy, instance);
+		break;
+	default:
+		dev_err(u3phy->dev, "incompatible PHY type\n");
+		return -EINVAL;
+	}
 
 	return 0;
 }
@@ -545,9 +722,12 @@ static int mt65xx_phy_power_on(struct phy *phy)
 	struct mt65xx_u3phy *u3phy = dev_get_drvdata(phy->dev.parent);
 
 	if (instance->type == PHY_TYPE_USB2) {
-		phy_instance_power_on(u3phy, instance);
+		u2_phy_instance_power_on(u3phy, instance);
 		hs_slew_rate_calibrate(u3phy, instance);
+	} else if (instance->type == PHY_TYPE_PCIE) {
+		pcie_phy_instance_power_on(u3phy, instance);
 	}
+
 	return 0;
 }
 
@@ -557,7 +737,9 @@ static int mt65xx_phy_power_off(struct phy *phy)
 	struct mt65xx_u3phy *u3phy = dev_get_drvdata(phy->dev.parent);
 
 	if (instance->type == PHY_TYPE_USB2)
-		phy_instance_power_off(u3phy, instance);
+		u2_phy_instance_power_off(u3phy, instance);
+	else if (instance->type == PHY_TYPE_PCIE)
+		pcie_phy_instance_power_off(u3phy, instance);
 
 	return 0;
 }
@@ -568,7 +750,7 @@ static int mt65xx_phy_exit(struct phy *phy)
 	struct mt65xx_u3phy *u3phy = dev_get_drvdata(phy->dev.parent);
 
 	if (instance->type == PHY_TYPE_USB2)
-		phy_instance_exit(u3phy, instance);
+		u2_phy_instance_exit(u3phy, instance);
 
 	clk_disable_unprepare(instance->ref_clk);
 	clk_disable_unprepare(u3phy->u3phya_ref);
@@ -601,7 +783,8 @@ static struct phy *mt65xx_phy_xlate(struct device *dev,
 
 	instance->type = args->args[0];
 	if (!(instance->type == PHY_TYPE_USB2 ||
-	      instance->type == PHY_TYPE_USB3)) {
+	      instance->type == PHY_TYPE_USB3 ||
+	      instance->type == PHY_TYPE_PCIE)) {
 		dev_err(dev, "unsupported device type: %d\n", instance->type);
 		return ERR_PTR(-EINVAL);
 	}
@@ -626,7 +809,7 @@ static struct phy *mt65xx_phy_xlate(struct device *dev,
 	.owner		= THIS_MODULE,
 };
 
-static const struct mt65xx_phy_pdata mt2701_pdata = {
+static const struct mt65xx_phy_pdata tphy_v1_pdata = {
 	.avoid_rx_sen_degradation = false,
 	.version = MT_PHY_V1,
 };
@@ -642,9 +825,10 @@ static struct phy *mt65xx_phy_xlate(struct device *dev,
 };
 
 static const struct of_device_id mt65xx_u3phy_id_table[] = {
-	{ .compatible = "mediatek,mt2701-u3phy", .data = &mt2701_pdata },
+	{ .compatible = "mediatek,mt2701-u3phy", .data = &tphy_v1_pdata },
 	{ .compatible = "mediatek,mt2712-u3phy", .data = &mt2712_pdata },
 	{ .compatible = "mediatek,mt8173-u3phy", .data = &mt8173_pdata },
+	{ .compatible = "mediatek,generic-tphy-v1", .data = &tphy_v1_pdata },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, mt65xx_u3phy_id_table);
-- 
1.9.1
