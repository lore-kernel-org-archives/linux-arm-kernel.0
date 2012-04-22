From: marex@denx.de (Marek Vasut)
Date: Sun, 22 Apr 2012 14:59:16 +0200
Subject: [RFC PATCH 00/11 V4] MXS: Add i.MX28 USB Host driver
In-Reply-To: <1334771194-18688-1-git-send-email-marex@denx.de>
References: <1334771194-18688-1-git-send-email-marex@denx.de>
Message-ID: <1335099567-21056-1-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset introduces the USB Host driver for i.MX28 CPU, utilising the
generic USB PHY infrastructure. Also added is glue code for CI13xxx driver, to
allow device mode. This patchset still does NOT support OTG mode, the
device/host mode is selected via platform data.

V2: Introduce stub imx-usb driver that then registers the PHY and EHCI drivers.
V3: Add the HCD on demand based on the PHY's state (only add HCD if it's host).
    Currently, only the HOST mode is supported.
V4: * Introduce ci13xxx gadget glue
    * Reorder patches in a more sensible order
    * Introduce platform data, containing VBUS GPIO and port mode (device/gadget)
    * Rename imx-usb to imx-otg
    * Drop mx28evk usb host patch
    * Use more devm_ function
    * Rework the mxs-phy to register the same interrupt as ehci-mxs (and
      effectivelly kill bogus otg_set_vbus() call from ehci-mxs ; use standard
      ehci irq handling in ehci-mxs)

Marek Vasut (11):
  MXS: Make clk_disable return integer
  MXS: Add USB EHCI and USB PHY clock handling
  MXS: Fixup i.MX233 USB base address name
  MXS: Add data shared between imx-otg and EHCI driver
  MXS: Modify the ci13xxx_udc to avoid adding UDC
  MXS: Add small registration glue for ci13xxx_udc
  MXS: Add separate MXS EHCI HCD driver
  MXS: Add imx-otg driver
  MXS: Add USB PHY driver
  MXS: Add platform registration hooks for USB EHCI
  MXS: Enable USB on M28EVK

 arch/arm/mach-mxs/Kconfig                       |    2 +
 arch/arm/mach-mxs/clock-mx28.c                  |   28 +-
 arch/arm/mach-mxs/devices-mx28.h                |    5 +
 arch/arm/mach-mxs/devices/Kconfig               |    3 +
 arch/arm/mach-mxs/devices/Makefile              |    1 +
 arch/arm/mach-mxs/devices/platform-usb.c        |   84 +++++
 arch/arm/mach-mxs/include/mach/clock.h          |    2 +-
 arch/arm/mach-mxs/include/mach/devices-common.h |   12 +
 arch/arm/mach-mxs/include/mach/mx23.h           |    8 +-
 arch/arm/mach-mxs/mach-m28evk.c                 |   20 ++
 drivers/usb/gadget/Kconfig                      |   17 +
 drivers/usb/gadget/Makefile                     |    1 +
 drivers/usb/gadget/ci13xxx_mxs.c                |   67 ++++
 drivers/usb/gadget/ci13xxx_udc.c                |   12 +-
 drivers/usb/gadget/ci13xxx_udc.h                |    1 +
 drivers/usb/host/Kconfig                        |    7 +
 drivers/usb/host/ehci-hcd.c                     |    5 +
 drivers/usb/host/ehci-mxs.c                     |  197 ++++++++++
 drivers/usb/otg/Kconfig                         |   16 +
 drivers/usb/otg/Makefile                        |    2 +
 drivers/usb/otg/imx-otg.c                       |  282 +++++++++++++++
 drivers/usb/otg/mxs-phy.c                       |  438 +++++++++++++++++++++++
 include/linux/fsl/mxs-usb.h                     |   46 +++
 23 files changed, 1243 insertions(+), 13 deletions(-)
 create mode 100644 arch/arm/mach-mxs/devices/platform-usb.c
 create mode 100644 drivers/usb/gadget/ci13xxx_mxs.c
 create mode 100644 drivers/usb/host/ehci-mxs.c
 create mode 100644 drivers/usb/otg/imx-otg.c
 create mode 100644 drivers/usb/otg/mxs-phy.c
 create mode 100644 include/linux/fsl/mxs-usb.h

Cc: Chen Peter-B29397 <B29397@freescale.com>
Cc: Detlev Zundel <dzu@denx.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Li Frank-B20596 <B20596@freescale.com>
Cc: Lin Tony-B19295 <B19295@freescale.com>
Cc: Linux USB <linux-usb@vger.kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Shawn Guo <shawn.guo@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Stefano Babic <sbabic@denx.de>
Cc: Subodh Nijsure <snijsure@grid-net.com>
Cc: Tony Lin <tony.lin@freescale.com>
Cc: Wolfgang Denk <wd@denx.de>

NOTE: Adding this ci13xxx-mxs driver was really helpful, it helped me to realise
      how this whole monster should look like in the end. Now the mxs-phy is
      also much more prepared for the OTG operation.

-- 
1.7.9.5
