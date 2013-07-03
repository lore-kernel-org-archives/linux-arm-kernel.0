From: balbi@ti.com (Felipe Balbi)
Date: Wed, 3 Jul 2013 17:13:32 +0300
Subject: [PATCH v3 2/8] wlcore: set irq_flags in the board files instead
 of hiding behind a quirk
In-Reply-To: <1372860209-3504-3-git-send-email-coelho@ti.com>
References: <1372860209-3504-1-git-send-email-coelho@ti.com>
 <1372860209-3504-3-git-send-email-coelho@ti.com>
Message-ID: <20130703141332.GO15056@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jul 03, 2013 at 05:03:23PM +0300, Luciano Coelho wrote:
> diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
> index 56a9a4f..953f620 100644
> --- a/arch/arm/mach-omap2/board-4430sdp.c
> +++ b/arch/arm/mach-omap2/board-4430sdp.c
> @@ -703,12 +703,30 @@ static void __init omap4_sdp4430_wifi_init(void)
>  
>  	omap4_sdp4430_wifi_mux_init();
>  	omap4_sdp4430_wlan_data.irq = gpio_to_irq(GPIO_WIFI_IRQ);
> +
> +	ret = gpio_request_one(GPIO_WIFI_IRQ, GPIOF_IN, "GPIO_WIFI_IRQ");
> +	if (ret) {
> +		pr_err("error requesting wl12xx gpio: %d\n", ret);
> +		goto out;
> +	}
> +
> +	ret = irq_set_irq_type(gpio_to_irq(GPIO_WIFI_IRQ), IRQ_TYPE_LEVEL_HIGH);
> +	if (ret) {
> +		pr_err("error setting wl12xx irq type: %d\n", ret);
> +		goto free;
> +	}
> +
>  	ret = wl12xx_set_platform_data(&omap4_sdp4430_wlan_data);
>  	if (ret)
>  		pr_err("Error setting wl12xx data: %d\n", ret);
> +
>  	ret = platform_device_register(&omap_vwlan_device);
>  	if (ret)
>  		pr_err("Error registering wl12xx device: %d\n", ret);
> +out:
> +	return;
> +free:
> +	gpio_free(GPIO_WIFI_IRQ);

actually, you should leave this GPIO requested in order to use it as
IRQ.

ditto for all others

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130703/6376cbe3/attachment-0001.sig>
