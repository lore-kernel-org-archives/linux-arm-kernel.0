From: guillaume.tucker@collabora.com (Guillaume Tucker)
Date: Tue, 25 Apr 2017 14:16:16 +0100
Subject: [PATCH v4 1/5] dt-bindings: gpu: add bindings for the ARM Mali
 Midgard GPU
In-Reply-To: <cover.1493125299.git.guillaume.tucker@collabora.com>
References: <cover.1493125299.git.guillaume.tucker@collabora.com>
Message-ID: <9349c8ae9091fbd93e9410f4cfae770ac850bf6b.1493125299.git.guillaume.tucker@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARM Mali Midgard GPU family is present in a number of SoCs
from many different vendors such as Samsung Exynos and Rockchip.

Import the device tree bindings documentation from the r16p0
release of the Mali Midgard GPU kernel driver:

  https://developer.arm.com/-/media/Files/downloads/mali-drivers/kernel/mali-midgard-gpu/TX011-SW-99002-r16p0-00rel0.tgz

Remove the copyright and GPL licence header as deemed not necessary.

Redesign the "compatible" property strings to list all the Mali
Midgard GPU types and include optional vendor ones.

Drop the "clock-names" property as only one clock is used by the Mali
Midgard driver (which now needs to call clk_get with NULL).

Convert the "interrupt-names" property values to lower-case: "job",
"mmu" and "gpu".

Replace the deprecated "operating-points" optional property with
"operating-points-v2".

Omit the following optional properties in this initial version as they
are only used in very specific cases:

  * snoop_enable_smc
  * snoop_disable_smc
  * jm_config
  * power_model
  * system-coherency
  * ipa-model

Update the example accordingly to reflect all these changes.

CC: John Reitan <john.reitan@arm.com>
Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>
---
 .../devicetree/bindings/gpu/arm,mali-midgard.txt   | 82 ++++++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
new file mode 100644
index 000000000000..547ddeceb498
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
@@ -0,0 +1,82 @@
+ARM Mali Midgard GPU
+====================
+
+Required properties:
+
+- compatible :
+  * Must be one of the following:
+    + "arm,mali-t60x"
+    + "arm,mali-t62x"
+    + "arm,mali-t720"
+    + "arm,mali-t760"
+    + "arm,mali-t820"
+    + "arm,mali-t830"
+    + "arm,mali-t860"
+    + "arm,mali-t880"
+  * And, optionally, one of the vendor specific compatible:
+    + "amlogic,meson-gxm-mali"
+    + "rockchip,rk3288-mali"
+
+- reg : Physical base address of the device and length of the register area.
+
+- interrupts : Contains the three IRQ lines required by Mali Midgard devices.
+
+- interrupt-names : Contains the names of IRQ resources in the order they were
+  provided in the interrupts property. Must contain: "job", "mmu", "gpu".
+
+
+Optional properties:
+
+- clocks : Phandle to clock for the Mali Midgard device.
+
+- mali-supply : Phandle to regulator for the Mali device. Refer to
+  Documentation/devicetree/bindings/regulator/regulator.txt for details.
+
+- operating-points-v2 : Refer to Documentation/devicetree/bindings/power/opp.txt
+  for details.
+
+
+Example for a Mali-T602:
+
+gpu at fc010000 {
+	compatible = "arm,mali-t60x", "arm,mali-midgard";
+	reg = <0xfc010000 0x4000>;
+	interrupts = <0 36 4>, <0 37 4>, <0 38 4>;
+	interrupt-names = "job", "mmu", "gpu";
+	clocks = <&pclk_mali>;
+	mali-supply = <&vdd_mali>;
+	operating-points-v2 = <&gpu_opp_table>;
+};
+
+gpu_opp_table: opp_table0 {
+	compatible = "operating-points-v2";
+
+	opp at 533000000 {
+		opp-hz = /bits/ 64 <533000000>;
+		opp-microvolt = <1250000>;
+	};
+	opp at 450000000 {
+		opp-hz = /bits/ 64 <450000000>;
+		opp-microvolt = <1150000>;
+	};
+	opp at 400000000 {
+		opp-hz = /bits/ 64 <400000000>;
+		opp-microvolt = <1125000>;
+	};
+	opp at 350000000 {
+		opp-hz = /bits/ 64 <350000000>;
+		opp-microvolt = <1075000>;
+	};
+	opp at 266000000 {
+		opp-hz = /bits/ 64 <266000000>;
+		opp-microvolt = <1025000>;
+	};
+	opp at 160000000 {
+		opp-hz = /bits/ 64 <160000000>;
+		opp-microvolt = <925000>;
+	};
+	opp at 100000000 {
+		opp-hz = /bits/ 64 <100000000>;
+		opp-microvolt = <912500>;
+	};
+};
-- 
2.11.0
