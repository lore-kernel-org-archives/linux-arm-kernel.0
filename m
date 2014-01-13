From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 13 Jan 2014 16:06:30 +1100
Subject: linux-next: manual merge of the clk tree with the arm-soc tree
Message-ID: <20140113160630.cf720268510f5e0931c24284@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

Today's linux-next merge of the clk tree got a conflict in
drivers/clk/samsung/clk-exynos4.c between commit 86576fbe201b ("clk:
samsung: exynos4: Fix definition of div_mmc_pre4 divider") from the
arm-soc tree and commit 2d7382375054 ("clk: exynos4: replace clock ID
private enums with IDs from DT header") from the clk tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc drivers/clk/samsung/clk-exynos4.c
index 3852e44db0f8,2f7e440aebf8..000000000000
--- a/drivers/clk/samsung/clk-exynos4.c
+++ b/drivers/clk/samsung/clk-exynos4.c
@@@ -498,64 -437,63 +437,64 @@@ static struct samsung_mux_clock exynos4
  
  /* list of divider clocks supported in all exynos4 soc's */
  static struct samsung_div_clock exynos4_div_clks[] __initdata = {
- 	DIV(none, "div_core", "mout_core", DIV_CPU0, 0, 3),
- 	DIV(none, "div_core2", "div_core", DIV_CPU0, 28, 3),
- 	DIV(none, "div_fimc0", "mout_fimc0", DIV_CAM, 0, 4),
- 	DIV(none, "div_fimc1", "mout_fimc1", DIV_CAM, 4, 4),
- 	DIV(none, "div_fimc2", "mout_fimc2", DIV_CAM, 8, 4),
- 	DIV(none, "div_fimc3", "mout_fimc3", DIV_CAM, 12, 4),
- 	DIV(none, "div_cam0", "mout_cam0", DIV_CAM, 16, 4),
- 	DIV(none, "div_cam1", "mout_cam1", DIV_CAM, 20, 4),
- 	DIV(none, "div_csis0", "mout_csis0", DIV_CAM, 24, 4),
- 	DIV(none, "div_csis1", "mout_csis1", DIV_CAM, 28, 4),
- 	DIV(sclk_mfc, "sclk_mfc", "mout_mfc", DIV_MFC, 0, 4),
- 	DIV_F(none, "div_g3d", "mout_g3d", DIV_G3D, 0, 4,
+ 	DIV(0, "div_core", "mout_core", DIV_CPU0, 0, 3),
+ 	DIV(0, "div_core2", "div_core", DIV_CPU0, 28, 3),
+ 	DIV(0, "div_fimc0", "mout_fimc0", DIV_CAM, 0, 4),
+ 	DIV(0, "div_fimc1", "mout_fimc1", DIV_CAM, 4, 4),
+ 	DIV(0, "div_fimc2", "mout_fimc2", DIV_CAM, 8, 4),
+ 	DIV(0, "div_fimc3", "mout_fimc3", DIV_CAM, 12, 4),
+ 	DIV(0, "div_cam0", "mout_cam0", DIV_CAM, 16, 4),
+ 	DIV(0, "div_cam1", "mout_cam1", DIV_CAM, 20, 4),
+ 	DIV(0, "div_csis0", "mout_csis0", DIV_CAM, 24, 4),
+ 	DIV(0, "div_csis1", "mout_csis1", DIV_CAM, 28, 4),
+ 	DIV(CLK_SCLK_MFC, "sclk_mfc", "mout_mfc", DIV_MFC, 0, 4),
+ 	DIV_F(0, "div_g3d", "mout_g3d", DIV_G3D, 0, 4,
  			CLK_SET_RATE_PARENT, 0),
- 	DIV(none, "div_fimd0", "mout_fimd0", DIV_LCD0, 0, 4),
- 	DIV(none, "div_mipi0", "mout_mipi0", DIV_LCD0, 16, 4),
- 	DIV(none, "div_audio0", "mout_audio0", DIV_MAUDIO, 0, 4),
- 	DIV(sclk_pcm0, "sclk_pcm0", "sclk_audio0", DIV_MAUDIO, 4, 8),
- 	DIV(none, "div_mmc0", "mout_mmc0", DIV_FSYS1, 0, 4),
- 	DIV(none, "div_mmc1", "mout_mmc1", DIV_FSYS1, 16, 4),
- 	DIV(none, "div_mmc2", "mout_mmc2", DIV_FSYS2, 0, 4),
- 	DIV(none, "div_mmc3", "mout_mmc3", DIV_FSYS2, 16, 4),
- 	DIV(sclk_pixel, "sclk_pixel", "sclk_vpll", DIV_TV, 0, 4),
- 	DIV(aclk100, "aclk100", "mout_aclk100", DIV_TOP, 4, 4),
- 	DIV(aclk160, "aclk160", "mout_aclk160", DIV_TOP, 8, 3),
- 	DIV(aclk133, "aclk133", "mout_aclk133", DIV_TOP, 12, 3),
- 	DIV(none, "div_onenand", "mout_onenand1", DIV_TOP, 16, 3),
- 	DIV(sclk_slimbus, "sclk_slimbus", "sclk_epll", DIV_PERIL3, 4, 4),
- 	DIV(sclk_pcm1, "sclk_pcm1", "sclk_audio1", DIV_PERIL4, 4, 8),
- 	DIV(sclk_pcm2, "sclk_pcm2", "sclk_audio2", DIV_PERIL4, 20, 8),
- 	DIV(sclk_i2s1, "sclk_i2s1", "sclk_audio1", DIV_PERIL5, 0, 6),
- 	DIV(sclk_i2s2, "sclk_i2s2", "sclk_audio2", DIV_PERIL5, 8, 6),
- 	DIV(none, "div_mmc4", "mout_mmc4", DIV_FSYS3, 0, 4),
- 	DIV_F(none, "div_mmc_pre4", "div_mmc4", DIV_FSYS3, 8, 8,
+ 	DIV(0, "div_fimd0", "mout_fimd0", DIV_LCD0, 0, 4),
+ 	DIV(0, "div_mipi0", "mout_mipi0", DIV_LCD0, 16, 4),
+ 	DIV(0, "div_audio0", "mout_audio0", DIV_MAUDIO, 0, 4),
+ 	DIV(CLK_SCLK_PCM0, "sclk_pcm0", "sclk_audio0", DIV_MAUDIO, 4, 8),
+ 	DIV(0, "div_mmc0", "mout_mmc0", DIV_FSYS1, 0, 4),
+ 	DIV(0, "div_mmc1", "mout_mmc1", DIV_FSYS1, 16, 4),
+ 	DIV(0, "div_mmc2", "mout_mmc2", DIV_FSYS2, 0, 4),
+ 	DIV(0, "div_mmc3", "mout_mmc3", DIV_FSYS2, 16, 4),
+ 	DIV(CLK_SCLK_PIXEL, "sclk_pixel", "sclk_vpll", DIV_TV, 0, 4),
+ 	DIV(CLK_ACLK100, "aclk100", "mout_aclk100", DIV_TOP, 4, 4),
+ 	DIV(CLK_ACLK160, "aclk160", "mout_aclk160", DIV_TOP, 8, 3),
+ 	DIV(CLK_ACLK133, "aclk133", "mout_aclk133", DIV_TOP, 12, 3),
+ 	DIV(0, "div_onenand", "mout_onenand1", DIV_TOP, 16, 3),
+ 	DIV(CLK_SCLK_SLIMBUS, "sclk_slimbus", "sclk_epll", DIV_PERIL3, 4, 4),
+ 	DIV(CLK_SCLK_PCM1, "sclk_pcm1", "sclk_audio1", DIV_PERIL4, 4, 8),
+ 	DIV(CLK_SCLK_PCM2, "sclk_pcm2", "sclk_audio2", DIV_PERIL4, 20, 8),
+ 	DIV(CLK_SCLK_I2S1, "sclk_i2s1", "sclk_audio1", DIV_PERIL5, 0, 6),
+ 	DIV(CLK_SCLK_I2S2, "sclk_i2s2", "sclk_audio2", DIV_PERIL5, 8, 6),
+ 	DIV(0, "div_mmc4", "mout_mmc4", DIV_FSYS3, 0, 4),
 -	DIV(0, "div_mmc_pre4", "div_mmc4", DIV_FSYS3, 8, 8),
++	DIV_F(0, "div_mmc_pre4", "div_mmc4", DIV_FSYS3, 8, 8,
 +			CLK_SET_RATE_PARENT, 0),
- 	DIV(none, "div_uart0", "mout_uart0", DIV_PERIL0, 0, 4),
- 	DIV(none, "div_uart1", "mout_uart1", DIV_PERIL0, 4, 4),
- 	DIV(none, "div_uart2", "mout_uart2", DIV_PERIL0, 8, 4),
- 	DIV(none, "div_uart3", "mout_uart3", DIV_PERIL0, 12, 4),
- 	DIV(none, "div_uart4", "mout_uart4", DIV_PERIL0, 16, 4),
- 	DIV(none, "div_spi0", "mout_spi0", DIV_PERIL1, 0, 4),
- 	DIV(none, "div_spi_pre0", "div_spi0", DIV_PERIL1, 8, 8),
- 	DIV(none, "div_spi1", "mout_spi1", DIV_PERIL1, 16, 4),
- 	DIV(none, "div_spi_pre1", "div_spi1", DIV_PERIL1, 24, 8),
- 	DIV(none, "div_spi2", "mout_spi2", DIV_PERIL2, 0, 4),
- 	DIV(none, "div_spi_pre2", "div_spi2", DIV_PERIL2, 8, 8),
- 	DIV(none, "div_audio1", "mout_audio1", DIV_PERIL4, 0, 4),
- 	DIV(none, "div_audio2", "mout_audio2", DIV_PERIL4, 16, 4),
- 	DIV(arm_clk, "arm_clk", "div_core2", DIV_CPU0, 28, 3),
- 	DIV(sclk_apll, "sclk_apll", "mout_apll", DIV_CPU0, 24, 3),
- 	DIV_F(none, "div_mipi_pre0", "div_mipi0", DIV_LCD0, 20, 4,
+ 	DIV(0, "div_uart0", "mout_uart0", DIV_PERIL0, 0, 4),
+ 	DIV(0, "div_uart1", "mout_uart1", DIV_PERIL0, 4, 4),
+ 	DIV(0, "div_uart2", "mout_uart2", DIV_PERIL0, 8, 4),
+ 	DIV(0, "div_uart3", "mout_uart3", DIV_PERIL0, 12, 4),
+ 	DIV(0, "div_uart4", "mout_uart4", DIV_PERIL0, 16, 4),
+ 	DIV(0, "div_spi0", "mout_spi0", DIV_PERIL1, 0, 4),
+ 	DIV(0, "div_spi_pre0", "div_spi0", DIV_PERIL1, 8, 8),
+ 	DIV(0, "div_spi1", "mout_spi1", DIV_PERIL1, 16, 4),
+ 	DIV(0, "div_spi_pre1", "div_spi1", DIV_PERIL1, 24, 8),
+ 	DIV(0, "div_spi2", "mout_spi2", DIV_PERIL2, 0, 4),
+ 	DIV(0, "div_spi_pre2", "div_spi2", DIV_PERIL2, 8, 8),
+ 	DIV(0, "div_audio1", "mout_audio1", DIV_PERIL4, 0, 4),
+ 	DIV(0, "div_audio2", "mout_audio2", DIV_PERIL4, 16, 4),
+ 	DIV(CLK_ARM_CLK, "arm_clk", "div_core2", DIV_CPU0, 28, 3),
+ 	DIV(CLK_SCLK_APLL, "sclk_apll", "mout_apll", DIV_CPU0, 24, 3),
+ 	DIV_F(0, "div_mipi_pre0", "div_mipi0", DIV_LCD0, 20, 4,
  			CLK_SET_RATE_PARENT, 0),
- 	DIV_F(none, "div_mmc_pre0", "div_mmc0", DIV_FSYS1, 8, 8,
+ 	DIV_F(0, "div_mmc_pre0", "div_mmc0", DIV_FSYS1, 8, 8,
  			CLK_SET_RATE_PARENT, 0),
- 	DIV_F(none, "div_mmc_pre1", "div_mmc1", DIV_FSYS1, 24, 8,
+ 	DIV_F(0, "div_mmc_pre1", "div_mmc1", DIV_FSYS1, 24, 8,
  			CLK_SET_RATE_PARENT, 0),
- 	DIV_F(none, "div_mmc_pre2", "div_mmc2", DIV_FSYS2, 8, 8,
+ 	DIV_F(0, "div_mmc_pre2", "div_mmc2", DIV_FSYS2, 8, 8,
  			CLK_SET_RATE_PARENT, 0),
- 	DIV_F(none, "div_mmc_pre3", "div_mmc3", DIV_FSYS2, 24, 8,
+ 	DIV_F(0, "div_mmc_pre3", "div_mmc3", DIV_FSYS2, 24, 8,
  			CLK_SET_RATE_PARENT, 0),
  };
  
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140113/425aeedf/attachment.sig>
