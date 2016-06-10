From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Fri, 10 Jun 2016 13:56:31 +0900
Subject: [PATCH 2/3] clk: samsung: exynos5433: Add CLK_IGNORE_UNUSED flag to
 clocks occurring hang at sleep
In-Reply-To: <1465534592-18860-1-git-send-email-cw00.choi@samsung.com>
References: <1465534592-18860-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1465534592-18860-3-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jonghwa Lee <jonghwa3.lee@samsung.com>

Some clocks are required being unmasked during suspend-to-ram. Otherwise,
PMU will stuck and power line never down.

Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/clk/samsung/clk-exynos5433.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5433.c b/drivers/clk/samsung/clk-exynos5433.c
index e1a9c24079a4..852ac6a7607e 100644
--- a/drivers/clk/samsung/clk-exynos5433.c
+++ b/drivers/clk/samsung/clk-exynos5433.c
@@ -668,11 +668,14 @@ static struct samsung_gate_clock top_gate_clks[] __initdata = {
 	GATE(CLK_SCLK_PCM1_PERIC, "sclk_pcm1_peric", "div_sclk_pcm1",
 			ENABLE_SCLK_TOP_PERIC, 7, CLK_SET_RATE_PARENT, 0),
 	GATE(CLK_SCLK_UART2_PERIC, "sclk_uart2_peric", "div_sclk_uart2",
-			ENABLE_SCLK_TOP_PERIC, 5, CLK_SET_RATE_PARENT, 0),
+			ENABLE_SCLK_TOP_PERIC, 5, CLK_SET_RATE_PARENT |
+			CLK_IGNORE_UNUSED, 0),
 	GATE(CLK_SCLK_UART1_PERIC, "sclk_uart1_peric", "div_sclk_uart1",
-			ENABLE_SCLK_TOP_PERIC, 4, CLK_SET_RATE_PARENT, 0),
+			ENABLE_SCLK_TOP_PERIC, 4, CLK_SET_RATE_PARENT |
+			CLK_IGNORE_UNUSED, 0),
 	GATE(CLK_SCLK_UART0_PERIC, "sclk_uart0_peric", "div_sclk_uart0",
-			ENABLE_SCLK_TOP_PERIC, 3, CLK_SET_RATE_PARENT, 0),
+			ENABLE_SCLK_TOP_PERIC, 3, CLK_SET_RATE_PARENT |
+			CLK_IGNORE_UNUSED, 0),
 	GATE(CLK_SCLK_SPI2_PERIC, "sclk_spi2_peric", "div_sclk_spi2_b",
 			ENABLE_SCLK_TOP_PERIC, 2, CLK_SET_RATE_PARENT, 0),
 	GATE(CLK_SCLK_SPI1_PERIC, "sclk_spi1_peric", "div_sclk_spi1_b",
@@ -833,7 +836,7 @@ static struct samsung_div_clock cpif_div_clks[] __initdata = {
 static struct samsung_gate_clock cpif_gate_clks[] __initdata = {
 	/* ENABLE_SCLK_CPIF */
 	GATE(CLK_SCLK_MPHY_PLL, "sclk_mphy_pll", "mout_mphy_pll",
-			ENABLE_SCLK_CPIF, 9, 0, 0),
+			ENABLE_SCLK_CPIF, 9, CLK_IGNORE_UNUSED, 0),
 	GATE(CLK_SCLK_UFS_MPHY, "sclk_ufs_mphy", "div_sclk_mphy",
 			ENABLE_SCLK_CPIF, 4, 0, 0),
 };
@@ -1440,11 +1443,13 @@ static struct samsung_gate_clock mif_gate_clks[] __initdata = {
 
 	/* ENABLE_PCLK_MIF_SECURE_DREX0_TZ */
 	GATE(CLK_PCLK_DREX0_TZ, "pclk_drex0_tz", "div_aclk_mif_133",
-			ENABLE_PCLK_MIF_SECURE_DREX0_TZ, 0, 0, 0),
+			ENABLE_PCLK_MIF_SECURE_DREX0_TZ, 0,
+			CLK_IGNORE_UNUSED, 0),
 
 	/* ENABLE_PCLK_MIF_SECURE_DREX1_TZ */
 	GATE(CLK_PCLK_DREX1_TZ, "pclk_drex1_tz", "div_aclk_mif_133",
-			ENABLE_PCLK_MIF_SECURE_DREX1_TZ, 0, 0, 0),
+			ENABLE_PCLK_MIF_SECURE_DREX1_TZ, 0,
+			CLK_IGNORE_UNUSED, 0),
 
 	/* ENABLE_PCLK_MIF_SECURE_MONOTONIC_CNT */
 	GATE(CLK_PCLK_MONOTONIC_CNT, "pclk_monotonic_cnt", "div_aclk_mif_133",
@@ -1674,11 +1679,14 @@ static struct samsung_gate_clock peric_gate_clks[] __initdata = {
 	GATE(CLK_SCLK_SPI0, "sclk_spi0", "sclk_spi0_peric", ENABLE_SCLK_PERIC,
 			3, CLK_SET_RATE_PARENT, 0),
 	GATE(CLK_SCLK_UART2, "sclk_uart2", "sclk_uart2_peric",
-			ENABLE_SCLK_PERIC, 2, CLK_SET_RATE_PARENT, 0),
+			ENABLE_SCLK_PERIC, 2,
+			CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, 0),
 	GATE(CLK_SCLK_UART1, "sclk_uart1", "sclk_uart1_peric",
-			ENABLE_SCLK_PERIC, 1, CLK_SET_RATE_PARENT, 0),
+			ENABLE_SCLK_PERIC, 1,
+			CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, 0),
 	GATE(CLK_SCLK_UART0, "sclk_uart0", "sclk_uart0_peric",
-			ENABLE_SCLK_PERIC, 0, CLK_SET_RATE_PARENT, 0),
+			ENABLE_SCLK_PERIC, 0,
+			CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, 0),
 };
 
 static struct samsung_cmu_info peric_cmu_info __initdata = {
@@ -2962,7 +2970,7 @@ static struct samsung_gate_clock aud_gate_clks[] __initdata = {
 
 	/* ENABLE_SCLK_AUD0 */
 	GATE(CLK_ATCLK_AUD, "atclk_aud", "div_atclk_aud", ENABLE_SCLK_AUD0,
-			2, 0, 0),
+			2, CLK_IGNORE_UNUSED, 0),
 	GATE(CLK_PCLK_DBG_AUD, "pclk_dbg_aud", "div_pclk_dbg_aud",
 			ENABLE_SCLK_AUD0, 1, 0, 0),
 	GATE(CLK_SCLK_AUD_CA5, "sclk_aud_ca5", "div_aud_ca5", ENABLE_SCLK_AUD0,
@@ -3356,9 +3364,11 @@ static struct samsung_gate_clock gscl_gate_clks[] __initdata = {
 	GATE(CLK_ACLK_GSCLNP_111, "aclk_gsclnp_111", "mout_aclk_gscl_111_user",
 			ENABLE_ACLK_GSCL, 6, CLK_IGNORE_UNUSED, 0),
 	GATE(CLK_ACLK_GSCLRTND_333, "aclk_gsclrtnd_333",
-			"mout_aclk_gscl_333_user", ENABLE_ACLK_GSCL, 5, 0, 0),
+			"mout_aclk_gscl_333_user", ENABLE_ACLK_GSCL, 5,
+			CLK_IGNORE_UNUSED, 0),
 	GATE(CLK_ACLK_GSCLBEND_333, "aclk_gsclbend_333",
-			"mout_aclk_gscl_333_user", ENABLE_ACLK_GSCL, 4, 0, 0),
+			"mout_aclk_gscl_333_user", ENABLE_ACLK_GSCL, 4,
+			CLK_IGNORE_UNUSED, 0),
 	GATE(CLK_ACLK_GSD, "aclk_gsd", "mout_aclk_gscl_333_user",
 			ENABLE_ACLK_GSCL, 3, 0, 0),
 	GATE(CLK_ACLK_GSCL2, "aclk_gscl2", "mout_aclk_gscl_333_user",
-- 
1.9.1
