From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 17 Sep 2009 11:00:38 +0200
Subject: [PATCH] at91: use gpiolib calls for USB vbus pin on at91sam9g45
In-Reply-To: <4AB1EFC5.2060707@atmel.com>
References: <4AB10F7D.9060706@atmel.com>
	<1253122169-14806-1-git-send-email-nicolas.ferre@atmel.com>
	<20090916215328.GG4172@game.jcrosoft.org>
	<4AB1EFC5.2060707@atmel.com>
Message-ID: <20090917090038.GD29905@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10:13 Thu 17 Sep     , Nicolas Ferre wrote:
> Jean-Christophe PLAGNIOL-VILLARD :
> > On 19:29 Wed 16 Sep     , Nicolas Ferre wrote:
> >> Change pin configuration for USB vbus on at91sam9g45: use the generic gpiolib
> >> call instead of the at91 specific one.
> >> Use gpio_request() function with same identifier for OHCI and EHCI hosts as
> >> they are sharing the same pin.
> >>
> >> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> >> ---
> >> This patch is on top of at91sam9g45 USB integration one:
> >> "[PATCH 2/2] at91/USB: at91sam9g45 series USB host integration"
> >> http://lkml.org/lkml/2009/6/9/221
> >>
> >>  arch/arm/mach-at91/at91sam9g45_devices.c |   12 ++++++++----
> >>  1 files changed, 8 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/arch/arm/mach-at91/at91sam9g45_devices.c b/arch/arm/mach-at91/at91sam9g45_devices.c
> >> index 5be8cf2..7d939c0 100644
> >> --- a/arch/arm/mach-at91/at91sam9g45_devices.c
> >> +++ b/arch/arm/mach-at91/at91sam9g45_devices.c
> >> @@ -118,8 +118,10 @@ void __init at91_add_device_usbh_ohci(struct at91_usbh_data *data)
> >>  
> >>  	/* Enable VBus control for UHP ports */
> >>  	for (i = 0; i < data->ports; i++) {
> >> -		if (data->vbus_pin[i])
> >> -			at91_set_gpio_output(data->vbus_pin[i], 0);
> >> +		if (data->vbus_pin[i]) {
> >> +			gpio_request(data->vbus_pin[i], "usb host vbus");
> >> +			gpio_direction_output(data->vbus_pin[i], 0);
> >> +		}
> >>  	}
> >>  
> >>  	usbh_ohci_data = *data;
> >> @@ -173,8 +175,10 @@ void __init at91_add_device_usbh_ehci(struct at91_usbh_data *data)
> >>  
> >>  	/* Enable VBus control for UHP ports */
> >>  	for (i = 0; i < data->ports; i++) {
> >> -		if (data->vbus_pin[i])
> >> -			at91_set_gpio_output(data->vbus_pin[i], 0);
> >> +		if (data->vbus_pin[i]) {
> >> +			gpio_request(data->vbus_pin[i], "usb host vbus");
> >> +			gpio_direction_output(data->vbus_pin[i], 0);
> >> +		}
> >>  	}
> > as you do the same think for ehci & ohci why not factorize it?
> 
> Just because you may choose only one or the other controller.
> For instance, if you only want ohci, you can disable ehci selection and
> always have its configuration done.
I agree but both configuration function share some code which could be
factorize, is it not?

Best Regards,
J.
