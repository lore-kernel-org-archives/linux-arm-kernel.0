From: antoine.tenart@free-electrons.com (=?UTF-8?q?Antoine=20T=C3=A9nart?=)
Date: Tue, 24 Jun 2014 12:35:20 +0200
Subject: [PATCH v2 11/12] ARM: dts: berlin: add BG2CD nodes for USB support
In-Reply-To: <1403606121-6368-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1403606121-6368-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1403606121-6368-12-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

Adds nodes describing the Marvell Berlin BG2CD USB PHY and USB. The BG2CD
SoC has 2 USB ChipIdea controllers, with usb0 host-only and usb1 dual-role
capable.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
 arch/arm/boot/dts/berlin2cd.dtsi | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm/boot/dts/berlin2cd.dtsi b/arch/arm/boot/dts/berlin2cd.dtsi
index 68f7032b4686..d35c9fbaa397 100644
--- a/arch/arm/boot/dts/berlin2cd.dtsi
+++ b/arch/arm/boot/dts/berlin2cd.dtsi
@@ -66,6 +66,22 @@
 			clocks = <&chip CLKID_TWD>;
 		};
 
+		usb_phy0: usb-phy at b74000 {
+			compatible = "marvell,berlin2cd-usb-phy";
+			reg = <0xb74000 0x128>;
+			#phy-cells = <0>;
+			resets = <&chip 0x178 23>;
+			status = "disabled";
+		};
+
+		usb_phy1: usb-phy at b78000 {
+			compatible = "marvell,berlin2cd-usb-phy";
+			reg = <0xb78000 0x128>;
+			#phy-cells = <0>;
+			resets = <&chip 0x178 24>;
+			status = "disabled";
+		};
+
 		apb at e80000 {
 			compatible = "simple-bus";
 			#address-cells = <1>;
@@ -242,6 +258,24 @@
 			};
 		};
 
+		usb0: usb at ed0000 {
+			compatible = "chipidea-usb";
+			reg = <0xed0000 0x200>;
+			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&chip CLKID_USB0>;
+			usb-phy = <&usb_phy0>;
+			status = "disabled";
+		};
+
+		usb1: usb at ee0000 {
+			compatible = "chipidea-usb";
+			reg = <0xee0000 0x200>;
+			interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&chip CLKID_USB1>;
+			usb-phy = <&usb_phy1>;
+			status = "disabled";
+		};
+
 		apb at fc0000 {
 			compatible = "simple-bus";
 			#address-cells = <1>;
-- 
1.9.1
