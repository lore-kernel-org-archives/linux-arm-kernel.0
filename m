From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 27 Mar 2013 12:02:47 +0100
Subject: [PATCH 10/21] clk: samsung: exynos4: Add camera related clock
 definitions
In-Reply-To: <1364382178-25248-1-git-send-email-t.figa@samsung.com>
References: <1364382178-25248-1-git-send-email-t.figa@samsung.com>
Message-ID: <1364382178-25248-11-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sylwester Nawrocki <s.nawrocki@samsung.com>

This patch adds several gate and mux clocks related to camera and ISP
blocks.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 .../devicetree/bindings/clock/exynos4-clock.txt    | 20 +++++++++
 drivers/clk/samsung/clk-exynos4.c                  | 50 ++++++++++++++--------
 2 files changed, 53 insertions(+), 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/exynos4-clock.txt b/Documentation/devicetree/bindings/clock/exynos4-clock.txt
index 51c572a..657b889 100644
--- a/Documentation/devicetree/bindings/clock/exynos4-clock.txt
+++ b/Documentation/devicetree/bindings/clock/exynos4-clock.txt
@@ -198,6 +198,26 @@ Exynos4 SoC and this is specified where applicable.
   audss               348
   mipi_hsi            349     Exynos4210
   mdma2               350     Exynos4210
+  pixelasyncm0        351
+  pixelasyncm1        352
+  fimc_lite0          353     Exynos4x12
+  fimc_lite1          354     Exynos4x12
+  ppmuispx            355     Exynos4x12
+  ppmuispmx           356     Exynos4x12
+
+			[Mux Clocks]
+
+	Clock		ID	SoC (if specific)
+	-----------------------------------------------
+
+	mout_fimc0	384
+	mout_fimc1	385
+	mout_fimc2	386
+	mout_fimc3	387
+	mout_cam0	388
+	mout_cam1	389
+	mout_csis0	390
+	mout_csis1	391
 
 Example 1: An example of a clock controller node is listed below.
 
diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-exynos4.c
index 8c4cffb..728ffaf 100644
--- a/drivers/clk/samsung/clk-exynos4.c
+++ b/drivers/clk/samsung/clk-exynos4.c
@@ -87,6 +87,7 @@
 #define E4210_MPLL_CON0		0x14108
 #define SRC_CPU			0x14200
 #define DIV_CPU0		0x14500
