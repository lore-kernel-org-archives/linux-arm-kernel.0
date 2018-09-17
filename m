From: phil@raspberrypi.org (Phil Elwell)
Date: Mon, 17 Sep 2018 09:22:20 +0100
Subject: [PATCH v3 0/4] Improve VCHIQ cache line size handling
Message-ID: <1537172544-104852-1-git-send-email-phil@raspberrypi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Both sides of the VCHIQ communications mechanism need to agree on the cache
line size. Using an incorrect value can lead to data corruption, but having the
two sides using different values is usually worse.

In the absence of an obvious convenient run-time method to determine the
correct value in the ARCH=arm world, the downstream Raspberry Pi trees used a
Device Tree property, written by the firmware, to configure the kernel driver.
This method was vetoed during the upstreaming process, so a fixed value of 32
was used instead, and some corruptions ensued. This is take 2 at arriving at
the correct value.

Add a new compatible string - "brcm,bcm2836-vchiq" - to indicate an SoC with
a 64-byte cache line. Document the new string in the binding, and use it on
the appropriate platforms.

The final patch is a (seemingly cosmetic) correction of the Device Tree "reg"
declaration for the device node, but it doubles as an indication to the
Raspberry Pi firmware that the kernel driver is running a recent kernel driver
that chooses the correct value. As such it would help if the DT patches are
not merged before the driver patch.

v3: Builds without errors, tested on multiple Raspberry Pi models.
v2: Replaced ARM-specific logic used to determine cache line size with
    a new compatible string for BCM2836 and BCM2837.

Phil Elwell (4):
  staging/vc04_services: Use correct cache line size
  dt-bindings: soc: Document "brcm,bcm2836-vchiq"
  ARM: dts: bcm283x: Correct vchiq compatible string
  ARM: dts: bcm283x: Correct mailbox register sizes

 .../bindings/soc/bcm/brcm,bcm2835-vchiq.txt        |  3 +-
 arch/arm/boot/dts/bcm2835-rpi.dtsi                 |  4 +--
 arch/arm/boot/dts/bcm2836-rpi-2-b.dts              |  2 +-
 arch/arm/boot/dts/bcm2836-rpi.dtsi                 |  6 ++++
 arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts         |  2 +-
 arch/arm/boot/dts/bcm2837-rpi-3-b.dts              |  2 +-
 arch/arm/boot/dts/bcm2837-rpi-cm3.dtsi             |  2 +-
 .../interface/vchiq_arm/vchiq_2835_arm.c           |  4 ++-
 .../vc04_services/interface/vchiq_arm/vchiq_arm.c  | 35 +++++++++++++++-------
 .../vc04_services/interface/vchiq_arm/vchiq_arm.h  |  5 ++++
 10 files changed, 47 insertions(+), 18 deletions(-)
 create mode 100644 arch/arm/boot/dts/bcm2836-rpi.dtsi

-- 
2.7.4
