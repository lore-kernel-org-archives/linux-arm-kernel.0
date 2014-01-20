From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 20 Jan 2014 17:47:58 +0000
Subject: [PATCH RFC v2 1/2] Documentation: arm: add cache DT bindings
In-Reply-To: <1390240079-6495-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1390240079-6495-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1390240079-6495-2-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ARM systems the cache topology cannot be probed at runtime, in
particular, it is impossible to probe which CPUs share a given cache
level. Power management software requires this knowledge to implement
optimized power down sequences, hence this patch adds a document that
defines the DT cache bindings for ARM systems. The bindings are compliant
with ePAPR (PowerPC bindings), even though most of the cache nodes
properties requirements are overriden, because caches geometry for
architected caches is probeable on ARM systems. This patch also adds
properties that are specific to ARM architected caches to the existing ones
defined in the ePAPR v1.1, as bindings extensions.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 Documentation/devicetree/bindings/arm/cache.txt | 187 ++++++++++++++++++++++++
 1 file changed, 187 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/cache.txt

diff --git a/Documentation/devicetree/bindings/arm/cache.txt b/Documentation/devicetree/bindings/arm/cache.txt
new file mode 100644
index 0000000..b27cedf
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/cache.txt
@@ -0,0 +1,187 @@
+==========================================
+ARM processors cache binding description
+==========================================
+
+Device tree bindings for ARM processor caches adhere to the cache bindings
+described in [3], in section 3.8 for multi-level and shared caches.
+On ARM based systems most of the cache properties related to cache
+geometry are probeable in HW, hence, unless otherwise stated, the properties
+defined in ePAPR for multi-level and shared caches are to be considered
+optional by default.
+
+On ARM, caches are either architected (directly controlled by the processor
+through coprocessor instructions and tightly coupled with the processor
+implementation) or unarchitected (controlled through a memory mapped
+interface, implemented as a stand-alone IP external to the processor
+implementation).
+
+This document provides the device tree bindings for ARM architected caches.
+
+- ARM architected cache node
+
+	Description: must be a direct child of the cpu node. A system
+		     can contain multiple architected cache nodes per cpu node,
+		     linked through the next-level-cache phandle. The
+		     next-level-cache property in the cpu node points to
+		     the first level of architected cache for the CPU.
+		     The next-level-cache property in architected cache nodes
+		     points to the respective next level of caching in the
+		     hierarchy. An architected cache node with an empty or
+		     missing next-level-cache property represents the last
+		     architected cache level for the CPU.
+		     On ARM v7 and v8 architectures, the order in which cache
+		     nodes are linked through the next-level-cache phandle must
+		     follow the ordering specified in the processors CLIDR (v7)
+		     and CLIDR_EL1 (v8) registers, as described in [1][2],
+		     implying that a cache node pointed at by a
+		     next-level-cache phandle must correspond to a level
+		     defined in CLIDR (v7) and CLIDR_EL1 (v8) greater than the
+		     one the cache node containing the next-level-cache
+		     phandle corresponds to.
+
+	Since on ARM most of the cache properties are probeable in HW the
+	properties described in [3] - section 3.8 multi-level and shared
+	caches - shall be considered optional, with the following properties
+	updates, specific for the ARM architected cache node.
+
+	- compatible
+		Usage: Required
+		Value type: <string>
+		Definition: value shall be "arm,arch-cache".
+
+	- interrupts
+		Usage: Optional
+		Value type: See definition
+		Definition: standard device tree property [3] that defines
+			    the interrupt line associated with the cache.
+			    The property can be accompanied by an
+			    interrupt-names property, as described in [4].
+
+	- power-domain
+		Usage: Optional
+		Value type: phandle
+		Definition: A phandle and power domain specifier as defined by
+			    bindings of power controller specified by the
+			    phandle [5].
+
+Example(dual-cluster big.LITTLE system 32-bit)
+
+	cpus {
+		#size-cells = <0>;
+		#address-cells = <1>;
+
+		cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <0x0>;
+			next-level-cache = <&L1_0>;
+
+			L1_0: l1-cache {
+				compatible = "arm,arch-cache";
+				next-level-cache = <&L2_0>;
+			};
+
+			L2_0: l2-cache {
+				compatible = "arm,arch-cache";
+			};
+		};
+
+		cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <0x1>;
+			next-level-cache = <&L1_1>;
+
+			L1_1: l1-cache {
+				compatible = "arm,arch-cache";
+				next-level-cache = <&L2_0>;
+			};
+		};
+
+		cpu at 2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <0x2>;
+			next-level-cache = <&L1_2>;
+
+			L1_2: l1-cache {
+				compatible = "arm,arch-cache";
+				next-level-cache = <&L2_0>;
+			};
+		};
+
+		cpu at 3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <0x3>;
+			next-level-cache = <&L1_3>;
+
+			L1_3: l1-cache {
+				compatible = "arm,arch-cache";
+				next-level-cache = <&L2_0>;
+			};
+		};
+
+		cpu at 100 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0x100>;
+			next-level-cache = <&L1_4>;
+
+			L1_4: l1-cache {
+				compatible = "arm,arch-cache";
+				next-level-cache = <&L2_1>;
+			};
+
+			L2_1: l2-cache {
+				compatible = "arm,arch-cache";
+			};
+		};
+
+		cpu at 101 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0x101>;
+			next-level-cache = <&L1_5>;
+
+			L1_5: l1-cache {
+				compatible = "arm,arch-cache";
+				next-level-cache = <&L2_1>;
+			};
+		};
+
+		cpu at 102 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0x102>;
+			next-level-cache = <&L1_6>;
+
+			L1_6: l1-cache {
+				compatible = "arm,arch-cache";
+				next-level-cache = <&L2_1>;
+			};
+		};
+
+		cpu at 103 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0x103>;
+			next-level-cache = <&L1_7>;
+
+			L1_7: l1-cache {
+				compatible = "arm,arch-cache";
+				next-level-cache = <&L2_1>;
+			};
+		};
+	};
+
+[1] ARMv7-AR Reference Manual
+    http://infocenter.arm.com/help/index.jsp
+[2] ARMv8-A Reference Manual
+    http://infocenter.arm.com/help/index.jsp
+[3] ePAPR standard
+    https://www.power.org/documentation/epapr-version-1-1/
+[4] Kernel documentation - resource property bindings
+    Documentation/devicetree/bindings/resource-names.txt
+[5] Kernel documentation - power domain bindings
+    Documentation/devicetree/bindings/power/power_domain.txt
-- 
1.8.4
