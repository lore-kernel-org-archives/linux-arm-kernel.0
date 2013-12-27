From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 26 Dec 2013 19:43:10 -0700
Subject: [PATCH 2/3] ARM: bcm2835: add USB controller to device tree
In-Reply-To: <1388112192-4762-1-git-send-email-swarren@wwwdotorg.org>
References: <1388112192-4762-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1388112192-4762-2-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The BCM2835 SoC contains a DWC2 USB controller. Add this to the DT.

Set up the pin controller to fully enable the USB controller on the
Raspberry Pi. The GPIO setup works because the default output value for
GPIO 6 (LAN_RUN/n_reset) just happens to be 1, which enables the
USB/LAN chip.

Note that you'll need a U-Boot which enables power to the USB controller;
search for U-Boot patch "ARM: rpi_b: power on SDHCI and USB HW modules".

Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
---
I imagine this will go into a dt or boards branch.

 arch/arm/boot/dts/bcm2835-rpi-b.dts |    9 +++++++--
 arch/arm/boot/dts/bcm2835.dtsi      |    6 ++++++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/bcm2835-rpi-b.dts b/arch/arm/boot/dts/bcm2835-rpi-b.dts
index 6e9deb7..2a3b1c1 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-b.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-b.dts
@@ -23,10 +23,15 @@
 
 &gpio {
 	pinctrl-names = "default";
-	pinctrl-0 = <&alt0 &alt3>;
+	pinctrl-0 = <&gpioout &alt0 &alt3>;
+
+	gpioout: gpioout {
+		brcm,pins = <6>;
+		brcm,function = <1>; /* GPIO out */
+	};
 
 	alt0: alt0 {
-		brcm,pins = <0 1 2 3 4 5 6 7 8 9 10 11 14 15 40 45>;
+		brcm,pins = <0 1 2 3 4 5 7 8 9 10 11 14 15 40 45>;
 		brcm,function = <4>; /* alt0 */
 	};
 
diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi
index 1e12aef..71a78f7 100644
--- a/arch/arm/boot/dts/bcm2835.dtsi
+++ b/arch/arm/boot/dts/bcm2835.dtsi
@@ -103,6 +103,12 @@
 			clocks = <&clk_mmc>;
 			status = "disabled";
 		};
+
+		usb {
+			compatible = "brcm,bcm2835-usb";
+			reg = <0x7e980000 0x10000>;
+			interrupts = <1 9>;
+		};
 	};
 
 	clocks {
-- 
1.7.10.4
