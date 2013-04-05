From: mturquette@linaro.org (Mike Turquette)
Date: Fri, 05 Apr 2013 11:32:21 -0700
Subject: [PATCH] clk: exynos4: export clocks required for fimc-is
In-Reply-To: <1365184185-23794-1-git-send-email-s.nawrocki@samsung.com>
References: <1365184185-23794-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <20130405183221.7302.97946@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Sylwester Nawrocki (2013-04-05 10:49:45)
> This patch adds clock indexes for ACLK_DIV0, ACLK_DIV1,
> ACLK_400_MCUISP, ACLK_MCUISP_DIV0, ACLK_MCUISP_DIV1,
> DIVACLK_400_MCUISP and DIVACLK_200 so these clocks are
> available to the consumers (Exynos4x12 FIMC-IS subsystem).
> While at it, indentation of the mux clocks table is
> corrected.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

Acked-by: Mike Turquette <mturquette@linaro.org>

> ---
> Rebased onto git://git.kernel.org/pub/scm/linux/kernel/git/
> kgene/linux-samsung.git for-next
> 
>  .../devicetree/bindings/clock/exynos4-clock.txt    |   42 +++++++++++++-------
>  drivers/clk/samsung/clk-exynos4.c                  |   20 ++++++----
>  2 files changed, 41 insertions(+), 21 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/exynos4-clock.txt b/Documentation/devicetree/bindings/clock/exynos4-clock.txt
> index 662007e..ea5e26f 100644
> --- a/Documentation/devicetree/bindings/clock/exynos4-clock.txt
> +++ b/Documentation/devicetree/bindings/clock/exynos4-clock.txt
> @@ -236,22 +236,36 @@ Exynos4 SoC and this is specified where applicable.
>    spi1_isp_sclk       381     Exynos4x12
>    uart_isp_sclk       382     Exynos4x12
> 
> -                       [Mux Clocks]
> +               [Mux Clocks]
> 
> -       Clock           ID      SoC (if specific)
> -       -----------------------------------------------
> +  Clock                        ID      SoC (if specific)
> +  -----------------------------------------------
> +
> +  mout_fimc0           384
> +  mout_fimc1           385
> +  mout_fimc2           386
> +  mout_fimc3           387
> +  mout_cam0            388
> +  mout_cam1            389
> +  mout_csis0           390
> +  mout_csis1           391
> +  mout_g3d0            392
> +  mout_g3d1            393
> +  mout_g3d             394
> +  aclk400_mcuisp       395     Exynos4x12
> +
> +               [Div Clocks]
> +
> +  Clock                        ID      SoC (if specific)
> +  -----------------------------------------------
> +
> +  div_isp0             450     Exynos4x12
> +  div_isp1             451     Exynos4x12
> +  div_mcuisp0          452     Exynos4x12
> +  div_mcuisp1          453     Exynos4x12
> +  div_aclk200          454     Exynos4x12
> +  div_aclk400_mcuisp   455     Exynos4x12
> 
> -       mout_fimc0      384
> -       mout_fimc1      385
> -       mout_fimc2      386
> -       mout_fimc3      387
> -       mout_cam0       388
> -       mout_cam1       389
> -       mout_csis0      390
> -       mout_csis1      391
> -       mout_g3d0       392
> -       mout_g3d1       393
> -       mout_g3d        394
> 
>  Example 1: An example of a clock controller node is listed below.
> 
> diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-exynos4.c
> index 17674da..7104669 100644
> --- a/drivers/clk/samsung/clk-exynos4.c
> +++ b/drivers/clk/samsung/clk-exynos4.c
> @@ -175,6 +175,11 @@ enum exynos4_clks {
>         /* mux clocks */
>         mout_fimc0 = 384, mout_fimc1, mout_fimc2, mout_fimc3, mout_cam0,
>         mout_cam1, mout_csis0, mout_csis1, mout_g3d0, mout_g3d1, mout_g3d,
> +       aclk400_mcuisp,
> +
> +       /* div clocks */
> +       div_isp0 = 450, div_isp1, div_mcuisp0, div_mcuisp1, div_aclk200,
> +       div_aclk400_mcuisp,
> 
>         nr_clks,
>  };
> @@ -429,7 +434,7 @@ struct samsung_mux_clock exynos4x12_mux_clks[] __initdata = {
>         MUX(none, "mout_user_aclk266_gps", mout_user_aclk266_gps_p4x12,
>                         SRC_TOP1, 16, 1),
>         MUX(aclk200, "aclk200", mout_user_aclk200_p4x12, SRC_TOP1, 20, 1),
> -       MUX(none, "aclk400_mcuisp", mout_user_aclk400_mcuisp_p4x12,
> +       MUX(aclk400_mcuisp, "aclk400_mcuisp", mout_user_aclk400_mcuisp_p4x12,
>                         SRC_TOP1, 24, 1),
>         MUX(none, "mout_aclk200", aclk_p4412, SRC_TOP0, 12, 1),
>         MUX(none, "mout_aclk100", aclk_p4412, SRC_TOP0, 16, 1),
> @@ -563,20 +568,21 @@ struct samsung_div_clock exynos4x12_div_clks[] __initdata = {
>         DIV(none, "div_mdnie_pwm_pre0", "div_mdnie_pwm0", DIV_LCD0, 12, 4),
>         DIV(none, "div_mipihsi", "mout_mipihsi", DIV_FSYS0, 20, 4),
>         DIV(none, "div_jpeg", "mout_jpeg", E4X12_DIV_CAM1, 0, 4),
> -       DIV(none, "div_aclk200", "mout_aclk200", DIV_TOP, 0, 3),
> +       DIV(div_aclk200, "div_aclk200", "mout_aclk200", DIV_TOP, 0, 3),
>         DIV(none, "div_aclk266_gps", "mout_aclk266_gps", DIV_TOP, 20, 3),
> -       DIV(none, "div_aclk400_mcuisp", "mout_aclk400_mcuisp", DIV_TOP, 24, 3),
> +       DIV(div_aclk400_mcuisp, "div_aclk400_mcuisp", "mout_aclk400_mcuisp",
> +                                               DIV_TOP, 24, 3),
>         DIV(none, "div_pwm_isp", "mout_pwm_isp", E4X12_DIV_ISP, 0, 4),
>         DIV(none, "div_spi0_isp", "mout_spi0_isp", E4X12_DIV_ISP, 4, 4),
>         DIV(none, "div_spi0_isp_pre", "div_spi0_isp", E4X12_DIV_ISP, 8, 8),
>         DIV(none, "div_spi1_isp", "mout_spi1_isp", E4X12_DIV_ISP, 16, 4),
>         DIV(none, "div_spi1_isp_pre", "div_spi1_isp", E4X12_DIV_ISP, 20, 8),
>         DIV(none, "div_uart_isp", "mout_uart_isp", E4X12_DIV_ISP, 28, 4),
> -       DIV(none, "div_isp0", "aclk200", E4X12_DIV_ISP0, 0, 3),
> -       DIV(none, "div_isp1", "aclk200", E4X12_DIV_ISP0, 4, 3),
> +       DIV(div_isp0, "div_isp0", "aclk200", E4X12_DIV_ISP0, 0, 3),
> +       DIV(div_isp1, "div_isp1", "aclk200", E4X12_DIV_ISP0, 4, 3),
>         DIV(none, "div_mpwm", "div_isp1", E4X12_DIV_ISP1, 0, 3),
> -       DIV(none, "div_mcuisp0", "aclk400_mcuisp", E4X12_DIV_ISP1, 4, 3),
> -       DIV(none, "div_mcuisp1", "div_mcuisp0", E4X12_DIV_ISP1, 8, 3),
> +       DIV(div_mcuisp0, "div_mcuisp0", "aclk400_mcuisp", E4X12_DIV_ISP1, 4, 3),
> +       DIV(div_mcuisp1, "div_mcuisp1", "div_mcuisp0", E4X12_DIV_ISP1, 8, 3),
>  };
> 
>  /* list of gate clocks supported in all exynos4 soc's */
> --
> 1.7.9.5
