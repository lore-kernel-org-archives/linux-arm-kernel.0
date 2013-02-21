From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 21 Feb 2013 10:54:46 -0500 (EST)
Subject: [V2 1/8] USB: EHCI: make ehci-spear a separate driver
In-Reply-To: <CAJFYCKHMfymudGXq15bFzBHFx3Pc3JdhvMeJ6jfME7rm2ZBfSA@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1302211051130.1529-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 21 Feb 2013, Manjunath Goudar wrote:

> On 20 February 2013 21:43, Alan Stern <stern@rowland.harvard.edu> wrote:
> 
> > On Fri, 15 Feb 2013, Manjunath Goudar wrote:
> >
> > > Separate the SPEAr host controller driver from ehci-hcd host code
> > > into its own driver module.
> > >
> > > In V2:
> > > Replaced spear as SPEAr everywhere, leaving functions/variables/config
> > options.
> >
> > > --- a/drivers/usb/host/Kconfig
> > > +++ b/drivers/usb/host/Kconfig
> > > @@ -162,6 +162,14 @@ config USB_EHCI_HCD_OMAP
> > >         Enables support for the on-chip EHCI controller on
> > >         OMAP3 and later chips.
> > >
> > > +config USB_EHCI_HCD_SPEAR
> > > +        tristate "Support for ST SPEAr on-chip EHCI USB controller"
> > > +        depends on USB_EHCI_HCD && PLAT_SPEAR
> > > +        default y
> > > +        ---help---
> > > +          Enables support for the on-chip EHCI controller on
> > > +          ST SPEAr chips.
> >
> > Is it a good idea to make this option interactive?  That might cause
> > people to disable it by mistake.
> >
> > Thank you very much your approach.
> 
> This is my approach, who are by mistake disabling.
> 
> config USB_EHCI_HCD_SPEAR
>         tristate "Support for ST SPEAr on-chip EHCI USB controller"
>         depends on PLAT_SPEAR
>         select USB_EHCI_HCD
>         default y
>         ---help---
>           Enables support for the on-chip EHCI controller on
>           ST SPEAr chips.
> 
> Is it ok.

I'm not sure what you mean.  But other people have said that it's 
better for these options to be interactive, so this is okay.

> > > @@ -209,11 +188,35 @@ static struct platform_driver
> > spear_ehci_hcd_driver = {
> > >       .remove         = spear_ehci_hcd_drv_remove,
> > >       .shutdown       = usb_hcd_platform_shutdown,
> > >       .driver         = {
> > > -             .name = "spear-ehci",
> > > +             .name = hcd_name,
> >
> > You must not change the driver's name.  It won't work on non-DT
> > systems; the platform bus relies on matching drivers to devices by
> > comparing their names.
> >
> > Here I am planing to avoid two different string for single driver
> "spear-ehci" is used in above initialization "ehci-spear" one is used for
> printing driver name in module_init, instead of two, why cant we go for
> single string "spear-ehci" only.

You need to have two different strings because there are two different 
entities with different names:

	The driver file is ehci-spear (or ehci-spear.ko for the
	module).

	The device is spear-ehci (this is determined by the platform
	code, not the USB stack).

Alan Stern
