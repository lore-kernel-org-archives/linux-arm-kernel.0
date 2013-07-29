From: mgr@pengutronix.de (Michael Grzeschik)
Date: Tue, 30 Jul 2013 00:30:25 +0200
Subject: [PATCH v13 02/14] usb: chipidea: imx: remove vbus regulator
 operation
In-Reply-To: <1374830310-21765-3-git-send-email-peter.chen@freescale.com>
References: <1374830310-21765-1-git-send-email-peter.chen@freescale.com>
 <1374830310-21765-3-git-send-email-peter.chen@freescale.com>
Message-ID: <20130729223025.GA7109@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On Fri, Jul 26, 2013 at 05:18:18PM +0800, Peter Chen wrote:
> Since we have added vbus reguatlor operation at common
> host file (chipidea/host.c), the glue layer vbus operation
> isn't needed any more.
> 
> Tested-by: Marek Vasut <marex@denx.de>
> Signed-off-by: Peter Chen <peter.chen@freescale.com>
> ---
>  drivers/usb/chipidea/ci_hdrc_imx.c |   30 +++++++-----------------------
>  1 files changed, 7 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
> index 14362c0..d06355e 100644
> --- a/drivers/usb/chipidea/ci_hdrc_imx.c
> +++ b/drivers/usb/chipidea/ci_hdrc_imx.c
> @@ -31,7 +31,6 @@ struct ci_hdrc_imx_data {
>  	struct usb_phy *phy;
>  	struct platform_device *ci_pdev;
>  	struct clk *clk;
> -	struct regulator *reg_vbus;
>  };
>  
>  static const struct usbmisc_ops *usbmisc_ops;
> @@ -141,22 +140,13 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
>  		goto err_clk;
>  	}
>  
> -	/* we only support host now, so enable vbus here */
> -	data->reg_vbus = devm_regulator_get(&pdev->dev, "vbus");
> -	if (!IS_ERR(data->reg_vbus)) {
> -		ret = regulator_enable(data->reg_vbus);
> -		if (ret) {
> -			dev_err(&pdev->dev,
> -				"Failed to enable vbus regulator, err=%d\n",
> -				ret);
> -			goto err_clk;
> -		}
> -	} else {
> -		data->reg_vbus = NULL;
> -	}
> -
>  	pdata.phy = data->phy;
>  
> +	/* Get the vbus regulator */
> +	pdata.reg_vbus = devm_regulator_get(&pdev->dev, "vbus");
> +	if (IS_ERR(pdata.reg_vbus))
> +		pdata.reg_vbus = NULL;
> +

This hunk needs the reg_vbus variable from the previous patch, therefor
it should also be added in that patch. As the user of the variable is
the previous patch, it's the reason to swap their order.

Anyway, can't this be done in core.c instead? I don't see why other
users don't need this code.

>  	if (!pdev->dev.dma_mask)
>  		pdev->dev.dma_mask = &pdev->dev.coherent_dma_mask;
>  	if (!pdev->dev.coherent_dma_mask)
> @@ -167,7 +157,7 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
>  		if (ret) {
>  			dev_err(&pdev->dev,
>  				"usbmisc init failed, ret=%d\n", ret);
> -			goto err;
> +			goto err_clk;
>  		}
>  	}
>  
> @@ -179,7 +169,7 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
>  		dev_err(&pdev->dev,
>  			"Can't register ci_hdrc platform device, err=%d\n",
>  			ret);
> -		goto err;
> +		goto err_clk;
>  	}
>  
>  	if (usbmisc_ops && usbmisc_ops->post) {
> @@ -200,9 +190,6 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
>  
>  disable_device:
>  	ci_hdrc_remove_device(data->ci_pdev);
> -err:
> -	if (data->reg_vbus)
> -		regulator_disable(data->reg_vbus);
>  err_clk:
>  	clk_disable_unprepare(data->clk);
>  	return ret;
> @@ -215,9 +202,6 @@ static int ci_hdrc_imx_remove(struct platform_device *pdev)
>  	pm_runtime_disable(&pdev->dev);
>  	ci_hdrc_remove_device(data->ci_pdev);
>  
> -	if (data->reg_vbus)
> -		regulator_disable(data->reg_vbus);
> -
>  	if (data->phy) {
>  		usb_phy_shutdown(data->phy);
>  		module_put(data->phy->dev->driver->owner);
> -- 
> 1.7.0.4
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
