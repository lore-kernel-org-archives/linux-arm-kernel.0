From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 9 May 2014 04:19:41 +0400
Subject: [PATCH] ARM: shmobile: henninger: add I2C2 DT support
Message-ID: <201405090419.42435.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the Henninger board dependent part of the I2C2 device node.
Add device nodes for Analog Devices ADV7180 video decoder and Renesas EEPROM
connected to this I2C bus.

Based on the Koelsch I2C2 device tree patch by Wolfram Sang.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
This patch is against 'renesas-devel-v3.15-rc3-20140502' tag of Simon Horman's
'renesas.git' repo plus SDHI0/2, QSPI, and MSIOF0 DT support patches posted
recently.

 arch/arm/boot/dts/r8a7791-henninger.dts |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7791-henninger.dts
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7791-henninger.dts
+++ renesas/arch/arm/boot/dts/r8a7791-henninger.dts
@@ -110,6 +110,11 @@
 		renesas,function = "sdhi2";
 	};
 
+	i2c2_pins: i2c2 {
+		renesas,groups = "i2c2";
+		renesas,function = "i2c2";
+	};
+
 	qspi_pins: spi0 {
 		renesas,groups = "qspi_ctrl", "qspi_data4";
 		renesas,function = "qspi";
@@ -170,6 +175,25 @@
 	status = "okay";
 };
 
+&i2c2 {
+	pinctrl-0 = <&i2c2_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+	clock-frequency = <400000>;
+
+	video at 20 {
+		compatible = "adi,adv7180";
+		reg = <0x20>;
+	};
+
+	eeprom at 50 {
+		compatible = "24c02";
+		reg = <0x50>;
+		pagesize = <16>;
+	};
+};
+
 &qspi {
 	pinctrl-0 = <&qspi_pins>;
 	pinctrl-names = "default";
