From: lho@apm.com (Loc Ho)
Date: Thu, 14 May 2015 11:05:45 -0600
Subject: [PATCH v9 3/5] Documentation: Add documentation for the APM X-Gene
 SoC EDAC DTS binding
In-Reply-To: <1431623147-4950-3-git-send-email-lho@apm.com>
References: <1431623147-4950-1-git-send-email-lho@apm.com>
 <1431623147-4950-2-git-send-email-lho@apm.com>
 <1431623147-4950-3-git-send-email-lho@apm.com>
Message-ID: <1431623147-4950-4-git-send-email-lho@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds documentation for the APM X-Gene SoC EDAC DTS binding.

Signed-off-by: Loc Ho <lho@apm.com>
---
 .../devicetree/bindings/edac/apm-xgene-edac.txt    |   74 ++++++++++++++++++++
 1 files changed, 74 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/edac/apm-xgene-edac.txt

diff --git a/Documentation/devicetree/bindings/edac/apm-xgene-edac.txt b/Documentation/devicetree/bindings/edac/apm-xgene-edac.txt
new file mode 100644
index 0000000..bd42c53
--- /dev/null
+++ b/Documentation/devicetree/bindings/edac/apm-xgene-edac.txt
@@ -0,0 +1,74 @@
+* APM X-Gene SoC EDAC node
+
+EDAC node is defined to describe on-chip error detection and correction.
+The follow error types are supported:
+
+  memory controller	- Memory controller
+  PMD (L1/L2)		- Processor module unit (PMD) L1/L2 cache
+
+The following section describes the EDAC DT node binding.
+
+Required properties:
+- compatible		: Shall be "apm,xgene-edac".
+- reg			: First resource shall be the CPU bus (PCP) resource.
+- interrupts            : Interrupt-specifier for MCU, PMD, L3, or SoC error
+			  IRQ(s).
+
+Required properties for memory controller subnode:
+- compatible		: Shall be "apm,xgene-edac-mc".
+- reg			: First resource shall be the memory controller unit
+                          (MCU) resource.
+- regmap-csw		: Regmap of the CPU switch fabric (CSW) resource.
+- regmap-mcba		: Regmap of the MCB-A (memory bridge) resource.
+- regmap-mcbb		: Regmap of the MCB-B (memory bridge) resource.
+
+Required properties for PMD subnode:
+- compatible		: Shall be "apm,xgene-edac-pmd".
+- reg			: First resource shall be the PMD resource.
+- regmap-efuse		: Regmap of the PMD efuse resource.
+
+Example:
+	csw: csw at 7e200000 {
+		compatible = "syscon";
+		reg = <0x0 0x7e200000 0x0 0x1000>;
+	};
+
+	mcba: mcba at 7e700000 {
+		compatible = "syscon";
+		reg = <0x0 0x7e700000 0x0 0x1000>;
+	};
+
+	mcbb: mcbb at 7e720000 {
+		compatible = "syscon";
+		reg = <0x0 0x7e720000 0x0 0x1000>;
+	};
+
+	efuse: efuse at 1054a000 {
+		compatible = "syscon";
+		reg = <0x0 0x1054a000 0x0 0x20>;
+	};
+
+	edac: edac at 78800000 {
+		compatible = "apm,xgene-edac";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		reg = <0x0 0x78800000 0x0 0x100>;
+		interrupts = <0x0 0x20 0x4>,
+			     <0x0 0x21 0x4>,
+			     <0x0 0x27 0x4>;
+
+		edacmc0: edacmc0 at 7e800000 {
+			compatible = "apm,xgene-edac-mc";
+			regmap-csw = <&csw>;
+			regmap-mcba = <&mcba>;
+			regmap-mcbb = <&mcbb>;
+			reg = <0x0 0x7e800000 0x0 0x1000>;
+		};
+
+		edacpmd0: edacpmd0 at 7c000000 {
+			compatible = "apm,xgene-edac-pmd";
+			regmap-efuse = <&efuse>;
+			reg = <0x0 0x7c000000 0x0 0x200000>;
+		};
+
+	};
-- 
1.7.1
