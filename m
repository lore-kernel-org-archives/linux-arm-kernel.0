From: l.stach@pengutronix.de (Lucas Stach)
Date: Tue, 04 Apr 2017 11:46:24 +0200
Subject: [PATCH 1/5] ARM: imx: gpc: Do not print error message for
 EPROBE_DEFER
In-Reply-To: <ac58dbed203260f9bb93d7685c8f0e08407e0019.1490987945.git.leonard.crestez@nxp.com>
References: <cover.1490987945.git.leonard.crestez@nxp.com>
 <ac58dbed203260f9bb93d7685c8f0e08407e0019.1490987945.git.leonard.crestez@nxp.com>
Message-ID: <1491299184.2367.12.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, den 31.03.2017, 22:25 +0300 schrieb Leonard Crestez:
> The pu regulator request will return -EPROBE_DEFER if it has a supply
> from PMIC and this supply is not yet registered. This does not represent
> an error since the driver will call probe again later, so only print a
> warning message in this case.
> 
> Signed-off-by: Irina Tirdea <irina.tirdea@nxp.com>
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  arch/arm/mach-imx/gpc.c | 6 +++++-

The driver moved places, together with a large rewrite, to
drivers/soc/imx/.

This issue isn't present in the new driver, so this patch can just be
dropped.

Regards,
Lucas

>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-imx/gpc.c b/arch/arm/mach-imx/gpc.c
> index 1dc2a34..ce64d11 100644
> --- a/arch/arm/mach-imx/gpc.c
> +++ b/arch/arm/mach-imx/gpc.c
> @@ -466,7 +466,11 @@ static int imx_gpc_probe(struct platform_device *pdev)
>  		pu_reg = NULL;
>  	if (IS_ERR(pu_reg)) {
>  		ret = PTR_ERR(pu_reg);
> -		dev_err(&pdev->dev, "failed to get pu regulator: %d\n", ret);
> +		if (ret == -EPROBE_DEFER)
> +			dev_dbg(&pdev->dev, "pu regulator not ready, retry\n");
> +		else
> +			dev_err(&pdev->dev, "failed to get pu regulator: %d\n",
> +					ret);
>  		return ret;
>  	}
>  
