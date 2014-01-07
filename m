From: a.hajda@samsung.com (Andrzej Hajda)
Date: Tue, 07 Jan 2014 15:47:34 +0100
Subject: [PATCH RESEND v2 06/12] clk: exynos5250: replace clock ID private
 enums with IDs from DT header
In-Reply-To: <1389106060-20291-1-git-send-email-a.hajda@samsung.com>
References: <1389106060-20291-1-git-send-email-a.hajda@samsung.com>
Message-ID: <1389106060-20291-7-git-send-email-a.hajda@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch replaces private enum clock IDs in the driver with macros provided
by the DT header.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/clk/samsung/clk-exynos5250.c | 559 +++++++++++++++++------------------
 1 file changed, 264 insertions(+), 295 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5250.c b/drivers/clk/samsung/clk-exynos5250.c
index 18d0b5e..25c77ab 100644
--- a/drivers/clk/samsung/clk-exynos5250.c
+++ b/drivers/clk/samsung/clk-exynos5250.c
@@ -10,6 +10,7 @@
  * Common Clock Framework support for Exynos5250 SoC.
 */
 
+#include <dt-bindings/clock/exynos5250.h>
 #include <linux/clk.h>
 #include <linux/clkdev.h>
 #include <linux/clk-provider.h>
@@ -85,52 +86,6 @@ enum exynos5250_plls {
 };
 
 /*
- * Let each supported clock get a unique id. This id is used to lookup the clock
- * for device tree based platforms. The clocks are categorized into three
- * sections: core, sclk gate and bus interface gate clocks.
- *
- * When adding a new clock to this list, it is advised to choose a clock
- * category and add it to the end of that category. That is because the the
- * device tree source file is referring to these ids and any change in the
- * sequence number of existing clocks will require corresponding change in the
- * device tree files. This limitation would go away when pre-processor support
- * for dtc would be available.
- */
-enum exynos5250_clks {
-	none,
-
-	/* core clocks */
-	fin_pll, fout_apll, fout_mpll, fout_bpll, fout_gpll, fout_cpll,
-	fout_epll, fout_vpll,
-
-	/* gate for special clocks (sclk) */
-	sclk_cam_bayer = 128, sclk_cam0, sclk_cam1, sclk_gscl_wa, sclk_gscl_wb,
-	sclk_fimd1, sclk_mipi1, sclk_dp, sclk_hdmi, sclk_pixel, sclk_audio0,
-	sclk_mmc0, sclk_mmc1, sclk_mmc2, sclk_mmc3, sclk_sata, sclk_usb3,
-	sclk_jpeg, sclk_uart0, sclk_uart1, sclk_uart2, sclk_uart3, sclk_pwm,
-	sclk_audio1, sclk_audio2, sclk_spdif, sclk_spi0, sclk_spi1, sclk_spi2,
-	div_i2s1, div_i2s2, sclk_hdmiphy,
-
-	/* gate clocks */
-	gscl0 = 256, gscl1, gscl2, gscl3, gscl_wa, gscl_wb, smmu_gscl0,
-	smmu_gscl1, smmu_gscl2, smmu_gscl3, mfc, smmu_mfcl, smmu_mfcr, rotator,
-	jpeg, mdma1, smmu_rotator, smmu_jpeg, smmu_mdma1, pdma0, pdma1, sata,
-	usbotg, mipi_hsi, sdmmc0, sdmmc1, sdmmc2, sdmmc3, sromc, usb2, usb3,
-	sata_phyctrl, sata_phyi2c, uart0, uart1, uart2,	uart3, uart4, i2c0,
-	i2c1, i2c2, i2c3, i2c4, i2c5, i2c6, i2c7, i2c_hdmi, adc, spi0, spi1,
-	spi2, i2s1, i2s2, pcm1, pcm2, pwm, spdif, ac97, hsi2c0, hsi2c1, hsi2c2,
-	hsi2c3, chipid, sysreg, pmu, cmu_top, cmu_core, cmu_mem, tzpc0, tzpc1,
-	tzpc2, tzpc3, tzpc4, tzpc5, tzpc6, tzpc7, tzpc8, tzpc9, hdmi_cec, mct,
-	wdt, rtc, tmu, fimd1, mie1, dsim0, dp, mixer, hdmi, g2d, mdma0,
-	smmu_mdma0,
-
-	/* mux clocks */
-	mout_hdmi = 1024,
-
-	nr_clks,
-};
-
-/*
  * list of controller registers to be saved and restored during a
  * suspend/resume cycle.
  */
