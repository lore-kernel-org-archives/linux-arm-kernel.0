From: eric@anholt.net (Eric Anholt)
Date: Tue, 20 Nov 2018 09:19:52 -0800
Subject: [PATCH 0/8] BCM2835 PM driver
Message-ID: <20181120172000.15102-1-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series moves the BCM2835 WDT driver that controls a fraction of
the PM block out to soc/ and adds most of the rest of its
functionality.  My motivation has been to have V3D be functional
without firmware calls, probably improve its interactivity (since
we'll be able to power on/off without RPC to the firmware that may be
busy with other tasks), and (in a patch not submitted in this series)
extend its binding to use the reset controller instead of trying to
reset by toggling its power domain.

I've tested V3D with a few hours of running a V3D test, sleep(1) (to
trigger PM domain off); running a GPU hang job (to trigger reset);
sleep(1).  The non-hanging success-case job always passed, and dmesg
had no complaints from bcm2835-pm.  The other power domains are not
tested, but I've done my best.

This series will probably also be of interest to the
https://github.com/christinaa/rpi-open-firmware project for enabling USB.

Eric Anholt (8):
  watchdog: bcm2835: Move the driver to the soc/ directory.
  soc: bcm: bcm2835-pm: Rename the driver to its new "PM" name.
  soc: bcm: bcm2835-pm: Stop using _relaxed mmio accessors.
  soc: bcm: bcm2835-pm: Make some little accessor macros for the mmio
    area.
  dt-bindings: soc: Add a new binding for the BCM2835 PM node.
  soc: bcm: bcm2835-pm: Add support for power domains under a new
    binding.
  ARM: bcm283x: Extend the WDT DT node out to cover the whole PM block.
  ARM: bcm283x: Switch V3D over to using the PM driver instead of
    firmware.

 .../bindings/soc/bcm/brcm,bcm2835-pm.txt      |  42 +
 arch/arm/boot/dts/bcm2835-rpi.dtsi            |   4 -
 arch/arm/boot/dts/bcm283x.dtsi                |  16 +-
 arch/arm/mach-bcm/Kconfig                     |   1 +
 drivers/soc/bcm/Makefile                      |   1 +
 drivers/soc/bcm/bcm2835-pm.c                  | 866 ++++++++++++++++++
 drivers/watchdog/Kconfig                      |  11 -
 drivers/watchdog/Makefile                     |   1 -
 drivers/watchdog/bcm2835_wdt.c                | 254 -----
 include/dt-bindings/soc/bcm2835-pm.h          |  28 +
 10 files changed, 951 insertions(+), 273 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.txt
 create mode 100644 drivers/soc/bcm/bcm2835-pm.c
 delete mode 100644 drivers/watchdog/bcm2835_wdt.c
 create mode 100644 include/dt-bindings/soc/bcm2835-pm.h

-- 
2.19.1
