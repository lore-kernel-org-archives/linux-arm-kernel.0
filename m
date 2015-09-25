From: mpa@pengutronix.de (Markus Pargmann)
Date: Fri, 25 Sep 2015 12:47:26 +0200
Subject: [PATCH v5 4/7] pinctrl: freescale: imx: allow mux_reg offset zero
In-Reply-To: <1443128043-21063-4-git-send-email-aalonso@freescale.com>
References: <1443128043-21063-1-git-send-email-aalonso@freescale.com>
 <1443128043-21063-4-git-send-email-aalonso@freescale.com>
Message-ID: <20150925104726.GJ11805@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 24, 2015 at 03:54:00PM -0500, Adrian Alonso wrote:
> Allow mux_reg offset zero to be a valid pin_id, on imx7d
> mux_conf reg offset is zero for iomuxc-lspr controller
> 
> Signed-off-by: Adrian Alonso <aalonso@freescale.com>
> ---
> Changes for V2: Resend
> Changes for V3: Resend
> Changes for V4: Simplify pin_id assigment when ZERO_OFFSET_VALID is set
> Changes for V5:
> - Drop patch pinctrl: freescale: imx: add ZERO_OFFSET_VALID flag
> - Allow mux_reg ZERO OFFSET as pin_id
> 
>  drivers/pinctrl/freescale/pinctrl-imx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/freescale/pinctrl-imx.c b/drivers/pinctrl/freescale/pinctrl-imx.c
> index b9c6deb..23348d8 100644
> --- a/drivers/pinctrl/freescale/pinctrl-imx.c
> +++ b/drivers/pinctrl/freescale/pinctrl-imx.c
> @@ -550,7 +550,7 @@ static int imx_pinctrl_parse_groups(struct device_node *np,
>  				conf_reg = -1;
>  		}
>  
> -		pin_id = mux_reg ? mux_reg / 4 : conf_reg / 4;
> +		pin_id = (mux_reg != -1) ? mux_reg / 4 : conf_reg / 4;

This will break compatibility with imx35 and imx25 pinctrl drivers. They
have definitions where mux_reg can be 0x0. See imx35-pinfunc.h and
imx25-pinfunc.h:

	git grep -E "0x0+ 0x.* 0x.* 0x.* 0x.*"

This mux_reg behaviour was not described in the DT binding
documentation. But it is used by some platforms. So even if you change
the pincfunc headers to use "-1", it would break devicetrees compiled
with earlier kernel versions.

Regards,

Markus

>  		pin_reg = &info->pin_regs[pin_id];
>  		pin->pin = pin_id;
>  		grp->pin_ids[i] = pin_id;
> -- 
> 2.1.4
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150925/fb760c15/attachment.sig>
