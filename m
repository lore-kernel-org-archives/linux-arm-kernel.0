From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Tue,  6 Dec 2016 18:17:11 +0100
Subject: [PATCH 2/5] ARM: BCM5301X: Specify USB controllers in DT
In-Reply-To: <20161206171714.22738-1-zajec5@gmail.com>
References: <20161206171714.22738-1-zajec5@gmail.com>
Message-ID: <20161206171714.22738-2-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rafa? Mi?ecki <rafal@milecki.pl>

There are 3 separated controllers, one per USB /standard/. With PHY
drivers in place they can be simply supported with generic drivers.

Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>
---
 arch/arm/boot/dts/bcm5301x.dtsi | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm5301x.dtsi b/arch/arm/boot/dts/bcm5301x.dtsi
index f09a2bb..bfc98d19 100644
--- a/arch/arm/boot/dts/bcm5301x.dtsi
+++ b/arch/arm/boot/dts/bcm5301x.dtsi
@@ -248,8 +248,26 @@
 
 			#address-cells = <1>;
 			#size-cells = <1>;
+			ranges;
 
-			phys = <&usb2_phy>;
+			interrupt-parent = <&gic>;
+
+			ohci: ohci at 21000 {
+				#usb-cells = <0>;
+
+				compatible = "generic-ohci";
+				reg = <0x00022000 0x1000>;
+				interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			ehci: ehci at 22000 {
+				#usb-cells = <0>;
+
+				compatible = "generic-ehci";
+				reg = <0x00021000 0x1000>;
+				interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
+				phys = <&usb2_phy>;
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
