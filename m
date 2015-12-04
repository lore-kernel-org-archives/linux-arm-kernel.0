From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Fri, 4 Dec 2015 10:11:05 +0800
Subject: [RESEND,PATCH] phy: phy-mt65xx-usb3: improve HS eye diagram
Message-ID: <1449195065-31392-1-git-send-email-chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

calibrate HS slew rate and switch 100uA current to SSUSB
to improve HS eye diagram of HQA test.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/phy/phy-mt65xx-usb3.c | 99 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 96 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/phy-mt65xx-usb3.c b/drivers/phy/phy-mt65xx-usb3.c
index dc480d3..9069162 100644
--- a/drivers/phy/phy-mt65xx-usb3.c
+++ b/drivers/phy/phy-mt65xx-usb3.c
@@ -17,6 +17,7 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/phy/phy.h>
@@ -27,6 +28,7 @@
  * relative to USB3_SIF2_BASE base address
  */
 #define SSUSB_SIFSLV_SPLLC		0x0000
+#define SSUSB_SIFSLV_U2FREQ		0x0100
 
 /* offsets of sub-segment in each port registers */
 #define SSUSB_SIFSLV_U2PHY_COM_BASE	0x0000
@@ -41,6 +43,7 @@
 #define PA2_RG_SIF_U2PLL_FORCE_EN	BIT(18)
 
 #define U3P_USBPHYACR5		(SSUSB_SIFSLV_U2PHY_COM_BASE + 0x0014)
+#define PA5_RG_U2_HSTX_SRCAL_EN	BIT(15)
 #define PA5_RG_U2_HSTX_SRCTRL		GENMASK(14, 12)
 #define PA5_RG_U2_HSTX_SRCTRL_VAL(x)	((0x7 & (x)) << 12)
 #define PA5_RG_U2_HS_100U_U3_EN	BIT(11)
@@ -113,6 +116,24 @@
 #define XC3_RG_U3_XTAL_RX_PWD		BIT(9)
 #define XC3_RG_U3_FRC_XTAL_RX_PWD	BIT(8)
 
