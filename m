From: anson.huang@nxp.com (Anson Huang)
Date: Wed, 17 Oct 2018 06:12:04 +0000
Subject: [PATCH 2/2] clk: imx7d: remove CLK_IS_CRITICAL flag for
 arm_a7_root_clk
In-Reply-To: <1539756441-18776-1-git-send-email-Anson.Huang@nxp.com>
References: <1539756441-18776-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <1539756441-18776-2-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i.MX7D uses virtual cpu clock of "arm" clock to be child clock
of "arm_a7_root_clk" and it is with CLK_IS_CRITICAL flag set, so
no need to add CLK_IS_CRITICAL flag for keeping "arm_a7_root_clk"
use count correct, latest clock tree is as below in clk_summary:

pll_arm_main                         1        1        0   792000000          0
      pll_arm_main_bypass            1        1        0   792000000          0
         pll_arm_main_clk            1        1        0   792000000          0
            arm_a7_src               1        1        0   792000000          0
               arm_a7_cg             1        1        0   792000000          0
                  arm_a7_div         1        1        0   792000000          0
                     arm_a7_root_clk       1        1        0   792000000    0
                        arm          1        1        0   792000000

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/clk/imx/clk-imx7d.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx7d.c b/drivers/clk/imx/clk-imx7d.c
index 076460b..adb08f6 100644
--- a/drivers/clk/imx/clk-imx7d.c
+++ b/drivers/clk/imx/clk-imx7d.c
@@ -775,7 +775,7 @@ static void __init imx7d_clocks_init(struct device_node *ccm_node)
 	clks[IMX7D_CLKO1_ROOT_DIV] = imx_clk_divider2("clko1_post_div", "clko1_pre_div", base + 0xbd80, 0, 6);
 	clks[IMX7D_CLKO2_ROOT_DIV] = imx_clk_divider2("clko2_post_div", "clko2_pre_div", base + 0xbe00, 0, 6);
 
-	clks[IMX7D_ARM_A7_ROOT_CLK] = imx_clk_gate2_flags("arm_a7_root_clk", "arm_a7_div", base + 0x4000, 0, CLK_IS_CRITICAL | CLK_OPS_PARENT_ENABLE);
+	clks[IMX7D_ARM_A7_ROOT_CLK] = imx_clk_gate2_flags("arm_a7_root_clk", "arm_a7_div", base + 0x4000, 0, CLK_OPS_PARENT_ENABLE);
 	clks[IMX7D_ARM_M4_ROOT_CLK] = imx_clk_gate4("arm_m4_root_clk", "arm_m4_div", base + 0x4010, 0);
 	clks[IMX7D_MAIN_AXI_ROOT_CLK] = imx_clk_gate2_flags("main_axi_root_clk", "axi_post_div", base + 0x4040, 0, CLK_IS_CRITICAL | CLK_OPS_PARENT_ENABLE);
 	clks[IMX7D_DISP_AXI_ROOT_CLK] = imx_clk_gate4("disp_axi_root_clk", "disp_axi_post_div", base + 0x4050, 0);
-- 
2.7.4
