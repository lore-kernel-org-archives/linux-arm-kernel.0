From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 15 Apr 2013 17:13:22 +0100
Subject: [RFC PATCH 2/2] ARM: DT: kernel: DT cpu node bindings update
In-Reply-To: <1366042402-8987-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1366042402-8987-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1366042402-8987-3-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to extend the current cpu nodes bindings to newer CPUs
inclusive of AArch64 and to update support for older ARM CPUs this
patch updates device tree documentation for the cpu nodes bindings.

Main changes:

- adds 64-bit bindings (inclusive of cpus node #address-cells updates)
- defines behaviour on pre and post v7 uniprocessor systems
- adds ARM 11MPcore specific reg property definition

DT cpu map parsing code must be made compliant with the latest bindings
updates, hence this patch also updates the arm_dt_init_cpu_maps() function
with checks and additional parsing rules.

Uniprocessor systems predating v7 do not parse the cpus node at all
since the reg property is meaningless on those systems.

Device trees for 64-bit systems can be taken as device tree input also
for 64-bit CPUs running in 32-bit mode. The code checks that the reg entries
are zeroed as required in the respective fields and detects automatically
the cpus node #address-cells value so that device tree written for
64-bit ARM platforms (cpus #address-cells == 2) can still be taken as
input. The correct device tree entries are to be set up by the boot
loader, kernel code just checks that device tree entries in the cpus
node are as expected for a 32-bit CPU (reg[63:24] == 0).

cpu node entries with invalid reg property or containing duplicates are
ignored and the device tree parsing is not stopped anymore when such
entries are encountered, the device tree cpu entry is just skipped.

A device tree with cpu nodes missing the boot CPU MPIDR is considered a
hard error and the kernel flags this up as a bug to force firmware updates.

The updates to cpus/cpu node bindings for ARM require all in-kernel dts files
present in the mainline to be made compliant to the latest specification.

This patch also updates ARM in-kernel non-compliant dts files to the latest
cpus/cpu nodes bindings specification.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 Documentation/devicetree/bindings/arm/cpus.txt | 335 +++++++++++++++++++++----
 arch/arm/boot/dts/exynos5440.dtsi              |   7 +
 arch/arm/boot/dts/omap3.dtsi                   |   4 +
 arch/arm/boot/dts/omap4.dtsi                   |   5 +
 arch/arm/boot/dts/omap5.dtsi                   |   5 +
 arch/arm/boot/dts/r8a7740.dtsi                 |   3 +
 arch/arm/boot/dts/sh7372.dtsi                  |   4 +
 arch/arm/boot/dts/sunxi.dtsi                   |   4 +
 arch/arm/kernel/devtree.c                      |  82 +++---
 9 files changed, 377 insertions(+), 72 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
index f32494d..b1ef3d8 100644
--- a/Documentation/devicetree/bindings/arm/cpus.txt
+++ b/Documentation/devicetree/bindings/arm/cpus.txt
@@ -1,4 +1,6 @@
-* ARM CPUs binding description
+=============================
+ARM CPUs bindings description
+=============================
 
 The device tree allows to describe the layout of CPUs in a system through
 the "cpus" node, which in turn contains a number of subnodes (ie "cpu")
@@ -8,70 +10,317 @@ Bindings for CPU nodes follow the ePAPR standard, available from:
 
 http://devicetree.org
 
-For the ARM architecture every CPU node must contain the following properties:
-
-- device_type:	must be "cpu"
-- reg:		property matching the CPU MPIDR[23:0] register bits
-		reg[31:24] bits must be set to 0
-- compatible:	should be one of:
-		"arm,arm1020"
-		"arm,arm1020e"
-		"arm,arm1022"
-		"arm,arm1026"
-		"arm,arm720"
-		"arm,arm740"
-		"arm,arm7tdmi"
-		"arm,arm920"
-		"arm,arm922"
-		"arm,arm925"
-		"arm,arm926"
-		"arm,arm940"
-		"arm,arm946"
-		"arm,arm9tdmi"
-		"arm,cortex-a5"
-		"arm,cortex-a7"
-		"arm,cortex-a8"
-		"arm,cortex-a9"
-		"arm,cortex-a15"
-		"arm,arm1136"
-		"arm,arm1156"
-		"arm,arm1176"
-		"arm,arm11mpcore"
-		"faraday,fa526"
-		"intel,sa110"
-		"intel,sa1100"
-		"marvell,feroceon"
-		"marvell,mohawk"
-		"marvell,xsc3"
-		"marvell,xscale"
-
-Example:
+with updates for 32-bit and 64-bit ARM systems provided in this document.
+
+In the bindings below:
+
+- square brackets define bitfields, eg reg[7:0] value of the bitfield in
+  the reg property contained in bits 7 down to 0
+
+- cpus node
+
+	Description: Container of cpu nodes
+
+	The node name must be "cpus".
+
+	A cpus node must define the following properties:
+
+	- #address-cells
+		Usage: required
+		Value type: <u32>
+		Definition: must be set to 1 for 32-bit systems and 2 for
+			    64-bit systems
+	- #size-cells
+		Usage: required
+		Value type: <u32>
+		Definition: must be set to 0
+
+- cpu node
+
+	Description: Describes a CPU in an ARM based system
+
+	PROPERTIES
+
+	- device_type
+		Usage: required
+		Value type: <string>
+		Definition: must be "cpu"
+	- reg
+		Usage and definition depend on ARM architecture version and
+		configuration:
+
+			# On uniprocessor ARM architectures previous to v7
+			  this property is optional since they do not define
+			  any register that provides a CPU identifier.
+			  Any value set in the reg property for these CPUs
+			  should be ignored.
+
+			# On ARM 11 MPcore based systems this property is
+			  required and matches the CPUID[11:0] register bits.
+
+			  Bits [11:0] in the reg cell must be set to
+			  bits [11:0] in CPU ID register.
+
+			  All other bits in the reg cell must be set to 0.
+
+			# On ARM architecture versions >= 7 based 32-bit
+			  systems this property is required and matches the
+			  CPU MPIDR[23:0] register bits.
+
+			  Bits [23:0] in the reg cell must be set to
+			  bits [23:0] in MPIDR.
+
+			  All other bits in the reg cell must be set to 0.
+
+			# On ARM v8 64-bit systems, where the reg property
+			  is made up of two cells to accomodate the 64-bit
+			  MPDIR_EL1 register this property is required and
+			  matches:
+
+			  The first reg cell bits [7:0] must be set to
+			  bits [39:32] of MPIDR_EL1.
+
+			  The second reg cell bits [23:0] must be set to
+			  bits [23:0] of MPIDR_EL1.
+
+			  All other bits in the reg cells must be set to 0.
+	- compatible:
+		Usage: required
+		Value type: <string>
+		Definition: should be one of:
+			    "arm,arm1020"
+			    "arm,arm1020e"
+			    "arm,arm1022"
+			    "arm,arm1026"
+			    "arm,arm720"
+			    "arm,arm740"
+			    "arm,arm7tdmi"
+			    "arm,arm920"
+			    "arm,arm922"
+			    "arm,arm925"
+			    "arm,arm926"
+			    "arm,arm940"
+			    "arm,arm946"
+			    "arm,arm9tdmi"
+			    "arm,cortex-a5"
+			    "arm,cortex-a7"
+			    "arm,cortex-a8"
+			    "arm,cortex-a9"
+			    "arm,cortex-a15"
+			    "arm,cortex-a57"
+			    "arm,arm1136"
+			    "arm,arm1156"
+			    "arm,arm1176"
+			    "arm,arm11mpcore"
+			    "faraday,fa526"
+			    "intel,sa110"
+			    "intel,sa1100"
+			    "marvell,feroceon"
+			    "marvell,mohawk"
+			    "marvell,xsc3"
+			    "marvell,xscale"
+	- enable-method
+		Usage: required on ARM 64-bit systems, optional on ARM 32-bit
+		       systems
+		Value type: <string>
+		Definition: On ARM 64-bit systems must be "spin-table" [1].
+
+	- cpu-release-addr
+		Usage: required on ARM 64-bit systems, optional on ARM 32-bit
+		       systems
+		Value type: <prop-encoded-array>
+		Definition: On ARM 64-bit systems must be a two cell
+			    property identifying a 64-bit zero-initialised
+			    memory location [1].
+
+Example 1 (dual-cluster big.LITTLE system 32-bit):
 
 	cpus {
 		#size-cells = <0>;
 		#address-cells = <1>;
 
-		CPU0: cpu at 0 {
+		cpu at 0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a15";
 			reg = <0x0>;
 		};
 
-		CPU1: cpu at 1 {
+		cpu at 1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a15";
 			reg = <0x1>;
 		};
 
-		CPU2: cpu at 100 {
+		cpu at 100 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a7";
 			reg = <0x100>;
 		};
 
-		CPU3: cpu at 101 {
+		cpu at 101 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a7";
 			reg = <0x101>;
 		};
 	};
+
+Example 2 (Cortex-A8 uniprocessor 32-bit system):
+
+	cpus {
+		#size-cells = <0>;
+		#address-cells = <1>;
+
+		cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a8";
+			reg = <0x0>;
+		};
+
+	};
+
+Example 3 (ARM 1176 uniprocessor 32-bit system):
+
+	cpus {
+		cpu {
+			device_type = "cpu";
+			compatible = "arm,arm1176";
+		};
+	};
+
+Example 4 (ARM Cortex-A57 64-bit system):
+
+cpus {
+	#size-cells = <0>;
+	#address-cells = <2>;
+
+	cpu at 0 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a57";
+		reg = <0x0 0x0>;
+		enable-method = "spin-table";
+		cpu-release-addr = <0 0x20000000>;
+	};
+
+	cpu at 1 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a57";
+		reg = <0x0 0x1>;
+		enable-method = "spin-table";
+		cpu-release-addr = <0 0x20000000>;
+	};
+
+	cpu at 100 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a57";
+		reg = <0x0 0x100>;
+		enable-method = "spin-table";
+		cpu-release-addr = <0 0x20000000>;
+	};
+
+	cpu at 101 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a57";
+		reg = <0x0 0x101>;
+		enable-method = "spin-table";
+		cpu-release-addr = <0 0x20000000>;
+	};
+
+	cpu at 10000 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a57";
+		reg = <0x0 0x10000>;
+		enable-method = "spin-table";
+		cpu-release-addr = <0 0x20000000>;
+	};
+
+	cpu at 10001 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a57";
+		reg = <0x0 0x10001>;
+		enable-method = "spin-table";
+		cpu-release-addr = <0 0x20000000>;
+	};
+
+	cpu at 10100 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a57";
+		reg = <0x0 0x10100>;
+		enable-method = "spin-table";
+		cpu-release-addr = <0 0x20000000>;
+	};
+
+	cpu at 10101 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a57";
+		reg = <0x0 0x10101>;
+		enable-method = "spin-table";
+		cpu-release-addr = <0 0x20000000>;
+	};
+
+	cpu at 100000000 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a57";
+		reg = <0x1 0x0>;
+		enable-method = "spin-table";
+		cpu-release-addr = <0 0x20000000>;
+	};
+
+	cpu at 100000001 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a57";
+		reg = <0x1 0x1>;
+		enable-method = "spin-table";
+		cpu-release-addr = <0 0x20000000>;
+	};
+
+	cpu at 100000100 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a57";
+		reg = <0x1 0x100>;
+		enable-method = "spin-table";
+		cpu-release-addr = <0 0x20000000>;
+	};
+
+	cpu at 100000101 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a57";
+		reg = <0x1 0x101>;
+		enable-method = "spin-table";
+		cpu-release-addr = <0 0x20000000>;
+	};
+
+	cpu at 100010000 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a57";
+		reg = <0x1 0x10000>;
+		enable-method = "spin-table";
+		cpu-release-addr = <0 0x20000000>;
+	};
+
+	cpu at 100010001 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a57";
+		reg = <0x1 0x10001>;
+		enable-method = "spin-table";
+		cpu-release-addr = <0 0x20000000>;
+	};
+
+	cpu at 100010100 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a57";
+		reg = <0x1 0x10100>;
+		enable-method = "spin-table";
+		cpu-release-addr = <0 0x20000000>;
+	};
+
+	cpu at 100010101 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a57";
+		reg = <0x1 0x10101>;
+		enable-method = "spin-table";
+		cpu-release-addr = <0 0x20000000>;
+	};
+};
+===============================================================================
+[1] ARM Linux kernel documentation
+    Documentation/devicetree/bindings/arm64/booting.txt
diff --git a/arch/arm/boot/dts/exynos5440.dtsi b/arch/arm/boot/dts/exynos5440.dtsi
index 5f3562a..eda21d5 100644
--- a/arch/arm/boot/dts/exynos5440.dtsi
+++ b/arch/arm/boot/dts/exynos5440.dtsi
@@ -24,8 +24,12 @@
 	};
 
 	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
 		cpu at 0 {
 			compatible = "arm,cortex-a15";
+			reg = <0x0>;
 			timer {
 				compatible = "arm,armv7-timer";
 				interrupts = <1 13 0xf08>;
@@ -34,6 +38,7 @@
 		};
 		cpu at 1 {
 			compatible = "arm,cortex-a15";
+			reg = <0x1>;
 			timer {
 				compatible = "arm,armv7-timer";
 				interrupts = <1 14 0xf08>;
@@ -42,6 +47,7 @@
 		};
 		cpu at 2 {
 			compatible = "arm,cortex-a15";
+			reg = <0x2>;
 			timer {
 				compatible = "arm,armv7-timer";
 				interrupts = <1 14 0xf08>;
@@ -50,6 +56,7 @@
 		};
 		cpu at 3 {
 			compatible = "arm,cortex-a15";
+			reg = <0x3>;
 			timer {
 				compatible = "arm,armv7-timer";
 				interrupts = <1 14 0xf08>;
diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 1acc261..b4e2b8d 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -21,8 +21,12 @@
 	};
 
 	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
 		cpu at 0 {
 			compatible = "arm,cortex-a8";
+			reg = <0x0>;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 739bb79..9c5f7c2 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -28,13 +28,18 @@
 	};
 
 	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
 		cpu at 0 {
 			compatible = "arm,cortex-a9";
 			next-level-cache = <&L2>;
+			reg = <0x0>;
 		};
 		cpu at 1 {
 			compatible = "arm,cortex-a9";
 			next-level-cache = <&L2>;
+			reg = <0x1>;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 790bb2a..d2106b6 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -31,8 +31,12 @@
 	};
 
 	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
 		cpu at 0 {
 			compatible = "arm,cortex-a15";
+			reg = <0x0>;
 			timer {
 				compatible = "arm,armv7-timer";
 				/* 14th PPI IRQ, active low level-sensitive */
@@ -42,6 +46,7 @@
 		};
 		cpu at 1 {
 			compatible = "arm,cortex-a15";
+			reg = <0x1>;
 			timer {
 				compatible = "arm,armv7-timer";
 				/* 14th PPI IRQ, active low level-sensitive */
diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
index 798fa35..b47bb36 100644
--- a/arch/arm/boot/dts/r8a7740.dtsi
+++ b/arch/arm/boot/dts/r8a7740.dtsi
@@ -14,8 +14,11 @@
 	compatible = "renesas,r8a7740";
 
 	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
 		cpu at 0 {
 			compatible = "arm,cortex-a9";
+			reg = <0x0>;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/sh7372.dtsi b/arch/arm/boot/dts/sh7372.dtsi
index 677fc60..78478af 100644
--- a/arch/arm/boot/dts/sh7372.dtsi
+++ b/arch/arm/boot/dts/sh7372.dtsi
@@ -14,8 +14,12 @@
 	compatible = "renesas,sh7372";
 
 	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
 		cpu at 0 {
 			compatible = "arm,cortex-a8";
+			reg = <0x0>;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/sunxi.dtsi b/arch/arm/boot/dts/sunxi.dtsi
index 8b36abe..447a0f0 100644
--- a/arch/arm/boot/dts/sunxi.dtsi
+++ b/arch/arm/boot/dts/sunxi.dtsi
@@ -17,8 +17,12 @@
 	interrupt-parent = <&intc>;
 
 	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
 		cpu at 0 {
 			compatible = "arm,cortex-a8";
+			reg = <0x0>;
 		};
 	};
 
diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
index f149217..4eda2dc 100644
--- a/arch/arm/kernel/devtree.c
+++ b/arch/arm/kernel/devtree.c
@@ -23,6 +23,7 @@
 #include <asm/setup.h>
 #include <asm/page.h>
 #include <asm/smp_plat.h>
+#include <asm/system_info.h>
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
 
@@ -81,48 +82,68 @@ void __init arm_dt_init_cpu_maps(void)
 	static u32 tmp_map[NR_CPUS] __initdata = {
 				[0 ... NR_CPUS-1] = UINT_MAX };
 	struct device_node *cpu, *cpus;
-	u32 i, j, cpuidx = 1;
+	u32 i, j, ac, cpuidx = 1;
 	u32 mpidr = is_smp() ? read_cpuid_mpidr() & MPIDR_HWID_BITMASK : 0;
-
+	int len;
 	bool bootcpu_valid = false;
+
 	cpus = of_find_node_by_path("/cpus");
 
-	if (!cpus)
+	if (!cpus || ((cpu_architecture() < CPU_ARCH_ARMv7) && !is_smp()))
 		return;
 
+	if (WARN_ON(of_property_read_u32(cpus, "#address-cells", &ac)))
+		ac = of_n_addr_cells(cpus);
+
 	for_each_child_of_node(cpus, cpu) {
-		u32 hwid;
+		u64 hwid64;
+		u32 hwid32;
+		const __be32 *prop;
 
 		pr_debug(" * %s...\n", cpu->full_name);
 		/*
-		 * A device tree containing CPU nodes with missing "reg"
-		 * properties is considered invalid to build the
-		 * cpu_logical_map.
+		 * A CPU node with missing or wrong "reg" property is
+		 * considered invalid to build a cpu_logical_map entry.
 		 */
-		if (of_property_read_u32(cpu, "reg", &hwid)) {
-			pr_debug(" * %s missing reg property\n",
-				     cpu->full_name);
-			return;
+		prop = of_get_property(cpu, "reg", &len);
+		if (!prop || len < (ac * sizeof(*prop))) {
+				WARN(1, " * %s node missing/wrong reg"
+					 " property, skipped\n",
+					 cpu->full_name);
+				goto next;
 		}
-
 		/*
-		 * 8 MSBs must be set to 0 in the DT since the reg property
-		 * defines the MPIDR[23:0].
+		 * Always read reg as u64 value.
+		 * For dts with #address-cells == 1 hwid64[63:32]
+		 * will be set to 0 by of_read_number.
+		 * Toss away the top 32 bits and store value in hwid32.
+		 */
+		hwid32 = hwid64 = of_read_number(prop, ac);
+		/*
+		 * hwid64[63:24] must be always be 0 since the reg
+		 * property defines the MPIDR[23:0] bits regardless
+		 * of the cpus node #address-cells value.
 		 */
-		if (hwid & ~MPIDR_HWID_BITMASK)
-			return;
+		if (hwid64 & ~MPIDR_HWID_BITMASK) {
+			WARN(1, " * %s node reg[63:24] must be 0 on"
+			       " 32-bit dts, got %#016llx, skipped\n",
+			       cpu->full_name, hwid64);
+			goto next;
+		}
 
 		/*
 		 * Duplicate MPIDRs are a recipe for disaster.
 		 * Scan all initialized entries and check for
-		 * duplicates. If any is found just bail out.
+		 * duplicates. If any is found just ignore the CPU.
 		 * temp values were initialized to UINT_MAX
 		 * to avoid matching valid MPIDR[23:0] values.
 		 */
 		for (j = 0; j < cpuidx; j++)
-			if (WARN(tmp_map[j] == hwid, "Duplicate /cpu reg "
-						     "properties in the DT\n"))
-				return;
+			if (WARN(tmp_map[j] == hwid32, " * %s node "
+						"duplicate cpu reg "
+						"property, skipped\n",
+						cpu->full_name))
+				goto next;
 
 		/*
 		 * Build a stashed array of MPIDR values. Numbering scheme
@@ -133,26 +154,29 @@ void __init arm_dt_init_cpu_maps(void)
 		 * logical map built from DT is validated and can be used
 		 * to override the map created in smp_setup_processor_id().
 		 */
-		if (hwid == mpidr) {
+		if (hwid32 == mpidr) {
 			i = 0;
 			bootcpu_valid = true;
 		} else {
 			i = cpuidx++;
 		}
 
-		if (WARN(cpuidx > nr_cpu_ids, "DT /cpu %u nodes greater than "
-					       "max cores %u, capping them\n",
+		if (WARN_ONCE(cpuidx > nr_cpu_ids, "DT cpu %u nodes greater"
+						   " than max cores %u,"
+						   " capping them\n",
 					       cpuidx, nr_cpu_ids)) {
 			cpuidx = nr_cpu_ids;
-			break;
+			goto next;
 		}
 
-		tmp_map[i] = hwid;
+		tmp_map[i] = hwid32;
+next:	;
 	}
-
-	if (WARN(!bootcpu_valid, "DT missing boot CPU MPIDR[23:0], "
-				 "fall back to default cpu_logical_map\n"))
-		return;
+	/*
+	 * A DT missing the boot CPU MPIDR is a really bad omen
+	 * Flag it up as such and force firmware/dtb updates
+	 */
+	BUG_ON(!bootcpu_valid);
 
 	/*
 	 * Since the boot CPU node contains proper data, and all nodes have
-- 
1.7.12
