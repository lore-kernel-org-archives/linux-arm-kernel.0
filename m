From: padma.v@samsung.com (Padmavathi Venna)
Date: Thu, 20 Oct 2011 17:20:36 +0530
Subject: [PATCH] ARM: mxs: Use CLKDEV_INIT for creating clk_lookup instance
Message-ID: <1319111436-27856-1-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A common macro CLKDEV_INIT was added for creating clk_lookup
instance in include/linux/clkdev.h. So replace _REGISTER_CLOCK
macro with CLKDEV_INIT.

Suggested by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---
 arch/arm/mach-mxs/clock-mx23.c |   39 +++++++++-------------
 arch/arm/mach-mxs/clock-mx28.c |   71 ++++++++++++++++++----------------------
 2 files changed, 48 insertions(+), 62 deletions(-)

diff --git a/arch/arm/mach-mxs/clock-mx23.c b/arch/arm/mach-mxs/clock-mx23.c
index 0163b6d..7714dc2 100644
--- a/arch/arm/mach-mxs/clock-mx23.c
+++ b/arch/arm/mach-mxs/clock-mx23.c
@@ -430,32 +430,25 @@ _DEFINE_CLOCK(audio_clk, XTAL, FILT_CLK24M_GATE, &ref_xtal_clk);
 _DEFINE_CLOCK(pwm_clk, XTAL, PWM_CLK24M_GATE, &ref_xtal_clk);
 _DEFINE_CLOCK(clk32k_clk, XTAL, TIMROT_CLK32K_GATE, &ref_xtal_clk);
 
-#define _REGISTER_CLOCK(d, n, c) \
-	{ \
-		.dev_id = d, \
-		.con_id = n, \
-		.clk = &c, \
-	},
-
 static struct clk_lookup lookups[] = {
 	/* for amba bus driver */
-	_REGISTER_CLOCK("duart", "apb_pclk", xbus_clk)
+	CLKDEV_INIT("duart", "apb_pclk", &xbus_clk),
 	/* for amba-pl011 driver */
-	_REGISTER_CLOCK("duart", NULL, uart_clk)
-	_REGISTER_CLOCK("mxs-auart.0", NULL, uart_clk)
-	_REGISTER_CLOCK("rtc", NULL, rtc_clk)
-	_REGISTER_CLOCK("mxs-dma-apbh", NULL, hbus_clk)
-	_REGISTER_CLOCK("mxs-dma-apbx", NULL, xbus_clk)
-	_REGISTER_CLOCK("mxs-mmc.0", NULL, ssp_clk)
-	_REGISTER_CLOCK("mxs-mmc.1", NULL, ssp_clk)
-	_REGISTER_CLOCK(NULL, "usb", usb_clk)
-	_REGISTER_CLOCK(NULL, "audio", audio_clk)
-	_REGISTER_CLOCK("mxs-pwm.0", NULL, pwm_clk)
-	_REGISTER_CLOCK("mxs-pwm.1", NULL, pwm_clk)
-	_REGISTER_CLOCK("mxs-pwm.2", NULL, pwm_clk)
-	_REGISTER_CLOCK("mxs-pwm.3", NULL, pwm_clk)
-	_REGISTER_CLOCK("mxs-pwm.4", NULL, pwm_clk)
-	_REGISTER_CLOCK("imx23-fb", NULL, lcdif_clk)
+	CLKDEV_INIT("duart", NULL, &uart_clk),
+	CLKDEV_INIT("mxs-auart.0", NULL, &uart_clk),
+	CLKDEV_INIT("rtc", NULL, &rtc_clk),
+	CLKDEV_INIT("mxs-dma-apbh", NULL, &hbus_clk),
+	CLKDEV_INIT("mxs-dma-apbx", NULL, &xbus_clk),
+	CLKDEV_INIT("mxs-mmc.0", NULL, &ssp_clk),
+	CLKDEV_INIT("mxs-mmc.1", NULL, &ssp_clk),
+	CLKDEV_INIT(NULL, "usb", &usb_clk),
+	CLKDEV_INIT(NULL, "audio", &audio_clk),
+	CLKDEV_INIT("mxs-pwm.0", NULL, &pwm_clk),
+	CLKDEV_INIT("mxs-pwm.1", NULL, &pwm_clk),
+	CLKDEV_INIT("mxs-pwm.2", NULL, &pwm_clk),
+	CLKDEV_INIT("mxs-pwm.3", NULL, &pwm_clk),
+	CLKDEV_INIT("mxs-pwm.4", NULL, &pwm_clk),
+	CLKDEV_INIT("imx23-fb", NULL, &lcdif_clk),
 };
 
 static int clk_misc_init(void)
diff --git a/arch/arm/mach-mxs/clock-mx28.c b/arch/arm/mach-mxs/clock-mx28.c
index 7b28c2a..1c5c929 100644
--- a/arch/arm/mach-mxs/clock-mx28.c
+++ b/arch/arm/mach-mxs/clock-mx28.c
@@ -604,48 +604,41 @@ _DEFINE_CLOCK(clk32k_clk, XTAL, TIMROT_CLK32K_GATE, &ref_xtal_clk);
 _DEFINE_CLOCK(spdif_clk, SPDIF, CLKGATE, &pll0_clk);
 _DEFINE_CLOCK(fec_clk, ENET, DISABLE, &hbus_clk);
 
