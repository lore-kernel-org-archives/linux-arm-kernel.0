From: prabhakar.kushwaha@nxp.com (Prabhakar Kushwaha)
Date: Wed, 10 May 2017 15:13:23 +0530
Subject: [PATCH][v3] arm64: Add flash node for ls1088a qds and rdb
Message-ID: <1494409403-22369-1-git-send-email-prabhakar.kushwaha@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

LS1088AQDS consist of NOR, NAND and FPGA connected over IFC
LS1088ARDB consist of NAND and FPGA connected over IFC.

So add flash information in ifc node of device tree.

Signed-off-by: Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>
---
changes for v2: Incorporated Shawn's comments
changes for v3: Incorporated Shawn's further comments

 arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dts | 24 +++++++++++++++++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts | 16 +++++++++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi    |  5 +----
 3 files changed, 41 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dts
index 8c3cae5..82e1615 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dts
@@ -110,6 +110,30 @@
 	};
 };
 
+&ifc {
+	ranges = <0 0 0x5 0x80000000 0x08000000
+		  2 0 0x5 0x30000000 0x00010000
+		  3 0 0x5 0x20000000 0x00010000>;
+	status = "okay";
+
+	nor at 0,0 {
+		compatible = "cfi-flash";
+		reg = <0x0 0x0 0x8000000>;
+		bank-width = <2>;
+		device-width = <1>;
+	};
+
+	nand at 2,0 {
+		compatible = "fsl,ifc-nand";
+		reg = <0x2 0x0 0x10000>;
+	};
+
+	fpga: board-control at 3,0 {
+		compatible = "fsl,ls1088aqds-fpga", "fsl,fpga-qixis";
+		reg = <0x3 0x0 0x0000100>;
+	};
+};
+
 &duart0 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts
index 8a04fbb..a93a588 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts
@@ -94,6 +94,22 @@
 	};
 };
 
+&ifc {
+	ranges = <0 0 0x5 0x30000000 0x00010000
+		  2 0 0x5 0x20000000 0x00010000>;
+	status = "okay";
+
+	nand at 0,0 {
+		compatible = "fsl,ifc-nand";
+		reg = <0x0 0x0 0x10000>;
+	};
+
+	fpga: board-control at 2,0 {
+		compatible = "fsl,ls1088ardb-fpga", "fsl,fpga-qixis";
+		reg = <0x2 0x0 0x0000100>;
+	};
+};
+
 &duart0 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index 2946fd7..e852b22 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -216,11 +216,8 @@
 			little-endian;
 			#address-cells = <2>;
 			#size-cells = <1>;
-
-			ranges = <0 0 0x5 0x80000000 0x08000000
-				  2 0 0x5 0x30000000 0x00010000
-				  3 0 0x5 0x20000000 0x00010000>;
 			status = "disabled";
+
 		};
 
 		i2c0: i2c at 2000000 {
-- 
2.7.4
