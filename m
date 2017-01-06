From: david@lechnology.com (David Lechner)
Date: Thu,  5 Jan 2017 22:33:43 -0600
Subject: [PATCH v2 0/5] Support for LEGO MINDSTORMS EV3
Message-ID: <1483677228-2325-1-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds support for LEGO MINDSTORMS EV3. This is a TI AM1808
based board.

v2 changes:
* Dropped defconfig patches that have already been pick up
* Added some new defconfig patches
* Updated device tree file based on feedback and new available bindings
  * Renamed file to include da850- prefix
  * Changed button labels
  * Fixed LED names
  * Added beeper device for sound
  * Added regulators for USB and A/DC
  * Removed unused pinmux nodes
  * Added pinconf for buttons
  * Enabled pwms
  * Used preferred bindings for flash partitions
  * Added A/DC spi device
  * Enabled USB

This patch series has been tested working on next-20170105 with linux-davinci/
next merged into it, along with a few other patches that have been submitted.

Dependencies:

i.e. Things that are not in next-20170105 or linux-davinci/next already. I know
this seems like a long list, but most of these are just small fixes and not
necessarily strict dependencies.

* "iio: adc: New driver for TI ADS7950 chips" [1]
  This patch is currently in iio/testing. It is expected to be included as-is
  in v4.11.

* "ARM: davinci: Allocate extra interrupts" [2]
  This patch has been submitted but has not received any feedback. It is not
  critical, but needed to use the trigger capabilities of iio.

* "spi: davinci: Allow device tree devices to use DMA" [3]
  This has been (re)submitted, but no response from spi maintainer yet. It is
  needed for the flash memory to work correctly.

* "ARM: dts: da850: Add usb device node" [4]
  The dependencies that were holding up this patch are all merged, so it is OK
  to pick up this patch in linux-davinci now.

* "regulator: fixed: Handle optional overcurrent pin" [5]
  This is used by the USB/input port/output port/ADC regulator. This patch has
  been slow in getting accepted into regulator.

* "serial: 8250: Add new port type for TI DA8xx/66AK2x" [6]
  "ARM: da850: Add ti,da830-uart compatible for serial ports" [7]
  This series fixes UART0 and UART2 not working. Waiting for patch to be picked
  up in serial tree.

* "Input: pwm-beeper: add optional enable gpio" [8]
  I just submitted this patch, so we will see what happens. It is needed for
  the speaker to actually make sound.


[1]: https://patchwork.kernel.org/patch/9449767/
[2]: https://patchwork.kernel.org/patch/9438709/
[3]: https://patchwork.kernel.org/patch/9499937/
[4]: https://patchwork.kernel.org/patch/9439839/
[5]: https://patchwork.kernel.org/patch/9476509/
[6]: https://patchwork.kernel.org/patch/9499459/
[7]: https://patchwork.kernel.org/patch/9499457/
[8]: https://patchwork.kernel.org/patch/9499919/


David Lechner (5):
  ARM: davinci_all_defconfig: enable DA8xx pinconf
  ARM: davinci_all_defconfig: Enable PWM modules
  ARM: davinci_all_defconfig: enable iio and ADS7950
  ARM: davinci_all_defconfig: enable pwm-beeper
  ARM: dts: Add LEGO MINDSTORMS EV3 dts

 arch/arm/boot/dts/Makefile             |   3 +-
 arch/arm/boot/dts/da850-lego-ev3.dts   | 381 +++++++++++++++++++++++++++++++++
 arch/arm/configs/davinci_all_defconfig |  12 ++
 3 files changed, 395 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/da850-lego-ev3.dts

-- 
2.7.4
