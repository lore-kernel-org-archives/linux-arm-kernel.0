From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 17 May 2013 16:20:46 +0100
Subject: [RFC PATCH v4 03/18] Documentation: devicetree: arm: cpus/cpu nodes
 bindings updates
In-Reply-To: <1368804061-4421-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1368804061-4421-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1368804061-4421-4-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to extend the current cpu nodes bindings to newer CPUs
inclusive of AArch64 and to update support for older ARM CPUs this
patch updates device tree documentation for the cpu nodes bindings.

Main changes:
    - adds 64-bit bindings
    - define usage of #address-cells
    - define 32/64 dts compatibility settings
    - defines behaviour on pre and post v7 uniprocessor systems
    - adds ARM 11MPcore specific reg property definition

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 Documentation/devicetree/bindings/arm/cpus.txt | 459 ++++++++++++++++++++++---
 1 file changed, 412 insertions(+), 47 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
index f32494d..3fc0c11 100644
--- a/Documentation/devicetree/bindings/arm/cpus.txt
+++ b/Documentation/devicetree/bindings/arm/cpus.txt
@@ -1,77 +1,442 @@
-* ARM CPUs binding description
+=================
+ARM CPUs bindings
+=================
 
 The device tree allows to describe the layout of CPUs in a system through
 the "cpus" node, which in turn contains a number of subnodes (ie "cpu")
 defining properties for every cpu.
 
