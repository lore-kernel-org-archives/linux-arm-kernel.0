From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 10 Oct 2015 00:40:31 +0300
Subject: [PATCH v2] ARM: shmobile: porter: add QSPI DT support
Message-ID: <2106212.7FLXjWMUMh@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the Porter board dependent part of the QSPI device node.
Add device nodes  for Spansion  S25FL512S SPI flash and the MTD partitions
on it.

This patch is  mostly analogous  to the commit f59838d44835 ("ARM:
shmobile: henninger: add QSPI DT support")  as there are no differences
between the boards in this respect.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
This patch is against 'renesas-devel-20151008-v4.3-rc4' tag of Simon Horman's
'renesas.git' repo plus the Porter I2C2 and VIN0/ADV7180 patches posted earlier.

Changes in version 2:
- fixed the commit citing style and reformatted that whole paragraph.

 arch/arm/boot/dts/r8a7791-porter.dts |   38 +++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7791-porter.dts
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7791-porter.dts
+++ renesas/arch/arm/boot/dts/r8a7791-porter.dts
@@ -110,6 +110,11 @@
 		renesas,function = "sdhi2";
 	};
 
+	qspi_pins: spi0 {
+		renesas,groups = "qspi_ctrl", "qspi_data4";
+		renesas,function = "qspi";
+	};
+
 	i2c2_pins: i2c2 {
 		renesas,groups = "i2c2";
 		renesas,function = "i2c2";
@@ -165,6 +170,39 @@
 	status = "okay";
 };
 
+&qspi {
+	pinctrl-0 = <&qspi_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+
+	flash at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "spansion,s25fl512s", "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <30000000>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
+		m25p,fast-read;
+
+		partition at 0 {
+			label = "loader_prg";
+			reg = <0x00000000 0x00040000>;
+			read-only;
+		};
+		partition at 40000 {
+			label = "user_prg";
+			reg = <0x00040000 0x00400000>;
+			read-only;
+		};
+		partition at 440000 {
+			label = "flash_fs";
+			reg = <0x00440000 0x03bc0000>;
+		};
+	};
+};
+
 &i2c2 {
 	pinctrl-0 = <&i2c2_pins>;
 	pinctrl-names = "default";
