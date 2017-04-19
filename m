From: guillaume.tucker@collabora.com (Guillaume Tucker)
Date: Wed, 19 Apr 2017 09:06:17 +0100
Subject: [PATCH v3 1/5] dt-bindings: gpu: add bindings for the ARM Mali
 Midgard GPU
In-Reply-To: <cover.1492588180.git.guillaume.tucker@collabora.com>
References: <cover.1492588180.git.guillaume.tucker@collabora.com>
Message-ID: <96021d989387d9aaff039efebd66aa3bfe667941.1492588180.git.guillaume.tucker@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARM Mali Midgard GPU family is present in a number of SoCs
from many different vendors such as Samsung Exynos and Rockchip.

Import the device tree bindings documentation from the r16p0
release of the Mali Midgard GPU kernel driver:

  https://developer.arm.com/-/media/Files/downloads/mali-drivers/kernel/mali-midgard-gpu/TX011-SW-99002-r16p0-00rel0.tgz

The "compatible" property strings have been redesigned to explicitly
list all the Mali Midgard GPU types and include optional vendor ones.

The "clock-names" property has been dropped as only one clock is used
by the Mali Midgard driver which now needs to call clk_get with NULL.

The "interrupt-names" property values have been converted to
lower-case: "job", "mmu" and "gpu".

The following optional bindings have been omitted in this initial
version as they are only used in very specific cases:

  * snoop_enable_smc
  * snoop_disable_smc
  * jm_config
  * power_model
  * system-coherency
  * ipa-model

The example has been simplified accordingly.

The copyright and GPL licence header has been removed as deemed not
necessary.

CC: John Reitan <john.reitan@arm.com>
Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>
---
 .../devicetree/bindings/gpu/arm,mali-midgard.txt   | 57 ++++++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
new file mode 100644
index 000000000000..917c4f8d178f
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
@@ -0,0 +1,57 @@
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
+- operating-points : Refer to Documentation/devicetree/bindings/power/opp.txt
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
+	operating-points = <
+		/* KHz   uV */
+		533000 1250000,
+		450000 1150000,
+		400000 1125000,
+		350000 1075000,
+		266000 1025000,
+		160000  925000,
+		100000  912500,
+	>;
+};
-- 
2.11.0
