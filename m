From: alexander.stein@systec-electronic.com (Alexander Stein)
Date: Wed,  9 Sep 2015 11:35:15 +0200
Subject: [PATCH v2 2/2] ARM: imx31: Do not call mxc_timer_init twice when
 booting with DT
In-Reply-To: <1441791315-25390-1-git-send-email-alexander.stein@systec-electronic.com>
References: <1441791315-25390-1-git-send-email-alexander.stein@systec-electronic.com>
Message-ID: <1441791315-25390-2-git-send-email-alexander.stein@systec-electronic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mxc_timer_init must not be called from within mx31_clocks_init_dt. It will
eventually be called by imx31_timer_init_dt
(drivers/clocksource/timer-imx-gpt.c).
This arranges the initialization code similar to clk-imx27.c

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
---
* Added in v2
* Compile tested only due to lack of hardware

 drivers/clk/imx/clk-imx31.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/imx/clk-imx31.c b/drivers/clk/imx/clk-imx31.c
index fe66c40..9a49653 100644
--- a/drivers/clk/imx/clk-imx31.c
+++ b/drivers/clk/imx/clk-imx31.c
@@ -62,7 +62,7 @@ enum mx31_clks {
 static struct clk *clk[clk_max];
 static struct clk_onecell_data clk_data;
 
-int __init mx31_clocks_init(unsigned long fref)
+static void __init _mx31_clocks_init(unsigned long fref)
 {
 	void __iomem *base;
 	struct device_node *np;
@@ -132,6 +132,12 @@ int __init mx31_clocks_init(unsigned long fref)
 
 	imx_check_clocks(clk, ARRAY_SIZE(clk));
 
+	clk_set_parent(clk[csi], clk[upll]);
+	clk_prepare_enable(clk[emi_gate]);
+	clk_prepare_enable(clk[iim_gate]);
+	mx31_revision();
+	clk_disable_unprepare(clk[iim_gate]);
+
 	np = of_find_compatible_node(NULL, NULL, "fsl,imx31-ccm");
 
 	if (np) {
@@ -139,6 +145,11 @@ int __init mx31_clocks_init(unsigned long fref)
 		clk_data.clk_num = ARRAY_SIZE(clk);
 		of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
 	}
+}
+
+int __init mx31_clocks_init(void)
+{
+	_mx31_clocks_init();
 
 	clk_register_clkdev(clk[gpt_gate], "per", "imx-gpt.0");
 	clk_register_clkdev(clk[ipg], "ipg", "imx-gpt.0");
@@ -193,12 +204,6 @@ int __init mx31_clocks_init(unsigned long fref)
 	clk_register_clkdev(clk[sdma_gate], NULL, "imx31-sdma");
 	clk_register_clkdev(clk[iim_gate], "iim", NULL);
 
-	clk_set_parent(clk[csi], clk[upll]);
-	clk_prepare_enable(clk[emi_gate]);
-	clk_prepare_enable(clk[iim_gate]);
-	mx31_revision();
-	clk_disable_unprepare(clk[iim_gate]);
-
 	mxc_timer_init(MX31_GPT1_BASE_ADDR, MX31_INT_GPT, GPT_TYPE_IMX31);
 
 	return 0;
@@ -217,5 +222,5 @@ int __init mx31_clocks_init_dt(void)
 			break;
 	}
 
-	return mx31_clocks_init(fref);
+	return _mx31_clocks_init(fref);
 }
-- 
2.4.6
