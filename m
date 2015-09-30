From: alexander.stein@systec-electronic.com (Alexander Stein)
Date: Wed, 30 Sep 2015 08:23:40 +0200
Subject: [PATCH v4 1/1] clk: imx31: Do not call mxc_timer_init twice when
 booting with DT
Message-ID: <1443594220-21183-1-git-send-email-alexander.stein@systec-electronic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mxc_timer_init must not be called from within mx31_clocks_init_dt. It will
eventually be called by imx31_timer_init_dt
(drivers/clocksource/timer-imx-gpt.c).
This arranges the initialization code similar to clk-imx27.c

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
---
Changes in v4:
* Adjusted subject line
* Move static fref variable to function local one
* rebases to Shawn's imx/clk branch

Changes in v3:
* Fix compilation issues
* Actually compile tested, but still untested due to lack of hardware

* Added in v2
* Compile tested only due to lack of hardware

 drivers/clk/imx/clk-imx31.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/imx/clk-imx31.c b/drivers/clk/imx/clk-imx31.c
index 5520e20..f65b8b1 100644
--- a/drivers/clk/imx/clk-imx31.c
+++ b/drivers/clk/imx/clk-imx31.c
@@ -72,7 +72,7 @@ static struct clk ** const uart_clks[] __initconst = {
 	NULL
 };
 
-int __init mx31_clocks_init(unsigned long fref)
+static void __init _mx31_clocks_init(unsigned long fref)
 {
 	void __iomem *base;
 	struct device_node *np;
@@ -142,6 +142,12 @@ int __init mx31_clocks_init(unsigned long fref)
 
 	imx_check_clocks(clk, ARRAY_SIZE(clk));
 
+	clk_set_parent(clk[csi], clk[upll]);
+	clk_prepare_enable(clk[emi_gate]);
+	clk_prepare_enable(clk[iim_gate]);
+	mx31_revision();
+	clk_disable_unprepare(clk[iim_gate]);
+
 	np = of_find_compatible_node(NULL, NULL, "fsl,imx31-ccm");
 
 	if (np) {
@@ -149,6 +155,13 @@ int __init mx31_clocks_init(unsigned long fref)
 		clk_data.clk_num = ARRAY_SIZE(clk);
 		of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
 	}
+}
+
+int __init mx31_clocks_init(void)
+{
+	u32 fref = 26000000; /* default */
+
+	_mx31_clocks_init(fref);
 
 	clk_register_clkdev(clk[gpt_gate], "per", "imx-gpt.0");
 	clk_register_clkdev(clk[ipg], "ipg", "imx-gpt.0");
@@ -204,14 +217,8 @@ int __init mx31_clocks_init(unsigned long fref)
 	clk_register_clkdev(clk[sdma_gate], NULL, "imx31-sdma");
 	clk_register_clkdev(clk[iim_gate], "iim", NULL);
 
-	clk_set_parent(clk[csi], clk[upll]);
-	clk_prepare_enable(clk[emi_gate]);
-	clk_prepare_enable(clk[iim_gate]);
-	mx31_revision();
-	clk_disable_unprepare(clk[iim_gate]);
 
 	imx_register_uart_clocks(uart_clks);
-
 	mxc_timer_init(MX31_GPT1_BASE_ADDR, MX31_INT_GPT, GPT_TYPE_IMX31);
 
 	return 0;
@@ -230,5 +237,7 @@ int __init mx31_clocks_init_dt(void)
 			break;
 	}
 
-	return mx31_clocks_init(fref);
+	_mx31_clocks_init(fref);
+
+	return 0;
 }
-- 
2.4.9
