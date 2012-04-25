From: marex@denx.de (Marek Vasut)
Date: Wed, 25 Apr 2012 14:27:58 +0200
Subject: [RFC PATCH 00/11 V5] MXS: Add i.MX28 USB Host driver
In-Reply-To: <20120424200215.GD3628@n2100.arm.linux.org.uk>
References: <1335099567-21056-1-git-send-email-marex@denx.de>
 <1335237523-9053-1-git-send-email-marex@denx.de>
 <20120424200215.GD3628@n2100.arm.linux.org.uk>
Message-ID: <201204251427.59194.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Russell King - ARM Linux,

> Do you really need 138 messages (and counting) all threaded together
> across the entire history of this patch set?  Please stop posting new
> copies of your patch set as followups to the previous set.

Well, it's usually to the point where the usb patches change, so instead of 
posting 8 patches, I post the whole set ot make it consistent.

> Not only does it rob horizontal space for reading the subjects in the
> index, but also it either buries your patches ages back or brings the
> entire 138 messages to the front of mailboxes, depending on your sort
> preferences.  Either way it makes threaded reading of the mailing list
> really difficult.
> 
> Please stop this antisocial behaviour.  Thanks.

Can you please suggest better solution? You mean post each new set as a separate 
thread ? Or post each patch as an in-reply-to previous one?

Thanks and sorry for that.

> On Tue, Apr 24, 2012 at 05:18:32AM +0200, Marek Vasut wrote:
> > From: Marek Vasut <marek.vasut@gmail.com>
> > 
> > This patchset introduces the USB Host driver for i.MX28 CPU, utilising
> > the generic USB PHY infrastructure. Also added is glue code for CI13xxx
> > driver, to allow device mode. This patchset still does NOT support OTG
> > mode, the device/host mode is selected via platform data.
> > 
> > V2: Introduce stub imx-usb driver that then registers the PHY and EHCI
> > drivers. V3: Add the HCD on demand based on the PHY's state (only add
> > HCD if it's host).
> > 
> >     Currently, only the HOST mode is supported.
> > 
> > V4: * Introduce ci13xxx gadget glue
> > 
> >     * Reorder patches in a more sensible order
> >     * Introduce platform data, containing VBUS GPIO and port mode
> >     (device/gadget) * Rename imx-usb to imx-otg
> >     * Drop mx28evk usb host patch
> >     * Use more devm_ function
> >     * Rework the mxs-phy to register the same interrupt as ehci-mxs (and
> >     
> >       effectivelly kill bogus otg_set_vbus() call from ehci-mxs ; use
> >       standard ehci irq handling in ehci-mxs)
> > 
> > V5: * Finally move OTG IRQ handling into imx-otg
> > 
> >     * Move imx_otg_set_{host,peripheral}() into imx-otg
> >     * Move imx_otg_work() into imx-otg driver (now it all makes sense,
> >     yay!)
> > 
> > Marek Vasut (11):
> >   MXS: Make clk_disable return integer
> >   MXS: Add USB EHCI and USB PHY clock handling
> >   MXS: Fixup i.MX233 USB base address name
> >   MXS: Add data shared between imx-otg and EHCI driver
> >   MXS: Modify the ci13xxx_udc to avoid adding UDC
> >   MXS: Add small registration glue for ci13xxx_udc
> >   MXS: Add separate MXS EHCI HCD driver
> >   MXS: Add imx-otg driver
> >   MXS: Add USB PHY driver
> >   MXS: Add platform registration hooks for USB EHCI
> >   MXS: Enable USB on M28EVK
> >  
> >  arch/arm/mach-mxs/Kconfig                       |    2 +
> >  arch/arm/mach-mxs/clock-mx28.c                  |   28 +-
> >  arch/arm/mach-mxs/devices-mx28.h                |    5 +
> >  arch/arm/mach-mxs/devices/Kconfig               |    3 +
> >  arch/arm/mach-mxs/devices/Makefile              |    1 +
> >  arch/arm/mach-mxs/devices/platform-usb.c        |   85 ++++
> >  arch/arm/mach-mxs/include/mach/clock.h          |    2 +-
> >  arch/arm/mach-mxs/include/mach/devices-common.h |   13 +
> >  arch/arm/mach-mxs/include/mach/mx23.h           |    8 +-
> >  arch/arm/mach-mxs/mach-m28evk.c                 |   21 +
> >  drivers/usb/gadget/Kconfig                      |   17 +
> >  drivers/usb/gadget/Makefile                     |    1 +
> >  drivers/usb/gadget/ci13xxx_mxs.c                |   67 ++++
> >  drivers/usb/gadget/ci13xxx_udc.c                |   12 +-
> >  drivers/usb/gadget/ci13xxx_udc.h                |    1 +
> >  drivers/usb/host/Kconfig                        |    7 +
> >  drivers/usb/host/ehci-hcd.c                     |    5 +
> >  drivers/usb/host/ehci-mxs.c                     |  178 +++++++++
> >  drivers/usb/otg/Kconfig                         |   16 +
> >  drivers/usb/otg/Makefile                        |    2 +
> >  drivers/usb/otg/imx-otg.c                       |  473
> >  +++++++++++++++++++++++ drivers/usb/otg/mxs-phy.c                      
> >  |  237 ++++++++++++ include/linux/usb/mxs-usb.h                     |  
> >  95 +++++
> >  23 files changed, 1266 insertions(+), 13 deletions(-)
> >  create mode 100644 arch/arm/mach-mxs/devices/platform-usb.c
> >  create mode 100644 drivers/usb/gadget/ci13xxx_mxs.c
> >  create mode 100644 drivers/usb/host/ehci-mxs.c
> >  create mode 100644 drivers/usb/otg/imx-otg.c
> >  create mode 100644 drivers/usb/otg/mxs-phy.c
> >  create mode 100644 include/linux/usb/mxs-usb.h
> > 
> > Cc: Chen Peter-B29397 <B29397@freescale.com>
> > Cc: Detlev Zundel <dzu@denx.de>
> > Cc: Fabio Estevam <festevam@gmail.com>
> > Cc: Li Frank-B20596 <B20596@freescale.com>
> > Cc: Lin Tony-B19295 <B19295@freescale.com>
> > Cc: Linux USB <linux-usb@vger.kernel.org>
> > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > Cc: Shawn Guo <shawn.guo@freescale.com>
> > Cc: Shawn Guo <shawn.guo@linaro.org>
> > Cc: Stefano Babic <sbabic@denx.de>
> > Cc: Subodh Nijsure <snijsure@grid-net.com>
> > Cc: Tony Lin <tony.lin@freescale.com>
> > Cc: Wolfgang Denk <wd@denx.de>

Best regards,
Marek Vasut
