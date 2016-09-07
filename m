From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 7 Sep 2016 20:09:43 +0200
Subject: [PATCH v6] i2c: imx: make bus recovery through pinctrl optional
In-Reply-To: <1473267796-10403-1-git-send-email-leoyang.li@nxp.com>
References: <1473267796-10403-1-git-send-email-leoyang.li@nxp.com>
Message-ID: <20160907180943.ia3pjqq4dynzuxvm@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, Sep 07, 2016 at 12:03:16PM -0500, Li Yang wrote:
> Since commit 1c4b6c3bcf30 ("i2c: imx: implement bus recovery") the
> driver starts to use gpio/pinctrl to do i2c bus recovery.  But pinctrl
> is not always available for platforms with this controller such as
> ls1021a and ls1043a, and the device tree binding also mentioned this
> gpio based recovery mechanism as optional.  The patch makes it really
> optional that the probe function won't bailout but just disable the
> bus recovery function when pinctrl is not usable.
> 
> Signed-off-by: Li Yang <leoyang.li@nxp.com>
> Cc: Gao Pan <pandy.gao@nxp.com>
> Cc: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> v6:
> Update code comment
> 
> v5:
> Revert the last minute change of recovery info initialization timing, it
> will cause problem if initialized after i2c_add_numbered_adapter()
> 
> v4:
> Remove the use of IS_ERR_OR_NULL
> Move the condition judgement to i2c_imx_init_recovery_info()
> Change the timing of recovery initialization to be after bus registration
> 
> v3:
> Rebased to Wolfram's for-next branch
> Added acked-by from Linus Walleij
> Update to use new nxp email addresses due to company merge
> 
>  drivers/i2c/busses/i2c-imx.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index 1844bc9..f52ff47 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -989,6 +989,14 @@ static void i2c_imx_init_recovery_info(struct imx_i2c_struct *i2c_imx,
>  {
>  	struct i2c_bus_recovery_info *rinfo = &i2c_imx->rinfo;
>  
> +	/* If pinctrl is not available disable bus recovery */
> +	if (IS_ERR(i2c_imx->pinctrl))
> +		i2c_imx->pinctrl = NULL;

I still prefer to do this in i2c_imx_probe to have a single place that
assignes to i2c_imx->pinctrl.

> +	if (!i2c_imx->pinctrl) {
> +		dev_info(&pdev->dev, "can't get pinctrl, bus recovery not supported\n");
> +		return;
> +	}
> +
>  	i2c_imx->pinctrl_pins_default = pinctrl_lookup_state(i2c_imx->pinctrl,
>  			PINCTRL_STATE_DEFAULT);
>  	i2c_imx->pinctrl_pins_gpio = pinctrl_lookup_state(i2c_imx->pinctrl,
> @@ -1081,8 +1089,19 @@ static int i2c_imx_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> +	/*
> +	 * If pinctrl is available it might be possible to switch the
> +	 * SDA and SCL lines to their GPIO functions and do a recovery
> +	 * procedure in this mode. If there is anything wrong with
> +	 * pinctrl we cannot do this and simply not enable it.
> +	 */
>  	i2c_imx->pinctrl = devm_pinctrl_get(&pdev->dev);
> -	if (IS_ERR(i2c_imx->pinctrl)) {
> +	/*
> +	 * Bailout on critical errors, continue for other errors.
> +	 * Bus recovery will not be enabled if pinctrl is not available.
> +	 */
> +	if (PTR_ERR(i2c_imx->pinctrl) == -ENOMEM ||
> +			PTR_ERR(i2c_imx->pinctrl) == -EPROBE_DEFER) {
>  		ret = PTR_ERR(i2c_imx->pinctrl);
>  		goto clk_disable;

I'd not call EPROBE_DEFER a critical error. Maybe only handle this and
also ignore ENOMEM? You argued that ENOMEM might affect the i2c driver,
too. I'd say it's worth to try that because not enough memory might also
happen because pinctrl_get asked for a too big chunk.

>  	}
> @@ -1125,6 +1144,7 @@ static int i2c_imx_probe(struct platform_device *pdev)
>  			i2c_imx, IMX_I2C_I2CR);
>  	imx_i2c_write_reg(i2c_imx->hwdata->i2sr_clr_opcode, i2c_imx, IMX_I2C_I2SR);
>  
> +	/* Init bus recovery info if supported */
>  	i2c_imx_init_recovery_info(i2c_imx, pdev);
>  
>  	/* Add I2C adapter */

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
