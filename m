From: vz@mleia.com (Vladimir Zapolskiy)
Date: Mon, 19 Sep 2016 05:42:19 +0300
Subject: [PATCH 2/2] clk: imx31: properly init clocks for machines with DT
In-Reply-To: <1474252939-12579-1-git-send-email-vz@mleia.com>
References: <1474252939-12579-1-git-send-email-vz@mleia.com>
Message-ID: <1474252939-12579-3-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The change converts exported mx31_clocks_init_dt() into a static
initialization function registered by CLK_OF_DECLARE().

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 drivers/clk/imx/clk-imx31.c | 50 +++++++++++++++++++++++----------------------
 1 file changed, 26 insertions(+), 24 deletions(-)

diff --git a/drivers/clk/imx/clk-imx31.c b/drivers/clk/imx/clk-imx31.c
index 6a49ba2..cbce308 100644
--- a/drivers/clk/imx/clk-imx31.c
+++ b/drivers/clk/imx/clk-imx31.c
@@ -21,6 +21,7 @@
 #include <linux/io.h>
 #include <linux/err.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <soc/imx/revision.h>
 #include <soc/imx/timer.h>
 #include <asm/irq.h>
@@ -72,14 +73,8 @@ static struct clk ** const uart_clks[] __initconst = {
 	NULL
 };
 
-static void __init _mx31_clocks_init(unsigned long fref)
+static void __init _mx31_clocks_init(void __iomem *base, unsigned long fref)
 {
-	void __iomem *base;
-	struct device_node *np;
-
-	base = ioremap(MX31_CCM_BASE_ADDR, SZ_4K);
-	BUG_ON(!base);
-
 	clk[dummy] = imx_clk_fixed("dummy", 0);
 	clk[ckih] = imx_clk_fixed("ckih", fref);
 	clk[ckil] = imx_clk_fixed("ckil", 32768);
@@ -147,19 +142,17 @@ static void __init _mx31_clocks_init(unsigned long fref)
 	clk_prepare_enable(clk[iim_gate]);
 	mx31_revision();
 	clk_disable_unprepare(clk[iim_gate]);
-
-	np = of_find_compatible_node(NULL, NULL, "fsl,imx31-ccm");
-
-	if (np) {
-		clk_data.clks = clk;
-		clk_data.clk_num = ARRAY_SIZE(clk);
-		of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
-	}
 }
 
 int __init mx31_clocks_init(unsigned long fref)
 {
-	_mx31_clocks_init(fref);
+	void __iomem *base;
+
+	base = ioremap(MX31_CCM_BASE_ADDR, SZ_4K);
+	if (!base)
+		panic("%s: failed to map registers\n", __func__);
+
+	_mx31_clocks_init(base, fref);
 
 	clk_register_clkdev(clk[gpt_gate], "per", "imx-gpt.0");
 	clk_register_clkdev(clk[ipg], "ipg", "imx-gpt.0");
@@ -222,22 +215,31 @@ int __init mx31_clocks_init(unsigned long fref)
 	return 0;
 }
 
-int __init mx31_clocks_init_dt(void)
+static void __init mx31_clocks_init_dt(struct device_node *np)
 {
-	struct device_node *np;
+	struct device_node *osc_np;
 	u32 fref = 26000000; /* default */
+	void __iomem *ccm;
 
-	for_each_compatible_node(np, NULL, "fixed-clock") {
-		if (!of_device_is_compatible(np, "fsl,imx-osc26m"))
+	for_each_compatible_node(osc_np, NULL, "fixed-clock") {
+		if (!of_device_is_compatible(osc_np, "fsl,imx-osc26m"))
 			continue;
 
-		if (!of_property_read_u32(np, "clock-frequency", &fref)) {
-			of_node_put(np);
+		if (!of_property_read_u32(osc_np, "clock-frequency", &fref)) {
+			of_node_put(osc_np);
 			break;
 		}
 	}
 
-	_mx31_clocks_init(fref);
+	ccm = of_iomap(np, 0);
+	if (!ccm)
+		panic("%s: failed to map registers\n", __func__);
 
-	return 0;
+	_mx31_clocks_init(ccm, fref);
+
+	clk_data.clks = clk;
+	clk_data.clk_num = ARRAY_SIZE(clk);
+	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
 }
+
+CLK_OF_DECLARE(imx31_ccm, "fsl,imx31-ccm", mx31_clocks_init_dt);
-- 
2.8.1
