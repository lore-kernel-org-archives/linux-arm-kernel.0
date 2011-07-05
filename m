From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Tue, 05 Jul 2011 15:39:18 +0400
Subject: [PATCH 1/3] ohci-at91: add vbus_pin_inverted platform attribute
In-Reply-To: <1309856728-8265-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1309856728-8265-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <4E12F7E6.7080604@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 05-07-2011 13:05, Thomas Petazzoni wrote:

> The existing OHCI AT91 driver made the assumption that the enable
> input of the USB power switch was active low. However, some USB power
> switches such as the Micrel MIC2026-1 [1] have an active high input to
> enable the power. A new vbus_pin_inverted attribute is added to the
> at91_usbh_data structure so that board files can tell the OHCI driver
> if the vbus pin logic is active low or active high.

> [1] http://www.micrel.com/page.do?page=product-info/products/mic2026.shtml

> Signed-off-by: Thomas Petazzoni<thomas.petazzoni@free-electrons.com>
> Cc: Andrew Victor<linux@maxim.org.za>
> Cc: Nicolas Ferre<nicolas.ferre@atmel.com>
> Cc: Jean-Christophe Plagniol-Villard<plagnioj@jcrosoft.com>
[...]

> diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
> index 944291e..52e50ba 100644
> --- a/drivers/usb/host/ohci-at91.c
> +++ b/drivers/usb/host/ohci-at91.c
> @@ -284,7 +284,7 @@ static int ohci_hcd_at91_drv_probe(struct platform_device *pdev)
>   			if (pdata->vbus_pin[i]<= 0)
>   				continue;
>   			gpio_request(pdata->vbus_pin[i], "ohci_vbus");
> -			gpio_direction_output(pdata->vbus_pin[i], 0);
> +			gpio_direction_output(pdata->vbus_pin[i], 0 ^ pdata->vbus_pin_inverted);

    Why not simply 'pdata->vbus_pin_inverted'?

>   		}
>   	}
>
> @@ -301,7 +301,7 @@ static int ohci_hcd_at91_drv_remove(struct platform_device *pdev)
>   		for (i = 0; i<  ARRAY_SIZE(pdata->vbus_pin); i++) {
>   			if (pdata->vbus_pin[i]<= 0)
>   				continue;
> -			gpio_direction_output(pdata->vbus_pin[i], 1);
> +			gpio_direction_output(pdata->vbus_pin[i], 1 ^ pdata->vbus_pin_inverted);

    Why not simply '!pdata->vbus_pin_inverted'?

WBR, Sergei
