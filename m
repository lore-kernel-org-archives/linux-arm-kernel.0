From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 16 May 2012 12:50:21 +0200
Subject: [PATCH 4/4] ARM: imx6q: prepare and enable init on clks directly
 instead of clk_get first
In-Reply-To: <1337165421-17118-1-git-send-email-s.hauer@pengutronix.de>
References: <1337165421-17118-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1337165421-17118-5-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Richard Zhao <richard.zhao@freescale.com>

This also removes the usboh3 clk from the initially turned on
clocks which leaked in from an internal development tree.

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-imx/clk-imx6q.c |   20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index 24324f2..7b4751d 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -122,10 +122,6 @@ static const char *cko1_sels[]	= { "pll3_usb_otg", "pll2_bus", "pll1_sys", "pll5
 				    "dummy", "axi", "enfc", "ipu1_di0", "ipu1_di1", "ipu2_di0",
 				    "ipu2_di1", "ahb", "ipg", "ipg_per", "ckil", "pll4_audio", };
 
-static const char * const clks_init_on[] __initconst = {
-	"mmdc_ch0_axi", "mmdc_ch1_axi", "usboh3",
-};
-
 enum mx6q_clks {
 	dummy, ckil, ckih, osc, pll2_pfd0_352m, pll2_pfd1_594m, pll2_pfd2_396m,
 	pll3_pfd0_720m, pll3_pfd1_540m, pll3_pfd2_508m, pll3_pfd3_454m,
@@ -160,11 +156,14 @@ enum mx6q_clks {
 
 static struct clk *clk[clk_max];
 
+static enum mx6q_clks const clks_init_on[] __initconst = {
+	mmdc_ch0_axi, mmdc_ch1_axi,
+};
+
 int __init mx6q_clocks_init(void)
 {
 	struct device_node *np;
 	void __iomem *base;
-	struct clk *c;
 	int i, irq;
 
 	clk[dummy] = imx_clk_fixed("dummy", 0);
@@ -419,15 +418,8 @@ int __init mx6q_clocks_init(void)
 	clk_register_clkdev(clk[dummy], NULL, "20bc000.wdog");
 	clk_register_clkdev(clk[dummy], NULL, "20c0000.wdog");
 
-	for (i = 0; i < ARRAY_SIZE(clks_init_on); i++) {
-		c = clk_get_sys(clks_init_on[i], NULL);
-		if (IS_ERR(c)) {
-			pr_err("%s: failed to get clk %s", __func__,
-			       clks_init_on[i]);
-			return PTR_ERR(c);
-		}
-		clk_prepare_enable(c);
-	}
+	for (i = 0; i < ARRAY_SIZE(clks_init_on); i++)
+		clk_prepare_enable(clk[clks_init_on[i]]);
 
 	np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-gpt");
 	base = of_iomap(np, 0);
-- 
1.7.10
