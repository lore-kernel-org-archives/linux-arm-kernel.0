From: ttnguyen@apm.com (Tai Nguyen)
Date: Thu, 31 Mar 2016 16:37:50 -0700
Subject: [PATCH 2/4] Documentation: Add documentation for APM X-Gene SoC PMU
 DTS binding
In-Reply-To: <1459467472-31561-1-git-send-email-ttnguyen@apm.com>
References: <1459467472-31561-1-git-send-email-ttnguyen@apm.com>
Message-ID: <1459467472-31561-3-git-send-email-ttnguyen@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Documentation: Add documentation for APM X-Gene SoC PMU DTS binding

Signed-off-by: Tai Nguyen <ttnguyen@apm.com>
---
 .../devicetree/bindings/perf/apm-xgene-pmu.txt     | 116 +++++++++++++++++++++
 1 file changed, 116 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/perf/apm-xgene-pmu.txt

diff --git a/Documentation/devicetree/bindings/perf/apm-xgene-pmu.txt b/Documentation/devicetree/bindings/perf/apm-xgene-pmu.txt
new file mode 100644
index 0000000..40dfd4e
--- /dev/null
+++ b/Documentation/devicetree/bindings/perf/apm-xgene-pmu.txt
@@ -0,0 +1,116 @@
+* APM X-Gene SoC PMU bindings
+
+This is APM X-Gene SoC PMU (Performance Monitoring Unit) module.
+The following PMU devices are supported:
+
+  L3C			- L3 cache controller
+  IOB			- IO bridge
+  MCB			- Memory controller bridge
+  MC			- Memory controller
+
+The following section describes the SoC PMU DT node binding.
+
+Required properties:
+- compatible		: Shall be "apm,xgene-pmu" for revision 1 or
+                          "apm,xgene-pmu-v2" for revision 2.
+- regmap-csw		: Regmap of the CPU switch fabric (CSW) resource.
+- regmap-mcba		: Regmap of the MCB-A (memory bridge) resource.
+- regmap-mcbb		: Regmap of the MCB-B (memory bridge) resource.
+- reg			: First resource shall be the CPU bus PMU resource.
+- interrupts            : Interrupt-specifier for PMU IRQ.
+
+Required properties for L3C subnode:
+- compatible		: Shall be "apm,xgene-pmu-l3c".
+- reg			: First resource shall be the L3C PMU resource.
+- index			: Instance number of the L3C PMU.
+
+Required properties for IOB subnode:
+- compatible		: Shall be "apm,xgene-pmu-iob".
+- reg			: First resource shall be the IOB PMU resource.
+- index			: Instance number of the IOB PMU.
+
+Required properties for MCB subnode:
+- compatible		: Shall be "apm,xgene-pmu-mcb".
+- reg			: First resource shall be the MCB PMU resource.
+- index			: Instance number of the MCB PMU.
+
+Required properties for MC subnode:
+- compatible		: Shall be "apm,xgene-pmu-mc".
+- reg			: First resource shall be the MC PMU resource.
+- index			: Instance number of the MC PMU.
+
+Example:
+	csw: csw at 7e200000 {
+		compatible = "apm,xgene-csw", "syscon";
+		reg = <0x0 0x7e200000 0x0 0x1000>;
+	};
+
+	mcba: mcba at 7e700000 {
+		compatible = "apm,xgene-mcb", "syscon";
+		reg = <0x0 0x7e700000 0x0 0x1000>;
+	};
+
+	mcbb: mcbb at 7e720000 {
+		compatible = "apm,xgene-mcb", "syscon";
+		reg = <0x0 0x7e720000 0x0 0x1000>;
+	};
+
+	pmu: pmu at 78810000 {
+		compatible = "apm,xgene-pmu-v2";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		regmap-csw = <&csw>;
+		regmap-mcba = <&mcba>;
+		regmap-mcbb = <&mcbb>;
+		reg = <0x0 0x78810000 0x0 0x1000>;
+		interrupts = <0x0 0x22 0x4>;
+
+		pmul3c at 7e610000 {
+			compatible = "apm,xgene-pmu-l3c";
+			reg = <0x0 0x7e610000 0x0 0x1000>;
+			index = <0>;
+		};
+
+		pmuiob at 7e940000 {
+			compatible = "apm,xgene-pmu-iob";
+			reg = <0x0 0x7e940000 0x0 0x1000>;
+			index = <0>;
+		};
+
+		pmucmcb at 7e710000 {
+			compatible = "apm,xgene-pmu-mcb";
+			reg = <0x0 0x7e710000 0x0 0x1000>;
+			index = <0>;
+		};
+
+		pmucmcb at 7e730000 {
+			compatible = "apm,xgene-pmu-mcb";
+			reg = <0x0 0x7e730000 0x0 0x1000>;
+			index = <1>;
+		};
+
+		pmucmc at 7e810000 {
+			compatible = "apm,xgene-pmu-mc";
+			reg = <0x0 0x7e810000 0x0 0x1000>;
+			index = <0>;
+		};
+
+		pmucmc at 7e850000 {
+			compatible = "apm,xgene-pmu-mc";
+			reg = <0x0 0x7e850000 0x0 0x1000>;
+			index = <1>;
+		};
+
+		pmucmc at 7e890000 {
+			compatible = "apm,xgene-pmu-mc";
+			reg = <0x0 0x7e890000 0x0 0x1000>;
+			index = <2>;
+		};
+
+		pmucmc at 7e8d0000 {
+			compatible = "apm,xgene-pmu-mc";
+			reg = <0x0 0x7e8d0000 0x0 0x1000>;
+			index = <3>;
+		};
+	};
-- 
1.9.1
