From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 27 Mar 2013 12:02:49 +0100
Subject: [PATCH 12/21] clk: samsung: exynos4: Add missing CMU_TOP and ISP
 clocks
In-Reply-To: <1364382178-25248-1-git-send-email-t.figa@samsung.com>
References: <1364382178-25248-1-git-send-email-t.figa@samsung.com>
Message-ID: <1364382178-25248-13-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrzej Hajda <a.hajda@samsung.com>

The patch adds missing clocks to TOP and ISP clock domains.
It also adds clock gates for ISP sub-blocks.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 .../devicetree/bindings/clock/exynos4-clock.txt    |  30 ++++++
 drivers/clk/samsung/clk-exynos4.c                  | 110 ++++++++++++++++++++-
 2 files changed, 137 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/exynos4-clock.txt b/Documentation/devicetree/bindings/clock/exynos4-clock.txt
index 1863032..662007e 100644
--- a/Documentation/devicetree/bindings/clock/exynos4-clock.txt
+++ b/Documentation/devicetree/bindings/clock/exynos4-clock.txt
@@ -98,6 +98,10 @@ Exynos4 SoC and this is specified where applicable.
   sclk_mfc            170
   sclk_pcm0           171
   sclk_g3d            172
+  sclk_pwm_isp        173     Exynos4x12
+  sclk_spi0_isp       174     Exynos4x12
+  sclk_spi1_isp       175     Exynos4x12
+  sclk_uart_isp       176     Exynos4x12
 
 	      [Peripheral Clock Gates]
 
@@ -205,6 +209,32 @@ Exynos4 SoC and this is specified where applicable.
   fimc_lite1          354     Exynos4x12
   ppmuispx            355     Exynos4x12
   ppmuispmx           356     Exynos4x12
+  fimc_isp            357     Exynos4x12
+  fimc_drc            358     Exynos4x12
+  fimc_fd             359     Exynos4x12
+  mcuisp              360     Exynos4x12
+  gicisp              361     Exynos4x12
+  smmu_isp            362     Exynos4x12
+  smmu_drc            363     Exynos4x12
+  smmu_fd             364     Exynos4x12
+  smmu_lite0          365     Exynos4x12
+  smmu_lite1          366     Exynos4x12
+  mcuctl_isp          367     Exynos4x12
+  mpwm_isp            368     Exynos4x12
+  i2c0_isp            369     Exynos4x12
+  i2c1_isp            370     Exynos4x12
+  mtcadc_isp          371     Exynos4x12
+  pwm_isp             372     Exynos4x12
+  wdt_isp             373     Exynos4x12
+  uart_isp            374     Exynos4x12
+  asyncaxim           375     Exynos4x12
+  smmu_ispcx          376     Exynos4x12
+  spi0_isp            377     Exynos4x12
+  spi1_isp            378     Exynos4x12
+  pwm_isp_sclk        379     Exynos4x12
+  spi0_isp_sclk       380     Exynos4x12
+  spi1_isp_sclk       381     Exynos4x12
+  uart_isp_sclk       382     Exynos4x12
 
 			[Mux Clocks]
 
diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-exynos4.c
index 694b890..0586421 100644
--- a/drivers/clk/samsung/clk-exynos4.c
+++ b/drivers/clk/samsung/clk-exynos4.c
@@ -34,6 +34,7 @@
 #define E4210_SRC_IMAGE		0xc230
 #define SRC_LCD0		0xc234
 #define SRC_LCD1		0xc238
+#define E4X12_SRC_ISP		0xc238
 #define SRC_MAUDIO		0xc23c
 #define SRC_FSYS		0xc240
 #define SRC_PERIL0		0xc250
@@ -43,6 +44,7 @@
 #define SRC_MASK_TV		0xc324
 #define SRC_MASK_LCD0		0xc334
 #define SRC_MASK_LCD1		0xc338
