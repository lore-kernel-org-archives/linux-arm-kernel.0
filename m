From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Fri, 29 Jun 2018 10:20:30 +0800
Subject: [PATCH 4/5] phy: phy-mtk-tphy: add property for BC12
In-Reply-To: <54260d59ae39c2335e97892fe85db16cac30b33b.1530238400.git.chunfeng.yun@mediatek.com>
References: <54260d59ae39c2335e97892fe85db16cac30b33b.1530238400.git.chunfeng.yun@mediatek.com>
Message-ID: <c074a2e2fad54c9be78635effe3ee5044ebbfdc5.1530238400.git.chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some platforms support BC12 which is disabled by default,
here add a property to enable it if need

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/phy/mediatek/phy-mtk-tphy.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/phy/mediatek/phy-mtk-tphy.c b/drivers/phy/mediatek/phy-mtk-tphy.c
index 9ab6f2e..3eb8e1b 100644
--- a/drivers/phy/mediatek/phy-mtk-tphy.c
+++ b/drivers/phy/mediatek/phy-mtk-tphy.c
@@ -101,6 +101,9 @@
 #define P2C_RG_AVALID			BIT(2)
 #define P2C_RG_IDDIG			BIT(1)
 
+#define U3P_U2PHYBC12C		0x080
+#define P2C_RG_CHGDT_EN		BIT(0)
+
 #define U3P_U3_CHIP_GPIO_CTLD		0x0c
 #define P3C_REG_IP_SW_RST		BIT(31)
 #define P3C_MCU_BUS_CK_GATE_EN		BIT(30)
@@ -297,6 +300,7 @@ struct mtk_phy_instance {
 	int eye_src;
 	int eye_vrt;
 	int eye_term;
+	bool bc12_en;
 };
 
 struct mtk_tphy {
@@ -839,12 +843,16 @@ static void phy_parse_property(struct mtk_tphy *tphy,
 	if (instance->type != PHY_TYPE_USB2)
 		return;
 
+	instance->bc12_en = device_property_read_bool(dev, "mediatek,bc12");
 	device_property_read_u32(dev, "mediatek,eye-src",
 				 &instance->eye_src);
 	device_property_read_u32(dev, "mediatek,eye-vrt",
 				 &instance->eye_vrt);
 	device_property_read_u32(dev, "mediatek,eye-term",
 				 &instance->eye_term);
+	dev_dbg(dev, "bc12:%d, src:%d, vrt:%d, term:%d\n",
+		instance->bc12_en, instance->eye_src,
+		instance->eye_vrt, instance->eye_term);
 }
 
 static void u2_phy_props_set(struct mtk_tphy *tphy,
@@ -854,6 +862,11 @@ static void u2_phy_props_set(struct mtk_tphy *tphy,
 	void __iomem *com = u2_banks->com;
 	u32 tmp;
 
+	if (instance->bc12_en) {
+		tmp = readl(com + U3P_U2PHYBC12C);
+		tmp |= P2C_RG_CHGDT_EN;	/* BC1.2 path Enable */
+		writel(tmp, com + U3P_U2PHYBC12C);
+	}
 
 	if (instance->eye_src) {
 		tmp = readl(com + U3P_USBPHYACR5);
-- 
1.9.1
