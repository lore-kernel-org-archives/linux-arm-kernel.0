From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 28 Mar 2011 18:01:27 +0200
Subject: [PATCH 1/4] arm: lpc32xx: add tsc-device
Message-ID: <1301328090-25994-1-git-send-email-w.sang@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the clock name, too.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---
 arch/arm/mach-lpc32xx/clock.c  |    2 +-
 arch/arm/mach-lpc32xx/common.c |   21 +++++++++++++++++++++
 arch/arm/mach-lpc32xx/common.h |    1 +
 3 files changed, 23 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-lpc32xx/clock.c b/arch/arm/mach-lpc32xx/clock.c
index da0e649..1e02751 100644
--- a/arch/arm/mach-lpc32xx/clock.c
+++ b/arch/arm/mach-lpc32xx/clock.c
@@ -1077,7 +1077,7 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("lpc32xx-nand.0", "nand_ck", clk_nand)
 	_REGISTER_CLOCK("tbd", "i2s0_ck", clk_i2s0)
 	_REGISTER_CLOCK("tbd", "i2s1_ck", clk_i2s1)
-	_REGISTER_CLOCK("lpc32xx-ts", NULL, clk_tsc)
+	_REGISTER_CLOCK("ts-lpc32xx", NULL, clk_tsc)
 	_REGISTER_CLOCK("dev:mmc0", "MCLK", clk_mmc)
 	_REGISTER_CLOCK("lpc-net.0", NULL, clk_net)
 	_REGISTER_CLOCK("dev:clcd", NULL, clk_lcd)
diff --git a/arch/arm/mach-lpc32xx/common.c b/arch/arm/mach-lpc32xx/common.c
index ee24dc2..5c186b0 100644
--- a/arch/arm/mach-lpc32xx/common.c
+++ b/arch/arm/mach-lpc32xx/common.c
@@ -95,6 +95,27 @@ struct platform_device lpc32xx_i2c2_device = {
 	},
 };
 
+/* TSC (Touch Screen Controller) */
+
+static struct resource lpc32xx_tsc_resources[] = {
+	{
+		.start = LPC32XX_ADC_BASE,
+		.end = LPC32XX_ADC_BASE + SZ_16K - 1,
+		.flags = IORESOURCE_MEM,
+	}, {
+		.start = IRQ_LPC32XX_TS_IRQ,
+		.end = IRQ_LPC32XX_TS_IRQ,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device lpc32xx_tsc_device = {
+	.name =  "ts-lpc32xx",
+	.id = -1,
+	.num_resources = ARRAY_SIZE(lpc32xx_tsc_resources),
+	.resource = lpc32xx_tsc_resources,
+};
+
 /*
  * Returns the unique ID for the device
  */
diff --git a/arch/arm/mach-lpc32xx/common.h b/arch/arm/mach-lpc32xx/common.h
index f82211f..e81243c 100644
--- a/arch/arm/mach-lpc32xx/common.h
+++ b/arch/arm/mach-lpc32xx/common.h
@@ -28,6 +28,7 @@ extern struct platform_device lpc32xx_watchdog_device;
 extern struct platform_device lpc32xx_i2c0_device;
 extern struct platform_device lpc32xx_i2c1_device;
 extern struct platform_device lpc32xx_i2c2_device;
+extern struct platform_device lpc32xx_tsc_device;
 
 /*
  * Other arch specific structures and functions
-- 
1.7.2.5
