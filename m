From: peter.chen@freescale.com (Peter Chen)
Date: Mon, 26 Nov 2012 17:29:31 +0800
Subject: [PATCH 2/9] usb: chipidea: ci13xxx_imx: add 2nd and 3rd clock
 to support imx5x and newer
In-Reply-To: <1352909950-32555-3-git-send-email-m.grzeschik@pengutronix.de>
References: <1352909950-32555-1-git-send-email-m.grzeschik@pengutronix.de>
 <1352909950-32555-3-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <20121126092931.GA15740@nchen-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 14, 2012 at 05:19:03PM +0100, Michael Grzeschik wrote:
> This patch adds support for a second and third clock to the chipidea driver. On
> modern freescale ARM cores like the imx51, imx53 and imx6q three clocks ("ahb",
> "ipg" and "per") must be enabled in order to access the USB core.
> 
> In the original driver, the clock was requested without specifying the
> connection id, further all mainline ARM archs with support for the chipidea
> core (imx23, imx28) register their USB clock without a connection id.
> 
> This patch first renames the existing clk variable to clk_ahb. The connection
> id "ahb" is added to the devm_clk_get() call. Then the clocks "ipg" and "per"
> are requested. As all archs don't specify a connection id, all clk_get return
> the same clock. This ensures compatibility to existing USB support and adds
> support for imx5x at the same time.
> 
> This patch has been tested on imx28 and on imx53 with seperate "ahb", "ipg"
> and "per" clocks.
mx23, mx28, and mx6q has the same usb clock sources and different with
mxc (mx5x, mx3x).

I am not sure which method is better:
- Add dummy clock at clock.c
- Add platform information(id_table or something similar) at driver.

Add dummy clock may confuse some users, for example, mx6q has no
"per" and "ipg" clock at all.
> 
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  drivers/usb/chipidea/ci13xxx_imx.c |   54 ++++++++++++++++++++++++++++++------
>  1 file changed, 45 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/usb/chipidea/ci13xxx_imx.c b/drivers/usb/chipidea/ci13xxx_imx.c
> index 935de97..570aedf 100644
> --- a/drivers/usb/chipidea/ci13xxx_imx.c
> +++ b/drivers/usb/chipidea/ci13xxx_imx.c
> @@ -32,7 +32,9 @@ struct ci13xxx_imx_data {
>  	struct device_node *phy_np;
>  	struct usb_phy *phy;
>  	struct platform_device *ci_pdev;
> -	struct clk *clk;
> +	struct clk *clk_ahb;
> +	struct clk *clk_ipg;
> +	struct clk *clk_per;
>  	struct regulator *reg_vbus;
>  };
>  
> @@ -144,20 +146,48 @@ static int __devinit ci13xxx_imx_probe(struct platform_device *pdev)
>  		dev_warn(&pdev->dev, "pinctrl get/select failed, err=%ld\n",
>  			PTR_ERR(pinctrl));
>  
> -	data->clk = devm_clk_get(&pdev->dev, NULL);
> -	if (IS_ERR(data->clk)) {
> +	data->clk_ahb = devm_clk_get(&pdev->dev, "ahb");
> +	if (IS_ERR(data->clk_ahb)) {
>  		dev_err(&pdev->dev,
> -			"Failed to get clock, err=%ld\n", PTR_ERR(data->clk));
> -		return PTR_ERR(data->clk);
> +			"Failed to get ahb clock, err=%ld\n", PTR_ERR(data->clk_ahb));
> +		return PTR_ERR(data->clk_ahb);
>  	}
>  
> -	ret = clk_prepare_enable(data->clk);
> +	data->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
> +	if (IS_ERR(data->clk_ipg)) {
> +		dev_err(&pdev->dev,
> +			"Failed to get ipg clock, err=%ld\n", PTR_ERR(data->clk_ipg));
> +		return PTR_ERR(data->clk_ipg);
> +	}
> +
> +	data->clk_per = devm_clk_get(&pdev->dev, "per");
> +	if (IS_ERR(data->clk_per)) {
> +		dev_err(&pdev->dev,
> +			"Failed to get per clock, err=%ld\n", PTR_ERR(data->clk_per));
> +		return PTR_ERR(data->clk_per);
> +	}
> +
> +	ret = clk_prepare_enable(data->clk_ahb);
>  	if (ret) {
>  		dev_err(&pdev->dev,
> -			"Failed to prepare or enable clock, err=%d\n", ret);
> +			"Failed to prepare or enable ahb clock, err=%d\n", ret);
>  		return ret;
>  	}
>  
> +	ret = clk_prepare_enable(data->clk_ipg);
> +	if (ret) {
> +		dev_err(&pdev->dev,
> +			"Failed to prepare or enable ipg clock, err=%d\n", ret);
> +		goto err_ipg_failed;
> +	}
> +
> +	ret = clk_prepare_enable(data->clk_per);
> +	if (ret) {
> +		dev_err(&pdev->dev,
> +			"Failed to prepare or enable per clock, err=%d\n", ret);
> +		goto err_per_failed;
> +	}
> +
>  	phy_np = of_parse_phandle(pdev->dev.of_node, "fsl,usbphy", 0);
>  	if (phy_np) {
>  		data->phy_np = phy_np;
> @@ -246,7 +276,11 @@ static int __devinit ci13xxx_imx_probe(struct platform_device *pdev)
>  put_np:
>  	if (phy_np)
>  		of_node_put(phy_np);
> -	clk_disable_unprepare(data->clk);
> +	clk_disable_unprepare(data->clk_per);
> +err_per_failed:
> +	clk_disable_unprepare(data->clk_ipg);
> +err_ipg_failed:
> +	clk_disable_unprepare(data->clk_ahb);
>  
>  	return ret;
>  }
> @@ -268,7 +302,9 @@ static int __devexit ci13xxx_imx_remove(struct platform_device *pdev)
>  
>  	of_node_put(data->phy_np);
>  
> -	clk_disable_unprepare(data->clk);
> +	clk_disable_unprepare(data->clk_per);
> +	clk_disable_unprepare(data->clk_ipg);
> +	clk_disable_unprepare(data->clk_ahb);
>  
>  	platform_set_drvdata(pdev, NULL);
>  
> -- 
> 1.7.10.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 

Best Regards,
Peter Chen
