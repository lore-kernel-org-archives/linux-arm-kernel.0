From: B19295@freescale.com (Lin Tony-B19295)
Date: Wed, 27 Jul 2011 09:15:37 +0000
Subject: [PATCH v3 0/6] ARM: mx28: add usb host function
In-Reply-To: <4E2FD3FE.5080100@pengutronix.de>
References: <1311744574-3610-1-git-send-email-tony.lin@freescale.com>
	<4E2FD3FE.5080100@pengutronix.de>
Message-ID: <97D3A72708D04647A5AC84A04996E5B5166AF4@039-SN1MPN1-006.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Marc Kleine-Budde [mailto:mkl at pengutronix.de]
> Sent: Wednesday, July 27, 2011 5:02 PM
> To: Lin Tony-B19295
> Cc: linux-usb at vger.kernel.org; koen.beel.barco at gmail.com;
> stern at rowland.harvard.edu; s.hauer at pengutronix.de; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH v3 0/6] ARM: mx28: add usb host function
> 
> On 07/27/2011 07:29 AM, Tony Lin wrote:
> > this patch series is to add mx28 usb host function.
> > the driver only support usb host mode on usb port1.
> > the driver reuses ehci-mxc.c under usb/host, but add platform irq
> > handler routines if platform wants to do something specific in irq
> > handler.
> > the patch also consolidates some macro definitions and structure
> > definitions to make ehci-mxc.c better reusable among mxs/mxc
> > platforms.
> >
> > Code is based on the branch for-next in sascha's tree
> > http://git.pengutronix.de/git/imx/linux-2.6.git
> >
> > Tested on MX28 EVK.
> >
> > changes since v2:
> >  * add error condition clean up code.
> >  * remove unnecessary initial code.
> >  * change file name from regs-usbphy-mx28 to regs-usbphy-mxs.h.
> >
> > changes since v1:
> >  * add dummy clock to avoid adding cpu judgement in driver for Sascha's
> request.
> 
> What about providing dummy clock definitions to the mxc's that don't have
> the clocks, too. This way you can remove all the cpu_is from
> "drivers/usb/host/ehci-mxc.c". You don't have to add all cpu_is_mx* to
> your "arch/arm/mach-mxs/include/mach/mxs.h".
> 

Correct. I know some guys have already involved in cleaning up this cpu_is_mx*. But I'm not sure whether there's someone working
on ehci-mxc.c.
If nobody, I'm going to do that work after this patch series. As you know, change that logic is simple but testing it takes efforts.
And this change deserves a dedicated patch series.

> >  * use context in phy functions, so that usb device could share the
> code.
> >  * some code consolidation and patch reorgnization.
> >  * error checking improvement.
> >  * remove a few unneccesary code.
> >
> > Tony Lin (6):
> >   ARM: mxs: ehci: consolidate definitions and structures to share among
> platforms
> >   ARM: mxs: enable usb1 phy power supply
> >   ARM: mxs: add usb clocks to clock tree
> >   ARM: mxs: make ehci-mxc more flexible to be used on different
> platforms
> >   ARM: mxs: add usb phy operations
> >   ARM: mxs: add usb host function to default config
> >
> >  arch/arm/configs/mxs_defconfig            |    8 +-
> >  arch/arm/mach-mxs/Kconfig                 |    1 +
> >  arch/arm/mach-mxs/Makefile                |    1 +
> >  arch/arm/mach-mxs/clock-mx28.c            |   16 ++-
> >  arch/arm/mach-mxs/include/mach/hardware.h |    2 +
> >  arch/arm/mach-mxs/include/mach/mxs.h      |   12 +-
> >  arch/arm/mach-mxs/mach-mx28evk.c          |    8 +
> >  arch/arm/mach-mxs/mxs_usb.c               |  288
> +++++++++++++++++++++++++++++
> >  arch/arm/mach-mxs/regs-usbphy-mxs.h       |  240
> ++++++++++++++++++++++++
> >  arch/arm/plat-mxc/include/mach/mxc_ehci.h |   19 --
> >  drivers/usb/host/Kconfig                  |    2 +-
> >  drivers/usb/host/ehci-mxc.c               |   19 ++-
> >  include/linux/fsl_devices.h               |   21 ++
> >  13 files changed, 609 insertions(+), 28 deletions(-)  create mode
> > 100644 arch/arm/mach-mxs/mxs_usb.c  create mode 100644
> > arch/arm/mach-mxs/regs-usbphy-mxs.h
> >
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> cheers, Marc
> --
> Pengutronix e.K.                  | Marc Kleine-Budde           |
> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
