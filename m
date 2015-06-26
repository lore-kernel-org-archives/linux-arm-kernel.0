From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Fri, 26 Jun 2015 14:10:54 -0300
Subject: [PATCH v3 2/2] clk: imx: clk-imx6q: Provide initial IPU clock
 settings for mx6dl
In-Reply-To: <1435338654-9098-1-git-send-email-fabio.estevam@freescale.com>
References: <1435338654-9098-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1435338654-9098-2-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently it is not possible to use HDMI and LVDS at the same time on a 
imx6dl-sabresd board.

Fix this usecase by setting IMX6QDL_CLK_PLL3_PFD1_540M to 540MHz and
also by setting it as the parent of IMX6QDL_CLK_IPU1_SEL.

Based on the configuration done in the FSL kernel.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v2:
- Move clk_set_rate for PLL3_PFD1_540M outside the if block as suggested
by Vladimir Zapolskiy.

 drivers/clk/imx/clk-imx6q.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
index d046f8e..c507bca 100644
--- a/drivers/clk/imx/clk-imx6q.c
+++ b/drivers/clk/imx/clk-imx6q.c
@@ -494,6 +494,10 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 		clk_set_parent(clk[IMX6QDL_CLK_LDB_DI1_SEL], clk[IMX6QDL_CLK_PLL5_VIDEO_DIV]);
 	}
 
+	clk_set_rate(clk[IMX6QDL_CLK_PLL3_PFD1_540M], 540000000);
+	if (clk_on_imx6dl())
+		clk_set_parent(clk[IMX6QDL_CLK_IPU1_SEL], clk[IMX6QDL_CLK_PLL3_PFD1_540M]);
+
 	clk_set_parent(clk[IMX6QDL_CLK_IPU1_DI0_PRE_SEL], clk[IMX6QDL_CLK_PLL5_VIDEO_DIV]);
 	clk_set_parent(clk[IMX6QDL_CLK_IPU1_DI1_PRE_SEL], clk[IMX6QDL_CLK_PLL5_VIDEO_DIV]);
 	clk_set_parent(clk[IMX6QDL_CLK_IPU2_DI0_PRE_SEL], clk[IMX6QDL_CLK_PLL5_VIDEO_DIV]);
-- 
1.9.1
