From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 15 Oct 2013 19:41:15 +0200
Subject: [PATCH 1/7] clk: samsung: exynos5250: Sort definitions by registers
 and bitfield
In-Reply-To: <1381858881-25611-1-git-send-email-t.figa@samsung.com>
References: <1381858881-25611-1-git-send-email-t.figa@samsung.com>
Message-ID: <1381858881-25611-2-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch reorders clock definitions, so they are sorted by register
addresses and bitfield shifts. When at it, blank lines are added to
separate definitions of clocks from different registers.

Overall this should make the driver more readable and reduce the number
of potential conflicts when adding new entries.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/clk/samsung/clk-exynos5250.c | 286 +++++++++++++++++++++++------------
 1 file changed, 186 insertions(+), 100 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5250.c b/drivers/clk/samsung/clk-exynos5250.c
index adf3234..32ee031 100644
--- a/drivers/clk/samsung/clk-exynos5250.c
+++ b/drivers/clk/samsung/clk-exynos5250.c
@@ -25,6 +25,7 @@
 #define MPLL_LOCK		0x4000
 #define MPLL_CON0		0x4100
 #define SRC_CORE1		0x4204
+#define GATE_IP_ACP		0x10000
 #define CPLL_LOCK		0x10020
 #define EPLL_LOCK		0x10030
 #define VPLL_LOCK		0x10040
@@ -65,6 +66,7 @@
 #define DIV_PERIC4		0x10568
 #define DIV_PERIC5		0x1056c
 #define GATE_IP_GSCL		0x10920
+#define GATE_IP_DISP1		0x10928
 #define GATE_IP_MFC		0x1092c
 #define GATE_IP_GEN		0x10934
 #define GATE_IP_FSYS		0x10944
@@ -74,8 +76,6 @@
 #define BPLL_CON0		0x20110
 #define SRC_CDREX		0x20200
 #define PLL_DIV2_SEL		0x20a24
