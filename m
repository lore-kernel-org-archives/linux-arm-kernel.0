From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Fri,  9 Sep 2016 07:49:53 +0000
Subject: [PATCH V4 0/4] thermal: bcm2835: add thermal driver
Message-ID: <1473407397-29395-1-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

Add a thermal driver for the TSENSE device of the bcm2835 SOC.

If the firmware enables the HW, then the configuration is not touched.
In case the firmware has not enabled the device, then we try to set
it up correctly (which unfortunately can not get tested).

It exposes temperature and a critical trip point
(using a hardcoded default of 80C or the temperature configured
in the control register by the firmware, which reads as
407C currently)

The calibrations are (potentially) different for bcm2835, bcm2836
and bcm2837 and can get selected by the compatible property
in the device tree.

The driver also exposes the registers via debugfs.

Possible future enhancements:
* the device has the ability to trigger interrupts on reaching
  the programmed critical temperature.
  I have no knowledge which interrupt could be responsible
  for this on the ARM side, so if we get to know which irq
  it is we can implement that.
  Instead the driver right now implements polling in 1 second intervals
* the device can also reset the HW after the trip point
  has been reached (also with some delay, so that corrective
  actions can get taken) - this is currently not enabled by the
  firmware, but could.
* we could define more trip points for THERMAL_TRIP_HOT
* make the trip point limits modifiable (ops.set_trip_temp)

Changelog:
 V1 -> V2: renamed dt-binding documentation file
       	   added specific settings depending on compatible
	   added trip point based on register
	   setting up ctrl-register if HW is not enabled by firmware
	     as per recommendation of Eric (untested)
	   check that clock frequency is in range
	     (1.9 - 5MHz - as per comment in clk-bcm2835.c)
 	   added driver to multi_v7_defconfig
 V2 -> V3: made a module in multi_v7_defconfig
           fixed typo in dt-binding document
 V3 -> V4: moved driver back to thermal (not using bcm sub-directory)
       	   set polling interval to 1second (was 0ms, so interrupt driven)

Martin Sperl (4):
  dt: bindings: add thermal device driver for bcm2835
  thermal: bcm2835: add thermal driver for bcm2835 soc
  ARM: bcm2835: add thermal node to device-tree of bcm283x
  ARM: bcm2835: add thermal driver to default_config

 .../bindings/thermal/brcm,bcm2835-thermal.txt      |  17 ++
 arch/arm/boot/dts/bcm283x.dtsi                     |   6 +
 arch/arm/configs/bcm2835_defconfig                 |   2 +
 drivers/thermal/Kconfig                            |   5 +
 drivers/thermal/Makefile                           |   1 +
 drivers/thermal/bcm2835_thermal.c                  | 327 +++++++++++++++++++++
 6 files changed, 358 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/brcm,bcm2835-thermal.txt
 create mode 100644 drivers/thermal/bcm2835_thermal.c

--
2.1.4
