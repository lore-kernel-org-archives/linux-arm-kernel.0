From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Fri, 14 Dec 2012 17:45:31 +0100
Subject: [PATCH 7/7] ARM: mackerel: add more devices to DT
In-Reply-To: <1355503531-7276-1-git-send-email-g.liakhovetski@gmx.de>
References: <1355503531-7276-1-git-send-email-g.liakhovetski@gmx.de>
Message-ID: <1355503531-7276-8-git-send-email-g.liakhovetski@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds devices, whose initialisation from DT is already supported,
into the board .dts file.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/arm/boot/dts/sh7372-mackerel.dts |   96 +++++++++++++++++++++++++++++++++
 1 files changed, 96 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/sh7372-mackerel.dts b/arch/arm/boot/dts/sh7372-mackerel.dts
index 2ede70d..8bc95c0 100644
--- a/arch/arm/boot/dts/sh7372-mackerel.dts
+++ b/arch/arm/boot/dts/sh7372-mackerel.dts
@@ -19,4 +19,100 @@
 		device_type = "memory";
 		reg = <0x40000000 0x10000000>;
 	};
+
+	reg_1p8v: regulator at 0 {
+		compatible = "regulator-fixed";
+		regulator-name = "1P8V";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	reg_3p3v: regulator at 1 {
+		compatible = "regulator-fixed";
+		regulator-name = "3P3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	lan9220 at 14000000 {
+		compatible = "smsc,lan9220", "smsc,lan9115";
+		reg = <0x14000000 0x2000000>;
+		phy-mode = "mii";
+		interrupt-parent = <&intca_irq_pins_lo>;
+		interrupts = <0x2c0>;
+		reg-io-width = <4>;
+		smsc,irq-push-pull;
+		smsc,save-mac-address;
+		vddvario-supply = <&reg_1p8v>;
+		vdd33a-supply = <&reg_3p3v>;
+	};
+
+	i2c0: i2c at fff20000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,rmobile-iic";
+		reg = <0xfff20000 0x1000>;
+		interrupt-parent = <&intcs>;
+		interrupts = <0x4200 0x4220 0x4240 0x4260>;
+
+		clock-frequency = <100000>;
+
+		touchscreen at 55 {
+			compatible = "sitronix,st1232-ts";
+			reg = <0x55>;
+			interrupt-parent = <&intca_irq_pins_lo>;
+			interrupts = <0x02e0>;
+		};
+
+		codec at 13 {
+			compatible = "asahi-kasei,ak4642-codec";
+			reg = <0x13>;
+		};
+	};
+
+	i2c1: i2c at e6c20000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,rmobile-iic";
+		reg = <0xe6c20000 0x1000>;
+		interrupt-parent = <&intca>;
+		interrupts = <0x780 0x7a0 0x7c0 0x7e0>;
+
+		clock-frequency = <100000>;
+
+		accelerometer at 53 {
+			compatible = "analog-devices,adxl34x";
+			reg = <0x53>;
+			interrupt-parent = <&intca_irq_pins_hi>;
+			interrupts = <0x32a0>;
+		};
+	};
+
+	mmcif0: mmcif at 0xe6bd0000 {
+		compatible = "renesas,sh-mmcif", "renesas,sh7372-mmcif";
+		reg = <0xe6bd0000 0x100>;
+		interrupt-parent = <&intca>;
+		interrupts = <0x1ac0 0x1ae0>;
+		vmmc-supply = <&reg_1p8v>;
+	};
+
+	sdhi0: sdhi at 0xe6850000 {
+		compatible = "renesas,shmobile-sdhi";
+		reg = <0xe6850000 0x100>;
+		interrupt-parent = <&intca>;
+		interrupts = <0x0e00 0x0e20 0x0e40>;
+		vmmc-supply = <&reg_3p3v>;
+	};
+
+	sdhi2: sdhi at 0xe6870000 {
+		compatible = "renesas,shmobile-sdhi";
+		reg = <0xe6870000 0x100>;
+		interrupt-parent = <&intca>;
+		interrupts = <0x1200 0x1220 0x1240>;
+		vmmc-supply = <&reg_3p3v>;
+	};
 };
-- 
1.7.2.5
