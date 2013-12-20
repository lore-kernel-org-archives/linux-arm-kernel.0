From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Fri, 20 Dec 2013 18:27:24 +0530
Subject: [PATCH 1/3] clk/exynos5420: cleanup clock file
In-Reply-To: <1387544246-31658-1-git-send-email-rahul.sharma@samsung.com>
References: <1387544246-31658-1-git-send-email-rahul.sharma@samsung.com>
Message-ID: <1387544246-31658-2-git-send-email-rahul.sharma@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Clock file has undergone a lot of updates after SoC revision.
Existing file has many issues related to clock parents, naming
convention, bit fields, missing clocks etc. This patch is
fixing these issues.

Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
---
 drivers/clk/samsung/clk-exynos5420.c | 1033 +++++++++++++++++++++++-----------
 1 file changed, 695 insertions(+), 338 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index e5493cf..c90382f 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -26,6 +26,9 @@
 #define DIV_CPU1		0x504
 #define GATE_BUS_CPU		0x700
 #define GATE_SCLK_CPU		0x800
+#define CLKOUT_CMU_CPU		0xa00
+#define DIV_G2D			0x8500
+#define GATE_BUS_G2D		0x8700
 #define CPLL_LOCK		0x10020
 #define DPLL_LOCK		0x10030
 #define EPLL_LOCK		0x10040
@@ -37,7 +40,11 @@
 #define CPLL_CON0		0x10120
 #define DPLL_CON0		0x10128
 #define EPLL_CON0		0x10130
+#define EPLL_CON1		0x10134
+#define EPLL_CON2		0x10138
 #define RPLL_CON0		0x10140
+#define RPLL_CON1		0x10144
+#define RPLL_CON2		0x10148
 #define IPLL_CON0		0x10150
 #define SPLL_CON0		0x10160
 #define VPLL_CON0		0x10170
@@ -55,10 +62,13 @@
 #define SRC_FSYS		0x10244
 #define SRC_PERIC0		0x10250
 #define SRC_PERIC1		0x10254
+#define SRC_ISP			0x10270
 #define SRC_TOP10		0x10280
 #define SRC_TOP11		0x10284
 #define SRC_TOP12		0x10288
-#define	SRC_MASK_DISP10		0x1032c
+#define SRC_MASK_TOP2		0x10308
+#define SRC_MASK_DISP10		0x1032c
+#define SRC_MASK_MAU		0x10334
 #define SRC_MASK_FSYS		0x10340
 #define SRC_MASK_PERIC0		0x10350
 #define SRC_MASK_PERIC1		0x10354
@@ -75,24 +85,41 @@
 #define DIV_PERIC2		0x10560
 #define DIV_PERIC3		0x10564
 #define DIV_PERIC4		0x10568
+#define SCLK_DIV_ISP0		0x10580
+#define SCLK_DIV_ISP1		0x10584
+#define DIV2_RATIO0		0x10590
+#define DIV4_RATIO		0x105a0
 #define GATE_BUS_TOP		0x10700
+#define GATE_BUS_GSCL0		0x10710
+#define GATE_BUS_GSCL1		0x10720
+#define GATE_BUS_DISP1		0x10728
+#define GATE_BUS_MFC		0x10734
+#define GATE_BUS_GEN		0x1073c
 #define GATE_BUS_FSYS0		0x10740
+#define GATE_BUS_FSYS2		0x10748
+#define GATE_BUS_MSCL		0x1074C
 #define GATE_BUS_PERIC		0x10750
 #define GATE_BUS_PERIC1		0x10754
 #define GATE_BUS_PERIS0		0x10760
 #define GATE_BUS_PERIS1		0x10764
+#define GATE_BUS_NOC		0x10770
+#define GATE_TOP_SCLK_ISP	0x10870
 #define GATE_IP_GSCL0		0x10910
 #define GATE_IP_GSCL1		0x10920
 #define GATE_IP_MFC		0x1092c
 #define GATE_IP_DISP1		0x10928
 #define GATE_IP_G3D		0x10930
 #define GATE_IP_GEN		0x10934
+#define GATE_IP_FSYS		0x10944
+#define GATE_IP_PERIC		0x10950
+#define GATE_IP_PERIS		0x10960
 #define GATE_IP_MSCL		0x10970
 #define GATE_TOP_SCLK_GSCL	0x10820
 #define GATE_TOP_SCLK_DISP1	0x10828
 #define GATE_TOP_SCLK_MAU	0x1083c
 #define GATE_TOP_SCLK_FSYS	0x10840
 #define GATE_TOP_SCLK_PERIC	0x10850
+#define TOP_SPARE2		0x10b08
 #define BPLL_LOCK		0x20010
 #define BPLL_CON0		0x20110
 #define SRC_CDREX		0x20200
