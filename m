From: marek.vasut@gmail.com (Marek Vasut)
Date: Sat, 13 Mar 2010 23:00:55 +0100
Subject: [PATCH] Voipac PXA270: UDC and UHC support
In-Reply-To: <87hbol77lp.fsf@free.fr>
References: <201003100543.00221.marek.vasut@gmail.com>
	<201003101243.54008.marek.vasut@gmail.com> <87hbol77lp.fsf@free.fr>
Message-ID: <201003132300.55480.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne P? 12. b?ezna 2010 18:49:54 Robert Jarzmik napsal(a):
> Marek Vasut <marek.vasut@gmail.com> writes:
> > Dne St 10. b?ezna 2010 05:43:00 Marek Vasut napsal(a):
> >> Hi,
> >> this patch adds UDC and UHC support (and formating fix, I hope you dont
> >>  mind Eric).
> >>
> >> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> >
> > revised patch
> 
> snip
> 
> > +/***********************************************************************
> >******* + * USB Gadget
> > +
> > *************************************************************************
> >*****/ +#if
> > defined(CONFIG_USB_GADGET_PXA27X)||defined(CONFIG_USB_GADGET_PXA27X_MODUL
> >E) +static struct pxa2xx_udc_mach_info vpac270_udc_info __initdata = {
> > +	.gpio_vbus		= GPIO41_VPAC270_UDC_DETECT,
> > +};
> 
> That won't work I think. gpio_vbus is not dealt with by pxa27x_udc.
> The way to go would rather be something like :
> 
> #include <linux/usb/gpio_vbus.h>
> static struct pxa2xx_udc_mach_info vpac270_udc_info __initdata = {
>         .gpio_pullup      = <to be filled in>,
> };
> 
> struct gpio_vbus_mach_info gpio_vbus_data = {
>         .gpio_vbus = GPIO41_VPAC270_UDC_DETECT,
>         .gpio_vbus_inverted = 0,
>         .gpio_pullup = -1,
> };
> 
> Add add a "gpio_vbus" device, with platform_data set to gpio_vbus_data.
> 
> As a matter of fact, there are not a lot of cases where an UDC can work
>  without : - a GPIO for pullup
>  - or the udc_command() callback implemented
> The only working case I see is a hardwired D+ pin to the Vdd, but that
>  seems an exterme in board design I've never met before. This lets me think
>  you should find and the add the correct GPIO for pullup.
> 
> Cheers.
> 
> --
> Robert
> 
Updated patch attached.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0003-Voipac-PXA270-UDC-and-UHC-support.patch
Type: text/x-patch
Size: 4188 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100313/3ecfd342/attachment.bin>
