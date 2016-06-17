From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 17 Jun 2016 18:53:54 +0530
Subject: [PATCH] phy: phy-sun4i-usb: Add log when probing
In-Reply-To: <1465818232-29108-1-git-send-email-quentin.schulz@free-electrons.com>
References: <1465818232-29108-1-git-send-email-quentin.schulz@free-electrons.com>
Message-ID: <5763F9EA.20504@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Quentin,

On Monday 13 June 2016 05:13 PM, Quentin Schulz wrote:
> When phy-sun4i-usb's probing fails, it does not print the reason in
> kernel log, forcing the developer to edit this driver to add info logs.
> This commit makes the kernel print the reason of phy-sun4i-usb's probing
> failure or a success message.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
>  drivers/phy/phy-sun4i-usb.c | 28 ++++++++++++++++++++++------
>  1 file changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/phy/phy-sun4i-usb.c b/drivers/phy/phy-sun4i-usb.c
> index 45f01d6..117afa0 100644
> --- a/drivers/phy/phy-sun4i-usb.c
> +++ b/drivers/phy/phy-sun4i-usb.c
> @@ -552,24 +552,32 @@ static int sun4i_usb_phy_probe(struct platform_device *pdev)
>  
>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "phy_ctrl");
>  	data->base = devm_ioremap_resource(dev, res);
> -	if (IS_ERR(data->base))
> +	if (IS_ERR(data->base)) {
> +		dev_err(dev, "Couldn't map our registers\n");

devm_ioremap_resource() itself has error message. So this shouldn't be required.
>  		return PTR_ERR(data->base);
> +	}
>  
>  	data->id_det_gpio = devm_gpiod_get_optional(dev, "usb0_id_det",
>  						    GPIOD_IN);
> -	if (IS_ERR(data->id_det_gpio))
> +	if (IS_ERR(data->id_det_gpio)) {
> +		dev_err(dev, "Couldn't request ID GPIO\n");
>  		return PTR_ERR(data->id_det_gpio);
> +	}
>  
>  	data->vbus_det_gpio = devm_gpiod_get_optional(dev, "usb0_vbus_det",
>  						      GPIOD_IN);
> -	if (IS_ERR(data->vbus_det_gpio))
> +	if (IS_ERR(data->vbus_det_gpio)) {
> +		dev_err(dev, "Couldn't request VBUS detect GPIO\n");
>  		return PTR_ERR(data->vbus_det_gpio);
> +	}
>  
>  	if (of_find_property(np, "usb0_vbus_power-supply", NULL)) {
>  		data->vbus_power_supply = devm_power_supply_get_by_phandle(dev,
>  						     "usb0_vbus_power-supply");
> -		if (IS_ERR(data->vbus_power_supply))
> +		if (IS_ERR(data->vbus_power_supply)) {
> +			dev_err(dev, "Couldn't get the VBUS power supply\n");
>  			return PTR_ERR(data->vbus_power_supply);
> +		}
>  
>  		if (!data->vbus_power_supply)
>  			return -EPROBE_DEFER;
> @@ -584,8 +592,10 @@ static int sun4i_usb_phy_probe(struct platform_device *pdev)
>  	if (data->id_det_gpio) {
>  		data->extcon = devm_extcon_dev_allocate(dev,
>  							sun4i_usb_phy0_cable);
> -		if (IS_ERR(data->extcon))
> +		if (IS_ERR(data->extcon)) {
> +			dev_err(dev, "Couldn't allocate our extcon device\n");
>  			return PTR_ERR(data->extcon);
> +		}
>  
>  		ret = devm_extcon_dev_register(dev, data->extcon);
>  		if (ret) {
> @@ -601,8 +611,12 @@ static int sun4i_usb_phy_probe(struct platform_device *pdev)
>  		snprintf(name, sizeof(name), "usb%d_vbus", i);
>  		phy->vbus = devm_regulator_get_optional(dev, name);
>  		if (IS_ERR(phy->vbus)) {
> -			if (PTR_ERR(phy->vbus) == -EPROBE_DEFER)
> +			if (PTR_ERR(phy->vbus) == -EPROBE_DEFER) {
> +				dev_err(dev, "Couldn't get regulator %s... Deferring probe\n",
> +					name);
>  				return -EPROBE_DEFER;
> +			}
> +
>  			phy->vbus = NULL;

For rest of the API's it's fine.
>  		}
>  
> @@ -690,6 +704,8 @@ static int sun4i_usb_phy_probe(struct platform_device *pdev)
>  		return PTR_ERR(phy_provider);
>  	}
>  
> +	dev_info(dev, "successfully loaded\n");

This will make the boot noisy. Maybe dev_dbg instead?

Thanks
Kishon
