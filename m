From: linux-kernel-dev@beckhoff.com (linux-kernel-dev at beckhoff.com)
Date: Thu, 26 Nov 2015 16:10:20 +0100
Subject: [PATCH] clk: imx5: ipu_di_sel clocks can set parent rates
Message-ID: <1448550620-24219-1-git-send-email-linux-kernel-dev@beckhoff.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrick Br?nn <p.bruenn@beckhoff.com>

To obtain exact pixel clocks, allow the DI clock selectors to influence
the PLLs that they are derived from.

Commit 4591b13289b54fb5cbce84ee170f7390c576ef8f did this for i.MX6.
Port it to enable high display resolutions on i.MX53 based platforms
such as CX9020 Industrial PC, too.

Signed-off-by: Patrick Br?nn <p.bruenn@beckhoff.com>
---
 drivers/clk/imx/clk-imx51-imx53.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/imx/clk-imx51-imx53.c b/drivers/clk/imx/clk-imx51-imx53.c
index c677034..29d4c44 100644
--- a/drivers/clk/imx/clk-imx51-imx53.c
+++ b/drivers/clk/imx/clk-imx51-imx53.c
@@ -519,10 +519,10 @@ static void __init mx53_clocks_init(struct device_node *np)
 						mx53_ldb_di0_sel, ARRAY_SIZE(mx53_ldb_di0_sel), CLK_SET_RATE_PARENT);
 	clk[IMX5_CLK_LDB_DI0_GATE]	= imx_clk_gate2("ldb_di0_gate", "ldb_di0_div", MXC_CCM_CCGR6, 28);
 	clk[IMX5_CLK_LDB_DI1_GATE]	= imx_clk_gate2("ldb_di1_gate", "ldb_di1_div", MXC_CCM_CCGR6, 30);
-	clk[IMX5_CLK_IPU_DI0_SEL]	= imx_clk_mux("ipu_di0_sel", MXC_CCM_CSCMR2, 26, 3,
-						mx53_ipu_di0_sel, ARRAY_SIZE(mx53_ipu_di0_sel));
-	clk[IMX5_CLK_IPU_DI1_SEL]	= imx_clk_mux("ipu_di1_sel", MXC_CCM_CSCMR2, 29, 3,
-						mx53_ipu_di1_sel, ARRAY_SIZE(mx53_ipu_di1_sel));
+	clk[IMX5_CLK_IPU_DI0_SEL]	= imx_clk_mux_flags("ipu_di0_sel", MXC_CCM_CSCMR2, 26, 3,
+						mx53_ipu_di0_sel, ARRAY_SIZE(mx53_ipu_di0_sel), CLK_SET_RATE_PARENT);
+	clk[IMX5_CLK_IPU_DI1_SEL]	= imx_clk_mux_flags("ipu_di1_sel", MXC_CCM_CSCMR2, 29, 3,
+						mx53_ipu_di1_sel, ARRAY_SIZE(mx53_ipu_di1_sel), CLK_SET_RATE_PARENT);
 	clk[IMX5_CLK_TVE_EXT_SEL]	= imx_clk_mux_flags("tve_ext_sel", MXC_CCM_CSCMR1, 6, 1,
 						mx53_tve_ext_sel, ARRAY_SIZE(mx53_tve_ext_sel), CLK_SET_RATE_PARENT);
 	clk[IMX5_CLK_TVE_GATE]		= imx_clk_gate2("tve_gate", "tve_pred", MXC_CCM_CCGR2, 30);
-- 
1.9.1
