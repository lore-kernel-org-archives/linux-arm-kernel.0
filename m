From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 17 Dec 2012 08:59:07 +0100
Subject: devicetree support for efikasb
Message-ID: <20121217075907.GQ24458@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I recently put some work into my Efika MX smartbook. Here are patches
to make it work with a current kernel. It turned out that most of the
stuff is quite straight forward. Unfortunately there is a lot missing
in the USB area. Without USB support the Smartbook is pretty much
useless, so most of the patches are for adding USB support.

What currently works is:

- USB
- Display
- Battery
- keyboard/touchpad
- Sound (used to work, currently broken)
- Wifi
- LEDs

I'm not posting the patches here since I do not consider them ready, but
for everyone interested you can pull the following git tree. I have no
idea if the patches work together with the preinstalled U-Boot, I use
barebox on the Smartbook.

Since it's a spare time project I have no schedule when to continue. If
you want to push this forward, please let me know, I may have soemthing
newer then.

Sascha


The following changes since commit 11520e5e7c1855fc3bf202bb3be35a39d9efa034:

  Revert "x86-64/efi: Use EFI to deal with platform wall clock (again)" (2012-12-15 15:20:41 -0800)

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git work/efikasb

for you to fetch changes up to 4de30514cbd7126ba06062e39ba4701f2bca1a37:

  ARM i.MX: Adjust imx_v6_v7_defconfig for efikasb (2012-12-16 19:10:06 +0100)

----------------------------------------------------------------
Marc Kleine-Budde (5):
      usb: chipidea: usbmisc: unset global varibale usbmisc on driver remove
      usb: chipidea: usbmisc: fix a potential race condition
      usb: chipidea: usbmisc: prepare driver to handle more than one soc
      usb: chipidea: usbmisc: add support for ahb, ipg and per clock
      usb: chipidea: ci13xxx-imx: add "dr_mode" property to device tree bindings

Michael Grzeschik (8):
      ARM: dts: imx: rename imx5x usb entries as in imx6q.dtsi
      ARM: dts: imx: add imx5x phy-mode entries
      usb: chipidea: usbmisc: rename file, struct and functions to usbmisc_imx
      usb: chipidea: usbmisc: add mx53 support
      usb: chipidea: usbmisc: add post handling and errata fix for mx25
      usb: chipidea: ci13xxx_imx: add 2nd and 3rd clock to support imx5x and newer
      usb: add phy connection by phy-mode
      usb: chipidea: ci13xxx-imx: create dynamic platformdata

Peter Chen (5):
      Revert "USB: chipidea: add vbus detect for udc"
      usb: chipidea: add otg file
      usb: chipidea: add otg id switch and vbus connect/disconnect detect
      usb: chipidea: create the gadget at ci_hdrc_probe even at host role
      usb: chipidea: imx: add internal vbus regulator control

Sascha Hauer (11):
      usb chipidea: Add ULPI support
      Arm i.MX5 clk: Add PATA and SRTC clocks
      ARM i.MX51: Add PATA support
      ata i.MX pata: Set bus timing
      RTC i.MX dryice: Add devicetree support
      ARM i.MX5 dts: Add SRTC device
      ARM i.MX51 dts: Add clocks to USB devices
      DRM i.MX: Add efika LVDS support
      ARM i.MX: Add Efika Smartbook devicetree
      ARM efikasb: HACK: enable backlight
      ARM i.MX: Adjust imx_v6_v7_defconfig for efikasb

 .../devicetree/bindings/clock/imx5-clock.txt       |    2 +
 .../devicetree/bindings/usb/ci13xxx-imx.txt        |    6 +
 arch/arm/boot/dts/Makefile                         |    1 +
 arch/arm/boot/dts/imx28.dtsi                       |    2 +
 arch/arm/boot/dts/imx51-genesi-efika-sb.dts        |  312 +++++++++++++
 arch/arm/boot/dts/imx51.dtsi                       |   70 ++-
 arch/arm/boot/dts/imx53.dtsi                       |   18 +-
 arch/arm/configs/imx_v6_v7_defconfig               |   49 +-
 arch/arm/mach-imx/clk-imx51-imx53.c                |    4 +-
 arch/arm/mach-imx/imx51-dt.c                       |   36 ++
 drivers/ata/pata_imx.c                             |   70 +++
 drivers/of/Kconfig                                 |   12 +
 drivers/of/Makefile                                |    1 +
 drivers/of/of_usbphy.c                             |   49 ++
 drivers/rtc/Kconfig                                |    2 +-
 drivers/rtc/rtc-imxdi.c                            |   11 +
 drivers/staging/imx-drm/Kconfig                    |    4 +
 drivers/staging/imx-drm/Makefile                   |    1 +
 drivers/staging/imx-drm/mtl017.c                   |  469 ++++++++++++++++++++
 drivers/usb/chipidea/Kconfig                       |    1 +
 drivers/usb/chipidea/Makefile                      |    4 +-
 drivers/usb/chipidea/bits.h                        |   13 +
 drivers/usb/chipidea/ci.h                          |   19 +-
 drivers/usb/chipidea/ci13xxx_imx.c                 |  158 +++++--
 drivers/usb/chipidea/ci13xxx_imx.h                 |    3 +
 drivers/usb/chipidea/core.c                        |  290 ++++++++++--
 drivers/usb/chipidea/host.c                        |   16 +
 drivers/usb/chipidea/otg.c                         |   61 +++
 drivers/usb/chipidea/otg.h                         |    6 +
 drivers/usb/chipidea/udc.c                         |   41 +-
 drivers/usb/chipidea/usbmisc_imx.c                 |  256 +++++++++++
 drivers/usb/chipidea/usbmisc_imx6q.c               |  162 -------
 include/linux/of_usbphy.h                          |   15 +
 include/linux/usb/chipidea.h                       |   16 +
 include/linux/usb/phy.h                            |    8 +
 35 files changed, 1894 insertions(+), 294 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx51-genesi-efika-sb.dts
 create mode 100644 drivers/of/of_usbphy.c
 create mode 100644 drivers/staging/imx-drm/mtl017.c
 create mode 100644 drivers/usb/chipidea/otg.c
 create mode 100644 drivers/usb/chipidea/otg.h
 create mode 100644 drivers/usb/chipidea/usbmisc_imx.c
 delete mode 100644 drivers/usb/chipidea/usbmisc_imx6q.c
 create mode 100644 include/linux/of_usbphy.h
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
