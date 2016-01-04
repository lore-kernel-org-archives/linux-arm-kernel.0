From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  4 Jan 2016 21:36:59 +1100
Subject: [PATCH v2] ARM: shmobile: alt: Add QSPI device to DT
Message-ID: <1451903819-19218-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the QSPI controller in the alt device tree.

Based similar work for the silk board by by Vladimir Barinov and
Sergei Shtylyov.

Cc: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---
v2
* Added compatible = "fixed-partitions";
* Update partitioning scheme to reflect
  ALT_MiniMonitor_Manual(SPI_Boot)_Rev0.01_e.pdf
* Tested on top of renesas-devel-20151228-v4.4-rc7
  Read /dev/mtd0 with 512K blocks at 6.5Mb/s
---
 arch/arm/boot/dts/r8a7794-alt.dts | 46 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7794-alt.dts b/arch/arm/boot/dts/r8a7794-alt.dts
index 2394e4883786..773f304d1142 100644
--- a/arch/arm/boot/dts/r8a7794-alt.dts
+++ b/arch/arm/boot/dts/r8a7794-alt.dts
@@ -138,6 +138,13 @@
 	status = "okay";
 };
 
+&pfc {
+	qspi_pins: spi0 {
+		renesas,groups = "qspi_ctrl", "qspi_data4";
+		renesas,function = "qspi";
+	};
+};
+
 &ether {
 	pinctrl-0 = <&ether_pins &phy1_pins>;
 	pinctrl-names = "default";
@@ -197,3 +204,42 @@
 
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
+				label = "system";
+				reg = <0x00040000 0x00040000>;
+				read-only;
+			};
+			partition at 80000 {
+				label = "user";
+				reg = <0x00080000 0x03f80000>;
+			};
+		};
+	};
+};
-- 
2.1.4