@@ -231,24 +186,24 @@ PNAME(mout_spdif_p)	= { "sclk_audio0", "sclk_audio1", "sclk_audio2",
 
 /* fixed rate clocks generated outside the soc */
 static struct samsung_fixed_rate_clock exynos5250_fixed_rate_ext_clks[] __initdata = {
-	FRATE(fin_pll, "fin_pll", NULL, CLK_IS_ROOT, 0),
+	FRATE(CLK_FIN_PLL, "fin_pll", NULL, CLK_IS_ROOT, 0),
 };
 
 /* fixed rate clocks generated inside the soc */
 static struct samsung_fixed_rate_clock exynos5250_fixed_rate_clks[] __initdata = {
-	FRATE(sclk_hdmiphy, "sclk_hdmiphy", NULL, CLK_IS_ROOT, 24000000),
-	FRATE(none, "sclk_hdmi27m", NULL, CLK_IS_ROOT, 27000000),
-	FRATE(none, "sclk_dptxphy", NULL, CLK_IS_ROOT, 24000000),
-	FRATE(none, "sclk_uhostphy", NULL, CLK_IS_ROOT, 48000000),
+	FRATE(CLK_SCLK_HDMIPHY, "sclk_hdmiphy", NULL, CLK_IS_ROOT, 24000000),
+	FRATE(0, "sclk_hdmi27m", NULL, CLK_IS_ROOT, 27000000),
+	FRATE(0, "sclk_dptxphy", NULL, CLK_IS_ROOT, 24000000),
+	FRATE(0, "sclk_uhostphy", NULL, CLK_IS_ROOT, 48000000),
 };
 
 static struct samsung_fixed_factor_clock exynos5250_fixed_factor_clks[] __initdata = {
-	FFACTOR(none, "fout_mplldiv2", "fout_mpll", 1, 2, 0),
-	FFACTOR(none, "fout_bplldiv2", "fout_bpll", 1, 2, 0),
+	FFACTOR(0, "fout_mplldiv2", "fout_mpll", 1, 2, 0),
+	FFACTOR(0, "fout_bplldiv2", "fout_bpll", 1, 2, 0),
 };
 
 static struct samsung_mux_clock exynos5250_pll_pmux_clks[] __initdata = {
-	MUX(none, "mout_vpllsrc", mout_vpllsrc_p, SRC_TOP2, 0, 1),
+	MUX(0, "mout_vpllsrc", mout_vpllsrc_p, SRC_TOP2, 0, 1),
 };
 
 static struct samsung_mux_clock exynos5250_mux_clks[] __initdata = {
@@ -262,74 +217,74 @@ static struct samsung_mux_clock exynos5250_mux_clks[] __initdata = {
 	/*
 	 * CMU_CPU
 	 */
-	MUX_FA(none, "mout_apll", mout_apll_p, SRC_CPU, 0, 1,
+	MUX_FA(0, "mout_apll", mout_apll_p, SRC_CPU, 0, 1,
 					CLK_SET_RATE_PARENT, 0, "mout_apll"),
-	MUX_A(none, "mout_cpu", mout_cpu_p, SRC_CPU, 16, 1, "mout_cpu"),
+	MUX_A(0, "mout_cpu", mout_cpu_p, SRC_CPU, 16, 1, "mout_cpu"),
 
 	/*
 	 * CMU_CORE
 	 */
-	MUX_A(none, "mout_mpll", mout_mpll_p, SRC_CORE1, 8, 1, "mout_mpll"),
+	MUX_A(0, "mout_mpll", mout_mpll_p, SRC_CORE1, 8, 1, "mout_mpll"),
 
 	/*
 	 * CMU_TOP
 	 */
-	MUX(none, "mout_aclk166", mout_aclk166_p, SRC_TOP0, 8, 1),
-	MUX(none, "mout_aclk200", mout_aclk200_p, SRC_TOP0, 12, 1),
-	MUX(none, "mout_aclk333", mout_aclk166_p, SRC_TOP0, 16, 1),
-
-	MUX(none, "mout_cpll", mout_cpll_p, SRC_TOP2, 8, 1),
-	MUX(none, "mout_epll", mout_epll_p, SRC_TOP2, 12, 1),
-	MUX(none, "mout_vpll", mout_vpll_p, SRC_TOP2, 16, 1),
-	MUX(none, "mout_mpll_user", mout_mpll_user_p, SRC_TOP2, 20, 1),
-	MUX(none, "mout_bpll_user", mout_bpll_user_p, SRC_TOP2, 24, 1),
-
-	MUX(none, "mout_aclk200_disp1_sub", mout_aclk200_sub_p, SRC_TOP3, 4, 1),
-	MUX(none, "mout_aclk266_gscl_sub", mout_aclk266_sub_p, SRC_TOP3, 8, 1),
-	MUX(none, "mout_aclk333_sub", mout_aclk333_sub_p, SRC_TOP3, 24, 1),
-
-	MUX(none, "mout_cam_bayer", mout_group1_p, SRC_GSCL, 12, 4),
-	MUX(none, "mout_cam0", mout_group1_p, SRC_GSCL, 16, 4),
-	MUX(none, "mout_cam1", mout_group1_p, SRC_GSCL, 20, 4),
-	MUX(none, "mout_gscl_wa", mout_group1_p, SRC_GSCL, 24, 4),
-	MUX(none, "mout_gscl_wb", mout_group1_p, SRC_GSCL, 28, 4),
-
-	MUX(none, "mout_fimd1", mout_group1_p, SRC_DISP1_0, 0, 4),
-	MUX(none, "mout_mipi1", mout_group1_p, SRC_DISP1_0, 12, 4),
-	MUX(none, "mout_dp", mout_group1_p, SRC_DISP1_0, 16, 4),
-	MUX(mout_hdmi, "mout_hdmi", mout_hdmi_p, SRC_DISP1_0, 20, 1),
-
-	MUX(none, "mout_audio0", mout_audio0_p, SRC_MAU, 0, 4),
-
-	MUX(none, "mout_mmc0", mout_group1_p, SRC_FSYS, 0, 4),
-	MUX(none, "mout_mmc1", mout_group1_p, SRC_FSYS, 4, 4),
-	MUX(none, "mout_mmc2", mout_group1_p, SRC_FSYS, 8, 4),
-	MUX(none, "mout_mmc3", mout_group1_p, SRC_FSYS, 12, 4),
-	MUX(none, "mout_sata", mout_aclk200_p, SRC_FSYS, 24, 1),
-	MUX(none, "mout_usb3", mout_usb3_p, SRC_FSYS, 28, 1),
-
-	MUX(none, "mout_jpeg", mout_group1_p, SRC_GEN, 0, 4),
-
-	MUX(none, "mout_uart0", mout_group1_p, SRC_PERIC0, 0, 4),
-	MUX(none, "mout_uart1", mout_group1_p, SRC_PERIC0, 4, 4),
-	MUX(none, "mout_uart2", mout_group1_p, SRC_PERIC0, 8, 4),
-	MUX(none, "mout_uart3", mout_group1_p, SRC_PERIC0, 12, 4),
-	MUX(none, "mout_pwm", mout_group1_p, SRC_PERIC0, 24, 4),
-
-	MUX(none, "mout_audio1", mout_audio1_p, SRC_PERIC1, 0, 4),
-	MUX(none, "mout_audio2", mout_audio2_p, SRC_PERIC1, 4, 4),
-	MUX(none, "mout_spdif", mout_spdif_p, SRC_PERIC1, 8, 2),
-	MUX(none, "mout_spi0", mout_group1_p, SRC_PERIC1, 16, 4),
-	MUX(none, "mout_spi1", mout_group1_p, SRC_PERIC1, 20, 4),
-	MUX(none, "mout_spi2", mout_group1_p, SRC_PERIC1, 24, 4),
+	MUX(0, "mout_aclk166", mout_aclk166_p, SRC_TOP0, 8, 1),
+	MUX(0, "mout_aclk200", mout_aclk200_p, SRC_TOP0, 12, 1),
+	MUX(0, "mout_aclk333", mout_aclk166_p, SRC_TOP0, 16, 1),
+
+	MUX(0, "mout_cpll", mout_cpll_p, SRC_TOP2, 8, 1),
+	MUX(0, "mout_epll", mout_epll_p, SRC_TOP2, 12, 1),
+	MUX(0, "mout_vpll", mout_vpll_p, SRC_TOP2, 16, 1),
+	MUX(0, "mout_mpll_user", mout_mpll_user_p, SRC_TOP2, 20, 1),
+	MUX(0, "mout_bpll_user", mout_bpll_user_p, SRC_TOP2, 24, 1),
+
+	MUX(0, "mout_aclk200_disp1_sub", mout_aclk200_sub_p, SRC_TOP3, 4, 1),
+	MUX(0, "mout_aclk266_gscl_sub", mout_aclk266_sub_p, SRC_TOP3, 8, 1),
+	MUX(0, "mout_aclk333_sub", mout_aclk333_sub_p, SRC_TOP3, 24, 1),
+
+	MUX(0, "mout_cam_bayer", mout_group1_p, SRC_GSCL, 12, 4),
+	MUX(0, "mout_cam0", mout_group1_p, SRC_GSCL, 16, 4),
+	MUX(0, "mout_cam1", mout_group1_p, SRC_GSCL, 20, 4),
+	MUX(0, "mout_gscl_wa", mout_group1_p, SRC_GSCL, 24, 4),
+	MUX(0, "mout_gscl_wb", mout_group1_p, SRC_GSCL, 28, 4),
+
+	MUX(0, "mout_fimd1", mout_group1_p, SRC_DISP1_0, 0, 4),
+	MUX(0, "mout_mipi1", mout_group1_p, SRC_DISP1_0, 12, 4),
+	MUX(0, "mout_dp", mout_group1_p, SRC_DISP1_0, 16, 4),
+	MUX(CLK_MOUT_HDMI, "mout_hdmi", mout_hdmi_p, SRC_DISP1_0, 20, 1),
+
+	MUX(0, "mout_audio0", mout_audio0_p, SRC_MAU, 0, 4),
+
+	MUX(0, "mout_mmc0", mout_group1_p, SRC_FSYS, 0, 4),
+	MUX(0, "mout_mmc1", mout_group1_p, SRC_FSYS, 4, 4),
+	MUX(0, "mout_mmc2", mout_group1_p, SRC_FSYS, 8, 4),
+	MUX(0, "mout_mmc3", mout_group1_p, SRC_FSYS, 12, 4),
+	MUX(0, "mout_sata", mout_aclk200_p, SRC_FSYS, 24, 1),
+	MUX(0, "mout_usb3", mout_usb3_p, SRC_FSYS, 28, 1),
+
+	MUX(0, "mout_jpeg", mout_group1_p, SRC_GEN, 0, 4),
+
+	MUX(0, "mout_uart0", mout_group1_p, SRC_PERIC0, 0, 4),
+	MUX(0, "mout_uart1", mout_group1_p, SRC_PERIC0, 4, 4),
+	MUX(0, "mout_uart2", mout_group1_p, SRC_PERIC0, 8, 4),
+	MUX(0, "mout_uart3", mout_group1_p, SRC_PERIC0, 12, 4),
+	MUX(0, "mout_pwm", mout_group1_p, SRC_PERIC0, 24, 4),
+
+	MUX(0, "mout_audio1", mout_audio1_p, SRC_PERIC1, 0, 4),
+	MUX(0, "mout_audio2", mout_audio2_p, SRC_PERIC1, 4, 4),
+	MUX(0, "mout_spdif", mout_spdif_p, SRC_PERIC1, 8, 2),
+	MUX(0, "mout_spi0", mout_group1_p, SRC_PERIC1, 16, 4),
+	MUX(0, "mout_spi1", mout_group1_p, SRC_PERIC1, 20, 4),
+	MUX(0, "mout_spi2", mout_group1_p, SRC_PERIC1, 24, 4),
 
 	/*
 	 * CMU_CDREX
 	 */
-	MUX(none, "mout_bpll", mout_bpll_p, SRC_CDREX, 0, 1),
+	MUX(0, "mout_bpll", mout_bpll_p, SRC_CDREX, 0, 1),
 
-	MUX(none, "mout_mpll_fout", mout_mpll_fout_p, PLL_DIV2_SEL, 4, 1),
-	MUX(none, "mout_bpll_fout", mout_bpll_fout_p, PLL_DIV2_SEL, 0, 1),
+	MUX(0, "mout_mpll_fout", mout_mpll_fout_p, PLL_DIV2_SEL, 4, 1),
+	MUX(0, "mout_bpll_fout", mout_bpll_fout_p, PLL_DIV2_SEL, 0, 1),
 };
 
 static struct samsung_div_clock exynos5250_div_clks[] __initdata = {
@@ -343,81 +298,81 @@ static struct samsung_div_clock exynos5250_div_clks[] __initdata = {
 	/*
 	 * CMU_CPU
 	 */
-	DIV(none, "div_arm", "mout_cpu", DIV_CPU0, 0, 3),
-	DIV(none, "div_apll", "mout_apll", DIV_CPU0, 24, 3),
-	DIV_A(none, "div_arm2", "div_arm", DIV_CPU0, 28, 3, "armclk"),
+	DIV(0, "div_arm", "mout_cpu", DIV_CPU0, 0, 3),
+	DIV(0, "div_apll", "mout_apll", DIV_CPU0, 24, 3),
+	DIV_A(0, "div_arm2", "div_arm", DIV_CPU0, 28, 3, "armclk"),
 
 	/*
 	 * CMU_TOP
 	 */
-	DIV(none, "div_aclk66", "div_aclk66_pre", DIV_TOP0, 0, 3),
-	DIV(none, "div_aclk166", "mout_aclk166", DIV_TOP0, 8, 3),
-	DIV(none, "div_aclk200", "mout_aclk200", DIV_TOP0, 12, 3),
-	DIV(none, "div_aclk266", "mout_mpll_user", DIV_TOP0, 16, 3),
-	DIV(none, "div_aclk333", "mout_aclk333", DIV_TOP0, 20, 3),
-
-	DIV(none, "div_aclk66_pre", "mout_mpll_user", DIV_TOP1, 24, 3),
-
-	DIV(none, "div_cam_bayer", "mout_cam_bayer", DIV_GSCL, 12, 4),
-	DIV(none, "div_cam0", "mout_cam0", DIV_GSCL, 16, 4),
-	DIV(none, "div_cam1", "mout_cam1", DIV_GSCL, 20, 4),
-	DIV(none, "div_gscl_wa", "mout_gscl_wa", DIV_GSCL, 24, 4),
-	DIV(none, "div_gscl_wb", "mout_gscl_wb", DIV_GSCL, 28, 4),
-
-	DIV(none, "div_fimd1", "mout_fimd1", DIV_DISP1_0, 0, 4),
-	DIV(none, "div_mipi1", "mout_mipi1", DIV_DISP1_0, 16, 4),
-	DIV_F(none, "div_mipi1_pre", "div_mipi1",
+	DIV(0, "div_aclk66", "div_aclk66_pre", DIV_TOP0, 0, 3),
+	DIV(0, "div_aclk166", "mout_aclk166", DIV_TOP0, 8, 3),
+	DIV(0, "div_aclk200", "mout_aclk200", DIV_TOP0, 12, 3),
+	DIV(0, "div_aclk266", "mout_mpll_user", DIV_TOP0, 16, 3),
+	DIV(0, "div_aclk333", "mout_aclk333", DIV_TOP0, 20, 3),
+
+	DIV(0, "div_aclk66_pre", "mout_mpll_user", DIV_TOP1, 24, 3),
+
+	DIV(0, "div_cam_bayer", "mout_cam_bayer", DIV_GSCL, 12, 4),
+	DIV(0, "div_cam0", "mout_cam0", DIV_GSCL, 16, 4),
+	DIV(0, "div_cam1", "mout_cam1", DIV_GSCL, 20, 4),
+	DIV(0, "div_gscl_wa", "mout_gscl_wa", DIV_GSCL, 24, 4),
+	DIV(0, "div_gscl_wb", "mout_gscl_wb", DIV_GSCL, 28, 4),
+
+	DIV(0, "div_fimd1", "mout_fimd1", DIV_DISP1_0, 0, 4),
+	DIV(0, "div_mipi1", "mout_mipi1", DIV_DISP1_0, 16, 4),
+	DIV_F(0, "div_mipi1_pre", "div_mipi1",
 			DIV_DISP1_0, 20, 4, CLK_SET_RATE_PARENT, 0),
-	DIV(none, "div_dp", "mout_dp", DIV_DISP1_0, 24, 4),
-	DIV(sclk_pixel, "div_hdmi_pixel", "mout_vpll", DIV_DISP1_0, 28, 4),
+	DIV(0, "div_dp", "mout_dp", DIV_DISP1_0, 24, 4),
+	DIV(CLK_SCLK_PIXEL, "div_hdmi_pixel", "mout_vpll", DIV_DISP1_0, 28, 4),
 
-	DIV(none, "div_jpeg", "mout_jpeg", DIV_GEN, 4, 4),
+	DIV(0, "div_jpeg", "mout_jpeg", DIV_GEN, 4, 4),
 
-	DIV(none, "div_audio0", "mout_audio0", DIV_MAU, 0, 4),
-	DIV(none, "div_pcm0", "sclk_audio0", DIV_MAU, 4, 8),
+	DIV(0, "div_audio0", "mout_audio0", DIV_MAU, 0, 4),
+	DIV(0, "div_pcm0", "sclk_audio0", DIV_MAU, 4, 8),
 
-	DIV(none, "div_sata", "mout_sata", DIV_FSYS0, 20, 4),
-	DIV(none, "div_usb3", "mout_usb3", DIV_FSYS0, 24, 4),
+	DIV(0, "div_sata", "mout_sata", DIV_FSYS0, 20, 4),
+	DIV(0, "div_usb3", "mout_usb3", DIV_FSYS0, 24, 4),
 
-	DIV(none, "div_mmc0", "mout_mmc0", DIV_FSYS1, 0, 4),
-	DIV_F(none, "div_mmc_pre0", "div_mmc0",
+	DIV(0, "div_mmc0", "mout_mmc0", DIV_FSYS1, 0, 4),
+	DIV_F(0, "div_mmc_pre0", "div_mmc0",
 			DIV_FSYS1, 8, 8, CLK_SET_RATE_PARENT, 0),
-	DIV(none, "div_mmc1", "mout_mmc1", DIV_FSYS1, 16, 4),
-	DIV_F(none, "div_mmc_pre1", "div_mmc1",
+	DIV(0, "div_mmc1", "mout_mmc1", DIV_FSYS1, 16, 4),
+	DIV_F(0, "div_mmc_pre1", "div_mmc1",
 			DIV_FSYS1, 24, 8, CLK_SET_RATE_PARENT, 0),
 
-	DIV(none, "div_mmc2", "mout_mmc2", DIV_FSYS2, 0, 4),
-	DIV_F(none, "div_mmc_pre2", "div_mmc2",
+	DIV(0, "div_mmc2", "mout_mmc2", DIV_FSYS2, 0, 4),
+	DIV_F(0, "div_mmc_pre2", "div_mmc2",
 			DIV_FSYS2, 8, 8, CLK_SET_RATE_PARENT, 0),
-	DIV(none, "div_mmc3", "mout_mmc3", DIV_FSYS2, 16, 4),
-	DIV_F(none, "div_mmc_pre3", "div_mmc3",
+	DIV(0, "div_mmc3", "mout_mmc3", DIV_FSYS2, 16, 4),
+	DIV_F(0, "div_mmc_pre3", "div_mmc3",
 			DIV_FSYS2, 24, 8, CLK_SET_RATE_PARENT, 0),
 
-	DIV(none, "div_uart0", "mout_uart0", DIV_PERIC0, 0, 4),
-	DIV(none, "div_uart1", "mout_uart1", DIV_PERIC0, 4, 4),
-	DIV(none, "div_uart2", "mout_uart2", DIV_PERIC0, 8, 4),
-	DIV(none, "div_uart3", "mout_uart3", DIV_PERIC0, 12, 4),
+	DIV(0, "div_uart0", "mout_uart0", DIV_PERIC0, 0, 4),
+	DIV(0, "div_uart1", "mout_uart1", DIV_PERIC0, 4, 4),
+	DIV(0, "div_uart2", "mout_uart2", DIV_PERIC0, 8, 4),
+	DIV(0, "div_uart3", "mout_uart3", DIV_PERIC0, 12, 4),
 
-	DIV(none, "div_spi0", "mout_spi0", DIV_PERIC1, 0, 4),
-	DIV_F(none, "div_spi_pre0", "div_spi0",
+	DIV(0, "div_spi0", "mout_spi0", DIV_PERIC1, 0, 4),
+	DIV_F(0, "div_spi_pre0", "div_spi0",
 			DIV_PERIC1, 8, 8, CLK_SET_RATE_PARENT, 0),
-	DIV(none, "div_spi1", "mout_spi1", DIV_PERIC1, 16, 4),
-	DIV_F(none, "div_spi_pre1", "div_spi1",
+	DIV(0, "div_spi1", "mout_spi1", DIV_PERIC1, 16, 4),
+	DIV_F(0, "div_spi_pre1", "div_spi1",
 			DIV_PERIC1, 24, 8, CLK_SET_RATE_PARENT, 0),
 
-	DIV(none, "div_spi2", "mout_spi2", DIV_PERIC2, 0, 4),
-	DIV_F(none, "div_spi_pre2", "div_spi2",
+	DIV(0, "div_spi2", "mout_spi2", DIV_PERIC2, 0, 4),
+	DIV_F(0, "div_spi_pre2", "div_spi2",
 			DIV_PERIC2, 8, 8, CLK_SET_RATE_PARENT, 0),
 
-	DIV(none, "div_pwm", "mout_pwm", DIV_PERIC3, 0, 4),
+	DIV(0, "div_pwm", "mout_pwm", DIV_PERIC3, 0, 4),
 
-	DIV(none, "div_audio1", "mout_audio1", DIV_PERIC4, 0, 4),
-	DIV(none, "div_pcm1", "sclk_audio1", DIV_PERIC4, 4, 8),
-	DIV(none, "div_audio2", "mout_audio2", DIV_PERIC4, 16, 4),
-	DIV(none, "div_pcm2", "sclk_audio2", DIV_PERIC4, 20, 8),
+	DIV(0, "div_audio1", "mout_audio1", DIV_PERIC4, 0, 4),
+	DIV(0, "div_pcm1", "sclk_audio1", DIV_PERIC4, 4, 8),
+	DIV(0, "div_audio2", "mout_audio2", DIV_PERIC4, 16, 4),
+	DIV(0, "div_pcm2", "sclk_audio2", DIV_PERIC4, 20, 8),
 
-	DIV(div_i2s1, "div_i2s1", "sclk_audio1", DIV_PERIC5, 0, 6),
-	DIV(div_i2s2, "div_i2s2", "sclk_audio2", DIV_PERIC5, 8, 6),
+	DIV(CLK_DIV_I2S1, "div_i2s1", "sclk_audio1", DIV_PERIC5, 0, 6),
+	DIV(CLK_DIV_I2S2, "div_i2s2", "sclk_audio2", DIV_PERIC5, 8, 6),
 };
 
 static struct samsung_gate_clock exynos5250_gate_clks[] __initdata = {
@@ -431,180 +386,194 @@ static struct samsung_gate_clock exynos5250_gate_clks[] __initdata = {
 	/*
 	 * CMU_ACP
 	 */
-	GATE(mdma0, "mdma0", "div_aclk266", GATE_IP_ACP, 1, 0, 0),
-	GATE(g2d, "g2d", "div_aclk200", GATE_IP_ACP, 3, 0, 0),
-	GATE(smmu_mdma0, "smmu_mdma0", "div_aclk266", GATE_IP_ACP, 5, 0, 0),
+	GATE(CLK_MDMA0, "mdma0", "div_aclk266", GATE_IP_ACP, 1, 0, 0),
+	GATE(CLK_G2D, "g2d", "div_aclk200", GATE_IP_ACP, 3, 0, 0),
+	GATE(CLK_SMMU_MDMA0, "smmu_mdma0", "div_aclk266", GATE_IP_ACP, 5, 0, 0),
 
 	/*
 	 * CMU_TOP
 	 */
-	GATE(sclk_cam_bayer, "sclk_cam_bayer", "div_cam_bayer",
+	GATE(CLK_SCLK_CAM_BAYER, "sclk_cam_bayer", "div_cam_bayer",
 			SRC_MASK_GSCL, 12, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_cam0, "sclk_cam0", "div_cam0",
+	GATE(CLK_SCLK_CAM0, "sclk_cam0", "div_cam0",
 			SRC_MASK_GSCL, 16, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_cam1, "sclk_cam1", "div_cam1",
+	GATE(CLK_SCLK_CAM1, "sclk_cam1", "div_cam1",
 			SRC_MASK_GSCL, 20, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_gscl_wa, "sclk_gscl_wa", "div_gscl_wa",
+	GATE(CLK_SCLK_GSCL_WA, "sclk_gscl_wa", "div_gscl_wa",
 			SRC_MASK_GSCL, 24, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_gscl_wb, "sclk_gscl_wb", "div_gscl_wb",
+	GATE(CLK_SCLK_GSCL_WB, "sclk_gscl_wb", "div_gscl_wb",
 			SRC_MASK_GSCL, 28, CLK_SET_RATE_PARENT, 0),
 
-	GATE(sclk_fimd1, "sclk_fimd1", "div_fimd1",
+	GATE(CLK_SCLK_FIMD1, "sclk_fimd1", "div_fimd1",
 			SRC_MASK_DISP1_0, 0, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_mipi1, "sclk_mipi1", "div_mipi1",
+	GATE(CLK_SCLK_MIPI1, "sclk_mipi1", "div_mipi1",
 			SRC_MASK_DISP1_0, 12, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_dp, "sclk_dp", "div_dp",
+	GATE(CLK_SCLK_DP, "sclk_dp", "div_dp",
 			SRC_MASK_DISP1_0, 16, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_hdmi, "sclk_hdmi", "mout_hdmi",
+	GATE(CLK_SCLK_HDMI, "sclk_hdmi", "mout_hdmi",
 			SRC_MASK_DISP1_0, 20, 0, 0),
 
-	GATE(sclk_audio0, "sclk_audio0", "div_audio0",
+	GATE(CLK_SCLK_AUDIO0, "sclk_audio0", "div_audio0",
 			SRC_MASK_MAU, 0, CLK_SET_RATE_PARENT, 0),
 
-	GATE(sclk_mmc0, "sclk_mmc0", "div_mmc_pre0",
+	GATE(CLK_SCLK_MMC0, "sclk_mmc0", "div_mmc_pre0",
 			SRC_MASK_FSYS, 0, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_mmc1, "sclk_mmc1", "div_mmc_pre1",
+	GATE(CLK_SCLK_MMC1, "sclk_mmc1", "div_mmc_pre1",
 			SRC_MASK_FSYS, 4, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_mmc2, "sclk_mmc2", "div_mmc_pre2",
+	GATE(CLK_SCLK_MMC2, "sclk_mmc2", "div_mmc_pre2",
 			SRC_MASK_FSYS, 8, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_mmc3, "sclk_mmc3", "div_mmc_pre3",
+	GATE(CLK_SCLK_MMC3, "sclk_mmc3", "div_mmc_pre3",
 			SRC_MASK_FSYS, 12, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_sata, "sclk_sata", "div_sata",
+	GATE(CLK_SCLK_SATA, "sclk_sata", "div_sata",
 			SRC_MASK_FSYS, 24, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_usb3, "sclk_usb3", "div_usb3",
+	GATE(CLK_SCLK_USB3, "sclk_usb3", "div_usb3",
 			SRC_MASK_FSYS, 28, CLK_SET_RATE_PARENT, 0),
 
-	GATE(sclk_jpeg, "sclk_jpeg", "div_jpeg",
+	GATE(CLK_SCLK_JPEG, "sclk_jpeg", "div_jpeg",
 			SRC_MASK_GEN, 0, CLK_SET_RATE_PARENT, 0),
 
-	GATE(sclk_uart0, "sclk_uart0", "div_uart0",
+	GATE(CLK_SCLK_UART0, "sclk_uart0", "div_uart0",
 			SRC_MASK_PERIC0, 0, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_uart1, "sclk_uart1", "div_uart1",
+	GATE(CLK_SCLK_UART1, "sclk_uart1", "div_uart1",
 			SRC_MASK_PERIC0, 4, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_uart2, "sclk_uart2", "div_uart2",
+	GATE(CLK_SCLK_UART2, "sclk_uart2", "div_uart2",
 			SRC_MASK_PERIC0, 8, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_uart3, "sclk_uart3", "div_uart3",
+	GATE(CLK_SCLK_UART3, "sclk_uart3", "div_uart3",
 			SRC_MASK_PERIC0, 12, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_pwm, "sclk_pwm", "div_pwm",
+	GATE(CLK_SCLK_PWM, "sclk_pwm", "div_pwm",
 			SRC_MASK_PERIC0, 24, CLK_SET_RATE_PARENT, 0),
 
-	GATE(sclk_audio1, "sclk_audio1", "div_audio1",
+	GATE(CLK_SCLK_AUDIO1, "sclk_audio1", "div_audio1",
 			SRC_MASK_PERIC1, 0, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_audio2, "sclk_audio2", "div_audio2",
+	GATE(CLK_SCLK_AUDIO2, "sclk_audio2", "div_audio2",
 			SRC_MASK_PERIC1, 4, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_spdif, "sclk_spdif", "mout_spdif",
+	GATE(CLK_SCLK_SPDIF, "sclk_spdif", "mout_spdif",
 			SRC_MASK_PERIC1, 4, 0, 0),
-	GATE(sclk_spi0, "sclk_spi0", "div_spi_pre0",
+	GATE(CLK_SCLK_SPI0, "sclk_spi0", "div_spi_pre0",
 			SRC_MASK_PERIC1, 16, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_spi1, "sclk_spi1", "div_spi_pre1",
+	GATE(CLK_SCLK_SPI1, "sclk_spi1", "div_spi_pre1",
 			SRC_MASK_PERIC1, 20, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_spi2, "sclk_spi2", "div_spi_pre2",
+	GATE(CLK_SCLK_SPI2, "sclk_spi2", "div_spi_pre2",
 			SRC_MASK_PERIC1, 24, CLK_SET_RATE_PARENT, 0),
 
-	GATE(gscl0, "gscl0", "mout_aclk266_gscl_sub", GATE_IP_GSCL, 0, 0, 0),
-	GATE(gscl1, "gscl1", "mout_aclk266_gscl_sub", GATE_IP_GSCL, 1, 0, 0),
-	GATE(gscl2, "gscl2", "mout_aclk266_gscl_sub", GATE_IP_GSCL, 2, 0, 0),
-	GATE(gscl3, "gscl3", "mout_aclk266_gscl_sub", GATE_IP_GSCL, 3, 0, 0),
-	GATE(gscl_wa, "gscl_wa", "div_gscl_wa", GATE_IP_GSCL, 5, 0, 0),
-	GATE(gscl_wb, "gscl_wb", "div_gscl_wb", GATE_IP_GSCL, 6, 0, 0),
-	GATE(smmu_gscl0, "smmu_gscl0", "mout_aclk266_gscl_sub",
+	GATE(CLK_GSCL0, "gscl0", "mout_aclk266_gscl_sub", GATE_IP_GSCL, 0, 0,
+		0),
+	GATE(CLK_GSCL1, "gscl1", "mout_aclk266_gscl_sub", GATE_IP_GSCL, 1, 0,
+		0),
+	GATE(CLK_GSCL2, "gscl2", "mout_aclk266_gscl_sub", GATE_IP_GSCL, 2, 0,
+		0),
+	GATE(CLK_GSCL3, "gscl3", "mout_aclk266_gscl_sub", GATE_IP_GSCL, 3, 0,
+		0),
+	GATE(CLK_GSCL_WA, "gscl_wa", "div_gscl_wa", GATE_IP_GSCL, 5, 0, 0),
+	GATE(CLK_GSCL_WB, "gscl_wb", "div_gscl_wb", GATE_IP_GSCL, 6, 0, 0),
+	GATE(CLK_SMMU_GSCL0, "smmu_gscl0", "mout_aclk266_gscl_sub",
 			GATE_IP_GSCL, 7, 0, 0),
-	GATE(smmu_gscl1, "smmu_gscl1", "mout_aclk266_gscl_sub",
+	GATE(CLK_SMMU_GSCL1, "smmu_gscl1", "mout_aclk266_gscl_sub",
 			GATE_IP_GSCL, 8, 0, 0),
-	GATE(smmu_gscl2, "smmu_gscl2", "mout_aclk266_gscl_sub",
+	GATE(CLK_SMMU_GSCL2, "smmu_gscl2", "mout_aclk266_gscl_sub",
 			GATE_IP_GSCL, 9, 0, 0),
-	GATE(smmu_gscl3, "smmu_gscl3", "mout_aclk266_gscl_sub",
+	GATE(CLK_SMMU_GSCL3, "smmu_gscl3", "mout_aclk266_gscl_sub",
 			GATE_IP_GSCL, 10, 0, 0),
 
-	GATE(fimd1, "fimd1", "mout_aclk200_disp1_sub", GATE_IP_DISP1, 0, 0, 0),
-	GATE(mie1, "mie1", "mout_aclk200_disp1_sub", GATE_IP_DISP1, 1, 0, 0),
-	GATE(dsim0, "dsim0", "mout_aclk200_disp1_sub", GATE_IP_DISP1, 3, 0, 0),
-	GATE(dp, "dp", "mout_aclk200_disp1_sub", GATE_IP_DISP1, 4, 0, 0),
-	GATE(mixer, "mixer", "mout_aclk200_disp1_sub", GATE_IP_DISP1, 5, 0, 0),
-	GATE(hdmi, "hdmi", "mout_aclk200_disp1_sub", GATE_IP_DISP1, 6, 0, 0),
-
-	GATE(mfc, "mfc", "mout_aclk333_sub", GATE_IP_MFC, 0, 0, 0),
-	GATE(smmu_mfcr, "smmu_mfcr", "mout_aclk333_sub", GATE_IP_MFC, 1, 0, 0),
-	GATE(smmu_mfcl, "smmu_mfcl", "mout_aclk333_sub", GATE_IP_MFC, 2, 0, 0),
-
-	GATE(rotator, "rotator", "div_aclk266", GATE_IP_GEN, 1, 0, 0),
-	GATE(jpeg, "jpeg", "div_aclk166", GATE_IP_GEN, 2, 0, 0),
-	GATE(mdma1, "mdma1", "div_aclk266", GATE_IP_GEN, 4, 0, 0),
-	GATE(smmu_rotator, "smmu_rotator", "div_aclk266", GATE_IP_GEN, 6, 0, 0),
-	GATE(smmu_jpeg, "smmu_jpeg", "div_aclk166", GATE_IP_GEN, 7, 0, 0),
-	GATE(smmu_mdma1, "smmu_mdma1", "div_aclk266", GATE_IP_GEN, 9, 0, 0),
-
-	GATE(pdma0, "pdma0", "div_aclk200", GATE_IP_FSYS, 1, 0, 0),
-	GATE(pdma1, "pdma1", "div_aclk200", GATE_IP_FSYS, 2, 0, 0),
-	GATE(sata, "sata", "div_aclk200", GATE_IP_FSYS, 6, 0, 0),
-	GATE(usbotg, "usbotg", "div_aclk200", GATE_IP_FSYS, 7, 0, 0),
-	GATE(mipi_hsi, "mipi_hsi", "div_aclk200", GATE_IP_FSYS, 8, 0, 0),
-	GATE(sdmmc0, "sdmmc0", "div_aclk200", GATE_IP_FSYS, 12, 0, 0),
-	GATE(sdmmc1, "sdmmc1", "div_aclk200", GATE_IP_FSYS, 13, 0, 0),
-	GATE(sdmmc2, "sdmmc2", "div_aclk200", GATE_IP_FSYS, 14, 0, 0),
-	GATE(sdmmc3, "sdmmc3", "div_aclk200", GATE_IP_FSYS, 15, 0, 0),
-	GATE(sromc, "sromc", "div_aclk200", GATE_IP_FSYS, 17, 0, 0),
-	GATE(usb2, "usb2", "div_aclk200", GATE_IP_FSYS, 18, 0, 0),
-	GATE(usb3, "usb3", "div_aclk200", GATE_IP_FSYS, 19, 0, 0),
-	GATE(sata_phyctrl, "sata_phyctrl", "div_aclk200",
+	GATE(CLK_FIMD1, "fimd1", "mout_aclk200_disp1_sub", GATE_IP_DISP1, 0, 0,
+		0),
+	GATE(CLK_MIE1, "mie1", "mout_aclk200_disp1_sub", GATE_IP_DISP1, 1, 0,
+		0),
+	GATE(CLK_DSIM0, "dsim0", "mout_aclk200_disp1_sub", GATE_IP_DISP1, 3, 0,
+		0),
+	GATE(CLK_DP, "dp", "mout_aclk200_disp1_sub", GATE_IP_DISP1, 4, 0, 0),
+	GATE(CLK_MIXER, "mixer", "mout_aclk200_disp1_sub", GATE_IP_DISP1, 5, 0,
+		0),
+	GATE(CLK_HDMI, "hdmi", "mout_aclk200_disp1_sub", GATE_IP_DISP1, 6, 0,
+		0),
+
+	GATE(CLK_MFC, "mfc", "mout_aclk333_sub", GATE_IP_MFC, 0, 0, 0),
+	GATE(CLK_SMMU_MFCR, "smmu_mfcr", "mout_aclk333_sub", GATE_IP_MFC, 1, 0,
+		0),
+	GATE(CLK_SMMU_MFCL, "smmu_mfcl", "mout_aclk333_sub", GATE_IP_MFC, 2, 0,
+		0),
+
+	GATE(CLK_ROTATOR, "rotator", "div_aclk266", GATE_IP_GEN, 1, 0, 0),
+	GATE(CLK_JPEG, "jpeg", "div_aclk166", GATE_IP_GEN, 2, 0, 0),
+	GATE(CLK_MDMA1, "mdma1", "div_aclk266", GATE_IP_GEN, 4, 0, 0),
+	GATE(CLK_SMMU_ROTATOR, "smmu_rotator", "div_aclk266", GATE_IP_GEN, 6, 0,
+		0),
+	GATE(CLK_SMMU_JPEG, "smmu_jpeg", "div_aclk166", GATE_IP_GEN, 7, 0, 0),
+	GATE(CLK_SMMU_MDMA1, "smmu_mdma1", "div_aclk266", GATE_IP_GEN, 9, 0, 0),
+
+	GATE(CLK_PDMA0, "pdma0", "div_aclk200", GATE_IP_FSYS, 1, 0, 0),
+	GATE(CLK_PDMA1, "pdma1", "div_aclk200", GATE_IP_FSYS, 2, 0, 0),
+	GATE(CLK_SATA, "sata", "div_aclk200", GATE_IP_FSYS, 6, 0, 0),
+	GATE(CLK_USBOTG, "usbotg", "div_aclk200", GATE_IP_FSYS, 7, 0, 0),
+	GATE(CLK_MIPI_HSI, "mipi_hsi", "div_aclk200", GATE_IP_FSYS, 8, 0, 0),
+	GATE(CLK_SDMMC0, "sdmmc0", "div_aclk200", GATE_IP_FSYS, 12, 0, 0),
+	GATE(CLK_SDMMC1, "sdmmc1", "div_aclk200", GATE_IP_FSYS, 13, 0, 0),
+	GATE(CLK_SDMMC2, "sdmmc2", "div_aclk200", GATE_IP_FSYS, 14, 0, 0),
+	GATE(CLK_SDMMC3, "sdmmc3", "div_aclk200", GATE_IP_FSYS, 15, 0, 0),
+	GATE(CLK_SROMC, "sromc", "div_aclk200", GATE_IP_FSYS, 17, 0, 0),
+	GATE(CLK_USB2, "usb2", "div_aclk200", GATE_IP_FSYS, 18, 0, 0),
+	GATE(CLK_USB3, "usb3", "div_aclk200", GATE_IP_FSYS, 19, 0, 0),
+	GATE(CLK_SATA_PHYCTRL, "sata_phyctrl", "div_aclk200",
 			GATE_IP_FSYS, 24, 0, 0),
-	GATE(sata_phyi2c, "sata_phyi2c", "div_aclk200", GATE_IP_FSYS, 25, 0, 0),
-
-	GATE(uart0, "uart0", "div_aclk66", GATE_IP_PERIC, 0, 0, 0),
-	GATE(uart1, "uart1", "div_aclk66", GATE_IP_PERIC, 1, 0, 0),
-	GATE(uart2, "uart2", "div_aclk66", GATE_IP_PERIC, 2, 0, 0),
-	GATE(uart3, "uart3", "div_aclk66", GATE_IP_PERIC, 3, 0, 0),
-	GATE(uart4, "uart4", "div_aclk66", GATE_IP_PERIC, 4, 0, 0),
-	GATE(i2c0, "i2c0", "div_aclk66", GATE_IP_PERIC, 6, 0, 0),
-	GATE(i2c1, "i2c1", "div_aclk66", GATE_IP_PERIC, 7, 0, 0),
-	GATE(i2c2, "i2c2", "div_aclk66", GATE_IP_PERIC, 8, 0, 0),
-	GATE(i2c3, "i2c3", "div_aclk66", GATE_IP_PERIC, 9, 0, 0),
-	GATE(i2c4, "i2c4", "div_aclk66", GATE_IP_PERIC, 10, 0, 0),
-	GATE(i2c5, "i2c5", "div_aclk66", GATE_IP_PERIC, 11, 0, 0),
-	GATE(i2c6, "i2c6", "div_aclk66", GATE_IP_PERIC, 12, 0, 0),
-	GATE(i2c7, "i2c7", "div_aclk66", GATE_IP_PERIC, 13, 0, 0),
-	GATE(i2c_hdmi, "i2c_hdmi", "div_aclk66", GATE_IP_PERIC, 14, 0, 0),
-	GATE(adc, "adc", "div_aclk66", GATE_IP_PERIC, 15, 0, 0),
-	GATE(spi0, "spi0", "div_aclk66", GATE_IP_PERIC, 16, 0, 0),
-	GATE(spi1, "spi1", "div_aclk66", GATE_IP_PERIC, 17, 0, 0),
-	GATE(spi2, "spi2", "div_aclk66", GATE_IP_PERIC, 18, 0, 0),
-	GATE(i2s1, "i2s1", "div_aclk66", GATE_IP_PERIC, 20, 0, 0),
-	GATE(i2s2, "i2s2", "div_aclk66", GATE_IP_PERIC, 21, 0, 0),
-	GATE(pcm1, "pcm1", "div_aclk66", GATE_IP_PERIC, 22, 0, 0),
-	GATE(pcm2, "pcm2", "div_aclk66", GATE_IP_PERIC, 23, 0, 0),
-	GATE(pwm, "pwm", "div_aclk66", GATE_IP_PERIC, 24, 0, 0),
-	GATE(spdif, "spdif", "div_aclk66", GATE_IP_PERIC, 26, 0, 0),
-	GATE(ac97, "ac97", "div_aclk66", GATE_IP_PERIC, 27, 0, 0),
-	GATE(hsi2c0, "hsi2c0", "div_aclk66", GATE_IP_PERIC, 28, 0, 0),
-	GATE(hsi2c1, "hsi2c1", "div_aclk66", GATE_IP_PERIC, 29, 0, 0),
-	GATE(hsi2c2, "hsi2c2", "div_aclk66", GATE_IP_PERIC, 30, 0, 0),
-	GATE(hsi2c3, "hsi2c3", "div_aclk66", GATE_IP_PERIC, 31, 0, 0),
-
-	GATE(chipid, "chipid", "div_aclk66", GATE_IP_PERIS, 0, 0, 0),
-	GATE(sysreg, "sysreg", "div_aclk66",
+	GATE(CLK_SATA_PHYI2C, "sata_phyi2c", "div_aclk200", GATE_IP_FSYS, 25, 0,
+		0),
+
+	GATE(CLK_UART0, "uart0", "div_aclk66", GATE_IP_PERIC, 0, 0, 0),
+	GATE(CLK_UART1, "uart1", "div_aclk66", GATE_IP_PERIC, 1, 0, 0),
+	GATE(CLK_UART2, "uart2", "div_aclk66", GATE_IP_PERIC, 2, 0, 0),
+	GATE(CLK_UART3, "uart3", "div_aclk66", GATE_IP_PERIC, 3, 0, 0),
+	GATE(CLK_UART4, "uart4", "div_aclk66", GATE_IP_PERIC, 4, 0, 0),
+	GATE(CLK_I2C0, "i2c0", "div_aclk66", GATE_IP_PERIC, 6, 0, 0),
+	GATE(CLK_I2C1, "i2c1", "div_aclk66", GATE_IP_PERIC, 7, 0, 0),
+	GATE(CLK_I2C2, "i2c2", "div_aclk66", GATE_IP_PERIC, 8, 0, 0),
+	GATE(CLK_I2C3, "i2c3", "div_aclk66", GATE_IP_PERIC, 9, 0, 0),
+	GATE(CLK_I2C4, "i2c4", "div_aclk66", GATE_IP_PERIC, 10, 0, 0),
+	GATE(CLK_I2C5, "i2c5", "div_aclk66", GATE_IP_PERIC, 11, 0, 0),
+	GATE(CLK_I2C6, "i2c6", "div_aclk66", GATE_IP_PERIC, 12, 0, 0),
+	GATE(CLK_I2C7, "i2c7", "div_aclk66", GATE_IP_PERIC, 13, 0, 0),
+	GATE(CLK_I2C_HDMI, "i2c_hdmi", "div_aclk66", GATE_IP_PERIC, 14, 0, 0),
+	GATE(CLK_ADC, "adc", "div_aclk66", GATE_IP_PERIC, 15, 0, 0),
+	GATE(CLK_SPI0, "spi0", "div_aclk66", GATE_IP_PERIC, 16, 0, 0),
+	GATE(CLK_SPI1, "spi1", "div_aclk66", GATE_IP_PERIC, 17, 0, 0),
+	GATE(CLK_SPI2, "spi2", "div_aclk66", GATE_IP_PERIC, 18, 0, 0),
+	GATE(CLK_I2S1, "i2s1", "div_aclk66", GATE_IP_PERIC, 20, 0, 0),
+	GATE(CLK_I2S2, "i2s2", "div_aclk66", GATE_IP_PERIC, 21, 0, 0),
+	GATE(CLK_PCM1, "pcm1", "div_aclk66", GATE_IP_PERIC, 22, 0, 0),
+	GATE(CLK_PCM2, "pcm2", "div_aclk66", GATE_IP_PERIC, 23, 0, 0),
+	GATE(CLK_PWM, "pwm", "div_aclk66", GATE_IP_PERIC, 24, 0, 0),
+	GATE(CLK_SPDIF, "spdif", "div_aclk66", GATE_IP_PERIC, 26, 0, 0),
+	GATE(CLK_AC97, "ac97", "div_aclk66", GATE_IP_PERIC, 27, 0, 0),
+	GATE(CLK_HSI2C0, "hsi2c0", "div_aclk66", GATE_IP_PERIC, 28, 0, 0),
+	GATE(CLK_HSI2C1, "hsi2c1", "div_aclk66", GATE_IP_PERIC, 29, 0, 0),
+	GATE(CLK_HSI2C2, "hsi2c2", "div_aclk66", GATE_IP_PERIC, 30, 0, 0),
+	GATE(CLK_HSI2C3, "hsi2c3", "div_aclk66", GATE_IP_PERIC, 31, 0, 0),
+
+	GATE(CLK_CHIPID, "chipid", "div_aclk66", GATE_IP_PERIS, 0, 0, 0),
+	GATE(CLK_SYSREG, "sysreg", "div_aclk66",
 			GATE_IP_PERIS, 1, CLK_IGNORE_UNUSED, 0),
-	GATE(pmu, "pmu", "div_aclk66", GATE_IP_PERIS, 2, CLK_IGNORE_UNUSED, 0),
-	GATE(cmu_top, "cmu_top", "div_aclk66",
+	GATE(CLK_PMU, "pmu", "div_aclk66", GATE_IP_PERIS, 2, CLK_IGNORE_UNUSED,
+		0),
+	GATE(CLK_CMU_TOP, "cmu_top", "div_aclk66",
 			GATE_IP_PERIS, 3, CLK_IGNORE_UNUSED, 0),
-	GATE(cmu_core, "cmu_core", "div_aclk66",
+	GATE(CLK_CMU_CORE, "cmu_core", "div_aclk66",
 			GATE_IP_PERIS, 4, CLK_IGNORE_UNUSED, 0),
-	GATE(cmu_mem, "cmu_mem", "div_aclk66",
+	GATE(CLK_CMU_MEM, "cmu_mem", "div_aclk66",
 			GATE_IP_PERIS, 5, CLK_IGNORE_UNUSED, 0),
-	GATE(tzpc0, "tzpc0", "div_aclk66", GATE_IP_PERIS, 6, 0, 0),
-	GATE(tzpc1, "tzpc1", "div_aclk66", GATE_IP_PERIS, 7, 0, 0),
-	GATE(tzpc2, "tzpc2", "div_aclk66", GATE_IP_PERIS, 8, 0, 0),
-	GATE(tzpc3, "tzpc3", "div_aclk66", GATE_IP_PERIS, 9, 0, 0),
-	GATE(tzpc4, "tzpc4", "div_aclk66", GATE_IP_PERIS, 10, 0, 0),
-	GATE(tzpc5, "tzpc5", "div_aclk66", GATE_IP_PERIS, 11, 0, 0),
-	GATE(tzpc6, "tzpc6", "div_aclk66", GATE_IP_PERIS, 12, 0, 0),
-	GATE(tzpc7, "tzpc7", "div_aclk66", GATE_IP_PERIS, 13, 0, 0),
-	GATE(tzpc8, "tzpc8", "div_aclk66", GATE_IP_PERIS, 14, 0, 0),
-	GATE(tzpc9, "tzpc9", "div_aclk66", GATE_IP_PERIS, 15, 0, 0),
-	GATE(hdmi_cec, "hdmi_cec", "div_aclk66", GATE_IP_PERIS, 16, 0, 0),
-	GATE(mct, "mct", "div_aclk66", GATE_IP_PERIS, 18, 0, 0),
-	GATE(wdt, "wdt", "div_aclk66", GATE_IP_PERIS, 19, 0, 0),
-	GATE(rtc, "rtc", "div_aclk66", GATE_IP_PERIS, 20, 0, 0),
-	GATE(tmu, "tmu", "div_aclk66", GATE_IP_PERIS, 21, 0, 0),
+	GATE(CLK_TZPC0, "tzpc0", "div_aclk66", GATE_IP_PERIS, 6, 0, 0),
+	GATE(CLK_TZPC1, "tzpc1", "div_aclk66", GATE_IP_PERIS, 7, 0, 0),
+	GATE(CLK_TZPC2, "tzpc2", "div_aclk66", GATE_IP_PERIS, 8, 0, 0),
+	GATE(CLK_TZPC3, "tzpc3", "div_aclk66", GATE_IP_PERIS, 9, 0, 0),
+	GATE(CLK_TZPC4, "tzpc4", "div_aclk66", GATE_IP_PERIS, 10, 0, 0),
+	GATE(CLK_TZPC5, "tzpc5", "div_aclk66", GATE_IP_PERIS, 11, 0, 0),
+	GATE(CLK_TZPC6, "tzpc6", "div_aclk66", GATE_IP_PERIS, 12, 0, 0),
+	GATE(CLK_TZPC7, "tzpc7", "div_aclk66", GATE_IP_PERIS, 13, 0, 0),
+	GATE(CLK_TZPC8, "tzpc8", "div_aclk66", GATE_IP_PERIS, 14, 0, 0),
+	GATE(CLK_TZPC9, "tzpc9", "div_aclk66", GATE_IP_PERIS, 15, 0, 0),
+	GATE(CLK_HDMI_CEC, "hdmi_cec", "div_aclk66", GATE_IP_PERIS, 16, 0, 0),
+	GATE(CLK_MCT, "mct", "div_aclk66", GATE_IP_PERIS, 18, 0, 0),
+	GATE(CLK_WDT, "wdt", "div_aclk66", GATE_IP_PERIS, 19, 0, 0),
+	GATE(CLK_RTC, "rtc", "div_aclk66", GATE_IP_PERIS, 20, 0, 0),
+	GATE(CLK_TMU, "tmu", "div_aclk66", GATE_IP_PERIS, 21, 0, 0),
 };
 
 static struct samsung_pll_rate_table vpll_24mhz_tbl[] __initdata = {
@@ -652,19 +621,19 @@ static struct samsung_pll_rate_table apll_24mhz_tbl[] __initdata = {
 };
 
 static struct samsung_pll_clock exynos5250_plls[nr_plls] __initdata = {
-	[apll] = PLL_A(pll_35xx, fout_apll, "fout_apll", "fin_pll", APLL_LOCK,
-		APLL_CON0, "fout_apll", NULL),
-	[mpll] = PLL_A(pll_35xx, fout_mpll, "fout_mpll", "fin_pll", MPLL_LOCK,
-		MPLL_CON0, "fout_mpll", NULL),
-	[bpll] = PLL(pll_35xx, fout_bpll, "fout_bpll", "fin_pll", BPLL_LOCK,
+	[apll] = PLL_A(pll_35xx, CLK_FOUT_APLL, "fout_apll", "fin_pll",
+		APLL_LOCK, APLL_CON0, "fout_apll", NULL),
+	[mpll] = PLL_A(pll_35xx, CLK_FOUT_MPLL, "fout_mpll", "fin_pll",
+		MPLL_LOCK, MPLL_CON0, "fout_mpll", NULL),
+	[bpll] = PLL(pll_35xx, CLK_FOUT_BPLL, "fout_bpll", "fin_pll", BPLL_LOCK,
 		BPLL_CON0, NULL),
-	[gpll] = PLL(pll_35xx, fout_gpll, "fout_gpll", "fin_pll", GPLL_LOCK,
+	[gpll] = PLL(pll_35xx, CLK_FOUT_GPLL, "fout_gpll", "fin_pll", GPLL_LOCK,
 		GPLL_CON0, NULL),
-	[cpll] = PLL(pll_35xx, fout_cpll, "fout_cpll", "fin_pll", CPLL_LOCK,
+	[cpll] = PLL(pll_35xx, CLK_FOUT_CPLL, "fout_cpll", "fin_pll", CPLL_LOCK,
 		CPLL_CON0, NULL),
-	[epll] = PLL(pll_36xx, fout_epll, "fout_epll", "fin_pll", EPLL_LOCK,
+	[epll] = PLL(pll_36xx, CLK_FOUT_EPLL, "fout_epll", "fin_pll", EPLL_LOCK,
 		EPLL_CON0, NULL),
-	[vpll] = PLL(pll_36xx, fout_vpll, "fout_vpll", "mout_vpllsrc",
+	[vpll] = PLL(pll_36xx, CLK_FOUT_VPLL, "fout_vpll", "mout_vpllsrc",
 		VPLL_LOCK, VPLL_CON0, NULL),
 };
 
@@ -686,7 +655,7 @@ static void __init exynos5250_clk_init(struct device_node *np)
 		panic("%s: unable to determine soc\n", __func__);
 	}
 
-	samsung_clk_init(np, reg_base, nr_clks,
+	samsung_clk_init(np, reg_base, CLK_NR_CLKS,
 			exynos5250_clk_regs, ARRAY_SIZE(exynos5250_clk_regs),
 			NULL, 0);
 	samsung_clk_of_register_fixed_ext(exynos5250_fixed_rate_ext_clks,
-- 
1.8.3.2
