From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 12 Nov 2009 11:42:05 +0100
Subject: [PATCH 9/9] i.MX35: Fix audmux clock
In-Reply-To: <1258022525-21078-9-git-send-email-s.hauer@pengutronix.de>
References: <1258022525-21078-1-git-send-email-s.hauer@pengutronix.de>
	<1258022525-21078-2-git-send-email-s.hauer@pengutronix.de>
	<1258022525-21078-3-git-send-email-s.hauer@pengutronix.de>
	<1258022525-21078-4-git-send-email-s.hauer@pengutronix.de>
	<1258022525-21078-5-git-send-email-s.hauer@pengutronix.de>
	<1258022525-21078-6-git-send-email-s.hauer@pengutronix.de>
	<1258022525-21078-7-git-send-email-s.hauer@pengutronix.de>
	<1258022525-21078-8-git-send-email-s.hauer@pengutronix.de>
	<1258022525-21078-9-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1258022525-21078-10-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i.MX35 Datasheet claims that CCM_CGR0[4] is for the audio muxer,
but hardware tests showed that really CCM_CGR2[30] is for the audio
muxer (which is labelled as admux in the datasheet). Fix this.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mx3/clock-imx35.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-mx3/clock-imx35.c b/arch/arm/mach-mx3/clock-imx35.c
index 5068e1d..1353f65 100644
--- a/arch/arm/mach-mx3/clock-imx35.c
+++ b/arch/arm/mach-mx3/clock-imx35.c
@@ -335,7 +335,7 @@ static void clk_cgr_disable(struct clk *clk)
 
 DEFINE_CLOCK(asrc_clk,   0, CCM_CGR0,  0, NULL, NULL);
 DEFINE_CLOCK(ata_clk,    0, CCM_CGR0,  2, get_rate_ipg, NULL);
-DEFINE_CLOCK(audmux_clk, 0, CCM_CGR0,  4, NULL, NULL);
+/* DEFINE_CLOCK(audmux_clk, 0, CCM_CGR0,  4, NULL, NULL); */
 DEFINE_CLOCK(can1_clk,   0, CCM_CGR0,  6, get_rate_ipg, NULL);
 DEFINE_CLOCK(can2_clk,   1, CCM_CGR0,  8, get_rate_ipg, NULL);
 DEFINE_CLOCK(cspi1_clk,  0, CCM_CGR0, 10, get_rate_ipg, NULL);
@@ -381,7 +381,7 @@ DEFINE_CLOCK(uart3_clk,  2, CCM_CGR2, 20, get_rate_uart, NULL);
 DEFINE_CLOCK(usbotg_clk, 0, CCM_CGR2, 22, get_rate_otg, NULL);
 DEFINE_CLOCK(wdog_clk,   0, CCM_CGR2, 24, NULL, NULL);
 DEFINE_CLOCK(max_clk,    0, CCM_CGR2, 26, NULL, NULL);
-DEFINE_CLOCK(admux_clk,  0, CCM_CGR2, 30, NULL, NULL);
+DEFINE_CLOCK(audmux_clk, 0, CCM_CGR2, 30, NULL, NULL);
 
 DEFINE_CLOCK(csi_clk,    0, CCM_CGR3,  0, get_rate_csi, NULL);
 DEFINE_CLOCK(iim_clk,    0, CCM_CGR3,  2, NULL, NULL);
@@ -426,7 +426,6 @@ static struct clk nfc_clk = {
 static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK(NULL, "asrc", asrc_clk)
 	_REGISTER_CLOCK(NULL, "ata", ata_clk)
-	_REGISTER_CLOCK(NULL, "audmux", audmux_clk)
 	_REGISTER_CLOCK(NULL, "can", can1_clk)
 	_REGISTER_CLOCK(NULL, "can", can2_clk)
 	_REGISTER_CLOCK("spi_imx.0", NULL, cspi1_clk)
@@ -474,7 +473,7 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("fsl-usb2-udc", "usb", usbotg_clk)
 	_REGISTER_CLOCK("mxc_wdt.0", NULL, wdog_clk)
 	_REGISTER_CLOCK(NULL, "max", max_clk)
-	_REGISTER_CLOCK(NULL, "admux", admux_clk)
+	_REGISTER_CLOCK(NULL, "audmux", audmux_clk)
 	_REGISTER_CLOCK(NULL, "csi", csi_clk)
 	_REGISTER_CLOCK(NULL, "iim", iim_clk)
 	_REGISTER_CLOCK(NULL, "gpu2d", gpu2d_clk)
-- 
1.6.5.2
