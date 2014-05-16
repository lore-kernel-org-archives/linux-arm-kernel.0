From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 May 2014 09:58:12 +0900
Subject: [PATCH 03/11] ARM: shmobile: henninger: add QSPI DT support
In-Reply-To: <cover.1400200395.git.horms+renesas@verge.net.au>
References: <cover.1400200395.git.horms+renesas@verge.net.au>
Message-ID: <f59838d448356feb4f0ce70785a49045d842c9c3.1400200395.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Define the Henninger board dependent part of the QSPI device node.
Add device nodes for Spansion S25FL512S SPI flash and MTD partitions on it.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791-henninger.dts | 38 +++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791-henninger.dts b/arch/arm/boot/dts/r8a7791-henninger.dts
index 2e45c06..1d715a3 100644
--- a/arch/arm/boot/dts/r8a7791-henninger.dts
+++ b/arch/arm/boot/dts/r8a7791-henninger.dts
@@ -109,6 +109,11 @@
 		renesas,groups = "sdhi2_data4", "sdhi2_ctrl";
 		renesas,function = "sdhi2";
 	};
+
+	qspi_pins: spi0 {
+		renesas,groups = "qspi_ctrl", "qspi_data4";
+		renesas,function = "qspi";
+	};
 };
 
 &scif0 {
@@ -158,3 +163,36 @@
 	cd-gpios = <&gpio6 22 GPIO_ACTIVE_LOW>;
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
-- 
1.8.5.2
