From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sat, 11 Aug 2012 19:10:29 +0200
Subject: [v2] gpio: mvebu: new gpio driver for mvebu platforms
Message-ID: <1344705034-18173-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch set adds a new GPIO driver for Marvell EBU SoCs, which aims
at replacing the existing GPIO driver from plat-orion/gpio.c. The
driver comes with the necessary DT changes to make it work on Armada
370 and Armada XP, and it has been tested successfully by Sebastian
Hesselbarth on Dove. It should also work flawlessly on other Marvell
EBU SoCs (Kirkwood, Orion, Discovery), but this remains to be tested
by the relevant maintainers.

This new driver reuses a lot of code from the existing
plat-orion/gpio.c driver, but has a number of advantages:

 *) Support for Armada 370 and Armada XP
 *) It is integrated with the mvebu pinctrl driver so that GPIO pins
    are properly muxed, and the GPIO driver knows which GPIO pins are
    output-only or input-only. This driver has been submitted by
    Sebastian Hesselbarth today on the LAKML.
 *) Properly placed in drivers/gpio
 *) More extensible mechanism to support platform differences. The
    plat-orion driver uses a simple mask-offset DT property, which
    works fine for Discovery MV78200 but not for Armada XP. The new
    driver uses different compatible strings to identify the different
    variants of the GPIO controllers.

Changes since v1:
 * Added fixes for Dove from Sebastian Hesselbarth, and his Tested-by
   on the driver patch.

Thanks,

Thomas

The following changes since commit 872b6be95abf9d57e0639d0345fa2b5a0e4fa0f4:

  arm: mvebu: add pinctrl support in defconfig (2012-08-11 11:27:33 +0200)

are available in the git repository at:

  git://github.com/MISL-EBU-System-SW/mainline-public.git mvebu-gpio

for you to fetch changes up to c6347492639521d79e541a90fe2dfeec07d9b1a2:

  arm: mvebu: add gpio support in defconfig (2012-08-11 19:06:40 +0200)

----------------------------------------------------------------
Thomas Petazzoni (5):
      gpio: introduce gpio-mvebu driver for Marvell SoCs
      Documentation: add description of DT binding for the gpio-mvebu driver
      arm: mvebu: use GPIO support now that a driver is available
      arm: mvebu: add DT information for GPIO banks on Armada 370 and XP
      arm: mvebu: add gpio support in defconfig

 .../devicetree/bindings/gpio/gpio-mvebu.txt        |   44 ++
 arch/arm/Kconfig                                   |    1 +
 arch/arm/boot/dts/armada-370.dtsi                  |   30 +
 arch/arm/boot/dts/armada-xp-mv78230.dtsi           |   22 +
 arch/arm/boot/dts/armada-xp-mv78260.dtsi           |   33 +
 arch/arm/boot/dts/armada-xp-mv78460.dtsi           |   33 +
 arch/arm/configs/mvebu_defconfig                   |    2 +
 arch/arm/mach-mvebu/include/mach/gpio.h            |    1 +
 drivers/gpio/Kconfig                               |    6 +
 drivers/gpio/Makefile                              |    1 +
 drivers/gpio/gpio-mvebu.c                          |  656 ++++++++++++++++++++
 11 files changed, 829 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-mvebu.txt
 create mode 100644 arch/arm/mach-mvebu/include/mach/gpio.h
 create mode 100644 drivers/gpio/gpio-mvebu.c
