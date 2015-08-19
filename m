From: mpa@pengutronix.de (Markus Pargmann)
Date: Wed, 19 Aug 2015 08:12:11 +0200
Subject: [PATCH 7/8] pinctrl: freescale: imx: fix flat functions default
 return
In-Reply-To: <1439912939-17535-7-git-send-email-aalonso@freescale.com>
References: <1439912939-17535-1-git-send-email-aalonso@freescale.com>
 <1439912939-17535-7-git-send-email-aalonso@freescale.com>
Message-ID: <20150819061211.GG11161@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 18, 2015 at 10:48:58AM -0500, Adrian Alonso wrote:
> Fix imx pinctrl dt flat functions default return value.
> If property fsl,pins is not found in function_np and
> pinctrl_np return false to indicate that DT is not using
> flat functions.

The for loop in this function checks the child nodes and the child's
child nodes. Therefore if we exit the for loop we didn't find any nodes
on any level with the 'fsl,pins' property.

So this 'default' return value is never used unless there is no fsl,pins
property anywhere. So this return value is not important but I wrote
true because we want to use the new flat dt option as default. The extra
indention doesn't make sense anymore.

Regards,

Markus

> 
> Signed-off-by: Adrian Alonso <aalonso@freescale.com>
> ---
>  drivers/pinctrl/freescale/pinctrl-imx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/freescale/pinctrl-imx.c b/drivers/pinctrl/freescale/pinctrl-imx.c
> index 1009b52..3e02887 100644
> --- a/drivers/pinctrl/freescale/pinctrl-imx.c
> +++ b/drivers/pinctrl/freescale/pinctrl-imx.c
> @@ -641,7 +641,7 @@ static bool imx_pinctrl_dt_is_flat_functions(struct device_node *np)
>  		}
>  	}
>  
> -	return true;
> +	return false;
>  }
>  
>  static int imx_pinctrl_probe_dt(struct platform_device *pdev,
> -- 
> 2.1.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150819/6a97a423/attachment.sig>
