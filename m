From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 9 Oct 2013 09:34:23 +0200
Subject: [PATCH 2/9] i2c: i2c-imx: replace platform_driver_probe to
 support deferred probing
In-Reply-To: <1381264542-29396-3-git-send-email-wsa@the-dreams.de>
References: <1381264542-29396-1-git-send-email-wsa@the-dreams.de>
 <1381264542-29396-3-git-send-email-wsa@the-dreams.de>
Message-ID: <20131009073423.GS10079@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 08, 2013 at 10:35:34PM +0200, Wolfram Sang wrote:
> Subsystems like pinctrl and gpio rightfully make use of deferred probing at
> core level. Now, deferred drivers won't be retried if they don't have a .probe
> function specified in the driver struct. Fix this driver to have that, so the
> devices it supports won't get lost in a deferred probe.
> 
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> Cc: kernel at pengutronix.de
Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

> ---
>  drivers/i2c/busses/i2c-imx.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index ccf4665..1d7efa3 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -365,7 +365,7 @@ static void i2c_imx_stop(struct imx_i2c_struct *i2c_imx)
>  	clk_disable_unprepare(i2c_imx->clk);
>  }
>  
> -static void __init i2c_imx_set_clk(struct imx_i2c_struct *i2c_imx,
> +static void i2c_imx_set_clk(struct imx_i2c_struct *i2c_imx,
>  							unsigned int rate)
>  {
>  	struct imx_i2c_clk_pair *i2c_clk_div = i2c_imx->hwdata->clk_div;
> @@ -589,7 +589,7 @@ static struct i2c_algorithm i2c_imx_algo = {
>  	.functionality	= i2c_imx_func,
>  };
>  
> -static int __init i2c_imx_probe(struct platform_device *pdev)
> +static int i2c_imx_probe(struct platform_device *pdev)
>  {
>  	const struct of_device_id *of_id = of_match_device(i2c_imx_dt_ids,
>  							   &pdev->dev);
> @@ -697,7 +697,7 @@ static int __init i2c_imx_probe(struct platform_device *pdev)
>  	return 0;   /* Return OK */
>  }
>  
> -static int __exit i2c_imx_remove(struct platform_device *pdev)
> +static int i2c_imx_remove(struct platform_device *pdev)
>  {
>  	struct imx_i2c_struct *i2c_imx = platform_get_drvdata(pdev);
>  
> @@ -715,7 +715,8 @@ static int __exit i2c_imx_remove(struct platform_device *pdev)
>  }
>  
>  static struct platform_driver i2c_imx_driver = {
> -	.remove		= __exit_p(i2c_imx_remove),
> +	.probe = i2c_imx_probe,
> +	.remove = i2c_imx_remove,
>  	.driver	= {
>  		.name	= DRIVER_NAME,
>  		.owner	= THIS_MODULE,
> @@ -726,7 +727,7 @@ static struct platform_driver i2c_imx_driver = {
>  
>  static int __init i2c_adap_imx_init(void)
>  {
> -	return platform_driver_probe(&i2c_imx_driver, i2c_imx_probe);
> +	return platform_driver_register(&i2c_imx_driver);
>  }
>  subsys_initcall(i2c_adap_imx_init);
>  
> -- 
> 1.8.4.rc3
> 
> 

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
