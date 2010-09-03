From: fg@emlix.com (Fabian Godehardt)
Date: Fri,  3 Sep 2010 13:31:33 +0100
Subject: [PATCH] AT91: SAM9G45 - add a separate clock entry for every single
	TC block
Message-ID: <1283517093-12628-1-git-send-email-fg@emlix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without this patch you will not be able to register the first block
because of the second association call on at91_add_device_tc().

Signed-off-by: Fabian Godehardt <fg@emlix.com>
---
 arch/arm/mach-at91/at91sam9g45.c         |   12 +++++++++---
 arch/arm/mach-at91/at91sam9g45_devices.c |    4 ++--
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
index 753c0d3..52ef2d6 100644
--- a/arch/arm/mach-at91/at91sam9g45.c
+++ b/arch/arm/mach-at91/at91sam9g45.c
@@ -121,8 +121,13 @@ static struct clk ssc1_clk = {
 	.pmc_mask	= 1 << AT91SAM9G45_ID_SSC1,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
-static struct clk tcb_clk = {
-	.name		= "tcb_clk",
+static struct clk tcb0_clk = {
+	.name		= "tcb0_clk",
+	.pmc_mask	= 1 << AT91SAM9G45_ID_TCB,
+	.type		= CLK_TYPE_PERIPHERAL,
+};
+static struct clk tcb1_clk = {
+	.name		= "tcb1_clk",
 	.pmc_mask	= 1 << AT91SAM9G45_ID_TCB,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
@@ -208,7 +213,8 @@ static struct clk *periph_clocks[] __initdata = {
 	&spi1_clk,
 	&ssc0_clk,
 	&ssc1_clk,
-	&tcb_clk,
+	&tcb0_clk,
+	&tcb1_clk,
 	&pwm_clk,
 	&tsc_clk,
 	&dma_clk,
diff --git a/arch/arm/mach-at91/at91sam9g45_devices.c b/arch/arm/mach-at91/at91sam9g45_devices.c
index 809114d..4822019 100644
--- a/arch/arm/mach-at91/at91sam9g45_devices.c
+++ b/arch/arm/mach-at91/at91sam9g45_devices.c
@@ -835,9 +835,9 @@ static struct platform_device at91sam9g45_tcb1_device = {
 static void __init at91_add_device_tc(void)
 {
 	/* this chip has one clock and irq for all six TC channels */
-	at91_clock_associate("tcb_clk", &at91sam9g45_tcb0_device.dev, "t0_clk");
+	at91_clock_associate("tcb0_clk", &at91sam9g45_tcb0_device.dev, "t0_clk");
 	platform_device_register(&at91sam9g45_tcb0_device);
-	at91_clock_associate("tcb_clk", &at91sam9g45_tcb1_device.dev, "t0_clk");
+	at91_clock_associate("tcb1_clk", &at91sam9g45_tcb1_device.dev, "t0_clk");
 	platform_device_register(&at91sam9g45_tcb1_device);
 }
 #else
-- 
1.6.6.1
