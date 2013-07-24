From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 24 Jul 2013 09:34:00 +0900
Subject: [PATCH 06/16] ARM: shmobile: r8a73a4: add Z2 clock support
In-Reply-To: <cover.1374624383.git.horms+renesas@verge.net.au>
References: <cover.1374624383.git.horms+renesas@verge.net.au>
Message-ID: <a040f22d2c2e82347f978b52e7402a7387e5dee5.1374624383.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

The Z2 clock on r8a73a4 is used to clock the 4 Cortex A7 cores on the SoC.
Add a definition for this clock to later use it from the arm_big_little
CPUFreq driver.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-r8a73a4.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/mach-shmobile/clock-r8a73a4.c b/arch/arm/mach-shmobile/clock-r8a73a4.c
index 22f10ff..27ff58c 100644
--- a/arch/arm/mach-shmobile/clock-r8a73a4.c
+++ b/arch/arm/mach-shmobile/clock-r8a73a4.c
@@ -323,6 +323,21 @@ static struct clk z_clk = {
 	.ops = &zclk_ops,
 };
 
+/*
+ * It seems only 1/2 divider is usable in manual mode. 1/2 / 2/3
+ * switching is only available in auto-DVFS mode
+ */
+SH_FIXED_RATIO_CLK(pll0_div2_clk,	pll0_clk,		div2);
+
+static struct clk z2_clk = {
+	.parent = &pll0_div2_clk,
+	.div_mask = 0x1f,
+	.enable_bit = 0,
+	/* We'll need to access FRQCRB and FRQCRC */
+	.enable_reg = (void __iomem *)FRQCRB,
+	.ops = &zclk_ops,
+};
+
 static struct clk *main_clks[] = {
 	&extalr_clk,
 	&extal1_clk,
@@ -341,6 +356,8 @@ static struct clk *main_clks[] = {
 	&pll2s_clk,
 	&pll2h_clk,
 	&z_clk,
+	&pll0_div2_clk,
+	&z2_clk,
 };
 
 /* DIV4 */
-- 
1.8.2.1
