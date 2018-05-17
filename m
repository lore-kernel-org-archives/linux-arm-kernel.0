From: Anson.Huang@nxp.com (Anson Huang)
Date: Thu, 17 May 2018 16:40:21 +0800
Subject: [PATCH 1/2] clk: imx7d: correct enet clock CCGR register offset
Message-ID: <1526546422-7431-1-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Correct enet clock CCGR register offset.

CCGR6: IMX7D_ENET_AXI_ROOT_CLK (enet1 and enet2 bus clocks)
CCGR112: IMX7D_ENET1_TIME_ROOT_CLK, IMX7D_ENET1_IPG_ROOT_CLK
CCGR113: IMX7D_ENET2_TIME_ROOT_CLK, IMX7D_ENET2_IPG_ROOT_CLK

IMX7D_ENET_PHY_REF_ROOT_DIV supplies clock for PHY,
no gate after this clock, its parent clock root has gate.
IMX7D_ENET1_REF_ROOT_DIV/IMX7D_ENET2_REF_ROOT_DIV supplies clocks
for enet IPG_CLK_RMII, no gate after the clock, its parent
clock root has gate.

IMX7D_PLL_ENET_MAIN_125M_CLK (anatop pll) supplies clock for
enet RGMII tx_clk.

Based on Andy Duan's patch from the NXP kernel tree.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/clk/imx/clk-imx7d.c             | 11 ++++++-----
 include/dt-bindings/clock/imx7d-clock.h |  4 +++-
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/imx/clk-imx7d.c b/drivers/clk/imx/clk-imx7d.c
index 975a20d..485ab49 100644
--- a/drivers/clk/imx/clk-imx7d.c
+++ b/drivers/clk/imx/clk-imx7d.c
@@ -26,6 +26,8 @@ static u32 share_count_sai1;
 static u32 share_count_sai2;
 static u32 share_count_sai3;
 static u32 share_count_nand;
+static u32 share_count_enet1;
+static u32 share_count_enet2;
 
 static const struct clk_div_table test_div_table[] = {
 	{ .val = 3, .div = 1, },
@@ -805,6 +807,10 @@ static void __init imx7d_clocks_init(struct device_node *ccm_node)
 	clks[IMX7D_MIPI_DSI_ROOT_CLK] = imx_clk_gate4("mipi_dsi_root_clk", "mipi_dsi_post_div", base + 0x4650, 0);
 	clks[IMX7D_MIPI_CSI_ROOT_CLK] = imx_clk_gate4("mipi_csi_root_clk", "mipi_csi_post_div", base + 0x4640, 0);
 	clks[IMX7D_MIPI_DPHY_ROOT_CLK] = imx_clk_gate4("mipi_dphy_root_clk", "mipi_dphy_post_div", base + 0x4660, 0);
+	clks[IMX7D_ENET1_IPG_ROOT_CLK] = imx_clk_gate2_shared2("enet1_ipg_root_clk", "enet_axi_post_div", base + 0x4700, 0, &share_count_enet1);
+	clks[IMX7D_ENET1_TIME_ROOT_CLK] = imx_clk_gate2_shared2("enet1_time_root_clk", "enet1_time_post_div", base + 0x4700, 0, &share_count_enet1);
+	clks[IMX7D_ENET2_IPG_ROOT_CLK] = imx_clk_gate2_shared2("enet2_ipg_root_clk", "enet_axi_post_div", base + 0x4710, 0, &share_count_enet2);
+	clks[IMX7D_ENET2_TIME_ROOT_CLK] = imx_clk_gate2_shared2("enet2_time_root_clk", "enet2_time_post_div", base + 0x4710, 0, &share_count_enet2);
 	clks[IMX7D_SAI1_ROOT_CLK] = imx_clk_gate2_shared2("sai1_root_clk", "sai1_post_div", base + 0x48c0, 0, &share_count_sai1);
 	clks[IMX7D_SAI1_IPG_CLK]  = imx_clk_gate2_shared2("sai1_ipg_clk",  "ipg_root_clk",  base + 0x48c0, 0, &share_count_sai1);
 	clks[IMX7D_SAI2_ROOT_CLK] = imx_clk_gate2_shared2("sai2_root_clk", "sai2_post_div", base + 0x48d0, 0, &share_count_sai2);
@@ -812,11 +818,6 @@ static void __init imx7d_clocks_init(struct device_node *ccm_node)
 	clks[IMX7D_SAI3_ROOT_CLK] = imx_clk_gate2_shared2("sai3_root_clk", "sai3_post_div", base + 0x48e0, 0, &share_count_sai3);
 	clks[IMX7D_SAI3_IPG_CLK]  = imx_clk_gate2_shared2("sai3_ipg_clk",  "ipg_root_clk",  base + 0x48e0, 0, &share_count_sai3);
 	clks[IMX7D_SPDIF_ROOT_CLK] = imx_clk_gate4("spdif_root_clk", "spdif_post_div", base + 0x44d0, 0);
-	clks[IMX7D_ENET1_REF_ROOT_CLK] = imx_clk_gate4("enet1_ref_root_clk", "enet1_ref_post_div", base + 0x44e0, 0);
-	clks[IMX7D_ENET1_TIME_ROOT_CLK] = imx_clk_gate4("enet1_time_root_clk", "enet1_time_post_div", base + 0x44f0, 0);
-	clks[IMX7D_ENET2_REF_ROOT_CLK] = imx_clk_gate4("enet2_ref_root_clk", "enet2_ref_post_div", base + 0x4500, 0);
-	clks[IMX7D_ENET2_TIME_ROOT_CLK] = imx_clk_gate4("enet2_time_root_clk", "enet2_time_post_div", base + 0x4510, 0);
-	clks[IMX7D_ENET_PHY_REF_ROOT_CLK] = imx_clk_gate4("enet_phy_ref_root_clk", "enet_phy_ref_post_div", base + 0x4520, 0);
 	clks[IMX7D_EIM_ROOT_CLK] = imx_clk_gate4("eim_root_clk", "eim_post_div", base + 0x4160, 0);
 	clks[IMX7D_NAND_RAWNAND_CLK] = imx_clk_gate2_shared2("nand_rawnand_clk", "nand_root_clk", base + 0x4140, 0, &share_count_nand);
 	clks[IMX7D_NAND_USDHC_BUS_RAWNAND_CLK] = imx_clk_gate2_shared2("nand_usdhc_rawnand_clk", "nand_usdhc_root_clk", base + 0x4140, 0, &share_count_nand);
diff --git a/include/dt-bindings/clock/imx7d-clock.h b/include/dt-bindings/clock/imx7d-clock.h
index b2325d3e2..fef0647 100644
--- a/include/dt-bindings/clock/imx7d-clock.h
+++ b/include/dt-bindings/clock/imx7d-clock.h
@@ -455,5 +455,7 @@
 #define IMX7D_SNVS_CLK			442
 #define IMX7D_CAAM_CLK			443
 #define IMX7D_KPP_ROOT_CLK		444
-#define IMX7D_CLK_END			445
+#define IMX7D_ENET1_IPG_ROOT_CLK        445
+#define IMX7D_ENET2_IPG_ROOT_CLK        446
+#define IMX7D_CLK_END			447
 #endif /* __DT_BINDINGS_CLOCK_IMX7D_H */
-- 
2.7.4