+#define E4X12_SRC_MASK_ISP	0xc338
 #define SRC_MASK_MAUDIO		0xc33c
 #define SRC_MASK_FSYS		0xc340
 #define SRC_MASK_PERIL0		0xc350
@@ -76,6 +78,7 @@
 #define E4210_GATE_IP_IMAGE	0xc930
 #define GATE_IP_LCD0		0xc934
 #define GATE_IP_LCD1		0xc938
+#define E4X12_GATE_IP_ISP	0xc938
 #define E4X12_GATE_IP_MAUDIO	0xc93c
 #define GATE_IP_FSYS		0xc940
 #define GATE_IP_GPS		0xc94c
@@ -87,7 +90,10 @@
 #define E4210_MPLL_CON0		0x14108
 #define SRC_CPU			0x14200
 #define DIV_CPU0		0x14500
+#define E4X12_DIV_ISP0		0x18300
+#define E4X12_DIV_ISP1		0x18304
 #define E4X12_GATE_ISP0		0x18800
+#define E4X12_GATE_ISP1		0x18804
 
 /* the exynos4 soc type */
 enum exynos4_soc {
@@ -124,7 +130,8 @@ enum exynos4_clks {
 	sclk_sata, sclk_uart0, sclk_uart1, sclk_uart2, sclk_uart3, sclk_uart4,
 	sclk_audio1, sclk_audio2, sclk_spdif, sclk_spi0, sclk_spi1, sclk_spi2,
 	sclk_slimbus, sclk_fimd1, sclk_mipi1, sclk_pcm1, sclk_pcm2, sclk_i2s1,
-	sclk_i2s2, sclk_mipihsi, sclk_mfc, sclk_pcm0, sclk_g3d,
+	sclk_i2s2, sclk_mipihsi, sclk_mfc, sclk_pcm0, sclk_g3d, sclk_pwm_isp,
+	sclk_spi0_isp, sclk_spi1_isp, sclk_uart_isp,
 
 	/* gate clocks */
 	fimc0 = 256, fimc1, fimc2, fimc3, csis0, csis1, jpeg, smmu_fimc0,
@@ -138,7 +145,11 @@ enum exynos4_clks {
 	spi0, spi1, spi2, i2s1, i2s2, pcm0, i2s0, pcm1, pcm2, pwm, slimbus,
 	spdif, ac97, modemif, chipid, sysreg, hdmi_cec, mct, wdt, rtc, keyif,
 	audss, mipi_hsi, mdma2, pixelasyncm0, pixelasyncm1, fimc_lite0,
-	fimc_lite1, ppmuispx, ppmuispmx,
+	fimc_lite1, ppmuispx, ppmuispmx, fimc_isp, fimc_drc, fimc_fd, mcuisp,
+	gicisp, smmu_isp, smmu_drc, smmu_fd, smmu_lite0, smmu_lite1, mcuctl_isp,
+	mpwm_isp, i2c0_isp, i2c1_isp, mtcadc_isp, pwm_isp, wdt_isp, uart_isp,
+	asyncaxim, smmu_ispcx, spi0_isp, spi1_isp, pwm_isp_sclk, spi0_isp_sclk,
+	spi1_isp_sclk, uart_isp_sclk,
 
 	/* mux clocks */
 	mout_fimc0 = 384, mout_fimc1, mout_fimc2, mout_fimc3, mout_cam0,
@@ -234,6 +245,8 @@ PNAME(mout_hdmi_p)	= { "sclk_pixel", "sclk_hdmiphy", };
 PNAME(mout_jpeg_p)	= { "mout_jpeg0", "mout_jpeg1", };
 PNAME(mout_spdif_p)	= { "sclk_audio0", "sclk_audio1", "sclk_audio2",
 				"spdif_extclk", };
+PNAME(mout_onenand_p)  = {"aclk133", "aclk160", };
+PNAME(mout_onenand1_p) = {"mout_onenand", "sclk_vpll", };
 
 /* Exynos 4210-specific parent groups */
 PNAME(sclk_vpll_p4210)	= { "mout_vpllsrc", "fout_vpll", };
@@ -271,6 +284,9 @@ PNAME(mout_audio2_p4x12) = { "cdclk2", "none", "sclk_hdmi24m",
 				"sclk_usbphy0", "xxti", "xusbxti",
 				"mout_mpll_user_t", "sclk_epll", "sclk_vpll", };
 PNAME(aclk_p4412)	= { "mout_mpll_user_t", "sclk_apll", };
+PNAME(mout_user_aclk400_mcuisp_p4x12) = {"fin_pll", "div_aclk400_mcuisp", };
+PNAME(mout_user_aclk200_p4x12) = {"fin_pll", "div_aclk200", };
+PNAME(mout_user_aclk266_gps_p4x12) = {"fin_pll", "div_aclk266_gps", };
 
 /* fixed rate clocks generated outside the soc */
 struct samsung_fixed_rate_clock exynos4_fixed_rate_ext_clks[] __initdata = {
@@ -301,7 +317,9 @@ struct samsung_mux_clock exynos4_mux_clks[] __initdata = {
 	MUX_F(mout_g3d, "mout_g3d", mout_g3d_p, SRC_G3D, 8, 1,
 			CLK_SET_RATE_PARENT, 0),
 	MUX(none, "mout_spdif", mout_spdif_p, SRC_PERIL1, 8, 2),
+	MUX(none, "mout_onenand1", mout_onenand1_p, SRC_TOP0, 0, 1),
 	MUX_A(sclk_epll, "sclk_epll", mout_epll_p, SRC_TOP0, 4, 1, "sclk_epll"),
+	MUX(none, "mout_onenand", mout_onenand_p, SRC_TOP0, 28, 1),
 };
 
 /* list of mux clocks supported in exynos4210 soc */
@@ -357,8 +375,15 @@ struct samsung_mux_clock exynos4210_mux_clks[] __initdata = {
 struct samsung_mux_clock exynos4x12_mux_clks[] __initdata = {
 	MUX(mout_mpll_user_c, "mout_mpll_user_c", mout_mpll_user_p4x12,
 			SRC_CPU, 24, 1),
+	MUX(none, "mout_aclk266_gps", aclk_p4412, SRC_TOP1, 4, 1),
+	MUX(none, "mout_aclk400_mcuisp", aclk_p4412, SRC_TOP1, 8, 1),
 	MUX(mout_mpll_user_t, "mout_mpll_user_t", mout_mpll_user_p4x12,
 			SRC_TOP1, 12, 1),
+	MUX(none, "mout_user_aclk266_gps", mout_user_aclk266_gps_p4x12,
+			SRC_TOP1, 16, 1),
+	MUX(aclk200, "aclk200", mout_user_aclk200_p4x12, SRC_TOP1, 20, 1),
+	MUX(none, "aclk400_mcuisp", mout_user_aclk400_mcuisp_p4x12,
+			SRC_TOP1, 24, 1),
 	MUX(none, "mout_aclk200", aclk_p4412, SRC_TOP0, 12, 1),
 	MUX(none, "mout_aclk100", aclk_p4412, SRC_TOP0, 16, 1),
 	MUX(none, "mout_aclk160", aclk_p4412, SRC_TOP0, 20, 1),
@@ -404,6 +429,10 @@ struct samsung_mux_clock exynos4x12_mux_clks[] __initdata = {
 	MUX(none, "mout_spi0", group1_p4x12, SRC_PERIL1, 16, 4),
 	MUX(none, "mout_spi1", group1_p4x12, SRC_PERIL1, 20, 4),
 	MUX(none, "mout_spi2", group1_p4x12, SRC_PERIL1, 24, 4),
+	MUX(none, "mout_pwm_isp", group1_p4x12, E4X12_SRC_ISP, 0, 4),
+	MUX(none, "mout_spi0_isp", group1_p4x12, E4X12_SRC_ISP, 4, 4),
+	MUX(none, "mout_spi1_isp", group1_p4x12, E4X12_SRC_ISP, 8, 4),
+	MUX(none, "mout_uart_isp", group1_p4x12, E4X12_SRC_ISP, 12, 4),
 };
 
 /* list of divider clocks supported in all exynos4 soc's */
@@ -430,10 +459,10 @@ struct samsung_div_clock exynos4_div_clks[] __initdata = {
 	DIV(none, "div_mmc2", "mout_mmc2", DIV_FSYS2, 0, 4),
 	DIV(none, "div_mmc3", "mout_mmc3", DIV_FSYS2, 16, 4),
 	DIV(sclk_pixel, "sclk_pixel", "sclk_vpll", DIV_TV, 0, 4),
-	DIV(aclk200, "aclk200", "mout_aclk200", DIV_TOP, 0, 3),
 	DIV(aclk100, "aclk100", "mout_aclk100", DIV_TOP, 4, 4),
 	DIV(aclk160, "aclk160", "mout_aclk160", DIV_TOP, 8, 3),
 	DIV(aclk133, "aclk133", "mout_aclk133", DIV_TOP, 12, 3),
+	DIV(none, "div_onenand", "mout_onenand1", DIV_TOP, 16, 3),
 	DIV(sclk_slimbus, "sclk_slimbus", "sclk_epll", DIV_PERIL3, 4, 4),
 	DIV(sclk_pcm1, "sclk_pcm1", "sclk_audio1", DIV_PERIL4, 4, 8),
 	DIV(sclk_pcm2, "sclk_pcm2", "sclk_audio2", DIV_PERIL4, 20, 8),
@@ -471,6 +500,7 @@ struct samsung_div_clock exynos4_div_clks[] __initdata = {
 
 /* list of divider clocks supported in exynos4210 soc */
 struct samsung_div_clock exynos4210_div_clks[] __initdata = {
+	DIV(aclk200, "aclk200", "mout_aclk200", DIV_TOP, 0, 3),
 	DIV(none, "div_g2d", "mout_g2d", DIV_IMAGE, 0, 4),
 	DIV(none, "div_fimd1", "mout_fimd1", E4210_DIV_LCD1, 0, 4),
 	DIV(none, "div_mipi1", "mout_mipi1", E4210_DIV_LCD1, 16, 4),
@@ -486,6 +516,20 @@ struct samsung_div_clock exynos4x12_div_clks[] __initdata = {
 	DIV(none, "div_mdnie_pwm_pre0", "div_mdnie_pwm0", DIV_LCD0, 12, 4),
 	DIV(none, "div_mipihsi", "mout_mipihsi", DIV_FSYS0, 20, 4),
 	DIV(none, "div_jpeg", "mout_jpeg", E4X12_DIV_CAM1, 0, 4),
+	DIV(none, "div_aclk200", "mout_aclk200", DIV_TOP, 0, 3),
+	DIV(none, "div_aclk266_gps", "mout_aclk266_gps", DIV_TOP, 20, 3),
+	DIV(none, "div_aclk400_mcuisp", "mout_aclk400_mcuisp", DIV_TOP, 24, 3),
+	DIV(none, "div_pwm_isp", "mout_pwm_isp", E4X12_DIV_ISP, 0, 4),
+	DIV(none, "div_spi0_isp", "mout_spi0_isp", E4X12_DIV_ISP, 4, 4),
+	DIV(none, "div_spi0_isp_pre", "div_spi0_isp", E4X12_DIV_ISP, 8, 8),
+	DIV(none, "div_spi1_isp", "mout_spi1_isp", E4X12_DIV_ISP, 16, 4),
+	DIV(none, "div_spi1_isp_pre", "div_spi1_isp", E4X12_DIV_ISP, 20, 8),
+	DIV(none, "div_uart_isp", "mout_uart_isp", E4X12_DIV_ISP, 28, 4),
+	DIV(none, "div_isp0", "aclk200", E4X12_DIV_ISP0, 0, 3),
+	DIV(none, "div_isp1", "aclk200", E4X12_DIV_ISP0, 4, 3),
+	DIV(none, "div_mpwm", "div_isp1", E4X12_DIV_ISP1, 0, 3),
+	DIV(none, "div_mcuisp0", "aclk400_mcuisp", E4X12_DIV_ISP1, 4, 3),
+	DIV(none, "div_mcuisp1", "div_mcuisp0", E4X12_DIV_ISP1, 8, 3),
 };
 
 /* list of gate clocks supported in all exynos4 soc's */
@@ -729,20 +773,80 @@ struct samsung_gate_clock exynos4x12_gate_clks[] __initdata = {
 	GATE_A(rtc, "rtc", "aclk100", E4X12_GATE_IP_PERIR, 15, 0, 0, "rtc"),
 	GATE_A(keyif, "keyif", "aclk100",
 			E4X12_GATE_IP_PERIR, 16, 0, 0, "keypad"),
+	GATE(sclk_pwm_isp, "sclk_pwm_isp", "div_pwm_isp",
+			E4X12_SRC_MASK_ISP, 0, CLK_SET_RATE_PARENT, 0),
+	GATE(sclk_spi0_isp, "sclk_spi0_isp", "div_spi0_isp_pre",
+			E4X12_SRC_MASK_ISP, 4, CLK_SET_RATE_PARENT, 0),
+	GATE(sclk_spi1_isp, "sclk_spi1_isp", "div_spi1_isp_pre",
+			E4X12_SRC_MASK_ISP, 8, CLK_SET_RATE_PARENT, 0),
+	GATE(sclk_uart_isp, "sclk_uart_isp", "div_uart_isp",
+			E4X12_SRC_MASK_ISP, 12, CLK_SET_RATE_PARENT, 0),
+	GATE(pwm_isp_sclk, "pwm_isp_sclk", "sclk_pwm_isp",
+			E4X12_GATE_IP_ISP, 0, 0, 0),
+	GATE(spi0_isp_sclk, "spi0_isp_sclk", "sclk_spi0_isp",
+			E4X12_GATE_IP_ISP, 1, 0, 0),
+	GATE(spi1_isp_sclk, "spi1_isp_sclk", "sclk_spi1_isp",
+			E4X12_GATE_IP_ISP, 2, 0, 0),
+	GATE(uart_isp_sclk, "uart_isp_sclk", "sclk_uart_isp",
+			E4X12_GATE_IP_ISP, 3, 0, 0),
 	GATE_A(wdt, "watchdog", "aclk100",
 			E4X12_GATE_IP_PERIR, 14, 0, 0, "watchdog"),
 	GATE_DA(pcm0, "samsung-pcm.0", "pcm0", "aclk100",
 			E4X12_GATE_IP_MAUDIO, 2, 0, 0, "pcm"),
 	GATE_DA(i2s0, "samsung-i2s.0", "i2s0", "aclk100",
 			E4X12_GATE_IP_MAUDIO, 3, 0, 0, "iis"),
+	GATE(fimc_isp, "isp", "aclk200", E4X12_GATE_ISP0, 0,
+			CLK_IGNORE_UNUSED, 0),
+	GATE(fimc_drc, "drc", "aclk200", E4X12_GATE_ISP0, 1,
+			CLK_IGNORE_UNUSED, 0),
+	GATE(fimc_fd, "fd", "aclk200", E4X12_GATE_ISP0, 2,
+			CLK_IGNORE_UNUSED, 0),
 	GATE(fimc_lite0, "lite0", "aclk200", E4X12_GATE_ISP0, 3,
 			CLK_IGNORE_UNUSED, 0),
 	GATE(fimc_lite1, "lite1", "aclk200", E4X12_GATE_ISP0, 4,
 			CLK_IGNORE_UNUSED, 0),
+	GATE(mcuisp, "mcuisp", "aclk200", E4X12_GATE_ISP0, 5,
+			CLK_IGNORE_UNUSED, 0),
+	GATE(gicisp, "gicisp", "aclk200", E4X12_GATE_ISP0, 7,
+			CLK_IGNORE_UNUSED, 0),
+	GATE(smmu_isp, "smmu_isp", "aclk200", E4X12_GATE_ISP0, 8,
+			CLK_IGNORE_UNUSED, 0),
+	GATE(smmu_drc, "smmu_drc", "aclk200", E4X12_GATE_ISP0, 9,
+			CLK_IGNORE_UNUSED, 0),
+	GATE(smmu_fd, "smmu_fd", "aclk200", E4X12_GATE_ISP0, 10,
+			CLK_IGNORE_UNUSED, 0),
+	GATE(smmu_lite0, "smmu_lite0", "aclk200", E4X12_GATE_ISP0, 11,
+			CLK_IGNORE_UNUSED, 0),
+	GATE(smmu_lite1, "smmu_lite1", "aclk200", E4X12_GATE_ISP0, 12,
+			CLK_IGNORE_UNUSED, 0),
 	GATE(ppmuispmx, "ppmuispmx", "aclk200", E4X12_GATE_ISP0, 20,
 			CLK_IGNORE_UNUSED, 0),
 	GATE(ppmuispx, "ppmuispx", "aclk200", E4X12_GATE_ISP0, 21,
 			CLK_IGNORE_UNUSED, 0),
+	GATE(mcuctl_isp, "mcuctl_isp", "aclk200", E4X12_GATE_ISP0, 23,
+			CLK_IGNORE_UNUSED, 0),
+	GATE(mpwm_isp, "mpwm_isp", "aclk200", E4X12_GATE_ISP0, 24,
+			CLK_IGNORE_UNUSED, 0),
+	GATE(i2c0_isp, "i2c0_isp", "aclk200", E4X12_GATE_ISP0, 25,
+			CLK_IGNORE_UNUSED, 0),
+	GATE(i2c1_isp, "i2c1_isp", "aclk200", E4X12_GATE_ISP0, 26,
+			CLK_IGNORE_UNUSED, 0),
+	GATE(mtcadc_isp, "mtcadc_isp", "aclk200", E4X12_GATE_ISP0, 27,
+			CLK_IGNORE_UNUSED, 0),
+	GATE(pwm_isp, "pwm_isp", "aclk200", E4X12_GATE_ISP0, 28,
+			CLK_IGNORE_UNUSED, 0),
+	GATE(wdt_isp, "wdt_isp", "aclk200", E4X12_GATE_ISP0, 30,
+			CLK_IGNORE_UNUSED, 0),
+	GATE(uart_isp, "uart_isp", "aclk200", E4X12_GATE_ISP0, 31,
+			CLK_IGNORE_UNUSED, 0),
+	GATE(asyncaxim, "asyncaxim", "aclk200", E4X12_GATE_ISP1, 0,
+			CLK_IGNORE_UNUSED, 0),
+	GATE(smmu_ispcx, "smmu_ispcx", "aclk200", E4X12_GATE_ISP1, 4,
+			CLK_IGNORE_UNUSED, 0),
+	GATE(spi0_isp, "spi0_isp", "aclk200", E4X12_GATE_ISP1, 12,
+			CLK_IGNORE_UNUSED, 0),
+	GATE(spi1_isp, "spi1_isp", "aclk200", E4X12_GATE_ISP1, 13,
+			CLK_IGNORE_UNUSED, 0),
 };
 
 #ifdef CONFIG_OF
-- 
1.8.1.5
