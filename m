From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 07 Sep 2011 12:51:16 +0200
Subject: [PATCH 3/3] at91-ohci: configure overcurrent pins as input GPIOs
In-Reply-To: <1310549358-13330-4-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1310549358-13330-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1310549358-13330-4-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <4E674CA4.6080506@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 13/07/2011 11:29, Thomas Petazzoni :
> As a new overcurrent_pin[] array has been added to the at91_usbh_data
> structure, those pins must be muxed to work properly. This commit
> implements this muxing for all AT91 SoCs that support the AT91 OHCI.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Andrew Victor <linux@maxim.org.za>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>

I will include this patch series in at91-l2 branch on:
git://github.com/at91linux/linux-at91.git
(mind the removal of -2.6-)

But there are several changes to ohci-at91 which also may fit in an USB
git tree...
According to the nature of changes, I think it is better to send them
upstream through the AT91 - arm-soc flow.

Thanks Thomas, best regards,

> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> ---
>  arch/arm/mach-at91/at91cap9_devices.c    |    6 ++++++
>  arch/arm/mach-at91/at91rm9200_devices.c  |    6 ++++++
>  arch/arm/mach-at91/at91sam9260_devices.c |    6 ++++++
>  arch/arm/mach-at91/at91sam9261_devices.c |    6 ++++++
>  arch/arm/mach-at91/at91sam9263_devices.c |    6 ++++++
>  arch/arm/mach-at91/at91sam9g45_devices.c |    6 ++++++
>  6 files changed, 36 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/at91cap9_devices.c b/arch/arm/mach-at91/at91cap9_devices.c
> index dba0d8d..b46615a 100644
> --- a/arch/arm/mach-at91/at91cap9_devices.c
> +++ b/arch/arm/mach-at91/at91cap9_devices.c
> @@ -80,6 +80,12 @@ void __init at91_add_device_usbh(struct at91_usbh_data *data)
>  			at91_set_gpio_output(data->vbus_pin[i], 0);
>  	}
>  
> +	/* Enable overcurrent notification */
> +	for (i = 0; i < data->ports; i++) {
> +		if (data->overcurrent_pin[i])
> +			at91_set_gpio_input(data->overcurrent_pin[i], 1);
> +	}
> +
>  	usbh_data = *data;
>  	platform_device_register(&at91_usbh_device);
>  }
> diff --git a/arch/arm/mach-at91/at91rm9200_devices.c b/arch/arm/mach-at91/at91rm9200_devices.c
> index 7227755..b2202b6 100644
> --- a/arch/arm/mach-at91/at91rm9200_devices.c
> +++ b/arch/arm/mach-at91/at91rm9200_devices.c
> @@ -63,6 +63,12 @@ void __init at91_add_device_usbh(struct at91_usbh_data *data)
>  	if (!data)
>  		return;
>  
> +	/* Enable overcurrent notification */
> +	for (i = 0; i < data->ports; i++) {
> +		if (data->overcurrent_pin[i])
> +			at91_set_gpio_input(data->overcurrent_pin[i], 1);
> +	}
> +
>  	usbh_data = *data;
>  	platform_device_register(&at91rm9200_usbh_device);
>  }
> diff --git a/arch/arm/mach-at91/at91sam9260_devices.c b/arch/arm/mach-at91/at91sam9260_devices.c
> index 39f81f4..ad64fc3 100644
> --- a/arch/arm/mach-at91/at91sam9260_devices.c
> +++ b/arch/arm/mach-at91/at91sam9260_devices.c
> @@ -64,6 +64,12 @@ void __init at91_add_device_usbh(struct at91_usbh_data *data)
>  	if (!data)
>  		return;
>  
> +	/* Enable overcurrent notification */
> +	for (i = 0; i < data->ports; i++) {
> +		if (data->overcurrent_pin[i])
> +			at91_set_gpio_input(data->overcurrent_pin[i], 1);
> +	}
> +
>  	usbh_data = *data;
>  	platform_device_register(&at91_usbh_device);
>  }
> diff --git a/arch/arm/mach-at91/at91sam9261_devices.c b/arch/arm/mach-at91/at91sam9261_devices.c
> index 5004bf0..e394e86 100644
> --- a/arch/arm/mach-at91/at91sam9261_devices.c
> +++ b/arch/arm/mach-at91/at91sam9261_devices.c
> @@ -67,6 +67,12 @@ void __init at91_add_device_usbh(struct at91_usbh_data *data)
>  	if (!data)
>  		return;
>  
> +	/* Enable overcurrent notification */
> +	for (i = 0; i < data->ports; i++) {
> +		if (data->overcurrent_pin[i])
> +			at91_set_gpio_input(data->overcurrent_pin[i], 1);
> +	}
> +
>  	usbh_data = *data;
>  	platform_device_register(&at91sam9261_usbh_device);
>  }
> diff --git a/arch/arm/mach-at91/at91sam9263_devices.c b/arch/arm/mach-at91/at91sam9263_devices.c
> index a050f41..d4aef76 100644
> --- a/arch/arm/mach-at91/at91sam9263_devices.c
> +++ b/arch/arm/mach-at91/at91sam9263_devices.c
> @@ -74,6 +74,12 @@ void __init at91_add_device_usbh(struct at91_usbh_data *data)
>  			at91_set_gpio_output(data->vbus_pin[i], 0);
>  	}
>  
> +	/* Enable overcurrent notification */
> +	for (i = 0; i < data->ports; i++) {
> +		if (data->overcurrent_pin[i])
> +			at91_set_gpio_input(data->overcurrent_pin[i], 1);
> +	}
> +
>  	usbh_data = *data;
>  	platform_device_register(&at91_usbh_device);
>  }
> diff --git a/arch/arm/mach-at91/at91sam9g45_devices.c b/arch/arm/mach-at91/at91sam9g45_devices.c
> index 600bffb..e4a9857 100644
> --- a/arch/arm/mach-at91/at91sam9g45_devices.c
> +++ b/arch/arm/mach-at91/at91sam9g45_devices.c
> @@ -124,6 +124,12 @@ void __init at91_add_device_usbh_ohci(struct at91_usbh_data *data)
>  			at91_set_gpio_output(data->vbus_pin[i], 0);
>  	}
>  
> +	/* Enable overcurrent notification */
> +	for (i = 0; i < data->ports; i++) {
> +		if (data->overcurrent_pin[i])
> +			at91_set_gpio_input(data->overcurrent_pin[i], 1);
> +	}
> +
>  	usbh_ohci_data = *data;
>  	platform_device_register(&at91_usbh_ohci_device);
>  }


-- 
Nicolas Ferre
