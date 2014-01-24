From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 24 Jan 2014 13:49:48 +0100
Subject: [PATCH v2 12/15] ARM: shmobile: koelsch dts: Add QSPI nodes
In-Reply-To: <1390567791-8988-1-git-send-email-geert@linux-m68k.org>
References: <1390567791-8988-1-git-send-email-geert@linux-m68k.org>
Message-ID: <1390567791-8988-13-git-send-email-geert@linux-m68k.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Add pinctrl and SPI devices for QSPI on Koelsch.
Add Spansion s25fl512s SPI FLASH and MTD partitions.

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
Cc: devicetree at vger.kernel.org
---
v2:
  - No changes

 arch/arm/boot/dts/r8a7791-koelsch.dts |   36 +++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index 55ec36e2a1f1..42fd5ebe9119 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -123,6 +123,11 @@
 		renesas,groups = "scif1_data_d";
 		renesas,function = "scif1";
 	};
+
+	qspi_pins: spi {
+		renesas,groups = "qspi_ctrl", "qspi_data4";
+		renesas,function = "qspi";
+	};
 };
 
 &sata0 {
@@ -142,3 +147,34 @@
 
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
+			reg = <0x00000000 0x00080000>;
+			read-only;
+		};
+		partition at 80000 {
+			label = "bootenv";
+			reg = <0x00080000 0x00080000>;
+			read-only;
+		};
+		partition at 100000 {
+			label = "data";
+			reg = <0x00100000 0x03f00000>;
+		};
+	};
+};
-- 
1.7.9.5
