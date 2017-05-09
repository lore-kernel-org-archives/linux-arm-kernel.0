From: yangbo.lu@nxp.com (Yangbo Lu)
Date: Tue, 9 May 2017 10:37:08 +0800
Subject: [v3, 4/5] arm64: dts: ls1012a: add eSDHC nodes
In-Reply-To: <1494297429-12083-1-git-send-email-yangbo.lu@nxp.com>
References: <1494297429-12083-1-git-send-email-yangbo.lu@nxp.com>
Message-ID: <1494297429-12083-5-git-send-email-yangbo.lu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are two eSDHC controllers in LS1012A. This patch is to add
eSDHC nodes for ls1012a dts. Also enable eSDHC for RDB/QDS boards.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
Changes for v2:
	- Sorted the node.
Changes for v3:
	- None.
---
 arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dts |  8 ++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dts | 13 ++++++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi    | 25 +++++++++++++++++++++++
 3 files changed, 46 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dts
index 40ef468..8c013b5 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dts
@@ -97,6 +97,14 @@
 	status = "okay";
 };
 
+&esdhc0 {
+	status = "okay";
+};
+
+&esdhc1 {
+	status = "okay";
+};
+
 &i2c0 {
 	status = "okay";
 
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dts
index 65d4313..c1a119e 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dts
@@ -54,6 +54,19 @@
 	status = "okay";
 };
 
+&esdhc0 {
+	sd-uhs-sdr104;
+	sd-uhs-sdr50;
+	sd-uhs-sdr25;
+	sd-uhs-sdr12;
+	status = "okay";
+};
+
+&esdhc1 {
+	mmc-hs200-1_8v;
+	status = "okay";
+};
+
 &i2c0 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
index ae47156..9a2ccd8 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
@@ -117,12 +117,37 @@
 		#size-cells = <2>;
 		ranges;
 
+		esdhc0: esdhc at 1560000 {
+			compatible = "fsl,ls1012a-esdhc", "fsl,esdhc";
+			reg = <0x0 0x1560000 0x0 0x10000>;
+			interrupts = <0 62 0x4>;
+			clocks = <&clockgen 4 0>;
+			voltage-ranges = <1800 1800 3300 3300>;
+			sdhci,auto-cmd12;
+			big-endian;
+			bus-width = <4>;
+			status = "disabled";
+		};
+
 		scfg: scfg at 1570000 {
 			compatible = "fsl,ls1012a-scfg", "syscon";
 			reg = <0x0 0x1570000 0x0 0x10000>;
 			big-endian;
 		};
 
+		esdhc1: esdhc at 1580000 {
+			compatible = "fsl,ls1012a-esdhc", "fsl,esdhc";
+			reg = <0x0 0x1580000 0x0 0x10000>;
+			interrupts = <0 65 0x4>;
+			clocks = <&clockgen 4 0>;
+			voltage-ranges = <1800 1800 3300 3300>;
+			sdhci,auto-cmd12;
+			big-endian;
+			broken-cd;
+			bus-width = <4>;
+			status = "disabled";
+		};
+
 		crypto: crypto at 1700000 {
 			compatible = "fsl,sec-v5.4", "fsl,sec-v5.0",
 				     "fsl,sec-v4.0";
-- 
2.1.0.27.g96db324
