From: prabhakar.kushwaha@nxp.com (Prabhakar Kushwaha)
Date: Thu, 4 May 2017 14:40:32 +0530
Subject: [PATCH] arm: arm64: Add flash node for ls1088a qds and rdb
In-Reply-To: <1493889032-20857-1-git-send-email-prabhakar.kushwaha@nxp.com>
References: <1493889032-20857-1-git-send-email-prabhakar.kushwaha@nxp.com>
Message-ID: <1493889032-20857-2-git-send-email-prabhakar.kushwaha@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

LS1088AQDS consist of NOR, NAND and FPGA connected over IFC
LS1088ARDB consist of NAND and FPGA connected over IFC.

So add flash information in ifc node of device tree.

Signed-off-by: Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dts | 27 +++++++++++++++++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts | 20 +++++++++++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi    |  4 ----
 3 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dts
index 8c3cae5..ca7eb41 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dts
@@ -53,6 +53,33 @@
 	compatible = "fsl,ls1088a-qds", "fsl,ls1088a";
 };
 
+&ifc {
+	#address-cells = <2>;
+	#size-cells = <1>;
+	status = "okay";
+
+	ranges = <0 0 0x5 0x80000000 0x08000000
+		  2 0 0x5 0x30000000 0x00010000
+		  3 0 0x5 0x20000000 0x00010000>;
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
 &i2c0 {
 	status = "okay";
 
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts
index 8a04fbb..726e167 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts
@@ -53,6 +53,26 @@
 	compatible = "fsl,ls1088a-rdb", "fsl,ls1088a";
 };
 
+&ifc {
+	#address-cells = <2>;
+	#size-cells = <1>;
+	status = "okay";
+
+	ranges = <0 0 0x5 0x30000000 0x00010000
+		  2 0 0x5 0x20000000 0x00010000>;
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
+
 &i2c0 {
 	status = "okay";
 
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index 2946fd7..9f6bcb4 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -217,10 +217,6 @@
 			#address-cells = <2>;
 			#size-cells = <1>;
 
-			ranges = <0 0 0x5 0x80000000 0x08000000
-				  2 0 0x5 0x30000000 0x00010000
-				  3 0 0x5 0x20000000 0x00010000>;
-			status = "disabled";
 		};
 
 		i2c0: i2c at 2000000 {
-- 
2.7.4
