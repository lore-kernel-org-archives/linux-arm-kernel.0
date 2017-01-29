From: baruch@tkos.co.il (Baruch Siach)
Date: Sun, 29 Jan 2017 20:40:59 +0200
Subject: [PATCH v2] ARM: bcm2835: dts: fix uart0 pinctrl node names
Message-ID: <f37d02c769d0e2b6db2529cafb86b5fdd1e09a94.1485715259.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Downstream kernel uses pins 32, 33 as UART0 (PL011) Rx/Tx to communicate with
the Bluetooth chip. So ALT3 of these pins is most likely not CTS/RTS. Change
the node name to reflect that. This matches section 6.2 "Alternative Function
Assignments" in the BCM2835 ARM Peripherals document.

With this change in place, adding

  &uart0 {
	 pinctrl-names = "default";
	 pinctrl-0 = <&uart0_gpio32 &gpclk2_gpio43>;
	 status = "okay";
  };

to bcm2837-rpi-3-b.dts does the right thing on my Raspberry Pi 3.

Pins 30, 31 are CTS/RTS of UART0 in alternate function 3. Rename uart0_gpio30
as well.

While at it, fix a little typo in a nearby comment.

Fixes: 21ff843931b ("ARM: dts: bcm283x: Define standard pinctrl groups in the gpio node.")
Acked-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
v2:
   * Reference the ARM Peripherals document
   * Fix subject typo (Stefan)
   * Rename also uart0_gpio30 (Stefan)
   * Add comment typo fix (Stefan)
   * Add Stefan's ack
---
 arch/arm/boot/dts/bcm283x.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
index 9a44da190897..bc8ad417c8a3 100644
--- a/arch/arm/boot/dts/bcm283x.dtsi
+++ b/arch/arm/boot/dts/bcm283x.dtsi
@@ -292,17 +292,17 @@
 			/* Separate from the uart0_gpio14 group
 			 * because it conflicts with spi1_gpio16, and
 			 * people often run uart0 on the two pins
-			 * without flow contrl.
+			 * without flow control.
 			 */
 			uart0_ctsrts_gpio16: uart0_ctsrts_gpio16 {
 				brcm,pins = <16 17>;
 				brcm,function = <BCM2835_FSEL_ALT3>;
 			};
-			uart0_gpio30: uart0_gpio30 {
+			uart0_ctsrts_gpio30: uart0_ctsrts_gpio30 {
 				brcm,pins = <30 31>;
 				brcm,function = <BCM2835_FSEL_ALT3>;
 			};
-			uart0_ctsrts_gpio32: uart0_ctsrts_gpio32 {
+			uart0_gpio32: uart0_gpio32 {
 				brcm,pins = <32 33>;
 				brcm,function = <BCM2835_FSEL_ALT3>;
 			};
-- 
2.11.0
