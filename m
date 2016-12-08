From: yao.yuan@freescale.com (Yuan Yao)
Date: Thu, 8 Dec 2016 17:23:03 +0800
Subject: [PATCH 4/5] arm64: dts: ls1012a: add the DTS node for QSPI support
In-Reply-To: <1481188984-43683-1-git-send-email-yao.yuan@freescale.com>
References: <1481188984-43683-1-git-send-email-yao.yuan@freescale.com>
Message-ID: <1481188984-43683-5-git-send-email-yao.yuan@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yuan Yao <yao.yuan@nxp.com>

There is a s25fs512s qspi flash on QDS, RDB and FRDM board.

Signed-off-by: Yuan Yao <yao.yuan@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts | 14 ++++++++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dts  | 15 +++++++++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dts  | 15 +++++++++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi     | 15 +++++++++++++++
 4 files changed, 59 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts b/arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts
index 81bd689..34f9e76 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts
@@ -110,6 +110,20 @@
 	};
 };
 
+&qspi {
+	num-cs = <2>;
+	bus-num = <0>;
+	status = "okay";
+
+	qflash0: s25fs512s at 0 {
+		compatible = "spansion,m25p80";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		spi-max-frequency = <20000000>;
+		reg = <0>;
+	};
+};
+
 &sai2 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dts
index 3d32c76..0e5befa 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dts
@@ -156,6 +156,21 @@
 	};
 };
 
+&qspi {
+	num-cs = <2>;
+	bus-num = <0>;
+	status = "okay";
+
+	qflash0: s25fs512s at 0 {
+		compatible = "spansion,m25p80";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		spi-max-frequency = <20000000>;
+		m25p,fast-read;
+		reg = <0>;
+	};
+};
+
 &sai2 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dts
index 62c5c71..c20bfd3 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dts
@@ -57,3 +57,18 @@
 &i2c0 {
 	status = "okay";
 };
+
+&qspi {
+	num-cs = <2>;
+	bus-num = <0>;
+	status = "okay";
+
+	qflash0: s25fs512s at 0 {
+		compatible = "spansion,m25p80";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		spi-max-frequency = <20000000>;
+		m25p,fast-read;
+		reg = <0>;
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
index c917a87..72e61c5 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
@@ -195,6 +195,21 @@
 			#interrupt-cells = <2>;
 		};
 
+		qspi: quadspi at 1550000 {
+			compatible = "fsl,ls1012a-qspi", "fsl,ls1021a-qspi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x0 0x1550000 0x0 0x10000>,
+				<0x0 0x40000000 0x0 0x10000000>;
+			reg-names = "QuadSPI", "QuadSPI-memory";
+			interrupts = <0 99 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "qspi_en", "qspi";
+			clocks = <&clockgen 4 0>, <&clockgen 4 0>;
+			big-endian;
+			fsl,qspi-has-second-chip;
+			status = "disabled";
+		};
+
 		wdog0: wdog at 2ad0000 {
 			compatible = "fsl,ls1012a-wdt",
 				     "fsl,imx21-wdt";
-- 
2.1.0.27.g96db324
