From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 27 Sep 2017 11:59:40 -0700
Subject: [PATCH] clk: hi3798cv200: correct parent mux clock for 'clk_sdio0_ciu'
Message-ID: <1506538780-15513-1-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo <shawn.guo@linaro.org>

Other than 'mmc_mux', 'clk_sdio0_ciu' uses a different parent mux clock.
Let's add this mux clock as 'sdio0_mux', and correct the parent of
'clk_sdio0_ciu' to be it.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/clk/hisilicon/crg-hi3798cv200.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/hisilicon/crg-hi3798cv200.c b/drivers/clk/hisilicon/crg-hi3798cv200.c
index ed8bb5f7507f..8478948e858e 100644
--- a/drivers/clk/hisilicon/crg-hi3798cv200.c
+++ b/drivers/clk/hisilicon/crg-hi3798cv200.c
@@ -47,6 +47,8 @@
 #define HI3798CV200_FIXED_12M	81
 #define HI3798CV200_FIXED_48M	82
 #define HI3798CV200_FIXED_60M	83
+#define HI3798CV200_FIXED_166P5M	84
+#define HI3798CV200_SDIO0_MUX	85
 
 #define HI3798CV200_CRG_NR_CLKS		128
 
@@ -63,6 +65,7 @@
 	{ HI3798CV200_FIXED_75M, "75m", NULL, 0, 75000000, },
 	{ HI3798CV200_FIXED_100M, "100m", NULL, 0, 100000000, },
 	{ HI3798CV200_FIXED_150M, "150m", NULL, 0, 150000000, },
+	{ HI3798CV200_FIXED_166P5M, "166p5m", NULL, 0, 165000000, },
 	{ HI3798CV200_FIXED_200M, "200m", NULL, 0, 200000000, },
 	{ HI3798CV200_FIXED_250M, "250m", NULL, 0, 250000000, },
 };
@@ -75,12 +78,19 @@
 		"100m", "25m"};
 static u32 comphy1_mux_table[] = {2, 3};
 
+static const char *const sdio_mux_p[] = {
+		"100m", "50m", "150m", "166p5m" };
+static u32 sdio_mux_table[] = {0, 1, 2, 3};
+
 static struct hisi_mux_clock hi3798cv200_mux_clks[] = {
 	{ HI3798CV200_MMC_MUX, "mmc_mux", mmc_mux_p, ARRAY_SIZE(mmc_mux_p),
 		CLK_SET_RATE_PARENT, 0xa0, 8, 3, 0, mmc_mux_table, },
 	{ HI3798CV200_COMBPHY1_MUX, "combphy1_mux",
 		comphy1_mux_p, ARRAY_SIZE(comphy1_mux_p),
 		CLK_SET_RATE_PARENT, 0x188, 10, 2, 0, comphy1_mux_table, },
+	{ HI3798CV200_SDIO0_MUX, "sdio0_mux", sdio_mux_p,
+		ARRAY_SIZE(sdio_mux_p), CLK_SET_RATE_PARENT,
+		0x9c, 8, 2, 0, sdio_mux_table, },
 };
 
 static const struct hisi_gate_clock hi3798cv200_gate_clks[] = {
@@ -104,7 +114,7 @@
 	/* SDIO */
 	{ HISTB_SDIO0_BIU_CLK, "clk_sdio0_biu", "200m",
 			CLK_SET_RATE_PARENT, 0x9c, 0, 0, },
-	{ HISTB_SDIO0_CIU_CLK, "clk_sdio0_ciu", "mmc_mux",
+	{ HISTB_SDIO0_CIU_CLK, "clk_sdio0_ciu", "sdio0_mux",
 		CLK_SET_RATE_PARENT, 0x9c, 1, 0, },
 	/* EMMC */
 	{ HISTB_MMC_BIU_CLK, "clk_mmc_biu", "200m",
-- 
1.9.1
