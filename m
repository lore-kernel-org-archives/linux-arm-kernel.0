From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 29 Dec 2014 10:47:04 +0900
Subject: [PATCH 1/4] ARM: shmobile: sh73a0 legacy/reference: Add missing
 INTCA0 clock for irqpin module
In-Reply-To: <cover.1419810196.git.horms+renesas@verge.net.au>
References: <cover.1419810196.git.horms+renesas@verge.net.au>
Message-ID: <2f472ae6b1998af6d9a4ccc3f0d58781db21cafc.1419810196.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

This clock drives the irqpin controller modules.
Before, it was assumed enabled by the bootloader or reset state.
By making it available to the driver, we make sure it gets enabled when
needed, and allow it to be managed by system or runtime PM.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-sh73a0.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/mach-shmobile/clock-sh73a0.c b/arch/arm/mach-shmobile/clock-sh73a0.c
index 6b4c1f3..3855fb0 100644
--- a/arch/arm/mach-shmobile/clock-sh73a0.c
+++ b/arch/arm/mach-shmobile/clock-sh73a0.c
@@ -553,6 +553,7 @@ enum { MSTP001,
 	MSTP314, MSTP313, MSTP312, MSTP311,
 	MSTP304, MSTP303, MSTP302, MSTP301, MSTP300,
 	MSTP411, MSTP410, MSTP403,
+	MSTP508,
 	MSTP_NR };
 
 #define MSTP(_parent, _reg, _bit, _flags) \
@@ -597,6 +598,7 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP411] = MSTP(&div4_clks[DIV4_HP], SMSTPCR4, 11, 0), /* IIC3 */
 	[MSTP410] = MSTP(&div4_clks[DIV4_HP], SMSTPCR4, 10, 0), /* IIC4 */
 	[MSTP403] = MSTP(&r_clk, SMSTPCR4, 3, 0), /* KEYSC */
+	[MSTP508] = MSTP(&div4_clks[DIV4_HP], SMSTPCR5, 8, 0), /* INTCA0 */
 };
 
 /* The lookups structure below includes duplicate entries for some clocks
@@ -677,6 +679,14 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("i2c-sh_mobile.4", &mstp_clks[MSTP410]), /* I2C4 */
 	CLKDEV_DEV_ID("e6828000.i2c", &mstp_clks[MSTP410]), /* I2C4 */
 	CLKDEV_DEV_ID("sh_keysc.0", &mstp_clks[MSTP403]), /* KEYSC */
+	CLKDEV_DEV_ID("renesas_intc_irqpin.0",	&mstp_clks[MSTP508]), /* INTCA0 */
+	CLKDEV_DEV_ID("e6900000.irqpin",	&mstp_clks[MSTP508]), /* INTCA0 */
+	CLKDEV_DEV_ID("renesas_intc_irqpin.1",	&mstp_clks[MSTP508]), /* INTCA0 */
+	CLKDEV_DEV_ID("e6900004.irqpin",	&mstp_clks[MSTP508]), /* INTCA0 */
+	CLKDEV_DEV_ID("renesas_intc_irqpin.2",	&mstp_clks[MSTP508]), /* INTCA0 */
+	CLKDEV_DEV_ID("e6900008.irqpin",	&mstp_clks[MSTP508]), /* INTCA0 */
+	CLKDEV_DEV_ID("renesas_intc_irqpin.3",	&mstp_clks[MSTP508]), /* INTCA0 */
+	CLKDEV_DEV_ID("e690000c.irqpin",	&mstp_clks[MSTP508]), /* INTCA0 */
 
 	/* ICK */
 	CLKDEV_ICK_ID("dsit_clk", "sh-mipi-dsi.0", &div6_clks[DIV6_DSIT]),
-- 
2.1.3
