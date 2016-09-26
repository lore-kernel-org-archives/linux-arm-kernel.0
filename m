From: vz@mleia.com (Vladimir Zapolskiy)
Date: Mon, 26 Sep 2016 03:03:43 +0300
Subject: [PATCH v2 4/4] ARM: clk: imx31: properly init clocks for machines
 with DT
In-Reply-To: <1474848223-19728-1-git-send-email-vz@mleia.com>
References: <1474848223-19728-1-git-send-email-vz@mleia.com>
Message-ID: <1474848223-19728-5-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Clock initialization for i.MX31 powered machines with DT support
should be done by a call of an init function registered with
CLK_OF_DECLARE() in common clock framework.

The change converts exported mx31_clocks_init_dt() into a static
initialization function registered by CLK_OF_DECLARE().

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
Changes from v1 to v2:
* this change is a squashed change of arch/arm and clk changes,
  if only one of two changes is applied there is a compilation
  time or runtime issue.

 arch/arm/mach-imx/common.h   |  1 -
 arch/arm/mach-imx/imx31-dt.c |  6 ------
 drivers/clk/imx/clk-imx31.c  | 50 +++++++++++++++++++++++---------------------
 3 files changed, 26 insertions(+), 31 deletions(-)

diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index a8f4693..e97d8cb 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -48,7 +48,6 @@ int mx21_clocks_init(unsigned long lref, unsigned long fref);
 int mx27_clocks_init(unsigned long fref);
 int mx31_clocks_init(unsigned long fref);
 int mx35_clocks_init(void);
-int mx31_clocks_init_dt(void);
 struct platform_device *mxc_register_gpio(char *name, int id,
 	resource_size_t iobase, resource_size_t iosize, int irq, int irq_high);
 void mxc_set_cpu_type(unsigned int type);
diff --git a/arch/arm/mach-imx/imx31-dt.c b/arch/arm/mach-imx/imx31-dt.c
index 62e6b4f..668d74b 100644
--- a/arch/arm/mach-imx/imx31-dt.c
+++ b/arch/arm/mach-imx/imx31-dt.c
@@ -23,11 +23,6 @@ static const char * const imx31_dt_board_compat[] __initconst = {
 	NULL
 };
 
-static void __init imx31_dt_timer_init(void)
-{
-	mx31_clocks_init_dt();
-}
-
 /* FIXME: replace with DT binding */
 static const struct resource imx31_rnga_res[] __initconst = {
 	DEFINE_RES_MEM(MX31_RNGA_BASE_ADDR, SZ_16K),
@@ -43,7 +38,6 @@ DT_MACHINE_START(IMX31_DT, "Freescale i.MX31 (Device Tree Support)")
 	.map_io		= mx31_map_io,
 	.init_early	= imx31_init_early,
 	.init_irq	= mx31_init_irq,
-	.init_time	= imx31_dt_timer_init,
 	.init_machine	= imx31_dt_mach_init,
 	.dt_compat	= imx31_dt_board_compat,
 MACHINE_END
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