-#define _REGISTER_CLOCK(d, n, c) \
-	{ \
-		.dev_id = d, \
-		.con_id = n, \
-		.clk = &c, \
-	},
-
 static struct clk_lookup lookups[] = {
 	/* for amba bus driver */
-	_REGISTER_CLOCK("duart", "apb_pclk", xbus_clk)
+	CLKDEV_INIT("duart", "apb_pclk", &xbus_clk),
 	/* for amba-pl011 driver */
-	_REGISTER_CLOCK("duart", NULL, uart_clk)
-	_REGISTER_CLOCK("imx28-fec.0", NULL, fec_clk)
-	_REGISTER_CLOCK("imx28-fec.1", NULL, fec_clk)
-	_REGISTER_CLOCK("mxs-auart.0", NULL, uart_clk)
-	_REGISTER_CLOCK("mxs-auart.1", NULL, uart_clk)
-	_REGISTER_CLOCK("mxs-auart.2", NULL, uart_clk)
-	_REGISTER_CLOCK("mxs-auart.3", NULL, uart_clk)
-	_REGISTER_CLOCK("mxs-auart.4", NULL, uart_clk)
-	_REGISTER_CLOCK("rtc", NULL, rtc_clk)
-	_REGISTER_CLOCK("pll2", NULL, pll2_clk)
-	_REGISTER_CLOCK("mxs-dma-apbh", NULL, hbus_clk)
-	_REGISTER_CLOCK("mxs-dma-apbx", NULL, xbus_clk)
-	_REGISTER_CLOCK("mxs-mmc.0", NULL, ssp0_clk)
-	_REGISTER_CLOCK("mxs-mmc.1", NULL, ssp1_clk)
-	_REGISTER_CLOCK("flexcan.0", NULL, can0_clk)
-	_REGISTER_CLOCK("flexcan.1", NULL, can1_clk)
-	_REGISTER_CLOCK(NULL, "usb0", usb0_clk)
-	_REGISTER_CLOCK(NULL, "usb1", usb1_clk)
-	_REGISTER_CLOCK("mxs-pwm.0", NULL, pwm_clk)
-	_REGISTER_CLOCK("mxs-pwm.1", NULL, pwm_clk)
-	_REGISTER_CLOCK("mxs-pwm.2", NULL, pwm_clk)
-	_REGISTER_CLOCK("mxs-pwm.3", NULL, pwm_clk)
-	_REGISTER_CLOCK("mxs-pwm.4", NULL, pwm_clk)
-	_REGISTER_CLOCK("mxs-pwm.5", NULL, pwm_clk)
-	_REGISTER_CLOCK("mxs-pwm.6", NULL, pwm_clk)
-	_REGISTER_CLOCK("mxs-pwm.7", NULL, pwm_clk)
-	_REGISTER_CLOCK(NULL, "lradc", lradc_clk)
-	_REGISTER_CLOCK(NULL, "spdif", spdif_clk)
-	_REGISTER_CLOCK("imx28-fb", NULL, lcdif_clk)
-	_REGISTER_CLOCK("mxs-saif.0", NULL, saif0_clk)
-	_REGISTER_CLOCK("mxs-saif.1", NULL, saif1_clk)
+	CLKDEV_INIT("duart", NULL, &uart_clk),
+	CLKDEV_INIT("imx28-fec.0", NULL, &fec_clk),
+	CLKDEV_INIT("imx28-fec.1", NULL, &fec_clk),
+	CLKDEV_INIT("mxs-auart.0", NULL, &uart_clk),
+	CLKDEV_INIT("mxs-auart.1", NULL, &uart_clk),
+	CLKDEV_INIT("mxs-auart.2", NULL, &uart_clk),
+	CLKDEV_INIT("mxs-auart.3", NULL, &uart_clk),
+	CLKDEV_INIT("mxs-auart.4", NULL, &uart_clk),
+	CLKDEV_INIT("rtc", NULL, &rtc_clk),
+	CLKDEV_INIT("pll2", NULL, &pll2_clk),
+	CLKDEV_INIT("mxs-dma-apbh", NULL, &hbus_clk),
+	CLKDEV_INIT("mxs-dma-apbx", NULL, &xbus_clk),
+	CLKDEV_INIT("mxs-mmc.0", NULL, &ssp0_clk),
+	CLKDEV_INIT("mxs-mmc.1", NULL, &ssp1_clk),
+	CLKDEV_INIT("flexcan.0", NULL, &can0_clk),
+	CLKDEV_INIT("flexcan.1", NULL, &can1_clk),
+	CLKDEV_INIT(NULL, "usb0", &usb0_clk),
+	CLKDEV_INIT(NULL, "usb1", &usb1_clk),
+	CLKDEV_INIT("mxs-pwm.0", NULL, &pwm_clk),
+	CLKDEV_INIT("mxs-pwm.1", NULL, &pwm_clk),
+	CLKDEV_INIT("mxs-pwm.2", NULL, &pwm_clk),
+	CLKDEV_INIT("mxs-pwm.3", NULL, &pwm_clk),
+	CLKDEV_INIT("mxs-pwm.4", NULL, &pwm_clk),
+	CLKDEV_INIT("mxs-pwm.5", NULL, &pwm_clk),
+	CLKDEV_INIT("mxs-pwm.6", NULL, &pwm_clk),
+	CLKDEV_INIT("mxs-pwm.7", NULL, &pwm_clk),
+	CLKDEV_INIT(NULL, "lradc", &lradc_clk),
+	CLKDEV_INIT(NULL, "spdif", &spdif_clk),
+	CLKDEV_INIT("imx28-fb", NULL, &lcdif_clk),
+	CLKDEV_INIT("mxs-saif.0", NULL, &saif0_clk),
+	CLKDEV_INIT("mxs-saif.1", NULL, &saif1_clk),
 };
 
 static int clk_misc_init(void)
-- 
1.7.4.4
