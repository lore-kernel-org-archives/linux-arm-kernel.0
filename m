From: baruch@tkos.co.il (Baruch Siach)
Date: Sun, 29 Jan 2017 15:17:30 +0200
Subject: [PATCH] ARM: bcm2835: dts: fix uart1 pinctrl node name
Message-ID: <81ee8da202abbe28e16352e80c1ff94c2e0628c2.1485695850.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Downstream kernel uses pins 32, 33 as UART0 (PL011) Rx/Tx to communicate with
the Bluetooth chip. So ALT3 of these pins is most likely not CTS/RTS. Change
the node name to reflect that.

With this change in place, adding

  &uart0 {
	 pinctrl-names = "default";
	 pinctrl-0 = <&uart0_gpio32 &gpclk2_gpio43>;
	 status = "okay";
  };

to bcm2837-rpi-3-b.dts does the right thing on my Raspberry Pi 3.

Fixes: 21ff843931b ("ARM: dts: bcm283x: Define standard pinctrl groups in the gpio node.")
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
Should uart0_gpio30 be renamed to uart0_ctsrts_gpio30?
---
 arch/arm/boot/dts/bcm283x.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
index 9a44da190897..be6f0bf430ea 100644
--- a/arch/arm/boot/dts/bcm283x.dtsi
+++ b/arch/arm/boot/dts/bcm283x.dtsi
@@ -302,7 +302,7 @@
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
