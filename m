From: stefan@agner.ch (Stefan Agner)
Date: Fri, 27 Mar 2015 11:32:31 +0100
Subject: [PATCH] pinctrl: fsl: imx: Check for 0 config register
In-Reply-To: <1427210778-28037-1-git-send-email-mpa@pengutronix.de>
References: <1427210778-28037-1-git-send-email-mpa@pengutronix.de>
Message-ID: <139dc298c0914b3536445dddd37be286@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-03-24 16:26, Markus Pargmann wrote:
> 0 is used in all pinfunction definitions when a config register is not
> available, for example imx25-pinfunc.h. If a configuration value is used
> for such a pinfunction the driver will always write it to the
> configuration register if it is not -1. For a 0 configuration register
> the configuration value is written to offset 0x0. This can lead to a
> crashing/hanging system without any warning message.

0 is a valid offset for Vybrid's mux register, however, since Vybrid set
the SHARE_MUX_CONF_REG, intepreting a 0 in conf_reg as "not set"
actually works.

What is a bit a bummer is that we now have different meanings of 0,
depending on the field:
- For the first field (mux), 0 is a valid offset
- For the second field (config), 0 means not valid

However, I can't think of a easy solution which would solve this in a
cleaner mannor... Maybe a comment in the function header how the 5 u32's
are intepreted would appropriate?


--
Stefan

> 
> This patch checks for 0 config register and sets the internal value to
> -1. If the configuration value is not NO_PADCTL this leads to an error
> message that applying the configuration failed.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
>  drivers/pinctrl/freescale/pinctrl-imx.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pinctrl/freescale/pinctrl-imx.c
> b/drivers/pinctrl/freescale/pinctrl-imx.c
> index 448f10986c28..2cc400b0a26b 100644
> --- a/drivers/pinctrl/freescale/pinctrl-imx.c
> +++ b/drivers/pinctrl/freescale/pinctrl-imx.c
> @@ -542,10 +542,13 @@ static int imx_pinctrl_parse_groups(struct
> device_node *np,
>  		struct imx_pin_reg *pin_reg;
>  		struct imx_pin *pin = &grp->pins[i];
>  
> -		if (info->flags & SHARE_MUX_CONF_REG)
> +		if (info->flags & SHARE_MUX_CONF_REG) {
>  			conf_reg = mux_reg;
> -		else
> +		} else {
>  			conf_reg = be32_to_cpu(*list++);
> +			if (!conf_reg)
> +				conf_reg = -1;
> +		}
>  
>  		pin_id = mux_reg ? mux_reg / 4 : conf_reg / 4;
>  		pin_reg = &info->pin_regs[pin_id];
