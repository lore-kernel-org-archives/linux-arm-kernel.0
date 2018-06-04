From: Anson.Huang@nxp.com (Anson Huang)
Date: Mon,  4 Jun 2018 09:06:44 +0800
Subject: [PATCH V2 2/4] clk: imx6sl: remove clks_init_on array
In-Reply-To: <1528074406-11735-1-git-send-email-Anson.Huang@nxp.com>
References: <1528074406-11735-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <1528074406-11735-2-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Clock framework will enable those clocks registered
with CLK_IS_CRITICAL flag, so no need to have
clks_init_on array during clock initialization now.

ARM clock is busy divider type which has the
CLK_IS_CRITICAL flag set by default when registered.

IPG clock has no clock gate and its parent AHB clock
is busy divider type, so no need to add CLK_IS_CRITICAL
flag for IPG clock.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
changes since V1:
	improve commit log to explain why no need to add CLK_IS_CRITICAL flag for ARM and IPG clocks.
 drivers/clk/imx/clk-imx6sl.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/clk/imx/clk-imx6sl.c b/drivers/clk/imx/clk-imx6sl.c
index 66b1dd1..eb6bcbf 100644
--- a/drivers/clk/imx/clk-imx6sl.c
+++ b/drivers/clk/imx/clk-imx6sl.c
@@ -104,10 +104,6 @@ static struct clk_onecell_data clk_data;
 static void __iomem *ccm_base;
 static void __iomem *anatop_base;
 
-static const u32 clks_init_on[] __initconst = {
-	IMX6SL_CLK_IPG, IMX6SL_CLK_ARM, IMX6SL_CLK_MMDC_ROOT,
-};
-
 /*
  * ERR005311 CCM: After exit from WAIT mode, unwanted interrupt(s) taken
  *           during WAIT mode entry process could cause cache memory
@@ -195,7 +191,6 @@ static void __init imx6sl_clocks_init(struct device_node *ccm_node)
 {
 	struct device_node *np;
 	void __iomem *base;
-	int i;
 	int ret;
 
 	clks[IMX6SL_CLK_DUMMY] = imx_clk_fixed("dummy", 0);
@@ -426,13 +421,6 @@ static void __init imx6sl_clocks_init(struct device_node *ccm_node)
 		pr_warn("%s: failed to set AHB clock rate %d!\n",
 			__func__, ret);
 
-	/*
-	 * Make sure those always on clocks are enabled to maintain the correct
-	 * usecount and enabling/disabling of parent PLLs.
-	 */
-	for (i = 0; i < ARRAY_SIZE(clks_init_on); i++)
-		clk_prepare_enable(clks[clks_init_on[i]]);
-
 	if (IS_ENABLED(CONFIG_USB_MXS_PHY)) {
 		clk_prepare_enable(clks[IMX6SL_CLK_USBPHY1_GATE]);
 		clk_prepare_enable(clks[IMX6SL_CLK_USBPHY2_GATE]);
-- 
2.7.4
