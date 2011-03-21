From: LW@KARO-electronics.de (=?utf-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Mon, 21 Mar 2011 17:48:05 +0100
Subject: [PATCH 1/2] ARM: mxs: configure and register the second FEC device on
	TX28/STK5-V4
Message-ID: <1300726086-23297-1-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/mach-mxs/module-tx28.c |   41 +++++++++++++++++++++++++++++++++-----
 arch/arm/mach-mxs/module-tx28.h |    1 +
 2 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-mxs/module-tx28.c b/arch/arm/mach-mxs/module-tx28.c
index 7510057..7d44936 100644
--- a/arch/arm/mach-mxs/module-tx28.c
+++ b/arch/arm/mach-mxs/module-tx28.c
@@ -45,7 +45,7 @@ static const iomux_cfg_t tx28_fec_gpio_pads[] __initconst = {
 };
 
 #define FEC_MODE (MXS_PAD_8MA | MXS_PAD_PULLUP | MXS_PAD_3V3)
-static const iomux_cfg_t tx28_fec_pads[] __initconst = {
+static const iomux_cfg_t tx28_fec0_pads[] __initconst = {
 	MX28_PAD_ENET0_MDC__ENET0_MDC | FEC_MODE,
 	MX28_PAD_ENET0_MDIO__ENET0_MDIO | FEC_MODE,
 	MX28_PAD_ENET0_RX_EN__ENET0_RX_EN | FEC_MODE,
@@ -57,7 +57,20 @@ static const iomux_cfg_t tx28_fec_pads[] __initconst = {
 	MX28_PAD_ENET_CLK__CLKCTRL_ENET | FEC_MODE,
 };
 
-static const struct fec_platform_data tx28_fec_data __initconst = {
+static const iomux_cfg_t tx28_fec1_pads[] __initconst = {
+	MX28_PAD_ENET0_RXD2__ENET1_RXD0,
+	MX28_PAD_ENET0_RXD3__ENET1_RXD1,
+	MX28_PAD_ENET0_TXD2__ENET1_TXD0,
+	MX28_PAD_ENET0_TXD3__ENET1_TXD1,
+	MX28_PAD_ENET0_COL__ENET1_TX_EN,
+	MX28_PAD_ENET0_CRS__ENET1_RX_EN,
+};
+
+static struct fec_platform_data tx28_fec0_data = {
+	.phy = PHY_INTERFACE_MODE_RMII,
+};
+
+static struct fec_platform_data tx28_fec1_data = {
 	.phy = PHY_INTERFACE_MODE_RMII,
 };
 
@@ -119,15 +132,15 @@ int __init tx28_add_fec0(void)
 	pr_debug("%s: Deasserting FEC PHY RESET\n", __func__);
 	gpio_set_value(TX28_FEC_PHY_RESET, 1);
 
-	ret = mxs_iomux_setup_multiple_pads(tx28_fec_pads,
-			ARRAY_SIZE(tx28_fec_pads));
+	ret = mxs_iomux_setup_multiple_pads(tx28_fec0_pads,
+			ARRAY_SIZE(tx28_fec0_pads));
 	if (ret) {
 		pr_debug("%s: mxs_iomux_setup_multiple_pads() failed with rc: %d\n",
 				__func__, ret);
 		goto free_gpios;
 	}
-	pr_debug("%s: Registering FEC device\n", __func__);
-	mx28_add_fec(0, &tx28_fec_data);
+	pr_debug("%s: Registering FEC0 device\n", __func__);
+	mx28_add_fec(0, &tx28_fec0_data);
 	return 0;
 
 free_gpios:
@@ -140,3 +153,19 @@ free_gpios:
 
 	return ret;
 }
+
+int __init tx28_add_fec1(void)
+{
+	int ret;
+
+	ret = mxs_iomux_setup_multiple_pads(tx28_fec1_pads,
+			ARRAY_SIZE(tx28_fec1_pads));
+	if (ret) {
+		pr_debug("%s: mxs_iomux_setup_multiple_pads() failed with rc: %d\n",
+				__func__, ret);
+		return ret;
+	}
+	pr_debug("%s: Registering FEC1 device\n", __func__);
+	mx28_add_fec(1, &tx28_fec1_data);
+	return 0;
+}
diff --git a/arch/arm/mach-mxs/module-tx28.h b/arch/arm/mach-mxs/module-tx28.h
index df9e1b6..8ed4254 100644
--- a/arch/arm/mach-mxs/module-tx28.h
+++ b/arch/arm/mach-mxs/module-tx28.h
@@ -7,3 +7,4 @@
  * Free Software Foundation.
  */
 int __init tx28_add_fec0(void);
+int __init tx28_add_fec1(void);
-- 
1.5.6.5