+#define E4X12_GATE_ISP0		0x18800
 
 /* the exynos4 soc type */
 enum exynos4_soc {
@@ -136,7 +137,12 @@ enum exynos4_clks {
 	uart4, i2c0, i2c1, i2c2, i2c3, i2c4, i2c5, i2c6, i2c7, i2c_hdmi, tsadc,
 	spi0, spi1, spi2, i2s1, i2s2, pcm0, i2s0, pcm1, pcm2, pwm, slimbus,
 	spdif, ac97, modemif, chipid, sysreg, hdmi_cec, mct, wdt, rtc, keyif,
-	audss, mipi_hsi, mdma2,
+	audss, mipi_hsi, mdma2, pixelasyncm0, pixelasyncm1, fimc_lite0,
+	fimc_lite1, ppmuispx, ppmuispmx,
+
+	/* mux clocks */
+	mout_fimc0 = 384, mout_fimc1, mout_fimc2, mout_fimc3, mout_cam0,
+	mout_cam1, mout_csis0, mout_csis1,
 
 	nr_clks,
 };
@@ -314,14 +320,14 @@ struct samsung_mux_clock exynos4210_mux_clks[] __initdata = {
 	MUX_A(mout_core, "mout_core", mout_core_p4210, SRC_CPU, 16, 1, "mout_core"),
 	MUX_A(sclk_vpll, "sclk_vpll", sclk_vpll_p4210,
 			SRC_TOP0, 8, 1, "sclk_vpll"),
-	MUX(none, "mout_fimc0", group1_p4210, SRC_CAM, 0, 4),
-	MUX(none, "mout_fimc1", group1_p4210, SRC_CAM, 4, 4),
-	MUX(none, "mout_fimc2", group1_p4210, SRC_CAM, 8, 4),
-	MUX(none, "mout_fimc3", group1_p4210, SRC_CAM, 12, 4),
-	MUX(none, "mout_cam0", group1_p4210, SRC_CAM, 16, 4),
-	MUX(none, "mout_cam1", group1_p4210, SRC_CAM, 20, 4),
-	MUX(none, "mout_csis0", group1_p4210, SRC_CAM, 24, 4),
-	MUX(none, "mout_csis1", group1_p4210, SRC_CAM, 28, 4),
+	MUX(mout_fimc0, "mout_fimc0", group1_p4210, SRC_CAM, 0, 4),
+	MUX(mout_fimc1, "mout_fimc1", group1_p4210, SRC_CAM, 4, 4),
+	MUX(mout_fimc2, "mout_fimc2", group1_p4210, SRC_CAM, 8, 4),
+	MUX(mout_fimc3, "mout_fimc3", group1_p4210, SRC_CAM, 12, 4),
+	MUX(mout_cam0, "mout_cam0", group1_p4210, SRC_CAM, 16, 4),
+	MUX(mout_cam1, "mout_cam1", group1_p4210, SRC_CAM, 20, 4),
+	MUX(mout_csis0, "mout_csis0", group1_p4210, SRC_CAM, 24, 4),
+	MUX(mout_csis1, "mout_csis1", group1_p4210, SRC_CAM, 28, 4),
 	MUX(none, "mout_mfc0", sclk_ampll_p4210, SRC_MFC, 0, 1),
 	MUX(none, "mout_g3d0", sclk_ampll_p4210, SRC_G3D, 0, 1),
 	MUX(none, "mout_fimd0", group1_p4210, SRC_LCD0, 0, 4),
@@ -365,14 +371,14 @@ struct samsung_mux_clock exynos4x12_mux_clks[] __initdata = {
 	MUX_A(sclk_vpll, "sclk_vpll", mout_vpll_p,
 			SRC_TOP0, 8, 1, "sclk_vpll"),
 	MUX(mout_core, "mout_core", mout_core_p4x12, SRC_CPU, 16, 1),
-	MUX(none, "mout_fimc0", group1_p4x12, SRC_CAM, 0, 4),
-	MUX(none, "mout_fimc1", group1_p4x12, SRC_CAM, 4, 4),
-	MUX(none, "mout_fimc2", group1_p4x12, SRC_CAM, 8, 4),
-	MUX(none, "mout_fimc3", group1_p4x12, SRC_CAM, 12, 4),
-	MUX(none, "mout_cam0", group1_p4x12, SRC_CAM, 16, 4),
-	MUX(none, "mout_cam1", group1_p4x12, SRC_CAM, 20, 4),
-	MUX(none, "mout_csis0", group1_p4x12, SRC_CAM, 24, 4),
-	MUX(none, "mout_csis1", group1_p4x12, SRC_CAM, 28, 4),
+	MUX(mout_fimc0, "mout_fimc0", group1_p4x12, SRC_CAM, 0, 4),
+	MUX(mout_fimc1, "mout_fimc1", group1_p4x12, SRC_CAM, 4, 4),
+	MUX(mout_fimc2, "mout_fimc2", group1_p4x12, SRC_CAM, 8, 4),
+	MUX(mout_fimc3, "mout_fimc3", group1_p4x12, SRC_CAM, 12, 4),
+	MUX(mout_cam0, "mout_cam0", group1_p4x12, SRC_CAM, 16, 4),
+	MUX(mout_cam1, "mout_cam1", group1_p4x12, SRC_CAM, 20, 4),
+	MUX(mout_csis0, "mout_csis0", group1_p4x12, SRC_CAM, 24, 4),
+	MUX(mout_csis1, "mout_csis1", group1_p4x12, SRC_CAM, 28, 4),
 	MUX(none, "mout_mfc0", sclk_ampll_p4x12, SRC_MFC, 0, 1),
 	MUX(none, "mout_g3d0", sclk_ampll_p4x12, SRC_G3D, 0, 1),
 	MUX(none, "mout_fimd0", group1_p4x12, SRC_LCD0, 0, 4),
@@ -587,6 +593,8 @@ struct samsung_gate_clock exynos4_gate_clks[] __initdata = {
 			GATE_IP_CAM, 10, 0, 0, "sysmmu"),
 	GATE_DA(smmu_jpeg, "exynos-sysmmu.3", "smmu_jpeg", "aclk160",
 			GATE_IP_CAM, 11, 0, 0, "sysmmu"),
+	GATE(pixelasyncm0, "pxl_async0", "aclk160", GATE_IP_CAM, 17, 0, 0),
+	GATE(pixelasyncm1, "pxl_async1", "aclk160", GATE_IP_CAM, 18, 0, 0),
 	GATE_DA(smmu_tv, "exynos-sysmmu.2", "smmu_tv", "aclk160",
 			GATE_IP_TV, 4, 0, 0, "sysmmu"),
 	GATE_DA(mfc, "s5p-mfc", "mfc", "aclk100", GATE_IP_MFC, 0, 0, 0, "mfc"),
@@ -721,6 +729,14 @@ struct samsung_gate_clock exynos4x12_gate_clks[] __initdata = {
 			E4X12_GATE_IP_MAUDIO, 2, 0, 0, "pcm"),
 	GATE_DA(i2s0, "samsung-i2s.0", "i2s0", "aclk100",
 			E4X12_GATE_IP_MAUDIO, 3, 0, 0, "iis"),
+	GATE(fimc_lite0, "lite0", "aclk200", E4X12_GATE_ISP0, 3,
+			CLK_IGNORE_UNUSED, 0),
+	GATE(fimc_lite1, "lite1", "aclk200", E4X12_GATE_ISP0, 4,
+			CLK_IGNORE_UNUSED, 0),
+	GATE(ppmuispmx, "ppmuispmx", "aclk200", E4X12_GATE_ISP0, 20,
+			CLK_IGNORE_UNUSED, 0),
+	GATE(ppmuispx, "ppmuispx", "aclk200", E4X12_GATE_ISP0, 21,
+			CLK_IGNORE_UNUSED, 0),
 };
 
 #ifdef CONFIG_OF
-- 
1.8.1.5