+#define U3P_U2FREQ_FMCR0	(SSUSB_SIFSLV_U2FREQ + 0x00)
+#define P2F_RG_MONCLK_SEL	GENMASK(27, 26)
+#define P2F_RG_MONCLK_SEL_VAL(x)	((0x3 & (x)) << 26)
+#define P2F_RG_FREQDET_EN	BIT(24)
+#define P2F_RG_CYCLECNT		GENMASK(23, 0)
+#define P2F_RG_CYCLECNT_VAL(x)	((P2F_RG_CYCLECNT) & (x))
+
+#define U3P_U2FREQ_VALUE	(SSUSB_SIFSLV_U2FREQ + 0x0c)
+
+#define U3P_U2FREQ_FMMONR1	(SSUSB_SIFSLV_U2FREQ + 0x10)
+#define P2F_USB_FM_VALID	BIT(0)
+#define P2F_RG_FRCK_EN		BIT(8)
+
+#define U3P_REF_CLK		26	/* MHZ */
+#define U3P_SLEW_RATE_COEF	28
+#define U3P_SR_COEF_DIVISOR	1000
+#define U3P_FM_DET_CYCLE_CNT	1024
+
 struct mt65xx_phy_instance {
 	struct phy *phy;
 	void __iomem *port_base;
@@ -128,6 +149,77 @@ struct mt65xx_u3phy {
 	int nphys;
 };
 
+static void hs_slew_rate_calibrate(struct mt65xx_u3phy *u3phy,
+	struct mt65xx_phy_instance *instance)
+{
+	void __iomem *sif_base = u3phy->sif_base;
+	int calibration_val;
+	int fm_out;
+	u32 tmp;
+
+	/* enable USB ring oscillator */
+	tmp = readl(instance->port_base + U3P_USBPHYACR5);
+	tmp |= PA5_RG_U2_HSTX_SRCAL_EN;
+	writel(tmp, instance->port_base + U3P_USBPHYACR5);
+	udelay(1);
+
+	/*enable free run clock */
+	tmp = readl(sif_base + U3P_U2FREQ_FMMONR1);
+	tmp |= P2F_RG_FRCK_EN;
+	writel(tmp, sif_base + U3P_U2FREQ_FMMONR1);
+
+	/* set cycle count as 1024, and select u2 channel */
+	tmp = readl(sif_base + U3P_U2FREQ_FMCR0);
+	tmp &= ~(P2F_RG_CYCLECNT | P2F_RG_MONCLK_SEL);
+	tmp |= P2F_RG_CYCLECNT_VAL(U3P_FM_DET_CYCLE_CNT);
+	tmp |= P2F_RG_MONCLK_SEL_VAL(instance->index);
+	writel(tmp, sif_base + U3P_U2FREQ_FMCR0);
+
+	/* enable frequency meter */
+	tmp = readl(sif_base + U3P_U2FREQ_FMCR0);
+	tmp |= P2F_RG_FREQDET_EN;
+	writel(tmp, sif_base + U3P_U2FREQ_FMCR0);
+
+	/* ignore return value */
+	readl_poll_timeout(sif_base + U3P_U2FREQ_FMMONR1, tmp,
+		  (tmp & P2F_USB_FM_VALID), 10, 200);
+
+	fm_out = readl(sif_base + U3P_U2FREQ_VALUE);
+
+	/* disable frequency meter */
+	tmp = readl(sif_base + U3P_U2FREQ_FMCR0);
+	tmp &= ~P2F_RG_FREQDET_EN;
+	writel(tmp, sif_base + U3P_U2FREQ_FMCR0);
+
+	/*disable free run clock */
+	tmp = readl(sif_base + U3P_U2FREQ_FMMONR1);
+	tmp &= ~P2F_RG_FRCK_EN;
+	writel(tmp, sif_base + U3P_U2FREQ_FMMONR1);
+
+	if (fm_out) {
+		/* ( 1024 / FM_OUT ) x reference clock frequency x 0.028 */
+		tmp = U3P_FM_DET_CYCLE_CNT * U3P_REF_CLK * U3P_SLEW_RATE_COEF;
+		tmp /= fm_out;
+		calibration_val = DIV_ROUND_CLOSEST(tmp, U3P_SR_COEF_DIVISOR);
+	} else {
+		/* if FM detection fail, set default value */
+		calibration_val = 4;
+	}
+	dev_dbg(u3phy->dev, "phy:%d, fm_out:%d, calib:%d\n",
+		instance->index, fm_out, calibration_val);
+
+	/* set HS slew rate */
+	tmp = readl(instance->port_base + U3P_USBPHYACR5);
+	tmp &= ~PA5_RG_U2_HSTX_SRCTRL;
+	tmp |= PA5_RG_U2_HSTX_SRCTRL_VAL(calibration_val);
+	writel(tmp, instance->port_base + U3P_USBPHYACR5);
+
+	/* disable USB ring oscillator */
+	tmp = readl(instance->port_base + U3P_USBPHYACR5);
+	tmp &= ~PA5_RG_U2_HSTX_SRCAL_EN;
+	writel(tmp, instance->port_base + U3P_USBPHYACR5);
+}
+
 static void phy_instance_init(struct mt65xx_u3phy *u3phy,
 	struct mt65xx_phy_instance *instance)
 {
@@ -226,9 +318,9 @@ static void phy_instance_power_on(struct mt65xx_u3phy *u3phy,
 		tmp |= XC3_RG_U3_XTAL_RX_PWD | XC3_RG_U3_FRC_XTAL_RX_PWD;
 		writel(tmp, u3phy->sif_base + U3P_XTALCTL3);
 
-		/* [mt8173]disable Change 100uA current from SSUSB */
+		/* [mt8173]switch 100uA current to SSUSB */
 		tmp = readl(port_base + U3P_USBPHYACR5);
-		tmp &= ~PA5_RG_U2_HS_100U_U3_EN;
+		tmp |= PA5_RG_U2_HS_100U_U3_EN;
 		writel(tmp, port_base + U3P_USBPHYACR5);
 	}
 
@@ -273,7 +365,7 @@ static void phy_instance_power_off(struct mt65xx_u3phy *u3phy,
 	writel(tmp, port_base + U3P_USBPHYACR6);
 
 	if (!index) {
-		/* (also disable)Change 100uA current switch to USB2.0 */
+		/* switch 100uA current back to USB2.0 */
 		tmp = readl(port_base + U3P_USBPHYACR5);
 		tmp &= ~PA5_RG_U2_HS_100U_U3_EN;
 		writel(tmp, port_base + U3P_USBPHYACR5);
@@ -343,6 +435,7 @@ static int mt65xx_phy_power_on(struct phy *phy)
 	struct mt65xx_u3phy *u3phy = dev_get_drvdata(phy->dev.parent);
 
 	phy_instance_power_on(u3phy, instance);
+	hs_slew_rate_calibrate(u3phy, instance);
 	return 0;
 }
 
-- 
1.8.1.1.dirty
