From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 30 Jul 2013 15:50:21 +0800
Subject: [PATCH 1/2] pinctrl: imx: Add exception hook for select input
In-Reply-To: <1375152857-32177-1-git-send-email-peter.chen@freescale.com>
References: <1375152857-32177-1-git-send-email-peter.chen@freescale.com>
Message-ID: <20130730075018.GD12382@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 30, 2013 at 10:54:16AM +0800, Peter Chen wrote:
> At some i.mx platforms the select input pin configuration may
> not be at common select input register region due to IC found
> the pin select pin configuration missing very late (Eg, ECO stage),
> so this pin's select input register is at other register space at
> pinctrl module. One typical example is USB OTG ID pin at i.mx6q is
> at IOMUXC_IOMUXC_GPR1.

Do you know any other case except this USB OTG ID pin on imx6q?  If this
is the only case, I'm wondering if we could work it around in machine
code mach-imx6q.c to avoid the churn of pinctrl driver?

Shawn

> 
> Signed-off-by: Peter Chen <peter.chen@freescale.com>
> ---
>  drivers/pinctrl/pinctrl-imx.c   |   11 +++++++++--
>  drivers/pinctrl/pinctrl-imx.h   |    8 ++++++--
>  drivers/pinctrl/pinctrl-imx6q.c |   14 ++++++++++++++
>  3 files changed, 29 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-imx.c b/drivers/pinctrl/pinctrl-imx.c
> index 57a4eb0..da75cd4 100644
> --- a/drivers/pinctrl/pinctrl-imx.c
> +++ b/drivers/pinctrl/pinctrl-imx.c
> @@ -240,8 +240,15 @@ static int imx_pmx_enable(struct pinctrl_dev *pctldev, unsigned selector,
>  			pin_reg->mux_reg, mux[i]);
>  
>  		/* some pins also need select input setting, set it if found */
> -		if (input_reg[i]) {
> -			writel(input_val[i], ipctl->base + input_reg[i]);
> +		if (input_reg) {
> +			if ((input_reg[i] == IMX_SELECT_INPUT_EXCEPTION) &&
> +					info->imx_select_input_hook)
> +				info->imx_select_input_hook(ipctl->base,
> +					input_val[i]);
> +			else
> +				writel(input_val[i], ipctl->base +
> +					input_reg[i]);
> +
>  			dev_dbg(ipctl->dev,
>  				"==>select_input: offset 0x%x val 0x%x\n",
>  				input_reg[i], input_val[i]);
> diff --git a/drivers/pinctrl/pinctrl-imx.h b/drivers/pinctrl/pinctrl-imx.h
> index bcedd99..15e71b9 100644
> --- a/drivers/pinctrl/pinctrl-imx.h
> +++ b/drivers/pinctrl/pinctrl-imx.h
> @@ -26,8 +26,9 @@ struct platform_device;
>   *	elements in .pins so we can iterate over that array
>   * @mux_mode: the mux mode for each pin in this group. The size of this
>   *	array is the same as pins.
> - * @input_reg: select input register offset for this mux if any
> - *	0 if no select input setting needed.
> + * @input_reg: select input register offset for this mux,
> + *	0 if no select input setting needed, 0xfff if select input setting
> + *	is not at common select input register regiion.
>   * @input_val: the select input value for each pin in this group. The size of
>   *	this array is the same as pins.
>   * @configs: the config for each pin in this group. The size of this
> @@ -75,10 +76,13 @@ struct imx_pinctrl_soc_info {
>  	struct imx_pmx_func *functions;
>  	unsigned int nfunctions;
>  	unsigned int flags;
> +	/* Handle the exception for select input choose */
> +	void (*imx_select_input_hook) (void __iomem *, int);
>  };
>  
>  #define ZERO_OFFSET_VALID	0x1
>  #define SHARE_MUX_CONF_REG	0x2
> +#define IMX_SELECT_INPUT_EXCEPTION	0xfff
>  
>  #define NO_MUX		0x0
>  #define NO_PAD		0x0
> diff --git a/drivers/pinctrl/pinctrl-imx6q.c b/drivers/pinctrl/pinctrl-imx6q.c
> index 76dd9c4..61efa97 100644
> --- a/drivers/pinctrl/pinctrl-imx6q.c
> +++ b/drivers/pinctrl/pinctrl-imx6q.c
> @@ -461,9 +461,23 @@ static const struct pinctrl_pin_desc imx6q_pinctrl_pads[] = {
>  	IMX_PINCTRL_PIN(MX6Q_PAD_SD2_DAT3),
>  };
>  
> +#define IOMUXC_IOMUXC_GPR1	0x4
> +#define IOMUXC_GPR1_USB_OTG_ID_SEL_BIT	13
> +static void imx6q_pinctrl_select_input_hook(void __iomem *base, int val)
> +{
> +	u32 value;
> +	/* Add the exceptions one by one */
> +
> +	/* USB ID select input configuration */
> +	value = readl(base + IOMUXC_IOMUXC_GPR1);
> +	writel(value | (val << IOMUXC_GPR1_USB_OTG_ID_SEL_BIT),
> +		base + IOMUXC_IOMUXC_GPR1);
> +}
> +
>  static struct imx_pinctrl_soc_info imx6q_pinctrl_info = {
>  	.pins = imx6q_pinctrl_pads,
>  	.npins = ARRAY_SIZE(imx6q_pinctrl_pads),
> +	.imx_select_input_hook = imx6q_pinctrl_select_input_hook,
>  };
>  
>  static struct of_device_id imx6q_pinctrl_of_match[] = {
> -- 
> 1.7.0.4
> 
> 
