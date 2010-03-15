From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 15 Mar 2010 20:21:37 +0100
Subject: [PATCH] Voipac PXA270: UDC and UHC support
In-Reply-To: <201003132300.55480.marek.vasut@gmail.com> (Marek Vasut's message
	of "Sat, 13 Mar 2010 23:00:55 +0100")
References: <201003100543.00221.marek.vasut@gmail.com>
	<201003101243.54008.marek.vasut@gmail.com> <87hbol77lp.fsf@free.fr>
	<201003132300.55480.marek.vasut@gmail.com>
Message-ID: <87ljdtpf0e.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marek Vasut <marek.vasut@gmail.com> writes:

> Dne P? 12. b?ezna 2010 18:49:54 Robert Jarzmik napsal(a):
>> Marek Vasut <marek.vasut@gmail.com> writes:
>> > Dne St 10. b?ezna 2010 05:43:00 Marek Vasut napsal(a):
>> >> Hi,
>> >> this patch adds UDC and UHC support (and formating fix, I hope you dont
>> >>  mind Eric).
>> >>
>> >> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
>> >
>> > revised patch
Yes, I feel that one much better.

One minor comments remain for me.
> +/******************************************************************************
> + * USB Gadget
> + ******************************************************************************/
> +#if defined(CONFIG_USB_GADGET_PXA27X)||defined(CONFIG_USB_GADGET_PXA27X_MODULE)
> +static struct gpio_vbus_mach_info vpac270_gpio_vbus_info = {
> +	.gpio_vbus		= GPIO41_VPAC270_UDC_DETECT,
> +	.gpio_pullup		= -1,
> +};
> +
> +static struct platform_device vpac270_gpio_vbus = {
> +	.name	= "gpio-vbus",
> +	.id	= -1,
> +	.dev	= {
> +		.platform_data	= &vpac270_gpio_vbus_info,
> +	},
> +};
> +
> +static void vpac270_udc_command(int cmd) 
> +{
> +	if (cmd == PXA2XX_UDC_CMD_CONNECT)
> +		UP2OCR |= UP2OCR_HXOE | UP2OCR_DPPUE | UP2OCR_DPPUBE;
> +	else if (cmd == PXA2XX_UDC_CMD_DISCONNECT)
> +		UP2OCR &= ~(UP2OCR_HXOE | UP2OCR_DPPUE | UP2OCR_DPPUBE);

In the "DISCONNECT" case, you reset UP2OCR_HXOE, meaning the usb port isn't a
USB Device anymore (neither a USB host). If that's on purpose, then all good, in
the other case, don't reset that one.

Otherwise, you can add for the UDC part :
Reviewed-by: Robert Jarzmik <robert.jarzmik@free.fr>

-- 
Robert
