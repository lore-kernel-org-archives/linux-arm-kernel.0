From: nm@ti.com (Nishanth Menon)
Date: Thu, 2 May 2013 11:24:33 -0500
Subject: [PATCH] ARM: OMAP-USB: Fix possible memory leak
In-Reply-To: <1367510596-27780-1-git-send-email-shc_work@mail.ru>
References: <1367510596-27780-1-git-send-email-shc_work@mail.ru>
Message-ID: <20130502162433.GA10016@kahuna>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20:03-20130502, Alexander Shiyan wrote:
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  arch/arm/mach-omap2/usb-host.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/usb-host.c b/arch/arm/mach-omap2/usb-host.c
> index aa27d7f..8d17a0d 100644
> --- a/arch/arm/mach-omap2/usb-host.c
> +++ b/arch/arm/mach-omap2/usb-host.c
> @@ -570,8 +570,10 @@ static int usbhs_add_regulator(char *name, char *dev_id, char *dev_supply,
>  	supplies->dev_name = dev_id;
>  
>  	reg_data = kzalloc(sizeof(*reg_data), GFP_KERNEL);
> -	if (!reg_data)
> +	if (!reg_data) {
> +		kfree(supplies);
>  		return -ENOMEM;
> +	}
>  
>  	reg_data->constraints.valid_ops_mask = REGULATOR_CHANGE_STATUS;
>  	reg_data->consumer_supplies = supplies;
> @@ -579,8 +581,11 @@ static int usbhs_add_regulator(char *name, char *dev_id, char *dev_supply,
>  
>  	config = kmemdup(&hsusb_reg_config, sizeof(hsusb_reg_config),
>  			GFP_KERNEL);
> -	if (!config)
> +	if (!config) {
> +		kfree(supplies);
> +		kfree(reg_data);
>  		return -ENOMEM;
> +	}
>  
>  	config->supply_name = name;
>  	config->gpio = gpio;
> @@ -589,17 +594,25 @@ static int usbhs_add_regulator(char *name, char *dev_id, char *dev_supply,
>  
>  	/* create a regulator device */
>  	pdev = kzalloc(sizeof(*pdev), GFP_KERNEL);
> -	if (!pdev)
> +	if (!pdev) {
> +		kfree(supplies);
> +		kfree(reg_data);
> +		kfree(config);
>  		return -ENOMEM;
> +	}
>  
>  	pdev->id = PLATFORM_DEVID_AUTO;
>  	pdev->name = reg_name;
>  	pdev->dev.platform_data = config;
>  
>  	ret = platform_device_register(pdev);
> -	if (ret)
> +	if (ret) {
>  		pr_err("%s: Failed registering regulator %s for %s\n",
>  				__func__, name, dev_id);
> +		kfree(supplies);
> +		kfree(reg_data);
> +		kfree(config);
> +	}

Might be better to switch to devm_XXX managed functions?
>  
>  	return ret;
>  }
> -- 
> 1.8.1.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Regards,
Nishanth Menon
