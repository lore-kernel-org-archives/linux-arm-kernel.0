From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 12 Nov 2010 00:24:41 +0100
Subject: [PATCH] AT91 USB Serial Device
In-Reply-To: <AANLkTimV2ENcWajrrMQ2Too4pf=XBfLczJ9HehNt4V_8@mail.gmail.com>
References: <AANLkTimV2ENcWajrrMQ2Too4pf=XBfLczJ9HehNt4V_8@mail.gmail.com>
Message-ID: <20101111232441.GA13661@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

	please send a patch

Best Regards,
J.
On 17:16 Wed 10 Nov     , Rob Emanuele wrote:
> Hi Nicolas,
> 
> I came across a small bug while debugging my problems of getting the
> host interface and device interface to work at the same time but on
> different ports.  I had compiled the atmel usb device support as a
> module and after unloading it and trying to reload it, the irq for
> vbus was not released.  This little patch fixes that
> 
> diff --git a/drivers/usb/gadget/atmel_usba_udc.c
> b/drivers/usb/gadget/atmel_usba_udc.c
> index d6ef3d5..bc70e53 100644
> --- a/drivers/usb/gadget/atmel_usba_udc.c
> +++ b/drivers/usb/gadget/atmel_usba_udc.c
> @@ -2052,8 +2052,10 @@ static int __exit usba_udc_remove(struct
> platform_device *pdev)
>                 usba_ep_cleanup_debugfs(&usba_ep[i]);
>         usba_cleanup_debugfs(udc);
> 
> -       if (gpio_is_valid(udc->vbus_pin))
> +       if (gpio_is_valid(udc->vbus_pin)) {
> +               free_irq(gpio_to_irq(udc->vbus_pin), udc);
>                 gpio_free(udc->vbus_pin);
> +       }
> 
>         free_irq(udc->irq, udc);
>         kfree(usba_ep);
> 
> 
> On Tue, Nov 9, 2010 at 3:59 PM, Rob Emanuele <poorarm@shoreis.com> wrote:
> > Nicolas et al,
> >
> > Thank you for the information. ?For the moment I have a boot option to
> > use either 2 host ports or a host and a device port. ?That would seem
> > to fit my needs except for the case that I'm loading the usb serial
> > gadget as a module and then specifying in the inittab that getty use
> > it as ttyGS0. ?In that case connecting the device port to a host does
> > not seem to ever register on the host. ?If I remove the getty line
> > from inittab and then run getty manually after it boots, it works
> > fine. ?To add insult to injury, then it will work after reboot also
> > until a hard power down.
> >
> > Anyone experience this?
> >
> > Thank you,
> >
> > Rob
> >
> > On Tue, Nov 9, 2010 at 9:46 AM, Nicolas Ferre <nicolas.ferre@atmel.com> wrote:
> >> Le 05/11/2010 22:09, Rob Emanuele :
> >>> Greetings,
> >>>
> >>> We've been developing a at91sam9g45 product and it is finally available at:
> >>> https://www.crystalfontz.com/product/CFA910.html
> >>
> >> Very nice platform!
> >>
> >>> We are looking into supporting USB OTG on this device as the 'g45 has
> >>> the USB host/device port. ?As far at I can tell Atmel or anyone else
> >>> working on this platform has not made full use of this as an OTG
> >>> device.
> >>
> >> Indeed, it is not done for the moment...
> >>
> >>> ?I haven't found support in the USB or the OTG code for
> >>> reading the USB ID line to determine host or device mode.
> >>
> >> I am not sure USB ID is well supported by consumer cable providers and
> >> is a reliable way to determine host or device mode.
> >>
> >>> Am I missing something or is that an area that needs some code written for it?
> >>
> >> Anyway, using this port as host or device is a matter of
> >> 1/ driving or not VBUS pin
> >> 2/ dealing with loading the gadget driver (as the "Enable" of the usba
> >> IP is responsible for swithing to device mode).
> >>
> >> I think that determining if the port shall be used in host or device
> >> mode can be asked through the GUI... But note that I am not an USB expert...
> >> --
> >> Nicolas Ferre
> >>
> >>
> >> _______________________________________________
> >> linux-arm-kernel mailing list
> >> linux-arm-kernel at lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> >>
> >
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
