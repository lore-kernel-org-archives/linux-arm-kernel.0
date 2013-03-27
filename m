From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 27 Mar 2013 12:02:48 +0100
Subject: [PATCH 11/21] clk: samsung: exynos4: Add G3D clocks
In-Reply-To: <1364382178-25248-1-git-send-email-t.figa@samsung.com>
References: <1364382178-25248-1-git-send-email-t.figa@samsung.com>
Message-ID: <1364382178-25248-12-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds clocks needed for G3D block present on Exynos 4 SoCs.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 .../devicetree/bindings/clock/exynos4-clock.txt    |  4 ++++
 drivers/clk/samsung/clk-exynos4.c                  | 22 ++++++++++++++--------
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/exynos4-clock.txt b/Documentation/devicetree/bindings/clock/exynos4-clock.txt
index 657b889..1863032 100644
--- a/Documentation/devicetree/bindings/clock/exynos4-clock.txt
+++ b/Documentation/devicetree/bindings/clock/exynos4-clock.txt
@@ -97,6 +97,7 @@ Exynos4 SoC and this is specified where applicable.
   sclk_mipihsi        169     Exynos4412
   sclk_mfc            170
   sclk_pcm0           171
+  sclk_g3d            172
 
 	      [Peripheral Clock Gates]
 
@@ -218,6 +219,9 @@ Exynos4 SoC and this is specified where applicable.
 	mout_cam1	389
 	mout_csis0	390
 	mout_csis1	391
+	mout_g3d0	392
+	mout_g3d1	393
+	mout_g3d	394
 
 Example 1: An example of a clock controller node is listed below.
 
diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-exynos4.c
index 728ffaf..694b890 100644
--- a/drivers/clk/samsung/clk-exynos4.c
+++ b/drivers/clk/samsung/clk-exynos4.c
@@ -124,7 +124,7 @@ enum exynos4_clks {
 	sclk_sata, sclk_uart0, sclk_uart1, sclk_uart2, sclk_uart3, sclk_uart4,
 	sclk_audio1, sclk_audio2, sclk_spdif, sclk_spi0, sclk_spi1, sclk_spi2,
 	sclk_slimbus, sclk_fimd1, sclk_mipi1, sclk_pcm1, sclk_pcm2, sclk_i2s1,
-	sclk_i2s2, sclk_mipihsi, sclk_mfc, sclk_pcm0,
+	sclk_i2s2, sclk_mipihsi, sclk_mfc, sclk_pcm0, sclk_g3d,
 
 	/* gate clocks */
 	fimc0 = 256, fimc1, fimc2, fimc3, csis0, csis1, jpeg, smmu_fimc0,
@@ -142,7 +142,7 @@ enum exynos4_clks {
 
 	/* mux clocks */
 	mout_fimc0 = 384, mout_fimc1, mout_fimc2, mout_fimc3, mout_cam0,
-	mout_cam1, mout_csis0, mout_csis1,
+	mout_cam1, mout_csis0, mout_csis1, mout_g3d0, mout_g3d1, mout_g3d,
 
 	nr_clks,
 };
@@ -296,8 +296,10 @@ struct samsung_mux_clock exynos4_mux_clks[] __initdata = {
 	MUX(none, "mout_hdmi", mout_hdmi_p, SRC_TV, 0, 1),
 	MUX(none, "mout_mfc1", sclk_evpll_p, SRC_MFC, 4, 1),
 	MUX(none, "mout_mfc", mout_mfc_p, SRC_MFC, 8, 1),
-	MUX(none, "mout_g3d1", sclk_evpll_p, SRC_G3D, 4, 1),
-	MUX(none, "mout_g3d", mout_g3d_p, SRC_G3D, 8, 1),
+	MUX_F(mout_g3d1, "mout_g3d1", sclk_evpll_p, SRC_G3D, 4, 1,
+			CLK_SET_RATE_PARENT, 0),
+	MUX_F(mout_g3d, "mout_g3d", mout_g3d_p, SRC_G3D, 8, 1,
+			CLK_SET_RATE_PARENT, 0),
 	MUX(none, "mout_spdif", mout_spdif_p, SRC_PERIL1, 8, 2),
 	MUX_A(sclk_epll, "sclk_epll", mout_epll_p, SRC_TOP0, 4, 1, "sclk_epll"),
 };
@@ -329,7 +331,8 @@ struct samsung_mux_clock exynos4210_mux_clks[] __initdata = {
 	MUX(mout_csis0, "mout_csis0", group1_p4210, SRC_CAM, 24, 4),
 	MUX(mout_csis1, "mout_csis1", group1_p4210, SRC_CAM, 28, 4),
 	MUX(none, "mout_mfc0", sclk_ampll_p4210, SRC_MFC, 0, 1),
-	MUX(none, "mout_g3d0", sclk_ampll_p4210, SRC_G3D, 0, 1),
+	MUX_F(mout_g3d0, "mout_g3d0", sclk_ampll_p4210, SRC_G3D, 0, 1,
+			CLK_SET_RATE_PARENT, 0),
 	MUX(none, "mout_fimd0", group1_p4210, SRC_LCD0, 0, 4),
 	MUX(none, "mout_mipi0", group1_p4210, SRC_LCD0, 12, 4),
 	MUX(none, "mout_audio0", mout_audio0_p4210, SRC_MAUDIO, 0, 4),
@@ -380,7 +383,8 @@ struct samsung_mux_clock exynos4x12_mux_clks[] __initdata = {
 	MUX(mout_csis0, "mout_csis0", group1_p4x12, SRC_CAM, 24, 4),
 	MUX(mout_csis1, "mout_csis1", group1_p4x12, SRC_CAM, 28, 4),
 	MUX(none, "mout_mfc0", sclk_ampll_p4x12, SRC_MFC, 0, 1),
-	MUX(none, "mout_g3d0", sclk_ampll_p4x12, SRC_G3D, 0, 1),
+	MUX_F(mout_g3d0, "mout_g3d0", sclk_ampll_p4x12, SRC_G3D, 0, 1,
+			CLK_SET_RATE_PARENT, 0),
 	MUX(none, "mout_fimd0", group1_p4x12, SRC_LCD0, 0, 4),
 	MUX(none, "mout_mipi0", group1_p4x12, SRC_LCD0, 12, 4),
 	MUX(none, "mout_audio0", mout_audio0_p4x12, SRC_MAUDIO, 0, 4),
@@ -415,7 +419,8 @@ struct samsung_div_clock exynos4_div_clks[] __initdata = {
 	DIV(none, "div_csis0", "mout_csis0", DIV_CAM, 24, 4),
 	DIV(none, "div_csis1", "mout_csis1", DIV_CAM, 28, 4),
 	DIV(sclk_mfc, "sclk_mfc", "mout_mfc", DIV_MFC, 0, 4),
-	DIV(none, "div_g3d", "mout_g3d", DIV_G3D, 0, 4),
+	DIV_F(none, "div_g3d", "mout_g3d", DIV_G3D, 0, 4,
+			CLK_SET_RATE_PARENT, 0),
 	DIV(none, "div_fimd0", "mout_fimd0", DIV_LCD0, 0, 4),
 	DIV(none, "div_mipi0", "mout_mipi0", DIV_LCD0, 16, 4),
 	DIV(none, "div_audio0", "mout_audio0", DIV_MAUDIO, 0, 4),
@@ -501,7 +506,8 @@ struct samsung_gate_clock exynos4_gate_clks[] __initdata = {
 	GATE(smmu_fimd1, "smmu_fimd1", "aclk160", GATE_IP_LCD1, 4, 0, 0),
 	GATE(tsi, "tsi", "aclk133", GATE_IP_FSYS, 4, 0, 0),
 	GATE(sromc, "sromc", "aclk133", GATE_IP_FSYS, 11, 0, 0),
-	GATE(g3d, "g3d", "aclk200", GATE_IP_G3D, 0, 0, 0),
+	GATE(sclk_g3d, "sclk_g3d", "div_g3d", GATE_IP_G3D, 0,
+			CLK_SET_RATE_PARENT, 0),
 	GATE(usb_device, "usb_device", "aclk133", GATE_IP_FSYS, 13, 0, 0),
 	GATE(onenand, "onenand", "aclk133", GATE_IP_FSYS, 15, 0, 0),
 	GATE(nfcon, "nfcon", "aclk133", GATE_IP_FSYS, 16, 0, 0),
-- 
1.8.1.5
