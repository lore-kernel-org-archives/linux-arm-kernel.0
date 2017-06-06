From: stefan@agner.ch (Stefan Agner)
Date: Mon,  5 Jun 2017 23:30:48 -0700
Subject: [PATCH v5 1/3] clk: imx7d: create clocks behind rawnand clock gate
In-Reply-To: <cover.b62c3a17bd60de48d8fb2ade6dde4f2bc60aaf3c.1496730576.git-series.stefan@agner.ch>
References: <cover.b62c3a17bd60de48d8fb2ade6dde4f2bc60aaf3c.1496730576.git-series.stefan@agner.ch>
Message-ID: <df22afd249abba1ee7c9d31be1c2c8dc1a68f69a.1496730576.git-series.stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The rawnand clock gate gates two clocks, NAND_USDHC_BUS_CLK_ROOT
and NAND_CLK_ROOT. However, the gate has been in the chain of the
latter only. This does not allow to use the NAND_USDHC_BUS_CLK_ROOT
only, e.g. as required by APBH-Bridge-DMA.

Add new clocks which represent the clock after the gate, and use a
shared clock gate to correctly model the hardware.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/clk/imx/clk-imx7d.c             | 6 ++++--
 include/dt-bindings/clock/imx7d-clock.h | 4 +++-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/imx/clk-imx7d.c b/drivers/clk/imx/clk-imx7d.c
index 93b0364..e364060 100644
--- a/drivers/clk/imx/clk-imx7d.c
+++ b/drivers/clk/imx/clk-imx7d.c
@@ -25,6 +25,7 @@
 static u32 share_count_sai1;
 static u32 share_count_sai2;
 static u32 share_count_sai3;
+static u32 share_count_nand;
 
 static struct clk_div_table test_div_table[] = {
 	{ .val = 3, .div = 1, },
@@ -748,7 +749,7 @@ static void __init imx7d_clocks_init(struct device_node *ccm_node)
 	clks[IMX7D_ENET2_TIME_ROOT_DIV] = imx_clk_divider2("enet2_time_post_div", "enet2_time_pre_div", base + 0xa880, 0, 6);
 	clks[IMX7D_ENET_PHY_REF_ROOT_DIV] = imx_clk_divider2("enet_phy_ref_post_div", "enet_phy_ref_pre_div", base + 0xa900, 0, 6);
 	clks[IMX7D_EIM_ROOT_DIV] = imx_clk_divider2("eim_post_div", "eim_pre_div", base + 0xa980, 0, 6);
-	clks[IMX7D_NAND_ROOT_DIV] = imx_clk_divider2("nand_post_div", "nand_pre_div", base + 0xaa00, 0, 6);
+	clks[IMX7D_NAND_ROOT_CLK] = imx_clk_divider2("nand_root_clk", "nand_pre_div", base + 0xaa00, 0, 6);
 	clks[IMX7D_QSPI_ROOT_DIV] = imx_clk_divider2("qspi_post_div", "qspi_pre_div", base + 0xaa80, 0, 6);
 	clks[IMX7D_USDHC1_ROOT_DIV] = imx_clk_divider2("usdhc1_post_div", "usdhc1_pre_div", base + 0xab00, 0, 6);
 	clks[IMX7D_USDHC2_ROOT_DIV] = imx_clk_divider2("usdhc2_post_div", "usdhc2_pre_div", base + 0xab80, 0, 6);
@@ -825,7 +826,8 @@ static void __init imx7d_clocks_init(struct device_node *ccm_node)
 	clks[IMX7D_ENET2_TIME_ROOT_CLK] = imx_clk_gate4("enet2_time_root_clk", "enet2_time_post_div", base + 0x4510, 0);
 	clks[IMX7D_ENET_PHY_REF_ROOT_CLK] = imx_clk_gate4("enet_phy_ref_root_clk", "enet_phy_ref_post_div", base + 0x4520, 0);
 	clks[IMX7D_EIM_ROOT_CLK] = imx_clk_gate4("eim_root_clk", "eim_post_div", base + 0x4160, 0);
-	clks[IMX7D_NAND_ROOT_CLK] = imx_clk_gate4("nand_root_clk", "nand_post_div", base + 0x4140, 0);
+	clks[IMX7D_NAND_RAWNAND_CLK] = imx_clk_gate2_shared2("nand_rawnand_clk", "nand_root_clk", base + 0x4140, 0, &share_count_nand);
+	clks[IMX7D_NAND_USDHC_BUS_RAWNAND_CLK] = imx_clk_gate2_shared2("nand_usdhc_rawnand_clk", "nand_usdhc_root_clk", base + 0x4140, 0, &share_count_nand);
 	clks[IMX7D_QSPI_ROOT_CLK] = imx_clk_gate4("qspi_root_clk", "qspi_post_div", base + 0x4150, 0);
 	clks[IMX7D_USDHC1_ROOT_CLK] = imx_clk_gate4("usdhc1_root_clk", "usdhc1_post_div", base + 0x46c0, 0);
 	clks[IMX7D_USDHC2_ROOT_CLK] = imx_clk_gate4("usdhc2_root_clk", "usdhc2_post_div", base + 0x46d0, 0);
diff --git a/include/dt-bindings/clock/imx7d-clock.h b/include/dt-bindings/clock/imx7d-clock.h
index a7a1a50..de62a83 100644
--- a/include/dt-bindings/clock/imx7d-clock.h
+++ b/include/dt-bindings/clock/imx7d-clock.h
@@ -450,5 +450,7 @@
 #define IMX7D_CLK_ARM			437
 #define IMX7D_CKIL			438
 #define IMX7D_OCOTP_CLK			439
-#define IMX7D_CLK_END			440
+#define IMX7D_NAND_RAWNAND_CLK		440
+#define IMX7D_NAND_USDHC_BUS_RAWNAND_CLK 441
+#define IMX7D_CLK_END			442
 #endif /* __DT_BINDINGS_CLOCK_IMX7D_H */
-- 
git-series 0.9.1
