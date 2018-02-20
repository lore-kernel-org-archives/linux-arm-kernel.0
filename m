From: baruch@tkos.co.il (Baruch Siach)
Date: Tue, 20 Feb 2018 14:19:30 +0200
Subject: [PATCH v5 0/5] gpio: driver for the RPi3 GPIO expander
Message-ID: <cover.1519128054.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Raspberry Pi 3 has a GPIO expander that controls, among others, the 
activity LED, and the camera connector GPIOs. The GPIO expander on an I2C bus 
that is not directly controlled from the ARM core. The VC4 firmware controls 
the I2C bus, and allows the ARM core to set/get GPIO settings over its mailbox 
interface.

This series adds support for the RPi3 expander.

The driver is ported from the downstream kernel at 
https://github.com/raspberrypi/linux/, branch rpi-4.9.y.

This series is based on commit v4.16-rc2.

Changes in v5:

  * Remove the 'firmware' property from the binding as suggested by Rob
    Herring. The firmware node is the parent of the gpio node, so use
    of_get_parent() instead of a phandle.

Changes in v4:

  * Move the gpio expander node under the firmware node; this requires an
    addtional patch that makes the firmware node into a bus
  * Rename the gpio node to just 'gpio'
  * Drop the platform driver .owner set

Changes in v3:

  * Kconfig tweaks
  * Check rpi_exp_gpio_get_polarity() return value
  * Redundant header removal
  * Redundant platform_set_drvdata() call removal
  * Small coding style changes

Changes in v2:

  * Driver renamed to gpio-raspberrypi-exp
  * Compatible string renamed to "raspberrypi,firmware-gpio"
  * Firmware error check
  * Smaller tweaks listed in individual patches

Baruch Siach (4):
  ARM: bcm2835: sync firmware properties with downstream
  dt-bindings: gpio: add raspberry pi GPIO expander binding
  ARM: dts: bcm2835: make the firmware node into a bus
  ARM: dts: bcm2837-rpi-3-b: add GPIO expander

Dave Stevenson (1):
  gpio: raspberrypi-exp: Driver for RPi3 GPIO expander via mailbox
    service

 .../bindings/gpio/raspberrypi,firmware-gpio.txt    |  30 +++
 arch/arm/boot/dts/bcm2835-rpi.dtsi                 |   4 +-
 arch/arm/boot/dts/bcm2837-rpi-3-b.dts              |  17 ++
 drivers/gpio/Kconfig                               |   9 +
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-raspberrypi-exp.c                | 252 +++++++++++++++++++++
 include/soc/bcm2835/raspberrypi-firmware.h         |  18 ++
 7 files changed, 330 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/raspberrypi,firmware-gpio.txt
 create mode 100644 drivers/gpio/gpio-raspberrypi-exp.c

-- 
2.16.1
