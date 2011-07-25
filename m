From: tony.lin@freescale.com (Tony Lin)
Date: Mon, 25 Jul 2011 15:01:18 +0800
Subject: [PATCH v2 0/6] ARM: mx28: add usb host function
Message-ID: <1311577284-11506-1-git-send-email-tony.lin@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

this patch series is to add mx28 usb host function.
the driver only support usb host mode on usb port1.
the driver reuses ehci-mxc.c under usb/host, but did
some modifications based on it to satisfy mx28 usb host
requirement. The modifications will not affect other
platforms.

Code is based on the branch for-next in sascha's tree http://git.pengutronix.de/git/imx/linux-2.6.git

Tested on MX28 EVK.

changes since v1:
 * add dummy clock to avoid adding cpu judgement in driver for Sascha's request.
 * use context in phy functions, so that usb device could share the code.
 * some code consolidation and patch reorgnization.
 * error checking improvement.
 * remove a few unneccesary code.

Tony Lin (6):
  ARM: mxs: ehci: consolidate definitions and structures to share among platforms
  ARM: mxs: enable usb1 phy power supply
  ARM: mxs: add usb clocks to clock tree
  ARM: mxs: make ehci-mxc more flexible to be used on different platforms
  ARM: mxs: add usb phy operations
  ARM: mxs: add usb host function to default config

 arch/arm/configs/mxs_defconfig            |    8 +-
 arch/arm/mach-mxs/Kconfig                 |    1 +
 arch/arm/mach-mxs/Makefile                |    1 +
 arch/arm/mach-mxs/clock-mx28.c            |   28 ++-
 arch/arm/mach-mxs/include/mach/hardware.h |    2 +
 arch/arm/mach-mxs/include/mach/mxs.h      |   12 +-
 arch/arm/mach-mxs/mach-mx28evk.c          |    8 +
 arch/arm/mach-mxs/mxs_usb.c               |  286 +++++++++++++++++++++++++++++
 arch/arm/mach-mxs/regs-usbphy-mx28.h      |  240 ++++++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/mxc_ehci.h |   19 --
 drivers/usb/host/Kconfig                  |    2 +-
 drivers/usb/host/ehci-mxc.c               |   21 ++-
 include/linux/fsl_devices.h               |   21 ++
 13 files changed, 613 insertions(+), 36 deletions(-)
 create mode 100644 arch/arm/mach-mxs/mxs_usb.c
 create mode 100644 arch/arm/mach-mxs/regs-usbphy-mx28.h
