From: abailon@baylibre.com (Alexandre Bailon)
Date: Tue, 24 Jan 2017 11:22:52 +0100
Subject: [PATCH v4] ARM: dts: da850: Add the CPPI 4.1 DMA to the USB OTG
 controller
Message-ID: <20170124102252.15142-1-abailon@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the CPPI 4.1 DMA controller to the USB OTG controller.

Changes since v3:
- Don't use a wildcard for compatible property.

Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
---
 arch/arm/boot/dts/da850.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 104155d..f4a637a 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -396,12 +396,37 @@
 		usb0: usb at 200000 {
 			compatible = "ti,da830-musb";
 			reg = <0x200000 0x10000>;
+			ranges;
 			interrupts = <58>;
 			interrupt-names = "mc";
 			dr_mode = "otg";
 			phys = <&usb_phy 0>;
 			phy-names = "usb-phy";
 			status = "disabled";
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			dmas = <&cppi41dma 0 0 &cppi41dma 1 0
+				&cppi41dma 2 0 &cppi41dma 3 0
+				&cppi41dma 0 1 &cppi41dma 1 1
+				&cppi41dma 2 1 &cppi41dma 3 1>;
+			dma-names =
+				"rx1", "rx2", "rx3", "rx4",
+				"tx1", "tx2", "tx3", "tx4";
+
+			cppi41dma: dma-controller at 201000 {
+				compatible = "ti,da830-cppi41";
+				reg =  <0x201000 0x1000
+					0x202000 0x1000
+					0x204000 0x4000>;
+				reg-names = "controller",
+					    "scheduler", "queuemgr";
+				interrupts = <58>;
+				#dma-cells = <2>;
+				#dma-channels = <4>;
+				status = "okay";
+			};
 		};
 		mdio: mdio at 224000 {
 			compatible = "ti,davinci_mdio";
-- 
2.10.2
