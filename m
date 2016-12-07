From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Wed,  7 Dec 2016 08:56:52 +0100
Subject: [PATCH V2 2/5] ARM: BCM5301X: Specify USB controllers in DT
In-Reply-To: <20161207075655.7396-1-zajec5@gmail.com>
References: <20161207075655.7396-1-zajec5@gmail.com>
Message-ID: <20161207075655.7396-2-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rafa? Mi?ecki <rafal@milecki.pl>

There are 3 separated controllers, one per USB /standard/. With PHY
drivers in place they can be simply supported with generic drivers.

Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>
---
V2: Fix node names and reorder ehci with ohci. Thanks Ray!
---
 arch/arm/boot/dts/bcm5301x.dtsi | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm5301x.dtsi b/arch/arm/boot/dts/bcm5301x.dtsi
index f09a2bb..a4614c9 100644
--- a/arch/arm/boot/dts/bcm5301x.dtsi
+++ b/arch/arm/boot/dts/bcm5301x.dtsi
@@ -248,8 +248,26 @@
 
 			#address-cells = <1>;
 			#size-cells = <1>;
+			ranges;
 
-			phys = <&usb2_phy>;
+			interrupt-parent = <&gic>;
+
+			ehci: ehci at 21000 {
+				#usb-cells = <0>;
+
+				compatible = "generic-ehci";
+				reg = <0x00021000 0x1000>;
+				interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
+				phys = <&usb2_phy>;
+			};
+
+			ohci: ohci at 22000 {
+				#usb-cells = <0>;
+
+				compatible = "generic-ohci";
+				reg = <0x00022000 0x1000>;
+				interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
+			};
 		};
 
 		usb3: usb3 at 23000 {
@@ -257,6 +275,19 @@
 
 			#address-cells = <1>;
 			#size-cells = <1>;
+			ranges;
+
+			interrupt-parent = <&gic>;
+
+			xhci: xhci at 23000 {
+				#usb-cells = <0>;
+
+				compatible = "generic-xhci";
+				reg = <0x00023000 0x1000>;
+				interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
+				phys = <&usb3_phy>;
+				phy-names = "usb";
+			};
 		};
 
 		spi at 29000 {
-- 
2.10.1
