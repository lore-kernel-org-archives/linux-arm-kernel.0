From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sun, 09 Aug 2015 01:27:14 +0300
Subject: [PATCH 2/2] ARM: shmobile: silk: add QSPI DT support
In-Reply-To: <1898263.zrOs5SAUTS@wasted.cogentembedded.com>
References: <1898263.zrOs5SAUTS@wasted.cogentembedded.com>
Message-ID: <1768974.jEFIAaInqd@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the SILK board dependent part of the QSPI device node.
Add device nodes  for Spansion  S25FL512S SPI flash and MTD partitions on it.

Based on the original patch by Vladimir Barinov
<vladimir.barinov@cogentembedded.com>.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm/boot/dts/r8a7794-silk.dts |   40 +++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7794-silk.dts
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7794-silk.dts
+++ renesas/arch/arm/boot/dts/r8a7794-silk.dts
@@ -65,6 +65,11 @@
 		renesas,groups = "mmc_data8", "mmc_ctrl";
 		renesas,function = "mmc";
 	};
+
+	qspi_pins: spi0 {
+		renesas,groups = "qspi_ctrl", "qspi_data4";
+		renesas,function = "qspi";
+	};
 };
 
 &scif2 {
@@ -100,3 +105,38 @@
 	non-removable;
 	status = "okay";
 };
+
+&qspi {
+	pinctrl-0 = <&qspi_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+
+	flash at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "spansion,s25fl512s";
+		reg = <0>;
+		spi-max-frequency = <30000000>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
+		m25p,fast-read;
+		spi-cpol;
+		spi-cpha;
+
+		partition at 0 {
+			label = "loader";
+			reg = <0x00000000 0x00040000>;
+			read-only;
+		};
+		partition at 40000 {
+			label = "user";
+			reg = <0x00040000 0x00400000>;
+			read-only;
+		};
+		partition at 440000 {
+			label = "flash";
+			reg = <0x00440000 0x03bc0000>;
+		};
+	};
+};
