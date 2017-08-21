From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 21 Aug 2017 11:17:01 -0300
Subject: [PATCH] clk: imx51: propagate rate across ipu_di*_sel
In-Reply-To: <20170818163058.22252-1-l.stach@pengutronix.de>
References: <20170818163058.22252-1-l.stach@pengutronix.de>
Message-ID: <CAOMZO5BoZNQrmDMXE0CDxLS-v7xVu4z87Ezdma1X1QCV56rPtQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 18, 2017 at 1:30 PM, Lucas Stach <l.stach@pengutronix.de> wrote:
> This propagates rate requests from the display interface to the divider
> or PLL output, allowing to hit the required display rate in many more
> cases.
>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

Looks good:

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>

> ---
>  drivers/clk/imx/clk-imx51-imx53.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/clk/imx/clk-imx51-imx53.c b/drivers/clk/imx/clk-imx51-imx53.c
> index 1e3c9ea5f9dc..7bcaf270db11 100644
> --- a/drivers/clk/imx/clk-imx51-imx53.c
> +++ b/drivers/clk/imx/clk-imx51-imx53.c
> @@ -416,10 +416,10 @@ static void __init mx51_clocks_init(struct device_node *np)
>
>         clk[IMX5_CLK_LP_APM]            = imx_clk_mux("lp_apm", MXC_CCM_CCSR, 9, 1,
>                                                 lp_apm_sel, ARRAY_SIZE(lp_apm_sel));
> -       clk[IMX5_CLK_IPU_DI0_SEL]       = imx_clk_mux("ipu_di0_sel", MXC_CCM_CSCMR2, 26, 3,
> -                                               mx51_ipu_di0_sel, ARRAY_SIZE(mx51_ipu_di0_sel));
> -       clk[IMX5_CLK_IPU_DI1_SEL]       = imx_clk_mux("ipu_di1_sel", MXC_CCM_CSCMR2, 29, 3,
> -                                               mx51_ipu_di1_sel, ARRAY_SIZE(mx51_ipu_di1_sel));
> +       clk[IMX5_CLK_IPU_DI0_SEL]       = imx_clk_mux_flags("ipu_di0_sel", MXC_CCM_CSCMR2, 26, 3,
> +                                               mx51_ipu_di0_sel, ARRAY_SIZE(mx51_ipu_di0_sel), CLK_SET_RATE_PARENT);
> +       clk[IMX5_CLK_IPU_DI1_SEL]       = imx_clk_mux_flags("ipu_di1_sel", MXC_CCM_CSCMR2, 29, 3,
> +                                               mx51_ipu_di1_sel, ARRAY_SIZE(mx51_ipu_di1_sel), CLK_SET_RATE_PARENT);
>         clk[IMX5_CLK_TVE_EXT_SEL]       = imx_clk_mux_flags("tve_ext_sel", MXC_CCM_CSCMR1, 6, 1,
>                                                 mx51_tve_ext_sel, ARRAY_SIZE(mx51_tve_ext_sel), CLK_SET_RATE_PARENT);
>         clk[IMX5_CLK_TVE_SEL]           = imx_clk_mux("tve_sel", MXC_CCM_CSCMR1, 7, 1,

Wladimir,

Could you please test it and see if it fixes the DVI output issue you
reported earlier?
https://lists.freedesktop.org/archives/dri-devel/2017-April/138155.html

Thanks
