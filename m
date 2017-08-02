From: jonas.gorski@gmail.com (Jonas Gorski)
Date: Wed,  2 Aug 2017 11:34:28 +0200
Subject: [PATCH 7/8] MIPS: BCM63XX: move the HSSPI PLL HZ into its own clock
In-Reply-To: <20170802093429.12572-1-jonas.gorski@gmail.com>
References: <20170802093429.12572-1-jonas.gorski@gmail.com>
Message-ID: <20170802093429.12572-8-jonas.gorski@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Split up the HSSPL clock into rate and a gate clock, to more closely
match the actual hardware.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 arch/mips/bcm63xx/clk.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/mips/bcm63xx/clk.c b/arch/mips/bcm63xx/clk.c
index 8a089a92e029..884099de097f 100644
--- a/arch/mips/bcm63xx/clk.c
+++ b/arch/mips/bcm63xx/clk.c
@@ -248,6 +248,10 @@ static struct clk clk_hsspi = {
 	.set	= hsspi_set,
 };
 
+/*
+ * HSSPI PLL
+ */
+static struct clk clk_hsspi_pll;
 
 /*
  * XTM clock
@@ -379,6 +383,7 @@ static struct clk_lookup bcm6328_clks[] = {
 	CLKDEV_INIT(NULL, "periph", &clk_periph),
 	CLKDEV_INIT("bcm63xx_uart.0", "refclk", &clk_periph),
 	CLKDEV_INIT("bcm63xx_uart.1", "refclk", &clk_periph),
+	CLKDEV_INIT("bcm63xx-hsspi.0", "pll", &clk_hsspi_pll),
 	/* gated clocks */
 	CLKDEV_INIT(NULL, "enetsw", &clk_enetsw),
 	CLKDEV_INIT(NULL, "usbh", &clk_usbh),
@@ -452,6 +457,7 @@ static struct clk_lookup bcm6362_clks[] = {
 	CLKDEV_INIT(NULL, "periph", &clk_periph),
 	CLKDEV_INIT("bcm63xx_uart.0", "refclk", &clk_periph),
 	CLKDEV_INIT("bcm63xx_uart.1", "refclk", &clk_periph),
+	CLKDEV_INIT("bcm63xx-hsspi.0", "pll", &clk_hsspi_pll),
 	/* gated clocks */
 	CLKDEV_INIT(NULL, "enetsw", &clk_enetsw),
 	CLKDEV_INIT(NULL, "usbh", &clk_usbh),
@@ -486,7 +492,7 @@ static int __init bcm63xx_clk_init(void)
 		clkdev_add_table(bcm3368_clks, ARRAY_SIZE(bcm3368_clks));
 		break;
 	case BCM6328_CPU_ID:
-		clk_hsspi.rate = HSSPI_PLL_HZ_6328;
+		clk_hsspi_pll.rate = HSSPI_PLL_HZ_6328;
 		clkdev_add_table(bcm6328_clks, ARRAY_SIZE(bcm6328_clks));
 		break;
 	case BCM6338_CPU_ID:
@@ -502,7 +508,7 @@ static int __init bcm63xx_clk_init(void)
 		clkdev_add_table(bcm6358_clks, ARRAY_SIZE(bcm6358_clks));
 		break;
 	case BCM6362_CPU_ID:
-		clk_hsspi.rate = HSSPI_PLL_HZ_6362;
+		clk_hsspi_pll.rate = HSSPI_PLL_HZ_6362;
 		clkdev_add_table(bcm6362_clks, ARRAY_SIZE(bcm6362_clks));
 		break;
 	case BCM6368_CPU_ID:
-- 
2.13.2
