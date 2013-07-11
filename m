From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 11 Jul 2013 08:37:19 +0200
Subject: [PATCH v12 02/13] usb: chipidea: imx: remove vbus regulator
 operation
In-Reply-To: <1373524041-10482-3-git-send-email-peter.chen@freescale.com>
References: <1373524041-10482-1-git-send-email-peter.chen@freescale.com>
 <1373524041-10482-3-git-send-email-peter.chen@freescale.com>
Message-ID: <20130711063719.GE14452@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 11, 2013 at 02:27:10PM +0800, Peter Chen wrote:
> Since we have added vbus reguatlor operation at common
> host file (chipidea/host.c), the glue layer vbus operation
> isn't needed any more.
> 
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

I think you should bail out at least in the -EPROBE_DEFER case.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
