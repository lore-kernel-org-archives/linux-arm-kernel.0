From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 18 Feb 2015 22:03:06 +0100
Subject: [PATCH] usb: renesas: fix extcon dependency
In-Reply-To: <20150129114158.GY26493@n2100.arm.linux.org.uk>
References: <2167400.bYh9r60XLF@wuerfel>
 <20150129114158.GY26493@n2100.arm.linux.org.uk>
Message-ID: <5999511.VS28SAB4Q0@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 29 January 2015 11:41:58 Russell King - ARM Linux wrote:
> On Wed, Jan 28, 2015 at 10:47:18PM +0100, Arnd Bergmann wrote:
> > The renesas usbhs driver calls extcon_get_edev_by_phandle(), which
> > is defined in drivers/extcon/extcon-class.c, and that can be a
> > loadable module. If the extcon-class support is disabled, usbhs
> > will work correctly for all devices that do not need extcon.
> > 
> > However, if extcon-class is a loadable module, and usbhs is
> > built-in, the kernel fails to link. In order to solve that,
> > we need a Kconfig dependency that allows extcon to be disabled
> > but does not allow usbhs built-in if extcon is a module.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > 
> > diff --git a/drivers/usb/renesas_usbhs/Kconfig b/drivers/usb/renesas_usbhs/Kconfig
> > index de83b9d0cd5c..0ea9040b9f10 100644
> > --- a/drivers/usb/renesas_usbhs/Kconfig
> > +++ b/drivers/usb/renesas_usbhs/Kconfig
> > @@ -6,6 +6,7 @@ config USB_RENESAS_USBHS
> >       tristate 'Renesas USBHS controller'
> >       depends on USB_GADGET
> >       depends on ARCH_SHMOBILE || SUPERH || COMPILE_TEST
> > +     depends on EXTCON || !EXTCON # for module build if extcon is
> 
> The comment doesn't make much sense on its own (and when I read it before
> reading the above description, it was down right confusing.)  Maybe a
> longer comment would be a good idea?
> 

Sorry for the late reply.

We have a lot of these dependencies, and I never know what a particular
maintainer expects. Let me try to come up with something better.

	Arnd
