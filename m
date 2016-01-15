From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 15 Jan 2016 08:53:56 +0100
Subject: [PATCH v3] i2c: imx: make bus recovery through pinctrl optional
In-Reply-To: <1452842844-16256-1-git-send-email-leoyang.li@nxp.com>
References: <1452842844-16256-1-git-send-email-leoyang.li@nxp.com>
Message-ID: <20160115075356.GI24441@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, Jan 15, 2016 at 01:27:24AM -0600, Li Yang wrote:
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index a2b132c..1239bfa 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -1081,8 +1081,11 @@ static int i2c_imx_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> +	/* optional bus recovery feature through pinctrl */
>  	i2c_imx->pinctrl = devm_pinctrl_get(&pdev->dev);
> -	if (IS_ERR(i2c_imx->pinctrl)) {
> +	/* bailout on -ENOMEM or -EPROBE_DEFER, continue for other errors */
> +	if (PTR_ERR(i2c_imx->pinctrl) == -ENOMEM ||
> +			PTR_ERR(i2c_imx->pinctrl) == -EPROBE_DEFER) {
>  		ret = PTR_ERR(i2c_imx->pinctrl);
>  		goto clk_disable;
>  	}
> @@ -1125,7 +1128,10 @@ static int i2c_imx_probe(struct platform_device *pdev)
>  			i2c_imx, IMX_I2C_I2CR);
>  	imx_i2c_write_reg(i2c_imx->hwdata->i2sr_clr_opcode, i2c_imx, IMX_I2C_I2SR);
>  
> -	i2c_imx_init_recovery_info(i2c_imx, pdev);
> +	if (IS_ERR_OR_NULL(i2c_imx->pinctrl))

I'd prefer to set i2c_imx->pinctrl to NULL if it's not used and then use

	if (!i2c_imx->pinctrl)

here. (Or maybe make i2c_imx_init_recovery_info aware of this situation
to keep the caller simple?)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