-#define GATE_IP_DISP1		0x10928
-#define GATE_IP_ACP		0x10000
 
 /* list of PLLs to be registered */
 enum exynos5250_plls {
@@ -238,111 +238,248 @@ static struct samsung_mux_clock exynos5250_pll_pmux_clks[] __initdata = {
 };
 
 static struct samsung_mux_clock exynos5250_mux_clks[] __initdata = {
+	/*
+	 * NOTE: Following table is sorted by (clock domain, register address,
+	 * bitfield shift) triplet in ascending order. When adding new entries,
+	 * please make sure that the order is kept, to avoid merge conflicts
+	 * and make further work with defined data easier.
+	 */
+
+	/*
+	 * CMU_CPU
+	 */
 	MUX_A(none, "mout_apll", mout_apll_p, SRC_CPU, 0, 1, "mout_apll"),
 	MUX_A(none, "mout_cpu", mout_cpu_p, SRC_CPU, 16, 1, "mout_cpu"),
-	MUX(none, "mout_mpll_fout", mout_mpll_fout_p, PLL_DIV2_SEL, 4, 1),
+
+	/*
+	 * CMU_CORE
+	 */
 	MUX_A(none, "sclk_mpll", mout_mpll_p, SRC_CORE1, 8, 1, "mout_mpll"),
-	MUX(none, "mout_bpll_fout", mout_bpll_fout_p, PLL_DIV2_SEL, 0, 1),
-	MUX(none, "sclk_bpll", mout_bpll_p, SRC_CDREX, 0, 1),
-	MUX(none, "sclk_vpll", mout_vpll_p, SRC_TOP2, 16, 1),
-	MUX(none, "sclk_epll", mout_epll_p, SRC_TOP2, 12, 1),
+
+	/*
+	 * CMU_TOP
+	 */
+	MUX(none, "mout_aclk166", mout_aclk166_p, SRC_TOP0, 8, 1),
+	MUX(none, "mout_aclk200", mout_aclk200_p, SRC_TOP0, 12, 1),
+	MUX(none, "mout_aclk333", mout_aclk166_p, SRC_TOP0, 16, 1),
+
 	MUX(none, "sclk_cpll", mout_cpll_p, SRC_TOP2, 8, 1),
+	MUX(none, "sclk_epll", mout_epll_p, SRC_TOP2, 12, 1),
+	MUX(none, "sclk_vpll", mout_vpll_p, SRC_TOP2, 16, 1),
 	MUX(none, "sclk_mpll_user", mout_mpll_user_p, SRC_TOP2, 20, 1),
 	MUX(none, "sclk_bpll_user", mout_bpll_user_p, SRC_TOP2, 24, 1),
-	MUX(none, "mout_aclk166", mout_aclk166_p, SRC_TOP0, 8, 1),
-	MUX(none, "mout_aclk333", mout_aclk166_p, SRC_TOP0, 16, 1),
-	MUX(none, "mout_aclk200", mout_aclk200_p, SRC_TOP0, 12, 1),
+
 	MUX(none, "mout_cam_bayer", mout_group1_p, SRC_GSCL, 12, 4),
 	MUX(none, "mout_cam0", mout_group1_p, SRC_GSCL, 16, 4),
 	MUX(none, "mout_cam1", mout_group1_p, SRC_GSCL, 20, 4),
 	MUX(none, "mout_gscl_wa", mout_group1_p, SRC_GSCL, 24, 4),
 	MUX(none, "mout_gscl_wb", mout_group1_p, SRC_GSCL, 28, 4),
+
 	MUX(none, "mout_fimd1", mout_group1_p, SRC_DISP1_0, 0, 4),
 	MUX(none, "mout_mipi1", mout_group1_p, SRC_DISP1_0, 12, 4),
 	MUX(none, "mout_dp", mout_group1_p, SRC_DISP1_0, 16, 4),
 	MUX(mout_hdmi, "mout_hdmi", mout_hdmi_p, SRC_DISP1_0, 20, 1),
+
 	MUX(none, "mout_audio0", mout_audio0_p, SRC_MAU, 0, 4),
+
 	MUX(none, "mout_mmc0", mout_group1_p, SRC_FSYS, 0, 4),
 	MUX(none, "mout_mmc1", mout_group1_p, SRC_FSYS, 4, 4),
 	MUX(none, "mout_mmc2", mout_group1_p, SRC_FSYS, 8, 4),
 	MUX(none, "mout_mmc3", mout_group1_p, SRC_FSYS, 12, 4),
 	MUX(none, "mout_sata", mout_aclk200_p, SRC_FSYS, 24, 1),
 	MUX(none, "mout_usb3", mout_usb3_p, SRC_FSYS, 28, 1),
+
 	MUX(none, "mout_jpeg", mout_group1_p, SRC_GEN, 0, 4),
+
 	MUX(none, "mout_uart0", mout_group1_p, SRC_PERIC0, 0, 4),
 	MUX(none, "mout_uart1", mout_group1_p, SRC_PERIC0, 4, 4),
 	MUX(none, "mout_uart2", mout_group1_p, SRC_PERIC0, 8, 4),
 	MUX(none, "mout_uart3", mout_group1_p, SRC_PERIC0, 12, 4),
 	MUX(none, "mout_pwm", mout_group1_p, SRC_PERIC0, 24, 4),
+
 	MUX(none, "mout_audio1", mout_audio1_p, SRC_PERIC1, 0, 4),
 	MUX(none, "mout_audio2", mout_audio2_p, SRC_PERIC1, 4, 4),
 	MUX(none, "mout_spdif", mout_spdif_p, SRC_PERIC1, 8, 2),
 	MUX(none, "mout_spi0", mout_group1_p, SRC_PERIC1, 16, 4),
 	MUX(none, "mout_spi1", mout_group1_p, SRC_PERIC1, 20, 4),
 	MUX(none, "mout_spi2", mout_group1_p, SRC_PERIC1, 24, 4),
+
+	/*
+	 * CMU_CDREX
+	 */
+	MUX(none, "sclk_bpll", mout_bpll_p, SRC_CDREX, 0, 1),
+
+	MUX(none, "mout_mpll_fout", mout_mpll_fout_p, PLL_DIV2_SEL, 4, 1),
+	MUX(none, "mout_bpll_fout", mout_bpll_fout_p, PLL_DIV2_SEL, 0, 1),
 };
 
 static struct samsung_div_clock exynos5250_div_clks[] __initdata = {
+	/*
+	 * NOTE: Following table is sorted by (clock domain, register address,
+	 * bitfield shift) triplet in ascending order. When adding new entries,
+	 * please make sure that the order is kept, to avoid merge conflicts
+	 * and make further work with defined data easier.
+	 */
+
+	/*
+	 * CMU_CPU
+	 */
 	DIV(none, "div_arm", "mout_cpu", DIV_CPU0, 0, 3),
 	DIV(none, "sclk_apll", "mout_apll", DIV_CPU0, 24, 3),
-	DIV(none, "aclk66_pre", "sclk_mpll_user", DIV_TOP1, 24, 3),
+	DIV_A(none, "armclk", "div_arm", DIV_CPU0, 28, 3, "armclk"),
+
+	/*
+	 * CMU_TOP
+	 */
 	DIV(none, "aclk66", "aclk66_pre", DIV_TOP0, 0, 3),
-	DIV(none, "aclk266", "sclk_mpll_user", DIV_TOP0, 16, 3),
 	DIV(none, "aclk166", "mout_aclk166", DIV_TOP0, 8, 3),
-	DIV(none, "aclk333", "mout_aclk333", DIV_TOP0, 20, 3),
 	DIV(none, "aclk200", "mout_aclk200", DIV_TOP0, 12, 3),
+	DIV(none, "aclk266", "sclk_mpll_user", DIV_TOP0, 16, 3),
+	DIV(none, "aclk333", "mout_aclk333", DIV_TOP0, 20, 3),
+
+	DIV(none, "aclk66_pre", "sclk_mpll_user", DIV_TOP1, 24, 3),
+
 	DIV(none, "div_cam_bayer", "mout_cam_bayer", DIV_GSCL, 12, 4),
 	DIV(none, "div_cam0", "mout_cam0", DIV_GSCL, 16, 4),
 	DIV(none, "div_cam1", "mout_cam1", DIV_GSCL, 20, 4),
 	DIV(none, "div_gscl_wa", "mout_gscl_wa", DIV_GSCL, 24, 4),
 	DIV(none, "div_gscl_wb", "mout_gscl_wb", DIV_GSCL, 28, 4),
+
 	DIV(none, "div_fimd1", "mout_fimd1", DIV_DISP1_0, 0, 4),
 	DIV(none, "div_mipi1", "mout_mipi1", DIV_DISP1_0, 16, 4),
+	DIV_F(none, "div_mipi1_pre", "div_mipi1",
+			DIV_DISP1_0, 20, 4, CLK_SET_RATE_PARENT, 0),
 	DIV(none, "div_dp", "mout_dp", DIV_DISP1_0, 24, 4),
+	DIV(sclk_pixel, "div_hdmi_pixel", "sclk_vpll", DIV_DISP1_0, 28, 4),
+
 	DIV(none, "div_jpeg", "mout_jpeg", DIV_GEN, 4, 4),
+
 	DIV(none, "div_audio0", "mout_audio0", DIV_MAU, 0, 4),
 	DIV(none, "div_pcm0", "sclk_audio0", DIV_MAU, 4, 8),
+
 	DIV(none, "div_sata", "mout_sata", DIV_FSYS0, 20, 4),
 	DIV(none, "div_usb3", "mout_usb3", DIV_FSYS0, 24, 4),
+
 	DIV(none, "div_mmc0", "mout_mmc0", DIV_FSYS1, 0, 4),
+	DIV_F(none, "div_mmc_pre0", "div_mmc0",
+			DIV_FSYS1, 8, 8, CLK_SET_RATE_PARENT, 0),
 	DIV(none, "div_mmc1", "mout_mmc1", DIV_FSYS1, 16, 4),
+	DIV_F(none, "div_mmc_pre1", "div_mmc1",
+			DIV_FSYS1, 24, 8, CLK_SET_RATE_PARENT, 0),
+
 	DIV(none, "div_mmc2", "mout_mmc2", DIV_FSYS2, 0, 4),
+	DIV_F(none, "div_mmc_pre2", "div_mmc2",
+			DIV_FSYS2, 8, 8, CLK_SET_RATE_PARENT, 0),
 	DIV(none, "div_mmc3", "mout_mmc3", DIV_FSYS2, 16, 4),
+	DIV_F(none, "div_mmc_pre3", "div_mmc3",
+			DIV_FSYS2, 24, 8, CLK_SET_RATE_PARENT, 0),
+
 	DIV(none, "div_uart0", "mout_uart0", DIV_PERIC0, 0, 4),
 	DIV(none, "div_uart1", "mout_uart1", DIV_PERIC0, 4, 4),
 	DIV(none, "div_uart2", "mout_uart2", DIV_PERIC0, 8, 4),
 	DIV(none, "div_uart3", "mout_uart3", DIV_PERIC0, 12, 4),
+
 	DIV(none, "div_spi0", "mout_spi0", DIV_PERIC1, 0, 4),
+	DIV_F(none, "div_spi_pre0", "div_spi0",
+			DIV_PERIC1, 8, 8, CLK_SET_RATE_PARENT, 0),
 	DIV(none, "div_spi1", "mout_spi1", DIV_PERIC1, 16, 4),
+	DIV_F(none, "div_spi_pre1", "div_spi1",
+			DIV_PERIC1, 24, 8, CLK_SET_RATE_PARENT, 0),
+
 	DIV(none, "div_spi2", "mout_spi2", DIV_PERIC2, 0, 4),
+	DIV_F(none, "div_spi_pre2", "div_spi2",
+			DIV_PERIC2, 8, 8, CLK_SET_RATE_PARENT, 0),
+
 	DIV(none, "div_pwm", "mout_pwm", DIV_PERIC3, 0, 4),
+
 	DIV(none, "div_audio1", "mout_audio1", DIV_PERIC4, 0, 4),
 	DIV(none, "div_pcm1", "sclk_audio1", DIV_PERIC4, 4, 8),
 	DIV(none, "div_audio2", "mout_audio2", DIV_PERIC4, 16, 4),
 	DIV(none, "div_pcm2", "sclk_audio2", DIV_PERIC4, 20, 8),
+
 	DIV(div_i2s1, "div_i2s1", "sclk_audio1", DIV_PERIC5, 0, 6),
 	DIV(div_i2s2, "div_i2s2", "sclk_audio2", DIV_PERIC5, 8, 6),
-	DIV(sclk_pixel, "div_hdmi_pixel", "sclk_vpll", DIV_DISP1_0, 28, 4),
-	DIV_A(none, "armclk", "div_arm", DIV_CPU0, 28, 3, "armclk"),
-	DIV_F(none, "div_mipi1_pre", "div_mipi1",
-			DIV_DISP1_0, 20, 4, CLK_SET_RATE_PARENT, 0),
-	DIV_F(none, "div_mmc_pre0", "div_mmc0",
-			DIV_FSYS1, 8, 8, CLK_SET_RATE_PARENT, 0),
-	DIV_F(none, "div_mmc_pre1", "div_mmc1",
-			DIV_FSYS1, 24, 8, CLK_SET_RATE_PARENT, 0),
-	DIV_F(none, "div_mmc_pre2", "div_mmc2",
-			DIV_FSYS2, 8, 8, CLK_SET_RATE_PARENT, 0),
-	DIV_F(none, "div_mmc_pre3", "div_mmc3",
-			DIV_FSYS2, 24, 8, CLK_SET_RATE_PARENT, 0),
-	DIV_F(none, "div_spi_pre0", "div_spi0",
-			DIV_PERIC1, 8, 8, CLK_SET_RATE_PARENT, 0),
-	DIV_F(none, "div_spi_pre1", "div_spi1",
-			DIV_PERIC1, 24, 8, CLK_SET_RATE_PARENT, 0),
-	DIV_F(none, "div_spi_pre2", "div_spi2",
-			DIV_PERIC2, 8, 8, CLK_SET_RATE_PARENT, 0),
 };
 
 static struct samsung_gate_clock exynos5250_gate_clks[] __initdata = {
+	/*
+	 * NOTE: Following table is sorted by (clock domain, register address,
+	 * bitfield shift) triplet in ascending order. When adding new entries,
+	 * please make sure that the order is kept, to avoid merge conflicts
+	 * and make further work with defined data easier.
+	 */
+
+	/*
+	 * CMU_ACP
+	 */
+	GATE(g2d, "g2d", "aclk200", GATE_IP_ACP, 3, 0, 0),
+
+	/*
+	 * CMU_TOP
+	 */
+	GATE(sclk_cam_bayer, "sclk_cam_bayer", "div_cam_bayer",
+			SRC_MASK_GSCL, 12, CLK_SET_RATE_PARENT, 0),
+	GATE(sclk_cam0, "sclk_cam0", "div_cam0",
+			SRC_MASK_GSCL, 16, CLK_SET_RATE_PARENT, 0),
+	GATE(sclk_cam1, "sclk_cam1", "div_cam1",
+			SRC_MASK_GSCL, 20, CLK_SET_RATE_PARENT, 0),
+	GATE(sclk_gscl_wa, "sclk_gscl_wa", "div_gscl_wa",
+			SRC_MASK_GSCL, 24, CLK_SET_RATE_PARENT, 0),
+	GATE(sclk_gscl_wb, "sclk_gscl_wb", "div_gscl_wb",
+			SRC_MASK_GSCL, 28, CLK_SET_RATE_PARENT, 0),
+
+	GATE(sclk_fimd1, "sclk_fimd1", "div_fimd1",
+			SRC_MASK_DISP1_0, 0, CLK_SET_RATE_PARENT, 0),
+	GATE(sclk_mipi1, "sclk_mipi1", "div_mipi1",
+			SRC_MASK_DISP1_0, 12, CLK_SET_RATE_PARENT, 0),
+	GATE(sclk_dp, "sclk_dp", "div_dp",
+			SRC_MASK_DISP1_0, 16, CLK_SET_RATE_PARENT, 0),
+	GATE(sclk_hdmi, "sclk_hdmi", "mout_hdmi",
+			SRC_MASK_DISP1_0, 20, 0, 0),
+
+	GATE(sclk_audio0, "sclk_audio0", "div_audio0",
+			SRC_MASK_MAU, 0, CLK_SET_RATE_PARENT, 0),
+
+	GATE(sclk_mmc0, "sclk_mmc0", "div_mmc_pre0",
+			SRC_MASK_FSYS, 0, CLK_SET_RATE_PARENT, 0),
+	GATE(sclk_mmc1, "sclk_mmc1", "div_mmc_pre1",
+			SRC_MASK_FSYS, 4, CLK_SET_RATE_PARENT, 0),
+	GATE(sclk_mmc2, "sclk_mmc2", "div_mmc_pre2",
+			SRC_MASK_FSYS, 8, CLK_SET_RATE_PARENT, 0),
+	GATE(sclk_mmc3, "sclk_mmc3", "div_mmc_pre3",
+			SRC_MASK_FSYS, 12, CLK_SET_RATE_PARENT, 0),
+	GATE(sclk_sata, "sclk_sata", "div_sata",
+			SRC_MASK_FSYS, 24, CLK_SET_RATE_PARENT, 0),
+	GATE(sclk_usb3, "sclk_usb3", "div_usb3",
+			SRC_MASK_FSYS, 28, CLK_SET_RATE_PARENT, 0),
+
+	GATE(sclk_jpeg, "sclk_jpeg", "div_jpeg",
+			SRC_MASK_GEN, 0, CLK_SET_RATE_PARENT, 0),
+
+	GATE(sclk_uart0, "sclk_uart0", "div_uart0",
+			SRC_MASK_PERIC0, 0, CLK_SET_RATE_PARENT, 0),
+	GATE(sclk_uart1, "sclk_uart1", "div_uart1",
+			SRC_MASK_PERIC0, 4, CLK_SET_RATE_PARENT, 0),
+	GATE(sclk_uart2, "sclk_uart2", "div_uart2",
+			SRC_MASK_PERIC0, 8, CLK_SET_RATE_PARENT, 0),
+	GATE(sclk_uart3, "sclk_uart3", "div_uart3",
+			SRC_MASK_PERIC0, 12, CLK_SET_RATE_PARENT, 0),
+	GATE(sclk_pwm, "sclk_pwm", "div_pwm",
+			SRC_MASK_PERIC0, 24, CLK_SET_RATE_PARENT, 0),
+
+	GATE(sclk_audio1, "sclk_audio1", "div_audio1",
+			SRC_MASK_PERIC1, 0, CLK_SET_RATE_PARENT, 0),
+	GATE(sclk_audio2, "sclk_audio2", "div_audio2",
+			SRC_MASK_PERIC1, 4, CLK_SET_RATE_PARENT, 0),
+	GATE(sclk_spdif, "sclk_spdif", "mout_spdif",
+			SRC_MASK_PERIC1, 4, 0, 0),
+	GATE(sclk_spi0, "sclk_spi0", "div_spi_pre0",
+			SRC_MASK_PERIC1, 16, CLK_SET_RATE_PARENT, 0),
+	GATE(sclk_spi1, "sclk_spi1", "div_spi_pre1",
+			SRC_MASK_PERIC1, 20, CLK_SET_RATE_PARENT, 0),
+	GATE(sclk_spi2, "sclk_spi2", "div_spi_pre2",
+			SRC_MASK_PERIC1, 24, CLK_SET_RATE_PARENT, 0),
+
 	GATE(gscl0, "gscl0", "none", GATE_IP_GSCL, 0, 0, 0),
 	GATE(gscl1, "gscl1", "none", GATE_IP_GSCL, 1, 0, 0),
 	GATE(gscl2, "gscl2", "aclk266", GATE_IP_GSCL, 2, 0, 0),
@@ -353,15 +490,25 @@ static struct samsung_gate_clock exynos5250_gate_clks[] __initdata = {
 	GATE(smmu_gscl1, "smmu_gscl1", "aclk266", GATE_IP_GSCL, 8, 0, 0),
 	GATE(smmu_gscl2, "smmu_gscl2", "aclk266", GATE_IP_GSCL, 9, 0, 0),
 	GATE(smmu_gscl3, "smmu_gscl3", "aclk266", GATE_IP_GSCL, 10, 0, 0),
+
+	GATE(fimd1, "fimd1", "aclk200", GATE_IP_DISP1, 0, 0, 0),
+	GATE(mie1, "mie1", "aclk200", GATE_IP_DISP1, 1, 0, 0),
+	GATE(dsim0, "dsim0", "aclk200", GATE_IP_DISP1, 3, 0, 0),
+	GATE(dp, "dp", "aclk200", GATE_IP_DISP1, 4, 0, 0),
+	GATE(mixer, "mixer", "mout_aclk200_disp1", GATE_IP_DISP1, 5, 0, 0),
+	GATE(hdmi, "hdmi", "mout_aclk200_disp1", GATE_IP_DISP1, 6, 0, 0),
+
 	GATE(mfc, "mfc", "aclk333", GATE_IP_MFC, 0, 0, 0),
 	GATE(smmu_mfcl, "smmu_mfcl", "aclk333", GATE_IP_MFC, 1, 0, 0),
 	GATE(smmu_mfcr, "smmu_mfcr", "aclk333", GATE_IP_MFC, 2, 0, 0),
+
 	GATE(rotator, "rotator", "aclk266", GATE_IP_GEN, 1, 0, 0),
 	GATE(jpeg, "jpeg", "aclk166", GATE_IP_GEN, 2, 0, 0),
 	GATE(mdma1, "mdma1", "aclk266", GATE_IP_GEN, 4, 0, 0),
 	GATE(smmu_rotator, "smmu_rotator", "aclk266", GATE_IP_GEN, 6, 0, 0),
 	GATE(smmu_jpeg, "smmu_jpeg", "aclk166", GATE_IP_GEN, 7, 0, 0),
 	GATE(smmu_mdma1, "smmu_mdma1", "aclk266", GATE_IP_GEN, 9, 0, 0),
+
 	GATE(pdma0, "pdma0", "aclk200", GATE_IP_FSYS, 1, 0, 0),
 	GATE(pdma1, "pdma1", "aclk200", GATE_IP_FSYS, 2, 0, 0),
 	GATE(sata, "sata", "aclk200", GATE_IP_FSYS, 6, 0, 0),
@@ -376,6 +523,7 @@ static struct samsung_gate_clock exynos5250_gate_clks[] __initdata = {
 	GATE(usb3, "usb3", "aclk200", GATE_IP_FSYS, 19, 0, 0),
 	GATE(sata_phyctrl, "sata_phyctrl", "aclk200", GATE_IP_FSYS, 24, 0, 0),
 	GATE(sata_phyi2c, "sata_phyi2c", "aclk200", GATE_IP_FSYS, 25, 0, 0),
+
 	GATE(uart0, "uart0", "aclk66", GATE_IP_PERIC, 0, 0, 0),
 	GATE(uart1, "uart1", "aclk66", GATE_IP_PERIC, 1, 0, 0),
 	GATE(uart2, "uart2", "aclk66", GATE_IP_PERIC, 2, 0, 0),
@@ -405,9 +553,16 @@ static struct samsung_gate_clock exynos5250_gate_clks[] __initdata = {
 	GATE(hsi2c1, "hsi2c1", "aclk66", GATE_IP_PERIC, 29, 0, 0),
 	GATE(hsi2c2, "hsi2c2", "aclk66", GATE_IP_PERIC, 30, 0, 0),
 	GATE(hsi2c3, "hsi2c3", "aclk66", GATE_IP_PERIC, 31, 0, 0),
+
 	GATE(chipid, "chipid", "aclk66", GATE_IP_PERIS, 0, 0, 0),
 	GATE(sysreg, "sysreg", "aclk66", GATE_IP_PERIS, 1, 0, 0),
 	GATE(pmu, "pmu", "aclk66", GATE_IP_PERIS, 2, CLK_IGNORE_UNUSED, 0),
+	GATE(cmu_top, "cmu_top", "aclk66",
+			GATE_IP_PERIS, 3, CLK_IGNORE_UNUSED, 0),
+	GATE(cmu_core, "cmu_core", "aclk66",
+			GATE_IP_PERIS, 4, CLK_IGNORE_UNUSED, 0),
+	GATE(cmu_mem, "cmu_mem", "aclk66",
+			GATE_IP_PERIS, 5, CLK_IGNORE_UNUSED, 0),
 	GATE(tzpc0, "tzpc0", "aclk66", GATE_IP_PERIS, 6, 0, 0),
 	GATE(tzpc1, "tzpc1", "aclk66", GATE_IP_PERIS, 7, 0, 0),
 	GATE(tzpc2, "tzpc2", "aclk66", GATE_IP_PERIS, 8, 0, 0),
@@ -423,75 +578,6 @@ static struct samsung_gate_clock exynos5250_gate_clks[] __initdata = {
 	GATE(wdt, "wdt", "aclk66", GATE_IP_PERIS, 19, 0, 0),
 	GATE(rtc, "rtc", "aclk66", GATE_IP_PERIS, 20, 0, 0),
 	GATE(tmu, "tmu", "aclk66", GATE_IP_PERIS, 21, 0, 0),
-	GATE(cmu_top, "cmu_top", "aclk66",
-			GATE_IP_PERIS, 3, CLK_IGNORE_UNUSED, 0),
-	GATE(cmu_core, "cmu_core", "aclk66",
-			GATE_IP_PERIS, 4, CLK_IGNORE_UNUSED, 0),
-	GATE(cmu_mem, "cmu_mem", "aclk66",
-			GATE_IP_PERIS, 5, CLK_IGNORE_UNUSED, 0),
-	GATE(sclk_cam_bayer, "sclk_cam_bayer", "div_cam_bayer",
-			SRC_MASK_GSCL, 12, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_cam0, "sclk_cam0", "div_cam0",
-			SRC_MASK_GSCL, 16, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_cam1, "sclk_cam1", "div_cam1",
-			SRC_MASK_GSCL, 20, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_gscl_wa, "sclk_gscl_wa", "div_gscl_wa",
-			SRC_MASK_GSCL, 24, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_gscl_wb, "sclk_gscl_wb", "div_gscl_wb",
-			SRC_MASK_GSCL, 28, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_fimd1, "sclk_fimd1", "div_fimd1",
-			SRC_MASK_DISP1_0, 0, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_mipi1, "sclk_mipi1", "div_mipi1",
-			SRC_MASK_DISP1_0, 12, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_dp, "sclk_dp", "div_dp",
-			SRC_MASK_DISP1_0, 16, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_hdmi, "sclk_hdmi", "mout_hdmi",
-			SRC_MASK_DISP1_0, 20, 0, 0),
-	GATE(sclk_audio0, "sclk_audio0", "div_audio0",
-			SRC_MASK_MAU, 0, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_mmc0, "sclk_mmc0", "div_mmc_pre0",
-			SRC_MASK_FSYS, 0, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_mmc1, "sclk_mmc1", "div_mmc_pre1",
-			SRC_MASK_FSYS, 4, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_mmc2, "sclk_mmc2", "div_mmc_pre2",
-			SRC_MASK_FSYS, 8, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_mmc3, "sclk_mmc3", "div_mmc_pre3",
-			SRC_MASK_FSYS, 12, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_sata, "sclk_sata", "div_sata",
-			SRC_MASK_FSYS, 24, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_usb3, "sclk_usb3", "div_usb3",
-			SRC_MASK_FSYS, 28, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_jpeg, "sclk_jpeg", "div_jpeg",
-			SRC_MASK_GEN, 0, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_uart0, "sclk_uart0", "div_uart0",
-			SRC_MASK_PERIC0, 0, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_uart1, "sclk_uart1", "div_uart1",
-			SRC_MASK_PERIC0, 4, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_uart2, "sclk_uart2", "div_uart2",
-			SRC_MASK_PERIC0, 8, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_uart3, "sclk_uart3", "div_uart3",
-			SRC_MASK_PERIC0, 12, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_pwm, "sclk_pwm", "div_pwm",
-			SRC_MASK_PERIC0, 24, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_audio1, "sclk_audio1", "div_audio1",
-			SRC_MASK_PERIC1, 0, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_audio2, "sclk_audio2", "div_audio2",
-			SRC_MASK_PERIC1, 4, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_spdif, "sclk_spdif", "mout_spdif",
-			SRC_MASK_PERIC1, 4, 0, 0),
-	GATE(sclk_spi0, "sclk_spi0", "div_spi_pre0",
-			SRC_MASK_PERIC1, 16, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_spi1, "sclk_spi1", "div_spi_pre1",
-			SRC_MASK_PERIC1, 20, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_spi2, "sclk_spi2", "div_spi_pre2",
-			SRC_MASK_PERIC1, 24, CLK_SET_RATE_PARENT, 0),
-	GATE(fimd1, "fimd1", "aclk200", GATE_IP_DISP1, 0, 0, 0),
-	GATE(mie1, "mie1", "aclk200", GATE_IP_DISP1, 1, 0, 0),
-	GATE(dsim0, "dsim0", "aclk200", GATE_IP_DISP1, 3, 0, 0),
-	GATE(dp, "dp", "aclk200", GATE_IP_DISP1, 4, 0, 0),
-	GATE(mixer, "mixer", "mout_aclk200_disp1", GATE_IP_DISP1, 5, 0, 0),
-	GATE(hdmi, "hdmi", "mout_aclk200_disp1", GATE_IP_DISP1, 6, 0, 0),
-	GATE(g2d, "g2d", "aclk200", GATE_IP_ACP, 3, 0, 0),
 };
 
 static struct samsung_pll_rate_table vpll_24mhz_tbl[] __initdata = {
-- 
1.8.3.2
