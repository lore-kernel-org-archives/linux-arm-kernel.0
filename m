From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Fri, 20 Dec 2013 18:27:26 +0530
Subject: [PATCH 3/3] clk/exynos5420: replace enums with macros as clock ids
In-Reply-To: <1387544246-31658-1-git-send-email-rahul.sharma@samsung.com>
References: <1387544246-31658-1-git-send-email-rahul.sharma@samsung.com>
Message-ID: <1387544246-31658-4-git-send-email-rahul.sharma@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In clock file for exynos5420, clock IDs are enums.
These are replaced with macros and used in DT file.

Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
---
 drivers/clk/samsung/clk-exynos5420.c     |  889 ++++++++++++++----------------
 include/dt-bindings/clk/exynos5420-clk.h |  236 ++++++++
 2 files changed, 646 insertions(+), 479 deletions(-)
 create mode 100644 include/dt-bindings/clk/exynos5420-clk.h

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index c90382f..cc8db67 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -18,6 +18,7 @@
 #include <linux/syscore_ops.h>
 
 #include "clk.h"
+#include <dt-bindings/clk/exynos5420-clk.h>
 
 #define APLL_LOCK		0x0
 #define APLL_CON0		0x100
@@ -135,76 +136,6 @@ enum exynos5420_plls {
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
-	sclk_pwm, sclk_gscl_wa, sclk_gscl_wb, sclk_hdmiphy, sclk_mphy_refclk,
-	sclk_spi0_isp, sclk_spi1_isp, sclk_uart_isp, sclk_isp_sensor0,
-	sclk_isp_sensor1, sclk_isp_sensor2, sclk_pwm_isp, sclk_hsic_12m,
-	sclk_mphy_ixtal24,
-
-	/* gate clocks */
-	aclk66_peric = 256, pclk_uart0, pclk_uart1, pclk_uart2,
-	pclk_uart3, pclk_i2c0, pclk_i2c1, pclk_i2c2, pclk_i2c3,
-	pclk_usi0, pclk_usi1, pclk_usi2, pclk_usi3, pclk_i2c_hdmi,
-	pclk_tsadc, pclk_spi0, pclk_spi1, pclk_spi2, pclk_i2s1,
-	pclk_i2s2, pclk_pcm1, pclk_pcm2, pclk_pwm,
-	pclk_spdif, pclk_usi4, pclk_usi5, pclk_usi6,
-	aclk66_psgen = 300, pclk_chipid, pclk_sysreg, pclk_tzpc0, pclk_tzpc1,
-	pclk_tzpc2, pclk_tzpc3, pclk_tzpc4, pclk_tzpc5, pclk_tzpc6,
-	pclk_tzpc7, pclk_tzpc8, pclk_tzpc9, hdmi_cec, seckey, pclk_mct,
-	pclk_wdt, pclk_rtc, pclk_tmu, pclk_tmu_gpu,
-	pclk66_gpio = 330,
-	aclk200_fsys2 = 350, aclk_mmc0, aclk_mmc1, aclk_mmc2, hclk_sromc, ufs,
-	aclk200_fsys = 360, aclk_pdma0, aclk_pdma1, aclk_rtic,
-	hclk_usbh20, hclk_usbd300, hclk_usbd301,
-	pclk200_fsys = 370,
-	aclk400_mscl = 380, aclk_mscl0, aclk_mscl1, aclk_mscl2, smmu_mscl0,
-	smmu_mscl1, smmu_mscl2,
-	aclk333 = 400, aclk_mfc, smmu_mfcl, smmu_mfcr,
-	aclk200_disp1 = 410, pclk_dsim1, pclk_dp1, pclk_hdmi,
-	aclk300_disp1 = 420, aclk_fimd1, smmu_fimd1m0, smmu_fimd1m1,
-	aclk400_disp1,
-	aclk166 = 430, aclk_mixer,
-	aclk266 = 440, aclk_rotator, aclk_mdma1, smmu_rotator, smmu_mdma1,
-	aclk300_jpeg = 450, aclk_jpeg, aclk_jpeg2, smmu_jpeg,
-	aclk300_gscl = 460, smmu_gscl0, smmu_gscl1, pclk_gscl_wa,
-	aclk_gscl0 = 465, aclk_gscl1, aclk_fimc_3aa,
-	aclk266_g2d = 470, aclk_sss, aclk_slim_sss, aclk_mdma0,
-	aclk333_g2d = 480, aclk_g2d,
-	aclk333_432_gscl = 490, smmu_3aa, smmu_fimcl0, smmu_fimcl1, smmu_fimcl3,
-	aclk_fimc_lite3,
-	clk_g3d = 500, smmu_mixer, pclk_tzpc10, pclk_tzpc11, pclk_mc,
-	pclk_top_rtc, smmu_jpeg2, pclk_rotator, smmu_rtic, pclk_g2d,
-	aclk_smmu_g2d, smmu_g2d, aclk_smmu_mdma0, smmu_mdma0, aclk_smmu_sss,
-	smmu_sss, smmu_slim_sss, aclk_smmu_slim_sss, aclk266_isp, aclk400_isp,
-	aclk333_432_isp0, aclk333_432_isp, aclk_smmu_mixer, pclk_hdmiphy,
-	pclk_gscl0, pclk_gscl1, pclk_fimc_3aa, aclk_fimc_lite0, aclk_fimc_lite1,
-	pclk_fimc_lite0, pclk_fimc_lite1, pclk_fimc_lite3, pclk_mscl0,
-	pclk_mscl1, pclk_mscl2, pclk_mfc,
-
-	/* mux clocks */
-	mout_hdmi = 640, mout_fimd1, mout_maudio0, mout_spi0, mout_spi1,
-	mout_spi2, mout_sw_aclk333, mout_user_aclk333, mout_sw_aclk300_gscl,
-	mout_user_aclk300_gscl, mout_sw_aclk333_432_gscl,
-	mout_user_aclk333_432_gscl, mout_g3d,
-
-	/* divider clocks */
-	dout_pixel = 768,
-
-	nr_clks,
-};
-
 static void __iomem *reg_base;
 
 #ifdef CONFIG_PM_SLEEP
