From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Thu, 12 Jun 2014 10:39:29 +0800
Subject: [PATCH v2 2/2] clk: hix5hd2: add sd clk
In-Reply-To: <1402540769-6156-1-git-send-email-zhangfei.gao@linaro.org>
References: <1402540769-6156-1-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <1402540769-6156-3-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jiancheng Xue <xuejiancheng@huawei.com>

Signed-off-by: Jiancheng Xue <xuejiancheng@huawei.com>
---
 drivers/clk/hisilicon/clk-hix5hd2.c       |   21 +++++++++++++++------
 include/dt-bindings/clock/hix5hd2-clock.h |    4 ++++
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/hisilicon/clk-hix5hd2.c b/drivers/clk/hisilicon/clk-hix5hd2.c
index 2114ee3..5638818 100644
--- a/drivers/clk/hisilicon/clk-hix5hd2.c
+++ b/drivers/clk/hisilicon/clk-hix5hd2.c
@@ -50,9 +50,9 @@ static const char *sfc_mux_p[] __initconst = {
 		"24m", "150m", "200m", "100m", "75m", };
 static u32 sfc_mux_table[] = {0, 4, 5, 6, 7};
 
-static const char *sdio1_mux_p[] __initconst = {
+static const char *sdio_mux_p[] __initconst = {
 		"75m", "100m", "50m", "15m", };
-static u32 sdio1_mux_table[] = {0, 1, 2, 3};
+static u32 sdio_mux_table[] = {0, 1, 2, 3};
 
 static const char *fephy_mux_p[] __initconst = { "25m", "125m"};
 static u32 fephy_mux_table[] = {0, 1};
@@ -61,20 +61,29 @@ static u32 fephy_mux_table[] = {0, 1};
 static struct hisi_mux_clock hix5hd2_mux_clks[] __initdata = {
 	{ HIX5HD2_SFC_MUX, "sfc_mux", sfc_mux_p, ARRAY_SIZE(sfc_mux_p),
 		CLK_SET_RATE_PARENT, 0x5c, 8, 3, 0, sfc_mux_table, },
-	{ HIX5HD2_MMC_MUX, "mmc_mux", sdio1_mux_p, ARRAY_SIZE(sdio1_mux_p),
-		CLK_SET_RATE_PARENT, 0xa0, 8, 2, 0, sdio1_mux_table, },
+	{ HIX5HD2_MMC_MUX, "mmc_mux", sdio_mux_p, ARRAY_SIZE(sdio_mux_p),
+		CLK_SET_RATE_PARENT, 0xa0, 8, 2, 0, sdio_mux_table, },
+	{ HIX5HD2_SD_MUX, "sd_mux", sdio_mux_p, ARRAY_SIZE(sdio_mux_p),
+		CLK_SET_RATE_PARENT, 0x9c, 8, 2, 0, sdio_mux_table, },
 	{ HIX5HD2_FEPHY_MUX, "fephy_mux",
 		fephy_mux_p, ARRAY_SIZE(fephy_mux_p),
 		CLK_SET_RATE_PARENT, 0x120, 8, 2, 0, fephy_mux_table, },
 };
 
 static struct hisi_gate_clock hix5hd2_gate_clks[] __initdata = {
-	/*sfc*/
+	/* sfc */
 	{ HIX5HD2_SFC_CLK, "clk_sfc", "sfc_mux",
 		CLK_SET_RATE_PARENT, 0x5c, 0, 0, },
 	{ HIX5HD2_SFC_RST, "rst_sfc", "clk_sfc",
 		CLK_SET_RATE_PARENT, 0x5c, 4, CLK_GATE_SET_TO_DISABLE, },
-	/*sdio1*/
+	/* sdio0 */
+	{ HIX5HD2_SD_BIU_CLK, "clk_sd_biu", "200m",
+		CLK_SET_RATE_PARENT, 0x9c, 0, 0, },
+	{ HIX5HD2_SD_CIU_CLK, "clk_sd_ciu", "sd_mux",
+		CLK_SET_RATE_PARENT, 0x9c, 1, 0, },
+	{ HIX5HD2_SD_CIU_RST, "rst_sd_ciu", "clk_sd_ciu",
+		CLK_SET_RATE_PARENT, 0x9c, 4, CLK_GATE_SET_TO_DISABLE, },
+	/* sdio1 */
 	{ HIX5HD2_MMC_BIU_CLK, "clk_mmc_biu", "200m",
 		CLK_SET_RATE_PARENT, 0xa0, 0, 0, },
 	{ HIX5HD2_MMC_CIU_CLK, "clk_mmc_ciu", "mmc_mux",
diff --git a/include/dt-bindings/clock/hix5hd2-clock.h b/include/dt-bindings/clock/hix5hd2-clock.h
index e328669..5bd4135 100644
--- a/include/dt-bindings/clock/hix5hd2-clock.h
+++ b/include/dt-bindings/clock/hix5hd2-clock.h
@@ -46,6 +46,7 @@
 #define HIX5HD2_SFC_MUX			64
 #define HIX5HD2_MMC_MUX			65
 #define HIX5HD2_FEPHY_MUX		66
+#define HIX5HD2_SD_MUX			67
 
 /* gate clocks */
 #define HIX5HD2_SFC_RST			128
@@ -56,6 +57,9 @@
 #define HIX5HD2_FWD_BUS_CLK		133
 #define HIX5HD2_FWD_SYS_CLK		134
 #define HIX5HD2_MAC0_PHY_CLK		135
+#define HIX5HD2_SD_CIU_CLK		136
+#define HIX5HD2_SD_BIU_CLK		137
+#define HIX5HD2_SD_CIU_RST		138
 
 /* complex */
 #define HIX5HD2_MAC0_CLK		192
-- 
1.7.9.5
