From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 27 Mar 2013 12:02:39 +0100
Subject: [PATCH 02/21] clk: samsung: exynos4: Use mout_mpll_user_* on
 Exynos4x12
In-Reply-To: <1364382178-25248-1-git-send-email-t.figa@samsung.com>
References: <1364382178-25248-1-git-send-email-t.figa@samsung.com>
Message-ID: <1364382178-25248-3-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Many clock muxes of Exynos 4x12 uses mout_mpll_user_* clocks instead of
sclk_mpll as one of their parents.

This patch moves such clocks from common array into SoC-specific arrays
and adjusts their parent lists respectively.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 .../devicetree/bindings/clock/exynos4-clock.txt    |   2 +
 drivers/clk/samsung/clk-exynos4.c                  | 172 +++++++++++++--------
 2 files changed, 113 insertions(+), 61 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/exynos4-clock.txt b/Documentation/devicetree/bindings/clock/exynos4-clock.txt
index 8b58232..d029605 100644
--- a/Documentation/devicetree/bindings/clock/exynos4-clock.txt
+++ b/Documentation/devicetree/bindings/clock/exynos4-clock.txt
@@ -42,6 +42,8 @@ Exynos4 SoC and this is specified where applicable.
   aclk100             14
   aclk160             15
   aclk133             16
+  mout_mpll_user_t    17      Exynos4x12
+  mout_mpll_user_c    18      Exynos4x12
 
 
             [Clock Gate for Special Clocks]
diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-exynos4.c
index 44a99b5..8edd64c 100644
--- a/drivers/clk/samsung/clk-exynos4.c
+++ b/drivers/clk/samsung/clk-exynos4.c
@@ -112,7 +112,7 @@ enum exynos4_clks {
 	/* core clocks */
 	xxti, xusbxti, fin_pll, fout_apll, fout_mpll, fout_epll, fout_vpll,
 	sclk_apll, sclk_mpll, sclk_epll, sclk_vpll, arm_clk, aclk200, aclk100,
-	aclk160, aclk133,
+	aclk160, aclk133, mout_mpll_user_t, mout_mpll_user_c, /* 18 */
 
 	/* gate for special clocks (sclk) */
 	sclk_fimc0 = 128, sclk_fimc1, sclk_fimc2, sclk_fimc3, sclk_cam0,
@@ -218,35 +218,53 @@ PNAME(mout_apll_p)	= { "fin_pll", "fout_apll", };
 PNAME(mout_mpll_p)	= { "fin_pll", "fout_mpll", };
 PNAME(mout_epll_p)	= { "fin_pll", "fout_epll", };
 PNAME(mout_vpllsrc_p)	= { "fin_pll", "sclk_hdmi24m", };
-PNAME(sclk_vpll_p4210)	= { "mout_vpllsrc", "fout_vpll", };
 PNAME(mout_vpll_p)	= { "fin_pll", "fout_vpll", };
-PNAME(mout_core_p)	= { "mout_apll", "sclk_mpll", };
-PNAME(sclk_ampll_p)	= { "sclk_mpll", "sclk_apll", };
-PNAME(mout_mpll_user_p)	= { "fin_pll", "sclk_mpll", };
-PNAME(aclk_p4412)	= { "mout_mpll_user", "sclk_apll", };
 PNAME(sclk_evpll_p)	= { "sclk_epll", "sclk_vpll", };
 PNAME(mout_mfc_p)	= { "mout_mfc0", "mout_mfc1", };
 PNAME(mout_g3d_p)	= { "mout_g3d0", "mout_g3d1", };
 PNAME(mout_g2d_p)	= { "mout_g2d0", "mout_g2d1", };
-PNAME(mout_mixer_p4210)	= { "sclk_dac", "sclk_hdmi", };
-PNAME(mout_dac_p4210)	= { "sclk_vpll", "sclk_hdmiphy", };
 PNAME(mout_hdmi_p)	= { "sclk_pixel", "sclk_hdmiphy", };
 PNAME(mout_jpeg_p)	= { "mout_jpeg0", "mout_jpeg1", };
-PNAME(group1_p)		= { "xxti", "xusbxti", "sclk_hdmi24m", "sclk_usbphy0",
-				"none",	"sclk_hdmiphy", "sclk_mpll",
-				"sclk_epll", "sclk_vpll", };
-PNAME(mout_audio0_p)	= { "cdclk0", "none", "sclk_hdmi24m", "sclk_usbphy0",
-				"xxti", "xusbxti", "sclk_mpll", "sclk_epll",
-				"sclk_vpll" };
-PNAME(mout_audio1_p)	= { "cdclk1", "none", "sclk_hdmi24m", "sclk_usbphy0",
-				"xxti", "xusbxti", "sclk_mpll", "sclk_epll",
-				"sclk_vpll", };
-PNAME(mout_audio2_p)	= { "cdclk2", "none", "sclk_hdmi24m", "sclk_usbphy0",
-				"xxti", "xusbxti", "sclk_mpll", "sclk_epll",
-				"sclk_vpll", };
 PNAME(mout_spdif_p)	= { "sclk_audio0", "sclk_audio1", "sclk_audio2",
 				"spdif_extclk", };
 
+/* Exynos 4210-specific parent groups */
+PNAME(sclk_vpll_p4210)	= { "mout_vpllsrc", "fout_vpll", };
+PNAME(mout_core_p4210)	= { "mout_apll", "sclk_mpll", };
+PNAME(sclk_ampll_p4210)	= { "sclk_mpll", "sclk_apll", };
+PNAME(group1_p4210)	= { "xxti", "xusbxti", "sclk_hdmi24m",
+				"sclk_usbphy0", "none",	"sclk_hdmiphy",
+				"sclk_mpll", "sclk_epll", "sclk_vpll", };
+PNAME(mout_audio0_p4210) = { "cdclk0", "none", "sclk_hdmi24m",
+				"sclk_usbphy0", "xxti", "xusbxti", "sclk_mpll",
+				"sclk_epll", "sclk_vpll" };
+PNAME(mout_audio1_p4210) = { "cdclk1", "none", "sclk_hdmi24m",
+				"sclk_usbphy0", "xxti", "xusbxti", "sclk_mpll",
+				"sclk_epll", "sclk_vpll", };
+PNAME(mout_audio2_p4210) = { "cdclk2", "none", "sclk_hdmi24m",
+				"sclk_usbphy0", "xxti", "xusbxti", "sclk_mpll",
+				"sclk_epll", "sclk_vpll", };
+PNAME(mout_mixer_p4210)	= { "sclk_dac", "sclk_hdmi", };
+PNAME(mout_dac_p4210)	= { "sclk_vpll", "sclk_hdmiphy", };
+
+/* Exynos 4x12-specific parent groups */
+PNAME(mout_mpll_user_p4x12) = { "fin_pll", "sclk_mpll", };
+PNAME(mout_core_p4x12)	= { "mout_apll", "mout_mpll_user_c", };
+PNAME(sclk_ampll_p4x12)	= { "mout_mpll_user_t", "sclk_apll", };
+PNAME(group1_p4x12)	= { "xxti", "xusbxti", "sclk_hdmi24m", "sclk_usbphy0",
+				"none",	"sclk_hdmiphy", "mout_mpll_user_t",
+				"sclk_epll", "sclk_vpll", };
+PNAME(mout_audio0_p4x12) = { "cdclk0", "none", "sclk_hdmi24m",
+				"sclk_usbphy0", "xxti", "xusbxti",
+				"mout_mpll_user_t", "sclk_epll", "sclk_vpll" };
+PNAME(mout_audio1_p4x12) = { "cdclk1", "none", "sclk_hdmi24m",
+				"sclk_usbphy0", "xxti", "xusbxti",
+				"mout_mpll_user_t", "sclk_epll", "sclk_vpll", };
+PNAME(mout_audio2_p4x12) = { "cdclk2", "none", "sclk_hdmi24m",
+				"sclk_usbphy0", "xxti", "xusbxti",
+				"mout_mpll_user_t", "sclk_epll", "sclk_vpll", };
+PNAME(aclk_p4412)	= { "mout_mpll_user_t", "sclk_apll", };
+
 /* fixed rate clocks generated outside the soc */
 struct samsung_fixed_rate_clock exynos4_fixed_rate_ext_clks[] __initdata = {
 	FRATE(xxti, "xxti", NULL, CLK_IS_ROOT, 0),
@@ -267,80 +285,112 @@ struct samsung_fixed_rate_clock exynos4210_fixed_rate_clks[] __initdata = {
 /* list of mux clocks supported in all exynos4 soc's */
 struct samsung_mux_clock exynos4_mux_clks[] __initdata = {
 	MUX(none, "mout_apll", mout_apll_p, SRC_CPU, 0, 1),
-	MUX(none, "mout_core", mout_core_p, SRC_CPU, 16, 1),
-	MUX(none, "mout_fimc0", group1_p, SRC_CAM, 0, 4),
-	MUX(none, "mout_fimc1", group1_p, SRC_CAM, 4, 4),
-	MUX(none, "mout_fimc2", group1_p, SRC_CAM, 8, 4),
-	MUX(none, "mout_fimc3", group1_p, SRC_CAM, 12, 4),
-	MUX(none, "mout_cam0", group1_p, SRC_CAM, 16, 4),
-	MUX(none, "mout_cam1", group1_p, SRC_CAM, 20, 4),
-	MUX(none, "mout_csis0", group1_p, SRC_CAM, 24, 4),
-	MUX(none, "mout_csis1", group1_p, SRC_CAM, 28, 4),
 	MUX(none, "mout_hdmi", mout_hdmi_p, SRC_TV, 0, 1),
-	MUX(none, "mout_mfc0", sclk_ampll_p, SRC_MFC, 0, 1),
 	MUX(none, "mout_mfc1", sclk_evpll_p, SRC_MFC, 4, 1),
 	MUX(none, "mout_mfc", mout_mfc_p, SRC_MFC, 8, 1),
-	MUX(none, "mout_g3d0", sclk_ampll_p, SRC_G3D, 0, 1),
 	MUX(none, "mout_g3d1", sclk_evpll_p, SRC_G3D, 4, 1),
 	MUX(none, "mout_g3d", mout_g3d_p, SRC_G3D, 8, 1),
-	MUX(none, "mout_fimd0", group1_p, SRC_LCD0, 0, 4),
-	MUX(none, "mout_mipi0", group1_p, SRC_LCD0, 12, 4),
-	MUX(none, "mout_audio0", mout_audio0_p, SRC_MAUDIO, 0, 4),
-	MUX(none, "mout_mmc0", group1_p, SRC_FSYS, 0, 4),
-	MUX(none, "mout_mmc1", group1_p, SRC_FSYS, 4, 4),
-	MUX(none, "mout_mmc2", group1_p, SRC_FSYS, 8, 4),
-	MUX(none, "mout_mmc3", group1_p, SRC_FSYS, 12, 4),
-	MUX(none, "mout_mmc4", group1_p, SRC_FSYS, 16, 4),
-	MUX(none, "mout_uart0", group1_p, SRC_PERIL0, 0, 4),
-	MUX(none, "mout_uart1", group1_p, SRC_PERIL0, 4, 4),
-	MUX(none, "mout_uart2", group1_p, SRC_PERIL0, 8, 4),
-	MUX(none, "mout_uart3", group1_p, SRC_PERIL0, 12, 4),
-	MUX(none, "mout_uart4", group1_p, SRC_PERIL0, 16, 4),
-	MUX(none, "mout_audio1", mout_audio1_p, SRC_PERIL1, 0, 4),
-	MUX(none, "mout_audio2", mout_audio2_p, SRC_PERIL1, 4, 4),
 	MUX(none, "mout_spdif", mout_spdif_p, SRC_PERIL1, 8, 2),
-	MUX(none, "mout_spi0", group1_p, SRC_PERIL1, 16, 4),
-	MUX(none, "mout_spi1", group1_p, SRC_PERIL1, 20, 4),
-	MUX(none, "mout_spi2", group1_p, SRC_PERIL1, 24, 4),
 	MUX_A(sclk_epll, "sclk_epll", mout_epll_p, SRC_TOP0, 4, 1, "sclk_epll"),
 };
 
 /* list of mux clocks supported in exynos4210 soc */
 struct samsung_mux_clock exynos4210_mux_clks[] __initdata = {
-	MUX(none, "mout_aclk200", sclk_ampll_p, SRC_TOP0, 12, 1),
-	MUX(none, "mout_aclk100", sclk_ampll_p, SRC_TOP0, 16, 1),
-	MUX(none, "mout_aclk160", sclk_ampll_p, SRC_TOP0, 20, 1),
-	MUX(none, "mout_aclk133", sclk_ampll_p, SRC_TOP0, 24, 1),
+	MUX(none, "mout_aclk200", sclk_ampll_p4210, SRC_TOP0, 12, 1),
+	MUX(none, "mout_aclk100", sclk_ampll_p4210, SRC_TOP0, 16, 1),
+	MUX(none, "mout_aclk160", sclk_ampll_p4210, SRC_TOP0, 20, 1),
+	MUX(none, "mout_aclk133", sclk_ampll_p4210, SRC_TOP0, 24, 1),
 	MUX(none, "mout_vpllsrc", mout_vpllsrc_p, SRC_TOP1, 0, 1),
 	MUX(none, "mout_mixer", mout_mixer_p4210, SRC_TV, 4, 1),
 	MUX(none, "mout_dac", mout_dac_p4210, SRC_TV, 8, 1),
-	MUX(none, "mout_g2d0", sclk_ampll_p, E4210_SRC_IMAGE, 0, 1),
+	MUX(none, "mout_g2d0", sclk_ampll_p4210, E4210_SRC_IMAGE, 0, 1),
 	MUX(none, "mout_g2d1", sclk_evpll_p, E4210_SRC_IMAGE, 4, 1),
 	MUX(none, "mout_g2d", mout_g2d_p, E4210_SRC_IMAGE, 8, 1),
-	MUX(none, "mout_fimd1", group1_p, SRC_LCD1, 0, 4),
-	MUX(none, "mout_mipi1", group1_p, SRC_LCD1, 12, 4),
+	MUX(none, "mout_fimd1", group1_p4210, SRC_LCD1, 0, 4),
+	MUX(none, "mout_mipi1", group1_p4210, SRC_LCD1, 12, 4),
 	MUX_A(sclk_mpll, "sclk_mpll", mout_mpll_p, SRC_CPU, 8, 1, "sclk_mpll"),
+	MUX(none, "mout_core", mout_core_p4210, SRC_CPU, 16, 1),
 	MUX_A(sclk_vpll, "sclk_vpll", sclk_vpll_p4210,
 			SRC_TOP0, 8, 1, "sclk_vpll"),
+	MUX(none, "mout_fimc0", group1_p4210, SRC_CAM, 0, 4),
+	MUX(none, "mout_fimc1", group1_p4210, SRC_CAM, 4, 4),
+	MUX(none, "mout_fimc2", group1_p4210, SRC_CAM, 8, 4),
+	MUX(none, "mout_fimc3", group1_p4210, SRC_CAM, 12, 4),
+	MUX(none, "mout_cam0", group1_p4210, SRC_CAM, 16, 4),
+	MUX(none, "mout_cam1", group1_p4210, SRC_CAM, 20, 4),
+	MUX(none, "mout_csis0", group1_p4210, SRC_CAM, 24, 4),
+	MUX(none, "mout_csis1", group1_p4210, SRC_CAM, 28, 4),
+	MUX(none, "mout_mfc0", sclk_ampll_p4210, SRC_MFC, 0, 1),
+	MUX(none, "mout_g3d0", sclk_ampll_p4210, SRC_G3D, 0, 1),
+	MUX(none, "mout_fimd0", group1_p4210, SRC_LCD0, 0, 4),
+	MUX(none, "mout_mipi0", group1_p4210, SRC_LCD0, 12, 4),
+	MUX(none, "mout_audio0", mout_audio0_p4210, SRC_MAUDIO, 0, 4),
+	MUX(none, "mout_mmc0", group1_p4210, SRC_FSYS, 0, 4),
+	MUX(none, "mout_mmc1", group1_p4210, SRC_FSYS, 4, 4),
+	MUX(none, "mout_mmc2", group1_p4210, SRC_FSYS, 8, 4),
+	MUX(none, "mout_mmc3", group1_p4210, SRC_FSYS, 12, 4),
+	MUX(none, "mout_mmc4", group1_p4210, SRC_FSYS, 16, 4),
+	MUX(none, "mout_uart0", group1_p4210, SRC_PERIL0, 0, 4),
+	MUX(none, "mout_uart1", group1_p4210, SRC_PERIL0, 4, 4),
+	MUX(none, "mout_uart2", group1_p4210, SRC_PERIL0, 8, 4),
+	MUX(none, "mout_uart3", group1_p4210, SRC_PERIL0, 12, 4),
+	MUX(none, "mout_uart4", group1_p4210, SRC_PERIL0, 16, 4),
+	MUX(none, "mout_audio1", mout_audio1_p4210, SRC_PERIL1, 0, 4),
+	MUX(none, "mout_audio2", mout_audio2_p4210, SRC_PERIL1, 4, 4),
+	MUX(none, "mout_spi0", group1_p4210, SRC_PERIL1, 16, 4),
+	MUX(none, "mout_spi1", group1_p4210, SRC_PERIL1, 20, 4),
+	MUX(none, "mout_spi2", group1_p4210, SRC_PERIL1, 24, 4),
 };
 
 /* list of mux clocks supported in exynos4x12 soc */
 struct samsung_mux_clock exynos4x12_mux_clks[] __initdata = {
-	MUX(none, "mout_mpll_user", mout_mpll_user_p, SRC_LEFTBUS, 4, 1),
+	MUX(mout_mpll_user_c, "mout_mpll_user_c", mout_mpll_user_p4x12,
+			SRC_CPU, 24, 1),
+	MUX(mout_mpll_user_t, "mout_mpll_user_t", mout_mpll_user_p4x12,
+			SRC_TOP1, 12, 1),
 	MUX(none, "mout_aclk200", aclk_p4412, SRC_TOP0, 12, 1),
 	MUX(none, "mout_aclk100", aclk_p4412, SRC_TOP0, 16, 1),
 	MUX(none, "mout_aclk160", aclk_p4412, SRC_TOP0, 20, 1),
 	MUX(none, "mout_aclk133", aclk_p4412, SRC_TOP0, 24, 1),
-	MUX(none, "mout_mdnie0", group1_p, SRC_LCD0, 4, 4),
-	MUX(none, "mout_mdnie_pwm0", group1_p, SRC_LCD0, 8, 4),
-	MUX(none, "mout_sata", sclk_ampll_p, SRC_FSYS, 24, 1),
-	MUX(none, "mout_jpeg0", sclk_ampll_p, E4X12_SRC_CAM1, 0, 1),
+	MUX(none, "mout_mdnie0", group1_p4x12, SRC_LCD0, 4, 4),
+	MUX(none, "mout_mdnie_pwm0", group1_p4x12, SRC_LCD0, 8, 4),
+	MUX(none, "mout_sata", sclk_ampll_p4x12, SRC_FSYS, 24, 1),
+	MUX(none, "mout_jpeg0", sclk_ampll_p4x12, E4X12_SRC_CAM1, 0, 1),
 	MUX(none, "mout_jpeg1", sclk_evpll_p, E4X12_SRC_CAM1, 4, 1),
 	MUX(none, "mout_jpeg", mout_jpeg_p, E4X12_SRC_CAM1, 8, 1),
 	MUX_A(sclk_mpll, "sclk_mpll", mout_mpll_p,
 			E4X12_SRC_DMC, 12, 1, "sclk_mpll"),
 	MUX_A(sclk_vpll, "sclk_vpll", mout_vpll_p,
 			SRC_TOP0, 8, 1, "sclk_vpll"),
+	MUX(none, "mout_core", mout_core_p4x12, SRC_CPU, 16, 1),
+	MUX(none, "mout_fimc0", group1_p4x12, SRC_CAM, 0, 4),
+	MUX(none, "mout_fimc1", group1_p4x12, SRC_CAM, 4, 4),
+	MUX(none, "mout_fimc2", group1_p4x12, SRC_CAM, 8, 4),
+	MUX(none, "mout_fimc3", group1_p4x12, SRC_CAM, 12, 4),
+	MUX(none, "mout_cam0", group1_p4x12, SRC_CAM, 16, 4),
+	MUX(none, "mout_cam1", group1_p4x12, SRC_CAM, 20, 4),
+	MUX(none, "mout_csis0", group1_p4x12, SRC_CAM, 24, 4),
+	MUX(none, "mout_csis1", group1_p4x12, SRC_CAM, 28, 4),
+	MUX(none, "mout_mfc0", sclk_ampll_p4x12, SRC_MFC, 0, 1),
+	MUX(none, "mout_g3d0", sclk_ampll_p4x12, SRC_G3D, 0, 1),
+	MUX(none, "mout_fimd0", group1_p4x12, SRC_LCD0, 0, 4),
+	MUX(none, "mout_mipi0", group1_p4x12, SRC_LCD0, 12, 4),
+	MUX(none, "mout_audio0", mout_audio0_p4x12, SRC_MAUDIO, 0, 4),
+	MUX(none, "mout_mmc0", group1_p4x12, SRC_FSYS, 0, 4),
+	MUX(none, "mout_mmc1", group1_p4x12, SRC_FSYS, 4, 4),
+	MUX(none, "mout_mmc2", group1_p4x12, SRC_FSYS, 8, 4),
+	MUX(none, "mout_mmc3", group1_p4x12, SRC_FSYS, 12, 4),
+	MUX(none, "mout_mmc4", group1_p4x12, SRC_FSYS, 16, 4),
+	MUX(none, "mout_uart0", group1_p4x12, SRC_PERIL0, 0, 4),
+	MUX(none, "mout_uart1", group1_p4x12, SRC_PERIL0, 4, 4),
+	MUX(none, "mout_uart2", group1_p4x12, SRC_PERIL0, 8, 4),
+	MUX(none, "mout_uart3", group1_p4x12, SRC_PERIL0, 12, 4),
+	MUX(none, "mout_uart4", group1_p4x12, SRC_PERIL0, 16, 4),
+	MUX(none, "mout_audio1", mout_audio1_p4x12, SRC_PERIL1, 0, 4),
+	MUX(none, "mout_audio2", mout_audio2_p4x12, SRC_PERIL1, 4, 4),
+	MUX(none, "mout_spi0", group1_p4x12, SRC_PERIL1, 16, 4),
+	MUX(none, "mout_spi1", group1_p4x12, SRC_PERIL1, 20, 4),
+	MUX(none, "mout_spi2", group1_p4x12, SRC_PERIL1, 24, 4),
 };
 
 /* list of divider clocks supported in all exynos4 soc's */
-- 
1.8.1.5
