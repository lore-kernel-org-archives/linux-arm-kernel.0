From: aisheng.dong@nxp.com (A.s. Dong)
Date: Wed, 12 Jul 2017 13:59:57 +0000
Subject: [PATCH V4 7/7] pinctrl: pinctrl-imx7ulp: add gpio_set_direction
 support
In-Reply-To: <1498046395-30001-8-git-send-email-aisheng.dong@nxp.com>
References: <1498046395-30001-1-git-send-email-aisheng.dong@nxp.com>
 <1498046395-30001-8-git-send-email-aisheng.dong@nxp.com>
Message-ID: <AM3PR04MB3067C5E7E96CBFFF84B68B180AF0@AM3PR04MB306.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

> -----Original Message-----
> From: Dong Aisheng [mailto:aisheng.dong at nxp.com]
> Sent: Wednesday, June 21, 2017 8:00 PM
> To: linux-gpio at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org; linus.walleij at linaro.org;
> shawnguo at kernel.org; stefan at agner.ch; Jacky Bai; Andy Duan;
> kernel at pengutronix.de; A.s. Dong; Alexandre Courbot
> Subject: [PATCH V4 7/7] pinctrl: pinctrl-imx7ulp: add gpio_set_direction
> support
> 
> Add gpio_set_direction support. This makes the driver support GPIO
> input/output dynamically change from userspace.
> 
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Alexandre Courbot <gnurou@gmail.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Stefan Agner <stefan@agner.ch>
> Cc: Fugang Duan <fugang.duan@nxp.com>
> Cc: Bai Ping <ping.bai@nxp.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> 
> ---
> ChangeLog:
>  * New patch. Derived from the original:
>    [PATCH 1/2] pinctrl: pinctrl-imx: add IBE and OBE SoC property

And this one.

Please help review.

Regards
Dong Aisheng

> ---
>  drivers/pinctrl/freescale/pinctrl-imx7ulp.c | 26
> ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/pinctrl/freescale/pinctrl-imx7ulp.c
> b/drivers/pinctrl/freescale/pinctrl-imx7ulp.c
> index 96127dc..b7bebb2 100644
> --- a/drivers/pinctrl/freescale/pinctrl-imx7ulp.c
> +++ b/drivers/pinctrl/freescale/pinctrl-imx7ulp.c
> @@ -259,6 +259,8 @@ static const struct pinctrl_pin_desc
> imx7ulp_pinctrl_pads[] = {
>  	IMX_PINCTRL_PIN(IMX7ULP_PAD_PTF19),
>  };
> 
> +#define BM_OBE_ENABLED		BIT(17)
> +#define BM_IBE_ENABLED		BIT(16)
>  #define BM_LK_ENABLED		BIT(15)
>  #define BM_MUX_MODE		0xf00
>  #define BP_MUX_MODE		8
> @@ -300,10 +302,34 @@ static void imx7ulp_cfg_params_fixup(unsigned long
> *configs,
>  	}
>  }
> 
> +static int imx7ulp_pmx_gpio_set_direction(struct pinctrl_dev *pctldev,
> +					  struct pinctrl_gpio_range *range,
> +					  unsigned offset, bool input)
> +{
> +	struct imx_pinctrl *ipctl = pinctrl_dev_get_drvdata(pctldev);
> +	struct imx_pinctrl_soc_info *info = ipctl->info;
> +	const struct imx_pin_reg *pin_reg;
> +	u32 reg;
> +
> +	pin_reg = &info->pin_regs[offset];
> +	if (pin_reg->mux_reg == -1)
> +		return -EINVAL;
> +
> +	reg = readl(ipctl->base + pin_reg->mux_reg);
> +	if (input)
> +		reg = (reg & ~BM_OBE_ENABLED) | BM_IBE_ENABLED;
> +	else
> +		reg = (reg & ~BM_IBE_ENABLED) | BM_OBE_ENABLED;
> +	writel(reg, ipctl->base + pin_reg->mux_reg);
> +
> +	return 0;
> +}
> +
>  static struct imx_pinctrl_soc_info imx7ulp_pinctrl_info = {
>  	.pins = imx7ulp_pinctrl_pads,
>  	.npins = ARRAY_SIZE(imx7ulp_pinctrl_pads),
>  	.flags = ZERO_OFFSET_VALID | SHARE_MUX_CONF_REG,
> +	.gpio_set_direction = imx7ulp_pmx_gpio_set_direction,
>  	.mux_mask = BM_MUX_MODE,
>  	.mux_shift = BP_MUX_MODE,
>  	.generic_pinconf = true,
> --
> 2.7.4
