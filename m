From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Thu, 3 Aug 2017 18:01:05 +0800
Subject: [PATCH 2/4] phy: phy-mt65xx-usb3: add SATA PHY support
In-Reply-To: <72854b92d5d86698e5cbb427b1009e346eb15978.1501753328.git.chunfeng.yun@mediatek.com>
References: <72854b92d5d86698e5cbb427b1009e346eb15978.1501753328.git.chunfeng.yun@mediatek.com>
Message-ID: <1501754483-10392-2-git-send-email-chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ryder Lee <ryder.lee@mediatek.com>

This patch adds SATA setting part.

Change-Id: Icb1fc15ebe9f6172c56a46d40c359c7cff922976
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/phy/phy-mt65xx-usb3.c |  133 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 129 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/phy-mt65xx-usb3.c b/drivers/phy/phy-mt65xx-usb3.c
index 8ba6905..45291c1 100644
--- a/drivers/phy/phy-mt65xx-usb3.c
+++ b/drivers/phy/phy-mt65xx-usb3.c
@@ -29,7 +29,7 @@
 #define SSUSB_SIFSLV_V1_U2FREQ		0x100	/* shared by u2 phys */
 /* u2 phy bank */
 #define SSUSB_SIFSLV_V1_U2PHY_COM	0x000
-/* u3/pcie phy banks */
+/* u3/pcie/sata phy banks */
 #define SSUSB_SIFSLV_V1_U3PHYD		0x000
 #define SSUSB_SIFSLV_V1_U3PHYA		0x200
 
@@ -199,6 +199,65 @@
 #define U3P_SR_COEF_DIVISOR	1000
 #define U3P_FM_DET_CYCLE_CNT	1024
 
