From: robh@kernel.org (Rob Herring)
Date: Fri,  5 Oct 2018 11:58:23 -0500
Subject: [PATCH 11/36] dt-bindings: timer: Convert ARM timer bindings to
 json-schema
In-Reply-To: <20181005165848.3474-1-robh@kernel.org>
References: <20181005165848.3474-1-robh@kernel.org>
Message-ID: <20181005165848.3474-12-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert ARM timers to DT schema format using json-schema.

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree at vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/timer/arm,arch_timer.txt         | 112 ----------------
 .../bindings/timer/arm,arch_timer.yaml        | 103 +++++++++++++++
 .../bindings/timer/arm,arch_timer_mmio.yaml   | 120 ++++++++++++++++++
 .../bindings/timer/arm,global_timer.txt       |  27 ----
 .../bindings/timer/arm,global_timer.yaml      |  46 +++++++
 5 files changed, 269 insertions(+), 139 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/timer/arm,arch_timer.txt
 create mode 100644 Documentation/devicetree/bindings/timer/arm,arch_timer.yaml
 create mode 100644 Documentation/devicetree/bindings/timer/arm,arch_timer_mmio.yaml
 delete mode 100644 Documentation/devicetree/bindings/timer/arm,global_timer.txt
 create mode 100644 Documentation/devicetree/bindings/timer/arm,global_timer.yaml

