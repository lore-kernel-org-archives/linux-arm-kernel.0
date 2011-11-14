From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 14 Nov 2011 11:57:50 +0100
Subject: [PATCH] at91: at91-ohci: fix set/get power
In-Reply-To: <1321112773-8360-1-git-send-email-plagnioj@jcrosoft.com>
References: <1321112773-8360-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <4EC0F42E.3000808@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/12/2011 04:46 PM, Jean-Christophe PLAGNIOL-VILLARD :
> in commit aa6e52a35 we introduce the support of overcurrent notification
> but the set and get of the power without checking if the gpio is valid or not
> 
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
>  drivers/usb/host/ohci-at91.c |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
> index ba3a46b..95a9fec 100644
> --- a/drivers/usb/host/ohci-at91.c
> +++ b/drivers/usb/host/ohci-at91.c
> @@ -223,6 +223,9 @@ static void ohci_at91_usb_set_power(struct at91_usbh_data *pdata, int port, int
>  	if (port < 0 || port >= 2)
>  		return;
>  
> +	if (pdata->vbus_pin[port] <= 0)
> +		return;
> +
>  	gpio_set_value(pdata->vbus_pin[port], !pdata->vbus_pin_inverted ^ enable);
>  }
>  
> @@ -231,6 +234,9 @@ static int ohci_at91_usb_get_power(struct at91_usbh_data *pdata, int port)
>  	if (port < 0 || port >= 2)
>  		return -EINVAL;
>  
> +	if (pdata->vbus_pin[port] <= 0)
> +		return -EINVAL;
> +
>  	return gpio_get_value(pdata->vbus_pin[port]) ^ !pdata->vbus_pin_inverted;
>  }
>  


-- 
Nicolas Ferre