+/* SATA register setting */
+#define PHYD_CTRL_SIGNAL_MODE4		0x1c
+/* CDR Charge Pump P-path current adjustment */
+#define RG_CDR_BICLTD1_GEN1_MSK		GENMASK(23, 20)
+#define RG_CDR_BICLTD1_GEN1_VAL(x)	((0xf & (x)) << 20)
+#define RG_CDR_BICLTD0_GEN1_MSK		GENMASK(11, 8)
+#define RG_CDR_BICLTD0_GEN1_VAL(x)	((0xf & (x)) << 8)
+
+#define PHYD_DESIGN_OPTION2		0x24
+/* Symbol lock count selection */
+#define RG_LOCK_CNT_SEL_MSK		GENMASK(5, 4)
+#define RG_LOCK_CNT_SEL_VAL(x)		((0x3 & (x)) << 4)
+
+#define PHYD_DESIGN_OPTION9	0x40
+/* COMWAK GAP width window */
+#define RG_TG_MAX_MSK		GENMASK(20, 16)
+#define RG_TG_MAX_VAL(x)	((0x1f & (x)) << 16)
+/* COMINIT GAP width window */
+#define RG_T2_MAX_MSK		GENMASK(13, 8)
+#define RG_T2_MAX_VAL(x)	((0x3f & (x)) << 8)
+/* COMWAK GAP width window */
+#define RG_TG_MIN_MSK		GENMASK(7, 5)
+#define RG_TG_MIN_VAL(x)	((0x7 & (x)) << 5)
+/* COMINIT GAP width window */
+#define RG_T2_MIN_MSK		GENMASK(4, 0)
+#define RG_T2_MIN_VAL(x)	(0x1f & (x))
+
+#define ANA_RG_CTRL_SIGNAL1		0x4c
+/* TX driver tail current control for 0dB de-empahsis mdoe for Gen1 speed */
+#define RG_IDRV_0DB_GEN1_MSK		GENMASK(13, 8)
+#define RG_IDRV_0DB_GEN1_VAL(x)		((0x3f & (x)) << 8)
+
+#define ANA_RG_CTRL_SIGNAL4		0x58
+#define RG_CDR_BICLTR_GEN1_MSK		GENMASK(23, 20)
+#define RG_CDR_BICLTR_GEN1_VAL(x)	((0xf & (x)) << 20)
+/* Loop filter R1 resistance adjustment for Gen1 speed */
+#define RG_CDR_BR_GEN2_MSK		GENMASK(10, 8)
+#define RG_CDR_BR_GEN2_VAL(x)		((0x7 & (x)) << 8)
+
+#define ANA_RG_CTRL_SIGNAL6		0x60
+/* I-path capacitance adjustment for Gen1 */
+#define RG_CDR_BC_GEN1_MSK		GENMASK(28, 24)
+#define RG_CDR_BC_GEN1_VAL(x)		((0x1f & (x)) << 24)
+#define RG_CDR_BIRLTR_GEN1_MSK		GENMASK(4, 0)
+#define RG_CDR_BIRLTR_GEN1_VAL(x)	(0x1f & (x))
+
+#define ANA_EQ_EYE_CTRL_SIGNAL1		0x6c
+/* RX Gen1 LEQ tuning step */
+#define RG_EQ_DLEQ_LFI_GEN1_MSK		GENMASK(11, 8)
+#define RG_EQ_DLEQ_LFI_GEN1_VAL(x)	((0xf & (x)) << 8)
+
+#define ANA_EQ_EYE_CTRL_SIGNAL4		0xd8
+#define RG_CDR_BIRLTD0_GEN1_MSK		GENMASK(20, 16)
+#define RG_CDR_BIRLTD0_GEN1_VAL(x)	((0x1f & (x)) << 16)
+
+#define ANA_EQ_EYE_CTRL_SIGNAL5		0xdc
+#define RG_CDR_BIRLTD0_GEN3_MSK		GENMASK(4, 0)
+#define RG_CDR_BIRLTD0_GEN3_VAL(x)	(0x1f & (x))
+
 enum mt_phy_version {
 	MT_PHY_V1 = 1,
 	MT_PHY_V2,
@@ -630,6 +689,64 @@ static void pcie_phy_instance_power_off(struct mt65xx_u3phy *u3phy,
 	writel(tmp, bank->chip + U3P_U3_CHIP_GPIO_CTLE);
 }
 
+static void sata_phy_instance_init(struct mt65xx_u3phy *u3phy,
+	struct mt65xx_phy_instance *instance)
+{
+	struct u3phy_banks *u3_banks = &instance->u3_banks;
+	void __iomem *phyd = u3_banks->phyd;
+	u32 tmp;
+
+	/* charge current adjustment */
+	tmp = readl(phyd + ANA_RG_CTRL_SIGNAL6);
+	tmp &= ~(RG_CDR_BIRLTR_GEN1_MSK | RG_CDR_BC_GEN1_MSK);
+	tmp |= RG_CDR_BIRLTR_GEN1_VAL(0x6) | RG_CDR_BC_GEN1_VAL(0x1a);
+	writel(tmp, phyd + ANA_RG_CTRL_SIGNAL6);
+
+	tmp = readl(phyd + ANA_EQ_EYE_CTRL_SIGNAL4);
+	tmp &= ~RG_CDR_BIRLTD0_GEN1_MSK;
+	tmp |= RG_CDR_BIRLTD0_GEN1_VAL(0x18);
+	writel(tmp, phyd + ANA_EQ_EYE_CTRL_SIGNAL4);
+
+	tmp = readl(phyd + ANA_EQ_EYE_CTRL_SIGNAL5);
+	tmp &= ~RG_CDR_BIRLTD0_GEN3_MSK;
+	tmp |= RG_CDR_BIRLTD0_GEN3_VAL(0x06);
+	writel(tmp, phyd + ANA_EQ_EYE_CTRL_SIGNAL5);
+
+	tmp = readl(phyd + ANA_RG_CTRL_SIGNAL4);
+	tmp &= ~(RG_CDR_BICLTR_GEN1_MSK | RG_CDR_BR_GEN2_MSK);
+	tmp |= RG_CDR_BICLTR_GEN1_VAL(0x0c) | RG_CDR_BR_GEN2_VAL(0x07);
+	writel(tmp, phyd + ANA_RG_CTRL_SIGNAL4);
+
+	tmp = readl(phyd + PHYD_CTRL_SIGNAL_MODE4);
+	tmp &= ~(RG_CDR_BICLTD0_GEN1_MSK | RG_CDR_BICLTD1_GEN1_MSK);
+	tmp |= RG_CDR_BICLTD0_GEN1_VAL(0x08) | RG_CDR_BICLTD1_GEN1_VAL(0x02);
+	writel(tmp, phyd + PHYD_CTRL_SIGNAL_MODE4);
+
+	tmp = readl(phyd + PHYD_DESIGN_OPTION2);
+	tmp &= ~RG_LOCK_CNT_SEL_MSK;
+	tmp |= RG_LOCK_CNT_SEL_VAL(0x02);
+	writel(tmp, phyd + PHYD_DESIGN_OPTION2);
+
+	tmp = readl(phyd + PHYD_DESIGN_OPTION9);
+	tmp &= ~(RG_T2_MIN_MSK | RG_TG_MIN_MSK |
+		 RG_T2_MAX_MSK | RG_TG_MAX_MSK);
+	tmp |= RG_T2_MIN_VAL(0x12) | RG_TG_MIN_VAL(0x04) |
+	       RG_T2_MAX_VAL(0x31) | RG_TG_MAX_VAL(0x0e);
+	writel(tmp, phyd + PHYD_DESIGN_OPTION9);
+
+	tmp = readl(phyd + ANA_RG_CTRL_SIGNAL1);
+	tmp &= ~RG_IDRV_0DB_GEN1_MSK;
+	tmp |= RG_IDRV_0DB_GEN1_VAL(0x20);
+	writel(tmp, phyd + ANA_RG_CTRL_SIGNAL1);
+
+	tmp = readl(phyd + ANA_EQ_EYE_CTRL_SIGNAL1);
+	tmp &= ~RG_EQ_DLEQ_LFI_GEN1_MSK;
+	tmp |= RG_EQ_DLEQ_LFI_GEN1_VAL(0x03);
+	writel(tmp, phyd + ANA_EQ_EYE_CTRL_SIGNAL1);
+
+	dev_dbg(u3phy->dev, "%s(%d)\n", __func__, instance->index);
+}
+
 static void phy_v1_banks_init(struct mt65xx_u3phy *u3phy,
 			      struct mt65xx_phy_instance *instance)
 {
@@ -649,6 +766,9 @@ static void phy_v1_banks_init(struct mt65xx_u3phy *u3phy,
 		u3_banks->phyd = instance->port_base + SSUSB_SIFSLV_V1_U3PHYD;
 		u3_banks->phya = instance->port_base + SSUSB_SIFSLV_V1_U3PHYA;
 		break;
+	case PHY_TYPE_SATA:
+		u3_banks->phyd = instance->port_base + SSUSB_SIFSLV_V1_U3PHYD;
+		break;
 	default:
 		dev_err(u3phy->dev, "incompatible PHY type\n");
 		return;
@@ -708,6 +828,9 @@ static int mt65xx_phy_init(struct phy *phy)
 	case PHY_TYPE_PCIE:
 		pcie_phy_instance_init(u3phy, instance);
 		break;
+	case PHY_TYPE_SATA:
+		sata_phy_instance_init(u3phy, instance);
+		break;
 	default:
 		dev_err(u3phy->dev, "incompatible PHY type\n");
 		return -EINVAL;
@@ -784,7 +907,8 @@ static struct phy *mt65xx_phy_xlate(struct device *dev,
 	instance->type = args->args[0];
 	if (!(instance->type == PHY_TYPE_USB2 ||
 	      instance->type == PHY_TYPE_USB3 ||
-	      instance->type == PHY_TYPE_PCIE)) {
+	      instance->type == PHY_TYPE_PCIE ||
+	      instance->type == PHY_TYPE_SATA)) {
 		dev_err(dev, "unsupported device type: %d\n", instance->type);
 		return ERR_PTR(-EINVAL);
 	}
@@ -814,7 +938,7 @@ static struct phy *mt65xx_phy_xlate(struct device *dev,
 	.version = MT_PHY_V1,
 };
 
-static const struct mt65xx_phy_pdata mt2712_pdata = {
+static const struct mt65xx_phy_pdata tphy_v2_pdata = {
 	.avoid_rx_sen_degradation = false,
 	.version = MT_PHY_V2,
 };
@@ -826,9 +950,10 @@ static struct phy *mt65xx_phy_xlate(struct device *dev,
 
 static const struct of_device_id mt65xx_u3phy_id_table[] = {
 	{ .compatible = "mediatek,mt2701-u3phy", .data = &tphy_v1_pdata },
-	{ .compatible = "mediatek,mt2712-u3phy", .data = &mt2712_pdata },
+	{ .compatible = "mediatek,mt2712-u3phy", .data = &tphy_v2_pdata },
 	{ .compatible = "mediatek,mt8173-u3phy", .data = &mt8173_pdata },
 	{ .compatible = "mediatek,generic-tphy-v1", .data = &tphy_v1_pdata },
+	{ .compatible = "mediatek,generic-tphy-v2", .data = &tphy_v2_pdata },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, mt65xx_u3phy_id_table);
-- 
1.7.9.5
