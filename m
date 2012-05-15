From: marex@denx.de (Marek Vasut)
Date: Tue, 15 May 2012 10:23:31 +0200
Subject: [RFC PATCH 0/8 V8] MXS: Add i.MX28 USB Host driver
Message-ID: <1337070219-3630-1-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset introduces the USB Host driver for i.MX28 CPU, utilising the
generic USB PHY infrastructure. This version of patchset is now based on
ci13xxx rework by Alexander Shishkin.

This patchset now depends on the following four patches:
	http://www.spinics.net/lists/linux-usb/msg63787.html

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
V5: * Finally move OTG IRQ handling into imx-otg
    * Move imx_otg_set_{host,peripheral}() into imx-otg
    * Move imx_otg_work() into imx-otg driver (now it all makes sense, yay!)
V6: Do PHY-specific job inside the PHY driver
V7: * Pass only necessary data to the drivers registered by imx-otg
      (memory, irq, pointer to imx-otg device). This should fix issue pointed
      out by Lothar Wassmann.
    * Have single IRQ handler in imx-otg, which then calls host/gadget IRQ
      handlers only if they're registered via imx_otg_set_irq_handler() call,
      depending on the current state of the OTG.
V8: Rework on top of ci13xxx changes by Alex Shishkin

Marek Vasut (8):
  MXS: Make clk_disable return integer
  MXS: Add USB EHCI and USB PHY clock handling
  MXS: Fixup i.MX233 USB base address name
  MXS: Add data shared between imx-otg and EHCI driver
  MXS: Add USB PHY driver
  CI13xxx: Add i.MX233/i.MX28 binding code
  MXS: Add platform registration hooks for USB EHCI
  MXS: Enable USB on M28EVK

 arch/arm/mach-mxs/Kconfig                       |    2 +
 arch/arm/mach-mxs/clock-mx28.c                  |   28 +-
 arch/arm/mach-mxs/devices-mx28.h                |    5 +
 arch/arm/mach-mxs/devices/Kconfig               |    3 +
 arch/arm/mach-mxs/devices/Makefile              |    1 +
 arch/arm/mach-mxs/devices/platform-usb.c        |   84 ++++++
 arch/arm/mach-mxs/include/mach/clock.h          |    2 +-
 arch/arm/mach-mxs/include/mach/devices-common.h |   13 +
 arch/arm/mach-mxs/include/mach/mx23.h           |    8 +-
 arch/arm/mach-mxs/mach-m28evk.c                 |   19 ++
 drivers/usb/chipidea/Makefile                   |    4 +
 drivers/usb/chipidea/ci13xxx_mxs.c              |  201 +++++++++++++++
 drivers/usb/otg/Kconfig                         |   10 +
 drivers/usb/otg/Makefile                        |    1 +
 drivers/usb/otg/mxs-phy.c                       |  313 +++++++++++++++++++++++
 include/linux/usb/mxs-usb.h                     |   39 +++
 16 files changed, 724 insertions(+), 9 deletions(-)
 create mode 100644 arch/arm/mach-mxs/devices/platform-usb.c
 create mode 100644 drivers/usb/chipidea/ci13xxx_mxs.c
 create mode 100644 drivers/usb/otg/mxs-phy.c
 create mode 100644 include/linux/usb/mxs-usb.h

Cc: Chen Peter-B29397 <B29397@freescale.com>
Cc: Detlev Zundel <dzu@denx.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Li Frank-B20596 <B20596@freescale.com>
Cc: Linux USB <linux-usb@vger.kernel.org>
Cc: Liu JunJie-B08287 <B08287@freescale.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Shi Make-B15407 <B15407@freescale.com>
Cc: Stefano Babic <sbabic@denx.de>
Cc: Subodh Nijsure <snijsure@grid-net.com>
Cc: Wolfgang Denk <wd@denx.de>

-- 
1.7.10
