From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Sat, 11 Mar 2017 14:22:48 +0800
Subject: [PATCH v4 3/8] phy: phy-mt65xx-usb3: split SuperSpeed port into two
 ones
In-Reply-To: <1489213373-2544-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1489213373-2544-1-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <1489213373-2544-3-git-send-email-chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently usb3 port in fact includes two sub-ports, but it is not
flexible for some cases, such as following one:
    usb3 port0 includes u2port0 and u3port0;
    usb2 port0 includes u2port1;
If wants to support only HS, we can use u2port0 or u2port1, when
select u2port0, u3port0 is not needed;
If wants to support SS, we can compound u2port0 and u3port0,
or u2port1 and u3port0, if select latter one, u2port0 is not needed.

So it's more flexible to split usb3 port into two ones and also try
best to save power by disabling unnecessary ports.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/phy/phy-mt65xx-usb3.c |  149 +++++++++++++++++++++--------------------
 1 file changed, 75 insertions(+), 74 deletions(-)

diff --git a/drivers/phy/phy-mt65xx-usb3.c b/drivers/phy/phy-mt65xx-usb3.c
index 4fd47d0..7fff482 100644
--- a/drivers/phy/phy-mt65xx-usb3.c
+++ b/drivers/phy/phy-mt65xx-usb3.c
@@ -30,11 +30,11 @@
 #define SSUSB_SIFSLV_SPLLC		0x0000
 #define SSUSB_SIFSLV_U2FREQ		0x0100
 
-/* offsets of sub-segment in each port registers */
+/* offsets of banks in each u2phy registers */
 #define SSUSB_SIFSLV_U2PHY_COM_BASE	0x0000
-#define SSUSB_SIFSLV_U3PHYD_BASE	0x0100
-#define SSUSB_USB30_PHYA_SIV_B_BASE	0x0300
-#define SSUSB_SIFSLV_U3PHYA_DA_BASE	0x0400
+/* offsets of banks in each u3phy registers */
+#define SSUSB_SIFSLV_U3PHYD_BASE	0x0000
+#define SSUSB_SIFSLV_U3PHYA_BASE	0x0200
 
 #define U3P_USBPHYACR0		(SSUSB_SIFSLV_U2PHY_COM_BASE + 0x0000)
 #define PA0_RG_U2PLL_FORCE_ON		BIT(15)
@@ -49,7 +49,6 @@
 #define PA5_RG_U2_HS_100U_U3_EN	BIT(11)
 
 #define U3P_USBPHYACR6		(SSUSB_SIFSLV_U2PHY_COM_BASE + 0x0018)
-#define PA6_RG_U2_ISO_EN		BIT(31)
 #define PA6_RG_U2_BC11_SW_EN		BIT(23)
 #define PA6_RG_U2_OTG_VBUSCMP_EN	BIT(20)
 #define PA6_RG_U2_SQTH		GENMASK(3, 0)
@@ -91,18 +90,18 @@
 #define P2C_RG_SESSEND			BIT(4)
 #define P2C_RG_AVALID			BIT(2)
 
-#define U3P_U3_PHYA_REG0	(SSUSB_USB30_PHYA_SIV_B_BASE + 0x0000)
+#define U3P_U3_PHYA_REG0	(SSUSB_SIFSLV_U3PHYA_BASE + 0x0000)
 #define P3A_RG_U3_VUSB10_ON		BIT(5)
 
-#define U3P_U3_PHYA_REG6	(SSUSB_USB30_PHYA_SIV_B_BASE + 0x0018)
+#define U3P_U3_PHYA_REG6	(SSUSB_SIFSLV_U3PHYA_BASE + 0x0018)
 #define P3A_RG_TX_EIDLE_CM		GENMASK(31, 28)
 #define P3A_RG_TX_EIDLE_CM_VAL(x)	((0xf & (x)) << 28)
 
-#define U3P_U3_PHYA_REG9	(SSUSB_USB30_PHYA_SIV_B_BASE + 0x0024)
+#define U3P_U3_PHYA_REG9	(SSUSB_SIFSLV_U3PHYA_BASE + 0x0024)
 #define P3A_RG_RX_DAC_MUX		GENMASK(5, 1)
 #define P3A_RG_RX_DAC_MUX_VAL(x)	((0x1f & (x)) << 1)
 