@@ -460,617 +391,617 @@ PNAME(mout_mau_epll_clk_p) = {"mout_sclk_epll", "mout_sclk_dpll",
 
 /* fixed rate clocks generated outside the soc */
 static struct samsung_fixed_rate_clock exynos5420_fixed_rate_ext_clks[] __initdata = {
-	FRATE(fin_pll, "fin_pll", NULL, CLK_IS_ROOT, 0),
-	FRATE(none, "cdclk0", NULL, CLK_IS_ROOT, 0),
-	FRATE(none, "cdclk1", NULL, CLK_IS_ROOT, 0),
+	FRATE(FIN_PLL, "fin_pll", NULL, CLK_IS_ROOT, 0),
+	FRATE(NONE, "cdclk0", NULL, CLK_IS_ROOT, 0),
+	FRATE(NONE, "cdclk1", NULL, CLK_IS_ROOT, 0),
 };
 
 /* fixed rate clocks generated inside the soc */
 static struct samsung_fixed_rate_clock exynos5420_fixed_rate_clks[] __initdata = {
-	FRATE(sclk_hdmiphy, "sclk_hdmiphy", NULL, CLK_IS_ROOT, 24000000),
-	FRATE(none, "sclk_pwi", NULL, CLK_IS_ROOT, 24000000),
-	FRATE(none, "sclk_usbh20", NULL, CLK_IS_ROOT, 48000000),
-	FRATE(none, "mphy_refclk_ixtal24", NULL, CLK_IS_ROOT, 48000000),
-	FRATE(none, "sclk_usbh20_scan_clk", NULL, CLK_IS_ROOT, 480000000),
+	FRATE(SCLK_HDMIPHY, "sclk_hdmiphy", NULL, CLK_IS_ROOT, 24000000),
+	FRATE(NONE, "sclk_pwi", NULL, CLK_IS_ROOT, 24000000),
+	FRATE(NONE, "sclk_usbh20", NULL, CLK_IS_ROOT, 48000000),
+	FRATE(NONE, "mphy_refclk_ixtal24", NULL, CLK_IS_ROOT, 48000000),
+	FRATE(NONE, "sclk_usbh20_scan_clk", NULL, CLK_IS_ROOT, 480000000),
 };
 
 static struct samsung_fixed_factor_clock exynos5420_fixed_factor_clks[] __initdata = {
-	FFACTOR(none, "ffactor_hsic_12m", "fin_pll", 1, 2, 0),
-	FFACTOR(none, "ffactor_sw_aclk66", "mout_sw_aclk66", 1, 2, 0),
+	FFACTOR(NONE, "ffactor_hsic_12m", "fin_pll", 1, 2, 0),
+	FFACTOR(NONE, "ffactor_sw_aclk66", "mout_sw_aclk66", 1, 2, 0),
 };
 
 static struct samsung_mux_clock exynos5420_mux_clks[] __initdata = {
-	MUX(none, "mout_mspll_kfc", mout_mspll_cpu_p, SRC_TOP7, 8, 2),
-	MUX(none, "mout_mspll_cpu", mout_mspll_cpu_p, SRC_TOP7, 12, 2),
-	MUX(none, "mout_apll", mout_apll_p, SRC_CPU, 0, 1),
-	MUX(none, "mout_cpu", mout_cpu_p, SRC_CPU, 16, 1),
-	MUX(none, "mout_kpll", mout_kpll_p, SRC_KFC, 0, 1),
-	MUX(none, "mout_kfc", mout_kfc_p, SRC_KFC, 16, 1),
+	MUX(NONE, "mout_mspll_kfc", mout_mspll_cpu_p, SRC_TOP7, 8, 2),
+	MUX(NONE, "mout_mspll_cpu", mout_mspll_cpu_p, SRC_TOP7, 12, 2),
+	MUX(NONE, "mout_apll", mout_apll_p, SRC_CPU, 0, 1),
+	MUX(NONE, "mout_cpu", mout_cpu_p, SRC_CPU, 16, 1),
+	MUX(NONE, "mout_kpll", mout_kpll_p, SRC_KFC, 0, 1),
+	MUX(NONE, "mout_kfc", mout_kfc_p, SRC_KFC, 16, 1),
 
-	MUX(none, "sclk_bpll", mout_bpll_p, TOP_SPARE2, 0, 1),
+	MUX(NONE, "sclk_bpll", mout_bpll_p, TOP_SPARE2, 0, 1),
 
-	MUX_A(none, "mout_aclk400_mscl", mout_group1_p,
+	MUX_A(NONE, "mout_aclk400_mscl", mout_group1_p,
 			SRC_TOP0, 4, 2, "aclk400_mscl"),
-	MUX(none, "mout_aclk200", mout_group1_p, SRC_TOP0, 8, 2),
-	MUX(none, "mout_aclk200_fsys2", mout_group1_p, SRC_TOP0, 12, 2),
-	MUX(none, "mout_aclk200_fsys", mout_group1_p, SRC_TOP0, 28, 2),
-
-	MUX(none, "mout_aclk333_432_gscl", mout_group4_p, SRC_TOP1, 0, 2),
-	MUX(none, "mout_aclk66", mout_group1_p, SRC_TOP1, 8, 2),
-	MUX(none, "mout_aclk266", mout_group1_p, SRC_TOP1, 20, 2),
-	MUX(none, "mout_aclk166", mout_group1_p, SRC_TOP1, 24, 2),
-	MUX(none, "mout_aclk333", mout_group1_p, SRC_TOP1, 28, 2),
-
-	MUX(none, "mout_aclk333_g2d", mout_group1_p, SRC_TOP2, 8, 2),
-	MUX(none, "mout_aclk266_g2d", mout_group1_p, SRC_TOP2, 12, 2),
-	MUX(none, "mout_aclk_g3d", mout_group5_p, SRC_TOP2, 16, 1),
-	MUX(none, "mout_aclk300_jpeg", mout_group1_p, SRC_TOP2, 20, 2),
-	MUX(none, "mout_aclk300_disp1", mout_group1_p, SRC_TOP2, 24, 2),
-	MUX(none, "mout_aclk300_gscl", mout_group1_p, SRC_TOP2, 28, 2),
-
-	MUX(none, "mout_user_aclk400_mscl", mout_user_aclk400_mscl_p,
+	MUX(NONE, "mout_aclk200", mout_group1_p, SRC_TOP0, 8, 2),
+	MUX(NONE, "mout_aclk200_fsys2", mout_group1_p, SRC_TOP0, 12, 2),
+	MUX(NONE, "mout_aclk200_fsys", mout_group1_p, SRC_TOP0, 28, 2),
+
+	MUX(NONE, "mout_aclk333_432_gscl", mout_group4_p, SRC_TOP1, 0, 2),
+	MUX(NONE, "mout_aclk66", mout_group1_p, SRC_TOP1, 8, 2),
+	MUX(NONE, "mout_aclk266", mout_group1_p, SRC_TOP1, 20, 2),
+	MUX(NONE, "mout_aclk166", mout_group1_p, SRC_TOP1, 24, 2),
+	MUX(NONE, "mout_aclk333", mout_group1_p, SRC_TOP1, 28, 2),
+
+	MUX(NONE, "mout_aclk333_g2d", mout_group1_p, SRC_TOP2, 8, 2),
+	MUX(NONE, "mout_aclk266_g2d", mout_group1_p, SRC_TOP2, 12, 2),
+	MUX(NONE, "mout_aclk_g3d", mout_group5_p, SRC_TOP2, 16, 1),
+	MUX(NONE, "mout_aclk300_jpeg", mout_group1_p, SRC_TOP2, 20, 2),
+	MUX(NONE, "mout_aclk300_disp1", mout_group1_p, SRC_TOP2, 24, 2),
+	MUX(NONE, "mout_aclk300_gscl", mout_group1_p, SRC_TOP2, 28, 2),
+
+	MUX(NONE, "mout_user_aclk400_mscl", mout_user_aclk400_mscl_p,
 			SRC_TOP3, 4, 1),
-	MUX(none, "mout_aclk200_disp1", mout_aclk200_disp1_p, SRC_TOP3, 8, 1),
-	MUX(none, "mout_user_aclk200_fsys2", mout_user_aclk200_fsys2_p,
+	MUX(NONE, "mout_aclk200_disp1", mout_aclk200_disp1_p, SRC_TOP3, 8, 1),
+	MUX(NONE, "mout_user_aclk200_fsys2", mout_user_aclk200_fsys2_p,
 			SRC_TOP3, 12, 1),
-	MUX(none, "mout_user_aclk200_fsys", mout_user_aclk200_fsys_p,
+	MUX(NONE, "mout_user_aclk200_fsys", mout_user_aclk200_fsys_p,
 			SRC_TOP3, 28, 1),
 
-	MUX(mout_user_aclk333_432_gscl, "mout_user_aclk333_432_gscl",
+	MUX(MOUT_USER_ACLK333_432_GSCL, "mout_user_aclk333_432_gscl",
 			 mout_user_aclk333_432_gscl_p, SRC_TOP4, 0, 1),
-	MUX(none, "mout_user_aclk66_peric", mout_user_aclk66_peric_p,
+	MUX(NONE, "mout_user_aclk66_peric", mout_user_aclk66_peric_p,
 			SRC_TOP4, 8, 1),
-	MUX(none, "mout_user_aclk266", mout_user_aclk266_p, SRC_TOP4, 20, 1),
-	MUX(none, "mout_user_aclk166", mout_user_aclk166_p, SRC_TOP4, 24, 1),
-	MUX(mout_user_aclk333, "mout_user_aclk333", mout_user_aclk333_p,
+	MUX(NONE, "mout_user_aclk266", mout_user_aclk266_p, SRC_TOP4, 20, 1),
+	MUX(NONE, "mout_user_aclk166", mout_user_aclk166_p, SRC_TOP4, 24, 1),
+	MUX(MOUT_USER_ACLK333, "mout_user_aclk333", mout_user_aclk333_p,
 			SRC_TOP4, 28, 1),
 
-	MUX(none, "mout_user_aclk66_psgen", mout_user_aclk66_peric_p, SRC_TOP5,
+	MUX(NONE, "mout_user_aclk66_psgen", mout_user_aclk66_peric_p, SRC_TOP5,
 			4, 1),
-	MUX(none, "mout_user_aclk333_g2d", mout_user_aclk333_g2d_p, SRC_TOP5,
+	MUX(NONE, "mout_user_aclk333_g2d", mout_user_aclk333_g2d_p, SRC_TOP5,
 			8, 1),
-	MUX(none, "mout_user_aclk266_g2d", mout_user_aclk266_g2d_p, SRC_TOP5,
+	MUX(NONE, "mout_user_aclk266_g2d", mout_user_aclk266_g2d_p, SRC_TOP5,
 			12, 1),
-	MUX(mout_g3d, "mout_user_aclk_g3d", mout_user_aclk_g3d_p,
+	MUX(MOUT_G3D, "mout_user_aclk_g3d", mout_user_aclk_g3d_p,
 			SRC_TOP5, 16, 1),
-	MUX(none, "mout_user_aclk300_jpeg", mout_user_aclk300_jpeg_p,
+	MUX(NONE, "mout_user_aclk300_jpeg", mout_user_aclk300_jpeg_p,
 			SRC_TOP5, 20, 1),
-	MUX(none, "mout_user_aclk300_disp1", mout_user_aclk300_disp1_p,
+	MUX(NONE, "mout_user_aclk300_disp1", mout_user_aclk300_disp1_p,
 			SRC_TOP5, 24, 1),
-	MUX(mout_user_aclk300_gscl, "mout_user_aclk300_gscl",
+	MUX(MOUT_USER_ACLK300_GSCL, "mout_user_aclk300_gscl",
 			mout_user_aclk300_gscl_p, SRC_TOP5, 28, 1),
 
-	MUX(none, "mout_sclk_mpll", mout_mpll_p, SRC_TOP6, 0, 1),
-	MUX(none, "mout_sclk_vpll", mout_vpll_p, SRC_TOP6, 4, 1),
-	MUX(none, "mout_sclk_spll", mout_spll_p, SRC_TOP6, 8, 1),
-	MUX(none, "mout_sclk_ipll", mout_ipll_p, SRC_TOP6, 12, 1),
-	MUX(none, "mout_sclk_rpll", mout_rpll_p, SRC_TOP6, 16, 1),
-	MUX(none, "mout_sclk_epll", mout_epll_p, SRC_TOP6, 20, 1),
-	MUX(none, "mout_sclk_dpll", mout_dpll_p, SRC_TOP6, 24, 1),
-	MUX(none, "mout_sclk_cpll", mout_cpll_p, SRC_TOP6, 28, 1),
+	MUX(NONE, "mout_sclk_mpll", mout_mpll_p, SRC_TOP6, 0, 1),
+	MUX(NONE, "mout_sclk_vpll", mout_vpll_p, SRC_TOP6, 4, 1),
+	MUX(NONE, "mout_sclk_spll", mout_spll_p, SRC_TOP6, 8, 1),
+	MUX(NONE, "mout_sclk_ipll", mout_ipll_p, SRC_TOP6, 12, 1),
+	MUX(NONE, "mout_sclk_rpll", mout_rpll_p, SRC_TOP6, 16, 1),
+	MUX(NONE, "mout_sclk_epll", mout_epll_p, SRC_TOP6, 20, 1),
+	MUX(NONE, "mout_sclk_dpll", mout_dpll_p, SRC_TOP6, 24, 1),
+	MUX(NONE, "mout_sclk_cpll", mout_cpll_p, SRC_TOP6, 28, 1),
 
-	MUX(none, "mout_sw_aclk400_mscl", mout_sw_aclk400_mscl_p,
+	MUX(NONE, "mout_sw_aclk400_mscl", mout_sw_aclk400_mscl_p,
 			SRC_TOP10, 4, 1),
-	MUX(none, "mout_sw_aclk200", mout_sw_aclk200_p, SRC_TOP10, 8, 1),
-	MUX(none, "mout_sw_aclk200_fsys2", mout_sw_aclk200_fsys2_p,
+	MUX(NONE, "mout_sw_aclk200", mout_sw_aclk200_p, SRC_TOP10, 8, 1),
+	MUX(NONE, "mout_sw_aclk200_fsys2", mout_sw_aclk200_fsys2_p,
 			SRC_TOP10, 12, 1),
-	MUX(none, "mout_sw_aclk200_fsys", mout_sw_aclk200_fsys_p,
+	MUX(NONE, "mout_sw_aclk200_fsys", mout_sw_aclk200_fsys_p,
 			SRC_TOP10, 28, 1),
-	MUX(mout_sw_aclk333_432_gscl, "mout_sw_aclk333_432_gscl",
+	MUX(MOUT_SW_ACLK333_432_GSCL, "mout_sw_aclk333_432_gscl",
 			mout_sw_aclk333_432_gscl_p, SRC_TOP11, 0, 1),
-	MUX(none, "mout_sw_aclk66", mout_sw_aclk66_p, SRC_TOP11, 8, 1),
-	MUX(none, "mout_sw_aclk266", mout_sw_aclk266_p, SRC_TOP11, 20, 1),
-	MUX(none, "mout_sw_aclk166", mout_sw_aclk166_p, SRC_TOP11, 24, 1),
-	MUX(mout_sw_aclk333, "mout_sw_aclk333", mout_sw_aclk333_p,
+	MUX(NONE, "mout_sw_aclk66", mout_sw_aclk66_p, SRC_TOP11, 8, 1),
+	MUX(NONE, "mout_sw_aclk266", mout_sw_aclk266_p, SRC_TOP11, 20, 1),
+	MUX(NONE, "mout_sw_aclk166", mout_sw_aclk166_p, SRC_TOP11, 24, 1),
+	MUX(MOUT_SW_ACLK333, "mout_sw_aclk333", mout_sw_aclk333_p,
 			SRC_TOP11, 28, 1),
 
-	MUX(none, "mout_sw_aclk333_g2d", mout_sw_aclk333_g2d_p,
+	MUX(NONE, "mout_sw_aclk333_g2d", mout_sw_aclk333_g2d_p,
 			SRC_TOP12, 8, 1),
-	MUX(none, "mout_sw_aclk266_g2d", mout_sw_aclk266_g2d_p,
+	MUX(NONE, "mout_sw_aclk266_g2d", mout_sw_aclk266_g2d_p,
 			SRC_TOP12, 12, 1),
-	MUX(none, "mout_sw_aclk_g3d", mout_sw_aclk_g3d_p, SRC_TOP12, 16, 1),
-	MUX(none, "mout_sw_aclk300_jpeg", mout_sw_aclk300_jpeg_p,
+	MUX(NONE, "mout_sw_aclk_g3d", mout_sw_aclk_g3d_p, SRC_TOP12, 16, 1),
+	MUX(NONE, "mout_sw_aclk300_jpeg", mout_sw_aclk300_jpeg_p,
 			SRC_TOP12, 20, 1),
-	MUX(none, "mout_sw_aclk300_disp1", mout_sw_aclk300_disp1_p,
+	MUX(NONE, "mout_sw_aclk300_disp1", mout_sw_aclk300_disp1_p,
 			SRC_TOP12, 24, 1),
-	MUX(mout_sw_aclk300_gscl, "mout_sw_aclk300_gscl",
+	MUX(MOUT_SW_ACLK300_GSCL, "mout_sw_aclk300_gscl",
 			mout_sw_aclk300_gscl_p, SRC_TOP12, 28, 1),
 
 	/* DISP1 Block */
-	MUX(mout_fimd1, "mout_fimd1", mout_group3_p, SRC_DISP10, 4, 1),
-	MUX(none, "mout_mipi1", mout_group2_p, SRC_DISP10, 16, 3),
-	MUX(none, "mout_dp1", mout_group2_p, SRC_DISP10, 20, 3),
-	MUX(none, "mout_pixel", mout_group2_p, SRC_DISP10, 24, 3),
-	MUX(mout_hdmi, "mout_hdmi", mout_hdmi_p, SRC_DISP10, 28, 1),
-	MUX_F(none, "mout_fimd1_opt", mout_group2_p, SRC_DISP10, 8, 3,
+	MUX(MOUT_FIMD1, "mout_fimd1", mout_group3_p, SRC_DISP10, 4, 1),
+	MUX(NONE, "mout_mipi1", mout_group2_p, SRC_DISP10, 16, 3),
+	MUX(NONE, "mout_dp1", mout_group2_p, SRC_DISP10, 20, 3),
+	MUX(NONE, "mout_pixel", mout_group2_p, SRC_DISP10, 24, 3),
+	MUX(MOUT_HDMI, "mout_hdmi", mout_hdmi_p, SRC_DISP10, 28, 1),
+	MUX_F(NONE, "mout_fimd1_opt", mout_group2_p, SRC_DISP10, 8, 3,
 						CLK_SET_RATE_PARENT, 0),
-	MUX_F(none, "mout_fimd1_final", mout_fimd1_final_p, TOP_SPARE2, 8, 1,
+	MUX_F(NONE, "mout_fimd1_final", mout_fimd1_final_p, TOP_SPARE2, 8, 1,
 						CLK_SET_RATE_PARENT, 0),
 
 	/* MAU Block */
-	MUX_F(mout_maudio0, "mout_maudio0", mout_maudio0_p, SRC_MAU, 28, 3,
+	MUX_F(MOUT_MAUDIO0, "mout_maudio0", mout_maudio0_p, SRC_MAU, 28, 3,
 						CLK_SET_RATE_PARENT, 0),
 
 	/* FSYS Block */
-	MUX(none, "mout_usbd301", mout_group2_p, SRC_FSYS, 4, 3),
-	MUX(none, "mout_mmc0", mout_group2_p, SRC_FSYS, 8, 3),
-	MUX(none, "mout_mmc1", mout_group2_p, SRC_FSYS, 12, 3),
-	MUX(none, "mout_mmc2", mout_group2_p, SRC_FSYS, 16, 3),
-	MUX(none, "mout_usbd300", mout_group2_p, SRC_FSYS, 20, 3),
-	MUX(none, "mout_unipro", mout_group2_p, SRC_FSYS, 24, 3),
-	MUX(none, "mout_mphy_refclk", mout_group2_p, SRC_FSYS, 28, 3),
+	MUX(NONE, "mout_usbd301", mout_group2_p, SRC_FSYS, 4, 3),
+	MUX(NONE, "mout_mmc0", mout_group2_p, SRC_FSYS, 8, 3),
+	MUX(NONE, "mout_mmc1", mout_group2_p, SRC_FSYS, 12, 3),
+	MUX(NONE, "mout_mmc2", mout_group2_p, SRC_FSYS, 16, 3),
+	MUX(NONE, "mout_usbd300", mout_group2_p, SRC_FSYS, 20, 3),
+	MUX(NONE, "mout_unipro", mout_group2_p, SRC_FSYS, 24, 3),
+	MUX(NONE, "mout_mphy_refclk", mout_group2_p, SRC_FSYS, 28, 3),
 
 	/* PERIC Block */
-	MUX(none, "mout_uart0", mout_group2_p, SRC_PERIC0, 4, 3),
-	MUX(none, "mout_uart1", mout_group2_p, SRC_PERIC0, 8, 3),
-	MUX(none, "mout_uart2", mout_group2_p, SRC_PERIC0, 12, 3),
-	MUX(none, "mout_uart3", mout_group2_p, SRC_PERIC0, 16, 3),
-	MUX(none, "mout_pwm", mout_group2_p, SRC_PERIC0, 24, 3),
-	MUX(none, "mout_spdif", mout_spdif_p, SRC_PERIC0, 28, 3),
-	MUX(none, "mout_audio0", mout_audio0_p, SRC_PERIC1, 8, 3),
-	MUX(none, "mout_audio1", mout_audio1_p, SRC_PERIC1, 12, 3),
-	MUX(none, "mout_audio2", mout_audio2_p, SRC_PERIC1, 16, 3),
-	MUX(mout_spi0, "mout_spi0", mout_group2_p, SRC_PERIC1, 20, 3),
-	MUX(mout_spi1, "mout_spi1", mout_group2_p, SRC_PERIC1, 24, 3),
-	MUX(mout_spi2, "mout_spi2", mout_group2_p, SRC_PERIC1, 28, 3),
-
-	MUX(none, "mout_user_aclk66_gpio", mout_user_aclk66_gpio_p,
+	MUX(NONE, "mout_uart0", mout_group2_p, SRC_PERIC0, 4, 3),
+	MUX(NONE, "mout_uart1", mout_group2_p, SRC_PERIC0, 8, 3),
+	MUX(NONE, "mout_uart2", mout_group2_p, SRC_PERIC0, 12, 3),
+	MUX(NONE, "mout_uart3", mout_group2_p, SRC_PERIC0, 16, 3),
+	MUX(NONE, "mout_pwm", mout_group2_p, SRC_PERIC0, 24, 3),
+	MUX(NONE, "mout_spdif", mout_spdif_p, SRC_PERIC0, 28, 3),
+	MUX(NONE, "mout_audio0", mout_audio0_p, SRC_PERIC1, 8, 3),
+	MUX(NONE, "mout_audio1", mout_audio1_p, SRC_PERIC1, 12, 3),
+	MUX(NONE, "mout_audio2", mout_audio2_p, SRC_PERIC1, 16, 3),
+	MUX(MOUT_SPI0, "mout_spi0", mout_group2_p, SRC_PERIC1, 20, 3),
+	MUX(MOUT_SPI1, "mout_spi1", mout_group2_p, SRC_PERIC1, 24, 3),
+	MUX(MOUT_SPI2, "mout_spi2", mout_group2_p, SRC_PERIC1, 28, 3),
+
+	MUX(NONE, "mout_user_aclk66_gpio", mout_user_aclk66_gpio_p,
 		SRC_TOP7, 4, 1),
-	MUX_F(none, "mout_mau_epll_clk", mout_mau_epll_clk_p, SRC_TOP7, 20, 2,
+	MUX_F(NONE, "mout_mau_epll_clk", mout_mau_epll_clk_p, SRC_TOP7, 20, 2,
 		CLK_SET_RATE_PARENT, 0),
-	MUX(none, "mout_pclk200_fsys", mout_group1_p, SRC_TOP0, 24, 2),
-	MUX(none, "mout_sw_pclk200_fsys", mout_sw_pclk200_fsys_p,
+	MUX(NONE, "mout_pclk200_fsys", mout_group1_p, SRC_TOP0, 24, 2),
+	MUX(NONE, "mout_sw_pclk200_fsys", mout_sw_pclk200_fsys_p,
 		SRC_TOP10, 24, 1),
-	MUX(none, "mout_user_pclk200_fsys", mout_user_pclk200_fsys_p,
+	MUX(NONE, "mout_user_pclk200_fsys", mout_user_pclk200_fsys_p,
 		SRC_TOP3, 24, 1),
-	MUX(none, "mout_aclk100_noc", mout_group1_p, SRC_TOP0, 20, 2),
-	MUX(none, "mout_sw_aclk100_noc", mout_sw_aclk100_noc_p,
+	MUX(NONE, "mout_aclk100_noc", mout_group1_p, SRC_TOP0, 20, 2),
+	MUX(NONE, "mout_sw_aclk100_noc", mout_sw_aclk100_noc_p,
 		SRC_TOP10, 20, 1),
-	MUX(none, "mout_user_aclk100_noc", mout_user_aclk100_noc_p,
+	MUX(NONE, "mout_user_aclk100_noc", mout_user_aclk100_noc_p,
 		SRC_TOP3, 20, 1),
-	MUX(none, "mout_aclk400_wcore", mout_group1_p, SRC_TOP0, 16, 2),
-	MUX(none, "mout_aclk400_wcore_bpll", mout_aclk400_wcore_bpll_p,
+	MUX(NONE, "mout_aclk400_wcore", mout_group1_p, SRC_TOP0, 16, 2),
+	MUX(NONE, "mout_aclk400_wcore_bpll", mout_aclk400_wcore_bpll_p,
 		TOP_SPARE2, 4, 1),
-	MUX(none, "mout_sw_aclk400_wcore", mout_sw_aclk400_wcore_p,
+	MUX(NONE, "mout_sw_aclk400_wcore", mout_sw_aclk400_wcore_p,
 		SRC_TOP10, 16, 1),
-	MUX(none, "mout_user_aclk400_wcore", mout_user_aclk400_wcore_p,
+	MUX(NONE, "mout_user_aclk400_wcore", mout_user_aclk400_wcore_p,
 		SRC_TOP3, 16, 1),
-	MUX(none, "mout_aclk400_isp", mout_group1_p, SRC_TOP0, 0, 2),
-	MUX(none, "mout_sw_aclk400_isp", mout_sw_aclk400_isp_p,
+	MUX(NONE, "mout_aclk400_isp", mout_group1_p, SRC_TOP0, 0, 2),
+	MUX(NONE, "mout_sw_aclk400_isp", mout_sw_aclk400_isp_p,
 		SRC_TOP10, 0, 1),
-	MUX(none, "mout_user_aclk400_isp", mout_user_aclk400_isp_p,
+	MUX(NONE, "mout_user_aclk400_isp", mout_user_aclk400_isp_p,
 		SRC_TOP3, 0, 1),
-	MUX(none, "mout_aclk333_432_isp0", mout_group4_p, SRC_TOP1, 12, 2),
-	MUX(none, "mout_sw_aclk333_432_isp0", mout_sw_aclk333_432_isp0_p,
+	MUX(NONE, "mout_aclk333_432_isp0", mout_group4_p, SRC_TOP1, 12, 2),
+	MUX(NONE, "mout_sw_aclk333_432_isp0", mout_sw_aclk333_432_isp0_p,
 		SRC_TOP11, 12, 1),
-	MUX(none, "mout_user_aclk333_432_isp0", mout_user_aclk333_432_isp0_p,
+	MUX(NONE, "mout_user_aclk333_432_isp0", mout_user_aclk333_432_isp0_p,
 		SRC_TOP4, 12, 1),
-	MUX(none, "mout_aclk333_432_isp", mout_group4_p,
+	MUX(NONE, "mout_aclk333_432_isp", mout_group4_p,
 		SRC_TOP1, 4, 2),
-	MUX(none, "mout_sw_aclk333_432_isp", mout_sw_aclk333_432_isp_p,
+	MUX(NONE, "mout_sw_aclk333_432_isp", mout_sw_aclk333_432_isp_p,
 		SRC_TOP11, 4, 1),
-	MUX(none, "mout_user_aclk333_432_isp", mout_user_aclk333_432_isp_p,
+	MUX(NONE, "mout_user_aclk333_432_isp", mout_user_aclk333_432_isp_p,
 		SRC_TOP4, 4, 1),
-	MUX(none, "mout_user_aclk266_isp", mout_user_aclk266_isp_p,
+	MUX(NONE, "mout_user_aclk266_isp", mout_user_aclk266_isp_p,
 		SRC_TOP4, 16, 1),
-	MUX(none, "mout_aclk400_disp1", mout_group1_p, SRC_TOP2, 4, 2),
-	MUX(none, "mout_sw_aclk400_disp1", mout_sw_aclk400_disp1_p,
+	MUX(NONE, "mout_aclk400_disp1", mout_group1_p, SRC_TOP2, 4, 2),
+	MUX(NONE, "mout_sw_aclk400_disp1", mout_sw_aclk400_disp1_p,
 		SRC_TOP12, 4, 1),
-	MUX(none, "mout_user_aclk400_disp1", mout_user_aclk400_disp1_p,
+	MUX(NONE, "mout_user_aclk400_disp1", mout_user_aclk400_disp1_p,
 		SRC_TOP5, 0, 1),
 
 	/* ISP Block*/
-	MUX(none, "mout_pwm_isp", mout_group2_p, SRC_ISP, 24, 3),
-	MUX(none, "mout_uart_isp", mout_group2_p, SRC_ISP, 20, 3),
-	MUX(none, "mout_spi0_isp", mout_group2_p, SRC_ISP, 12, 3),
-	MUX(none, "mout_spi1_isp", mout_group2_p, SRC_ISP, 16, 3),
-	MUX(none, "mout_isp_sensor", mout_group2_p, SRC_ISP, 28, 3),
+	MUX(NONE, "mout_pwm_isp", mout_group2_p, SRC_ISP, 24, 3),
+	MUX(NONE, "mout_uart_isp", mout_group2_p, SRC_ISP, 20, 3),
+	MUX(NONE, "mout_spi0_isp", mout_group2_p, SRC_ISP, 12, 3),
+	MUX(NONE, "mout_spi1_isp", mout_group2_p, SRC_ISP, 16, 3),
+	MUX(NONE, "mout_isp_sensor", mout_group2_p, SRC_ISP, 28, 3),
 };
 
 static struct samsung_div_clock exynos5420_div_clks[] __initdata = {
-	DIV(none, "dout_armclk1", "mout_cpu", DIV_CPU0, 0, 3),
-	DIV(none, "sclk_apll", "mout_apll", DIV_CPU0, 24, 3),
-	DIV(none, "dout_armclk2", "dout_armclk1", DIV_CPU0, 28, 3),
-	DIV(none, "dout_kfc", "mout_kfc", DIV_KFC0, 0, 3),
-	DIV(none, "sclk_kpll", "mout_kpll", DIV_KFC0, 24, 3),
-
-	DIV(none, "dout_aclk400_mscl", "mout_aclk400_mscl", DIV_TOP0, 4, 3),
-	DIV(none, "dout_aclk200", "mout_aclk200", DIV_TOP0, 8, 3),
-	DIV(none, "dout_aclk200_fsys2", "mout_aclk200_fsys2", DIV_TOP0, 12, 3),
-	DIV(none, "dout_pclk200_fsys", "mout_pclk200_fsys", DIV_TOP0, 24, 3),
-	DIV(none, "dout_aclk200_fsys", "mout_aclk200_fsys", DIV_TOP0, 28, 3),
-
-	DIV(none, "dout_aclk333_432_gscl", "mout_aclk333_432_gscl",
+	DIV(NONE, "dout_armclk1", "mout_cpu", DIV_CPU0, 0, 3),
+	DIV(NONE, "sclk_apll", "mout_apll", DIV_CPU0, 24, 3),
+	DIV(NONE, "dout_armclk2", "dout_armclk1", DIV_CPU0, 28, 3),
+	DIV(NONE, "dout_kfc", "mout_kfc", DIV_KFC0, 0, 3),
+	DIV(NONE, "sclk_kpll", "mout_kpll", DIV_KFC0, 24, 3),
+
+	DIV(NONE, "dout_aclk400_mscl", "mout_aclk400_mscl", DIV_TOP0, 4, 3),
+	DIV(NONE, "dout_aclk200", "mout_aclk200", DIV_TOP0, 8, 3),
+	DIV(NONE, "dout_aclk200_fsys2", "mout_aclk200_fsys2", DIV_TOP0, 12, 3),
+	DIV(NONE, "dout_pclk200_fsys", "mout_pclk200_fsys", DIV_TOP0, 24, 3),
+	DIV(NONE, "dout_aclk200_fsys", "mout_aclk200_fsys", DIV_TOP0, 28, 3),
+
+	DIV(NONE, "dout_aclk333_432_gscl", "mout_aclk333_432_gscl",
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
-	DIV(none, "dout_aclk300_disp1", "mout_aclk300_disp1", DIV_TOP2, 24, 3),
-	DIV(none, "dout_aclk300_gscl", "mout_aclk300_gscl", DIV_TOP2, 28, 3),
+	DIV(NONE, "dout_aclk66", "mout_aclk66", DIV_TOP1, 8, 6),
+	DIV(NONE, "dout_aclk266", "mout_aclk266", DIV_TOP1, 20, 3),
+	DIV(NONE, "dout_aclk166", "mout_aclk166", DIV_TOP1, 24, 3),
+	DIV(NONE, "dout_aclk333", "mout_aclk333", DIV_TOP1, 28, 3),
+
+	DIV(NONE, "dout_aclk333_g2d", "mout_aclk333_g2d", DIV_TOP2, 8, 3),
+	DIV(NONE, "dout_aclk266_g2d", "mout_aclk266_g2d", DIV_TOP2, 12, 3),
+	DIV(NONE, "dout_aclk_g3d", "mout_aclk_g3d", DIV_TOP2, 16, 3),
+	DIV(NONE, "dout_aclk300_jpeg", "mout_aclk300_jpeg", DIV_TOP2, 20, 3),
+	DIV(NONE, "dout_aclk300_disp1", "mout_aclk300_disp1", DIV_TOP2, 24, 3),
+	DIV(NONE, "dout_aclk300_gscl", "mout_aclk300_gscl", DIV_TOP2, 28, 3),
 
 	/* DISP1 Block */
-	DIV(none, "dout_fimd1", "mout_fimd1_final", DIV_DISP10, 0, 4),
-	DIV(none, "dout_mipi1", "mout_mipi1", DIV_DISP10, 16, 8),
-	DIV(none, "dout_dp1", "mout_dp1", DIV_DISP10, 24, 4),
-	DIV(dout_pixel, "dout_hdmi_pixel", "mout_pixel", DIV_DISP10, 28, 4),
-	DIV(none, "dout_disp1_blk", "aclk200_disp1", DIV2_RATIO0, 16, 2),
+	DIV(NONE, "dout_fimd1", "mout_fimd1_final", DIV_DISP10, 0, 4),
+	DIV(NONE, "dout_mipi1", "mout_mipi1", DIV_DISP10, 16, 8),
+	DIV(NONE, "dout_dp1", "mout_dp1", DIV_DISP10, 24, 4),
+	DIV(DOUT_PIXEL, "dout_hdmi_pixel", "mout_pixel", DIV_DISP10, 28, 4),
+	DIV(NONE, "dout_disp1_blk", "aclk200_disp1", DIV2_RATIO0, 16, 2),
 
 	/* Audio Block */
-	DIV(none, "dout_maudio0", "mout_maudio0", DIV_MAU, 20, 4),
-	DIV(none, "dout_maupcm0", "dout_maudio0", DIV_MAU, 24, 8),
+	DIV(NONE, "dout_maudio0", "mout_maudio0", DIV_MAU, 20, 4),
+	DIV(NONE, "dout_maupcm0", "dout_maudio0", DIV_MAU, 24, 8),
 
 	/* USB3.0 */
-	DIV(none, "dout_usbphy301", "mout_usbd301", DIV_FSYS0, 12, 4),
-	DIV(none, "dout_usbphy300", "mout_usbd300", DIV_FSYS0, 16, 4),
-	DIV(none, "dout_usbd301", "mout_usbd301", DIV_FSYS0, 20, 4),
-	DIV(none, "dout_usbd300", "mout_usbd300", DIV_FSYS0, 24, 4),
+	DIV(NONE, "dout_usbphy301", "mout_usbd301", DIV_FSYS0, 12, 4),
+	DIV(NONE, "dout_usbphy300", "mout_usbd300", DIV_FSYS0, 16, 4),
+	DIV(NONE, "dout_usbd301", "mout_usbd301", DIV_FSYS0, 20, 4),
+	DIV(NONE, "dout_usbd300", "mout_usbd300", DIV_FSYS0, 24, 4),
 
 	/* MMC */
-	DIV(none, "dout_mmc0", "mout_mmc0", DIV_FSYS1, 0, 10),
-	DIV(none, "dout_mmc1", "mout_mmc1", DIV_FSYS1, 10, 10),
-	DIV(none, "dout_mmc2", "mout_mmc2", DIV_FSYS1, 20, 10),
+	DIV(NONE, "dout_mmc0", "mout_mmc0", DIV_FSYS1, 0, 10),
+	DIV(NONE, "dout_mmc1", "mout_mmc1", DIV_FSYS1, 10, 10),
+	DIV(NONE, "dout_mmc2", "mout_mmc2", DIV_FSYS1, 20, 10),
 
-	DIV(none, "dout_unipro", "mout_unipro", DIV_FSYS2, 24, 8),
-	DIV(none, "dout_mphy_refclk", "mout_mphy_refclk", DIV_FSYS2, 16, 8),
+	DIV(NONE, "dout_unipro", "mout_unipro", DIV_FSYS2, 24, 8),
+	DIV(NONE, "dout_mphy_refclk", "mout_mphy_refclk", DIV_FSYS2, 16, 8),
 
 	/* UART and PWM */
-	DIV(none, "dout_uart0", "mout_uart0", DIV_PERIC0, 8, 4),
-	DIV(none, "dout_uart1", "mout_uart1", DIV_PERIC0, 12, 4),
-	DIV(none, "dout_uart2", "mout_uart2", DIV_PERIC0, 16, 4),
-	DIV(none, "dout_uart3", "mout_uart3", DIV_PERIC0, 20, 4),
-	DIV(none, "dout_pwm", "mout_pwm", DIV_PERIC0, 28, 4),
+	DIV(NONE, "dout_uart0", "mout_uart0", DIV_PERIC0, 8, 4),
+	DIV(NONE, "dout_uart1", "mout_uart1", DIV_PERIC0, 12, 4),
+	DIV(NONE, "dout_uart2", "mout_uart2", DIV_PERIC0, 16, 4),
+	DIV(NONE, "dout_uart3", "mout_uart3", DIV_PERIC0, 20, 4),
+	DIV(NONE, "dout_pwm", "mout_pwm", DIV_PERIC0, 28, 4),
 
 	/* SPI */
-	DIV(none, "dout_spi0", "mout_spi0", DIV_PERIC1, 20, 4),
-	DIV(none, "dout_spi1", "mout_spi1", DIV_PERIC1, 24, 4),
-	DIV(none, "dout_spi2", "mout_spi2", DIV_PERIC1, 28, 4),
+	DIV(NONE, "dout_spi0", "mout_spi0", DIV_PERIC1, 20, 4),
+	DIV(NONE, "dout_spi1", "mout_spi1", DIV_PERIC1, 24, 4),
+	DIV(NONE, "dout_spi2", "mout_spi2", DIV_PERIC1, 28, 4),
 
 	/* PCM */
-	DIV(none, "dout_pcm1", "dout_audio1", DIV_PERIC2, 16, 8),
-	DIV(none, "dout_pcm2", "dout_audio2", DIV_PERIC2, 24, 8),
+	DIV(NONE, "dout_pcm1", "dout_audio1", DIV_PERIC2, 16, 8),
+	DIV(NONE, "dout_pcm2", "dout_audio2", DIV_PERIC2, 24, 8),
 
 	/* Audio - I2S */
-	DIV(none, "dout_i2s1", "dout_audio1", DIV_PERIC3, 6, 6),
-	DIV(none, "dout_i2s2", "dout_audio2", DIV_PERIC3, 12, 6),
-	DIV(none, "dout_audio0", "mout_audio0", DIV_PERIC3, 20, 4),
-	DIV(none, "dout_audio1", "mout_audio1", DIV_PERIC3, 24, 4),
-	DIV(none, "dout_audio2", "mout_audio2", DIV_PERIC3, 28, 4),
+	DIV(NONE, "dout_i2s1", "dout_audio1", DIV_PERIC3, 6, 6),
+	DIV(NONE, "dout_i2s2", "dout_audio2", DIV_PERIC3, 12, 6),
+	DIV(NONE, "dout_audio0", "mout_audio0", DIV_PERIC3, 20, 4),
+	DIV(NONE, "dout_audio1", "mout_audio1", DIV_PERIC3, 24, 4),
+	DIV(NONE, "dout_audio2", "mout_audio2", DIV_PERIC3, 28, 4),
 
 	/* SPI Pre-Ratio */
-	DIV(none, "dout_spi0_pre", "dout_spi0", DIV_PERIC4, 8, 8),
-	DIV(none, "dout_spi1_pre", "dout_spi1", DIV_PERIC4, 16, 8),
-	DIV(none, "dout_spi2_pre", "dout_spi2", DIV_PERIC4, 24, 8),
+	DIV(NONE, "dout_spi0_pre", "dout_spi0", DIV_PERIC4, 8, 8),
+	DIV(NONE, "dout_spi1_pre", "dout_spi1", DIV_PERIC4, 16, 8),
+	DIV(NONE, "dout_spi2_pre", "dout_spi2", DIV_PERIC4, 24, 8),
 
-	DIV(none, "dout_aclk400_disp1", "mout_aclk400_disp1",
+	DIV(NONE, "dout_aclk400_disp1", "mout_aclk400_disp1",
 		DIV_TOP2, 4, 3),
-	DIV(none, "dout_aclk100_noc", "mout_aclk100_noc", DIV_TOP0, 20, 3),
-	DIV(none, "dout_aclk400_wcore", "mout_aclk400_wcore_bpll",
+	DIV(NONE, "dout_aclk100_noc", "mout_aclk100_noc", DIV_TOP0, 20, 3),
+	DIV(NONE, "dout_aclk400_wcore", "mout_aclk400_wcore_bpll",
 		DIV_TOP0, 16, 3),
-	DIV(none, "dout_aclk400_isp", "mout_aclk400_isp", DIV_TOP0, 0, 3),
-	DIV(none, "dout_aclk333_432_isp0", "mout_aclk333_432_isp0",
+	DIV(NONE, "dout_aclk400_isp", "mout_aclk400_isp", DIV_TOP0, 0, 3),
+	DIV(NONE, "dout_aclk333_432_isp0", "mout_aclk333_432_isp0",
 		DIV_TOP1, 16, 3),
-	DIV(none, "dout_aclk333_432_isp", "mout_aclk333_432_isp",
+	DIV(NONE, "dout_aclk333_432_isp", "mout_aclk333_432_isp",
 		DIV_TOP1, 4, 3),
 	/* Mfc Blk */
-	DIV(none, "dout_mfc_blk", "mout_user_aclk333", DIV4_RATIO, 0, 2),
+	DIV(NONE, "dout_mfc_blk", "mout_user_aclk333", DIV4_RATIO, 0, 2),
 	/* Gscl Blk */
-	DIV(none, "dout_gscl_blk_300", "mout_user_aclk300_gscl",
+	DIV(NONE, "dout_gscl_blk_300", "mout_user_aclk300_gscl",
 						DIV2_RATIO0, 4, 2),
-	DIV(none, "dout_gscl_blk_333", "aclk333_432_gscl", DIV2_RATIO0, 6, 2),
+	DIV(NONE, "dout_gscl_blk_333", "aclk333_432_gscl", DIV2_RATIO0, 6, 2),
 	/* Mscl Blk */
-	DIV(none, "dout_mscl_blk", "aclk400_mscl", DIV2_RATIO0, 28, 2),
+	DIV(NONE, "dout_mscl_blk", "aclk400_mscl", DIV2_RATIO0, 28, 2),
 	/* Psgen */
-	DIV(none, "dout_gen_blk", "mout_user_aclk266", DIV2_RATIO0, 8, 1),
+	DIV(NONE, "dout_gen_blk", "mout_user_aclk266", DIV2_RATIO0, 8, 1),
 	/* Jpeg */
-	DIV(none, "dout_jpg_blk", "aclk166", DIV2_RATIO0, 20, 1),
+	DIV(NONE, "dout_jpg_blk", "aclk166", DIV2_RATIO0, 20, 1),
 	/* isp */
-	DIV(none, "dout_pwm_isp", "mout_pwm_isp", SCLK_DIV_ISP1, 28, 4),
-	DIV(none, "dout_uart_isp", "mout_uart_isp", SCLK_DIV_ISP1, 24, 4),
-	DIV(none, "dout_spi0_isp", "mout_spi0_isp", SCLK_DIV_ISP1, 16, 4),
-	DIV(none, "dout_spi1_isp", "mout_spi1_isp", SCLK_DIV_ISP1, 20, 4),
-	DIV(none, "dout_spi0_isp_pre", "dout_spi0_isp", SCLK_DIV_ISP1, 0, 8),
-	DIV(none, "dout_spi1_isp_pre", "dout_spi1_isp", SCLK_DIV_ISP1, 8, 8),
-	DIV(none, "dout_isp_sensor0", "mout_isp_sensor", SCLK_DIV_ISP0, 8, 8),
-	DIV(none, "dout_isp_sensor1", "mout_isp_sensor", SCLK_DIV_ISP0, 16, 8),
-	DIV(none, "dout_isp_sensor2", "mout_isp_sensor", SCLK_DIV_ISP0, 24, 8),
+	DIV(NONE, "dout_pwm_isp", "mout_pwm_isp", SCLK_DIV_ISP1, 28, 4),
+	DIV(NONE, "dout_uart_isp", "mout_uart_isp", SCLK_DIV_ISP1, 24, 4),
+	DIV(NONE, "dout_spi0_isp", "mout_spi0_isp", SCLK_DIV_ISP1, 16, 4),
+	DIV(NONE, "dout_spi1_isp", "mout_spi1_isp", SCLK_DIV_ISP1, 20, 4),
+	DIV(NONE, "dout_spi0_isp_pre", "dout_spi0_isp", SCLK_DIV_ISP1, 0, 8),
+	DIV(NONE, "dout_spi1_isp_pre", "dout_spi1_isp", SCLK_DIV_ISP1, 8, 8),
+	DIV(NONE, "dout_isp_sensor0", "mout_isp_sensor", SCLK_DIV_ISP0, 8, 8),
+	DIV(NONE, "dout_isp_sensor1", "mout_isp_sensor", SCLK_DIV_ISP0, 16, 8),
+	DIV(NONE, "dout_isp_sensor2", "mout_isp_sensor", SCLK_DIV_ISP0, 24, 8),
 };
 
 static struct samsung_gate_clock exynos5420_gate_clks[] __initdata = {
-	GATE(pclk_mct, "pclk_mct", "aclk66_psgen", GATE_BUS_PERIS1, 2, 0, 0),
+	GATE(PCLK_MCT, "pclk_mct", "aclk66_psgen", GATE_BUS_PERIS1, 2, 0, 0),
 
-	GATE(aclk200_fsys, "aclk200_fsys", "mout_user_aclk200_fsys",
+	GATE(ACLK200_FSYS, "aclk200_fsys", "mout_user_aclk200_fsys",
 			GATE_BUS_FSYS0, 9, CLK_IGNORE_UNUSED, 0),
-	GATE(aclk200_fsys2, "aclk200_fsys2", "mout_user_aclk200_fsys2",
+	GATE(ACLK200_FSYS2, "aclk200_fsys2", "mout_user_aclk200_fsys2",
 			GATE_BUS_FSYS0, 10, CLK_IGNORE_UNUSED, 0),
 
-	GATE(aclk333_g2d, "aclk333_g2d", "mout_user_aclk333_g2d",
+	GATE(ACLK333_G2D, "aclk333_g2d", "mout_user_aclk333_g2d",
 			GATE_BUS_TOP, 0, CLK_IGNORE_UNUSED, 0),
-	GATE(aclk266_g2d, "aclk266_g2d", "mout_user_aclk266_g2d",
+	GATE(ACLK266_G2D, "aclk266_g2d", "mout_user_aclk266_g2d",
 			GATE_BUS_TOP, 1, CLK_IGNORE_UNUSED, 0),
-	GATE(aclk300_jpeg, "aclk300_jpeg", "mout_user_aclk300_jpeg",
+	GATE(ACLK300_JPEG, "aclk300_jpeg", "mout_user_aclk300_jpeg",
 			GATE_BUS_TOP, 4, CLK_IGNORE_UNUSED, 0),
-	GATE(aclk300_gscl, "aclk300_gscl", "mout_user_aclk300_gscl",
+	GATE(ACLK300_GSCL, "aclk300_gscl", "mout_user_aclk300_gscl",
 			GATE_BUS_TOP, 6, CLK_IGNORE_UNUSED, 0),
-	GATE(aclk333_432_gscl, "aclk333_432_gscl",
+	GATE(ACLK333_432_GSCL, "aclk333_432_gscl",
 			"mout_user_aclk333_432_gscl",
 			GATE_BUS_TOP, 7, CLK_IGNORE_UNUSED, 0),
-	GATE(pclk66_gpio, "pclk66_gpio", "mout_user_aclk66_gpio",
+	GATE(PCLK66_GPIO, "pclk66_gpio", "mout_user_aclk66_gpio",
 			GATE_BUS_TOP, 9, CLK_IGNORE_UNUSED, 0),
-	GATE(aclk66_psgen, "aclk66_psgen", "mout_user_aclk66_psgen",
+	GATE(ACLK66_PSGEN, "aclk66_psgen", "mout_user_aclk66_psgen",
 			GATE_BUS_TOP, 10, CLK_IGNORE_UNUSED, 0),
-	GATE(aclk66_peric, "aclk66_peric", "mout_user_aclk66_peric",
+	GATE(ACLK66_PERIC, "aclk66_peric", "mout_user_aclk66_peric",
 			GATE_BUS_TOP, 11, CLK_IGNORE_UNUSED, 0),
-	GATE(aclk166, "aclk166", "mout_user_aclk166",
+	GATE(ACLK166, "aclk166", "mout_user_aclk166",
 			GATE_BUS_TOP, 14, CLK_IGNORE_UNUSED, 0),
-	GATE(aclk333, "aclk333", "mout_user_aclk333",
+	GATE(ACLK333, "aclk333", "mout_user_aclk333",
 			GATE_BUS_TOP, 15, CLK_IGNORE_UNUSED, 0),
 
 	/* sclk */
-	GATE(sclk_uart0, "sclk_uart0", "dout_uart0",
+	GATE(SCLK_UART0, "sclk_uart0", "dout_uart0",
 		GATE_TOP_SCLK_PERIC, 0, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_uart1, "sclk_uart1", "dout_uart1",
+	GATE(SCLK_UART1, "sclk_uart1", "dout_uart1",
 		GATE_TOP_SCLK_PERIC, 1, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_uart2, "sclk_uart2", "dout_uart2",
+	GATE(SCLK_UART2, "sclk_uart2", "dout_uart2",
 		GATE_TOP_SCLK_PERIC, 2, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_uart3, "sclk_uart3", "dout_uart3",
+	GATE(SCLK_UART3, "sclk_uart3", "dout_uart3",
 		GATE_TOP_SCLK_PERIC, 3, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_spi0, "sclk_spi0", "dout_spi0_pre",
+	GATE(SCLK_SPI0, "sclk_spi0", "dout_spi0_pre",
 		GATE_TOP_SCLK_PERIC, 6, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_spi1, "sclk_spi1", "dout_spi1_pre",
+	GATE(SCLK_SPI1, "sclk_spi1", "dout_spi1_pre",
 		GATE_TOP_SCLK_PERIC, 7, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_spi2, "sclk_spi2", "dout_spi2_pre",
+	GATE(SCLK_SPI2, "sclk_spi2", "dout_spi2_pre",
 		GATE_TOP_SCLK_PERIC, 8, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_spdif, "sclk_spdif", "mout_spdif",
+	GATE(SCLK_SPDIF, "sclk_spdif", "mout_spdif",
 		GATE_TOP_SCLK_PERIC, 9, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_pwm, "sclk_pwm", "dout_pwm",
+	GATE(SCLK_PWM, "sclk_pwm", "dout_pwm",
 		GATE_TOP_SCLK_PERIC, 11, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_pcm1, "sclk_pcm1", "dout_pcm1",
+	GATE(SCLK_PCM1, "sclk_pcm1", "dout_pcm1",
 		GATE_TOP_SCLK_PERIC, 15, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_pcm2, "sclk_pcm2", "dout_pcm2",
+	GATE(SCLK_PCM2, "sclk_pcm2", "dout_pcm2",
 		GATE_TOP_SCLK_PERIC, 16, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_i2s1, "sclk_i2s1", "dout_i2s1",
+	GATE(SCLK_I2S1, "sclk_i2s1", "dout_i2s1",
 		GATE_TOP_SCLK_PERIC, 17, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_i2s2, "sclk_i2s2", "dout_i2s2",
+	GATE(SCLK_I2S2, "sclk_i2s2", "dout_i2s2",
 		GATE_TOP_SCLK_PERIC, 18, CLK_SET_RATE_PARENT, 0),
 
-	GATE(sclk_mmc0, "sclk_mmc0", "dout_mmc0",
+	GATE(SCLK_MMC0, "sclk_mmc0", "dout_mmc0",
 		GATE_TOP_SCLK_FSYS, 0, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_mmc1, "sclk_mmc1", "dout_mmc1",
+	GATE(SCLK_MMC1, "sclk_mmc1", "dout_mmc1",
 		GATE_TOP_SCLK_FSYS, 1, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_mmc2, "sclk_mmc2", "dout_mmc2",
+	GATE(SCLK_MMC2, "sclk_mmc2", "dout_mmc2",
 		GATE_TOP_SCLK_FSYS, 2, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_usbphy301, "sclk_usbphy301", "dout_usbphy301",
+	GATE(SCLK_USBPHY301, "sclk_usbphy301", "dout_usbphy301",
 		GATE_TOP_SCLK_FSYS, 7, CLK_IGNORE_UNUSED, 0),
-	GATE(sclk_usbphy300, "sclk_usbphy300", "dout_usbphy300",
+	GATE(SCLK_USBPHY300, "sclk_usbphy300", "dout_usbphy300",
 		GATE_TOP_SCLK_FSYS, 8, CLK_IGNORE_UNUSED, 0),
-	GATE(sclk_usbd300, "sclk_usbd300", "dout_usbd300",
+	GATE(SCLK_USBD300, "sclk_usbd300", "dout_usbd300",
 		GATE_TOP_SCLK_FSYS, 9, CLK_IGNORE_UNUSED, 0),
-	GATE(sclk_usbd301, "sclk_usbd301", "dout_usbd301",
+	GATE(SCLK_USBD301, "sclk_usbd301", "dout_usbd301",
 		GATE_TOP_SCLK_FSYS, 10, CLK_IGNORE_UNUSED, 0),
 
-	GATE(sclk_unipro, "sclk_unipro", "dout_unipro",
+	GATE(SCLK_UNIPRO, "sclk_unipro", "dout_unipro",
 			GATE_IP_FSYS, 23, CLK_SET_RATE_PARENT, 0),
 
-	GATE(sclk_gscl_wa, "sclk_gscl_wa", "mout_user_aclk333_432_gscl",
+	GATE(SCLK_GSCL_WA, "sclk_gscl_wa", "mout_user_aclk333_432_gscl",
 		GATE_TOP_SCLK_GSCL, 6, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_gscl_wb, "sclk_gscl_wb", "mout_user_aclk333_432_gscl",
+	GATE(SCLK_GSCL_WB, "sclk_gscl_wb", "mout_user_aclk333_432_gscl",
 		GATE_TOP_SCLK_GSCL, 7, CLK_SET_RATE_PARENT, 0),
 
 	/* Display */
-	GATE(sclk_fimd1, "sclk_fimd1", "dout_fimd1",
+	GATE(SCLK_FIMD1, "sclk_fimd1", "dout_fimd1",
 		GATE_TOP_SCLK_DISP1, 0, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_mipi1, "sclk_mipi1", "dout_mipi1",
+	GATE(SCLK_MIPI1, "sclk_mipi1", "dout_mipi1",
 		GATE_TOP_SCLK_DISP1, 3, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_hdmi, "sclk_hdmi", "mout_hdmi",
+	GATE(SCLK_HDMI, "sclk_hdmi", "mout_hdmi",
 		GATE_TOP_SCLK_DISP1, 9, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_pixel, "sclk_pixel", "dout_hdmi_pixel",
+	GATE(SCLK_PIXEL, "sclk_pixel", "dout_hdmi_pixel",
 		GATE_TOP_SCLK_DISP1, 10, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_dp1, "sclk_dp1", "dout_dp1",
+	GATE(SCLK_DP1, "sclk_dp1", "dout_dp1",
 		GATE_TOP_SCLK_DISP1, 20, CLK_SET_RATE_PARENT, 0),
 
 	/* Maudio Block */
-	GATE(sclk_maudio0, "sclk_maudio0", "dout_maudio0",
+	GATE(SCLK_MAUDIO0, "sclk_maudio0", "dout_maudio0",
 		GATE_TOP_SCLK_MAU, 0, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_maupcm0, "sclk_maupcm0", "dout_maupcm0",
+	GATE(SCLK_MAUPCM0, "sclk_maupcm0", "dout_maupcm0",
 		GATE_TOP_SCLK_MAU, 1, CLK_SET_RATE_PARENT, 0),
 	/* FSYS */
-	GATE(aclk_pdma0, "aclk_pdma0", "aclk200_fsys", GATE_BUS_FSYS0, 1, 0, 0),
-	GATE(aclk_pdma1, "aclk_pdma1", "aclk200_fsys", GATE_BUS_FSYS0, 2, 0, 0),
-	GATE(ufs, "ufs", "aclk200_fsys2", GATE_BUS_FSYS0, 3, 0, 0),
-	GATE(aclk_rtic, "aclk_rtic", "aclk200_fsys2", GATE_IP_FSYS, 9, 0, 0),
-	GATE(aclk_mmc0, "aclk_mmc0", "aclk200_fsys2", GATE_BUS_FSYS0, 12, 0, 0),
-	GATE(aclk_mmc1, "aclk_mmc1", "aclk200_fsys2", GATE_BUS_FSYS0, 13, 0, 0),
-	GATE(aclk_mmc2, "aclk_mmc2", "aclk200_fsys2", GATE_BUS_FSYS0, 14, 0, 0),
-	GATE(hclk_sromc, "hclk_sromc", "aclk200_fsys2",
+	GATE(ACLK_PDMA0, "aclk_pdma0", "aclk200_fsys", GATE_BUS_FSYS0, 1, 0, 0),
+	GATE(ACLK_PDMA1, "aclk_pdma1", "aclk200_fsys", GATE_BUS_FSYS0, 2, 0, 0),
+	GATE(UFS, "ufs", "aclk200_fsys2", GATE_BUS_FSYS0, 3, 0, 0),
+	GATE(ACLK_RTIC, "aclk_rtic", "aclk200_fsys2", GATE_IP_FSYS, 9, 0, 0),
+	GATE(ACLK_MMC0, "aclk_mmc0", "aclk200_fsys2", GATE_BUS_FSYS0, 12, 0, 0),
+	GATE(ACLK_MMC1, "aclk_mmc1", "aclk200_fsys2", GATE_BUS_FSYS0, 13, 0, 0),
+	GATE(ACLK_MMC2, "aclk_mmc2", "aclk200_fsys2", GATE_BUS_FSYS0, 14, 0, 0),
+	GATE(HCLK_SROMC, "hclk_sromc", "aclk200_fsys2",
 			GATE_IP_FSYS, 17, CLK_IGNORE_UNUSED, 0),
-	GATE(hclk_usbh20, "hclk_usbh20", "aclk200_fsys",
+	GATE(HCLK_USBH20, "hclk_usbh20", "aclk200_fsys",
 			GATE_IP_FSYS, 18, 0, 0),
-	GATE(hclk_usbd300, "hclk_usbd300", "aclk200_fsys",
+	GATE(HCLK_USBD300, "hclk_usbd300", "aclk200_fsys",
 			GATE_BUS_FSYS0, 21, 0, 0),
-	GATE(hclk_usbd301, "hclk_usbd301", "aclk200_fsys",
+	GATE(HCLK_USBD301, "hclk_usbd301", "aclk200_fsys",
 			GATE_BUS_FSYS0, 28, 0, 0),
 
 	/* UART */
-	GATE(pclk_uart0, "pclk_uart0", "aclk66_peric", GATE_BUS_PERIC, 4, 0, 0),
-	GATE(pclk_uart1, "pclk_uart1", "aclk66_peric", GATE_BUS_PERIC, 5, 0, 0),
-	GATE(pclk_uart2, "pclk_uart2", "aclk66_peric",
+	GATE(PCLK_UART0, "pclk_uart0", "aclk66_peric", GATE_BUS_PERIC, 4, 0, 0),
+	GATE(PCLK_UART1, "pclk_uart1", "aclk66_peric", GATE_BUS_PERIC, 5, 0, 0),
+	GATE(PCLK_UART2, "pclk_uart2", "aclk66_peric",
 			GATE_BUS_PERIC, 6, 0, 0),
-	GATE(pclk_uart3, "pclk_uart3", "aclk66_peric", GATE_BUS_PERIC, 7, 0, 0),
+	GATE(PCLK_UART3, "pclk_uart3", "aclk66_peric", GATE_BUS_PERIC, 7, 0, 0),
 	/* I2C */
-	GATE(pclk_i2c0, "pclk_i2c0", "aclk66_peric", GATE_IP_PERIC, 6, 0, 0),
-	GATE(pclk_i2c1, "pclk_i2c1", "aclk66_peric", GATE_IP_PERIC, 7, 0, 0),
-	GATE(pclk_i2c2, "pclk_i2c2", "aclk66_peric", GATE_IP_PERIC, 8, 0, 0),
-	GATE(pclk_i2c3, "pclk_i2c3", "aclk66_peric", GATE_IP_PERIC, 9, 0, 0),
-	GATE(pclk_usi0, "pclk_usi0", "aclk66_peric", GATE_IP_PERIC, 10, 0, 0),
-	GATE(pclk_usi1, "pclk_usi1", "aclk66_peric", GATE_IP_PERIC, 11, 0, 0),
-	GATE(pclk_usi2, "pclk_usi2", "aclk66_peric", GATE_IP_PERIC, 12, 0, 0),
-	GATE(pclk_usi3, "pclk_usi3", "aclk66_peric", GATE_IP_PERIC, 13, 0, 0),
-	GATE(pclk_usi4, "pclk_usi4", "aclk66_peric", GATE_IP_PERIC, 28, 0, 0),
-	GATE(pclk_usi5, "pclk_usi5", "aclk66_peric", GATE_IP_PERIC, 30, 0, 0),
-	GATE(pclk_usi6, "pclk_usi6", "aclk66_peric", GATE_IP_PERIC, 31, 0, 0),
-
-	GATE(pclk_i2c_hdmi, "pclk_i2c_hdmi", "aclk66_peric",
+	GATE(PCLK_I2C0, "pclk_i2c0", "aclk66_peric", GATE_IP_PERIC, 6, 0, 0),
+	GATE(PCLK_I2C1, "pclk_i2c1", "aclk66_peric", GATE_IP_PERIC, 7, 0, 0),
+	GATE(PCLK_I2C2, "pclk_i2c2", "aclk66_peric", GATE_IP_PERIC, 8, 0, 0),
+	GATE(PCLK_I2C3, "pclk_i2c3", "aclk66_peric", GATE_IP_PERIC, 9, 0, 0),
+	GATE(PCLK_USI0, "pclk_usi0", "aclk66_peric", GATE_IP_PERIC, 10, 0, 0),
+	GATE(PCLK_USI1, "pclk_usi1", "aclk66_peric", GATE_IP_PERIC, 11, 0, 0),
+	GATE(PCLK_USI2, "pclk_usi2", "aclk66_peric", GATE_IP_PERIC, 12, 0, 0),
+	GATE(PCLK_USI3, "pclk_usi3", "aclk66_peric", GATE_IP_PERIC, 13, 0, 0),
+	GATE(PCLK_USI4, "pclk_usi4", "aclk66_peric", GATE_IP_PERIC, 28, 0, 0),
+	GATE(PCLK_USI5, "pclk_usi5", "aclk66_peric", GATE_IP_PERIC, 30, 0, 0),
+	GATE(PCLK_USI6, "pclk_usi6", "aclk66_peric", GATE_IP_PERIC, 31, 0, 0),
+
+	GATE(PCLK_I2C_HDMI, "pclk_i2c_hdmi", "aclk66_peric",
 			GATE_BUS_PERIC, 17, 0, 0),
-	GATE(pclk_tsadc, "pclk_tsadc", "aclk66_peric", GATE_IP_PERIC, 15, 0, 0),
+	GATE(PCLK_TSADC, "pclk_tsadc", "aclk66_peric", GATE_IP_PERIC, 15, 0, 0),
 	/* SPI */
-	GATE(pclk_spi0, "pclk_spi0", "aclk66_peric", GATE_BUS_PERIC, 19, 0, 0),
-	GATE(pclk_spi1, "pclk_spi1", "aclk66_peric", GATE_BUS_PERIC, 20, 0, 0),
-	GATE(pclk_spi2, "pclk_spi2", "aclk66_peric", GATE_BUS_PERIC, 21, 0, 0),
+	GATE(PCLK_SPI0, "pclk_spi0", "aclk66_peric", GATE_BUS_PERIC, 19, 0, 0),
+	GATE(PCLK_SPI1, "pclk_spi1", "aclk66_peric", GATE_BUS_PERIC, 20, 0, 0),
+	GATE(PCLK_SPI2, "pclk_spi2", "aclk66_peric", GATE_BUS_PERIC, 21, 0, 0),
 	/* I2S */
-	GATE(pclk_i2s1, "pclk_i2s1", "aclk66_peric", GATE_BUS_PERIC, 23, 0, 0),
-	GATE(pclk_i2s2, "pclk_i2s2", "aclk66_peric", GATE_BUS_PERIC, 24, 0, 0),
+	GATE(PCLK_I2S1, "pclk_i2s1", "aclk66_peric", GATE_BUS_PERIC, 23, 0, 0),
+	GATE(PCLK_I2S2, "pclk_i2s2", "aclk66_peric", GATE_BUS_PERIC, 24, 0, 0),
 	/* PCM */
-	GATE(pclk_pcm1, "pclk_pcm1", "aclk66_peric", GATE_BUS_PERIC, 25, 0, 0),
-	GATE(pclk_pcm2, "pclk_pcm2", "aclk66_peric", GATE_BUS_PERIC, 26, 0, 0),
+	GATE(PCLK_PCM1, "pclk_pcm1", "aclk66_peric", GATE_BUS_PERIC, 25, 0, 0),
+	GATE(PCLK_PCM2, "pclk_pcm2", "aclk66_peric", GATE_BUS_PERIC, 26, 0, 0),
 	/* PWM */
-	GATE(pclk_pwm, "pwm", "aclk66_peric", GATE_BUS_PERIC, 27, 0, 0),
+	GATE(PCLK_PWM, "pwm", "aclk66_peric", GATE_BUS_PERIC, 27, 0, 0),
 	/* SPDIF */
-	GATE(pclk_spdif, "pclk_spdif", "aclk66_peric",
+	GATE(PCLK_SPDIF, "pclk_spdif", "aclk66_peric",
 			GATE_BUS_PERIC, 29, 0, 0),
 
-	GATE(pclk_chipid, "pclk_chipid", "aclk66_psgen",
+	GATE(PCLK_CHIPID, "pclk_chipid", "aclk66_psgen",
 			GATE_IP_PERIS, 0, CLK_IGNORE_UNUSED, 0),
-	GATE(pclk_sysreg, "pclk_sysreg", "aclk66_psgen",
+	GATE(PCLK_SYSREG, "pclk_sysreg", "aclk66_psgen",
 			GATE_IP_PERIS, 1, CLK_IGNORE_UNUSED, 0),
-	GATE(pclk_tzpc0, "pclk_tzpc0", "aclk66_psgen", GATE_IP_PERIS, 6, 0, 0),
-	GATE(pclk_tzpc1, "pclk_tzpc1", "aclk66_psgen", GATE_IP_PERIS, 7, 0, 0),
-	GATE(pclk_tzpc2, "pclk_tzpc2", "aclk66_psgen", GATE_IP_PERIS, 8, 0, 0),
-	GATE(pclk_tzpc3, "pclk_tzpc3", "aclk66_psgen", GATE_IP_PERIS, 9, 0, 0),
-	GATE(pclk_tzpc4, "pclk_tzpc4", "aclk66_psgen", GATE_IP_PERIS, 10, 0, 0),
-	GATE(pclk_tzpc5, "pclk_tzpc5", "aclk66_psgen", GATE_IP_PERIS, 11, 0, 0),
-	GATE(pclk_tzpc6, "pclk_tzpc6", "aclk66_psgen", GATE_IP_PERIS, 12, 0, 0),
-	GATE(pclk_tzpc7, "pclk_tzpc7", "aclk66_psgen", GATE_IP_PERIS, 13, 0, 0),
-	GATE(pclk_tzpc8, "pclk_tzpc8", "aclk66_psgen", GATE_IP_PERIS, 14, 0, 0),
-	GATE(pclk_tzpc9, "pclk_tzpc9", "aclk66_psgen", GATE_IP_PERIS, 15, 0, 0),
-	GATE(pclk_tzpc10, "pclk_tzpc10", "aclk66_psgen",
+	GATE(PCLK_TZPC0, "pclk_tzpc0", "aclk66_psgen", GATE_IP_PERIS, 6, 0, 0),
+	GATE(PCLK_TZPC1, "pclk_tzpc1", "aclk66_psgen", GATE_IP_PERIS, 7, 0, 0),
+	GATE(PCLK_TZPC2, "pclk_tzpc2", "aclk66_psgen", GATE_IP_PERIS, 8, 0, 0),
+	GATE(PCLK_TZPC3, "pclk_tzpc3", "aclk66_psgen", GATE_IP_PERIS, 9, 0, 0),
+	GATE(PCLK_TZPC4, "pclk_tzpc4", "aclk66_psgen", GATE_IP_PERIS, 10, 0, 0),
+	GATE(PCLK_TZPC5, "pclk_tzpc5", "aclk66_psgen", GATE_IP_PERIS, 11, 0, 0),
+	GATE(PCLK_TZPC6, "pclk_tzpc6", "aclk66_psgen", GATE_IP_PERIS, 12, 0, 0),
+	GATE(PCLK_TZPC7, "pclk_tzpc7", "aclk66_psgen", GATE_IP_PERIS, 13, 0, 0),
+	GATE(PCLK_TZPC8, "pclk_tzpc8", "aclk66_psgen", GATE_IP_PERIS, 14, 0, 0),
+	GATE(PCLK_TZPC9, "pclk_tzpc9", "aclk66_psgen", GATE_IP_PERIS, 15, 0, 0),
+	GATE(PCLK_TZPC10, "pclk_tzpc10", "aclk66_psgen",
 			GATE_BUS_GEN, 30, 0, 0),
-	GATE(pclk_tzpc11, "pclk_tzpc11", "aclk66_psgen",
+	GATE(PCLK_TZPC11, "pclk_tzpc11", "aclk66_psgen",
 			GATE_BUS_GEN, 31, 0, 0),
 
-	GATE(hdmi_cec, "hdmi_cec", "aclk66_psgen", GATE_BUS_PERIS1, 0, 0, 0),
-	GATE(pclk_wdt, "pclk_wdt", "aclk66_psgen", GATE_IP_PERIS, 19, 0, 0),
-	GATE(pclk_rtc, "pclk_rtc", "aclk66_psgen", GATE_IP_PERIS, 20, 0, 0),
-	GATE(pclk_tmu, "pclk_tmu", "aclk66_psgen", GATE_IP_PERIS, 21, 0, 0),
-	GATE(pclk_tmu_gpu, "pclk_tmu_gpu", "aclk66_psgen",
+	GATE(HDMI_CEC, "hdmi_cec", "aclk66_psgen", GATE_BUS_PERIS1, 0, 0, 0),
+	GATE(PCLK_WDT, "pclk_wdt", "aclk66_psgen", GATE_IP_PERIS, 19, 0, 0),
+	GATE(PCLK_RTC, "pclk_rtc", "aclk66_psgen", GATE_IP_PERIS, 20, 0, 0),
+	GATE(PCLK_TMU, "pclk_tmu", "aclk66_psgen", GATE_IP_PERIS, 21, 0, 0),
+	GATE(PCLK_TMU_GPU, "pclk_tmu_gpu", "aclk66_psgen",
 			GATE_IP_PERIS, 22, 0, 0),
 
-	GATE(pclk_gscl0, "pclk_gscl0", "dout_gscl_blk_300", GATE_IP_GSCL0, 14,
+	GATE(PCLK_GSCL0, "pclk_gscl0", "dout_gscl_blk_300", GATE_IP_GSCL0, 14,
 			CLK_IGNORE_UNUSED, 0),
-	GATE(pclk_gscl1, "pclk_gscl1", "dout_gscl_blk_300", GATE_IP_GSCL0, 15,
+	GATE(PCLK_GSCL1, "pclk_gscl1", "dout_gscl_blk_300", GATE_IP_GSCL0, 15,
 			CLK_IGNORE_UNUSED, 0),
-	GATE(aclk_gscl0, "aclk_gscl0", "mout_user_aclk300_gscl",
+	GATE(ACLK_GSCL0, "aclk_gscl0", "mout_user_aclk300_gscl",
 			GATE_IP_GSCL0, 0, 0, 0),
-	GATE(aclk_gscl1, "aclk_gscl1", "mout_user_aclk300_gscl",
+	GATE(ACLK_GSCL1, "aclk_gscl1", "mout_user_aclk300_gscl",
 			GATE_IP_GSCL0, 1, 0, 0),
-	GATE(aclk_fimc_3aa, "aclk_fimc_3aa", "aclk333_432_gscl",
+	GATE(ACLK_FIMC_3AA, "aclk_fimc_3aa", "aclk333_432_gscl",
 			GATE_IP_GSCL0, 4, 0, 0),
-	GATE(pclk_fimc_3aa, "pclk_fimc_3aa", "dout_gscl_blk_333",
+	GATE(PCLK_FIMC_3AA, "pclk_fimc_3aa", "dout_gscl_blk_333",
 			GATE_IP_GSCL0, 9, 0, 0),
-	GATE(smmu_3aa, "smmu_3aa", "dout_gscl_blk_333", GATE_IP_GSCL1, 2, 0, 0),
-	GATE(smmu_fimcl0, "smmu_fimcl0", "dout_gscl_blk_333",
+	GATE(SMMU_3AA, "smmu_3aa", "dout_gscl_blk_333", GATE_IP_GSCL1, 2, 0, 0),
+	GATE(SMMU_FIMCL0, "smmu_fimcl0", "dout_gscl_blk_333",
 			GATE_IP_GSCL1, 3, 0, 0),
-	GATE(smmu_fimcl1, "smmu_fimcl1", "dout_gscl_blk_333",
+	GATE(SMMU_FIMCL1, "smmu_fimcl1", "dout_gscl_blk_333",
 			GATE_IP_GSCL1, 4, 0, 0),
-	GATE(smmu_gscl0, "smmu_gscl0", "dout_gscl_blk_300",
+	GATE(SMMU_GSCL0, "smmu_gscl0", "dout_gscl_blk_300",
 			GATE_IP_GSCL1, 6, 0, 0),
-	GATE(smmu_gscl1, "smmu_gscl1", "dout_gscl_blk_300",
+	GATE(SMMU_GSCL1, "smmu_gscl1", "dout_gscl_blk_300",
 			GATE_IP_GSCL1, 7, 0, 0),
-	GATE(pclk_gscl_wa, "pclk_gscl_wa", "dout_gscl_blk_333",
+	GATE(PCLK_GSCL_WA, "pclk_gscl_wa", "dout_gscl_blk_333",
 			GATE_BUS_GSCL1, 28, 0, 0),
-	GATE(smmu_fimcl3, "smmu_fimcl3,", "dout_gscl_blk_333",
+	GATE(SMMU_FIMCL3, "smmu_fimcl3,", "dout_gscl_blk_333",
 			GATE_IP_GSCL1, 16, 0, 0),
-	GATE(aclk_fimc_lite3, "aclk_fimc_lite3", "aclk333_432_gscl",
+	GATE(ACLK_FIMC_LITE3, "aclk_fimc_lite3", "aclk333_432_gscl",
 			GATE_IP_GSCL1, 17, 0, 0),
 
-	GATE(aclk_fimd1, "aclk_fimd1", "mout_user_aclk300_disp1",
+	GATE(ACLK_FIMD1, "aclk_fimd1", "mout_user_aclk300_disp1",
 			GATE_IP_DISP1, 0, 0, 0),
-	GATE(pclk_dsim1, "pclk_dsim1", "dout_disp1_blk",
+	GATE(PCLK_DSIM1, "pclk_dsim1", "dout_disp1_blk",
 			GATE_BUS_DISP1, 17, 0, 0),
-	GATE(pclk_dp1, "pclk_dp1", "dout_disp1_blk", GATE_BUS_DISP1, 18, 0, 0),
-	GATE(aclk_mixer, "aclk_mixer", "aclk200_disp1",
+	GATE(PCLK_DP1, "pclk_dp1", "dout_disp1_blk", GATE_BUS_DISP1, 18, 0, 0),
+	GATE(ACLK_MIXER, "aclk_mixer", "aclk200_disp1",
 			GATE_IP_DISP1, 5, 0, 0),
-	GATE(pclk_hdmi, "pclk_hdmi", "dout_disp1_blk",
+	GATE(PCLK_HDMI, "pclk_hdmi", "dout_disp1_blk",
 			GATE_BUS_DISP1, 19, 0, 0),
-	GATE(smmu_fimd1m0, "smmu_fimd1m0", "dout_disp1_blk",
+	GATE(SMMU_FIMD1M0, "smmu_fimd1m0", "dout_disp1_blk",
 			GATE_IP_DISP1, 7, 0, 0),
-	GATE(smmu_fimd1m1, "smmu_fimd1m1", "dout_disp1_blk",
+	GATE(SMMU_FIMD1M1, "smmu_fimd1m1", "dout_disp1_blk",
 			GATE_IP_DISP1, 8, 0, 0),
 
-	GATE(aclk_mfc, "aclk_mfc", "mout_user_aclk333", GATE_BUS_MFC, 0, 0, 0),
-	GATE(pclk_mfc, "pclk_mfc", "dout_mfc_blk",
+	GATE(ACLK_MFC, "aclk_mfc", "mout_user_aclk333", GATE_BUS_MFC, 0, 0, 0),
+	GATE(PCLK_MFC, "pclk_mfc", "dout_mfc_blk",
 			GATE_BUS_MFC, 16, CLK_IGNORE_UNUSED, 0),
-	GATE(smmu_mfcl, "smmu_mfcl", "dout_mfc_blk", GATE_IP_MFC, 1, 0, 0),
-	GATE(smmu_mfcr, "smmu_mfcr", "dout_mfc_blk", GATE_IP_MFC, 2, 0, 0),
-	GATE(clk_g3d, "clk_g3d", "mout_user_aclk_g3d", GATE_IP_G3D, 9, 0, 0),
+	GATE(SMMU_MFCL, "smmu_mfcl", "dout_mfc_blk", GATE_IP_MFC, 1, 0, 0),
+	GATE(SMMU_MFCR, "smmu_mfcr", "dout_mfc_blk", GATE_IP_MFC, 2, 0, 0),
+	GATE(CLK_G3D, "clk_g3d", "mout_user_aclk_g3d", GATE_IP_G3D, 9, 0, 0),
 
-	GATE(aclk_rotator, "aclk_rotator", "mout_user_aclk266",
+	GATE(ACLK_ROTATOR, "aclk_rotator", "mout_user_aclk266",
 			GATE_IP_GEN, 1, 0, 0),
-	GATE(pclk_rotator, "pclk_rotator", "dout_gen_blk",
+	GATE(PCLK_ROTATOR, "pclk_rotator", "dout_gen_blk",
 			GATE_BUS_GEN, 13, 0, 0),
-	GATE(aclk_jpeg, "aclk_jpeg", "aclk300_jpeg", GATE_IP_GEN, 2, 0, 0),
-	GATE(aclk_jpeg2, "aclk_jpeg2", "aclk300_jpeg", GATE_IP_GEN, 3, 0, 0),
-	GATE(aclk_mdma0, "aclk_mdma0", "aclk266_g2d",
+	GATE(ACLK_JPEG, "aclk_jpeg", "aclk300_jpeg", GATE_IP_GEN, 2, 0, 0),
+	GATE(ACLK_JPEG2, "aclk_jpeg2", "aclk300_jpeg", GATE_IP_GEN, 3, 0, 0),
+	GATE(ACLK_MDMA0, "aclk_mdma0", "aclk266_g2d",
 			GATE_BUS_G2D, 1, CLK_IGNORE_UNUSED, 0),
-	GATE(aclk_mdma1, "aclk_mdma1", "mout_user_aclk266",
+	GATE(ACLK_MDMA1, "aclk_mdma1", "mout_user_aclk266",
 			GATE_IP_GEN, 4, 0, 0),
 
-	GATE(smmu_rotator, "smmu_rotator", "dout_gen_blk",
+	GATE(SMMU_ROTATOR, "smmu_rotator", "dout_gen_blk",
 			GATE_IP_GEN, 6, 0, 0),
-	GATE(aclk_smmu_mdma0, "aclk_smmu_mdma0", "aclk266_g2d",
+	GATE(ACLK_SMMU_MDMA0, "aclk_smmu_mdma0", "aclk266_g2d",
 			GATE_BUS_G2D, 5, CLK_IGNORE_UNUSED, 0),
-	GATE(smmu_mdma0, "smmu_mdma0", "aclk266_g2d",
+	GATE(SMMU_MDMA0, "smmu_mdma0", "aclk266_g2d",
 			GATE_BUS_G2D, 20, CLK_IGNORE_UNUSED, 0),
-	GATE(smmu_jpeg, "smmu_jpeg", "dout_jpg_blk", GATE_IP_GEN, 7, 0, 0),
-	GATE(smmu_jpeg2, "smmu_jpeg2", "dout_jpg_blk", GATE_BUS_GEN, 28, 0, 0),
-	GATE(smmu_mdma1, "smmu_mdma1", "dout_gen_blk", GATE_IP_GEN, 9, 0, 0),
-
-	GATE(aclk_mscl0, "aclk_mscl0", "aclk400_mscl", GATE_BUS_MSCL, 0, 0, 0),
-	GATE(aclk_mscl1, "aclk_mscl1", "aclk400_mscl", GATE_BUS_MSCL, 1, 0, 0),
-	GATE(aclk_mscl2, "aclk_mscl2", "aclk400_mscl", GATE_BUS_MSCL, 2, 0, 0),
-	GATE(pclk_mscl0, "pclk_mscl0", "dout_mscl_blk", GATE_BUS_MSCL, 8, 0, 0),
-	GATE(pclk_mscl1, "pclk_mscl1", "dout_mscl_blk", GATE_BUS_MSCL, 9, 0, 0),
-	GATE(pclk_mscl2, "pclk_mscl2", "dout_mscl_blk",
+	GATE(SMMU_JPEG, "smmu_jpeg", "dout_jpg_blk", GATE_IP_GEN, 7, 0, 0),
+	GATE(SMMU_JPEG2, "smmu_jpeg2", "dout_jpg_blk", GATE_BUS_GEN, 28, 0, 0),
+	GATE(SMMU_MDMA1, "smmu_mdma1", "dout_gen_blk", GATE_IP_GEN, 9, 0, 0),
+
+	GATE(ACLK_MSCL0, "aclk_mscl0", "aclk400_mscl", GATE_BUS_MSCL, 0, 0, 0),
+	GATE(ACLK_MSCL1, "aclk_mscl1", "aclk400_mscl", GATE_BUS_MSCL, 1, 0, 0),
+	GATE(ACLK_MSCL2, "aclk_mscl2", "aclk400_mscl", GATE_BUS_MSCL, 2, 0, 0),
+	GATE(PCLK_MSCL0, "pclk_mscl0", "dout_mscl_blk", GATE_BUS_MSCL, 8, 0, 0),
+	GATE(PCLK_MSCL1, "pclk_mscl1", "dout_mscl_blk", GATE_BUS_MSCL, 9, 0, 0),
+	GATE(PCLK_MSCL2, "pclk_mscl2", "dout_mscl_blk",
 			GATE_BUS_MSCL, 10, 0, 0),
-	GATE(smmu_mscl0, "smmu_mscl0", "dout_mscl_blk", GATE_IP_MSCL, 8, 0, 0),
-	GATE(smmu_mscl1, "smmu_mscl1", "dout_mscl_blk", GATE_IP_MSCL, 9, 0, 0),
-	GATE(smmu_mscl2, "smmu_mscl2", "dout_mscl_blk", GATE_IP_MSCL, 10, 0, 0),
-	GATE(smmu_mixer, "smmu_mixer", "dout_disp1_blk",
+	GATE(SMMU_MSCL0, "smmu_mscl0", "dout_mscl_blk", GATE_IP_MSCL, 8, 0, 0),
+	GATE(SMMU_MSCL1, "smmu_mscl1", "dout_mscl_blk", GATE_IP_MSCL, 9, 0, 0),
+	GATE(SMMU_MSCL2, "smmu_mscl2", "dout_mscl_blk", GATE_IP_MSCL, 10, 0, 0),
+	GATE(SMMU_MIXER, "smmu_mixer", "dout_disp1_blk",
 			GATE_IP_DISP1, 9, 0, 0),
-	GATE(aclk_smmu_mixer, "aclk_smmu_mixer", "aclk200_disp1",
+	GATE(ACLK_SMMU_MIXER, "aclk_smmu_mixer", "aclk200_disp1",
 			GATE_BUS_DISP1, 9, CLK_IGNORE_UNUSED, 0),
 
 	/* aclk333 gates internal MFC busses and should not be gated. */
 	/* aclk266 also gates other IPs in psgen. It should not be gated. */
-	GATE(aclk266, "aclk266", "mout_user_aclk266",
+	GATE(ACLK266, "aclk266", "mout_user_aclk266",
 			GATE_BUS_NOC, 22, CLK_IGNORE_UNUSED, 0),
-	GATE(aclk200_disp1, "aclk200_disp1", "mout_aclk200_disp1",
+	GATE(ACLK200_DISP1, "aclk200_disp1", "mout_aclk200_disp1",
 			GATE_BUS_TOP, 18, CLK_IGNORE_UNUSED, 0),
 	/* gating of aclk300_gscl causes system hang. It should not be gated. */
-	GATE(aclk400_mscl, "aclk400_mscl", "mout_user_aclk400_mscl",
+	GATE(ACLK400_MSCL, "aclk400_mscl", "mout_user_aclk400_mscl",
 			GATE_BUS_TOP, 17, CLK_IGNORE_UNUSED, 0),
-	GATE(aclk300_disp1, "aclk300_disp1", "mout_user_aclk300_disp1",
+	GATE(ACLK300_DISP1, "aclk300_disp1", "mout_user_aclk300_disp1",
 			SRC_MASK_TOP2, 24, CLK_IGNORE_UNUSED, 0),
-	GATE(aclk266_isp, "aclk266_isp", "mout_user_aclk266_isp",
+	GATE(ACLK266_ISP, "aclk266_isp", "mout_user_aclk266_isp",
 			GATE_BUS_TOP, 13, 0, 0),
-	GATE(aclk400_isp, "aclk400_isp", "mout_user_aclk400_isp",
+	GATE(ACLK400_ISP, "aclk400_isp", "mout_user_aclk400_isp",
 			GATE_BUS_TOP, 16, 0, 0),
-	GATE(aclk333_432_isp0, "aclk333_432_isp0", "mout_user_aclk333_432_isp0",
+	GATE(ACLK333_432_ISP0, "aclk333_432_isp0", "mout_user_aclk333_432_isp0",
 			GATE_BUS_TOP, 5, 0, 0),
-	GATE(aclk333_432_isp, "aclk333_432_isp", "mout_user_aclk333_432_isp",
+	GATE(ACLK333_432_ISP, "aclk333_432_isp", "mout_user_aclk333_432_isp",
 			GATE_BUS_TOP, 8, 0, 0),
 	/* misc: mct, adc, chipid, wdt, rtc, sysreg etc */
-	GATE(pclk_mc, "pclk_mc", "aclk66_psgen", GATE_BUS_GEN, 12, 0, 0),
-	GATE(pclk_top_rtc, "pclk_top_rtc", "aclk66_psgen",
+	GATE(PCLK_MC, "pclk_mc", "aclk66_psgen", GATE_BUS_GEN, 12, 0, 0),
+	GATE(PCLK_TOP_RTC, "pclk_top_rtc", "aclk66_psgen",
 			GATE_IP_GEN, 5, 0, 0),
-	GATE(sclk_hsic_12m, "sclk_hsic_12m", "ffactor_hsic_12m",
+	GATE(SCLK_HSIC_12M, "sclk_hsic_12m", "ffactor_hsic_12m",
 			GATE_BUS_TOP, 29, 0, 0),
-	GATE(sclk_mphy_ixtal24, "sclk_mphy_ixtal24", "mphy_refclk_ixtal24",
+	GATE(SCLK_MPHY_IXTAL24, "sclk_mphy_ixtal24", "mphy_refclk_ixtal24",
 			GATE_BUS_TOP, 28, 0, 0),
 	/*
 	* HACK: When aclk_fimd1 is gated, aclk300_disp1 also gets gated as
@@ -1078,82 +1009,82 @@ static struct samsung_gate_clock exynos5420_gate_clks[] __initdata = {
 	* to hdmi, mixer IPs through internal busses. gating of aclk300_disp1
 	* breaks HDMI S2R.
 	*/
-	GATE(pclk_hdmiphy, "pclk_hdmiphy", "dout_disp1_blk",
+	GATE(PCLK_HDMIPHY, "pclk_hdmiphy", "dout_disp1_blk",
 			GATE_BUS_DISP1, 15, CLK_IGNORE_UNUSED, 0),
-	GATE(sclk_mphy_refclk, "sclk_mphy_refclk", "dout_mphy_refclk",
+	GATE(SCLK_MPHY_REFCLK, "sclk_mphy_refclk", "dout_mphy_refclk",
 			GATE_BUS_TOP, 30, 0, 0),
-	GATE(aclk_fimc_lite0, "aclk_fimc_lite0", "aclk333_432_gscl",
+	GATE(ACLK_FIMC_LITE0, "aclk_fimc_lite0", "aclk333_432_gscl",
 			GATE_IP_GSCL0, 5, 0, 0),
-	GATE(aclk_fimc_lite1, "aclk_fimc_lite1", "aclk333_432_gscl",
+	GATE(ACLK_FIMC_LITE1, "aclk_fimc_lite1", "aclk333_432_gscl",
 			GATE_IP_GSCL0, 6, 0, 0),
-	GATE(pclk_fimc_lite0, "pclk_fimc_lite0", "dout_gscl_blk_333",
+	GATE(PCLK_FIMC_LITE0, "pclk_fimc_lite0", "dout_gscl_blk_333",
 			GATE_IP_GSCL0, 10, 0, 0),
-	GATE(pclk_fimc_lite1, "pclk_fimc_lite1", "dout_gscl_blk_333",
+	GATE(PCLK_FIMC_LITE1, "pclk_fimc_lite1", "dout_gscl_blk_333",
 			GATE_IP_GSCL0, 11, 0, 0),
-	GATE(pclk_fimc_lite3, "pclk_fimc_lite3", "dout_gscl_blk_333",
+	GATE(PCLK_FIMC_LITE3, "pclk_fimc_lite3", "dout_gscl_blk_333",
 			GATE_BUS_GSCL0, 13, 0, 0),
 	/* g2d */
-	GATE(aclk_g2d, "aclk_g2d", "aclk333_g2d",
+	GATE(ACLK_G2D, "aclk_g2d", "aclk333_g2d",
 			GATE_BUS_G2D, 3, CLK_IGNORE_UNUSED, 0),
-	GATE(pclk_g2d, "pclk_g2d", "aclk266_g2d",
+	GATE(PCLK_G2D, "pclk_g2d", "aclk266_g2d",
 			GATE_BUS_G2D, 19, CLK_IGNORE_UNUSED, 0),
-	GATE(aclk_smmu_g2d, "aclk_smmu_g2d", "aclk333_g2d",
+	GATE(ACLK_SMMU_G2D, "aclk_smmu_g2d", "aclk333_g2d",
 			GATE_BUS_G2D, 7, CLK_IGNORE_UNUSED, 0),
-	GATE(smmu_g2d, "smmu_g2d", "aclk266_g2d",
+	GATE(SMMU_G2D, "smmu_g2d", "aclk266_g2d",
 			GATE_BUS_G2D, 22, CLK_IGNORE_UNUSED, 0),
 	/* sss */
-	GATE(aclk_sss, "aclk_sss", "aclk266_g2d",
+	GATE(ACLK_SSS, "aclk_sss", "aclk266_g2d",
 			GATE_BUS_G2D, 2, CLK_IGNORE_UNUSED, 0),
-	GATE(aclk_smmu_sss, "aclk_smmu_sss", "aclk266_g2d",
+	GATE(ACLK_SMMU_SSS, "aclk_smmu_sss", "aclk266_g2d",
 			GATE_BUS_G2D, 6, CLK_IGNORE_UNUSED, 0),
-	GATE(smmu_sss, "smmu_sss", "aclk266_g2d",
+	GATE(SMMU_SSS, "smmu_sss", "aclk266_g2d",
 			GATE_BUS_G2D, 21, CLK_IGNORE_UNUSED, 0),
 	/* slim_sss */
-	GATE(aclk_slim_sss, "aclk_slim_sss", "aclk266_g2d",
+	GATE(ACLK_SLIM_SSS, "aclk_slim_sss", "aclk266_g2d",
 			GATE_BUS_G2D, 12, CLK_IGNORE_UNUSED, 0),
-	GATE(aclk_smmu_slim_sss, "aclk_smmu_slim_sss", "aclk266_g2d",
+	GATE(ACLK_SMMU_SLIM_SSS, "aclk_smmu_slim_sss", "aclk266_g2d",
 			GATE_BUS_G2D, 13, CLK_IGNORE_UNUSED, 0),
-	GATE(smmu_slim_sss, "smmu_slim_sss", "aclk266_g2d",
+	GATE(SMMU_SLIM_SSS, "smmu_slim_sss", "aclk266_g2d",
 			GATE_BUS_G2D, 28, CLK_IGNORE_UNUSED, 0),
 	/* ISP */
-	GATE(sclk_pwm_isp, "sclk_pwm_isp", "dout_pwm_isp",
+	GATE(SCLK_PWM_ISP, "sclk_pwm_isp", "dout_pwm_isp",
 			GATE_TOP_SCLK_ISP, 3, 0, 0),
-	GATE(sclk_uart_isp, "sclk_uart_isp", "dout_uart_isp",
+	GATE(SCLK_UART_ISP, "sclk_uart_isp", "dout_uart_isp",
 			GATE_TOP_SCLK_ISP, 0, 0, 0),
-	GATE(sclk_spi0_isp, "sclk_spi0_isp", "dout_spi0_isp_pre",
+	GATE(SCLK_SPI0_ISP, "sclk_spi0_isp", "dout_spi0_isp_pre",
 			GATE_TOP_SCLK_ISP, 1, 0, 0),
-	GATE(sclk_spi1_isp, "sclk_spi1_isp", "dout_spi1_isp_pre",
+	GATE(SCLK_SPI1_ISP, "sclk_spi1_isp", "dout_spi1_isp_pre",
 			GATE_TOP_SCLK_ISP, 2, 0, 0),
-	GATE(sclk_isp_sensor0, "sclk_isp_sensor0", "dout_isp_sensor0",
+	GATE(SCLK_ISP_SENSOR0, "sclk_isp_sensor0", "dout_isp_sensor0",
 			GATE_TOP_SCLK_ISP, 4, 0, 0),
-	GATE(sclk_isp_sensor1, "sclk_isp_sensor1", "dout_isp_sensor1",
+	GATE(SCLK_ISP_SENSOR1, "sclk_isp_sensor1", "dout_isp_sensor1",
 			GATE_TOP_SCLK_ISP, 8, 0, 0),
-	GATE(sclk_isp_sensor2, "sclk_isp_sensor2", "dout_isp_sensor2",
+	GATE(SCLK_ISP_SENSOR2, "sclk_isp_sensor2", "dout_isp_sensor2",
 			GATE_TOP_SCLK_ISP, 12, 0, 0),
 };
 
 static struct samsung_pll_clock exynos5420_plls[nr_plls] __initdata = {
-	[apll] = PLL(pll_2550, fout_apll, "fout_apll", "fin_pll", APLL_LOCK,
+	[apll] = PLL(pll_2550, FOUT_APLL, "fout_apll", "fin_pll", APLL_LOCK,
 		APLL_CON0, NULL),
-	[cpll] = PLL(pll_2550, fout_cpll, "fout_cpll", "fin_pll", CPLL_LOCK,
+	[cpll] = PLL(pll_2550, FOUT_CPLL, "fout_cpll", "fin_pll", CPLL_LOCK,
 		CPLL_CON0, NULL),
-	[dpll] = PLL(pll_2550, fout_dpll, "fout_dpll", "fin_pll", DPLL_LOCK,
+	[dpll] = PLL(pll_2550, FOUT_DPLL, "fout_dpll", "fin_pll", DPLL_LOCK,
 		DPLL_CON0, NULL),
-	[epll] = PLL(pll_2650, fout_epll, "fout_epll", "fin_pll", EPLL_LOCK,
+	[epll] = PLL(pll_2650, FOUT_EPLL, "fout_epll", "fin_pll", EPLL_LOCK,
 		EPLL_CON0, NULL),
-	[rpll] = PLL(pll_2650, fout_rpll, "fout_rpll", "fin_pll", RPLL_LOCK,
+	[rpll] = PLL(pll_2650, FOUT_RPLL, "fout_rpll", "fin_pll", RPLL_LOCK,
 		RPLL_CON0, NULL),
-	[ipll] = PLL(pll_2550, fout_ipll, "fout_ipll", "fin_pll", IPLL_LOCK,
+	[ipll] = PLL(pll_2550, FOUT_IPLL, "fout_ipll", "fin_pll", IPLL_LOCK,
 		IPLL_CON0, NULL),
-	[spll] = PLL(pll_2550, fout_spll, "fout_spll", "fin_pll", SPLL_LOCK,
+	[spll] = PLL(pll_2550, FOUT_SPLL, "fout_spll", "fin_pll", SPLL_LOCK,
 		SPLL_CON0, NULL),
-	[vpll] = PLL(pll_2550, fout_vpll, "fout_vpll", "fin_pll", VPLL_LOCK,
+	[vpll] = PLL(pll_2550, FOUT_VPLL, "fout_vpll", "fin_pll", VPLL_LOCK,
 		VPLL_CON0, NULL),
-	[mpll] = PLL(pll_2550, fout_mpll, "fout_mpll", "fin_pll", MPLL_LOCK,
+	[mpll] = PLL(pll_2550, FOUT_MPLL, "fout_mpll", "fin_pll", MPLL_LOCK,
 		MPLL_CON0, NULL),
-	[bpll] = PLL(pll_2550, fout_bpll, "fout_bpll", "fin_pll", BPLL_LOCK,
+	[bpll] = PLL(pll_2550, FOUT_BPLL, "fout_bpll", "fin_pll", BPLL_LOCK,
 		BPLL_CON0, NULL),
-	[kpll] = PLL(pll_2550, fout_kpll, "fout_kpll", "fin_pll", KPLL_LOCK,
+	[kpll] = PLL(pll_2550, FOUT_KPLL, "fout_kpll", "fin_pll", KPLL_LOCK,
 		KPLL_CON0, NULL),
 };
 
@@ -1175,7 +1106,7 @@ static void __init exynos5420_clk_init(struct device_node *np)
 		panic("%s: unable to determine soc\n", __func__);
 	}
 
-	ctx = samsung_clk_init(np, reg_base, nr_clks);
+	ctx = samsung_clk_init(np, reg_base, NR_CLKS);
 	if (!ctx)
 		panic("%s: unable to allocate context.\n", __func__);
 
diff --git a/include/dt-bindings/clk/exynos5420-clk.h b/include/dt-bindings/clk/exynos5420-clk.h
new file mode 100644
index 0000000..5822e2f
--- /dev/null
+++ b/include/dt-bindings/clk/exynos5420-clk.h
@@ -0,0 +1,236 @@
+/*
+ * Copyright (c) 2013 Samsung Electronics Co., Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Provides Constants for Exynos5420 clocks.
+*/
+
+#ifndef _DT_BINDINGS_CLK_EXYNOS5420_H
+#define _DT_BINDINGS_CLK_EXYNOS5420_H
+
+#define NONE		0
+#define FIN_PLL		1
+#define FOUT_APLL		2
+#define FOUT_CPLL		3
+#define FOUT_DPLL		4
+#define FOUT_EPLL		5
+#define FOUT_RPLL		6
+#define FOUT_IPLL		7
+#define FOUT_SPLL		8
+#define FOUT_VPLL		9
+#define FOUT_MPLL		10
+#define FOUT_BPLL		11
+#define FOUT_KPLL		12
+#define SCLK_UART0		13
+#define SCLK_UART1		14
+#define SCLK_UART2		15
+#define SCLK_UART3		16
+#define SCLK_MMC0		17
+#define SCLK_MMC1		18
+#define SCLK_MMC2		19
+#define SCLK_SPI0		20
+#define SCLK_SPI1		21
+#define SCLK_SPI2		22
+#define SCLK_I2S1		23
+#define SCLK_I2S2		24
+#define SCLK_PCM1		25
+#define SCLK_PCM2		26
+#define SCLK_SPDIF		27
+#define SCLK_HDMI		28
+#define SCLK_PIXEL		29
+#define SCLK_DP1		30
+#define SCLK_MIPI1		31
+#define SCLK_FIMD1		32
+#define SCLK_MAUDIO0	33
+#define SCLK_MAUPCM0	34
+#define SCLK_USBD300	35
+#define SCLK_USBD301	36
+#define SCLK_USBPHY300	37
+#define SCLK_USBPHY301	38
+#define SCLK_UNIPRO		39
+#define SCLK_PWM		40
+#define SCLK_GSCL_WA	41
+#define SCLK_GSCL_WB	42
+#define SCLK_HDMIPHY	43
+#define SCLK_MPHY_REFCLK	44
+#define SCLK_SPI0_ISP	45
+#define SCLK_SPI1_ISP	46
+#define SCLK_UART_ISP	47
+#define SCLK_ISP_SENSOR0	48
+#define SCLK_ISP_SENSOR1	49
+#define SCLK_ISP_SENSOR2	50
+#define SCLK_PWM_ISP	51
+#define SCLK_HSIC_12M	52
+#define SCLK_MPHY_IXTAL24	53
+#define ACLK66_PERIC	54
+#define PCLK_UART0		55
+#define PCLK_UART1		56
+#define PCLK_UART2		57
+#define PCLK_UART3		58
+#define PCLK_I2C0		59
+#define PCLK_I2C1		60
+#define PCLK_I2C2		61
+#define PCLK_I2C3		62
+#define PCLK_USI0		63
+#define PCLK_USI1		64
+#define PCLK_USI2		65
+#define PCLK_USI3		66
+#define PCLK_I2C_HDMI	67
+#define PCLK_TSADC		68
+#define PCLK_SPI0		69
+#define PCLK_SPI1		70
+#define PCLK_SPI2		71
+#define KEYIF		72
+#define PCLK_I2S1		73
+#define PCLK_I2S2		74
+#define PCLK_PCM1		75
+#define PCLK_PCM2		76
+#define PCLK_PWM		77
+#define PCLK_SPDIF		78
+#define PCLK_USI4		79
+#define PCLK_USI5		80
+#define PCLK_USI6		81
+#define ACLK66_PSGEN	82
+#define PCLK_CHIPID		83
+#define PCLK_SYSREG		84
+#define PCLK_TZPC0		85
+#define PCLK_TZPC1		86
+#define PCLK_TZPC2		87
+#define PCLK_TZPC3		88
+#define PCLK_TZPC4		89
+#define PCLK_TZPC5		90
+#define PCLK_TZPC6		91
+#define PCLK_TZPC7		92
+#define PCLK_TZPC8		93
+#define PCLK_TZPC9		94
+#define HDMI_CEC		95
+#define SECKEY		96
+#define PCLK_MCT		97
+#define PCLK_WDT		98
+#define PCLK_RTC		99
+#define PCLK_TMU		100
+#define PCLK_TMU_GPU	101
+#define PCLK66_GPIO		102
+#define ACLK200_FSYS2	103
+#define ACLK_MMC0		104
+#define ACLK_MMC1		105
+#define ACLK_MMC2		106
+#define HCLK_SROMC		107
+#define UFS		108
+#define ACLK200_FSYS	109
+#define TSI		110
+#define ACLK_PDMA0		111
+#define ACLK_PDMA1		112
+#define ACLK_RTIC		113
+#define HCLK_USBH20		114
+#define HCLK_USBD300	115
+#define HCLK_USBD301	116
+#define PCLK200_FSYS	117
+#define ACLK400_MSCL	118
+#define ACLK_MSCL0		119
+#define ACLK_MSCL1		120
+#define ACLK_MSCL2		121
+#define SMMU_MSCL0		122
+#define SMMU_MSCL1		123
+#define SMMU_MSCL2		124
+#define ACLK333		125
+#define ACLK_MFC		126
+#define SMMU_MFCL		127
+#define SMMU_MFCR		128
+#define ACLK200_DISP1	129
+#define PCLK_DSIM1		130
+#define PCLK_DP1		131
+#define PCLK_HDMI		132
+#define ACLK300_DISP1	133
+#define ACLK_FIMD1		134
+#define SMMU_FIMD1M0	135
+#define SMMU_FIMD1M1	136
+#define ACLK400_DISP1	137
+#define ACLK166		138
+#define ACLK_MIXER		139
+#define ACLK266		140
+#define ACLK_ROTATOR	141
+#define ACLK_MDMA1		142
+#define SMMU_ROTATOR	143
+#define SMMU_MDMA1		144
+#define ACLK300_JPEG	145
+#define ACLK_JPEG		146
+#define ACLK_JPEG2		147
+#define SMMU_JPEG		148
+#define ACLK300_GSCL	149
+#define SMMU_GSCL0		150
+#define SMMU_GSCL1		151
+#define PCLK_GSCL_WA	152
+#define GSCL_WB		153
+#define ACLK_GSCL0		154
+#define ACLK_GSCL1		155
+#define ACLK_FIMC_3AA	156
+#define ACLK266_G2D		157
+#define ACLK_SSS		158
+#define ACLK_SLIM_SSS	159
+#define ACLK_MDMA0		160
+#define ACLK333_G2D		161
+#define ACLK_G2D		162
+#define ACLK333_432_GSCL	163
+#define SMMU_3AA		164
+#define SMMU_FIMCL0		165
+#define SMMU_FIMCL1		166
+#define SMMU_FIMCL3		167
+#define ACLK_FIMC_LITE3	168
+#define CLK_G3D		169
+#define PCLK_MFC		170
+#define SMMU_MIXER		171
+#define PCLK_TZPC10		172
+#define PCLK_TZPC11		173
+#define PCLK_MC		174
+#define PCLK_TOP_RTC	175
+#define SMMU_JPEG2		176
+#define PCLK_ROTATOR	177
+#define SMMU_RTIC		178
+#define PCLK_G2D		179
+#define ACLK_SMMU_G2D	180
+#define SMMU_G2D		181
+#define ACLK_SMMU_MDMA0	182
+#define SMMU_MDMA0		183
+#define ACLK_SMMU_SSS	184
+#define SMMU_SSS		185
+#define SMMU_SLIM_SSS	186
+#define ACLK_SMMU_SLIM_SSS	187
+#define ACLK266_ISP		188
+#define ACLK400_ISP		189
+#define ACLK333_432_ISP0	190
+#define ACLK333_432_ISP	191
+#define ACLK_SMMU_MIXER	192
+#define PCLK_HDMIPHY	193
+#define PCLK_GSCL0		194
+#define PCLK_GSCL1		195
+#define PCLK_FIMC_3AA	196
+#define ACLK_FIMC_LITE0	197
+#define ACLK_FIMC_LITE1	198
+#define PCLK_FIMC_LITE0	199
+#define PCLK_FIMC_LITE1	200
+#define PCLK_FIMC_LITE3	201
+#define PCLK_MSCL0		202
+#define PCLK_MSCL1		203
+#define PCLK_MSCL2		204
+#define MOUT_HDMI		205
+#define MOUT_FIMD1		206
+#define MOUT_MAUDIO0	207
+#define MOUT_SPI0		208
+#define MOUT_SPI1		209
+#define MOUT_SPI2		210
+#define MOUT_SW_ACLK333	211
+#define MOUT_USER_ACLK333	212
+#define MOUT_SW_ACLK300_GSCL		213
+#define MOUT_USER_ACLK300_GSCL	214
+#define MOUT_SW_ACLK333_432_GSCL	215
+#define MOUT_USER_ACLK333_432_GSCL	216
+#define MOUT_G3D		217
+#define DOUT_PIXEL		218
+
+#define NR_CLKS		219
+
+#endif
-- 
1.7.10.4