diff --git a/Documentation/devicetree/bindings/timer/arm,arch_timer.txt b/Documentation/devicetree/bindings/timer/arm,arch_timer.txt
deleted file mode 100644
index 68301b77e854..000000000000
--- a/Documentation/devicetree/bindings/timer/arm,arch_timer.txt
+++ /dev/null
@@ -1,112 +0,0 @@
-* ARM architected timer
-
-ARM cores may have a per-core architected timer, which provides per-cpu timers,
-or a memory mapped architected timer, which provides up to 8 frames with a
-physical and optional virtual timer per frame.
-
-The per-core architected timer is attached to a GIC to deliver its
-per-processor interrupts via PPIs. The memory mapped timer is attached to a GIC
-to deliver its interrupts via SPIs.
-
-** CP15 Timer node properties:
-
-- compatible : Should at least contain one of
-	"arm,armv7-timer"
-	"arm,armv8-timer"
-
-- interrupts : Interrupt list for secure, non-secure, virtual and
-  hypervisor timers, in that order.
-
-- clock-frequency : The frequency of the main counter, in Hz. Should be present
-  only where necessary to work around broken firmware which does not configure
-  CNTFRQ on all CPUs to a uniform correct value. Use of this property is
-  strongly discouraged; fix your firmware unless absolutely impossible.
-
-- always-on : a boolean property. If present, the timer is powered through an
-  always-on power domain, therefore it never loses context.
-
-- fsl,erratum-a008585 : A boolean property. Indicates the presence of
-  QorIQ erratum A-008585, which says that reading the counter is
-  unreliable unless the same value is returned by back-to-back reads.
-  This also affects writes to the tval register, due to the implicit
-  counter read.
-
-- hisilicon,erratum-161010101 : A boolean property. Indicates the
-  presence of Hisilicon erratum 161010101, which says that reading the
-  counters is unreliable in some cases, and reads may return a value 32
-  beyond the correct value. This also affects writes to the tval
-  registers, due to the implicit counter read.
-
-** Optional properties:
-
-- arm,cpu-registers-not-fw-configured : Firmware does not initialize
-  any of the generic timer CPU registers, which contain their
-  architecturally-defined reset values. Only supported for 32-bit
-  systems which follow the ARMv7 architected reset values.
-
-- arm,no-tick-in-suspend : The main counter does not tick when the system is in
-  low-power system suspend on some SoCs. This behavior does not match the
-  Architecture Reference Manual's specification that the system counter "must
-  be implemented in an always-on power domain."
-
-
-Example:
-
-	timer {
-		compatible = "arm,cortex-a15-timer",
-			     "arm,armv7-timer";
-		interrupts = <1 13 0xf08>,
-			     <1 14 0xf08>,
-			     <1 11 0xf08>,
-			     <1 10 0xf08>;
-		clock-frequency = <100000000>;
-	};
-
-** Memory mapped timer node properties:
-
-- compatible : Should at least contain "arm,armv7-timer-mem".
-
-- clock-frequency : The frequency of the main counter, in Hz. Should be present
-  only when firmware has not configured the MMIO CNTFRQ registers.
-
-- reg : The control frame base address.
-
-Note that #address-cells, #size-cells, and ranges shall be present to ensure
-the CPU can address a frame's registers.
-
-A timer node has up to 8 frame sub-nodes, each with the following properties:
-
-- frame-number: 0 to 7.
-
-- interrupts : Interrupt list for physical and virtual timers in that order.
-  The virtual timer interrupt is optional.
-
-- reg : The first and second view base addresses in that order. The second view
-  base address is optional.
-
-- status : "disabled" indicates the frame is not available for use. Optional.
-
-Example:
-
-	timer at f0000000 {
-		compatible = "arm,armv7-timer-mem";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
-		reg = <0xf0000000 0x1000>;
-		clock-frequency = <50000000>;
-
-		frame at f0001000 {
-			frame-number = <0>
-			interrupts = <0 13 0x8>,
-				     <0 14 0x8>;
-			reg = <0xf0001000 0x1000>,
-			      <0xf0002000 0x1000>;
-		};
-
-		frame at f0003000 {
-			frame-number = <1>
-			interrupts = <0 15 0x8>;
-			reg = <0xf0003000 0x1000>;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/timer/arm,arch_timer.yaml b/Documentation/devicetree/bindings/timer/arm,arch_timer.yaml
new file mode 100644
index 000000000000..733ae2254c65
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/arm,arch_timer.yaml
@@ -0,0 +1,103 @@
+# SPDX-License-Identifier: None
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bindings/arm,arch_timer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ARM architected timer
+
+maintainers:
+  - Marc Zyngier <marc.zyngier@arm.com>
+  - Mark Rutland <mark.rutland@arm.com>
+description: |+
+  ARM cores may have a per-core architected timer, which provides per-cpu timers,
+  or a memory mapped architected timer, which provides up to 8 frames with a
+  physical and optional virtual timer per frame.
+
+  The per-core architected timer is attached to a GIC to deliver its
+  per-processor interrupts via PPIs. The memory mapped timer is attached to a GIC
+  to deliver its interrupts via SPIs.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - arm,cortex-a15-timer
+          - enum:
+              - arm,armv7-timer
+      - items:
+          - enum:
+            - arm,armv7-timer
+      - items:
+          - enum:
+            - arm,armv8-timer
+
+  interrupts:
+    items:
+      - description: secure timer irq
+      - description: non-secure timer irq
+      - description: virtual timer irq
+      - description: hypervisor timer irq
+
+  clock-frequency:
+    description: The frequency of the main counter, in Hz. Should be present
+      only where necessary to work around broken firmware which does not configure
+      CNTFRQ on all CPUs to a uniform correct value. Use of this property is
+      strongly discouraged; fix your firmware unless absolutely impossible.
+
+  always-on:
+    type: boolean
+    description: If present, the timer is powered through an always-on power
+      domain, therefore it never loses context.
+
+  fsl,erratum-a008585:
+    type: boolean
+    description: Indicates the presence of QorIQ erratum A-008585, which says
+      that reading the counter is unreliable unless the same value is returned
+      by back-to-back reads. This also affects writes to the tval register, due
+      to the implicit counter read.
+
+  hisilicon,erratum-161010101:
+    type: boolean
+    description: Indicates the presence of Hisilicon erratum 161010101, which
+      says that reading the counters is unreliable in some cases, and reads may
+      return a value 32 beyond the correct value. This also affects writes to
+      the tval registers, due to the implicit counter read.
+
+  arm,cpu-registers-not-fw-configured:
+    type: boolean
+    description: Firmware does not initialize any of the generic timer CPU
+      registers, which contain their architecturally-defined reset values. Only
+      supported for 32-bit systems which follow the ARMv7 architected reset
+      values.
+
+  arm,no-tick-in-suspend:
+    type: boolean
+    description: The main counter does not tick when the system is in
+      low-power system suspend on some SoCs. This behavior does not match the
+      Architecture Reference Manual's specification that the system counter "must
+      be implemented in an always-on power domain."
+
+required:
+  - compatible
+
+oneOf:
+  - required:
+      - interrupts
+  - required:
+      - interrupts-extended
+
+examples:
+  - |
+    timer {
+      compatible = "arm,cortex-a15-timer",
+             "arm,armv7-timer";
+      interrupts = <1 13 0xf08>,
+             <1 14 0xf08>,
+             <1 11 0xf08>,
+             <1 10 0xf08>;
+      clock-frequency = <100000000>;
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/timer/arm,arch_timer_mmio.yaml b/Documentation/devicetree/bindings/timer/arm,arch_timer_mmio.yaml
new file mode 100644
index 000000000000..34c8ecfea2a5
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/arm,arch_timer_mmio.yaml
@@ -0,0 +1,120 @@
+# SPDX-License-Identifier: None
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bindings/arm,arch_timer_mmio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ARM memory mapped architected timer
+
+maintainers:
+  - Marc Zyngier <marc.zyngier@arm.com>
+  - Mark Rutland <mark.rutland@arm.com>
+
+description: |+
+  ARM cores may have a memory mapped architected timer, which provides up to 8
+  frames with a physical and optional virtual timer per frame.
+
+  The memory mapped timer is attached to a GIC to deliver its interrupts via SPIs.
+
+properties:
+  compatible:
+    items:
+      - enum:
+        - arm,armv7-timer-mem
+
+  reg:
+    maxItems: 1
+    description: The control frame base address
+
+  '#address-cells':
+    enum: [1, 2]
+
+  '#size-cells':
+    const: 1
+
+  clock-frequency:
+    description: The frequency of the main counter, in Hz. Should be present
+      only where necessary to work around broken firmware which does not configure
+      CNTFRQ on all CPUs to a uniform correct value. Use of this property is
+      strongly discouraged; fix your firmware unless absolutely impossible.
+
+  always-on:
+    type: boolean
+    description: If present, the timer is powered through an always-on power
+      domain, therefore it never loses context.
+
+  arm,cpu-registers-not-fw-configured:
+    type: boolean
+    description: Firmware does not initialize any of the generic timer CPU
+      registers, which contain their architecturally-defined reset values. Only
+      supported for 32-bit systems which follow the ARMv7 architected reset
+      values.
+
+  arm,no-tick-in-suspend:
+    type: boolean
+    description: The main counter does not tick when the system is in
+      low-power system suspend on some SoCs. This behavior does not match the
+      Architecture Reference Manual's specification that the system counter "must
+      be implemented in an always-on power domain."
+
+patternProperties:
+  '^frame@[0-9a-z]*$':
+    description: A timer node has up to 8 frame sub-nodes, each with the following properties.
+    properties:
+      frame-number:
+        allOf:
+          - $ref: "/schemas/types.yaml#/definitions/uint32"
+          - minimum: 0
+            maximum: 7
+
+      interrupts:
+        minItems: 1
+        maxItems: 2
+        items:
+          - description: physical timer irq
+          - description: virtual timer irq
+
+      reg :
+        minItems: 1
+        maxItems: 2
+        items:
+          - description: 1st view base address
+          - description: 2nd optional view base address
+
+    required:
+      - frame-number
+      - interrupts
+      - reg
+
+required:
+  - compatible
+  - reg
+  - '#address-cells'
+  - '#size-cells'
+
+examples:
+  - |
+    timer at f0000000 {
+      compatible = "arm,armv7-timer-mem";
+      #address-cells = <1>;
+      #size-cells = <1>;
+      ranges;
+      reg = <0xf0000000 0x1000>;
+      clock-frequency = <50000000>;
+
+      frame at f0001000 {
+        frame-number = <0>;
+        interrupts = <0 13 0x8>,
+               <0 14 0x8>;
+        reg = <0xf0001000 0x1000>,
+              <0xf0002000 0x1000>;
+      };
+
+      frame at f0003000 {
+        frame-number = <1>;
+        interrupts = <0 15 0x8>;
+        reg = <0xf0003000 0x1000>;
+      };
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/timer/arm,global_timer.txt b/Documentation/devicetree/bindings/timer/arm,global_timer.txt
deleted file mode 100644
index bdae3a818793..000000000000
--- a/Documentation/devicetree/bindings/timer/arm,global_timer.txt
+++ /dev/null
@@ -1,27 +0,0 @@
-
-* ARM Global Timer
-	Cortex-A9 are often associated with a per-core Global timer.
-
-** Timer node required properties:
-
-- compatible : should contain
-	     * "arm,cortex-a5-global-timer" for Cortex-A5 global timers.
-	     * "arm,cortex-a9-global-timer" for Cortex-A9 global
-	         timers or any compatible implementation. Note: driver
-	         supports versions r2p0 and above.
-
-- interrupts : One interrupt to each core
-
-- reg : Specify the base address and the size of the GT timer
-	register window.
-
-- clocks : Should be phandle to a clock.
-
-Example:
-
-	timer at 2c000600 {
-		compatible = "arm,cortex-a9-global-timer";
-		reg = <0x2c000600 0x20>;
-		interrupts = <1 13 0xf01>;
-		clocks = <&arm_periph_clk>;
-	};
diff --git a/Documentation/devicetree/bindings/timer/arm,global_timer.yaml b/Documentation/devicetree/bindings/timer/arm,global_timer.yaml
new file mode 100644
index 000000000000..09090f677387
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/arm,global_timer.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: None
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bindings/arm,global_timer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ARM Global Timer
+
+maintainers:
+  - Stuart Menefy <stuart.menefy@st.com>
+
+description:
+  Cortex-A9 are often associated with a per-core Global timer.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - arm,cortex-a5-global-timer
+          - arm,cortex-a9-global-timer
+
+    description: driver supports versions r2p0 and above.
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+examples:
+  - |
+    timer at 2c000600 {
+      compatible = "arm,cortex-a9-global-timer";
+      reg = <0x2c000600 0x20>;
+      interrupts = <1 13 0xf01>;
+      clocks = <&arm_periph_clk>;
+    };
+...
-- 
2.17.1
