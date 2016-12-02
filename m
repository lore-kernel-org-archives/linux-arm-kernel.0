From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Fri, 02 Dec 2016 16:18:03 +0900
Subject: [PATCH 1/5] clk: samsung: exynos5433: Set NoC (Network On Chip) clocks
 as critical
In-Reply-To: <1480663087-4590-1-git-send-email-cw00.choi@samsung.com>
References: <1480663087-4590-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1480663087-4590-2-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ACLK_BUS0/1/2 are used for NoC (Network on Chip). If NoC's clocks are
disabled, the system halt happen. Following clock must be always enabled.
- CLK_ACLK_BUS0_400 : NoC's bus clock for PERIC/PERIS/FSYS/MSCL
- CLK_ACLK_BUS1_400 : NoC's bus clock for MFC/HEVC/G3D
- CLK_ACLK_BUS2_400 : NoC's bus clock for GSCL/DISP/G2D/CAM0/CAM1/ISP

Also, this patch adds the CLK_SET_RATE_PARENT flag to the CLK_SCLK_JPEG_MSCL
because this clock should be used for bus frequency scaling. This clock need to
be changed on the fly with CLK_SET_RATE_PARENT flag.

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc:linux-clk at vger.kernel.org
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/clk/samsung/clk-exynos5433.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5433.c b/drivers/clk/samsung/clk-exynos5433.c
index f096bd7df40c..0db5204c307c 100644
--- a/drivers/clk/samsung/clk-exynos5433.c
+++ b/drivers/clk/samsung/clk-exynos5433.c
@@ -549,10 +549,10 @@
 			29, CLK_IGNORE_UNUSED, 0),
 	GATE(CLK_ACLK_BUS0_400, "aclk_bus0_400", "div_aclk_bus0_400",
 			ENABLE_ACLK_TOP, 26,
-			CLK_IGNORE_UNUSED | CLK_SET_RATE_PARENT, 0),
+			CLK_IS_CRITICAL | CLK_SET_RATE_PARENT, 0),
 	GATE(CLK_ACLK_BUS1_400, "aclk_bus1_400", "div_aclk_bus1_400",
 			ENABLE_ACLK_TOP, 25,
-			CLK_IGNORE_UNUSED | CLK_SET_RATE_PARENT, 0),
+			CLK_IS_CRITICAL | CLK_SET_RATE_PARENT, 0),
 	GATE(CLK_ACLK_IMEM_200, "aclk_imem_200", "div_aclk_imem_266",
 			ENABLE_ACLK_TOP, 24,
 			CLK_IS_CRITICAL | CLK_SET_RATE_PARENT, 0),
@@ -616,7 +616,7 @@
 
 	/* ENABLE_SCLK_TOP_MSCL */
 	GATE(CLK_SCLK_JPEG_MSCL, "sclk_jpeg_mscl", "div_sclk_jpeg",
-			ENABLE_SCLK_TOP_MSCL, 0, 0, 0),
+			ENABLE_SCLK_TOP_MSCL, 0, CLK_SET_RATE_PARENT, 0),
 
 	/* ENABLE_SCLK_TOP_CAM1 */
 	GATE(CLK_SCLK_ISP_SENSOR2, "sclk_isp_sensor2", "div_sclk_isp_sensor2_b",
@@ -1382,7 +1382,7 @@ static void __init exynos5433_cmu_cpif_init(struct device_node *np)
 	/* ENABLE_ACLK_MIF3 */
 	GATE(CLK_ACLK_BUS2_400, "aclk_bus2_400", "div_aclk_bus2_400",
 			ENABLE_ACLK_MIF3, 4,
-			CLK_IGNORE_UNUSED | CLK_SET_RATE_PARENT, 0),
+			CLK_IS_CRITICAL | CLK_SET_RATE_PARENT, 0),
 	GATE(CLK_ACLK_DISP_333, "aclk_disp_333", "div_aclk_disp_333",
 			ENABLE_ACLK_MIF3, 1,
 			CLK_IS_CRITICAL | CLK_SET_RATE_PARENT, 0),
-- 
1.9.1
