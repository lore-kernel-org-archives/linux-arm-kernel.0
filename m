From: phil@raspberrypi.org (Phil Elwell)
Date: Tue, 9 May 2017 09:20:25 +0100
Subject: [PATCH] ARM: dts: bcm283x: Reserve first page for firmware
Message-ID: <c0c0ac24-b55d-046a-c765-0a2933424ac4@raspberrypi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Raspberry Pi startup stub files for multi-core BCM283X processors
make the secondary CPUs spin until the corresponding mailbox is
written. These stubs are loaded at physical address 0x00000xxx (as seen
by the ARMs), but this page will be reused by the kernel unless it is
explicitly reserved, causing the waiting cores to execute random code.

Use the /memreserve/ Device Tree directive to mark the first page as
off-limits to the kernel.

See: https://github.com/raspberrypi/linux/issues/1989

Signed-off-by: Phil Elwell <phil@raspberrypi.org>
---
 arch/arm/boot/dts/bcm2710-rpi-3-b.dts | 4 ----
 arch/arm/boot/dts/bcm283x.dtsi        | 2 ++
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/bcm2710-rpi-3-b.dts b/arch/arm/boot/dts/bcm2710-rpi-3-b.dts
index b21d286..cbec919 100644
--- a/arch/arm/boot/dts/bcm2710-rpi-3-b.dts
+++ b/arch/arm/boot/dts/bcm2710-rpi-3-b.dts
@@ -1,9 +1,5 @@
 /dts-v1/;
 
-#ifdef RPI364
-/memreserve/ 0x00000000 0x00001000;
-#endif
-
 #include "bcm2710.dtsi"
 #include "bcm283x-rpi-smsc9514.dtsi"
 
diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
index 7d58cd7..0bc1932 100644
--- a/arch/arm/boot/dts/bcm283x.dtsi
+++ b/arch/arm/boot/dts/bcm283x.dtsi
@@ -3,6 +3,8 @@
 #include <dt-bindings/clock/bcm2835-aux.h>
 #include <dt-bindings/gpio/gpio.h>
 
+/memreserve/ 0x00000000 0x00001000;
+
 /* This include file covers the common peripherals and configuration between
  * bcm2835 and bcm2836 implementations, leaving the CPU configuration to
  * bcm2835.dtsi and bcm2836.dtsi.
-- 
1.9.1
