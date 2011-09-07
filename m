From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 07 Sep 2011 12:47:13 +0200
Subject: [PATCH 1/3] ohci-at91: add vbus_pin_inverted platform attribute
In-Reply-To: <1310549358-13330-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1310549358-13330-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1310549358-13330-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <4E674BB1.8060502@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 13/07/2011 11:29, Thomas Petazzoni :
> The existing OHCI AT91 driver made the assumption that the enable
> input of the USB power switch was active low. However, some USB power
> switches such as the Micrel MIC2026-1 [1] have an active high input to
> enable the power. A new vbus_pin_inverted attribute is added to the
> at91_usbh_data structure so that board files can tell the OHCI driver
> if the vbus pin logic is active low or active high.
> 
> [1] http://www.micrel.com/page.do?page=product-info/products/mic2026.shtml
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Andrew Victor <linux@maxim.org.za>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> ---
>  arch/arm/mach-at91/include/mach/board.h |    1 +
>  drivers/usb/host/ohci-at91.c            |    4 ++--
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/include/mach/board.h b/arch/arm/mach-at91/include/mach/board.h
> index ed544a0..61d52dc 100644
> --- a/arch/arm/mach-at91/include/mach/board.h
> +++ b/arch/arm/mach-at91/include/mach/board.h
> @@ -98,6 +98,7 @@ extern void __init at91_add_device_eth(struct at91_eth_data *data);
>  struct at91_usbh_data {
>  	u8		ports;		/* number of ports on root hub */
>  	u8		vbus_pin[2];	/* port power-control pin */
> +	u8              vbus_pin_inverted;
>  };
>  extern void __init at91_add_device_usbh(struct at91_usbh_data *data);
>  extern void __init at91_add_device_usbh_ohci(struct at91_usbh_data *data);
> diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
> index 944291e..3612ccd 100644
> --- a/drivers/usb/host/ohci-at91.c
> +++ b/drivers/usb/host/ohci-at91.c
> @@ -284,7 +284,7 @@ static int ohci_hcd_at91_drv_probe(struct platform_device *pdev)
>  			if (pdata->vbus_pin[i] <= 0)
>  				continue;
>  			gpio_request(pdata->vbus_pin[i], "ohci_vbus");
> -			gpio_direction_output(pdata->vbus_pin[i], 0);
> +			gpio_direction_output(pdata->vbus_pin[i], pdata->vbus_pin_inverted);
>  		}
>  	}
>  
> @@ -301,7 +301,7 @@ static int ohci_hcd_at91_drv_remove(struct platform_device *pdev)
>  		for (i = 0; i < ARRAY_SIZE(pdata->vbus_pin); i++) {
>  			if (pdata->vbus_pin[i] <= 0)
>  				continue;
> -			gpio_direction_output(pdata->vbus_pin[i], 1);
> +			gpio_direction_output(pdata->vbus_pin[i], !pdata->vbus_pin_inverted);
>  			gpio_free(pdata->vbus_pin[i]);
>  		}
>  	}


-- 
Nicolas Ferre