-#define U3P_U3PHYA_DA_REG0	(SSUSB_SIFSLV_U3PHYA_DA_BASE + 0x0000)
+#define U3P_U3PHYA_DA_REG0	(SSUSB_SIFSLV_U3PHYA_BASE + 0x0100)
 #define P3A_RG_XTAL_EXT_EN_U3		GENMASK(11, 10)
 #define P3A_RG_XTAL_EXT_EN_U3_VAL(x)	((0x3 & (x)) << 10)
 
@@ -160,7 +159,7 @@ struct mt65xx_phy_instance {
 
 struct mt65xx_u3phy {
 	struct device *dev;
-	void __iomem *sif_base;	/* include sif2, but exclude port's */
+	void __iomem *sif_base;	/* only shared sif */
 	struct clk *u3phya_ref;	/* reference clock of usb3 anolog phy */
 	const struct mt65xx_phy_pdata *pdata;
 	struct mt65xx_phy_instance **phys;
@@ -190,7 +189,7 @@ static void hs_slew_rate_calibrate(struct mt65xx_u3phy *u3phy,
 	tmp = readl(sif_base + U3P_U2FREQ_FMCR0);
 	tmp &= ~(P2F_RG_CYCLECNT | P2F_RG_MONCLK_SEL);
 	tmp |= P2F_RG_CYCLECNT_VAL(U3P_FM_DET_CYCLE_CNT);
-	tmp |= P2F_RG_MONCLK_SEL_VAL(instance->index);
+	tmp |= P2F_RG_MONCLK_SEL_VAL(instance->index >> 1);
 	writel(tmp, sif_base + U3P_U2FREQ_FMCR0);
 
 	/* enable frequency meter */
@@ -238,6 +237,56 @@ static void hs_slew_rate_calibrate(struct mt65xx_u3phy *u3phy,
 	writel(tmp, instance->port_base + U3P_USBPHYACR5);
 }
 
+static void u3_phy_instance_init(struct mt65xx_u3phy *u3phy,
+	struct mt65xx_phy_instance *instance)
+{
+	void __iomem *port_base = instance->port_base;
+	u32 tmp;
+
+	/* gating PCIe Analog XTAL clock */
+	tmp = readl(u3phy->sif_base + U3P_XTALCTL3);
+	tmp |= XC3_RG_U3_XTAL_RX_PWD | XC3_RG_U3_FRC_XTAL_RX_PWD;
+	writel(tmp, u3phy->sif_base + U3P_XTALCTL3);
+
+	/* gating XSQ */
+	tmp = readl(port_base + U3P_U3PHYA_DA_REG0);
+	tmp &= ~P3A_RG_XTAL_EXT_EN_U3;
+	tmp |= P3A_RG_XTAL_EXT_EN_U3_VAL(2);
+	writel(tmp, port_base + U3P_U3PHYA_DA_REG0);
+
+	tmp = readl(port_base + U3P_U3_PHYA_REG9);
+	tmp &= ~P3A_RG_RX_DAC_MUX;
+	tmp |= P3A_RG_RX_DAC_MUX_VAL(4);
+	writel(tmp, port_base + U3P_U3_PHYA_REG9);
+
+	tmp = readl(port_base + U3P_U3_PHYA_REG6);
+	tmp &= ~P3A_RG_TX_EIDLE_CM;
+	tmp |= P3A_RG_TX_EIDLE_CM_VAL(0xe);
+	writel(tmp, port_base + U3P_U3_PHYA_REG6);
+
+	tmp = readl(port_base + U3P_PHYD_CDR1);
+	tmp &= ~(P3D_RG_CDR_BIR_LTD0 | P3D_RG_CDR_BIR_LTD1);
+	tmp |= P3D_RG_CDR_BIR_LTD0_VAL(0xc) | P3D_RG_CDR_BIR_LTD1_VAL(0x3);
+	writel(tmp, port_base + U3P_PHYD_CDR1);
+
+	tmp = readl(port_base + U3P_U3_PHYD_LFPS1);
+	tmp &= ~P3D_RG_FWAKE_TH;
+	tmp |= P3D_RG_FWAKE_TH_VAL(0x34);
+	writel(tmp, port_base + U3P_U3_PHYD_LFPS1);
+
+	tmp = readl(port_base + U3P_U3_PHYD_RXDET1);
+	tmp &= ~P3D_RG_RXDET_STB2_SET;
+	tmp |= P3D_RG_RXDET_STB2_SET_VAL(0x10);
+	writel(tmp, port_base + U3P_U3_PHYD_RXDET1);
+
+	tmp = readl(port_base + U3P_U3_PHYD_RXDET2);
+	tmp &= ~P3D_RG_RXDET_STB2_SET_P3;
+	tmp |= P3D_RG_RXDET_STB2_SET_P3_VAL(0x10);
+	writel(tmp, port_base + U3P_U3_PHYD_RXDET2);
+
+	dev_dbg(u3phy->dev, "%s(%d)\n", __func__, instance->index);
+}
+
 static void phy_instance_init(struct mt65xx_u3phy *u3phy,
 	struct mt65xx_phy_instance *instance)
 {
@@ -287,41 +336,6 @@ static void phy_instance_init(struct mt65xx_u3phy *u3phy,
 	tmp |= PA6_RG_U2_SQTH_VAL(2);
 	writel(tmp, port_base + U3P_USBPHYACR6);
 
-	tmp = readl(port_base + U3P_U3PHYA_DA_REG0);
-	tmp &= ~P3A_RG_XTAL_EXT_EN_U3;
-	tmp |= P3A_RG_XTAL_EXT_EN_U3_VAL(2);
-	writel(tmp, port_base + U3P_U3PHYA_DA_REG0);
-
-	tmp = readl(port_base + U3P_U3_PHYA_REG9);
-	tmp &= ~P3A_RG_RX_DAC_MUX;
-	tmp |= P3A_RG_RX_DAC_MUX_VAL(4);
-	writel(tmp, port_base + U3P_U3_PHYA_REG9);
-
-	tmp = readl(port_base + U3P_U3_PHYA_REG6);
-	tmp &= ~P3A_RG_TX_EIDLE_CM;
-	tmp |= P3A_RG_TX_EIDLE_CM_VAL(0xe);
-	writel(tmp, port_base + U3P_U3_PHYA_REG6);
-
-	tmp = readl(port_base + U3P_PHYD_CDR1);
-	tmp &= ~(P3D_RG_CDR_BIR_LTD0 | P3D_RG_CDR_BIR_LTD1);
-	tmp |= P3D_RG_CDR_BIR_LTD0_VAL(0xc) | P3D_RG_CDR_BIR_LTD1_VAL(0x3);
-	writel(tmp, port_base + U3P_PHYD_CDR1);
-
-	tmp = readl(port_base + U3P_U3_PHYD_LFPS1);
-	tmp &= ~P3D_RG_FWAKE_TH;
-	tmp |= P3D_RG_FWAKE_TH_VAL(0x34);
-	writel(tmp, port_base + U3P_U3_PHYD_LFPS1);
-
-	tmp = readl(port_base + U3P_U3_PHYD_RXDET1);
-	tmp &= ~P3D_RG_RXDET_STB2_SET;
-	tmp |= P3D_RG_RXDET_STB2_SET_VAL(0x10);
-	writel(tmp, port_base + U3P_U3_PHYD_RXDET1);
-
-	tmp = readl(port_base + U3P_U3_PHYD_RXDET2);
-	tmp &= ~P3D_RG_RXDET_STB2_SET_P3;
-	tmp |= P3D_RG_RXDET_STB2_SET_P3_VAL(0x10);
-	writel(tmp, port_base + U3P_U3_PHYD_RXDET2);
-
 	dev_dbg(u3phy->dev, "%s(%d)\n", __func__, index);
 }
 
@@ -332,13 +346,6 @@ static void phy_instance_power_on(struct mt65xx_u3phy *u3phy,
 	u32 index = instance->index;
 	u32 tmp;
 
-	if (!index) {
-		/* Set RG_SSUSB_VUSB10_ON as 1 after VUSB10 ready */
-		tmp = readl(port_base + U3P_U3_PHYA_REG0);
-		tmp |= P3A_RG_U3_VUSB10_ON;
-		writel(tmp, port_base + U3P_U3_PHYA_REG0);
-	}
-
 	/* (force_suspendm=0) (let suspendm=1, enable usb 480MHz pll) */
 	tmp = readl(port_base + U3P_U2PHYDTM0);
 	tmp &= ~(P2C_FORCE_SUSPENDM | P2C_RG_XCVRSEL);
@@ -351,10 +358,6 @@ static void phy_instance_power_on(struct mt65xx_u3phy *u3phy,
 	writel(tmp, port_base + U3P_USBPHYACR6);
 
 	if (!index) {
-		tmp = readl(u3phy->sif_base + U3P_XTALCTL3);
-		tmp |= XC3_RG_U3_XTAL_RX_PWD | XC3_RG_U3_FRC_XTAL_RX_PWD;
-		writel(tmp, u3phy->sif_base + U3P_XTALCTL3);
-
 		/* switch 100uA current to SSUSB */
 		tmp = readl(port_base + U3P_USBPHYACR5);
 		tmp |= PA5_RG_U2_HS_100U_U3_EN;
@@ -366,12 +369,6 @@ static void phy_instance_power_on(struct mt65xx_u3phy *u3phy,
 	tmp &= ~P2C_RG_SESSEND;
 	writel(tmp, port_base + U3P_U2PHYDTM1);
 
-	/* USB 2.0 slew rate calibration */
-	tmp = readl(port_base + U3P_USBPHYACR5);
-	tmp &= ~PA5_RG_U2_HSTX_SRCTRL;
-	tmp |= PA5_RG_U2_HSTX_SRCTRL_VAL(4);
-	writel(tmp, port_base + U3P_USBPHYACR5);
-
 	if (u3phy->pdata->avoid_rx_sen_degradation && index) {
 		tmp = readl(port_base + U3D_U2PHYDCR0);
 		tmp |= P2C_RG_SIF_U2PLL_FORCE_ON;
@@ -419,12 +416,6 @@ static void phy_instance_power_off(struct mt65xx_u3phy *u3phy,
 	tmp |= P2C_RG_SESSEND;
 	writel(tmp, port_base + U3P_U2PHYDTM1);
 
-	if (!index) {
-		tmp = readl(port_base + U3P_U3_PHYA_REG0);
-		tmp &= ~P3A_RG_U3_VUSB10_ON;
-		writel(tmp, port_base + U3P_U3_PHYA_REG0);
-	}
-
 	if (u3phy->pdata->avoid_rx_sen_degradation && index) {
 		tmp = readl(port_base + U3D_U2PHYDCR0);
 		tmp &= ~P2C_RG_SIF_U2PLL_FORCE_ON;
@@ -464,7 +455,11 @@ static int mt65xx_phy_init(struct phy *phy)
 		return ret;
 	}
 
-	phy_instance_init(u3phy, instance);
+	if (instance->type == PHY_TYPE_USB2)
+		phy_instance_init(u3phy, instance);
+	else
+		u3_phy_instance_init(u3phy, instance);
+
 	return 0;
 }
 
@@ -473,8 +468,10 @@ static int mt65xx_phy_power_on(struct phy *phy)
 	struct mt65xx_phy_instance *instance = phy_get_drvdata(phy);
 	struct mt65xx_u3phy *u3phy = dev_get_drvdata(phy->dev.parent);
 
-	phy_instance_power_on(u3phy, instance);
-	hs_slew_rate_calibrate(u3phy, instance);
+	if (instance->type == PHY_TYPE_USB2) {
+		phy_instance_power_on(u3phy, instance);
+		hs_slew_rate_calibrate(u3phy, instance);
+	}
 	return 0;
 }
 
@@ -483,7 +480,9 @@ static int mt65xx_phy_power_off(struct phy *phy)
 	struct mt65xx_phy_instance *instance = phy_get_drvdata(phy);
 	struct mt65xx_u3phy *u3phy = dev_get_drvdata(phy->dev.parent);
 
-	phy_instance_power_off(u3phy, instance);
+	if (instance->type == PHY_TYPE_USB2)
+		phy_instance_power_off(u3phy, instance);
+
 	return 0;
 }
 
@@ -492,7 +491,9 @@ static int mt65xx_phy_exit(struct phy *phy)
 	struct mt65xx_phy_instance *instance = phy_get_drvdata(phy);
 	struct mt65xx_u3phy *u3phy = dev_get_drvdata(phy->dev.parent);
 
-	phy_instance_exit(u3phy, instance);
+	if (instance->type == PHY_TYPE_USB2)
+		phy_instance_exit(u3phy, instance);
+
 	clk_disable_unprepare(u3phy->u3phya_ref);
 	return 0;
 }
-- 
1.7.9.5
