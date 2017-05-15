From: stefan@agner.ch (Stefan Agner)
Date: Mon, 15 May 2017 10:27:03 -0700
Subject: [PATCH 2/2] pinctrl: pinctrl-imx: do not assume mux 0 is gpio
In-Reply-To: <1494830906-6442-3-git-send-email-aisheng.dong@nxp.com>
References: <1494830906-6442-1-git-send-email-aisheng.dong@nxp.com>
 <1494830906-6442-3-git-send-email-aisheng.dong@nxp.com>
Message-ID: <6d47abc0527ae6f2214a9b37dfbeb154@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017-05-14 23:48, Dong Aisheng wrote:
> Do not assume MUX 0 is GPIO function in core driver as a different
> SoC may have different value. e.g. MX7ULP Mux 1 is GPIO.
> 
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Alexandre Courbot <gnurou@gmail.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Stefan Agner <stefan@agner.ch>
> Cc: Fugang Duan <fugang.duan@nxp.com>
> Cc: Bai Ping <ping.bai@nxp.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>  drivers/pinctrl/freescale/pinctrl-imx.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/freescale/pinctrl-imx.c
> b/drivers/pinctrl/freescale/pinctrl-imx.c
> index 0d6aaca..ed8ea32 100644
> --- a/drivers/pinctrl/freescale/pinctrl-imx.c
> +++ b/drivers/pinctrl/freescale/pinctrl-imx.c
> @@ -281,7 +281,7 @@ static int imx_pmx_gpio_request_enable(struct
> pinctrl_dev *pctldev,
>  			continue;
>  		for (pin = 0; pin < grp->num_pins; pin++) {
>  			imx_pin = &((struct imx_pin *)(grp->data))[pin];
> -			if (imx_pin->pin == offset && !imx_pin->mux_mode)
> +			if (imx_pin->pin == offset)
>  				goto mux_pin;

The reason I added that check was to make sure we pick a mux option
which is GPIO... With this change, any pinmux might be picked...

>  		}
>  	}
> @@ -292,6 +292,7 @@ static int imx_pmx_gpio_request_enable(struct
> pinctrl_dev *pctldev,
>  	reg = readl(ipctl->base + pin_reg->mux_reg);
>  	reg &= ~info->mux_mask;
>  	reg |= imx_pin->config;
> +	reg |= imx_pin->mux_mode << info->mux_shift;

... and muxed...

Not sure if we want that.

I had to control GPIO output/input through pinctrl since Vybrid does not
allow to control that from the GPIO block.

However, according to your GPIO patchset, the i.MX 7ULP has a new
register GPIO_PDDR to control output from the GPIO block. Is controlling
the output driver from IOMUXC still required? If not, I really would
just not use all that "find pinctrl config" hackery... e.g. add a new
flag, USE_IOMUXC_FOR_GPIO_OUTPUT, and set that only for Vybrid.

This would also align much better with the other i.MX devices, where
pinmuxing and GPIO is completely orthogonal.

--
Stefan

>  	writel(reg, ipctl->base + pin_reg->mux_reg);
>  
>  	return 0;