-Bindings for CPU nodes follow the ePAPR standard, available from:
-
-http://devicetree.org
-
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
+Bindings for CPU nodes follow the ePAPR v1.1 standard, available from:
+
+https://www.power.org/documentation/epapr-version-1-1/
+
+with updates for 32-bit and 64-bit ARM systems provided in this document.
+
+================================
+Convention used in this document
+================================
+
+This document follows the conventions described in the ePAPR v1.1, with
+the addition:
+
+- square brackets define bitfields, eg reg[7:0] value of the bitfield in
+  the reg property contained in bits 7 down to 0
+
+=====================================
+cpus and cpu node bindings definition
+=====================================
+
+The ARM architecture, in accordance with the ePAPR, requires the cpus and cpu
+nodes to be present and contain the properties described below.
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
+
+		Definition depends on ARM architecture version and
+		configuration:
+
+			# On uniprocessor ARM architectures previous to v7
+			  value must be 0.
+			# On 32-bit ARM 11 MPcore, ARM v7 or later systems
+			  value must be 1.
+			# On ARM v8 64-bit systems value must be set to 1
+			  or 2. Refer to the cpu node's reg property
+			  description for allowed configurations.
+
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
+			# On 32-bit ARM v7 or later systems this property is
+			  required and matches the CPU MPIDR[23:0] register
+			  bits.
+
+			  Bits [23:0] in the reg cell must be set to
+			  bits [23:0] in MPIDR.
+
+			  All other bits in the reg cell must be set to 0.
+
+			# On ARM v8 64-bit systems, where the reg property
+			  size can be 1 or 2 cells (as defined by cpus node's
+			  #address-cells property), this property is
+			  required and matches:
+
+			  - On systems running the OS in AArch32:
+
+			    * If the cpus node's #address-cells value is 2:
+
+			      The first reg cell must be set to 0.
+
+			      The second reg cell bits [23:0] must be set to
+			      bits [23:0] of MPIDR_EL1.
+
+			      All other bits in the reg cells must be set to 0.
+
+			    * If the cpus node's #address-cells value is 1:
+
+			      Bits [23:0] in the reg cell must be set to
+			      bits [23:0] in MPIDR_EL1.
+
+			      All other bits in the reg cell must be 0.
+
+			  - On systems running the OS in AArch64:
+
+			    * If the cpus node's #address-cells value is 2:
+
+			      The first reg cell bits [7:0] must be set to
+			      bits [39:32] of MPIDR_EL1.
+
+			      The second reg cell bits [23:0] must be set to
+			      bits [23:0] of MPIDR_EL1.
+
+			      All other bits in the reg cells must be set to 0.
+
+			    * If the cpus node's #address-cells value is 1:
+
+			      MPIDR_EL1[63:32] is 0 on all processors in the
+			      system.
+
+			      The reg cell bits [23:0] must be set to
+			      bits [23:0] of MPIDR_EL1.
+
+			      All other bits in the reg cell must be set to 0.
+
+	- compatible:
+		Usage: required
+		Value type: <string>
+		Definition: should be one of:
+			    "arm,arm710t"
+			    "arm,arm720t"
+			    "arm,arm740t"
+			    "arm,arm7ej-s"
+			    "arm,arm7tdmi"
+			    "arm,arm7tdmi-s"
+			    "arm,arm9es"
+			    "arm,arm9ej-s"
+			    "arm,arm920t"
+			    "arm,arm922t"
+			    "arm,arm925"
+			    "arm,arm926e-s"
+			    "arm,arm926ej-s"
+			    "arm,arm940t"
+			    "arm,arm946e-s"
+			    "arm,arm966e-s"
+			    "arm,arm968e-s"
+			    "arm,arm9tdmi"
+			    "arm,arm1020e"
+			    "arm,arm1020t"
+			    "arm,arm1022e"
+			    "arm,arm1026ej-s"
+			    "arm,arm1136j-s"
+			    "arm,arm1136jf-s"
+			    "arm,arm1156t2-s"
+			    "arm,arm1156t2f-s"
+			    "arm,arm1176jzf"
+			    "arm,arm1176jz-s"
+			    "arm,arm1176jzf-s"
+			    "arm,arm11mpcore"
+			    "arm,cortex-a5"
+			    "arm,cortex-a7"
+			    "arm,cortex-a8"
+			    "arm,cortex-a9"
+			    "arm,cortex-a15"
+			    "arm,cortex-a53"
+			    "arm,cortex-a57"
+			    "arm,cortex-m0"
+			    "arm,cortex-m0+"
+			    "arm,cortex-m1"
+			    "arm,cortex-m3"
+			    "arm,cortex-m4"
+			    "arm,cortex-r4"
+			    "arm,cortex-r5"
+			    "arm,cortex-r7"
+			    "faraday,fa526"
+			    "intel,sa110"
+			    "intel,sa1100"
+			    "marvell,feroceon"
+			    "marvell,mohawk"
+			    "marvell,pj4"
+			    "marvell,sheeva-v7"
+			    "marvell,xsc3"
+			    "marvell,xscale"
+			    "qcom,krait"
+			    "qcom,scorpion"
+	- enable-method
+		Value type: <stringlist>
+		Usage and definition depend on ARM architecture version and
+		configuration:
+			# On ARM v8 64-bit systems running the OS in AArch64,
+			  this property is required and must be one of:
+			     "spin-table"
+			     "psci"
+			# On ARM 32-bit systems or ARM v8 systems running
+			  the OS in AArch32 this property is prohibited.
+
+	- cpu-release-addr
+		Usage: required for systems that have an "enable-method"
+		       property value of "spin-table".
+		Value type: <prop-encoded-array>
+		Definition:
+			# On ARM v8 64-bit systems must be a two cell
+			  property identifying a 64-bit zero-initialised
+			  memory location.
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
+	};
+
+Example 3 (ARM 926EJ-S uniprocessor 32-bit system):
+
+	cpus {
+		#size-cells = <0>;
+		#address-cells = <0>;
+
+		cpu {
+			device_type = "cpu";
+			compatible = "arm,arm926ej-s";
+		};
+	};
+
+Example 4 (ARM Cortex-A57 64-bit system running OS in AArch64):
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
+
+Example 5 (ARM Cortex-A57 64-bit system running OS in AArch32):
+
+cpus {
+	#size-cells = <0>;
+	#address-cells = <2>;
+
+	cpu at 0 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a57";
+		reg = <0x0 0x0>;
+	};
+
+	cpu at 1 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a57";
+		reg = <0x0 0x1>;
+	};
+
+	cpu at 100 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a57";
+		reg = <0x0 0x100>;
+	};
+
+	cpu at 101 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a57";
+		reg = <0x0 0x101>;
+	};
+};
-- 
1.8.2.2
