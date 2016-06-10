From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Fri, 10 Jun 2016 13:56:32 +0900
Subject: [PATCH 3/3] clk: samsung: exynos5433: Add CLK_IGNORE_UNUSED flag to
 PCIE device
In-Reply-To: <1465534592-18860-1-git-send-email-cw00.choi@samsung.com>
References: <1465534592-18860-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1465534592-18860-4-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jaehoon Chung <jh80.chung@samsung.com>

This patch adds the CLK_IGNORE_UNUSED flag for PCI Express's clocks
which need the on state and the 'pcie' gate clock.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/clk/samsung/clk-exynos5433.c   | 11 ++++++-----
 include/dt-bindings/clock/exynos5433.h |  3 ++-
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5433.c b/drivers/clk/samsung/clk-exynos5433.c
index 852ac6a7607e..e3cc9359fb20 100644
--- a/drivers/clk/samsung/clk-exynos5433.c
+++ b/drivers/clk/samsung/clk-exynos5433.c
@@ -639,7 +639,7 @@ static struct samsung_gate_clock top_gate_clks[] __initdata = {
 
 	/* ENABLE_SCLK_TOP_FSYS */
 	GATE(CLK_SCLK_PCIE_100_FSYS, "sclk_pcie_100_fsys", "div_sclk_pcie_100",
-			ENABLE_SCLK_TOP_FSYS, 7, 0, 0),
+			ENABLE_SCLK_TOP_FSYS, 7, CLK_IGNORE_UNUSED, 0),
 	GATE(CLK_SCLK_MMC2_FSYS, "sclk_mmc2_fsys", "div_sclk_mmc2_b",
 			ENABLE_SCLK_TOP_FSYS, 6, CLK_SET_RATE_PARENT, 0),
 	GATE(CLK_SCLK_MMC1_FSYS, "sclk_mmc1_fsys", "div_sclk_mmc1_b",
@@ -2146,7 +2146,7 @@ static struct samsung_gate_clock fsys_gate_clks[] __initdata = {
 	GATE(CLK_ACLK_SMMU_PDMA1, "aclk_smmu_pdma1", "mout_aclk_fsys_200_user",
 			ENABLE_ACLK_FSYS1, 25, CLK_IGNORE_UNUSED, 0),
 	GATE(CLK_ACLK_BTS_PCIE, "aclk_bts_pcie", "mout_aclk_fsys_200_user",
-			ENABLE_ACLK_FSYS1, 24, 0, 0),
+			ENABLE_ACLK_FSYS1, 24, CLK_IGNORE_UNUSED, 0),
 	GATE(CLK_ACLK_AXIUS_PDMA1, "aclk_axius_pdma1",
 			"mout_aclk_fsys_200_user", ENABLE_ACLK_FSYS1,
 			22, CLK_IGNORE_UNUSED, 0),
@@ -2193,13 +2193,13 @@ static struct samsung_gate_clock fsys_gate_clks[] __initdata = {
 
 	/* ENABLE_PCLK_FSYS */
 	GATE(CLK_PCLK_PCIE_CTRL, "pclk_pcie_ctrl", "mout_aclk_fsys_200_user",
-			ENABLE_PCLK_FSYS, 17, 0, 0),
+			ENABLE_PCLK_FSYS, 17, CLK_IGNORE_UNUSED, 0),
 	GATE(CLK_PCLK_SMMU_PDMA1, "pclk_smmu_pdma1", "mout_aclk_fsys_200_user",
 			ENABLE_PCLK_FSYS, 16, CLK_IGNORE_UNUSED, 0),
 	GATE(CLK_PCLK_PCIE_PHY, "pclk_pcie_phy", "mout_aclk_fsys_200_user",
-			ENABLE_PCLK_FSYS, 14, 0, 0),
+			ENABLE_PCLK_FSYS, 14, CLK_IGNORE_UNUSED, 0),
 	GATE(CLK_PCLK_BTS_PCIE, "pclk_bts_pcie", "mout_aclk_fsys_200_user",
-			ENABLE_PCLK_FSYS, 13, 0, 0),
+			ENABLE_PCLK_FSYS, 13, CLK_IGNORE_UNUSED, 0),
 	GATE(CLK_PCLK_SMMU_PDMA0, "pclk_smmu_pdma0", "mout_aclk_fsys_200_user",
 			ENABLE_PCLK_FSYS, 8, CLK_IGNORE_UNUSED, 0),
 	GATE(CLK_PCLK_BTS_UFS, "pclk_bts_ufs", "mout_aclk_fsys_200_user",
@@ -2278,6 +2278,7 @@ static struct samsung_gate_clock fsys_gate_clks[] __initdata = {
 			ENABLE_SCLK_FSYS, 0, 0, 0),
 
 	/* ENABLE_IP_FSYS0 */
+	GATE(CLK_PCIE, "pcie", "sclk_pcie_100", ENABLE_IP_FSYS0, 17, 0, 0),
 	GATE(CLK_PDMA1, "pdma1", "aclk_pdma1", ENABLE_IP_FSYS0, 15, 0, 0),
 	GATE(CLK_PDMA0, "pdma0", "aclk_pdma0", ENABLE_IP_FSYS0, 0, 0, 0),
 };
diff --git a/include/dt-bindings/clock/exynos5433.h b/include/dt-bindings/clock/exynos5433.h
index 8e024fea26e7..4fa6bb2136e3 100644
--- a/include/dt-bindings/clock/exynos5433.h
+++ b/include/dt-bindings/clock/exynos5433.h
@@ -622,8 +622,9 @@
 #define CLK_SCLK_UFSUNIPRO		112
 #define CLK_SCLK_USBHOST30		113
 #define CLK_SCLK_USBDRD30		114
+#define CLK_PCIE			115
 
-#define FSYS_NR_CLK			115
+#define FSYS_NR_CLK			116
 
 /* CMU_G2D */
 #define CLK_MUX_ACLK_G2D_266_USER	1
-- 
1.9.1
