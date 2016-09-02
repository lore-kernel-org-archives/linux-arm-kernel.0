From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 03 Sep 2016 01:09:26 +0300
Subject: [PATCH 3/3] ARM: dts: wheat: add QSPI support
In-Reply-To: <1648590.FPpmBRoQyh@wasted.cogentembedded.com>
References: <1648590.FPpmBRoQyh@wasted.cogentembedded.com>
Message-ID: <3191777.fJ30rYXr4J@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the Wheat board dependent part of the QSPI device node.
Add device nodes for Spansion S25FL512S SPI flash and MTD partitions on it.

Based  on the original (and large) patch by Vladimir Barinov
<vladimir.barinov@cogentembedded.com>.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm/boot/dts/r8a7792-wheat.dts |   43 ++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7792-wheat.dts
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7792-wheat.dts
+++ renesas/arch/arm/boot/dts/r8a7792-wheat.dts
@@ -132,6 +132,11 @@
 		function = "sdhi0";
 	};
 
+	qspi_pins: qspi {
+		groups = "qspi_ctrl", "qspi_data4";
+		function = "qspi";
+	};
+
 	du0_pins: du0 {
 		groups = "du0_rgb888", "du0_sync", "du0_disp";
 		function = "du0";
@@ -173,6 +178,44 @@
 	status = "okay";
 };
 
+&qspi {
+	pinctrl-0 = <&qspi_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	flash at 0 {
+		compatible = "spansion,s25fl512s", "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <30000000>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
+		spi-cpol;
+		spi-cpha;
+		m25p,fast-read;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition at 0 {
+				label = "loader";
+				reg = <0x00000000 0x00040000>;
+				read-only;
+			};
+			partition at 40000 {
+				label = "user";
+				reg = <0x00040000 0x00400000>;
+				read-only;
+			};
+			partition at 440000 {
+				label = "flash";
+				reg = <0x00440000 0x03bc0000>;
+			};
+		};
+	};
+};
+
 &i2c4 {
 	status = "okay";
 	clock-frequency = <400000>;
