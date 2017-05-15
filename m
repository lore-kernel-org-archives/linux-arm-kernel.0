From: madalin.bucur@nxp.com (Madalin Bucur)
Date: Mon, 15 May 2017 12:21:17 +0300
Subject: [PATCH v2 2/3] arm64: dts: add LS1043A DPAA QBMan nodes
In-Reply-To: <1494840078-22243-1-git-send-email-madalin.bucur@nxp.com>
References: <1494840078-22243-1-git-send-email-madalin.bucur@nxp.com>
Message-ID: <1494840078-22243-3-git-send-email-madalin.bucur@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the DPAA 1.x QMan and BMan nodes in the LS1043A device tree.

Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 53 ++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index 45cface..a729755 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -45,6 +45,7 @@
  */
 
 #include <dt-bindings/thermal/thermal.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
 
 / {
 	compatible = "fsl,ls1043a";
@@ -106,6 +107,33 @@
 		      /* DRAM space 1, size: 2GiB DRAM */
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		bman_fbpr: bman-fbpr {
+			compatible = "shared-dma-pool";
+			size = <0 0x1000000>;
+			alignment = <0 0x1000000>;
+			no-map;
+		};
+
+		qman_fqd: qman-fqd {
+			compatible = "shared-dma-pool";
+			size = <0 0x400000>;
+			alignment = <0 0x400000>;
+			no-map;
+		};
+
+		qman_pfdr: qman-pfdr {
+			compatible = "shared-dma-pool";
+			size = <0 0x2000000>;
+			alignment = <0 0x2000000>;
+			no-map;
+		};
+	};
+
 	sysclk: sysclk {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
@@ -333,6 +361,28 @@
 			};
 		};
 
+		qman: qman at 1880000 {
+			compatible = "fsl,qman";
+			reg = <0x0 0x1880000 0x0 0x10000>;
+			interrupts = <0 45 0x4>;
+			memory-region = <&qman_fqd &qman_pfdr>;
+		};
+
+		bman: bman at 1890000 {
+			compatible = "fsl,bman";
+			reg = <0x0 0x1890000 0x0 0x10000>;
+			interrupts = <0 45 0x4>;
+			memory-region = <&bman_fbpr>;
+		};
+
+		bportals: bman-portals at 508000000 {
+			ranges = <0x0 0x5 0x08000000 0x8000000>;
+		};
+
+		qportals: qman-portals at 500000000 {
+			ranges = <0x0 0x5 0x00000000 0x8000000>;
+		};
+
 		dspi0: dspi at 2100000 {
 			compatible = "fsl,ls1043a-dspi", "fsl,ls1021a-v1.0-dspi";
 			#address-cells = <1>;
@@ -688,3 +738,6 @@
 	};
 
 };
+
+#include "qoriq-qman-portals.dtsi"
+#include "qoriq-bman-portals.dtsi"
-- 
2.1.0
