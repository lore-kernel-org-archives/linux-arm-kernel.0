From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 26 Oct 2016 13:48:56 -0200
Subject: [PATCH RESEND 1/3] clk: imx6: Mask mmdc_ch1 handshake for
 periph2_sel and mmdc_ch1_axi_podf
In-Reply-To: <1476750554-21961-1-git-send-email-festevam@gmail.com>
References: <1476750554-21961-1-git-send-email-festevam@gmail.com>
Message-ID: <CAOMZO5BQHKv7dxJTq2C1qdvhhRRRW8bafaXoQW77AKLNTWggAg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn,

Are you collecting the imx clk patches in this cycle?

I see no response from Stephen on this series from a long time.

We missed 4.9, so hopefully this can land in 4.10.

On Mon, Oct 17, 2016 at 10:29 PM, Fabio Estevam <festevam@gmail.com> wrote:
> From: Philipp Zabel <p.zabel@pengutronix.de>
>
> MMDC CH1 is not used on i.MX6Q, so the handshake needed to change the
> parent of periph2_sel or the divider of mmdc_ch1_axi_podf will never
> succeed.
> Disable the handshake mechanism to allow changing the frequency of
> mmdc_ch1_axi, allowing to use it as a possible source for the LDB DI
> clock.
>
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
>  drivers/clk/imx/clk-imx6q.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
> index ce8ea10..66825a8 100644
> --- a/drivers/clk/imx/clk-imx6q.c
> +++ b/drivers/clk/imx/clk-imx6q.c
> @@ -156,6 +156,19 @@ static struct clk ** const uart_clks[] __initconst = {
>         NULL
>  };
>
> +#define CCM_CCDR               0x04
> +
> +#define CCDR_MMDC_CH1_MASK     BIT(16)
> +
> +static void __init imx6q_mmdc_ch1_mask_handshake(void __iomem *ccm_base)
> +{
> +       unsigned int reg;
> +
> +       reg = readl_relaxed(ccm_base + CCM_CCDR);
> +       reg |= CCDR_MMDC_CH1_MASK;
> +       writel_relaxed(reg, ccm_base + CCM_CCDR);
> +}
> +
>  static void __init imx6q_clocks_init(struct device_node *ccm_node)
>  {
>         struct device_node *np;
> @@ -297,6 +310,8 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
>         base = of_iomap(np, 0);
>         WARN_ON(!base);
>
> +       imx6q_mmdc_ch1_mask_handshake(base);
> +
>         /*                                              name                reg       shift width parent_names     num_parents */
>         clk[IMX6QDL_CLK_STEP]             = imx_clk_mux("step",             base + 0xc,  8,  1, step_sels,         ARRAY_SIZE(step_sels));
>         clk[IMX6QDL_CLK_PLL1_SW]          = imx_clk_mux("pll1_sw",          base + 0xc,  2,  1, pll1_sw_sels,      ARRAY_SIZE(pll1_sw_sels));
> --
> 2.7.4
>
