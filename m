From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Wed,  1 Feb 2017 08:32:18 +0100
Subject: [PATCH RFC] ARM: dts: BCM53573: Specify PCIe card with bcma and
 ChipCommon (DT ranges mess)
Message-ID: <20170201073218.30026-1-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rafa? Mi?ecki <rafal@milecki.pl>

Tenda AC9 has PCIe controller with just one card connected to it:
0000:00:00.0		14e4:d145	Bridge Device
?? 0000:01:00.0		14e4:a8db	Network Controller

This card has bcma bus with GPIO controller on its ChipCommon core. We
need to describe that if we want to reference that GPIO controller in
DT.

This patch adds nested DT entries for:
1) PCIe controller
2) PCIe bridge
3) PCIe wireless card
4) ChipCommon that is on the wireless card

Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>
---
This DT change seems to work, it only requires a simple change in bcma
code of adding bcma_of_fill_device call for PCIe hosted bus.

I'm not convinced about these ranges though. I need them because bcma
uses of_translate_address. AFAIU this function requires ranges to be
specified all the way up till the root node. It means I need to specify
them for every nested node. I also can't simply use:
ranges;
because it works only for #address-cells 1 and #size-cells 1.

Also since ranges expects
parent #address-cells, child #address-cells, #size-cells
I needed different values depending on the node.

Does it look OK to you? Or is there some easier solution?
---
 arch/arm/boot/dts/bcm47189-tenda-ac9.dts | 10 ++++++++++
 arch/arm/boot/dts/bcm53573.dtsi          | 33 ++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/arch/arm/boot/dts/bcm47189-tenda-ac9.dts b/arch/arm/boot/dts/bcm47189-tenda-ac9.dts
index 4403ae8790c2..1c36ee1f94a0 100644
--- a/arch/arm/boot/dts/bcm47189-tenda-ac9.dts
+++ b/arch/arm/boot/dts/bcm47189-tenda-ac9.dts
@@ -48,6 +48,16 @@
 		};
 	};
 
+	pcie0_leds {
+		compatible = "gpio-leds";
+
+		2ghz {
+			label = "bcm53xx:blue:2ghz";
+			gpios = <&pcie0_chipcommon 3 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "default-off";
+		};
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys";
 		#address-cells = <1>;
diff --git a/arch/arm/boot/dts/bcm53573.dtsi b/arch/arm/boot/dts/bcm53573.dtsi
index 2da04d0a7348..b55491da63d7 100644
--- a/arch/arm/boot/dts/bcm53573.dtsi
+++ b/arch/arm/boot/dts/bcm53573.dtsi
@@ -113,6 +113,39 @@
 			};
 		};
 
+		pcie0: pcie at 12000 {
+			reg = <0x00002000 0x1000>;
+
+			/* All code below looks device specific and should go to
+			 * the device DT. It's here only for RFC patch needs to
+			 * make it easier to review.
+			 */
+			ranges = <0x00000000 0 0 0 0 0x00100000>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			bridge at 0,0,0 {
+				reg = <0x0000 0 0 0 0>;
+				ranges = <0x00000000 0 0 0 0 0 0 0x00100000>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+
+				wifi at 0,1,0 {
+					reg = <0x0000 0 0 0 0>;
+					ranges = <0x00000000 0 0 0 0x00100000>;
+					#address-cells = <1>;
+					#size-cells = <1>;
+
+					pcie0_chipcommon: chipcommon at 0 {
+						reg = <0 0x1000>;
+
+						gpio-controller;
+						#gpio-cells = <2>;
+					};
+				};
+			};
+		};
+
 		usb2: usb2 at 4000 {
 			reg = <0x4000 0x1000>;
 			ranges;
-- 
2.11.0
