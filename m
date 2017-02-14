From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Tue, 14 Feb 2017 17:49:05 +0100
Subject: [PATCH 1/2] ARM: dts: BCM53573: Describe Tenda AC9 PCIe card in DT
Message-ID: <20170214164906.19245-1-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rafa? Mi?ecki <rafal@milecki.pl>

Tenda AC9 has PCIe controller with just one device connected to it:
0000:00:00.0		14e4:d145	Bridge Device
?? 0000:01:00.0		14e4:a8db	Network Controller

This card is directly on SoC (doesn't use physical connector) and has
BCM43217 chipset with bcma bus. One of its components is ChipCommon core
which is also a GPIO controller. We need to describe it to be able to
add devices using its GPIO pins.

Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>
---
 arch/arm/boot/dts/bcm47189-tenda-ac9.dts | 27 +++++++++++++++++++++++++++
 arch/arm/boot/dts/bcm53573.dtsi          |  4 ++++
 2 files changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/bcm47189-tenda-ac9.dts b/arch/arm/boot/dts/bcm47189-tenda-ac9.dts
index 4403ae8790c2..ce8c155fcc01 100644
--- a/arch/arm/boot/dts/bcm47189-tenda-ac9.dts
+++ b/arch/arm/boot/dts/bcm47189-tenda-ac9.dts
@@ -72,3 +72,30 @@
 		};
 	};
 };
+
+&pcie0 {
+	ranges = <0x00000000 0 0 0 0 0x00100000>;
+	#address-cells = <3>;
+	#size-cells = <2>;
+
+	bridge at 0,0,0 {
+		reg = <0x0000 0 0 0 0>;
+		ranges = <0x00000000 0 0 0 0 0 0 0x00100000>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+
+		wifi at 0,1,0 {
+			reg = <0x0000 0 0 0 0>;
+			ranges = <0x00000000 0 0 0 0x00100000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			pcie0_chipcommon: chipcommon at 0 {
+				reg = <0 0x1000>;
+
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/bcm53573.dtsi b/arch/arm/boot/dts/bcm53573.dtsi
index 2da04d0a7348..71ce23e46d30 100644
--- a/arch/arm/boot/dts/bcm53573.dtsi
+++ b/arch/arm/boot/dts/bcm53573.dtsi
@@ -113,6 +113,10 @@
 			};
 		};
 
+		pcie0: pcie at 2000 {
+			reg = <0x00002000 0x1000>;
+		};
+
 		usb2: usb2 at 4000 {
 			reg = <0x4000 0x1000>;
 			ranges;
-- 
2.11.0
