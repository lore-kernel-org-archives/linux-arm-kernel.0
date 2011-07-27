From: B19295@freescale.com (Lin Tony-B19295)
Date: Wed, 27 Jul 2011 09:10:15 +0000
Subject: [PATCH v3 5/6] ARM: mxs: add usb phy operations
In-Reply-To: <20015.53465.485660.500080@ipc1.ka-ro>
References: <1311744574-3610-1-git-send-email-tony.lin@freescale.com>
	<1311744574-3610-6-git-send-email-tony.lin@freescale.com>
	<20015.53465.485660.500080@ipc1.ka-ro>
Message-ID: <97D3A72708D04647A5AC84A04996E5B5166AD6@039-SN1MPN1-006.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Lothar Wa?mann [mailto:LW at KARO-electronics.de]
> Sent: Wednesday, July 27, 2011 4:48 PM
> To: Lin Tony-B19295
> Cc: linux-usb at vger.kernel.org; koen.beel.barco at gmail.com;
> stern at rowland.harvard.edu; s.hauer at pengutronix.de; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH v3 5/6] ARM: mxs: add usb phy operations
> 
> Hi,
> 
> Tony Lin writes:
> > add usb phy register definitions and functions usb host driver will
> > use these callback functions to initialize usb phy and change working
> > mode
> >
> > Signed-off-by: Tony Lin <tony.lin@freescale.com>
> > ---
> >  arch/arm/mach-mxs/Kconfig           |    1 +
> >  arch/arm/mach-mxs/Makefile          |    1 +
> >  arch/arm/mach-mxs/mxs_usb.c         |  288
> +++++++++++++++++++++++++++++++++++
> >  arch/arm/mach-mxs/regs-usbphy-mxs.h |  240
> > +++++++++++++++++++++++++++++
> >  4 files changed, 530 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/mach-mxs/Kconfig b/arch/arm/mach-mxs/Kconfig
> > index 4cd0231..1c4264f 100644
> > --- a/arch/arm/mach-mxs/Kconfig
> > +++ b/arch/arm/mach-mxs/Kconfig
> > @@ -49,6 +49,7 @@ config MACH_MX28EVK
> >  	select MXS_HAVE_PLATFORM_MXS_MMC
> >  	select MXS_HAVE_PLATFORM_MXSFB
> >  	select MXS_OCOTP
> > +	select USB_ARCH_HAS_EHCI
> >  	help
> >  	  Include support for MX28EVK platform. This includes specific
> >  	  configurations for the board and its peripherals.
> > diff --git a/arch/arm/mach-mxs/Makefile b/arch/arm/mach-mxs/Makefile
> > index 6c38262..726c49f 100644
> > --- a/arch/arm/mach-mxs/Makefile
> > +++ b/arch/arm/mach-mxs/Makefile
> > @@ -12,5 +12,6 @@ obj-$(CONFIG_MACH_MX23EVK) += mach-mx23evk.o
> >  obj-$(CONFIG_MACH_MX28EVK) += mach-mx28evk.o
> >  obj-$(CONFIG_MODULE_TX28) += module-tx28.o
> >  obj-$(CONFIG_MACH_TX28)    += mach-tx28.o
> > +obj-$(CONFIG_USB_EHCI_MXC)   += mxs_usb.o
> >
> >  obj-y += devices/
> > diff --git a/arch/arm/mach-mxs/mxs_usb.c b/arch/arm/mach-mxs/mxs_usb.c
> > new file mode 100644 index 0000000..9acc611
> > --- /dev/null
> > +++ b/arch/arm/mach-mxs/mxs_usb.c
> [...]
> > +static struct mxs_usb_private_date usbh_private = {
> > +	.internal_phy_clk_already_on = 0,
> > +};
> > +
> > +static struct mxc_usbh_platform_data usbh_config = {
> > +	.init = fsl_usb_host_init,
> > +	.exit = fsl_usb_host_uninit,
> > +	.portsc = MXC_EHCI_MODE_ULPI,
> > +	.otg = NULL,
> > +	.plt_irq_handler = fsl_plt_usbh_irq_handler,
> > +	.ppriv = &usbh_private,
>         ^^^^^^^^^^^^^^^^^^^^^^^
> This is an abuse of the platform_data. platform_data is meant to convey
> platform specific information to a driver, not for drivers storing their
> internal state. It should be handled read-only by drivers.
> 
> If you want to associate driver internal data with a platform_device you
> should use platform_set_drvdata()/platform_get_drvdata() to
> store/retrieve a pointer to the driver's internal data.
> 
> 
The ppriv is not for storing driver internal state. Actually driver needs some callback functions which locates in platform.
So that this pointer stores platform specific information used in callbacks to distinguish such as register address, clk
Information.
So far, as we have only USB host, the code seems to be a little redundant. But later, it'll be shared by USB host and USB device.
And we need such information to distinguish it's in host/device context.

> Lothar Wa?mann
> --
> ___________________________________________________________
> 
> Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
> Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
> Gesch?ftsf?hrer: Matthias Kaussen
> Handelsregistereintrag: Amtsgericht Aachen, HRB 4996
> 
> www.karo-electronics.de | info at karo-electronics.de
> ___________________________________________________________
