From: aisheng.dong@nxp.com (A.S. Dong)
Date: Fri, 12 May 2017 13:32:45 +0000
Subject: [PATCH 2/5] pinctrl: pinctrl-imx: add soc specific mux_mode mask
 and shift property
In-Reply-To: <1494592686-30967-4-git-send-email-aisheng.dong@nxp.com>
References: <1494592686-30967-1-git-send-email-aisheng.dong@nxp.com>
 <1494592686-30967-4-git-send-email-aisheng.dong@nxp.com>
Message-ID: <AM3PR04MB306315F2D57F469AE313E2980E20@AM3PR04MB306.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Dong Aisheng [mailto:aisheng.dong at nxp.com]
> Sent: Friday, May 12, 2017 8:38 PM
> To: linux-gpio at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org; linus.walleij at linaro.org;
> shawnguo at kernel.org; stefan at agner.ch; Jacky Bai; Andy Duan;
> kernel at pengutronix.de; A.S. Dong
> Subject: [PATCH 2/5] pinctrl: pinctrl-imx: add soc specific mux_mode mask
> and shift property
> 
> MX7ULP MUX mode mask and shift bit is different from VF610.
> Let's make it a platform specific property for the later easy of adding
> MX7ULP support.
> 
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Stefan Agner <stefan@agner.ch>
> Cc: Bai Ping <ping.bai@nxp.com>
> Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

Please ignore this one which is sent out accidentally.
It's actually the same as the following one except the patch title difference.
[PATCH 2/5] pinctrl: imx: add soc specific mux_mode mask and shift property

Others all are ok.

Regards
Dong Aisheng

> ---
>  drivers/pinctrl/freescale/pinctrl-imx.c   | 10 +++++-----
>  drivers/pinctrl/freescale/pinctrl-imx.h   |  4 ++++
>  drivers/pinctrl/freescale/pinctrl-vf610.c |  2 ++
>  3 files changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pinctrl/freescale/pinctrl-imx.c
> b/drivers/pinctrl/freescale/pinctrl-imx.c
> index 406881d..ef4951f 100644
> --- a/drivers/pinctrl/freescale/pinctrl-imx.c
> +++ b/drivers/pinctrl/freescale/pinctrl-imx.c
> @@ -197,8 +197,8 @@ static int imx_pmx_set(struct pinctrl_dev *pctldev,
> unsigned selector,
>  		if (info->flags & SHARE_MUX_CONF_REG) {
>  			u32 reg;
>  			reg = readl(ipctl->base + pin_reg->mux_reg);
> -			reg &= ~(0x7 << 20);
> -			reg |= (pin->mux_mode << 20);
> +			reg &= ~info->mux_mask;
> +			reg |= (pin->mux_mode << info->mux_shift);
>  			writel(reg, ipctl->base + pin_reg->mux_reg);
>  		} else {
>  			writel(pin->mux_mode, ipctl->base + pin_reg->mux_reg);
> @@ -288,7 +288,7 @@ static int imx_pmx_gpio_request_enable(struct
> pinctrl_dev *pctldev,
> 
>  mux_pin:
>  	reg = readl(ipctl->base + pin_reg->mux_reg);
> -	reg &= ~(0x7 << 20);
> +	reg &= ~info->mux_mask;
>  	reg |= imx_pin->config;
>  	writel(reg, ipctl->base + pin_reg->mux_reg);
> 
> @@ -432,7 +432,7 @@ static int imx_pinconf_get(struct pinctrl_dev *pctldev,
>  	*config = readl(ipctl->base + pin_reg->conf_reg);
> 
>  	if (info->flags & SHARE_MUX_CONF_REG)
> -		*config &= 0xffff;
> +		*config &= ~info->mux_mask;
> 
>  	return 0;
>  }
> @@ -459,7 +459,7 @@ static int imx_pinconf_set(struct pinctrl_dev *pctldev,
>  		if (info->flags & SHARE_MUX_CONF_REG) {
>  			u32 reg;
>  			reg = readl(ipctl->base + pin_reg->conf_reg);
> -			reg &= ~0xffff;
> +			reg &= info->mux_mask;
>  			reg |= configs[i];
>  			writel(reg, ipctl->base + pin_reg->conf_reg);
>  		} else {
> diff --git a/drivers/pinctrl/freescale/pinctrl-imx.h
> b/drivers/pinctrl/freescale/pinctrl-imx.h
> index b5c8fe1..eb0ce95 100644
> --- a/drivers/pinctrl/freescale/pinctrl-imx.h
> +++ b/drivers/pinctrl/freescale/pinctrl-imx.h
> @@ -64,6 +64,10 @@ struct imx_pinctrl_soc_info {
>  	const char *gpr_compatible;
>  	struct mutex mutex;
> 
> +	/* MUX_MODE shift and mask in case SHARE_MUX_CONF_REG */
> +	unsigned int mux_mask;
> +	u8 mux_shift;
> +
>  	/* generic pinconf */
>  	bool generic_pinconf;
>  	const struct pinconf_generic_params *custom_params; diff --git
> a/drivers/pinctrl/freescale/pinctrl-vf610.c
> b/drivers/pinctrl/freescale/pinctrl-vf610.c
> index 2b1e198..3bd8556 100644
> --- a/drivers/pinctrl/freescale/pinctrl-vf610.c
> +++ b/drivers/pinctrl/freescale/pinctrl-vf610.c
> @@ -299,6 +299,8 @@ static struct imx_pinctrl_soc_info vf610_pinctrl_info
> = {
>  	.pins = vf610_pinctrl_pads,
>  	.npins = ARRAY_SIZE(vf610_pinctrl_pads),
>  	.flags = SHARE_MUX_CONF_REG | ZERO_OFFSET_VALID,
> +	.mux_mask = 0x700000,
> +	.mux_shift = 20,
>  };
> 
>  static const struct of_device_id vf610_pinctrl_of_match[] = {
> --
> 2.7.4
