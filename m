From: marex@denx.de (Marek Vasut)
Date: Mon, 30 Apr 2012 01:00:39 +0200
Subject: [RFC PATCH 00/11 V6] MXS: Add i.MX28 USB Host driver
In-Reply-To: <1335738860-26623-1-git-send-email-marex@denx.de>
References: <1335738860-26623-1-git-send-email-marex@denx.de>
Message-ID: <201204300100.39646.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> This patchset introduces the USB Host driver for i.MX28 CPU, utilising the
> generic USB PHY infrastructure. Also added is glue code for CI13xxx driver,
> to allow device mode. This patchset still does NOT support OTG mode, the
> device/host mode is selected via platform data.

I also pushed the patchset here:

http://git.kernel.org/?p=linux/kernel/git/marex/linux-2.6.git;a=shortlog;h=refs/heads/mxs-
usb

> 
> V2: Introduce stub imx-usb driver that then registers the PHY and EHCI
> drivers. V3: Add the HCD on demand based on the PHY's state (only add HCD
> if it's host). Currently, only the HOST mode is supported.
> V4: * Introduce ci13xxx gadget glue
>     * Reorder patches in a more sensible order
>     * Introduce platform data, containing VBUS GPIO and port mode
> (device/gadget) * Rename imx-usb to imx-otg
>     * Drop mx28evk usb host patch
>     * Use more devm_ function
>     * Rework the mxs-phy to register the same interrupt as ehci-mxs (and
>       effectivelly kill bogus otg_set_vbus() call from ehci-mxs ; use
> standard ehci irq handling in ehci-mxs)
> V5: * Finally move OTG IRQ handling into imx-otg
>     * Move imx_otg_set_{host,peripheral}() into imx-otg
>     * Move imx_otg_work() into imx-otg driver (now it all makes sense,
> yay!) V6: Do PHY-specific job inside the PHY driver
> 
> Marek Vasut (11):
>   MXS: Make clk_disable return integer
>   MXS: Add USB EHCI and USB PHY clock handling
>   MXS: Fixup i.MX233 USB base address name
>   MXS: Add data shared between imx-otg and EHCI driver
>   MXS: Modify the ci13xxx_udc to avoid adding UDC
>   MXS: Add small registration glue for ci13xxx_udc
>   MXS: Add separate MXS EHCI HCD driver
>   MXS: Add imx-otg driver
>   MXS: Add USB PHY driver
>   MXS: Add platform registration hooks for USB EHCI
>   MXS: Enable USB on M28EVK
> 
>  arch/arm/mach-mxs/Kconfig                       |    2 +
>  arch/arm/mach-mxs/clock-mx28.c                  |   28 +-
>  arch/arm/mach-mxs/devices-mx28.h                |    5 +
>  arch/arm/mach-mxs/devices/Kconfig               |    3 +
>  arch/arm/mach-mxs/devices/Makefile              |    1 +
>  arch/arm/mach-mxs/devices/platform-usb.c        |   89 +++++
>  arch/arm/mach-mxs/include/mach/clock.h          |    2 +-
>  arch/arm/mach-mxs/include/mach/devices-common.h |   13 +
>  arch/arm/mach-mxs/include/mach/mx23.h           |    8 +-
>  arch/arm/mach-mxs/mach-m28evk.c                 |   21 ++
>  drivers/usb/gadget/Kconfig                      |   17 +
>  drivers/usb/gadget/Makefile                     |    1 +
>  drivers/usb/gadget/ci13xxx_mxs.c                |   67 ++++
>  drivers/usb/gadget/ci13xxx_udc.c                |   12 +-
>  drivers/usb/gadget/ci13xxx_udc.h                |    1 +
>  drivers/usb/host/Kconfig                        |    7 +
>  drivers/usb/host/ehci-hcd.c                     |    5 +
>  drivers/usb/host/ehci-mxs.c                     |  178 +++++++++
>  drivers/usb/otg/Kconfig                         |   16 +
>  drivers/usb/otg/Makefile                        |    2 +
>  drivers/usb/otg/imx-otg.c                       |  437
> +++++++++++++++++++++++ drivers/usb/otg/mxs-phy.c                       | 
> 293 +++++++++++++++ include/linux/usb/mxs-usb.h                     |   94
> +++++
>  23 files changed, 1289 insertions(+), 13 deletions(-)
>  create mode 100644 arch/arm/mach-mxs/devices/platform-usb.c
>  create mode 100644 drivers/usb/gadget/ci13xxx_mxs.c
>  create mode 100644 drivers/usb/host/ehci-mxs.c
>  create mode 100644 drivers/usb/otg/imx-otg.c
>  create mode 100644 drivers/usb/otg/mxs-phy.c
>  create mode 100644 include/linux/usb/mxs-usb.h
> 
> Cc: Chen Peter-B29397 <B29397@freescale.com>
> Cc: Detlev Zundel <dzu@denx.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Li Frank-B20596 <B20596@freescale.com>
> Cc: Linux USB <linux-usb@vger.kernel.org>
> Cc: Liu JunJie-B08287 <B08287@freescale.com>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Shi Make-B15407 <B15407@freescale.com>
> Cc: Stefano Babic <sbabic@denx.de>
> Cc: Subodh Nijsure <snijsure@grid-net.com>
> Cc: Wolfgang Denk <wd@denx.de>

Best regards,
Marek Vasut
