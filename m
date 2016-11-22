From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 22 Nov 2016 16:05:16 +0530
Subject: [RESEND PATCH 1/3] ARM: davinci: da830: Handle vbus with a
 regulator
In-Reply-To: <20161121165349.29128-2-ahaslam@baylibre.com>
References: <20161121165349.29128-1-ahaslam@baylibre.com>
 <20161121165349.29128-2-ahaslam@baylibre.com>
Message-ID: <fad5d7af-3f54-020e-c037-0a46bc88c39d@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 21 November 2016 10:23 PM, Axel Haslam wrote:

>  static __init void da830_evm_usb_init(void)
>  {
> @@ -145,23 +123,13 @@ static __init void da830_evm_usb_init(void)
>  		return;
>  	}
>  
> -	ret = gpio_request(ON_BD_USB_DRV, "ON_BD_USB_DRV");
> -	if (ret) {
> -		pr_err("%s: failed to request GPIO for USB 1.1 port power control: %d\n",
> -		       __func__, ret);
> -		return;
> -	}
> -	gpio_direction_output(ON_BD_USB_DRV, 0);
> +	gpiod_add_lookup_table(&usb11_gpios_table);
>  
> -	ret = gpio_request(ON_BD_USB_OVC, "ON_BD_USB_OVC");
> -	if (ret) {
> -		pr_err("%s: failed to request GPIO for USB 1.1 port over-current indicator: %d\n",
> -		       __func__, ret);
> -		return;
> -	}
> -	gpio_direction_input(ON_BD_USB_OVC);
> +	ret = platform_device_register(&da8xx_usb11_regulator);
> +	if (ret)
> +		pr_warn("fail to add ohci regulator\n");

Can you follow the same style as used in other error/warning messages in
this function (adding a function name prefix, printing of error code).

Thanks,
Sekhar
