From: a.hajda@samsung.com (Andrzej Hajda)
Date: Thu, 05 Sep 2013 14:36:30 +0200
Subject: [PATCH 09/12] clk: exynos5420: replace clock ID private enums with IDs
 from DT header
In-Reply-To: <1378384594-4807-1-git-send-email-a.hajda@samsung.com>
References: <1378384594-4807-1-git-send-email-a.hajda@samsung.com>
Message-ID: <1378384594-4807-13-git-send-email-a.hajda@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch replaces private enum clock IDs in the driver with macros provided
by the DT header.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/clk/samsung/clk-exynos5420.c | 648 +++++++++++++++++------------------
 1 file changed, 309 insertions(+), 339 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index 48c4a93..ab223f0 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -10,6 +10,7 @@
  * Common Clock Framework support for Exynos5420 SoC.
 */
 
+#include <dt-bindings/clock/exynos5420.h>
 #include <linux/clk.h>
 #include <linux/clkdev.h>
 #include <linux/clk-provider.h>
@@ -107,48 +108,6 @@ enum exynos5420_plls {
 	nr_plls			/* number of PLLs */
 };
 
-enum exynos5420_clks {
-	none,
-
-	/* core clocks */
-	fin_pll,  fout_apll, fout_cpll, fout_dpll, fout_epll, fout_rpll,
-	fout_ipll, fout_spll, fout_vpll, fout_mpll, fout_bpll, fout_kpll,
-
-	/* gate for special clocks (sclk) */
-	sclk_uart0 = 128, sclk_uart1, sclk_uart2, sclk_uart3, sclk_mmc0,
-	sclk_mmc1, sclk_mmc2, sclk_spi0, sclk_spi1, sclk_spi2, sclk_i2s1,
-	sclk_i2s2, sclk_pcm1, sclk_pcm2, sclk_spdif, sclk_hdmi, sclk_pixel,
-	sclk_dp1, sclk_mipi1, sclk_fimd1, sclk_maudio0, sclk_maupcm0,
-	sclk_usbd300, sclk_usbd301, sclk_usbphy300, sclk_usbphy301, sclk_unipro,
-	sclk_pwm, sclk_gscl_wa, sclk_gscl_wb, sclk_hdmiphy,
-
-	/* gate clocks */
-	aclk66_peric = 256, uart0, uart1, uart2, uart3, i2c0, i2c1, i2c2, i2c3,
-	i2c4, i2c5, i2c6, i2c7, i2c_hdmi, tsadc, spi0, spi1, spi2, keyif, i2s1,
-	i2s2, pcm1, pcm2, pwm, spdif, i2c8, i2c9, i2c10, aclk66_psgen = 300,
-	chipid, sysreg, tzpc0, tzpc1, tzpc2, tzpc3, tzpc4, tzpc5, tzpc6, tzpc7,
-	tzpc8, tzpc9, hdmi_cec, seckey, mct, wdt, rtc, tmu, tmu_gpu,
-	pclk66_gpio = 330, aclk200_fsys2 = 350, mmc0, mmc1, mmc2, sromc, ufs,
-	aclk200_fsys = 360, tsi, pdma0, pdma1, rtic, usbh20, usbd300, usbd301,
-	aclk400_mscl = 380, mscl0, mscl1, mscl2, smmu_mscl0, smmu_mscl1,
-	smmu_mscl2, aclk333 = 400, mfc, smmu_mfcl, smmu_mfcr,
-	aclk200_disp1 = 410, dsim1, dp1, hdmi, aclk300_disp1 = 420, fimd1,
-	smmu_fimd1, aclk166 = 430, mixer, aclk266 = 440, rotator, mdma1,
-	smmu_rotator, smmu_mdma1, aclk300_jpeg = 450, jpeg, jpeg2, smmu_jpeg,
-	aclk300_gscl = 460, smmu_gscl0, smmu_gscl1, gscl_wa, gscl_wb, gscl0,
-	gscl1, clk_3aa, aclk266_g2d = 470, sss, slim_sss, mdma0,
-	aclk333_g2d = 480, g2d, aclk333_432_gscl = 490, smmu_3aa, smmu_fimcl0,
-	smmu_fimcl1, smmu_fimcl3, fimc_lite3, aclk_g3d = 500, g3d, smmu_mixer,
-
-	/* mux clocks */
-	mout_hdmi = 640,
-
-	/* divider clocks */
-	dout_pixel = 768,
-
-	nr_clks,
-};
-
 /*
  * list of controller registers to be saved and restored during a
  * suspend/resume cycle.
@@ -298,225 +257,226 @@ PNAME(maudio0_p)	= { "fin_pll", "maudio_clk", "sclk_dpll", "sclk_mpll",
 
 /* fixed rate clocks generated outside the soc */
 static struct samsung_fixed_rate_clock exynos5420_fixed_rate_ext_clks[] __initdata = {
-	FRATE(fin_pll, "fin_pll", NULL, CLK_IS_ROOT, 0),
+	FRATE(CLK_FIN_PLL, "fin_pll", NULL, CLK_IS_ROOT, 0),
 };
 
 /* fixed rate clocks generated inside the soc */
 static struct samsung_fixed_rate_clock exynos5420_fixed_rate_clks[] __initdata = {
-	FRATE(sclk_hdmiphy, "sclk_hdmiphy", NULL, CLK_IS_ROOT, 24000000),
-	FRATE(none, "sclk_pwi", NULL, CLK_IS_ROOT, 24000000),
-	FRATE(none, "sclk_usbh20", NULL, CLK_IS_ROOT, 48000000),
-	FRATE(none, "mphy_refclk_ixtal24", NULL, CLK_IS_ROOT, 48000000),
-	FRATE(none, "sclk_usbh20_scan_clk", NULL, CLK_IS_ROOT, 480000000),
+	FRATE(CLK_SCLK_HDMIPHY, "sclk_hdmiphy", NULL, CLK_IS_ROOT, 24000000),
+	FRATE(0, "sclk_pwi", NULL, CLK_IS_ROOT, 24000000),
+	FRATE(0, "sclk_usbh20", NULL, CLK_IS_ROOT, 48000000),
+	FRATE(0, "mphy_refclk_ixtal24", NULL, CLK_IS_ROOT, 48000000),
+	FRATE(0, "sclk_usbh20_scan_clk", NULL, CLK_IS_ROOT, 480000000),
 };
 
 static struct samsung_fixed_factor_clock exynos5420_fixed_factor_clks[] __initdata = {
-	FFACTOR(none, "sclk_hsic_12m", "fin_pll", 1, 2, 0),
+	FFACTOR(0, "sclk_hsic_12m", "fin_pll", 1, 2, 0),
 };
 
 static struct samsung_mux_clock exynos5420_mux_clks[] __initdata = {
-	MUX(none, "mout_mspll_kfc", mspll_cpu_p, SRC_TOP7, 8, 2),
-	MUX(none, "mout_mspll_cpu", mspll_cpu_p, SRC_TOP7, 12, 2),
-	MUX(none, "mout_apll", apll_p, SRC_CPU, 0, 1),
-	MUX(none, "mout_cpu", cpu_p, SRC_CPU, 16, 1),
-	MUX(none, "mout_kpll", kpll_p, SRC_KFC, 0, 1),
-	MUX(none, "mout_cpu_kfc", kfc_p, SRC_KFC, 16, 1),
+	MUX(0, "mout_mspll_kfc", mspll_cpu_p, SRC_TOP7, 8, 2),
+	MUX(0, "mout_mspll_cpu", mspll_cpu_p, SRC_TOP7, 12, 2),
+	MUX(0, "mout_apll", apll_p, SRC_CPU, 0, 1),
+	MUX(0, "mout_cpu", cpu_p, SRC_CPU, 16, 1),
+	MUX(0, "mout_kpll", kpll_p, SRC_KFC, 0, 1),
+	MUX(0, "mout_cpu_kfc", kfc_p, SRC_KFC, 16, 1),
 
-	MUX(none, "sclk_bpll", bpll_p, SRC_CDREX, 0, 1),
+	MUX(0, "sclk_bpll", bpll_p, SRC_CDREX, 0, 1),
 
-	MUX_A(none, "mout_aclk400_mscl", group1_p,
+	MUX_A(0, "mout_aclk400_mscl", group1_p,
 			SRC_TOP0, 4, 2, "aclk400_mscl"),
-	MUX(none, "mout_aclk200", group1_p, SRC_TOP0, 8, 2),
-	MUX(none, "mout_aclk200_fsys2", group1_p, SRC_TOP0, 12, 2),
-	MUX(none, "mout_aclk200_fsys", group1_p, SRC_TOP0, 28, 2),
-
-	MUX(none, "mout_aclk333_432_gscl", group4_p, SRC_TOP1, 0, 2),
-	MUX(none, "mout_aclk66", group1_p, SRC_TOP1, 8, 2),
-	MUX(none, "mout_aclk266", group1_p, SRC_TOP1, 20, 2),
-	MUX(none, "mout_aclk166", group1_p, SRC_TOP1, 24, 2),
-	MUX(none, "mout_aclk333", group1_p, SRC_TOP1, 28, 2),
-
-	MUX(none, "mout_aclk333_g2d", group1_p, SRC_TOP2, 8, 2),
-	MUX(none, "mout_aclk266_g2d", group1_p, SRC_TOP2, 12, 2),
-	MUX(none, "mout_aclk_g3d", group5_p, SRC_TOP2, 16, 1),
-	MUX(none, "mout_aclk300_jpeg", group1_p, SRC_TOP2, 20, 2),
-	MUX(none, "mout_aclk300_disp1", group1_p, SRC_TOP2, 24, 2),
-	MUX(none, "mout_aclk300_gscl", group1_p, SRC_TOP2, 28, 2),
-
-	MUX(none, "mout_user_aclk400_mscl", user_aclk400_mscl_p,
+	MUX(0, "mout_aclk200", group1_p, SRC_TOP0, 8, 2),
+	MUX(0, "mout_aclk200_fsys2", group1_p, SRC_TOP0, 12, 2),
+	MUX(0, "mout_aclk200_fsys", group1_p, SRC_TOP0, 28, 2),
+
+	MUX(0, "mout_aclk333_432_gscl", group4_p, SRC_TOP1, 0, 2),
+	MUX(0, "mout_aclk66", group1_p, SRC_TOP1, 8, 2),
+	MUX(0, "mout_aclk266", group1_p, SRC_TOP1, 20, 2),
+	MUX(0, "mout_aclk166", group1_p, SRC_TOP1, 24, 2),
+	MUX(0, "mout_aclk333", group1_p, SRC_TOP1, 28, 2),
+
+	MUX(0, "mout_aclk333_g2d", group1_p, SRC_TOP2, 8, 2),
+	MUX(0, "mout_aclk266_g2d", group1_p, SRC_TOP2, 12, 2),
+	MUX(0, "mout_aclk_g3d", group5_p, SRC_TOP2, 16, 1),
+	MUX(0, "mout_aclk300_jpeg", group1_p, SRC_TOP2, 20, 2),
+	MUX(0, "mout_aclk300_disp1", group1_p, SRC_TOP2, 24, 2),
+	MUX(0, "mout_aclk300_gscl", group1_p, SRC_TOP2, 28, 2),
+
+	MUX(0, "mout_user_aclk400_mscl", user_aclk400_mscl_p,
 			SRC_TOP3, 4, 1),
-	MUX_A(none, "mout_aclk200_disp1", aclk200_disp1_p,
+	MUX_A(0, "mout_aclk200_disp1", aclk200_disp1_p,
 			SRC_TOP3, 8, 1, "aclk200_disp1"),
-	MUX(none, "mout_user_aclk200_fsys2", user_aclk200_fsys2_p,
+	MUX(0, "mout_user_aclk200_fsys2", user_aclk200_fsys2_p,
 			SRC_TOP3, 12, 1),
-	MUX(none, "mout_user_aclk200_fsys", user_aclk200_fsys_p,
+	MUX(0, "mout_user_aclk200_fsys", user_aclk200_fsys_p,
 			SRC_TOP3, 28, 1),
 
-	MUX(none, "mout_user_aclk333_432_gscl", user_aclk333_432_gscl_p,
+	MUX(0, "mout_user_aclk333_432_gscl", user_aclk333_432_gscl_p,
 			SRC_TOP4, 0, 1),
-	MUX(none, "mout_aclk66_peric", aclk66_peric_p, SRC_TOP4, 8, 1),
-	MUX(none, "mout_user_aclk266", user_aclk266_p, SRC_TOP4, 20, 1),
-	MUX(none, "mout_user_aclk166", user_aclk166_p, SRC_TOP4, 24, 1),
-	MUX(none, "mout_user_aclk333", user_aclk333_p, SRC_TOP4, 28, 1),
-
-	MUX(none, "mout_aclk66_psgen", aclk66_peric_p, SRC_TOP5, 4, 1),
-	MUX(none, "mout_user_aclk333_g2d", user_aclk333_g2d_p, SRC_TOP5, 8, 1),
-	MUX(none, "mout_user_aclk266_g2d", user_aclk266_g2d_p, SRC_TOP5, 12, 1),
-	MUX_A(none, "mout_user_aclk_g3d", user_aclk_g3d_p,
+	MUX(0, "mout_aclk66_peric", aclk66_peric_p, SRC_TOP4, 8, 1),
+	MUX(0, "mout_user_aclk266", user_aclk266_p, SRC_TOP4, 20, 1),
+	MUX(0, "mout_user_aclk166", user_aclk166_p, SRC_TOP4, 24, 1),
+	MUX(0, "mout_user_aclk333", user_aclk333_p, SRC_TOP4, 28, 1),
+
+	MUX(0, "mout_aclk66_psgen", aclk66_peric_p, SRC_TOP5, 4, 1),
+	MUX(0, "mout_user_aclk333_g2d", user_aclk333_g2d_p, SRC_TOP5, 8, 1),
+	MUX(0, "mout_user_aclk266_g2d", user_aclk266_g2d_p, SRC_TOP5, 12, 1),
+	MUX_A(0, "mout_user_aclk_g3d", user_aclk_g3d_p,
 			SRC_TOP5, 16, 1, "aclkg3d"),
-	MUX(none, "mout_user_aclk300_jpeg", user_aclk300_jpeg_p,
+	MUX(0, "mout_user_aclk300_jpeg", user_aclk300_jpeg_p,
 			SRC_TOP5, 20, 1),
-	MUX(none, "mout_user_aclk300_disp1", user_aclk300_disp1_p,
+	MUX(0, "mout_user_aclk300_disp1", user_aclk300_disp1_p,
 			SRC_TOP5, 24, 1),
-	MUX(none, "mout_user_aclk300_gscl", user_aclk300_gscl_p,
+	MUX(0, "mout_user_aclk300_gscl", user_aclk300_gscl_p,
 			SRC_TOP5, 28, 1),
 
-	MUX(none, "sclk_mpll", mpll_p, SRC_TOP6, 0, 1),
-	MUX(none, "sclk_vpll", vpll_p, SRC_TOP6, 4, 1),
-	MUX(none, "sclk_spll", spll_p, SRC_TOP6, 8, 1),
-	MUX(none, "sclk_ipll", ipll_p, SRC_TOP6, 12, 1),
-	MUX(none, "sclk_rpll", rpll_p, SRC_TOP6, 16, 1),
-	MUX(none, "sclk_epll", epll_p, SRC_TOP6, 20, 1),
-	MUX(none, "sclk_dpll", dpll_p, SRC_TOP6, 24, 1),
-	MUX(none, "sclk_cpll", cpll_p, SRC_TOP6, 28, 1),
-
-	MUX(none, "mout_sw_aclk400_mscl", sw_aclk400_mscl_p, SRC_TOP10, 4, 1),
-	MUX(none, "mout_sw_aclk200", sw_aclk200_p, SRC_TOP10, 8, 1),
-	MUX(none, "mout_sw_aclk200_fsys2", sw_aclk200_fsys2_p,
+	MUX(0, "sclk_mpll", mpll_p, SRC_TOP6, 0, 1),
+	MUX(0, "sclk_vpll", vpll_p, SRC_TOP6, 4, 1),
+	MUX(0, "sclk_spll", spll_p, SRC_TOP6, 8, 1),
+	MUX(0, "sclk_ipll", ipll_p, SRC_TOP6, 12, 1),
+	MUX(0, "sclk_rpll", rpll_p, SRC_TOP6, 16, 1),
+	MUX(0, "sclk_epll", epll_p, SRC_TOP6, 20, 1),
+	MUX(0, "sclk_dpll", dpll_p, SRC_TOP6, 24, 1),
+	MUX(0, "sclk_cpll", cpll_p, SRC_TOP6, 28, 1),
+
+	MUX(0, "mout_sw_aclk400_mscl", sw_aclk400_mscl_p, SRC_TOP10, 4, 1),
+	MUX(0, "mout_sw_aclk200", sw_aclk200_p, SRC_TOP10, 8, 1),
+	MUX(0, "mout_sw_aclk200_fsys2", sw_aclk200_fsys2_p,
 			SRC_TOP10, 12, 1),
-	MUX(none, "mout_sw_aclk200_fsys", sw_aclk200_fsys_p, SRC_TOP10, 28, 1),
+	MUX(0, "mout_sw_aclk200_fsys", sw_aclk200_fsys_p, SRC_TOP10, 28, 1),
 
-	MUX(none, "mout_sw_aclk333_432_gscl", sw_aclk333_432_gscl_p,
+	MUX(0, "mout_sw_aclk333_432_gscl", sw_aclk333_432_gscl_p,
 			SRC_TOP11, 0, 1),
-	MUX(none, "mout_sw_aclk66", sw_aclk66_p, SRC_TOP11, 8, 1),
-	MUX(none, "mout_sw_aclk266", sw_aclk266_p, SRC_TOP11, 20, 1),
-	MUX(none, "mout_sw_aclk166", sw_aclk166_p, SRC_TOP11, 24, 1),
-	MUX(none, "mout_sw_aclk333", sw_aclk333_p, SRC_TOP11, 28, 1),
-
-	MUX(none, "mout_sw_aclk333_g2d", sw_aclk333_g2d_p, SRC_TOP12, 8, 1),
-	MUX(none, "mout_sw_aclk266_g2d", sw_aclk266_g2d_p, SRC_TOP12, 12, 1),
-	MUX(none, "mout_sw_aclk_g3d", sw_aclk_g3d_p, SRC_TOP12, 16, 1),
-	MUX(none, "mout_sw_aclk300_jpeg", sw_aclk300_jpeg_p, SRC_TOP12, 20, 1),
-	MUX(none, "mout_sw_aclk300_disp1", sw_aclk300_disp1_p,
+	MUX(0, "mout_sw_aclk66", sw_aclk66_p, SRC_TOP11, 8, 1),
+	MUX(0, "mout_sw_aclk266", sw_aclk266_p, SRC_TOP11, 20, 1),
+	MUX(0, "mout_sw_aclk166", sw_aclk166_p, SRC_TOP11, 24, 1),
+	MUX(0, "mout_sw_aclk333", sw_aclk333_p, SRC_TOP11, 28, 1),
+
+	MUX(0, "mout_sw_aclk333_g2d", sw_aclk333_g2d_p, SRC_TOP12, 8, 1),
+	MUX(0, "mout_sw_aclk266_g2d", sw_aclk266_g2d_p, SRC_TOP12, 12, 1),
+	MUX(0, "mout_sw_aclk_g3d", sw_aclk_g3d_p, SRC_TOP12, 16, 1),
+	MUX(0, "mout_sw_aclk300_jpeg", sw_aclk300_jpeg_p, SRC_TOP12, 20, 1),
+	MUX(0, "mout_sw_aclk300_disp1", sw_aclk300_disp1_p,
 			SRC_TOP12, 24, 1),
-	MUX(none, "mout_sw_aclk300_gscl", sw_aclk300_gscl_p, SRC_TOP12, 28, 1),
+	MUX(0, "mout_sw_aclk300_gscl", sw_aclk300_gscl_p, SRC_TOP12, 28, 1),
 
 	/* DISP1 Block */
-	MUX(none, "mout_fimd1", group3_p, SRC_DISP10, 4, 1),
-	MUX(none, "mout_mipi1", group2_p, SRC_DISP10, 16, 3),
-	MUX(none, "mout_dp1", group2_p, SRC_DISP10, 20, 3),
-	MUX(none, "mout_pixel", group2_p, SRC_DISP10, 24, 3),
-	MUX(mout_hdmi, "mout_hdmi", hdmi_p, SRC_DISP10, 28, 1),
+	MUX(0, "mout_fimd1", group3_p, SRC_DISP10, 4, 1),
+	MUX(0, "mout_mipi1", group2_p, SRC_DISP10, 16, 3),
+	MUX(0, "mout_dp1", group2_p, SRC_DISP10, 20, 3),
+	MUX(0, "mout_pixel", group2_p, SRC_DISP10, 24, 3),
+	MUX(CLK_MOUT_HDMI, "mout_hdmi", hdmi_p, SRC_DISP10, 28, 1),
 
 	/* MAU Block */
-	MUX(none, "mout_maudio0", maudio0_p, SRC_MAU, 28, 3),
+	MUX(0, "mout_maudio0", maudio0_p, SRC_MAU, 28, 3),
 
 	/* FSYS Block */
-	MUX(none, "mout_usbd301", group2_p, SRC_FSYS, 4, 3),
-	MUX(none, "mout_mmc0", group2_p, SRC_FSYS, 8, 3),
-	MUX(none, "mout_mmc1", group2_p, SRC_FSYS, 12, 3),
-	MUX(none, "mout_mmc2", group2_p, SRC_FSYS, 16, 3),
-	MUX(none, "mout_usbd300", group2_p, SRC_FSYS, 20, 3),
-	MUX(none, "mout_unipro", group2_p, SRC_FSYS, 24, 3),
+	MUX(0, "mout_usbd301", group2_p, SRC_FSYS, 4, 3),
+	MUX(0, "mout_mmc0", group2_p, SRC_FSYS, 8, 3),
+	MUX(0, "mout_mmc1", group2_p, SRC_FSYS, 12, 3),
+	MUX(0, "mout_mmc2", group2_p, SRC_FSYS, 16, 3),
+	MUX(0, "mout_usbd300", group2_p, SRC_FSYS, 20, 3),
+	MUX(0, "mout_unipro", group2_p, SRC_FSYS, 24, 3),
 
 	/* PERIC Block */
-	MUX(none, "mout_uart0", group2_p, SRC_PERIC0, 4, 3),
-	MUX(none, "mout_uart1", group2_p, SRC_PERIC0, 8, 3),
-	MUX(none, "mout_uart2", group2_p, SRC_PERIC0, 12, 3),
-	MUX(none, "mout_uart3", group2_p, SRC_PERIC0, 16, 3),
-	MUX(none, "mout_pwm", group2_p, SRC_PERIC0, 24, 3),
-	MUX(none, "mout_spdif", spdif_p, SRC_PERIC0, 28, 3),
-	MUX(none, "mout_audio0", audio0_p, SRC_PERIC1, 8, 3),
-	MUX(none, "mout_audio1", audio1_p, SRC_PERIC1, 12, 3),
-	MUX(none, "mout_audio2", audio2_p, SRC_PERIC1, 16, 3),
-	MUX(none, "mout_spi0", group2_p, SRC_PERIC1, 20, 3),
-	MUX(none, "mout_spi1", group2_p, SRC_PERIC1, 24, 3),
-	MUX(none, "mout_spi2", group2_p, SRC_PERIC1, 28, 3),
+	MUX(0, "mout_uart0", group2_p, SRC_PERIC0, 4, 3),
+	MUX(0, "mout_uart1", group2_p, SRC_PERIC0, 8, 3),
+	MUX(0, "mout_uart2", group2_p, SRC_PERIC0, 12, 3),
+	MUX(0, "mout_uart3", group2_p, SRC_PERIC0, 16, 3),
+	MUX(0, "mout_pwm", group2_p, SRC_PERIC0, 24, 3),
+	MUX(0, "mout_spdif", spdif_p, SRC_PERIC0, 28, 3),
+	MUX(0, "mout_audio0", audio0_p, SRC_PERIC1, 8, 3),
+	MUX(0, "mout_audio1", audio1_p, SRC_PERIC1, 12, 3),
+	MUX(0, "mout_audio2", audio2_p, SRC_PERIC1, 16, 3),
+	MUX(0, "mout_spi0", group2_p, SRC_PERIC1, 20, 3),
+	MUX(0, "mout_spi1", group2_p, SRC_PERIC1, 24, 3),
+	MUX(0, "mout_spi2", group2_p, SRC_PERIC1, 28, 3),
 };
 
 static struct samsung_div_clock exynos5420_div_clks[] __initdata = {
-	DIV(none, "div_arm", "mout_cpu", DIV_CPU0, 0, 3),
-	DIV(none, "sclk_apll", "mout_apll", DIV_CPU0, 24, 3),
-	DIV(none, "armclk2", "div_arm", DIV_CPU0, 28, 3),
-	DIV(none, "div_kfc", "mout_cpu_kfc", DIV_KFC0, 0, 3),
-	DIV(none, "sclk_kpll", "mout_kpll", DIV_KFC0, 24, 3),
-
-	DIV(none, "dout_aclk400_mscl", "mout_aclk400_mscl", DIV_TOP0, 4, 3),
-	DIV(none, "dout_aclk200", "mout_aclk200", DIV_TOP0, 8, 3),
-	DIV(none, "dout_aclk200_fsys2", "mout_aclk200_fsys2", DIV_TOP0, 12, 3),
-	DIV(none, "dout_pclk200_fsys", "mout_pclk200_fsys", DIV_TOP0, 24, 3),
-	DIV(none, "dout_aclk200_fsys", "mout_aclk200_fsys", DIV_TOP0, 28, 3),
-
-	DIV(none, "dout_aclk333_432_gscl", "mout_aclk333_432_gscl",
+	DIV(0, "div_arm", "mout_cpu", DIV_CPU0, 0, 3),
+	DIV(0, "sclk_apll", "mout_apll", DIV_CPU0, 24, 3),
+	DIV(0, "armclk2", "div_arm", DIV_CPU0, 28, 3),
+	DIV(0, "div_kfc", "mout_cpu_kfc", DIV_KFC0, 0, 3),
+	DIV(0, "sclk_kpll", "mout_kpll", DIV_KFC0, 24, 3),
+
+	DIV(0, "dout_aclk400_mscl", "mout_aclk400_mscl", DIV_TOP0, 4, 3),
+	DIV(0, "dout_aclk200", "mout_aclk200", DIV_TOP0, 8, 3),
+	DIV(0, "dout_aclk200_fsys2", "mout_aclk200_fsys2", DIV_TOP0, 12, 3),
+	DIV(0, "dout_pclk200_fsys", "mout_pclk200_fsys", DIV_TOP0, 24, 3),
+	DIV(0, "dout_aclk200_fsys", "mout_aclk200_fsys", DIV_TOP0, 28, 3),
+
+	DIV(0, "dout_aclk333_432_gscl", "mout_aclk333_432_gscl",
 			DIV_TOP1, 0, 3),
-	DIV(none, "dout_aclk66", "mout_aclk66", DIV_TOP1, 8, 6),
-	DIV(none, "dout_aclk266", "mout_aclk266", DIV_TOP1, 20, 3),
-	DIV(none, "dout_aclk166", "mout_aclk166", DIV_TOP1, 24, 3),
-	DIV(none, "dout_aclk333", "mout_aclk333", DIV_TOP1, 28, 3),
-
-	DIV(none, "dout_aclk333_g2d", "mout_aclk333_g2d", DIV_TOP2, 8, 3),
-	DIV(none, "dout_aclk266_g2d", "mout_aclk266_g2d", DIV_TOP2, 12, 3),
-	DIV(none, "dout_aclk_g3d", "mout_aclk_g3d", DIV_TOP2, 16, 3),
-	DIV(none, "dout_aclk300_jpeg", "mout_aclk300_jpeg", DIV_TOP2, 20, 3),
-	DIV_A(none, "dout_aclk300_disp1", "mout_aclk300_disp1",
+	DIV(0, "dout_aclk66", "mout_aclk66", DIV_TOP1, 8, 6),
+	DIV(0, "dout_aclk266", "mout_aclk266", DIV_TOP1, 20, 3),
+	DIV(0, "dout_aclk166", "mout_aclk166", DIV_TOP1, 24, 3),
+	DIV(0, "dout_aclk333", "mout_aclk333", DIV_TOP1, 28, 3),
+
+	DIV(0, "dout_aclk333_g2d", "mout_aclk333_g2d", DIV_TOP2, 8, 3),
+	DIV(0, "dout_aclk266_g2d", "mout_aclk266_g2d", DIV_TOP2, 12, 3),
+	DIV(0, "dout_aclk_g3d", "mout_aclk_g3d", DIV_TOP2, 16, 3),
+	DIV(0, "dout_aclk300_jpeg", "mout_aclk300_jpeg", DIV_TOP2, 20, 3),
+	DIV_A(0, "dout_aclk300_disp1", "mout_aclk300_disp1",
 			DIV_TOP2, 24, 3, "aclk300_disp1"),
-	DIV(none, "dout_aclk300_gscl", "mout_aclk300_gscl", DIV_TOP2, 28, 3),
+	DIV(0, "dout_aclk300_gscl", "mout_aclk300_gscl", DIV_TOP2, 28, 3),
 
 	/* DISP1 Block */
-	DIV(none, "dout_fimd1", "mout_fimd1", DIV_DISP10, 0, 4),
-	DIV(none, "dout_mipi1", "mout_mipi1", DIV_DISP10, 16, 8),
-	DIV(none, "dout_dp1", "mout_dp1", DIV_DISP10, 24, 4),
-	DIV(dout_pixel, "dout_hdmi_pixel", "mout_pixel", DIV_DISP10, 28, 4),
+	DIV(0, "dout_fimd1", "mout_fimd1", DIV_DISP10, 0, 4),
+	DIV(0, "dout_mipi1", "mout_mipi1", DIV_DISP10, 16, 8),
+	DIV(0, "dout_dp1", "mout_dp1", DIV_DISP10, 24, 4),
+	DIV(CLK_DOUT_PIXEL, "dout_hdmi_pixel", "mout_pixel", DIV_DISP10, 28, 4),
 
 	/* Audio Block */
-	DIV(none, "dout_maudio0", "mout_maudio0", DIV_MAU, 20, 4),
-	DIV(none, "dout_maupcm0", "dout_maudio0", DIV_MAU, 24, 8),
+	DIV(0, "dout_maudio0", "mout_maudio0", DIV_MAU, 20, 4),
+	DIV(0, "dout_maupcm0", "dout_maudio0", DIV_MAU, 24, 8),
 
 	/* USB3.0 */
-	DIV(none, "dout_usbphy301", "mout_usbd301", DIV_FSYS0, 12, 4),
-	DIV(none, "dout_usbphy300", "mout_usbd300", DIV_FSYS0, 16, 4),
-	DIV(none, "dout_usbd301", "mout_usbd301", DIV_FSYS0, 20, 4),
-	DIV(none, "dout_usbd300", "mout_usbd300", DIV_FSYS0, 24, 4),
+	DIV(0, "dout_usbphy301", "mout_usbd301", DIV_FSYS0, 12, 4),
+	DIV(0, "dout_usbphy300", "mout_usbd300", DIV_FSYS0, 16, 4),
+	DIV(0, "dout_usbd301", "mout_usbd301", DIV_FSYS0, 20, 4),
+	DIV(0, "dout_usbd300", "mout_usbd300", DIV_FSYS0, 24, 4),
 
 	/* MMC */
-	DIV(none, "dout_mmc0", "mout_mmc0", DIV_FSYS1, 0, 10),
-	DIV(none, "dout_mmc1", "mout_mmc1", DIV_FSYS1, 10, 10),
-	DIV(none, "dout_mmc2", "mout_mmc2", DIV_FSYS1, 20, 10),
+	DIV(0, "dout_mmc0", "mout_mmc0", DIV_FSYS1, 0, 10),
+	DIV(0, "dout_mmc1", "mout_mmc1", DIV_FSYS1, 10, 10),
+	DIV(0, "dout_mmc2", "mout_mmc2", DIV_FSYS1, 20, 10),
 
-	DIV(none, "dout_unipro", "mout_unipro", DIV_FSYS2, 24, 8),
+	DIV(0, "dout_unipro", "mout_unipro", DIV_FSYS2, 24, 8),
 
 	/* UART and PWM */
-	DIV(none, "dout_uart0", "mout_uart0", DIV_PERIC0, 8, 4),
-	DIV(none, "dout_uart1", "mout_uart1", DIV_PERIC0, 12, 4),
-	DIV(none, "dout_uart2", "mout_uart2", DIV_PERIC0, 16, 4),
-	DIV(none, "dout_uart3", "mout_uart3", DIV_PERIC0, 20, 4),
-	DIV(none, "dout_pwm", "mout_pwm", DIV_PERIC0, 28, 4),
+	DIV(0, "dout_uart0", "mout_uart0", DIV_PERIC0, 8, 4),
+	DIV(0, "dout_uart1", "mout_uart1", DIV_PERIC0, 12, 4),
+	DIV(0, "dout_uart2", "mout_uart2", DIV_PERIC0, 16, 4),
+	DIV(0, "dout_uart3", "mout_uart3", DIV_PERIC0, 20, 4),
+	DIV(0, "dout_pwm", "mout_pwm", DIV_PERIC0, 28, 4),
 
 	/* SPI */
-	DIV(none, "dout_spi0", "mout_spi0", DIV_PERIC1, 20, 4),
-	DIV(none, "dout_spi1", "mout_spi1", DIV_PERIC1, 24, 4),
-	DIV(none, "dout_spi2", "mout_spi2", DIV_PERIC1, 28, 4),
+	DIV(0, "dout_spi0", "mout_spi0", DIV_PERIC1, 20, 4),
+	DIV(0, "dout_spi1", "mout_spi1", DIV_PERIC1, 24, 4),
+	DIV(0, "dout_spi2", "mout_spi2", DIV_PERIC1, 28, 4),
 
 	/* PCM */
-	DIV(none, "dout_pcm1", "dout_audio1", DIV_PERIC2, 16, 8),
-	DIV(none, "dout_pcm2", "dout_audio2", DIV_PERIC2, 24, 8),
+	DIV(0, "dout_pcm1", "dout_audio1", DIV_PERIC2, 16, 8),
+	DIV(0, "dout_pcm2", "dout_audio2", DIV_PERIC2, 24, 8),
 
 	/* Audio - I2S */
-	DIV(none, "dout_i2s1", "dout_audio1", DIV_PERIC3, 6, 6),
-	DIV(none, "dout_i2s2", "dout_audio2", DIV_PERIC3, 12, 6),
-	DIV(none, "dout_audio0", "mout_audio0", DIV_PERIC3, 20, 4),
-	DIV(none, "dout_audio1", "mout_audio1", DIV_PERIC3, 24, 4),
-	DIV(none, "dout_audio2", "mout_audio2", DIV_PERIC3, 28, 4),
+	DIV(0, "dout_i2s1", "dout_audio1", DIV_PERIC3, 6, 6),
+	DIV(0, "dout_i2s2", "dout_audio2", DIV_PERIC3, 12, 6),
+	DIV(0, "dout_audio0", "mout_audio0", DIV_PERIC3, 20, 4),
+	DIV(0, "dout_audio1", "mout_audio1", DIV_PERIC3, 24, 4),
+	DIV(0, "dout_audio2", "mout_audio2", DIV_PERIC3, 28, 4),
 
 	/* SPI Pre-Ratio */
-	DIV(none, "dout_pre_spi0", "dout_spi0", DIV_PERIC4, 8, 8),
-	DIV(none, "dout_pre_spi1", "dout_spi1", DIV_PERIC4, 16, 8),
-	DIV(none, "dout_pre_spi2", "dout_spi2", DIV_PERIC4, 24, 8),
+	DIV(0, "dout_pre_spi0", "dout_spi0", DIV_PERIC4, 8, 8),
+	DIV(0, "dout_pre_spi1", "dout_spi1", DIV_PERIC4, 16, 8),
+	DIV(0, "dout_pre_spi2", "dout_spi2", DIV_PERIC4, 24, 8),
 };
 
 static struct samsung_gate_clock exynos5420_gate_clks[] __initdata = {
 	/* TODO: Re-verify the CG bits for all the gate clocks */
-	GATE_A(mct, "pclk_st", "aclk66_psgen", GATE_BUS_PERIS1, 2, 0, 0, "mct"),
+	GATE_A(CLK_MCT, "pclk_st", "aclk66_psgen", GATE_BUS_PERIS1, 2, 0, 0,
+		"mct"),
 
 	GATE(0, "aclk200_fsys", "mout_user_aclk200_fsys",
 			GATE_BUS_FSYS0, 9, CLK_IGNORE_UNUSED, 0),
@@ -545,217 +505,227 @@ static struct samsung_gate_clock exynos5420_gate_clks[] __initdata = {
 			GATE_BUS_TOP, 15, CLK_IGNORE_UNUSED, 0),
 
 	/* sclk */
-	GATE(sclk_uart0, "sclk_uart0", "dout_uart0",
+	GATE(CLK_SCLK_UART0, "sclk_uart0", "dout_uart0",
 		GATE_TOP_SCLK_PERIC, 0, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_uart1, "sclk_uart1", "dout_uart1",
+	GATE(CLK_SCLK_UART1, "sclk_uart1", "dout_uart1",
 		GATE_TOP_SCLK_PERIC, 1, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_uart2, "sclk_uart2", "dout_uart2",
+	GATE(CLK_SCLK_UART2, "sclk_uart2", "dout_uart2",
 		GATE_TOP_SCLK_PERIC, 2, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_uart3, "sclk_uart3", "dout_uart3",
+	GATE(CLK_SCLK_UART3, "sclk_uart3", "dout_uart3",
 		GATE_TOP_SCLK_PERIC, 3, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_spi0, "sclk_spi0", "dout_pre_spi0",
+	GATE(CLK_SCLK_SPI0, "sclk_spi0", "dout_pre_spi0",
 		GATE_TOP_SCLK_PERIC, 6, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_spi1, "sclk_spi1", "dout_pre_spi1",
+	GATE(CLK_SCLK_SPI1, "sclk_spi1", "dout_pre_spi1",
 		GATE_TOP_SCLK_PERIC, 7, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_spi2, "sclk_spi2", "dout_pre_spi2",
+	GATE(CLK_SCLK_SPI2, "sclk_spi2", "dout_pre_spi2",
 		GATE_TOP_SCLK_PERIC, 8, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_spdif, "sclk_spdif", "mout_spdif",
+	GATE(CLK_SCLK_SPDIF, "sclk_spdif", "mout_spdif",
 		GATE_TOP_SCLK_PERIC, 9, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_pwm, "sclk_pwm", "dout_pwm",
+	GATE(CLK_SCLK_PWM, "sclk_pwm", "dout_pwm",
 		GATE_TOP_SCLK_PERIC, 11, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_pcm1, "sclk_pcm1", "dout_pcm1",
+	GATE(CLK_SCLK_PCM1, "sclk_pcm1", "dout_pcm1",
 		GATE_TOP_SCLK_PERIC, 15, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_pcm2, "sclk_pcm2", "dout_pcm2",
+	GATE(CLK_SCLK_PCM2, "sclk_pcm2", "dout_pcm2",
 		GATE_TOP_SCLK_PERIC, 16, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_i2s1, "sclk_i2s1", "dout_i2s1",
+	GATE(CLK_SCLK_I2S1, "sclk_i2s1", "dout_i2s1",
 		GATE_TOP_SCLK_PERIC, 17, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_i2s2, "sclk_i2s2", "dout_i2s2",
+	GATE(CLK_SCLK_I2S2, "sclk_i2s2", "dout_i2s2",
 		GATE_TOP_SCLK_PERIC, 18, CLK_SET_RATE_PARENT, 0),
 
-	GATE(sclk_mmc0, "sclk_mmc0", "dout_mmc0",
+	GATE(CLK_SCLK_MMC0, "sclk_mmc0", "dout_mmc0",
 		GATE_TOP_SCLK_FSYS, 0, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_mmc1, "sclk_mmc1", "dout_mmc1",
+	GATE(CLK_SCLK_MMC1, "sclk_mmc1", "dout_mmc1",
 		GATE_TOP_SCLK_FSYS, 1, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_mmc2, "sclk_mmc2", "dout_mmc2",
+	GATE(CLK_SCLK_MMC2, "sclk_mmc2", "dout_mmc2",
 		GATE_TOP_SCLK_FSYS, 2, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_usbphy301, "sclk_usbphy301", "dout_usbphy301",
+	GATE(CLK_SCLK_USBPHY301, "sclk_usbphy301", "dout_usbphy301",
 		GATE_TOP_SCLK_FSYS, 7, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_usbphy300, "sclk_usbphy300", "dout_usbphy300",
+	GATE(CLK_SCLK_USBPHY300, "sclk_usbphy300", "dout_usbphy300",
 		GATE_TOP_SCLK_FSYS, 8, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_usbd300, "sclk_usbd300", "dout_usbd300",
+	GATE(CLK_SCLK_USBD300, "sclk_usbd300", "dout_usbd300",
 		GATE_TOP_SCLK_FSYS, 9, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_usbd301, "sclk_usbd301", "dout_usbd301",
+	GATE(CLK_SCLK_USBD301, "sclk_usbd301", "dout_usbd301",
 		GATE_TOP_SCLK_FSYS, 10, CLK_SET_RATE_PARENT, 0),
 
-	GATE(sclk_usbd301, "sclk_unipro", "dout_unipro",
+	GATE(CLK_SCLK_USBD301, "sclk_unipro", "dout_unipro",
 		SRC_MASK_FSYS, 24, CLK_SET_RATE_PARENT, 0),
 
-	GATE(sclk_gscl_wa, "sclk_gscl_wa", "aclK333_432_gscl",
+	GATE(CLK_SCLK_GSCL_WA, "sclk_gscl_wa", "aclK333_432_gscl",
 		GATE_TOP_SCLK_GSCL, 6, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_gscl_wb, "sclk_gscl_wb", "aclk333_432_gscl",
+	GATE(CLK_SCLK_GSCL_WB, "sclk_gscl_wb", "aclk333_432_gscl",
 		GATE_TOP_SCLK_GSCL, 7, CLK_SET_RATE_PARENT, 0),
 
 	/* Display */
-	GATE(sclk_fimd1, "sclk_fimd1", "dout_fimd1",
+	GATE(CLK_SCLK_FIMD1, "sclk_fimd1", "dout_fimd1",
 		GATE_TOP_SCLK_DISP1, 0, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_mipi1, "sclk_mipi1", "dout_mipi1",
+	GATE(CLK_SCLK_MIPI1, "sclk_mipi1", "dout_mipi1",
 		GATE_TOP_SCLK_DISP1, 3, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_hdmi, "sclk_hdmi", "mout_hdmi",
+	GATE(CLK_SCLK_HDMI, "sclk_hdmi", "mout_hdmi",
 		GATE_TOP_SCLK_DISP1, 9, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_pixel, "sclk_pixel", "dout_hdmi_pixel",
+	GATE(CLK_SCLK_PIXEL, "sclk_pixel", "dout_hdmi_pixel",
 		GATE_TOP_SCLK_DISP1, 10, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_dp1, "sclk_dp1", "dout_dp1",
+	GATE(CLK_SCLK_DP1, "sclk_dp1", "dout_dp1",
 		GATE_TOP_SCLK_DISP1, 20, CLK_SET_RATE_PARENT, 0),
 
 	/* Maudio Block */
-	GATE(sclk_maudio0, "sclk_maudio0", "dout_maudio0",
+	GATE(CLK_SCLK_MAUDIO0, "sclk_maudio0", "dout_maudio0",
 		GATE_TOP_SCLK_MAU, 0, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_maupcm0, "sclk_maupcm0", "dout_maupcm0",
+	GATE(CLK_SCLK_MAUPCM0, "sclk_maupcm0", "dout_maupcm0",
 		GATE_TOP_SCLK_MAU, 1, CLK_SET_RATE_PARENT, 0),
 	/* FSYS */
-	GATE(tsi, "tsi", "aclk200_fsys", GATE_BUS_FSYS0, 0, 0, 0),
-	GATE(pdma0, "pdma0", "aclk200_fsys", GATE_BUS_FSYS0, 1, 0, 0),
-	GATE(pdma1, "pdma1", "aclk200_fsys", GATE_BUS_FSYS0, 2, 0, 0),
-	GATE(ufs, "ufs", "aclk200_fsys2", GATE_BUS_FSYS0, 3, 0, 0),
-	GATE(rtic, "rtic", "aclk200_fsys", GATE_BUS_FSYS0, 5, 0, 0),
-	GATE(mmc0, "mmc0", "aclk200_fsys2", GATE_BUS_FSYS0, 12, 0, 0),
-	GATE(mmc1, "mmc1", "aclk200_fsys2", GATE_BUS_FSYS0, 13, 0, 0),
-	GATE(mmc2, "mmc2", "aclk200_fsys2", GATE_BUS_FSYS0, 14, 0, 0),
-	GATE(sromc, "sromc", "aclk200_fsys2",
+	GATE(CLK_TSI, "tsi", "aclk200_fsys", GATE_BUS_FSYS0, 0, 0, 0),
+	GATE(CLK_PDMA0, "pdma0", "aclk200_fsys", GATE_BUS_FSYS0, 1, 0, 0),
+	GATE(CLK_PDMA1, "pdma1", "aclk200_fsys", GATE_BUS_FSYS0, 2, 0, 0),
+	GATE(CLK_UFS, "ufs", "aclk200_fsys2", GATE_BUS_FSYS0, 3, 0, 0),
+	GATE(CLK_RTIC, "rtic", "aclk200_fsys", GATE_BUS_FSYS0, 5, 0, 0),
+	GATE(CLK_MMC0, "mmc0", "aclk200_fsys2", GATE_BUS_FSYS0, 12, 0, 0),
+	GATE(CLK_MMC1, "mmc1", "aclk200_fsys2", GATE_BUS_FSYS0, 13, 0, 0),
+	GATE(CLK_MMC2, "mmc2", "aclk200_fsys2", GATE_BUS_FSYS0, 14, 0, 0),
+	GATE(CLK_SROMC, "sromc", "aclk200_fsys2",
 			GATE_BUS_FSYS0, 19, CLK_IGNORE_UNUSED, 0),
-	GATE(usbh20, "usbh20", "aclk200_fsys", GATE_BUS_FSYS0, 20, 0, 0),
-	GATE(usbd300, "usbd300", "aclk200_fsys", GATE_BUS_FSYS0, 21, 0, 0),
-	GATE(usbd301, "usbd301", "aclk200_fsys", GATE_BUS_FSYS0, 28, 0, 0),
+	GATE(CLK_USBH20, "usbh20", "aclk200_fsys", GATE_BUS_FSYS0, 20, 0, 0),
+	GATE(CLK_USBD300, "usbd300", "aclk200_fsys", GATE_BUS_FSYS0, 21, 0, 0),
+	GATE(CLK_USBD301, "usbd301", "aclk200_fsys", GATE_BUS_FSYS0, 28, 0, 0),
 
 	/* UART */
-	GATE(uart0, "uart0", "aclk66_peric", GATE_BUS_PERIC, 4, 0, 0),
-	GATE(uart1, "uart1", "aclk66_peric", GATE_BUS_PERIC, 5, 0, 0),
-	GATE_A(uart2, "uart2", "aclk66_peric",
+	GATE(CLK_UART0, "uart0", "aclk66_peric", GATE_BUS_PERIC, 4, 0, 0),
+	GATE(CLK_UART1, "uart1", "aclk66_peric", GATE_BUS_PERIC, 5, 0, 0),
+	GATE_A(CLK_UART2, "uart2", "aclk66_peric",
 		GATE_BUS_PERIC, 6, CLK_IGNORE_UNUSED, 0, "uart2"),
-	GATE(uart3, "uart3", "aclk66_peric", GATE_BUS_PERIC, 7, 0, 0),
+	GATE(CLK_UART3, "uart3", "aclk66_peric", GATE_BUS_PERIC, 7, 0, 0),
 	/* I2C */
-	GATE(i2c0, "i2c0", "aclk66_peric", GATE_BUS_PERIC, 9, 0, 0),
-	GATE(i2c1, "i2c1", "aclk66_peric", GATE_BUS_PERIC, 10, 0, 0),
-	GATE(i2c2, "i2c2", "aclk66_peric", GATE_BUS_PERIC, 11, 0, 0),
-	GATE(i2c3, "i2c3", "aclk66_peric", GATE_BUS_PERIC, 12, 0, 0),
-	GATE(i2c4, "i2c4", "aclk66_peric", GATE_BUS_PERIC, 13, 0, 0),
-	GATE(i2c5, "i2c5", "aclk66_peric", GATE_BUS_PERIC, 14, 0, 0),
-	GATE(i2c6, "i2c6", "aclk66_peric", GATE_BUS_PERIC, 15, 0, 0),
-	GATE(i2c7, "i2c7", "aclk66_peric", GATE_BUS_PERIC, 16, 0, 0),
-	GATE(i2c_hdmi, "i2c_hdmi", "aclk66_peric", GATE_BUS_PERIC, 17, 0, 0),
-	GATE(tsadc, "tsadc", "aclk66_peric", GATE_BUS_PERIC, 18, 0, 0),
+	GATE(CLK_I2C0, "i2c0", "aclk66_peric", GATE_BUS_PERIC, 9, 0, 0),
+	GATE(CLK_I2C1, "i2c1", "aclk66_peric", GATE_BUS_PERIC, 10, 0, 0),
+	GATE(CLK_I2C2, "i2c2", "aclk66_peric", GATE_BUS_PERIC, 11, 0, 0),
+	GATE(CLK_I2C3, "i2c3", "aclk66_peric", GATE_BUS_PERIC, 12, 0, 0),
+	GATE(CLK_I2C4, "i2c4", "aclk66_peric", GATE_BUS_PERIC, 13, 0, 0),
+	GATE(CLK_I2C5, "i2c5", "aclk66_peric", GATE_BUS_PERIC, 14, 0, 0),
+	GATE(CLK_I2C6, "i2c6", "aclk66_peric", GATE_BUS_PERIC, 15, 0, 0),
+	GATE(CLK_I2C7, "i2c7", "aclk66_peric", GATE_BUS_PERIC, 16, 0, 0),
+	GATE(CLK_I2C_HDMI, "i2c_hdmi", "aclk66_peric", GATE_BUS_PERIC, 17, 0,
+		0),
+	GATE(CLK_TSADC, "tsadc", "aclk66_peric", GATE_BUS_PERIC, 18, 0, 0),
 	/* SPI */
-	GATE(spi0, "spi0", "aclk66_peric", GATE_BUS_PERIC, 19, 0, 0),
-	GATE(spi1, "spi1", "aclk66_peric", GATE_BUS_PERIC, 20, 0, 0),
-	GATE(spi2, "spi2", "aclk66_peric", GATE_BUS_PERIC, 21, 0, 0),
-	GATE(keyif, "keyif", "aclk66_peric", GATE_BUS_PERIC, 22, 0, 0),
+	GATE(CLK_SPI0, "spi0", "aclk66_peric", GATE_BUS_PERIC, 19, 0, 0),
+	GATE(CLK_SPI1, "spi1", "aclk66_peric", GATE_BUS_PERIC, 20, 0, 0),
+	GATE(CLK_SPI2, "spi2", "aclk66_peric", GATE_BUS_PERIC, 21, 0, 0),
+	GATE(CLK_KEYIF, "keyif", "aclk66_peric", GATE_BUS_PERIC, 22, 0, 0),
 	/* I2S */
-	GATE(i2s1, "i2s1", "aclk66_peric", GATE_BUS_PERIC, 23, 0, 0),
-	GATE(i2s2, "i2s2", "aclk66_peric", GATE_BUS_PERIC, 24, 0, 0),
+	GATE(CLK_I2S1, "i2s1", "aclk66_peric", GATE_BUS_PERIC, 23, 0, 0),
+	GATE(CLK_I2S2, "i2s2", "aclk66_peric", GATE_BUS_PERIC, 24, 0, 0),
 	/* PCM */
-	GATE(pcm1, "pcm1", "aclk66_peric", GATE_BUS_PERIC, 25, 0, 0),
-	GATE(pcm2, "pcm2", "aclk66_peric", GATE_BUS_PERIC, 26, 0, 0),
+	GATE(CLK_PCM1, "pcm1", "aclk66_peric", GATE_BUS_PERIC, 25, 0, 0),
+	GATE(CLK_PCM2, "pcm2", "aclk66_peric", GATE_BUS_PERIC, 26, 0, 0),
 	/* PWM */
-	GATE(pwm, "pwm", "aclk66_peric", GATE_BUS_PERIC, 27, 0, 0),
+	GATE(CLK_PWM, "pwm", "aclk66_peric", GATE_BUS_PERIC, 27, 0, 0),
 	/* SPDIF */
-	GATE(spdif, "spdif", "aclk66_peric", GATE_BUS_PERIC, 29, 0, 0),
+	GATE(CLK_SPDIF, "spdif", "aclk66_peric", GATE_BUS_PERIC, 29, 0, 0),
 
-	GATE(i2c8, "i2c8", "aclk66_peric", GATE_BUS_PERIC1, 0, 0, 0),
-	GATE(i2c9, "i2c9", "aclk66_peric", GATE_BUS_PERIC1, 1, 0, 0),
-	GATE(i2c10, "i2c10", "aclk66_peric", GATE_BUS_PERIC1, 2, 0, 0),
+	GATE(CLK_I2C8, "i2c8", "aclk66_peric", GATE_BUS_PERIC1, 0, 0, 0),
+	GATE(CLK_I2C9, "i2c9", "aclk66_peric", GATE_BUS_PERIC1, 1, 0, 0),
+	GATE(CLK_I2C10, "i2c10", "aclk66_peric", GATE_BUS_PERIC1, 2, 0, 0),
 
-	GATE(chipid, "chipid", "aclk66_psgen",
+	GATE(CLK_CHIPID, "chipid", "aclk66_psgen",
 			GATE_BUS_PERIS0, 12, CLK_IGNORE_UNUSED, 0),
-	GATE(sysreg, "sysreg", "aclk66_psgen",
+	GATE(CLK_SYSREG, "sysreg", "aclk66_psgen",
 			GATE_BUS_PERIS0, 13, CLK_IGNORE_UNUSED, 0),
-	GATE(tzpc0, "tzpc0", "aclk66_psgen", GATE_BUS_PERIS0, 18, 0, 0),
-	GATE(tzpc1, "tzpc1", "aclk66_psgen", GATE_BUS_PERIS0, 19, 0, 0),
-	GATE(tzpc2, "tzpc2", "aclk66_psgen", GATE_BUS_PERIS0, 20, 0, 0),
-	GATE(tzpc3, "tzpc3", "aclk66_psgen", GATE_BUS_PERIS0, 21, 0, 0),
-	GATE(tzpc4, "tzpc4", "aclk66_psgen", GATE_BUS_PERIS0, 22, 0, 0),
-	GATE(tzpc5, "tzpc5", "aclk66_psgen", GATE_BUS_PERIS0, 23, 0, 0),
-	GATE(tzpc6, "tzpc6", "aclk66_psgen", GATE_BUS_PERIS0, 24, 0, 0),
-	GATE(tzpc7, "tzpc7", "aclk66_psgen", GATE_BUS_PERIS0, 25, 0, 0),
-	GATE(tzpc8, "tzpc8", "aclk66_psgen", GATE_BUS_PERIS0, 26, 0, 0),
-	GATE(tzpc9, "tzpc9", "aclk66_psgen", GATE_BUS_PERIS0, 27, 0, 0),
-
-	GATE(hdmi_cec, "hdmi_cec", "aclk66_psgen", GATE_BUS_PERIS1, 0, 0, 0),
-	GATE(seckey, "seckey", "aclk66_psgen", GATE_BUS_PERIS1, 1, 0, 0),
-	GATE(wdt, "wdt", "aclk66_psgen", GATE_BUS_PERIS1, 3, 0, 0),
-	GATE(rtc, "rtc", "aclk66_psgen", GATE_BUS_PERIS1, 4, 0, 0),
-	GATE(tmu, "tmu", "aclk66_psgen", GATE_BUS_PERIS1, 5, 0, 0),
-	GATE(tmu_gpu, "tmu_gpu", "aclk66_psgen", GATE_BUS_PERIS1, 6, 0, 0),
-
-	GATE(gscl0, "gscl0", "aclk300_gscl", GATE_IP_GSCL0, 0, 0, 0),
-	GATE(gscl1, "gscl1", "aclk300_gscl", GATE_IP_GSCL0, 1, 0, 0),
-	GATE(clk_3aa, "clk_3aa", "aclk300_gscl", GATE_IP_GSCL0, 4, 0, 0),
-
-	GATE(smmu_3aa, "smmu_3aa", "aclk333_432_gscl", GATE_IP_GSCL1, 2, 0, 0),
-	GATE(smmu_fimcl0, "smmu_fimcl0", "aclk333_432_gscl",
+	GATE(CLK_TZPC0, "tzpc0", "aclk66_psgen", GATE_BUS_PERIS0, 18, 0, 0),
+	GATE(CLK_TZPC1, "tzpc1", "aclk66_psgen", GATE_BUS_PERIS0, 19, 0, 0),
+	GATE(CLK_TZPC2, "tzpc2", "aclk66_psgen", GATE_BUS_PERIS0, 20, 0, 0),
+	GATE(CLK_TZPC3, "tzpc3", "aclk66_psgen", GATE_BUS_PERIS0, 21, 0, 0),
+	GATE(CLK_TZPC4, "tzpc4", "aclk66_psgen", GATE_BUS_PERIS0, 22, 0, 0),
+	GATE(CLK_TZPC5, "tzpc5", "aclk66_psgen", GATE_BUS_PERIS0, 23, 0, 0),
+	GATE(CLK_TZPC6, "tzpc6", "aclk66_psgen", GATE_BUS_PERIS0, 24, 0, 0),
+	GATE(CLK_TZPC7, "tzpc7", "aclk66_psgen", GATE_BUS_PERIS0, 25, 0, 0),
+	GATE(CLK_TZPC8, "tzpc8", "aclk66_psgen", GATE_BUS_PERIS0, 26, 0, 0),
+	GATE(CLK_TZPC9, "tzpc9", "aclk66_psgen", GATE_BUS_PERIS0, 27, 0, 0),
+
+	GATE(CLK_HDMI_CEC, "hdmi_cec", "aclk66_psgen", GATE_BUS_PERIS1, 0, 0,
+		0),
+	GATE(CLK_SECKEY, "seckey", "aclk66_psgen", GATE_BUS_PERIS1, 1, 0, 0),
+	GATE(CLK_WDT, "wdt", "aclk66_psgen", GATE_BUS_PERIS1, 3, 0, 0),
+	GATE(CLK_RTC, "rtc", "aclk66_psgen", GATE_BUS_PERIS1, 4, 0, 0),
+	GATE(CLK_TMU, "tmu", "aclk66_psgen", GATE_BUS_PERIS1, 5, 0, 0),
+	GATE(CLK_TMU_GPU, "tmu_gpu", "aclk66_psgen", GATE_BUS_PERIS1, 6, 0, 0),
+
+	GATE(CLK_GSCL0, "gscl0", "aclk300_gscl", GATE_IP_GSCL0, 0, 0, 0),
+	GATE(CLK_GSCL1, "gscl1", "aclk300_gscl", GATE_IP_GSCL0, 1, 0, 0),
+	GATE(CLK_CLK_3AA, "clk_3aa", "aclk300_gscl", GATE_IP_GSCL0, 4, 0, 0),
+
+	GATE(CLK_SMMU_3AA, "smmu_3aa", "aclk333_432_gscl", GATE_IP_GSCL1, 2, 0,
+		0),
+	GATE(CLK_SMMU_FIMCL0, "smmu_fimcl0", "aclk333_432_gscl",
 			GATE_IP_GSCL1, 3, 0, 0),
-	GATE(smmu_fimcl1, "smmu_fimcl1", "aclk333_432_gscl",
+	GATE(CLK_SMMU_FIMCL1, "smmu_fimcl1", "aclk333_432_gscl",
 			GATE_IP_GSCL1, 4, 0, 0),
-	GATE(smmu_gscl0, "smmu_gscl0", "aclk300_gscl", GATE_IP_GSCL1, 6, 0, 0),
-	GATE(smmu_gscl1, "smmu_gscl1", "aclk300_gscl", GATE_IP_GSCL1, 7, 0, 0),
-	GATE(gscl_wa, "gscl_wa", "aclk300_gscl", GATE_IP_GSCL1, 12, 0, 0),
-	GATE(gscl_wb, "gscl_wb", "aclk300_gscl", GATE_IP_GSCL1, 13, 0, 0),
-	GATE(smmu_fimcl3, "smmu_fimcl3,", "aclk333_432_gscl",
+	GATE(CLK_SMMU_GSCL0, "smmu_gscl0", "aclk300_gscl", GATE_IP_GSCL1, 6, 0,
+		0),
+	GATE(CLK_SMMU_GSCL1, "smmu_gscl1", "aclk300_gscl", GATE_IP_GSCL1, 7, 0,
+		0),
+	GATE(CLK_GSCL_WA, "gscl_wa", "aclk300_gscl", GATE_IP_GSCL1, 12, 0, 0),
+	GATE(CLK_GSCL_WB, "gscl_wb", "aclk300_gscl", GATE_IP_GSCL1, 13, 0, 0),
+	GATE(CLK_SMMU_FIMCL3, "smmu_fimcl3,", "aclk333_432_gscl",
 			GATE_IP_GSCL1, 16, 0, 0),
-	GATE(fimc_lite3, "fimc_lite3", "aclk333_432_gscl",
+	GATE(CLK_FIMC_LITE3, "fimc_lite3", "aclk333_432_gscl",
 			GATE_IP_GSCL1, 17, 0, 0),
 
-	GATE(fimd1, "fimd1", "aclk300_disp1", GATE_IP_DISP1, 0, 0, 0),
-	GATE(dsim1, "dsim1", "aclk200_disp1", GATE_IP_DISP1, 3, 0, 0),
-	GATE(dp1, "dp1", "aclk200_disp1", GATE_IP_DISP1, 4, 0, 0),
-	GATE(mixer, "mixer", "aclk166", GATE_IP_DISP1, 5, 0, 0),
-	GATE(hdmi, "hdmi", "aclk200_disp1", GATE_IP_DISP1, 6, 0, 0),
-	GATE(smmu_fimd1, "smmu_fimd1", "aclk300_disp1", GATE_IP_DISP1, 8, 0, 0),
-
-	GATE(mfc, "mfc", "aclk333", GATE_IP_MFC, 0, 0, 0),
-	GATE(smmu_mfcl, "smmu_mfcl", "aclk333", GATE_IP_MFC, 1, 0, 0),
-	GATE(smmu_mfcr, "smmu_mfcr", "aclk333", GATE_IP_MFC, 2, 0, 0),
-
-	GATE(g3d, "g3d", "aclkg3d", GATE_IP_G3D, 9, 0, 0),
-
-	GATE(rotator, "rotator", "aclk266", GATE_IP_GEN, 1, 0, 0),
-	GATE(jpeg, "jpeg", "aclk300_jpeg", GATE_IP_GEN, 2, 0, 0),
-	GATE(jpeg2, "jpeg2", "aclk300_jpeg", GATE_IP_GEN, 3, 0, 0),
-	GATE(mdma1, "mdma1", "aclk266", GATE_IP_GEN, 4, 0, 0),
-	GATE(smmu_rotator, "smmu_rotator", "aclk266", GATE_IP_GEN, 6, 0, 0),
-	GATE(smmu_jpeg, "smmu_jpeg", "aclk300_jpeg", GATE_IP_GEN, 7, 0, 0),
-	GATE(smmu_mdma1, "smmu_mdma1", "aclk266", GATE_IP_GEN, 9, 0, 0),
-
-	GATE(mscl0, "mscl0", "aclk400_mscl", GATE_IP_MSCL, 0, 0, 0),
-	GATE(mscl1, "mscl1", "aclk400_mscl", GATE_IP_MSCL, 1, 0, 0),
-	GATE(mscl2, "mscl2", "aclk400_mscl", GATE_IP_MSCL, 2, 0, 0),
-	GATE(smmu_mscl0, "smmu_mscl0", "aclk400_mscl", GATE_IP_MSCL, 8, 0, 0),
-	GATE(smmu_mscl1, "smmu_mscl1", "aclk400_mscl", GATE_IP_MSCL, 9, 0, 0),
-	GATE(smmu_mscl2, "smmu_mscl2", "aclk400_mscl", GATE_IP_MSCL, 10, 0, 0),
-	GATE(smmu_mixer, "smmu_mixer", "aclk200_disp1", GATE_IP_DISP1, 9, 0, 0),
+	GATE(CLK_FIMD1, "fimd1", "aclk300_disp1", GATE_IP_DISP1, 0, 0, 0),
+	GATE(CLK_DSIM1, "dsim1", "aclk200_disp1", GATE_IP_DISP1, 3, 0, 0),
+	GATE(CLK_DP1, "dp1", "aclk200_disp1", GATE_IP_DISP1, 4, 0, 0),
+	GATE(CLK_MIXER, "mixer", "aclk166", GATE_IP_DISP1, 5, 0, 0),
+	GATE(CLK_HDMI, "hdmi", "aclk200_disp1", GATE_IP_DISP1, 6, 0, 0),
+	GATE(CLK_SMMU_FIMD1, "smmu_fimd1", "aclk300_disp1", GATE_IP_DISP1, 8, 0,
+		0),
+
+	GATE(CLK_MFC, "mfc", "aclk333", GATE_IP_MFC, 0, 0, 0),
+	GATE(CLK_SMMU_MFCL, "smmu_mfcl", "aclk333", GATE_IP_MFC, 1, 0, 0),
+	GATE(CLK_SMMU_MFCR, "smmu_mfcr", "aclk333", GATE_IP_MFC, 2, 0, 0),
+
+	GATE(CLK_G3D, "g3d", "aclkg3d", GATE_IP_G3D, 9, 0, 0),
+
+	GATE(CLK_ROTATOR, "rotator", "aclk266", GATE_IP_GEN, 1, 0, 0),
+	GATE(CLK_JPEG, "jpeg", "aclk300_jpeg", GATE_IP_GEN, 2, 0, 0),
+	GATE(CLK_JPEG2, "jpeg2", "aclk300_jpeg", GATE_IP_GEN, 3, 0, 0),
+	GATE(CLK_MDMA1, "mdma1", "aclk266", GATE_IP_GEN, 4, 0, 0),
+	GATE(CLK_SMMU_ROTATOR, "smmu_rotator", "aclk266", GATE_IP_GEN, 6, 0, 0),
+	GATE(CLK_SMMU_JPEG, "smmu_jpeg", "aclk300_jpeg", GATE_IP_GEN, 7, 0, 0),
+	GATE(CLK_SMMU_MDMA1, "smmu_mdma1", "aclk266", GATE_IP_GEN, 9, 0, 0),
+
+	GATE(CLK_MSCL0, "mscl0", "aclk400_mscl", GATE_IP_MSCL, 0, 0, 0),
+	GATE(CLK_MSCL1, "mscl1", "aclk400_mscl", GATE_IP_MSCL, 1, 0, 0),
+	GATE(CLK_MSCL2, "mscl2", "aclk400_mscl", GATE_IP_MSCL, 2, 0, 0),
+	GATE(CLK_SMMU_MSCL0, "smmu_mscl0", "aclk400_mscl", GATE_IP_MSCL, 8, 0,
+		0),
+	GATE(CLK_SMMU_MSCL1, "smmu_mscl1", "aclk400_mscl", GATE_IP_MSCL, 9, 0,
+		0),
+	GATE(CLK_SMMU_MSCL2, "smmu_mscl2", "aclk400_mscl", GATE_IP_MSCL, 10, 0,
+		0),
+	GATE(CLK_SMMU_MIXER, "smmu_mixer", "aclk200_disp1", GATE_IP_DISP1, 9, 0,
+		0),
 };
 
 static struct samsung_pll_clock exynos5420_plls[nr_plls] __initdata = {
-	[apll] = PLL(pll_2550, fout_apll, "fout_apll", "fin_pll", APLL_LOCK,
+	[apll] = PLL(pll_2550, CLK_FOUT_APLL, "fout_apll", "fin_pll", APLL_LOCK,
 		APLL_CON0, NULL),
-	[cpll] = PLL(pll_2550, fout_mpll, "fout_mpll", "fin_pll", MPLL_LOCK,
+	[cpll] = PLL(pll_2550, CLK_FOUT_MPLL, "fout_mpll", "fin_pll", MPLL_LOCK,
 		MPLL_CON0, NULL),
-	[dpll] = PLL(pll_2550, fout_dpll, "fout_dpll", "fin_pll", DPLL_LOCK,
+	[dpll] = PLL(pll_2550, CLK_FOUT_DPLL, "fout_dpll", "fin_pll", DPLL_LOCK,
 		DPLL_CON0, NULL),
-	[epll] = PLL(pll_2650, fout_epll, "fout_epll", "fin_pll", EPLL_LOCK,
+	[epll] = PLL(pll_2650, CLK_FOUT_EPLL, "fout_epll", "fin_pll", EPLL_LOCK,
 		EPLL_CON0, NULL),
-	[rpll] = PLL(pll_2650, fout_rpll, "fout_rpll", "fin_pll", RPLL_LOCK,
+	[rpll] = PLL(pll_2650, CLK_FOUT_RPLL, "fout_rpll", "fin_pll", RPLL_LOCK,
 		RPLL_CON0, NULL),
-	[ipll] = PLL(pll_2550, fout_ipll, "fout_ipll", "fin_pll", IPLL_LOCK,
+	[ipll] = PLL(pll_2550, CLK_FOUT_IPLL, "fout_ipll", "fin_pll", IPLL_LOCK,
 		IPLL_CON0, NULL),
-	[spll] = PLL(pll_2550, fout_spll, "fout_spll", "fin_pll", SPLL_LOCK,
+	[spll] = PLL(pll_2550, CLK_FOUT_SPLL, "fout_spll", "fin_pll", SPLL_LOCK,
 		SPLL_CON0, NULL),
-	[vpll] = PLL(pll_2550, fout_vpll, "fout_vpll", "fin_pll", VPLL_LOCK,
+	[vpll] = PLL(pll_2550, CLK_FOUT_VPLL, "fout_vpll", "fin_pll", VPLL_LOCK,
 		VPLL_CON0, NULL),
-	[mpll] = PLL(pll_2550, fout_mpll, "fout_mpll", "fin_pll", MPLL_LOCK,
+	[mpll] = PLL(pll_2550, CLK_FOUT_MPLL, "fout_mpll", "fin_pll", MPLL_LOCK,
 		MPLL_CON0, NULL),
-	[bpll] = PLL(pll_2550, fout_bpll, "fout_bpll", "fin_pll", BPLL_LOCK,
+	[bpll] = PLL(pll_2550, CLK_FOUT_BPLL, "fout_bpll", "fin_pll", BPLL_LOCK,
 		BPLL_CON0, NULL),
-	[kpll] = PLL(pll_2550, fout_kpll, "fout_kpll", "fin_pll", KPLL_LOCK,
+	[kpll] = PLL(pll_2550, CLK_FOUT_KPLL, "fout_kpll", "fin_pll", KPLL_LOCK,
 		KPLL_CON0, NULL),
 };
 
@@ -777,7 +747,7 @@ static void __init exynos5420_clk_init(struct device_node *np)
 		panic("%s: unable to determine soc\n", __func__);
 	}
 
-	samsung_clk_init(np, reg_base, nr_clks,
+	samsung_clk_init(np, reg_base, CLK_NR_CLKS,
 			exynos5420_clk_regs, ARRAY_SIZE(exynos5420_clk_regs),
 			NULL, 0);
 	samsung_clk_of_register_fixed_ext(exynos5420_fixed_rate_ext_clks,
-- 
1.8.1.2
