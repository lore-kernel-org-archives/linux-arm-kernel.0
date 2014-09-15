From: b20788@freescale.com (Anson Huang)
Date: Mon, 15 Sep 2014 15:44:46 +0800
Subject: [PATCH 2/2] ARM: imx: add anatop settings for LPDDR2 when enter DSM
 mode
In-Reply-To: <1410767086-3462-1-git-send-email-b20788@freescale.com>
References: <1410767086-3462-1-git-send-email-b20788@freescale.com>
Message-ID: <1410767086-3462-2-git-send-email-b20788@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For LPDDR2 platform, no need to enable weak2P5 in DSM mode,
it can be pulled down to save power(~0.65mW).

And per design team's recommendation, we should disconnect
VDDHIGH and SNVS in DSM mode on i.MX6SL.

Signed-off-by: Anson Huang <b20788@freescale.com>
---
 arch/arm/mach-imx/anatop.c |   36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/anatop.c b/arch/arm/mach-imx/anatop.c
index 8259a62..3b25b32 100644
--- a/arch/arm/mach-imx/anatop.c
+++ b/arch/arm/mach-imx/anatop.c
@@ -30,11 +30,16 @@
 #define ANADIG_DIGPROG_IMX6SL	0x280
 
 #define BM_ANADIG_REG_2P5_ENABLE_WEAK_LINREG	0x40000
+#define BM_ANADIG_REG_2P5_ENABLE_PULLDOWN	0x8
 #define BM_ANADIG_REG_CORE_FET_ODRIVE		0x20000000
 #define BM_ANADIG_ANA_MISC0_STOP_MODE_CONFIG	0x1000
+/* Below MISC0_DISCON_HIGH_SNVS is only for i.MX6SL */
+#define BM_ANADIG_ANA_MISC0_DISCON_HIGH_SNVS	0x2000
 #define BM_ANADIG_USB_CHRG_DETECT_CHK_CHRG_B	0x80000
 #define BM_ANADIG_USB_CHRG_DETECT_EN_B		0x100000
 
+#define DDR_TYPE_LPDDR2		1
+
 static struct regmap *anatop;
 
 static void imx_anatop_enable_weak2p5(bool enable)
@@ -56,16 +61,43 @@ static void imx_anatop_enable_fet_odrive(bool enable)
 		BM_ANADIG_REG_CORE_FET_ODRIVE);
 }
 
+static inline void imx_anatop_enable_2p5_pulldown(bool enable)
+{
+	regmap_write(anatop, ANADIG_REG_2P5 + (enable ? REG_SET : REG_CLR),
+		BM_ANADIG_REG_2P5_ENABLE_PULLDOWN);
+}
+
+static inline void imx_anatop_disconnect_high_snvs(bool enable)
+{
+	regmap_write(anatop, ANADIG_ANA_MISC0 + (enable ? REG_SET : REG_CLR),
+		BM_ANADIG_ANA_MISC0_DISCON_HIGH_SNVS);
+}
+
 void imx_anatop_pre_suspend(void)
 {
-	imx_anatop_enable_weak2p5(true);
+	if (imx_mmdc_get_ddr_type() == DDR_TYPE_LPDDR2)
+		imx_anatop_enable_2p5_pulldown(true);
+	else
+		imx_anatop_enable_weak2p5(true);
+
 	imx_anatop_enable_fet_odrive(true);
+
+	if (cpu_is_imx6sl())
+		imx_anatop_disconnect_high_snvs(true);
 }
 
 void imx_anatop_post_resume(void)
 {
+	if (imx_mmdc_get_ddr_type() == DDR_TYPE_LPDDR2)
+		imx_anatop_enable_2p5_pulldown(false);
+	else
+		imx_anatop_enable_weak2p5(false);
+
 	imx_anatop_enable_fet_odrive(false);
-	imx_anatop_enable_weak2p5(false);
+
+	if (cpu_is_imx6sl())
+		imx_anatop_disconnect_high_snvs(false);
+
 }
 
 static void imx_anatop_usb_chrg_detect_disable(void)
-- 
1.7.9.5
