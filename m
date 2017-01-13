From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Sat, 14 Jan 2017 00:58:57 +0100
Subject: [PATCH] ARM: BCM5301X: Set 5 GHz wireless frequency limits on Netgear
 R8000
Message-ID: <20170113235857.9616-1-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rafa? Mi?ecki <rafal@milecki.pl>

Netgear R8000 is a tri-band home router. It has three BCM43602 chipsets
two of them for 5 GHz band. Both seem the same and their firmwares
report the same set of channels. The problem is due to hardware / board
design there are extra limitations that should be respected.

First PHY should be used for U-NII-2 and U-NII-3. Third PHY should be
used for U-NII-1. Using them in a different way may result in wireless
not working or in noticeably reduced performance. Basic version of this
info was provided by Broadcom employee, then it has been verified by me
using original vendor firmware (which has limitations hardcoded in UI).

This patch uses recently introduced ieee80211-freq-limit property to
describe these limitations at DT level.

Referencing PCIe devices in DT required specifying all related bridges.
Below you can see (a bit complex) PCI tree from R8000 that explains all
entries that I needed to put in DT.

0000:00:00.0		14e4:8012	Bridge Device
?? 0000:01:00.0		14e4:aa52	Network Controller

0001:00:00.0		14e4:8012	Bridge Device
?? 0001:01:00.0		10b5:8603	Bridge Device
   ?? 0001:02:01.0	10b5:8603	Bridge Device
   ?  ?? 0001:03:00.0	14e4:aa52	Network Controller
   ?? 0001:02:02.0	10b5:8603	Bridge Device
   ?  ?? 0001:04:00.0	14e4:aa52	Network Controller
   ?? 0001:02:03.0	000d:0000	0x000000
   ?? 0001:02:04.0	000d:0000	0x000000
   ?? 0001:02:05.0	000d:0000	0x000000
   ?? 0001:02:06.0	000d:0000	0x000000
   ?? (...)
   ?? 0001:02:1d.0	000d:0000	0x000000
   ?? 0001:02:1e.0	000d:0000	0x000000
   ?? 0001:02:1f.0	000d:0000	0x000000

Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>
---
 arch/arm/boot/dts/bcm4709-netgear-r8000.dts | 48 +++++++++++++++++++++++++++++
 arch/arm/boot/dts/bcm5301x.dtsi             |  8 +++++
 2 files changed, 56 insertions(+)

diff --git a/arch/arm/boot/dts/bcm4709-netgear-r8000.dts b/arch/arm/boot/dts/bcm4709-netgear-r8000.dts
index cd13534..8e39a84 100644
--- a/arch/arm/boot/dts/bcm4709-netgear-r8000.dts
+++ b/arch/arm/boot/dts/bcm4709-netgear-r8000.dts
@@ -108,6 +108,54 @@
 	};
 };
 
+&pcie0 {
+	#address-cells = <3>;
+	#size-cells = <2>;
+
+	bridge at 0,0,0 {
+		reg = <0x0000 0 0 0 0>;
+
+		#address-cells = <3>;
+		#size-cells = <2>;
+
+		wifi at 0,1,0 {
+			reg = <0x0000 0 0 0 0>;
+			ieee80211-freq-limit = <5735000 5835000>;
+		};
+	};
+};
+
+&pcie1 {
+	#address-cells = <3>;
+	#size-cells = <2>;
+
+	bridge at 1,0,0 {
+		reg = <0x0000 0 0 0 0>;
+
+		#address-cells = <3>;
+		#size-cells = <2>;
+
+		bridge at 1,1,0 {
+			reg = <0x0000 0 0 0 0>;
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			bridge at 1,2,2 {
+				reg = <0x1000 0 0 0 0>;
+
+				#address-cells = <3>;
+				#size-cells = <2>;
+
+				wifi at 1,4,0 {
+					reg = <0x0000 0 0 0 0>;
+					ieee80211-freq-limit = <5170000 5730000>;
+				};
+			};
+		};
+	};
+};
+
 &usb2 {
 	vcc-gpio = <&chipcommon 0 GPIO_ACTIVE_HIGH>;
 };
diff --git a/arch/arm/boot/dts/bcm5301x.dtsi b/arch/arm/boot/dts/bcm5301x.dtsi
index a4614c9..4fbb089 100644
--- a/arch/arm/boot/dts/bcm5301x.dtsi
+++ b/arch/arm/boot/dts/bcm5301x.dtsi
@@ -243,6 +243,14 @@
 			#gpio-cells = <2>;
 		};
 
+		pcie0: pcie at 12000 {
+			reg = <0x00012000 0x1000>;
+		};
+
+		pcie1: pcie at 13000 {
+			reg = <0x00013000 0x1000>;
+		};
+
 		usb2: usb2 at 21000 {
 			reg = <0x00021000 0x1000>;
 
-- 
2.10.1
