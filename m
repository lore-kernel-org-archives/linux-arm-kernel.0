From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 10 Nov 2015 16:14:01 +0900
Subject: [PATCH 3/3] ARM: shmobile: gose: Add QSPI device to DT
In-Reply-To: <1447139641-11480-1-git-send-email-horms+renesas@verge.net.au>
References: <1447139641-11480-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1447139641-11480-4-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the QSPI controller in the gose device tree.

Based similar work for the silk board by by Vladimir Barinov and
Sergei Shtylyov.

Cc: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---
Tested: Read /dev/mtd0 with 512K blocks at 1.7MB/s
---
 arch/arm/boot/dts/r8a7793-gose.dts | 40 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7793-gose.dts b/arch/arm/boot/dts/r8a7793-gose.dts
index 1575ef759047..3bc4230aa2b5 100644
--- a/arch/arm/boot/dts/r8a7793-gose.dts
+++ b/arch/arm/boot/dts/r8a7793-gose.dts
@@ -57,6 +57,11 @@
 		renesas,groups = "intc_irq0";
 		renesas,function = "intc";
 	};
+
+	qspi_pins: spi0 {
+		renesas,groups = "qspi_ctrl", "qspi_data4";
+		renesas,function = "qspi";
+	};
 };
 
 &ether {
@@ -92,3 +97,38 @@
 
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
+		compatible = "spansion,s25fl512s", "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <30000000>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
+		spi-cpol;
+		spi-cpha;
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
2.1.4
