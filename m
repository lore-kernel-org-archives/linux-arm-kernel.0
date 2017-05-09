From: phil@raspberrypi.org (Phil Elwell)
Date: Tue, 9 May 2017 10:04:30 +0100
Subject: [PATCH V2] ARM: dts: bcm283x: Reserve first page for firmware
Message-ID: <b6aef857-1454-7931-2c60-6d7b55b7a0a8@raspberrypi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Raspberry Pi startup stub files for multi-core BCM27XX processors
make the secondary CPUs spin until the corresponding mailbox is
written. These stubs are loaded at physical address 0x00000xxx (as seen
by the ARMs), but this page will be reused by the kernel unless it is
explicitly reserved, causing the waiting cores to execute random code.

Use the /memreserve/ Device Tree directive to mark the first page as
off-limits to the kernel.

See: https://github.com/raspberrypi/linux/issues/1989

Signed-off-by: Phil Elwell <phil@raspberrypi.org>
---

Changes in V2:
- Rebase against linux-next
- Drop downstream-only patch

 arch/arm/boot/dts/bcm283x.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
index a3106aa..6d12c3e8 100644
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
