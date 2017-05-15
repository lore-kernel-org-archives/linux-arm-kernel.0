From: madalin.bucur@nxp.com (Madalin Bucur)
Date: Mon, 15 May 2017 12:21:18 +0300
Subject: [PATCH v2 3/3] arm64: dts: add LS1046A DPAA QBMan nodes
In-Reply-To: <1494840078-22243-1-git-send-email-madalin.bucur@nxp.com>
References: <1494840078-22243-1-git-send-email-madalin.bucur@nxp.com>
Message-ID: <1494840078-22243-4-git-send-email-madalin.bucur@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the QBMan device tree nodes for LS1046A devices.

Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 54 ++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index f4b8b7e..ce7e6e2 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -268,6 +268,30 @@
 			};
 		};
 
+		qman: qman at 1880000 {
+			compatible = "fsl,qman";
+			reg = <0x0 0x1880000 0x0 0x10000>;
+			interrupts = <0 45 0x4>;
+			memory-region = <&qman_fqd &qman_pfdr>;
+
+		};
+
+		bman: bman at 1890000 {
+			compatible = "fsl,bman";
+			reg = <0x0 0x1890000 0x0 0x10000>;
+			interrupts = <0 45 0x4>;
+			memory-region = <&bman_fbpr>;
+
+		};
+
+		qportals: qman-portals at 500000000 {
+			ranges = <0x0 0x5 0x00000000 0x8000000>;
+		};
+
+		bportals: bman-portals at 508000000 {
+			ranges = <0x0 0x5 0x08000000 0x8000000>;
+		};
+
 		dcfg: dcfg at 1ee0000 {
 			compatible = "fsl,ls1046a-dcfg", "syscon";
 			reg = <0x0 0x1ee0000 0x0 0x10000>;
@@ -594,4 +618,34 @@
 			clocks = <&clockgen 4 1>;
 		};
 	};
+
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
+			size = <0 0x800000>;
+			alignment = <0 0x800000>;
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
 };
+
+#include "qoriq-qman-portals.dtsi"
+#include "qoriq-bman-portals.dtsi"
-- 
2.1.0
