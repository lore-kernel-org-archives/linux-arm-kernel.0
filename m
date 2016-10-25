From: Minghuan.Lian@nxp.com (Minghuan Lian)
Date: Tue, 25 Oct 2016 20:35:40 +0800
Subject: [PATCH 1/6] dt/bindings: adjust bindings for Layerscape SCFG MSI
Message-ID: <1477398945-22774-1-git-send-email-Minghuan.Lian@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

1. The different version of a SoC may have different MSI
implementation. But compatible "fsl,<soc-name>-msi" can not describe
the SoC version. The MSI driver will use SoC match interface to get
SoC type and version instead of compatible string. So all MSI node
can use the common compatible "fsl,ls-scfg-msi" and the original
compatible is unnecessary.

2. Layerscape SoCs may have one or several MSI controllers.
In order to increase MSI interrupt number of a PCIe, the patch
moves all MSI node into the parent node "msi-controller". So a
PCIe can request MSI from all the MSI controllers.

Signed-off-by: Minghuan Lian <Minghuan.Lian@nxp.com>
---
 .../interrupt-controller/fsl,ls-scfg-msi.txt       | 57 +++++++++++++++++++---
 1 file changed, 49 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-scfg-msi.txt b/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-scfg-msi.txt
index 9e38949..29f95fd 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-scfg-msi.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-scfg-msi.txt
@@ -1,18 +1,28 @@
 * Freescale Layerscape SCFG PCIe MSI controller
 
+Layerscape SoCs may have one or multiple MSI controllers.
+Each MSI controller must be showed as a child node.
+
 Required properties:
 
-- compatible: should be "fsl,<soc-name>-msi" to identify
-	      Layerscape PCIe MSI controller block such as:
-              "fsl,1s1021a-msi"
-              "fsl,1s1043a-msi"
+- compatible: should be "fsl,ls-scfg-msi"
+- #address-cells: must be 2
+- #size-cells: must be 2
+- ranges: allows valid 1:1 translation between child's address space and
+	  parent's address space
 - msi-controller: indicates that this is a PCIe MSI controller node
+
+Required child node:
+A child node must exist to represent the MSI controller.
+The following are properties specific to those nodes:
+
 - reg: physical base address of the controller and length of memory mapped.
 - interrupts: an interrupt to the parent interrupt controller.
 
 Optional properties:
 - interrupt-parent: the phandle to the parent interrupt controller.
 
+Notes:
 This interrupt controller hardware is a second level interrupt controller that
 is hooked to a parent interrupt controller: e.g: ARM GIC for ARM-based
 platforms. If interrupt-parent is not provided, the default parent interrupt
@@ -22,9 +32,40 @@ MSI controller node
 
 Examples:
 
-	msi1: msi-controller at 1571000 {
-		compatible = "fsl,1s1043a-msi";
-		reg = <0x0 0x1571000 0x0 0x8>,
+	msi: msi-controller {
+		compatible = "fsl,ls-scfg-msi";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
 		msi-controller;
-		interrupts = <0 116 0x4>;
+
+		msi0 at 1580000 {
+			reg = <0x0 0x1580000 0x0 0x10000>;
+			interrupts = <0 116 0x4>,
+				     <0 111 0x4>,
+				     <0 112 0x4>,
+				     <0 113 0x4>;
+		};
+
+		msi1 at 1590000 {
+			reg = <0x0 0x1590000 0x0 0x10000>;
+			interrupts = <0 126 0x4>,
+				     <0 121 0x4>,
+				     <0 122 0x4>,
+				     <0 123 0x4>;
+		};
+
+		msi2 at 15a0000 {
+			reg = <0x0 0x15a0000 0x0 0x10000>;
+			interrupts = <0 160 0x4>,
+				     <0 155 0x4>,
+				     <0 156 0x4>,
+				     <0 157 0x4>;
+		};
+	};
+
+	pcie at 3400000 {
+			...
+			msi-parent = <&msi>;
+			...
 	};
-- 
1.9.1
