From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Thu, 28 Jun 2012 19:33:28 +0800
Subject: [PATCH v2 2/2] net: flexcan: add transceiver switch gpios support
In-Reply-To: <1340853701-4488-3-git-send-email-shawn.guo@linaro.org>
References: <1340853701-4488-1-git-send-email-shawn.guo@linaro.org>
 <1340853701-4488-3-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120628113327.GJ6406@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 28, 2012 at 11:21:41AM +0800, Shawn Guo wrote:
> The flexcan driver has function pointer transceiver_switch defined in
> flexcan_platform_data for platform codes to hook up their transceiver
> switch implementation.  However this does not cope with device tree
> probe.
> 
> It's been observed that platforms mostly use gpios to control the
> switch of flexcan transceiver, like enable and standby.  The patch
> adds transceiver switch gpios support into flexcan driver, so that
> platforms booting from device tree can just define properties
> phy-enable-gpios and phy-standby-gpios to have flexcan driver control
> the gpios.
Hmm, ideally these things are not so suitable to be put in controller driver
since they're platform specific.
However i also did not have better idea now.

One rough thought is maybe create a supported can phy libs and hook to controller
dynamically?

> +		phy_stby_gpio = of_get_named_gpio_flags(pdev->dev.of_node,
> +							"phy-standby-gpios",
> +							0, &flags);
> +		if (gpio_is_valid(phy_stby_gpio)) {
> +			if (flags == OF_GPIO_ACTIVE_LOW)
> +				phy_stby_high = false;
> +			err = devm_gpio_request_one(&pdev->dev, phy_stby_gpio,
> +						    GPIOF_DIR_OUT,
> +						    "phy-standby");
> +			if (err) {
> +				dev_err(&pdev->dev,
> +					"failed to request gpio %d: %d\n",
> +					phy_stby_gpio, err);
> +				goto failed_gpio;
I checked mx28 evk, it seems the phy only has a STB gpio and shared by both CAN0&CAN1.
I wonder the CAN1 probe may fail here.

> +			}
> +		}
>  	}
>  
>  	if (!clock_freq) {
> @@ -997,6 +1054,10 @@ static int __devinit flexcan_probe(struct platform_device *pdev)
>  	priv->base = base;
>  	priv->dev = dev;
>  	priv->clk = clk;
> +	priv->phy_en_gpio = phy_en_gpio;
> +	priv->phy_en_high = phy_en_high;
> +	priv->phy_stby_gpio = phy_stby_gpio;
> +	priv->phy_stby_high = phy_stby_high;
>  	priv->pdata = pdev->dev.platform_data;
>  
>  	netif_napi_add(dev, &priv->napi, flexcan_poll, FLEXCAN_NAPI_WEIGHT);
> @@ -1025,6 +1086,7 @@ static int __devinit flexcan_probe(struct platform_device *pdev)
>  	if (clk)
>  		clk_put(clk);
>   failed_clock:
> + failed_gpio:
>  	return err;
>  }
>  

Regards
Dong Aisheng
