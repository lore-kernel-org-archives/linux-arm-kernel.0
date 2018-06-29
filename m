From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Fri, 29 Jun 2018 10:20:29 +0800
Subject: [PATCH 3/5] phy: phy-mtk-tphy: add properties for eye diagram test
In-Reply-To: <54260d59ae39c2335e97892fe85db16cac30b33b.1530238400.git.chunfeng.yun@mediatek.com>
References: <54260d59ae39c2335e97892fe85db16cac30b33b.1530238400.git.chunfeng.yun@mediatek.com>
Message-ID: <e7cc9f7aa65b07abb3bd0f94029ef0b07de5d3d7.1530238400.git.chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add properties for Eye diagram test of HQA which sometimes need
adjust some parameters of u2phy

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/phy/mediatek/phy-mtk-tphy.c | 62 +++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/drivers/phy/mediatek/phy-mtk-tphy.c b/drivers/phy/mediatek/phy-mtk-tphy.c
index b962339..9ab6f2e 100644
--- a/drivers/phy/mediatek/phy-mtk-tphy.c
+++ b/drivers/phy/mediatek/phy-mtk-tphy.c
@@ -42,6 +42,12 @@
 #define PA0_RG_U2PLL_FORCE_ON		BIT(15)
 #define PA0_RG_USB20_INTR_EN		BIT(5)
 
+#define U3P_USBPHYACR1		0x004
+#define PA1_RG_VRT_SEL			GENMASK(14, 12)
+#define PA1_RG_VRT_SEL_VAL(x)	((0x7 & (x)) << 12)
+#define PA1_RG_TERM_SEL		GENMASK(10, 8)
+#define PA1_RG_TERM_SEL_VAL(x)	((0x7 & (x)) << 8)
+
 #define U3P_USBPHYACR2		0x008
 #define PA2_RG_SIF_U2PLL_FORCE_EN	BIT(18)
 
@@ -288,6 +294,9 @@ struct mtk_phy_instance {
 	struct clk *ref_clk;	/* reference clock of anolog phy */
 	u32 index;
 	u8 type;
+	int eye_src;
+	int eye_vrt;
+	int eye_term;
 };
 
 struct mtk_tphy {
@@ -312,6 +321,10 @@ static void hs_slew_rate_calibrate(struct mtk_tphy *tphy,
 	int fm_out;
 	u32 tmp;
 
+	/* use force value */
+	if (instance->eye_src)
+		return;
+
 	/* enable USB ring oscillator */
 	tmp = readl(com + U3P_USBPHYACR5);
 	tmp |= PA5_RG_U2_HSTX_SRCAL_EN;
@@ -818,6 +831,52 @@ static void phy_v2_banks_init(struct mtk_tphy *tphy,
 	}
 }
 
+static void phy_parse_property(struct mtk_tphy *tphy,
+				struct mtk_phy_instance *instance)
+{
+	struct device *dev = &instance->phy->dev;
+
+	if (instance->type != PHY_TYPE_USB2)
+		return;
+
+	device_property_read_u32(dev, "mediatek,eye-src",
+				 &instance->eye_src);
+	device_property_read_u32(dev, "mediatek,eye-vrt",
+				 &instance->eye_vrt);
+	device_property_read_u32(dev, "mediatek,eye-term",
+				 &instance->eye_term);
+}
+
+static void u2_phy_props_set(struct mtk_tphy *tphy,
+			     struct mtk_phy_instance *instance)
+{
+	struct u2phy_banks *u2_banks = &instance->u2_banks;
+	void __iomem *com = u2_banks->com;
+	u32 tmp;
+
+
+	if (instance->eye_src) {
+		tmp = readl(com + U3P_USBPHYACR5);
+		tmp &= ~PA5_RG_U2_HSTX_SRCTRL;
+		tmp |= PA5_RG_U2_HSTX_SRCTRL_VAL(instance->eye_src);
+		writel(tmp, com + U3P_USBPHYACR5);
+	}
+
+	if (instance->eye_vrt) {
+		tmp = readl(com + U3P_USBPHYACR1);
+		tmp &= ~PA1_RG_VRT_SEL;
+		tmp |= PA1_RG_VRT_SEL_VAL(instance->eye_vrt);
+		writel(tmp, com + U3P_USBPHYACR1);
+	}
+
+	if (instance->eye_term) {
+		tmp = readl(com + U3P_USBPHYACR1);
+		tmp &= ~PA1_RG_TERM_SEL;
+		tmp |= PA1_RG_TERM_SEL_VAL(instance->eye_term);
+		writel(tmp, com + U3P_USBPHYACR1);
+	}
+}
+
 static int mtk_phy_init(struct phy *phy)
 {
 	struct mtk_phy_instance *instance = phy_get_drvdata(phy);
@@ -839,6 +898,7 @@ static int mtk_phy_init(struct phy *phy)
 	switch (instance->type) {
 	case PHY_TYPE_USB2:
 		u2_phy_instance_init(tphy, instance);
+		u2_phy_props_set(tphy, instance);
 		break;
 	case PHY_TYPE_USB3:
 		u3_phy_instance_init(tphy, instance);
@@ -951,6 +1011,8 @@ static struct phy *mtk_phy_xlate(struct device *dev,
 		return ERR_PTR(-EINVAL);
 	}
 
+	phy_parse_property(tphy, instance);
+
 	return instance->phy;
 }
 
-- 
1.9.1
