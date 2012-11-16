From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Fri, 16 Nov 2012 14:06:46 +0200
Subject: [PATCH 3/9] usb: chipidea: ci13xxx-imx: create dynamic
 platformdata
In-Reply-To: <1352909950-32555-4-git-send-email-m.grzeschik@pengutronix.de>
References: <1352909950-32555-1-git-send-email-m.grzeschik@pengutronix.de>
 <1352909950-32555-4-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <8762557nvt.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Michael Grzeschik <m.grzeschik@pengutronix.de> writes:

> This patch removes the limitation of having only one instance of the
> ci13xxx-imx platformdata and makes different configurations possible.
>
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  drivers/usb/chipidea/ci13xxx_imx.c |   27 ++++++++++++++++-----------
>  1 file changed, 16 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/usb/chipidea/ci13xxx_imx.c b/drivers/usb/chipidea/ci13xxx_imx.c
> index 570aedf..7b99c96 100644
> --- a/drivers/usb/chipidea/ci13xxx_imx.c
> +++ b/drivers/usb/chipidea/ci13xxx_imx.c
> @@ -87,15 +87,6 @@ EXPORT_SYMBOL_GPL(usbmisc_get_init_data);
>  
>  /* End of common functions shared by usbmisc drivers*/
>  
> -static struct ci13xxx_platform_data ci13xxx_imx_platdata __devinitdata  = {
> -	.name			= "ci13xxx_imx",
> -	.flags			= CI13XXX_REQUIRE_TRANSCEIVER |
> -				  CI13XXX_PULLUP_ON_VBUS |
> -				  CI13XXX_DISABLE_STREAMING |
> -				  CI13XXX_REGS_SHARED,
> -	.capoffset		= DEF_CAPOFFSET,
> -};
> -
>  static int ci13xxx_otg_set_vbus(struct usb_otg *otg, bool enabled)
>  {
>  
> @@ -117,6 +108,7 @@ static int ci13xxx_otg_set_vbus(struct usb_otg *otg, bool enabled)
>  static int __devinit ci13xxx_imx_probe(struct platform_device *pdev)
>  {
>  	struct ci13xxx_imx_data *data;
> +	struct ci13xxx_platform_data *pdata;
>  	struct platform_device *plat_ci, *phy_pdev;
>  	struct ci13xxx	*ci;
>  	struct device_node *phy_np;
> @@ -129,6 +121,19 @@ static int __devinit ci13xxx_imx_probe(struct platform_device *pdev)
>  		&& !usbmisc_ops)
>  		return -EPROBE_DEFER;
>  
> +	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
> +	if (!pdata) {
> +		dev_err(&pdev->dev, "Failed to allocate CI13xxx-IMX pdata!\n");
> +		return -ENOMEM;
> +	}
> +
> +	pdata->name = "ci13xxx_imx";
> +	pdata->capoffset = DEF_CAPOFFSET;
> +	pdata->flags = CI13XXX_REQUIRE_TRANSCEIVER |
> +		       CI13XXX_PULLUP_ON_VBUS |
> +		       CI13XXX_DISABLE_STREAMING |
> +		       CI13XXX_REGS_SHARED,

Btw, I think you want to use semicolon instead of comma here.

> +
>  	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