@@ -121,28 +148,56 @@ enum exynos5420_clks {
 	sclk_i2s2, sclk_pcm1, sclk_pcm2, sclk_spdif, sclk_hdmi, sclk_pixel,
 	sclk_dp1, sclk_mipi1, sclk_fimd1, sclk_maudio0, sclk_maupcm0,
 	sclk_usbd300, sclk_usbd301, sclk_usbphy300, sclk_usbphy301, sclk_unipro,
-	sclk_pwm, sclk_gscl_wa, sclk_gscl_wb, sclk_hdmiphy,
+	sclk_pwm, sclk_gscl_wa, sclk_gscl_wb, sclk_hdmiphy, sclk_mphy_refclk,
+	sclk_spi0_isp, sclk_spi1_isp, sclk_uart_isp, sclk_isp_sensor0,
+	sclk_isp_sensor1, sclk_isp_sensor2, sclk_pwm_isp, sclk_hsic_12m,
+	sclk_mphy_ixtal24,
 
 	/* gate clocks */
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
+	aclk66_peric = 256, pclk_uart0, pclk_uart1, pclk_uart2,
+	pclk_uart3, pclk_i2c0, pclk_i2c1, pclk_i2c2, pclk_i2c3,
+	pclk_usi0, pclk_usi1, pclk_usi2, pclk_usi3, pclk_i2c_hdmi,
+	pclk_tsadc, pclk_spi0, pclk_spi1, pclk_spi2, pclk_i2s1,
+	pclk_i2s2, pclk_pcm1, pclk_pcm2, pclk_pwm,
+	pclk_spdif, pclk_usi4, pclk_usi5, pclk_usi6,
+	aclk66_psgen = 300, pclk_chipid, pclk_sysreg, pclk_tzpc0, pclk_tzpc1,
+	pclk_tzpc2, pclk_tzpc3, pclk_tzpc4, pclk_tzpc5, pclk_tzpc6,
+	pclk_tzpc7, pclk_tzpc8, pclk_tzpc9, hdmi_cec, seckey, pclk_mct,
+	pclk_wdt, pclk_rtc, pclk_tmu, pclk_tmu_gpu,
+	pclk66_gpio = 330,
+	aclk200_fsys2 = 350, aclk_mmc0, aclk_mmc1, aclk_mmc2, hclk_sromc, ufs,
+	aclk200_fsys = 360, aclk_pdma0, aclk_pdma1, aclk_rtic,
+	hclk_usbh20, hclk_usbd300, hclk_usbd301,
+	pclk200_fsys = 370,
+	aclk400_mscl = 380, aclk_mscl0, aclk_mscl1, aclk_mscl2, smmu_mscl0,
+	smmu_mscl1, smmu_mscl2,
+	aclk333 = 400, aclk_mfc, smmu_mfcl, smmu_mfcr,
+	aclk200_disp1 = 410, pclk_dsim1, pclk_dp1, pclk_hdmi,
+	aclk300_disp1 = 420, aclk_fimd1, smmu_fimd1m0, smmu_fimd1m1,
+	aclk400_disp1,
+	aclk166 = 430, aclk_mixer,
+	aclk266 = 440, aclk_rotator, aclk_mdma1, smmu_rotator, smmu_mdma1,
+	aclk300_jpeg = 450, aclk_jpeg, aclk_jpeg2, smmu_jpeg,
+	aclk300_gscl = 460, smmu_gscl0, smmu_gscl1, pclk_gscl_wa,
+	aclk_gscl0 = 465, aclk_gscl1, aclk_fimc_3aa,
+	aclk266_g2d = 470, aclk_sss, aclk_slim_sss, aclk_mdma0,
+	aclk333_g2d = 480, aclk_g2d,
+	aclk333_432_gscl = 490, smmu_3aa, smmu_fimcl0, smmu_fimcl1, smmu_fimcl3,
+	aclk_fimc_lite3,
+	clk_g3d = 500, smmu_mixer, pclk_tzpc10, pclk_tzpc11, pclk_mc,
+	pclk_top_rtc, smmu_jpeg2, pclk_rotator, smmu_rtic, pclk_g2d,
+	aclk_smmu_g2d, smmu_g2d, aclk_smmu_mdma0, smmu_mdma0, aclk_smmu_sss,
+	smmu_sss, smmu_slim_sss, aclk_smmu_slim_sss, aclk266_isp, aclk400_isp,
+	aclk333_432_isp0, aclk333_432_isp, aclk_smmu_mixer, pclk_hdmiphy,
+	pclk_gscl0, pclk_gscl1, pclk_fimc_3aa, aclk_fimc_lite0, aclk_fimc_lite1,
+	pclk_fimc_lite0, pclk_fimc_lite1, pclk_fimc_lite3, pclk_mscl0,
+	pclk_mscl1, pclk_mscl2, pclk_mfc,
 
 	/* mux clocks */
-	mout_hdmi = 640,
+	mout_hdmi = 640, mout_fimd1, mout_maudio0, mout_spi0, mout_spi1,
+	mout_spi2, mout_sw_aclk333, mout_user_aclk333, mout_sw_aclk300_gscl,
+	mout_user_aclk300_gscl, mout_sw_aclk333_432_gscl,
+	mout_user_aclk333_432_gscl, mout_g3d,
 
 	/* divider clocks */
 	dout_pixel = 768,
@@ -165,6 +220,13 @@ static unsigned long exynos5420_clk_regs[] __initdata = {
 	DIV_CPU1,
 	GATE_BUS_CPU,
 	GATE_SCLK_CPU,
+	CLKOUT_CMU_CPU,
+	EPLL_CON0,
+	EPLL_CON1,
+	EPLL_CON2,
+	RPLL_CON0,
+	RPLL_CON1,
+	RPLL_CON2,
 	SRC_TOP0,
 	SRC_TOP1,
 	SRC_TOP2,
@@ -178,10 +240,12 @@ static unsigned long exynos5420_clk_regs[] __initdata = {
 	SRC_FSYS,
 	SRC_PERIC0,
 	SRC_PERIC1,
+	SRC_ISP,
 	SRC_TOP10,
 	SRC_TOP11,
 	SRC_TOP12,
 	SRC_MASK_DISP10,
+	SRC_MASK_MAU,
 	SRC_MASK_FSYS,
 	SRC_MASK_PERIC0,
 	SRC_MASK_PERIC1,
@@ -198,27 +262,44 @@ static unsigned long exynos5420_clk_regs[] __initdata = {
 	DIV_PERIC2,
 	DIV_PERIC3,
 	DIV_PERIC4,
+	SCLK_DIV_ISP0,
+	SCLK_DIV_ISP1,
+	DIV2_RATIO0,
+	DIV4_RATIO,
 	GATE_BUS_TOP,
+	GATE_BUS_GSCL0,
+	GATE_BUS_GSCL1,
+	GATE_BUS_DISP1,
+	GATE_BUS_MFC,
+	GATE_BUS_GEN,
 	GATE_BUS_FSYS0,
+	GATE_BUS_FSYS2,
+	GATE_BUS_MSCL,
 	GATE_BUS_PERIC,
 	GATE_BUS_PERIC1,
 	GATE_BUS_PERIS0,
 	GATE_BUS_PERIS1,
+	GATE_BUS_NOC,
+	GATE_TOP_SCLK_ISP,
 	GATE_IP_GSCL0,
 	GATE_IP_GSCL1,
 	GATE_IP_MFC,
 	GATE_IP_DISP1,
 	GATE_IP_G3D,
 	GATE_IP_GEN,
+	GATE_IP_FSYS,
+	GATE_IP_PERIC,
+	GATE_IP_PERIS,
 	GATE_IP_MSCL,
 	GATE_TOP_SCLK_GSCL,
 	GATE_TOP_SCLK_DISP1,
 	GATE_TOP_SCLK_MAU,
 	GATE_TOP_SCLK_FSYS,
 	GATE_TOP_SCLK_PERIC,
-	SRC_CDREX,
+	TOP_SPARE2,
 	SRC_KFC,
 	DIV_KFC0,
+	SRC_MASK_TOP2,
 };
 
 static int exynos5420_clk_suspend(void)
@@ -257,89 +338,131 @@ static void exynos5420_clk_sleep_init(void) {}
 #endif
 
 /* list of all parent clocks */
-PNAME(mspll_cpu_p)	= { "sclk_cpll", "sclk_dpll",
-				"sclk_mpll", "sclk_spll" };
-PNAME(cpu_p)		= { "mout_apll" , "mout_mspll_cpu" };
-PNAME(kfc_p)		= { "mout_kpll" , "mout_mspll_kfc" };
-PNAME(apll_p)		= { "fin_pll", "fout_apll", };
-PNAME(bpll_p)		= { "fin_pll", "fout_bpll", };
-PNAME(cpll_p)		= { "fin_pll", "fout_cpll", };
-PNAME(dpll_p)		= { "fin_pll", "fout_dpll", };
-PNAME(epll_p)		= { "fin_pll", "fout_epll", };
-PNAME(ipll_p)		= { "fin_pll", "fout_ipll", };
-PNAME(kpll_p)		= { "fin_pll", "fout_kpll", };
-PNAME(mpll_p)		= { "fin_pll", "fout_mpll", };
-PNAME(rpll_p)		= { "fin_pll", "fout_rpll", };
-PNAME(spll_p)		= { "fin_pll", "fout_spll", };
-PNAME(vpll_p)		= { "fin_pll", "fout_vpll", };
-
-PNAME(group1_p)		= { "sclk_cpll", "sclk_dpll", "sclk_mpll" };
-PNAME(group2_p)		= { "fin_pll", "sclk_cpll", "sclk_dpll", "sclk_mpll",
-			  "sclk_spll", "sclk_ipll", "sclk_epll", "sclk_rpll" };
-PNAME(group3_p)		= { "sclk_rpll", "sclk_spll" };
-PNAME(group4_p)		= { "sclk_ipll", "sclk_dpll", "sclk_mpll" };
-PNAME(group5_p)		= { "sclk_vpll", "sclk_dpll" };
-
-PNAME(sw_aclk66_p)	= { "dout_aclk66", "sclk_spll" };
-PNAME(aclk66_peric_p)	= { "fin_pll", "mout_sw_aclk66" };
-
-PNAME(sw_aclk200_fsys_p) = { "dout_aclk200_fsys", "sclk_spll"};
-PNAME(user_aclk200_fsys_p)	= { "fin_pll", "mout_sw_aclk200_fsys" };
-
-PNAME(sw_aclk200_fsys2_p) = { "dout_aclk200_fsys2", "sclk_spll"};
-PNAME(user_aclk200_fsys2_p)	= { "fin_pll", "mout_sw_aclk200_fsys2" };
-
-PNAME(sw_aclk200_p) = { "dout_aclk200", "sclk_spll"};
-PNAME(aclk200_disp1_p)	= { "fin_pll", "mout_sw_aclk200" };
-
-PNAME(sw_aclk400_mscl_p) = { "dout_aclk400_mscl", "sclk_spll"};
-PNAME(user_aclk400_mscl_p)	= { "fin_pll", "mout_sw_aclk400_mscl" };
-
-PNAME(sw_aclk333_p) = { "dout_aclk333", "sclk_spll"};
-PNAME(user_aclk333_p)	= { "fin_pll", "mout_sw_aclk333" };
-
-PNAME(sw_aclk166_p) = { "dout_aclk166", "sclk_spll"};
-PNAME(user_aclk166_p)	= { "fin_pll", "mout_sw_aclk166" };
-
-PNAME(sw_aclk266_p) = { "dout_aclk266", "sclk_spll"};
-PNAME(user_aclk266_p)	= { "fin_pll", "mout_sw_aclk266" };
-
-PNAME(sw_aclk333_432_gscl_p) = { "dout_aclk333_432_gscl", "sclk_spll"};
-PNAME(user_aclk333_432_gscl_p)	= { "fin_pll", "mout_sw_aclk333_432_gscl" };
-
-PNAME(sw_aclk300_gscl_p) = { "dout_aclk300_gscl", "sclk_spll"};
-PNAME(user_aclk300_gscl_p)	= { "fin_pll", "mout_sw_aclk300_gscl" };
-
-PNAME(sw_aclk300_disp1_p) = { "dout_aclk300_disp1", "sclk_spll"};
-PNAME(user_aclk300_disp1_p)	= { "fin_pll", "mout_sw_aclk300_disp1" };
-
-PNAME(sw_aclk300_jpeg_p) = { "dout_aclk300_jpeg", "sclk_spll"};
-PNAME(user_aclk300_jpeg_p)	= { "fin_pll", "mout_sw_aclk300_jpeg" };
-
-PNAME(sw_aclk_g3d_p) = { "dout_aclk_g3d", "sclk_spll"};
-PNAME(user_aclk_g3d_p)	= { "fin_pll", "mout_sw_aclk_g3d" };
-
-PNAME(sw_aclk266_g2d_p) = { "dout_aclk266_g2d", "sclk_spll"};
-PNAME(user_aclk266_g2d_p)	= { "fin_pll", "mout_sw_aclk266_g2d" };
-
-PNAME(sw_aclk333_g2d_p) = { "dout_aclk333_g2d", "sclk_spll"};
-PNAME(user_aclk333_g2d_p)	= { "fin_pll", "mout_sw_aclk333_g2d" };
-
-PNAME(audio0_p)	= { "fin_pll", "cdclk0", "sclk_dpll", "sclk_mpll",
-		  "sclk_spll", "sclk_ipll", "sclk_epll", "sclk_rpll" };
-PNAME(audio1_p)	= { "fin_pll", "cdclk1", "sclk_dpll", "sclk_mpll",
-		  "sclk_spll", "sclk_ipll", "sclk_epll", "sclk_rpll" };
-PNAME(audio2_p)	= { "fin_pll", "cdclk2", "sclk_dpll", "sclk_mpll",
-		  "sclk_spll", "sclk_ipll", "sclk_epll", "sclk_rpll" };
-PNAME(spdif_p)	= { "fin_pll", "dout_audio0", "dout_audio1", "dout_audio2",
-		  "spdif_extclk", "sclk_ipll", "sclk_epll", "sclk_rpll" };
-PNAME(hdmi_p)	= { "dout_hdmi_pixel", "sclk_hdmiphy" };
-PNAME(maudio0_p)	= { "fin_pll", "maudio_clk", "sclk_dpll", "sclk_mpll",
-			  "sclk_spll", "sclk_ipll", "sclk_epll", "sclk_rpll" };
+PNAME(mout_mspll_cpu_p) = {"mout_sclk_cpll", "mout_sclk_dpll",
+				"mout_sclk_mpll", "mout_sclk_spll"};
+PNAME(mout_cpu_p) = {"mout_apll" , "mout_mspll_cpu"};
+PNAME(mout_kfc_p) = {"mout_kpll" , "mout_mspll_kfc"};
+PNAME(mout_apll_p) = {"fin_pll", "fout_apll"};
+PNAME(mout_bpll_p) = {"fin_pll", "fout_bpll"};
+PNAME(mout_cpll_p) = {"fin_pll", "fout_cpll"};
+PNAME(mout_dpll_p) = {"fin_pll", "fout_dpll"};
+PNAME(mout_epll_p) = {"fin_pll", "fout_epll"};
+PNAME(mout_ipll_p) = {"fin_pll", "fout_ipll"};
+PNAME(mout_kpll_p) = {"fin_pll", "fout_kpll"};
+PNAME(mout_mpll_p) = {"fin_pll", "fout_mpll"};
+PNAME(mout_rpll_p) = {"fin_pll", "fout_rpll"};
+PNAME(mout_spll_p) = {"fin_pll", "fout_spll"};
+PNAME(mout_vpll_p) = {"fin_pll", "fout_vpll"};
+
+PNAME(mout_group1_p) = {"mout_sclk_cpll", "mout_sclk_dpll",
+					"mout_sclk_mpll"};
+PNAME(mout_group2_p) = {"fin_pll", "mout_sclk_cpll",
+					"mout_sclk_dpll", "mout_sclk_mpll",
+					"mout_sclk_spll", "mout_sclk_ipll",
+					"mout_sclk_epll", "mout_sclk_rpll"};
+PNAME(mout_group3_p) = {"mout_sclk_rpll", "mout_sclk_spll"};
+PNAME(mout_group4_p) = {"mout_sclk_ipll", "mout_sclk_dpll",
+					"mout_sclk_mpll"};
+PNAME(mout_group5_p) = {"mout_sclk_vpll", "mout_sclk_dpll"};
+
+PNAME(mout_fimd1_final_p) = {"mout_fimd1", "mout_fimd1_opt"};
+PNAME(mout_sw_aclk66_p)	= {"dout_aclk66", "mout_sclk_spll"};
+PNAME(mout_user_aclk66_peric_p) = {"fin_pll", "mout_sw_aclk66"};
+PNAME(mout_user_aclk66_gpio_p) = {"mout_sw_aclk66", "ffactor_sw_aclk66"};
+
+PNAME(mout_sw_aclk200_fsys_p) = {"dout_aclk200_fsys", "mout_sclk_spll"};
+PNAME(mout_sw_pclk200_fsys_p) = {"dout_pclk200_fsys", "mout_sclk_spll"};
+PNAME(mout_user_pclk200_fsys_p)	= {"fin_pll", "mout_sw_pclk200_fsys"};
+PNAME(mout_user_aclk200_fsys_p)	= {"fin_pll", "mout_sw_aclk200_fsys"};
+PNAME(mout_sw_aclk200_fsys2_p) = {"dout_aclk200_fsys2", "mout_sclk_spll"};
+PNAME(mout_user_aclk200_fsys2_p) = {"fin_pll", "mout_sw_aclk200_fsys2"};
+
+PNAME(mout_sw_aclk100_noc_p) = {"dout_aclk100_noc", "mout_sclk_spll"};
+PNAME(mout_user_aclk100_noc_p) = {"fin_pll", "mout_sw_aclk100_noc"};
+
+PNAME(mout_sw_aclk400_wcore_p) = {"dout_aclk400_wcore", "mout_sclk_spll"};
+PNAME(mout_aclk400_wcore_bpll_p) = {"mout_aclk400_wcore", "sclk_bpll"};
+PNAME(mout_user_aclk400_wcore_p) = {"fin_pll", "mout_sw_aclk400_wcore"};
+
+PNAME(mout_sw_aclk400_isp_p) = {"dout_aclk400_isp", "mout_sclk_spll"};
+PNAME(mout_user_aclk400_isp_p) = {"fin_pll", "mout_sw_aclk400_isp"};
+
+PNAME(mout_sw_aclk333_432_isp0_p) = {"dout_aclk333_432_isp0",
+					"mout_sclk_spll"};
+PNAME(mout_user_aclk333_432_isp0_p) = {"fin_pll", "mout_sw_aclk333_432_isp0"};
+
+PNAME(mout_sw_aclk333_432_isp_p) = {"dout_aclk333_432_isp", "mout_sclk_spll"};
+PNAME(mout_user_aclk333_432_isp_p) = {"fin_pll", "mout_sw_aclk333_432_isp"};
+
+PNAME(mout_sw_aclk200_p) = {"dout_aclk200", "mout_sclk_spll"};
+PNAME(mout_aclk200_disp1_p) = {"fin_pll", "mout_sw_aclk200"};
+
+PNAME(mout_sw_aclk400_mscl_p) = {"dout_aclk400_mscl", "mout_sclk_spll"};
+PNAME(mout_user_aclk400_mscl_p)	= {"fin_pll", "mout_sw_aclk400_mscl"};
+
+PNAME(mout_sw_aclk333_p) = {"dout_aclk333", "mout_sclk_spll"};
+PNAME(mout_user_aclk333_p) = {"fin_pll", "mout_sw_aclk333"};
+
+PNAME(mout_sw_aclk166_p) = {"dout_aclk166", "mout_sclk_spll"};
+PNAME(mout_user_aclk166_p) = {"fin_pll", "mout_sw_aclk166"};
+
+PNAME(mout_sw_aclk266_p) = {"dout_aclk266", "mout_sclk_spll"};
+PNAME(mout_user_aclk266_p) = {"fin_pll", "mout_sw_aclk266"};
+PNAME(mout_user_aclk266_isp_p) = {"fin_pll", "mout_sw_aclk266"};
+
+PNAME(mout_sw_aclk333_432_gscl_p) = {"dout_aclk333_432_gscl",
+					"mout_sclk_spll"};
+PNAME(mout_user_aclk333_432_gscl_p) = {"fin_pll", "mout_sw_aclk333_432_gscl"};
+
+PNAME(mout_sw_aclk300_gscl_p) = {"dout_aclk300_gscl", "mout_sclk_spll"};
+PNAME(mout_user_aclk300_gscl_p)	= {"fin_pll", "mout_sw_aclk300_gscl"};
+
+PNAME(mout_sw_aclk300_disp1_p) = {"dout_aclk300_disp1", "mout_sclk_spll"};
+PNAME(mout_sw_aclk400_disp1_p) = {"dout_aclk400_disp1", "mout_sclk_spll"};
+PNAME(mout_user_aclk300_disp1_p) = {"fin_pll", "mout_sw_aclk300_disp1"};
+PNAME(mout_user_aclk400_disp1_p) = {"fin_pll", "mout_sw_aclk400_disp1"};
+
+PNAME(mout_sw_aclk300_jpeg_p) = {"dout_aclk300_jpeg", "mout_sclk_spll"};
+PNAME(mout_user_aclk300_jpeg_p) = {"fin_pll", "mout_sw_aclk300_jpeg"};
+
+PNAME(mout_sw_aclk_g3d_p) = {"dout_aclk_g3d", "mout_sclk_spll"};
+PNAME(mout_user_aclk_g3d_p) = {"fin_pll", "mout_sw_aclk_g3d"};
+
+PNAME(mout_sw_aclk266_g2d_p) = {"dout_aclk266_g2d", "mout_sclk_spll"};
+PNAME(mout_user_aclk266_g2d_p) = {"fin_pll", "mout_sw_aclk266_g2d"};
+
+PNAME(mout_sw_aclk333_g2d_p) = {"dout_aclk333_g2d", "mout_sclk_spll"};
+PNAME(mout_user_aclk333_g2d_p) = {"fin_pll", "mout_sw_aclk333_g2d"};
+
+PNAME(mout_audio0_p) = {"fin_pll", "cdclk0", "mout_sclk_dpll",
+				"mout_sclk_mpll", "mout_sclk_spll",
+				"mout_sclk_ipll", "mout_sclk_epll",
+				"mout_sclk_rpll"};
+PNAME(mout_audio1_p) = {"fin_pll", "cdclk1", "mout_sclk_dpll",
+				"mout_sclk_mpll", "mout_sclk_spll",
+				"mout_sclk_ipll", "mout_sclk_epll",
+				"mout_sclk_rpll"};
+PNAME(mout_audio2_p) = {"fin_pll", "cdclk2", "mout_sclk_dpll",
+				"mout_sclk_mpll", "mout_sclk_spll",
+				"mout_sclk_ipll", "mout_sclk_epll",
+				"mout_sclk_rpll"};
+PNAME(mout_spdif_p) = {"fin_pll", "dout_audio0", "dout_audio1",
+				"dout_audio2", "spdif_extclk",
+				"mout_sclk_ipll", "mout_sclk_epll",
+				"mout_sclk_rpll"};
+PNAME(mout_hdmi_p) = {"dout_hdmi_pixel", "sclk_hdmiphy"};
+PNAME(mout_maudio0_p) = {"fin_pll", "maudio_clk", "mout_sclk_dpll",
+				"mout_sclk_mpll",
+				"mout_sclk_spll", "mout_sclk_ipll",
+				"mout_sclk_epll", "mout_sclk_rpll"};
+PNAME(mout_mau_epll_clk_p) = {"mout_sclk_epll", "mout_sclk_dpll",
+				"mout_sclk_mpll", "mout_sclk_spll"};
 
 /* fixed rate clocks generated outside the soc */
 static struct samsung_fixed_rate_clock exynos5420_fixed_rate_ext_clks[] __initdata = {
 	FRATE(fin_pll, "fin_pll", NULL, CLK_IS_ROOT, 0),
+	FRATE(none, "cdclk0", NULL, CLK_IS_ROOT, 0),
+	FRATE(none, "cdclk1", NULL, CLK_IS_ROOT, 0),
 };
 
 /* fixed rate clocks generated inside the soc */
@@ -352,134 +475,203 @@ static struct samsung_fixed_rate_clock exynos5420_fixed_rate_clks[] __initdata =
 };
 
 static struct samsung_fixed_factor_clock exynos5420_fixed_factor_clks[] __initdata = {
-	FFACTOR(none, "sclk_hsic_12m", "fin_pll", 1, 2, 0),
+	FFACTOR(none, "ffactor_hsic_12m", "fin_pll", 1, 2, 0),
+	FFACTOR(none, "ffactor_sw_aclk66", "mout_sw_aclk66", 1, 2, 0),
 };
 
 static struct samsung_mux_clock exynos5420_mux_clks[] __initdata = {
-	MUX(none, "mout_mspll_kfc", mspll_cpu_p, SRC_TOP7, 8, 2),
-	MUX(none, "mout_mspll_cpu", mspll_cpu_p, SRC_TOP7, 12, 2),
-	MUX(none, "mout_apll", apll_p, SRC_CPU, 0, 1),
-	MUX(none, "mout_cpu", cpu_p, SRC_CPU, 16, 1),
-	MUX(none, "mout_kpll", kpll_p, SRC_KFC, 0, 1),
-	MUX(none, "mout_cpu_kfc", kfc_p, SRC_KFC, 16, 1),
+	MUX(none, "mout_mspll_kfc", mout_mspll_cpu_p, SRC_TOP7, 8, 2),
+	MUX(none, "mout_mspll_cpu", mout_mspll_cpu_p, SRC_TOP7, 12, 2),
+	MUX(none, "mout_apll", mout_apll_p, SRC_CPU, 0, 1),
+	MUX(none, "mout_cpu", mout_cpu_p, SRC_CPU, 16, 1),
+	MUX(none, "mout_kpll", mout_kpll_p, SRC_KFC, 0, 1),
+	MUX(none, "mout_kfc", mout_kfc_p, SRC_KFC, 16, 1),
 
-	MUX(none, "sclk_bpll", bpll_p, SRC_CDREX, 0, 1),
+	MUX(none, "sclk_bpll", mout_bpll_p, TOP_SPARE2, 0, 1),
 
-	MUX_A(none, "mout_aclk400_mscl", group1_p,
+	MUX_A(none, "mout_aclk400_mscl", mout_group1_p,
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
+	MUX(none, "mout_aclk200", mout_group1_p, SRC_TOP0, 8, 2),
+	MUX(none, "mout_aclk200_fsys2", mout_group1_p, SRC_TOP0, 12, 2),
+	MUX(none, "mout_aclk200_fsys", mout_group1_p, SRC_TOP0, 28, 2),
+
+	MUX(none, "mout_aclk333_432_gscl", mout_group4_p, SRC_TOP1, 0, 2),
+	MUX(none, "mout_aclk66", mout_group1_p, SRC_TOP1, 8, 2),
+	MUX(none, "mout_aclk266", mout_group1_p, SRC_TOP1, 20, 2),
+	MUX(none, "mout_aclk166", mout_group1_p, SRC_TOP1, 24, 2),
+	MUX(none, "mout_aclk333", mout_group1_p, SRC_TOP1, 28, 2),
+
+	MUX(none, "mout_aclk333_g2d", mout_group1_p, SRC_TOP2, 8, 2),
+	MUX(none, "mout_aclk266_g2d", mout_group1_p, SRC_TOP2, 12, 2),
+	MUX(none, "mout_aclk_g3d", mout_group5_p, SRC_TOP2, 16, 1),
+	MUX(none, "mout_aclk300_jpeg", mout_group1_p, SRC_TOP2, 20, 2),
+	MUX(none, "mout_aclk300_disp1", mout_group1_p, SRC_TOP2, 24, 2),
+	MUX(none, "mout_aclk300_gscl", mout_group1_p, SRC_TOP2, 28, 2),
+
+	MUX(none, "mout_user_aclk400_mscl", mout_user_aclk400_mscl_p,
 			SRC_TOP3, 4, 1),
-	MUX_A(none, "mout_aclk200_disp1", aclk200_disp1_p,
-			SRC_TOP3, 8, 1, "aclk200_disp1"),
-	MUX(none, "mout_user_aclk200_fsys2", user_aclk200_fsys2_p,
+	MUX(none, "mout_aclk200_disp1", mout_aclk200_disp1_p, SRC_TOP3, 8, 1),
+	MUX(none, "mout_user_aclk200_fsys2", mout_user_aclk200_fsys2_p,
 			SRC_TOP3, 12, 1),
-	MUX(none, "mout_user_aclk200_fsys", user_aclk200_fsys_p,
+	MUX(none, "mout_user_aclk200_fsys", mout_user_aclk200_fsys_p,
 			SRC_TOP3, 28, 1),
 
-	MUX(none, "mout_user_aclk333_432_gscl", user_aclk333_432_gscl_p,
-			SRC_TOP4, 0, 1),
-	MUX(none, "mout_aclk66_peric", aclk66_peric_p, SRC_TOP4, 8, 1),
-	MUX(none, "mout_user_aclk266", user_aclk266_p, SRC_TOP4, 20, 1),
-	MUX(none, "mout_user_aclk166", user_aclk166_p, SRC_TOP4, 24, 1),
-	MUX(none, "mout_user_aclk333", user_aclk333_p, SRC_TOP4, 28, 1),
-
-	MUX(none, "mout_aclk66_psgen", aclk66_peric_p, SRC_TOP5, 4, 1),
-	MUX(none, "mout_user_aclk333_g2d", user_aclk333_g2d_p, SRC_TOP5, 8, 1),
-	MUX(none, "mout_user_aclk266_g2d", user_aclk266_g2d_p, SRC_TOP5, 12, 1),
-	MUX_A(none, "mout_user_aclk_g3d", user_aclk_g3d_p,
-			SRC_TOP5, 16, 1, "aclkg3d"),
-	MUX(none, "mout_user_aclk300_jpeg", user_aclk300_jpeg_p,
+	MUX(mout_user_aclk333_432_gscl, "mout_user_aclk333_432_gscl",
+			 mout_user_aclk333_432_gscl_p, SRC_TOP4, 0, 1),
+	MUX(none, "mout_user_aclk66_peric", mout_user_aclk66_peric_p,
+			SRC_TOP4, 8, 1),
+	MUX(none, "mout_user_aclk266", mout_user_aclk266_p, SRC_TOP4, 20, 1),
+	MUX(none, "mout_user_aclk166", mout_user_aclk166_p, SRC_TOP4, 24, 1),
+	MUX(mout_user_aclk333, "mout_user_aclk333", mout_user_aclk333_p,
+			SRC_TOP4, 28, 1),
+
+	MUX(none, "mout_user_aclk66_psgen", mout_user_aclk66_peric_p, SRC_TOP5,
+			4, 1),
+	MUX(none, "mout_user_aclk333_g2d", mout_user_aclk333_g2d_p, SRC_TOP5,
+			8, 1),
+	MUX(none, "mout_user_aclk266_g2d", mout_user_aclk266_g2d_p, SRC_TOP5,
+			12, 1),
+	MUX(mout_g3d, "mout_user_aclk_g3d", mout_user_aclk_g3d_p,
+			SRC_TOP5, 16, 1),
+	MUX(none, "mout_user_aclk300_jpeg", mout_user_aclk300_jpeg_p,
 			SRC_TOP5, 20, 1),
-	MUX(none, "mout_user_aclk300_disp1", user_aclk300_disp1_p,
+	MUX(none, "mout_user_aclk300_disp1", mout_user_aclk300_disp1_p,
 			SRC_TOP5, 24, 1),
-	MUX(none, "mout_user_aclk300_gscl", user_aclk300_gscl_p,
-			SRC_TOP5, 28, 1),
-
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
+	MUX(mout_user_aclk300_gscl, "mout_user_aclk300_gscl",
+			mout_user_aclk300_gscl_p, SRC_TOP5, 28, 1),
+
+	MUX(none, "mout_sclk_mpll", mout_mpll_p, SRC_TOP6, 0, 1),
+	MUX(none, "mout_sclk_vpll", mout_vpll_p, SRC_TOP6, 4, 1),
+	MUX(none, "mout_sclk_spll", mout_spll_p, SRC_TOP6, 8, 1),
+	MUX(none, "mout_sclk_ipll", mout_ipll_p, SRC_TOP6, 12, 1),
+	MUX(none, "mout_sclk_rpll", mout_rpll_p, SRC_TOP6, 16, 1),
+	MUX(none, "mout_sclk_epll", mout_epll_p, SRC_TOP6, 20, 1),
+	MUX(none, "mout_sclk_dpll", mout_dpll_p, SRC_TOP6, 24, 1),
+	MUX(none, "mout_sclk_cpll", mout_cpll_p, SRC_TOP6, 28, 1),
+
+	MUX(none, "mout_sw_aclk400_mscl", mout_sw_aclk400_mscl_p,
+			SRC_TOP10, 4, 1),
+	MUX(none, "mout_sw_aclk200", mout_sw_aclk200_p, SRC_TOP10, 8, 1),
+	MUX(none, "mout_sw_aclk200_fsys2", mout_sw_aclk200_fsys2_p,
 			SRC_TOP10, 12, 1),
-	MUX(none, "mout_sw_aclk200_fsys", sw_aclk200_fsys_p, SRC_TOP10, 28, 1),
-
-	MUX(none, "mout_sw_aclk333_432_gscl", sw_aclk333_432_gscl_p,
-			SRC_TOP11, 0, 1),
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
+	MUX(none, "mout_sw_aclk200_fsys", mout_sw_aclk200_fsys_p,
+			SRC_TOP10, 28, 1),
+	MUX(mout_sw_aclk333_432_gscl, "mout_sw_aclk333_432_gscl",
+			mout_sw_aclk333_432_gscl_p, SRC_TOP11, 0, 1),
+	MUX(none, "mout_sw_aclk66", mout_sw_aclk66_p, SRC_TOP11, 8, 1),
+	MUX(none, "mout_sw_aclk266", mout_sw_aclk266_p, SRC_TOP11, 20, 1),
+	MUX(none, "mout_sw_aclk166", mout_sw_aclk166_p, SRC_TOP11, 24, 1),
+	MUX(mout_sw_aclk333, "mout_sw_aclk333", mout_sw_aclk333_p,
+			SRC_TOP11, 28, 1),
+
+	MUX(none, "mout_sw_aclk333_g2d", mout_sw_aclk333_g2d_p,
+			SRC_TOP12, 8, 1),
+	MUX(none, "mout_sw_aclk266_g2d", mout_sw_aclk266_g2d_p,
+			SRC_TOP12, 12, 1),
+	MUX(none, "mout_sw_aclk_g3d", mout_sw_aclk_g3d_p, SRC_TOP12, 16, 1),
+	MUX(none, "mout_sw_aclk300_jpeg", mout_sw_aclk300_jpeg_p,
+			SRC_TOP12, 20, 1),
+	MUX(none, "mout_sw_aclk300_disp1", mout_sw_aclk300_disp1_p,
 			SRC_TOP12, 24, 1),
-	MUX(none, "mout_sw_aclk300_gscl", sw_aclk300_gscl_p, SRC_TOP12, 28, 1),
+	MUX(mout_sw_aclk300_gscl, "mout_sw_aclk300_gscl",
+			mout_sw_aclk300_gscl_p, SRC_TOP12, 28, 1),
 
 	/* DISP1 Block */
-	MUX(none, "mout_fimd1", group3_p, SRC_DISP10, 4, 1),
-	MUX(none, "mout_mipi1", group2_p, SRC_DISP10, 16, 3),
-	MUX(none, "mout_dp1", group2_p, SRC_DISP10, 20, 3),
-	MUX(none, "mout_pixel", group2_p, SRC_DISP10, 24, 3),
-	MUX(mout_hdmi, "mout_hdmi", hdmi_p, SRC_DISP10, 28, 1),
+	MUX(mout_fimd1, "mout_fimd1", mout_group3_p, SRC_DISP10, 4, 1),
+	MUX(none, "mout_mipi1", mout_group2_p, SRC_DISP10, 16, 3),
+	MUX(none, "mout_dp1", mout_group2_p, SRC_DISP10, 20, 3),
+	MUX(none, "mout_pixel", mout_group2_p, SRC_DISP10, 24, 3),
+	MUX(mout_hdmi, "mout_hdmi", mout_hdmi_p, SRC_DISP10, 28, 1),
+	MUX_F(none, "mout_fimd1_opt", mout_group2_p, SRC_DISP10, 8, 3,
+						CLK_SET_RATE_PARENT, 0),
+	MUX_F(none, "mout_fimd1_final", mout_fimd1_final_p, TOP_SPARE2, 8, 1,
+						CLK_SET_RATE_PARENT, 0),
 
 	/* MAU Block */
-	MUX(none, "mout_maudio0", maudio0_p, SRC_MAU, 28, 3),
+	MUX_F(mout_maudio0, "mout_maudio0", mout_maudio0_p, SRC_MAU, 28, 3,
+						CLK_SET_RATE_PARENT, 0),
 
 	/* FSYS Block */
-	MUX(none, "mout_usbd301", group2_p, SRC_FSYS, 4, 3),
-	MUX(none, "mout_mmc0", group2_p, SRC_FSYS, 8, 3),
-	MUX(none, "mout_mmc1", group2_p, SRC_FSYS, 12, 3),
-	MUX(none, "mout_mmc2", group2_p, SRC_FSYS, 16, 3),
-	MUX(none, "mout_usbd300", group2_p, SRC_FSYS, 20, 3),
-	MUX(none, "mout_unipro", group2_p, SRC_FSYS, 24, 3),
+	MUX(none, "mout_usbd301", mout_group2_p, SRC_FSYS, 4, 3),
+	MUX(none, "mout_mmc0", mout_group2_p, SRC_FSYS, 8, 3),
+	MUX(none, "mout_mmc1", mout_group2_p, SRC_FSYS, 12, 3),
+	MUX(none, "mout_mmc2", mout_group2_p, SRC_FSYS, 16, 3),
+	MUX(none, "mout_usbd300", mout_group2_p, SRC_FSYS, 20, 3),
+	MUX(none, "mout_unipro", mout_group2_p, SRC_FSYS, 24, 3),
+	MUX(none, "mout_mphy_refclk", mout_group2_p, SRC_FSYS, 28, 3),
 
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
+	MUX(none, "mout_uart0", mout_group2_p, SRC_PERIC0, 4, 3),
+	MUX(none, "mout_uart1", mout_group2_p, SRC_PERIC0, 8, 3),
+	MUX(none, "mout_uart2", mout_group2_p, SRC_PERIC0, 12, 3),
+	MUX(none, "mout_uart3", mout_group2_p, SRC_PERIC0, 16, 3),
+	MUX(none, "mout_pwm", mout_group2_p, SRC_PERIC0, 24, 3),
+	MUX(none, "mout_spdif", mout_spdif_p, SRC_PERIC0, 28, 3),
+	MUX(none, "mout_audio0", mout_audio0_p, SRC_PERIC1, 8, 3),
+	MUX(none, "mout_audio1", mout_audio1_p, SRC_PERIC1, 12, 3),
+	MUX(none, "mout_audio2", mout_audio2_p, SRC_PERIC1, 16, 3),
+	MUX(mout_spi0, "mout_spi0", mout_group2_p, SRC_PERIC1, 20, 3),
+	MUX(mout_spi1, "mout_spi1", mout_group2_p, SRC_PERIC1, 24, 3),
+	MUX(mout_spi2, "mout_spi2", mout_group2_p, SRC_PERIC1, 28, 3),
+
+	MUX(none, "mout_user_aclk66_gpio", mout_user_aclk66_gpio_p,
+		SRC_TOP7, 4, 1),
+	MUX_F(none, "mout_mau_epll_clk", mout_mau_epll_clk_p, SRC_TOP7, 20, 2,
+		CLK_SET_RATE_PARENT, 0),
+	MUX(none, "mout_pclk200_fsys", mout_group1_p, SRC_TOP0, 24, 2),
+	MUX(none, "mout_sw_pclk200_fsys", mout_sw_pclk200_fsys_p,
+		SRC_TOP10, 24, 1),
+	MUX(none, "mout_user_pclk200_fsys", mout_user_pclk200_fsys_p,
+		SRC_TOP3, 24, 1),
+	MUX(none, "mout_aclk100_noc", mout_group1_p, SRC_TOP0, 20, 2),
+	MUX(none, "mout_sw_aclk100_noc", mout_sw_aclk100_noc_p,
+		SRC_TOP10, 20, 1),
+	MUX(none, "mout_user_aclk100_noc", mout_user_aclk100_noc_p,
+		SRC_TOP3, 20, 1),
+	MUX(none, "mout_aclk400_wcore", mout_group1_p, SRC_TOP0, 16, 2),
+	MUX(none, "mout_aclk400_wcore_bpll", mout_aclk400_wcore_bpll_p,
+		TOP_SPARE2, 4, 1),
+	MUX(none, "mout_sw_aclk400_wcore", mout_sw_aclk400_wcore_p,
+		SRC_TOP10, 16, 1),
+	MUX(none, "mout_user_aclk400_wcore", mout_user_aclk400_wcore_p,
+		SRC_TOP3, 16, 1),
+	MUX(none, "mout_aclk400_isp", mout_group1_p, SRC_TOP0, 0, 2),
+	MUX(none, "mout_sw_aclk400_isp", mout_sw_aclk400_isp_p,
+		SRC_TOP10, 0, 1),
+	MUX(none, "mout_user_aclk400_isp", mout_user_aclk400_isp_p,
+		SRC_TOP3, 0, 1),
+	MUX(none, "mout_aclk333_432_isp0", mout_group4_p, SRC_TOP1, 12, 2),
+	MUX(none, "mout_sw_aclk333_432_isp0", mout_sw_aclk333_432_isp0_p,
+		SRC_TOP11, 12, 1),
+	MUX(none, "mout_user_aclk333_432_isp0", mout_user_aclk333_432_isp0_p,
+		SRC_TOP4, 12, 1),
+	MUX(none, "mout_aclk333_432_isp", mout_group4_p,
+		SRC_TOP1, 4, 2),
+	MUX(none, "mout_sw_aclk333_432_isp", mout_sw_aclk333_432_isp_p,
+		SRC_TOP11, 4, 1),
+	MUX(none, "mout_user_aclk333_432_isp", mout_user_aclk333_432_isp_p,
+		SRC_TOP4, 4, 1),
+	MUX(none, "mout_user_aclk266_isp", mout_user_aclk266_isp_p,
+		SRC_TOP4, 16, 1),
+	MUX(none, "mout_aclk400_disp1", mout_group1_p, SRC_TOP2, 4, 2),
+	MUX(none, "mout_sw_aclk400_disp1", mout_sw_aclk400_disp1_p,
+		SRC_TOP12, 4, 1),
+	MUX(none, "mout_user_aclk400_disp1", mout_user_aclk400_disp1_p,
+		SRC_TOP5, 0, 1),
+
+	/* ISP Block*/
+	MUX(none, "mout_pwm_isp", mout_group2_p, SRC_ISP, 24, 3),
+	MUX(none, "mout_uart_isp", mout_group2_p, SRC_ISP, 20, 3),
+	MUX(none, "mout_spi0_isp", mout_group2_p, SRC_ISP, 12, 3),
+	MUX(none, "mout_spi1_isp", mout_group2_p, SRC_ISP, 16, 3),
+	MUX(none, "mout_isp_sensor", mout_group2_p, SRC_ISP, 28, 3),
 };
 
 static struct samsung_div_clock exynos5420_div_clks[] __initdata = {
-	DIV(none, "div_arm", "mout_cpu", DIV_CPU0, 0, 3),
+	DIV(none, "dout_armclk1", "mout_cpu", DIV_CPU0, 0, 3),
 	DIV(none, "sclk_apll", "mout_apll", DIV_CPU0, 24, 3),
-	DIV(none, "armclk2", "div_arm", DIV_CPU0, 28, 3),
-	DIV(none, "div_kfc", "mout_cpu_kfc", DIV_KFC0, 0, 3),
+	DIV(none, "dout_armclk2", "dout_armclk1", DIV_CPU0, 28, 3),
+	DIV(none, "dout_kfc", "mout_kfc", DIV_KFC0, 0, 3),
 	DIV(none, "sclk_kpll", "mout_kpll", DIV_KFC0, 24, 3),
 
 	DIV(none, "dout_aclk400_mscl", "mout_aclk400_mscl", DIV_TOP0, 4, 3),
@@ -499,15 +691,15 @@ static struct samsung_div_clock exynos5420_div_clks[] __initdata = {
 	DIV(none, "dout_aclk266_g2d", "mout_aclk266_g2d", DIV_TOP2, 12, 3),
 	DIV(none, "dout_aclk_g3d", "mout_aclk_g3d", DIV_TOP2, 16, 3),
 	DIV(none, "dout_aclk300_jpeg", "mout_aclk300_jpeg", DIV_TOP2, 20, 3),
-	DIV_A(none, "dout_aclk300_disp1", "mout_aclk300_disp1",
-			DIV_TOP2, 24, 3, "aclk300_disp1"),
+	DIV(none, "dout_aclk300_disp1", "mout_aclk300_disp1", DIV_TOP2, 24, 3),
 	DIV(none, "dout_aclk300_gscl", "mout_aclk300_gscl", DIV_TOP2, 28, 3),
 
 	/* DISP1 Block */
-	DIV(none, "dout_fimd1", "mout_fimd1", DIV_DISP10, 0, 4),
+	DIV(none, "dout_fimd1", "mout_fimd1_final", DIV_DISP10, 0, 4),
 	DIV(none, "dout_mipi1", "mout_mipi1", DIV_DISP10, 16, 8),
 	DIV(none, "dout_dp1", "mout_dp1", DIV_DISP10, 24, 4),
 	DIV(dout_pixel, "dout_hdmi_pixel", "mout_pixel", DIV_DISP10, 28, 4),
+	DIV(none, "dout_disp1_blk", "aclk200_disp1", DIV2_RATIO0, 16, 2),
 
 	/* Audio Block */
 	DIV(none, "dout_maudio0", "mout_maudio0", DIV_MAU, 20, 4),
@@ -525,6 +717,7 @@ static struct samsung_div_clock exynos5420_div_clks[] __initdata = {
 	DIV(none, "dout_mmc2", "mout_mmc2", DIV_FSYS1, 20, 10),
 
 	DIV(none, "dout_unipro", "mout_unipro", DIV_FSYS2, 24, 8),
+	DIV(none, "dout_mphy_refclk", "mout_mphy_refclk", DIV_FSYS2, 16, 8),
 
 	/* UART and PWM */
 	DIV(none, "dout_uart0", "mout_uart0", DIV_PERIC0, 8, 4),
@@ -550,39 +743,72 @@ static struct samsung_div_clock exynos5420_div_clks[] __initdata = {
 	DIV(none, "dout_audio2", "mout_audio2", DIV_PERIC3, 28, 4),
 
 	/* SPI Pre-Ratio */
-	DIV(none, "dout_pre_spi0", "dout_spi0", DIV_PERIC4, 8, 8),
-	DIV(none, "dout_pre_spi1", "dout_spi1", DIV_PERIC4, 16, 8),
-	DIV(none, "dout_pre_spi2", "dout_spi2", DIV_PERIC4, 24, 8),
+	DIV(none, "dout_spi0_pre", "dout_spi0", DIV_PERIC4, 8, 8),
+	DIV(none, "dout_spi1_pre", "dout_spi1", DIV_PERIC4, 16, 8),
+	DIV(none, "dout_spi2_pre", "dout_spi2", DIV_PERIC4, 24, 8),
+
+	DIV(none, "dout_aclk400_disp1", "mout_aclk400_disp1",
+		DIV_TOP2, 4, 3),
+	DIV(none, "dout_aclk100_noc", "mout_aclk100_noc", DIV_TOP0, 20, 3),
+	DIV(none, "dout_aclk400_wcore", "mout_aclk400_wcore_bpll",
+		DIV_TOP0, 16, 3),
+	DIV(none, "dout_aclk400_isp", "mout_aclk400_isp", DIV_TOP0, 0, 3),
+	DIV(none, "dout_aclk333_432_isp0", "mout_aclk333_432_isp0",
+		DIV_TOP1, 16, 3),
+	DIV(none, "dout_aclk333_432_isp", "mout_aclk333_432_isp",
+		DIV_TOP1, 4, 3),
+	/* Mfc Blk */
+	DIV(none, "dout_mfc_blk", "mout_user_aclk333", DIV4_RATIO, 0, 2),
+	/* Gscl Blk */
+	DIV(none, "dout_gscl_blk_300", "mout_user_aclk300_gscl",
+						DIV2_RATIO0, 4, 2),
+	DIV(none, "dout_gscl_blk_333", "aclk333_432_gscl", DIV2_RATIO0, 6, 2),
+	/* Mscl Blk */
+	DIV(none, "dout_mscl_blk", "aclk400_mscl", DIV2_RATIO0, 28, 2),
+	/* Psgen */
+	DIV(none, "dout_gen_blk", "mout_user_aclk266", DIV2_RATIO0, 8, 1),
+	/* Jpeg */
+	DIV(none, "dout_jpg_blk", "aclk166", DIV2_RATIO0, 20, 1),
+	/* isp */
+	DIV(none, "dout_pwm_isp", "mout_pwm_isp", SCLK_DIV_ISP1, 28, 4),
+	DIV(none, "dout_uart_isp", "mout_uart_isp", SCLK_DIV_ISP1, 24, 4),
+	DIV(none, "dout_spi0_isp", "mout_spi0_isp", SCLK_DIV_ISP1, 16, 4),
+	DIV(none, "dout_spi1_isp", "mout_spi1_isp", SCLK_DIV_ISP1, 20, 4),
+	DIV(none, "dout_spi0_isp_pre", "dout_spi0_isp", SCLK_DIV_ISP1, 0, 8),
+	DIV(none, "dout_spi1_isp_pre", "dout_spi1_isp", SCLK_DIV_ISP1, 8, 8),
+	DIV(none, "dout_isp_sensor0", "mout_isp_sensor", SCLK_DIV_ISP0, 8, 8),
+	DIV(none, "dout_isp_sensor1", "mout_isp_sensor", SCLK_DIV_ISP0, 16, 8),
+	DIV(none, "dout_isp_sensor2", "mout_isp_sensor", SCLK_DIV_ISP0, 24, 8),
 };
 
 static struct samsung_gate_clock exynos5420_gate_clks[] __initdata = {
-	/* TODO: Re-verify the CG bits for all the gate clocks */
-	GATE_A(mct, "pclk_st", "aclk66_psgen", GATE_BUS_PERIS1, 2, 0, 0, "mct"),
+	GATE(pclk_mct, "pclk_mct", "aclk66_psgen", GATE_BUS_PERIS1, 2, 0, 0),
 
-	GATE(0, "aclk200_fsys", "mout_user_aclk200_fsys",
+	GATE(aclk200_fsys, "aclk200_fsys", "mout_user_aclk200_fsys",
 			GATE_BUS_FSYS0, 9, CLK_IGNORE_UNUSED, 0),
-	GATE(0, "aclk200_fsys2", "mout_user_aclk200_fsys2",
+	GATE(aclk200_fsys2, "aclk200_fsys2", "mout_user_aclk200_fsys2",
 			GATE_BUS_FSYS0, 10, CLK_IGNORE_UNUSED, 0),
 
-	GATE(0, "aclk333_g2d", "mout_user_aclk333_g2d",
+	GATE(aclk333_g2d, "aclk333_g2d", "mout_user_aclk333_g2d",
 			GATE_BUS_TOP, 0, CLK_IGNORE_UNUSED, 0),
-	GATE(0, "aclk266_g2d", "mout_user_aclk266_g2d",
+	GATE(aclk266_g2d, "aclk266_g2d", "mout_user_aclk266_g2d",
 			GATE_BUS_TOP, 1, CLK_IGNORE_UNUSED, 0),
-	GATE(0, "aclk300_jpeg", "mout_user_aclk300_jpeg",
+	GATE(aclk300_jpeg, "aclk300_jpeg", "mout_user_aclk300_jpeg",
 			GATE_BUS_TOP, 4, CLK_IGNORE_UNUSED, 0),
-	GATE(0, "aclk300_gscl", "mout_user_aclk300_gscl",
+	GATE(aclk300_gscl, "aclk300_gscl", "mout_user_aclk300_gscl",
 			GATE_BUS_TOP, 6, CLK_IGNORE_UNUSED, 0),
-	GATE(0, "aclk333_432_gscl", "mout_user_aclk333_432_gscl",
+	GATE(aclk333_432_gscl, "aclk333_432_gscl",
+			"mout_user_aclk333_432_gscl",
 			GATE_BUS_TOP, 7, CLK_IGNORE_UNUSED, 0),
-	GATE(0, "pclk66_gpio", "mout_sw_aclk66",
+	GATE(pclk66_gpio, "pclk66_gpio", "mout_user_aclk66_gpio",
 			GATE_BUS_TOP, 9, CLK_IGNORE_UNUSED, 0),
-	GATE(0, "aclk66_psgen", "mout_aclk66_psgen",
+	GATE(aclk66_psgen, "aclk66_psgen", "mout_user_aclk66_psgen",
 			GATE_BUS_TOP, 10, CLK_IGNORE_UNUSED, 0),
-	GATE(0, "aclk66_peric", "mout_aclk66_peric",
-			GATE_BUS_TOP, 11, 0, 0),
-	GATE(0, "aclk166", "mout_user_aclk166",
+	GATE(aclk66_peric, "aclk66_peric", "mout_user_aclk66_peric",
+			GATE_BUS_TOP, 11, CLK_IGNORE_UNUSED, 0),
+	GATE(aclk166, "aclk166", "mout_user_aclk166",
 			GATE_BUS_TOP, 14, CLK_IGNORE_UNUSED, 0),
-	GATE(0, "aclk333", "mout_aclk333",
+	GATE(aclk333, "aclk333", "mout_user_aclk333",
 			GATE_BUS_TOP, 15, CLK_IGNORE_UNUSED, 0),
 
 	/* sclk */
@@ -594,11 +820,11 @@ static struct samsung_gate_clock exynos5420_gate_clks[] __initdata = {
 		GATE_TOP_SCLK_PERIC, 2, CLK_SET_RATE_PARENT, 0),
 	GATE(sclk_uart3, "sclk_uart3", "dout_uart3",
 		GATE_TOP_SCLK_PERIC, 3, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_spi0, "sclk_spi0", "dout_pre_spi0",
+	GATE(sclk_spi0, "sclk_spi0", "dout_spi0_pre",
 		GATE_TOP_SCLK_PERIC, 6, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_spi1, "sclk_spi1", "dout_pre_spi1",
+	GATE(sclk_spi1, "sclk_spi1", "dout_spi1_pre",
 		GATE_TOP_SCLK_PERIC, 7, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_spi2, "sclk_spi2", "dout_pre_spi2",
+	GATE(sclk_spi2, "sclk_spi2", "dout_spi2_pre",
 		GATE_TOP_SCLK_PERIC, 8, CLK_SET_RATE_PARENT, 0),
 	GATE(sclk_spdif, "sclk_spdif", "mout_spdif",
 		GATE_TOP_SCLK_PERIC, 9, CLK_SET_RATE_PARENT, 0),
@@ -620,20 +846,20 @@ static struct samsung_gate_clock exynos5420_gate_clks[] __initdata = {
 	GATE(sclk_mmc2, "sclk_mmc2", "dout_mmc2",
 		GATE_TOP_SCLK_FSYS, 2, CLK_SET_RATE_PARENT, 0),
 	GATE(sclk_usbphy301, "sclk_usbphy301", "dout_usbphy301",
-		GATE_TOP_SCLK_FSYS, 7, CLK_SET_RATE_PARENT, 0),
+		GATE_TOP_SCLK_FSYS, 7, CLK_IGNORE_UNUSED, 0),
 	GATE(sclk_usbphy300, "sclk_usbphy300", "dout_usbphy300",
-		GATE_TOP_SCLK_FSYS, 8, CLK_SET_RATE_PARENT, 0),
+		GATE_TOP_SCLK_FSYS, 8, CLK_IGNORE_UNUSED, 0),
 	GATE(sclk_usbd300, "sclk_usbd300", "dout_usbd300",
-		GATE_TOP_SCLK_FSYS, 9, CLK_SET_RATE_PARENT, 0),
+		GATE_TOP_SCLK_FSYS, 9, CLK_IGNORE_UNUSED, 0),
 	GATE(sclk_usbd301, "sclk_usbd301", "dout_usbd301",
-		GATE_TOP_SCLK_FSYS, 10, CLK_SET_RATE_PARENT, 0),
+		GATE_TOP_SCLK_FSYS, 10, CLK_IGNORE_UNUSED, 0),
 
-	GATE(sclk_usbd301, "sclk_unipro", "dout_unipro",
-		SRC_MASK_FSYS, 24, CLK_SET_RATE_PARENT, 0),
+	GATE(sclk_unipro, "sclk_unipro", "dout_unipro",
+			GATE_IP_FSYS, 23, CLK_SET_RATE_PARENT, 0),
 
-	GATE(sclk_gscl_wa, "sclk_gscl_wa", "aclK333_432_gscl",
+	GATE(sclk_gscl_wa, "sclk_gscl_wa", "mout_user_aclk333_432_gscl",
 		GATE_TOP_SCLK_GSCL, 6, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_gscl_wb, "sclk_gscl_wb", "aclk333_432_gscl",
+	GATE(sclk_gscl_wb, "sclk_gscl_wb", "mout_user_aclk333_432_gscl",
 		GATE_TOP_SCLK_GSCL, 7, CLK_SET_RATE_PARENT, 0),
 
 	/* Display */
@@ -654,132 +880,263 @@ static struct samsung_gate_clock exynos5420_gate_clks[] __initdata = {
 	GATE(sclk_maupcm0, "sclk_maupcm0", "dout_maupcm0",
 		GATE_TOP_SCLK_MAU, 1, CLK_SET_RATE_PARENT, 0),
 	/* FSYS */
-	GATE(tsi, "tsi", "aclk200_fsys", GATE_BUS_FSYS0, 0, 0, 0),
-	GATE(pdma0, "pdma0", "aclk200_fsys", GATE_BUS_FSYS0, 1, 0, 0),
-	GATE(pdma1, "pdma1", "aclk200_fsys", GATE_BUS_FSYS0, 2, 0, 0),
+	GATE(aclk_pdma0, "aclk_pdma0", "aclk200_fsys", GATE_BUS_FSYS0, 1, 0, 0),
+	GATE(aclk_pdma1, "aclk_pdma1", "aclk200_fsys", GATE_BUS_FSYS0, 2, 0, 0),
 	GATE(ufs, "ufs", "aclk200_fsys2", GATE_BUS_FSYS0, 3, 0, 0),
-	GATE(rtic, "rtic", "aclk200_fsys", GATE_BUS_FSYS0, 5, 0, 0),
-	GATE(mmc0, "mmc0", "aclk200_fsys2", GATE_BUS_FSYS0, 12, 0, 0),
-	GATE(mmc1, "mmc1", "aclk200_fsys2", GATE_BUS_FSYS0, 13, 0, 0),
-	GATE(mmc2, "mmc2", "aclk200_fsys2", GATE_BUS_FSYS0, 14, 0, 0),
-	GATE(sromc, "sromc", "aclk200_fsys2",
-			GATE_BUS_FSYS0, 19, CLK_IGNORE_UNUSED, 0),
-	GATE(usbh20, "usbh20", "aclk200_fsys", GATE_BUS_FSYS0, 20, 0, 0),
-	GATE(usbd300, "usbd300", "aclk200_fsys", GATE_BUS_FSYS0, 21, 0, 0),
-	GATE(usbd301, "usbd301", "aclk200_fsys", GATE_BUS_FSYS0, 28, 0, 0),
+	GATE(aclk_rtic, "aclk_rtic", "aclk200_fsys2", GATE_IP_FSYS, 9, 0, 0),
+	GATE(aclk_mmc0, "aclk_mmc0", "aclk200_fsys2", GATE_BUS_FSYS0, 12, 0, 0),
+	GATE(aclk_mmc1, "aclk_mmc1", "aclk200_fsys2", GATE_BUS_FSYS0, 13, 0, 0),
+	GATE(aclk_mmc2, "aclk_mmc2", "aclk200_fsys2", GATE_BUS_FSYS0, 14, 0, 0),
+	GATE(hclk_sromc, "hclk_sromc", "aclk200_fsys2",
+			GATE_IP_FSYS, 17, CLK_IGNORE_UNUSED, 0),
+	GATE(hclk_usbh20, "hclk_usbh20", "aclk200_fsys",
+			GATE_IP_FSYS, 18, 0, 0),
+	GATE(hclk_usbd300, "hclk_usbd300", "aclk200_fsys",
+			GATE_BUS_FSYS0, 21, 0, 0),
+	GATE(hclk_usbd301, "hclk_usbd301", "aclk200_fsys",
+			GATE_BUS_FSYS0, 28, 0, 0),
 
 	/* UART */
-	GATE(uart0, "uart0", "aclk66_peric", GATE_BUS_PERIC, 4, 0, 0),
-	GATE(uart1, "uart1", "aclk66_peric", GATE_BUS_PERIC, 5, 0, 0),
-	GATE_A(uart2, "uart2", "aclk66_peric",
-		GATE_BUS_PERIC, 6, CLK_IGNORE_UNUSED, 0, "uart2"),
-	GATE(uart3, "uart3", "aclk66_peric", GATE_BUS_PERIC, 7, 0, 0),
+	GATE(pclk_uart0, "pclk_uart0", "aclk66_peric", GATE_BUS_PERIC, 4, 0, 0),
+	GATE(pclk_uart1, "pclk_uart1", "aclk66_peric", GATE_BUS_PERIC, 5, 0, 0),
+	GATE(pclk_uart2, "pclk_uart2", "aclk66_peric",
+			GATE_BUS_PERIC, 6, 0, 0),
+	GATE(pclk_uart3, "pclk_uart3", "aclk66_peric", GATE_BUS_PERIC, 7, 0, 0),
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
+	GATE(pclk_i2c0, "pclk_i2c0", "aclk66_peric", GATE_IP_PERIC, 6, 0, 0),
+	GATE(pclk_i2c1, "pclk_i2c1", "aclk66_peric", GATE_IP_PERIC, 7, 0, 0),
+	GATE(pclk_i2c2, "pclk_i2c2", "aclk66_peric", GATE_IP_PERIC, 8, 0, 0),
+	GATE(pclk_i2c3, "pclk_i2c3", "aclk66_peric", GATE_IP_PERIC, 9, 0, 0),
+	GATE(pclk_usi0, "pclk_usi0", "aclk66_peric", GATE_IP_PERIC, 10, 0, 0),
+	GATE(pclk_usi1, "pclk_usi1", "aclk66_peric", GATE_IP_PERIC, 11, 0, 0),
+	GATE(pclk_usi2, "pclk_usi2", "aclk66_peric", GATE_IP_PERIC, 12, 0, 0),
+	GATE(pclk_usi3, "pclk_usi3", "aclk66_peric", GATE_IP_PERIC, 13, 0, 0),
+	GATE(pclk_usi4, "pclk_usi4", "aclk66_peric", GATE_IP_PERIC, 28, 0, 0),
+	GATE(pclk_usi5, "pclk_usi5", "aclk66_peric", GATE_IP_PERIC, 30, 0, 0),
+	GATE(pclk_usi6, "pclk_usi6", "aclk66_peric", GATE_IP_PERIC, 31, 0, 0),
+
+	GATE(pclk_i2c_hdmi, "pclk_i2c_hdmi", "aclk66_peric",
+			GATE_BUS_PERIC, 17, 0, 0),
+	GATE(pclk_tsadc, "pclk_tsadc", "aclk66_peric", GATE_IP_PERIC, 15, 0, 0),
 	/* SPI */
-	GATE(spi0, "spi0", "aclk66_peric", GATE_BUS_PERIC, 19, 0, 0),
-	GATE(spi1, "spi1", "aclk66_peric", GATE_BUS_PERIC, 20, 0, 0),
-	GATE(spi2, "spi2", "aclk66_peric", GATE_BUS_PERIC, 21, 0, 0),
-	GATE(keyif, "keyif", "aclk66_peric", GATE_BUS_PERIC, 22, 0, 0),
+	GATE(pclk_spi0, "pclk_spi0", "aclk66_peric", GATE_BUS_PERIC, 19, 0, 0),
+	GATE(pclk_spi1, "pclk_spi1", "aclk66_peric", GATE_BUS_PERIC, 20, 0, 0),
+	GATE(pclk_spi2, "pclk_spi2", "aclk66_peric", GATE_BUS_PERIC, 21, 0, 0),
 	/* I2S */
-	GATE(i2s1, "i2s1", "aclk66_peric", GATE_BUS_PERIC, 23, 0, 0),
-	GATE(i2s2, "i2s2", "aclk66_peric", GATE_BUS_PERIC, 24, 0, 0),
+	GATE(pclk_i2s1, "pclk_i2s1", "aclk66_peric", GATE_BUS_PERIC, 23, 0, 0),
+	GATE(pclk_i2s2, "pclk_i2s2", "aclk66_peric", GATE_BUS_PERIC, 24, 0, 0),
 	/* PCM */
-	GATE(pcm1, "pcm1", "aclk66_peric", GATE_BUS_PERIC, 25, 0, 0),
-	GATE(pcm2, "pcm2", "aclk66_peric", GATE_BUS_PERIC, 26, 0, 0),
+	GATE(pclk_pcm1, "pclk_pcm1", "aclk66_peric", GATE_BUS_PERIC, 25, 0, 0),
+	GATE(pclk_pcm2, "pclk_pcm2", "aclk66_peric", GATE_BUS_PERIC, 26, 0, 0),
 	/* PWM */
-	GATE(pwm, "pwm", "aclk66_peric", GATE_BUS_PERIC, 27, 0, 0),
+	GATE(pclk_pwm, "pwm", "aclk66_peric", GATE_BUS_PERIC, 27, 0, 0),
 	/* SPDIF */
-	GATE(spdif, "spdif", "aclk66_peric", GATE_BUS_PERIC, 29, 0, 0),
-
-	GATE(i2c8, "i2c8", "aclk66_peric", GATE_BUS_PERIC1, 0, 0, 0),
-	GATE(i2c9, "i2c9", "aclk66_peric", GATE_BUS_PERIC1, 1, 0, 0),
-	GATE(i2c10, "i2c10", "aclk66_peric", GATE_BUS_PERIC1, 2, 0, 0),
-
-	GATE(chipid, "chipid", "aclk66_psgen",
-			GATE_BUS_PERIS0, 12, CLK_IGNORE_UNUSED, 0),
-	GATE(sysreg, "sysreg", "aclk66_psgen",
-			GATE_BUS_PERIS0, 13, CLK_IGNORE_UNUSED, 0),
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
+	GATE(pclk_spdif, "pclk_spdif", "aclk66_peric",
+			GATE_BUS_PERIC, 29, 0, 0),
+
+	GATE(pclk_chipid, "pclk_chipid", "aclk66_psgen",
+			GATE_IP_PERIS, 0, CLK_IGNORE_UNUSED, 0),
+	GATE(pclk_sysreg, "pclk_sysreg", "aclk66_psgen",
+			GATE_IP_PERIS, 1, CLK_IGNORE_UNUSED, 0),
+	GATE(pclk_tzpc0, "pclk_tzpc0", "aclk66_psgen", GATE_IP_PERIS, 6, 0, 0),
+	GATE(pclk_tzpc1, "pclk_tzpc1", "aclk66_psgen", GATE_IP_PERIS, 7, 0, 0),
+	GATE(pclk_tzpc2, "pclk_tzpc2", "aclk66_psgen", GATE_IP_PERIS, 8, 0, 0),
+	GATE(pclk_tzpc3, "pclk_tzpc3", "aclk66_psgen", GATE_IP_PERIS, 9, 0, 0),
+	GATE(pclk_tzpc4, "pclk_tzpc4", "aclk66_psgen", GATE_IP_PERIS, 10, 0, 0),
+	GATE(pclk_tzpc5, "pclk_tzpc5", "aclk66_psgen", GATE_IP_PERIS, 11, 0, 0),
+	GATE(pclk_tzpc6, "pclk_tzpc6", "aclk66_psgen", GATE_IP_PERIS, 12, 0, 0),
+	GATE(pclk_tzpc7, "pclk_tzpc7", "aclk66_psgen", GATE_IP_PERIS, 13, 0, 0),
+	GATE(pclk_tzpc8, "pclk_tzpc8", "aclk66_psgen", GATE_IP_PERIS, 14, 0, 0),
+	GATE(pclk_tzpc9, "pclk_tzpc9", "aclk66_psgen", GATE_IP_PERIS, 15, 0, 0),
+	GATE(pclk_tzpc10, "pclk_tzpc10", "aclk66_psgen",
+			GATE_BUS_GEN, 30, 0, 0),
+	GATE(pclk_tzpc11, "pclk_tzpc11", "aclk66_psgen",
+			GATE_BUS_GEN, 31, 0, 0),
 
 	GATE(hdmi_cec, "hdmi_cec", "aclk66_psgen", GATE_BUS_PERIS1, 0, 0, 0),
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
+	GATE(pclk_wdt, "pclk_wdt", "aclk66_psgen", GATE_IP_PERIS, 19, 0, 0),
+	GATE(pclk_rtc, "pclk_rtc", "aclk66_psgen", GATE_IP_PERIS, 20, 0, 0),
+	GATE(pclk_tmu, "pclk_tmu", "aclk66_psgen", GATE_IP_PERIS, 21, 0, 0),
+	GATE(pclk_tmu_gpu, "pclk_tmu_gpu", "aclk66_psgen",
+			GATE_IP_PERIS, 22, 0, 0),
+
+	GATE(pclk_gscl0, "pclk_gscl0", "dout_gscl_blk_300", GATE_IP_GSCL0, 14,
+			CLK_IGNORE_UNUSED, 0),
+	GATE(pclk_gscl1, "pclk_gscl1", "dout_gscl_blk_300", GATE_IP_GSCL0, 15,
+			CLK_IGNORE_UNUSED, 0),
+	GATE(aclk_gscl0, "aclk_gscl0", "mout_user_aclk300_gscl",
+			GATE_IP_GSCL0, 0, 0, 0),
+	GATE(aclk_gscl1, "aclk_gscl1", "mout_user_aclk300_gscl",
+			GATE_IP_GSCL0, 1, 0, 0),
+	GATE(aclk_fimc_3aa, "aclk_fimc_3aa", "aclk333_432_gscl",
+			GATE_IP_GSCL0, 4, 0, 0),
+	GATE(pclk_fimc_3aa, "pclk_fimc_3aa", "dout_gscl_blk_333",
+			GATE_IP_GSCL0, 9, 0, 0),
+	GATE(smmu_3aa, "smmu_3aa", "dout_gscl_blk_333", GATE_IP_GSCL1, 2, 0, 0),
+	GATE(smmu_fimcl0, "smmu_fimcl0", "dout_gscl_blk_333",
 			GATE_IP_GSCL1, 3, 0, 0),
-	GATE(smmu_fimcl1, "smmu_fimcl1", "aclk333_432_gscl",
+	GATE(smmu_fimcl1, "smmu_fimcl1", "dout_gscl_blk_333",
 			GATE_IP_GSCL1, 4, 0, 0),
-	GATE(smmu_gscl0, "smmu_gscl0", "aclk300_gscl", GATE_IP_GSCL1, 6, 0, 0),
-	GATE(smmu_gscl1, "smmu_gscl1", "aclk300_gscl", GATE_IP_GSCL1, 7, 0, 0),
-	GATE(gscl_wa, "gscl_wa", "aclk300_gscl", GATE_IP_GSCL1, 12, 0, 0),
-	GATE(gscl_wb, "gscl_wb", "aclk300_gscl", GATE_IP_GSCL1, 13, 0, 0),
-	GATE(smmu_fimcl3, "smmu_fimcl3,", "aclk333_432_gscl",
+	GATE(smmu_gscl0, "smmu_gscl0", "dout_gscl_blk_300",
+			GATE_IP_GSCL1, 6, 0, 0),
+	GATE(smmu_gscl1, "smmu_gscl1", "dout_gscl_blk_300",
+			GATE_IP_GSCL1, 7, 0, 0),
+	GATE(pclk_gscl_wa, "pclk_gscl_wa", "dout_gscl_blk_333",
+			GATE_BUS_GSCL1, 28, 0, 0),
+	GATE(smmu_fimcl3, "smmu_fimcl3,", "dout_gscl_blk_333",
 			GATE_IP_GSCL1, 16, 0, 0),
-	GATE(fimc_lite3, "fimc_lite3", "aclk333_432_gscl",
+	GATE(aclk_fimc_lite3, "aclk_fimc_lite3", "aclk333_432_gscl",
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
+	GATE(aclk_fimd1, "aclk_fimd1", "mout_user_aclk300_disp1",
+			GATE_IP_DISP1, 0, 0, 0),
+	GATE(pclk_dsim1, "pclk_dsim1", "dout_disp1_blk",
+			GATE_BUS_DISP1, 17, 0, 0),
+	GATE(pclk_dp1, "pclk_dp1", "dout_disp1_blk", GATE_BUS_DISP1, 18, 0, 0),
+	GATE(aclk_mixer, "aclk_mixer", "aclk200_disp1",
+			GATE_IP_DISP1, 5, 0, 0),
+	GATE(pclk_hdmi, "pclk_hdmi", "dout_disp1_blk",
+			GATE_BUS_DISP1, 19, 0, 0),
+	GATE(smmu_fimd1m0, "smmu_fimd1m0", "dout_disp1_blk",
+			GATE_IP_DISP1, 7, 0, 0),
+	GATE(smmu_fimd1m1, "smmu_fimd1m1", "dout_disp1_blk",
+			GATE_IP_DISP1, 8, 0, 0),
+
+	GATE(aclk_mfc, "aclk_mfc", "mout_user_aclk333", GATE_BUS_MFC, 0, 0, 0),
+	GATE(pclk_mfc, "pclk_mfc", "dout_mfc_blk",
+			GATE_BUS_MFC, 16, CLK_IGNORE_UNUSED, 0),
+	GATE(smmu_mfcl, "smmu_mfcl", "dout_mfc_blk", GATE_IP_MFC, 1, 0, 0),
+	GATE(smmu_mfcr, "smmu_mfcr", "dout_mfc_blk", GATE_IP_MFC, 2, 0, 0),
+	GATE(clk_g3d, "clk_g3d", "mout_user_aclk_g3d", GATE_IP_G3D, 9, 0, 0),
+
+	GATE(aclk_rotator, "aclk_rotator", "mout_user_aclk266",
+			GATE_IP_GEN, 1, 0, 0),
+	GATE(pclk_rotator, "pclk_rotator", "dout_gen_blk",
+			GATE_BUS_GEN, 13, 0, 0),
+	GATE(aclk_jpeg, "aclk_jpeg", "aclk300_jpeg", GATE_IP_GEN, 2, 0, 0),
+	GATE(aclk_jpeg2, "aclk_jpeg2", "aclk300_jpeg", GATE_IP_GEN, 3, 0, 0),
+	GATE(aclk_mdma0, "aclk_mdma0", "aclk266_g2d",
+			GATE_BUS_G2D, 1, CLK_IGNORE_UNUSED, 0),
+	GATE(aclk_mdma1, "aclk_mdma1", "mout_user_aclk266",
+			GATE_IP_GEN, 4, 0, 0),
+
+	GATE(smmu_rotator, "smmu_rotator", "dout_gen_blk",
+			GATE_IP_GEN, 6, 0, 0),
+	GATE(aclk_smmu_mdma0, "aclk_smmu_mdma0", "aclk266_g2d",
+			GATE_BUS_G2D, 5, CLK_IGNORE_UNUSED, 0),
+	GATE(smmu_mdma0, "smmu_mdma0", "aclk266_g2d",
+			GATE_BUS_G2D, 20, CLK_IGNORE_UNUSED, 0),
+	GATE(smmu_jpeg, "smmu_jpeg", "dout_jpg_blk", GATE_IP_GEN, 7, 0, 0),
+	GATE(smmu_jpeg2, "smmu_jpeg2", "dout_jpg_blk", GATE_BUS_GEN, 28, 0, 0),
+	GATE(smmu_mdma1, "smmu_mdma1", "dout_gen_blk", GATE_IP_GEN, 9, 0, 0),
+
+	GATE(aclk_mscl0, "aclk_mscl0", "aclk400_mscl", GATE_BUS_MSCL, 0, 0, 0),
+	GATE(aclk_mscl1, "aclk_mscl1", "aclk400_mscl", GATE_BUS_MSCL, 1, 0, 0),
+	GATE(aclk_mscl2, "aclk_mscl2", "aclk400_mscl", GATE_BUS_MSCL, 2, 0, 0),
+	GATE(pclk_mscl0, "pclk_mscl0", "dout_mscl_blk", GATE_BUS_MSCL, 8, 0, 0),
+	GATE(pclk_mscl1, "pclk_mscl1", "dout_mscl_blk", GATE_BUS_MSCL, 9, 0, 0),
+	GATE(pclk_mscl2, "pclk_mscl2", "dout_mscl_blk",
+			GATE_BUS_MSCL, 10, 0, 0),
+	GATE(smmu_mscl0, "smmu_mscl0", "dout_mscl_blk", GATE_IP_MSCL, 8, 0, 0),
+	GATE(smmu_mscl1, "smmu_mscl1", "dout_mscl_blk", GATE_IP_MSCL, 9, 0, 0),
+	GATE(smmu_mscl2, "smmu_mscl2", "dout_mscl_blk", GATE_IP_MSCL, 10, 0, 0),
+	GATE(smmu_mixer, "smmu_mixer", "dout_disp1_blk",
+			GATE_IP_DISP1, 9, 0, 0),
+	GATE(aclk_smmu_mixer, "aclk_smmu_mixer", "aclk200_disp1",
+			GATE_BUS_DISP1, 9, CLK_IGNORE_UNUSED, 0),
+
+	/* aclk333 gates internal MFC busses and should not be gated. */
+	/* aclk266 also gates other IPs in psgen. It should not be gated. */
+	GATE(aclk266, "aclk266", "mout_user_aclk266",
+			GATE_BUS_NOC, 22, CLK_IGNORE_UNUSED, 0),
+	GATE(aclk200_disp1, "aclk200_disp1", "mout_aclk200_disp1",
+			GATE_BUS_TOP, 18, CLK_IGNORE_UNUSED, 0),
+	/* gating of aclk300_gscl causes system hang. It should not be gated. */
+	GATE(aclk400_mscl, "aclk400_mscl", "mout_user_aclk400_mscl",
+			GATE_BUS_TOP, 17, CLK_IGNORE_UNUSED, 0),
+	GATE(aclk300_disp1, "aclk300_disp1", "mout_user_aclk300_disp1",
+			SRC_MASK_TOP2, 24, CLK_IGNORE_UNUSED, 0),
+	GATE(aclk266_isp, "aclk266_isp", "mout_user_aclk266_isp",
+			GATE_BUS_TOP, 13, 0, 0),
+	GATE(aclk400_isp, "aclk400_isp", "mout_user_aclk400_isp",
+			GATE_BUS_TOP, 16, 0, 0),
+	GATE(aclk333_432_isp0, "aclk333_432_isp0", "mout_user_aclk333_432_isp0",
+			GATE_BUS_TOP, 5, 0, 0),
+	GATE(aclk333_432_isp, "aclk333_432_isp", "mout_user_aclk333_432_isp",
+			GATE_BUS_TOP, 8, 0, 0),
+	/* misc: mct, adc, chipid, wdt, rtc, sysreg etc */
+	GATE(pclk_mc, "pclk_mc", "aclk66_psgen", GATE_BUS_GEN, 12, 0, 0),
+	GATE(pclk_top_rtc, "pclk_top_rtc", "aclk66_psgen",
+			GATE_IP_GEN, 5, 0, 0),
+	GATE(sclk_hsic_12m, "sclk_hsic_12m", "ffactor_hsic_12m",
+			GATE_BUS_TOP, 29, 0, 0),
+	GATE(sclk_mphy_ixtal24, "sclk_mphy_ixtal24", "mphy_refclk_ixtal24",
+			GATE_BUS_TOP, 28, 0, 0),
+	/*
+	* HACK: When aclk_fimd1 is gated, aclk300_disp1 also gets gated as
+	* aclk_fimd1 is the only child node. aclk300_disp1 is connected
+	* to hdmi, mixer IPs through internal busses. gating of aclk300_disp1
+	* breaks HDMI S2R.
+	*/
+	GATE(pclk_hdmiphy, "pclk_hdmiphy", "dout_disp1_blk",
+			GATE_BUS_DISP1, 15, CLK_IGNORE_UNUSED, 0),
+	GATE(sclk_mphy_refclk, "sclk_mphy_refclk", "dout_mphy_refclk",
+			GATE_BUS_TOP, 30, 0, 0),
+	GATE(aclk_fimc_lite0, "aclk_fimc_lite0", "aclk333_432_gscl",
+			GATE_IP_GSCL0, 5, 0, 0),
+	GATE(aclk_fimc_lite1, "aclk_fimc_lite1", "aclk333_432_gscl",
+			GATE_IP_GSCL0, 6, 0, 0),
+	GATE(pclk_fimc_lite0, "pclk_fimc_lite0", "dout_gscl_blk_333",
+			GATE_IP_GSCL0, 10, 0, 0),
+	GATE(pclk_fimc_lite1, "pclk_fimc_lite1", "dout_gscl_blk_333",
+			GATE_IP_GSCL0, 11, 0, 0),
+	GATE(pclk_fimc_lite3, "pclk_fimc_lite3", "dout_gscl_blk_333",
+			GATE_BUS_GSCL0, 13, 0, 0),
+	/* g2d */
+	GATE(aclk_g2d, "aclk_g2d", "aclk333_g2d",
+			GATE_BUS_G2D, 3, CLK_IGNORE_UNUSED, 0),
+	GATE(pclk_g2d, "pclk_g2d", "aclk266_g2d",
+			GATE_BUS_G2D, 19, CLK_IGNORE_UNUSED, 0),
+	GATE(aclk_smmu_g2d, "aclk_smmu_g2d", "aclk333_g2d",
+			GATE_BUS_G2D, 7, CLK_IGNORE_UNUSED, 0),
+	GATE(smmu_g2d, "smmu_g2d", "aclk266_g2d",
+			GATE_BUS_G2D, 22, CLK_IGNORE_UNUSED, 0),
+	/* sss */
+	GATE(aclk_sss, "aclk_sss", "aclk266_g2d",
+			GATE_BUS_G2D, 2, CLK_IGNORE_UNUSED, 0),
+	GATE(aclk_smmu_sss, "aclk_smmu_sss", "aclk266_g2d",
+			GATE_BUS_G2D, 6, CLK_IGNORE_UNUSED, 0),
+	GATE(smmu_sss, "smmu_sss", "aclk266_g2d",
+			GATE_BUS_G2D, 21, CLK_IGNORE_UNUSED, 0),
+	/* slim_sss */
+	GATE(aclk_slim_sss, "aclk_slim_sss", "aclk266_g2d",
+			GATE_BUS_G2D, 12, CLK_IGNORE_UNUSED, 0),
+	GATE(aclk_smmu_slim_sss, "aclk_smmu_slim_sss", "aclk266_g2d",
+			GATE_BUS_G2D, 13, CLK_IGNORE_UNUSED, 0),
+	GATE(smmu_slim_sss, "smmu_slim_sss", "aclk266_g2d",
+			GATE_BUS_G2D, 28, CLK_IGNORE_UNUSED, 0),
+	/* ISP */
+	GATE(sclk_pwm_isp, "sclk_pwm_isp", "dout_pwm_isp",
+			GATE_TOP_SCLK_ISP, 3, 0, 0),
+	GATE(sclk_uart_isp, "sclk_uart_isp", "dout_uart_isp",
+			GATE_TOP_SCLK_ISP, 0, 0, 0),
+	GATE(sclk_spi0_isp, "sclk_spi0_isp", "dout_spi0_isp_pre",
+			GATE_TOP_SCLK_ISP, 1, 0, 0),
+	GATE(sclk_spi1_isp, "sclk_spi1_isp", "dout_spi1_isp_pre",
+			GATE_TOP_SCLK_ISP, 2, 0, 0),
+	GATE(sclk_isp_sensor0, "sclk_isp_sensor0", "dout_isp_sensor0",
+			GATE_TOP_SCLK_ISP, 4, 0, 0),
+	GATE(sclk_isp_sensor1, "sclk_isp_sensor1", "dout_isp_sensor1",
+			GATE_TOP_SCLK_ISP, 8, 0, 0),
+	GATE(sclk_isp_sensor2, "sclk_isp_sensor2", "dout_isp_sensor2",
+			GATE_TOP_SCLK_ISP, 12, 0, 0),
 };
 
 static struct samsung_pll_clock exynos5420_plls[nr_plls] __initdata = {
 	[apll] = PLL(pll_2550, fout_apll, "fout_apll", "fin_pll", APLL_LOCK,
 		APLL_CON0, NULL),
-	[cpll] = PLL(pll_2550, fout_mpll, "fout_mpll", "fin_pll", MPLL_LOCK,
-		MPLL_CON0, NULL),
+	[cpll] = PLL(pll_2550, fout_cpll, "fout_cpll", "fin_pll", CPLL_LOCK,
+		CPLL_CON0, NULL),
 	[dpll] = PLL(pll_2550, fout_dpll, "fout_dpll", "fin_pll", DPLL_LOCK,
 		DPLL_CON0, NULL),
 	[epll] = PLL(pll_2650, fout_epll, "fout_epll", "fin_pll", EPLL_LOCK,
-- 
1.7.10.4
