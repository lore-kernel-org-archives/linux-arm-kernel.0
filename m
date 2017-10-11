From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Wed, 11 Oct 2017 10:53:52 +0800
Subject: [RESEND PATCH] phy: phy-mtk-tphy: add set_mode callback
Message-ID: <88ca8e98f1f08e38ac20ece1b7f40189301be74f.1507690355.git.chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is used to force PHY with USB OTG function to enter a specific
mode, and override OTG IDPIN(or IDDIG) signal.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/phy/mediatek/phy-mtk-tphy.c |   39 +++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/phy/mediatek/phy-mtk-tphy.c b/drivers/phy/mediatek/phy-mtk-tphy.c
index 721a2a1..402385f 100644
--- a/drivers/phy/mediatek/phy-mtk-tphy.c
+++ b/drivers/phy/mediatek/phy-mtk-tphy.c
@@ -96,9 +96,11 @@
 
 #define U3P_U2PHYDTM1		0x06C
 #define P2C_RG_UART_EN			BIT(16)
+#define P2C_FORCE_IDDIG		BIT(9)
 #define P2C_RG_VBUSVALID		BIT(5)
 #define P2C_RG_SESSEND			BIT(4)
 #define P2C_RG_AVALID			BIT(2)
+#define P2C_RG_IDDIG			BIT(1)
 
 #define U3P_U3_CHIP_GPIO_CTLD		0x0c
 #define P3C_REG_IP_SW_RST		BIT(31)
@@ -585,6 +587,31 @@ static void u2_phy_instance_exit(struct mtk_tphy *tphy,
 	}
 }
 
+static void u2_phy_instance_set_mode(struct mtk_tphy *tphy,
+				     struct mtk_phy_instance *instance,
+				     enum phy_mode mode)
+{
+	struct u2phy_banks *u2_banks = &instance->u2_banks;
+	u32 tmp;
+
+	tmp = readl(u2_banks->com + U3P_U2PHYDTM1);
+	switch (mode) {
+	case PHY_MODE_USB_DEVICE:
+		tmp |= P2C_FORCE_IDDIG | P2C_RG_IDDIG;
+		break;
+	case PHY_MODE_USB_HOST:
+		tmp |= P2C_FORCE_IDDIG;
+		tmp &= ~P2C_RG_IDDIG;
+		break;
+	case PHY_MODE_USB_OTG:
+		tmp &= ~(P2C_FORCE_IDDIG | P2C_RG_IDDIG);
+		break;
+	default:
+		return;
+	}
+	writel(tmp, u2_banks->com + U3P_U2PHYDTM1);
+}
+
 static void pcie_phy_instance_init(struct mtk_tphy *tphy,
 	struct mtk_phy_instance *instance)
 {
@@ -881,6 +908,17 @@ static int mtk_phy_exit(struct phy *phy)
 	return 0;
 }
 
+static int mtk_phy_set_mode(struct phy *phy, enum phy_mode mode)
+{
+	struct mtk_phy_instance *instance = phy_get_drvdata(phy);
+	struct mtk_tphy *tphy = dev_get_drvdata(phy->dev.parent);
+
+	if (instance->type == PHY_TYPE_USB2)
+		u2_phy_instance_set_mode(tphy, instance, mode);
+
+	return 0;
+}
+
 static struct phy *mtk_phy_xlate(struct device *dev,
 					struct of_phandle_args *args)
 {
@@ -931,6 +969,7 @@ static struct phy *mtk_phy_xlate(struct device *dev,
 	.exit		= mtk_phy_exit,
 	.power_on	= mtk_phy_power_on,
 	.power_off	= mtk_phy_power_off,
+	.set_mode	= mtk_phy_set_mode,
 	.owner		= THIS_MODULE,
 };
 
-- 
1.7.9.5
