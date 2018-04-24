From: jae.hyun.yoo@linux.intel.com (Jae Hyun Yoo)
Date: Tue, 24 Apr 2018 15:40:56 -0700
Subject: [PATCH linux dev-4.13] clk:aspeed: Fix reset bits for PCI/VGA and PECI
Message-ID: <20180424224056.23384-1-jae.hyun.yoo@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit fixes incorrect setting of reset bits for PCI/VGA and
PECI modules.

1. Reset bit for PCI/VGA is 8.
2. PECI reset logic is missing so added bit 10 as its reset bit.

Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
---
 drivers/clk/clk-aspeed.c                 | 4 ++--
 include/dt-bindings/clock/aspeed-clock.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/clk-aspeed.c b/drivers/clk/clk-aspeed.c
index de8e1db..71404a2 100644
--- a/drivers/clk/clk-aspeed.c
+++ b/drivers/clk/clk-aspeed.c
@@ -100,7 +100,7 @@ static const struct aspeed_gate_data aspeed_gates[] = {
 	[ASPEED_CLK_GATE_GCLK] =	{  1,  7, "gclk-gate",		NULL,	0 }, /* 2D engine */
 	[ASPEED_CLK_GATE_MCLK] =	{  2, -1, "mclk-gate",		"mpll",	CLK_IS_CRITICAL }, /* SDRAM */
 	[ASPEED_CLK_GATE_VCLK] =	{  3,  6, "vclk-gate",		NULL,	0 }, /* Video Capture */
-	[ASPEED_CLK_GATE_BCLK] =	{  4, 10, "bclk-gate",		"bclk",	CLK_IS_CRITICAL }, /* PCIe/PCI */
+	[ASPEED_CLK_GATE_BCLK] =	{  4,  8, "bclk-gate",		"bclk",	CLK_IS_CRITICAL }, /* PCIe/PCI */
 	[ASPEED_CLK_GATE_DCLK] =	{  5, -1, "dclk-gate",		NULL,	CLK_IS_CRITICAL }, /* DAC */
 	[ASPEED_CLK_GATE_REFCLK] =	{  6, -1, "refclk-gate",	"clkin", CLK_IS_CRITICAL },
 	[ASPEED_CLK_GATE_USBPORT2CLK] =	{  7,  3, "usb-port2-gate",	NULL,	0 }, /* USB2.0 Host port 2 */
@@ -315,8 +315,8 @@ static const u8 aspeed_resets[] = {
 	[ASPEED_RESET_ADC]	= 23,
 	[ASPEED_RESET_JTAG_MASTER] = 22,
 	[ASPEED_RESET_MIC]	= 18,
+	[ASPEED_RESET_PECI]	= 10,
 	[ASPEED_RESET_PWM]	=  9,
-	[ASPEED_RESET_PCIVGA]	=  8,
 	[ASPEED_RESET_I2C]	=  2,
 	[ASPEED_RESET_AHB]	=  1,
 
diff --git a/include/dt-bindings/clock/aspeed-clock.h b/include/dt-bindings/clock/aspeed-clock.h
index e983d17..379f727 100644
--- a/include/dt-bindings/clock/aspeed-clock.h
+++ b/include/dt-bindings/clock/aspeed-clock.h
@@ -43,8 +43,8 @@
 #define ASPEED_RESET_ADC		2
 #define ASPEED_RESET_JTAG_MASTER	3
 #define ASPEED_RESET_MIC		4
-#define ASPEED_RESET_PWM		5
-#define ASPEED_RESET_PCIVGA		6
+#define ASPEED_RESET_PECI		5
+#define ASPEED_RESET_PWM		6
 #define ASPEED_RESET_I2C		7
 #define ASPEED_RESET_AHB		8
 #define ASPEED_RESET_CRT1		9
-- 
2.7.4
