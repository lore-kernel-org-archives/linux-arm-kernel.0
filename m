From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 21 Feb 2014 15:12:43 +0900
Subject: [PATCH 02/13] ARM: shmobile: lager dts: Add QSPI nodes
In-Reply-To: <cover.1392961872.git.horms+renesas@verge.net.au>
References: <cover.1392961872.git.horms+renesas@verge.net.au>
Message-ID: <9fe7c4f810a7e82c4a1a9765017f9cb2c2b40a65.1392961872.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Add pinctrl and SPI devices for QSPI on Lager.
Add Spansion s25fl512s SPI FLASH and MTD partitions.

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
Acked-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 1081c5e..adff2dc 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -80,6 +80,11 @@
 		renesas,groups = "mmc1_data8", "mmc1_ctrl";
 		renesas,function = "mmc1";
 	};
+
+	qspi_pins: spi {
+		renesas,groups = "qspi_ctrl", "qspi_data4";
+		renesas,function = "qspi";
+	};
 };
 
 &mmcif1 {
@@ -95,3 +100,34 @@
 &sata1 {
 	status = "okay";
 };
+
+&spi {
+	pinctrl-0 = <&qspi_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+
+	flash: flash at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "spansion,s25fl512s";
+		reg = <0>;
+		spi-max-frequency = <30000000>;
+		m25p,fast-read;
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
-- 
1.8.5.2
