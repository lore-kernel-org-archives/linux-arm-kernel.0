From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 11 Jun 2014 17:18:35 +0100
Subject: [PATCH v4 1/6] Documentation: arm: define DT idle states bindings
In-Reply-To: <1402503520-8611-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1402503520-8611-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1402503520-8611-2-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM based platforms implement a variety of power management schemes that
allow processors to enter idle states at run-time.
The parameters defining these idle states vary on a per-platform basis forcing
the OS to hardcode the state parameters in platform specific static tables
whose size grows as the number of platforms supported in the kernel increases
and hampers device drivers standardization.

Therefore, this patch aims at standardizing idle state device tree bindings for
ARM platforms. Bindings define idle state parameters inclusive of entry methods
and state latencies, to allow operating systems to retrieve the configuration
entries from the device tree and initialize the related power management
drivers, paving the way for common code in the kernel to deal with idle
states and removing the need for static data in current and previous kernel
versions.

Reviewed-by: Sebastian Capella <sebcape@gmail.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 Documentation/devicetree/bindings/arm/cpus.txt     |   8 +
 .../devicetree/bindings/arm/idle-states.txt        | 507 +++++++++++++++++++++
 2 files changed, 515 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/idle-states.txt

diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
index 1fe72a0..a44d4fd 100644
--- a/Documentation/devicetree/bindings/arm/cpus.txt
+++ b/Documentation/devicetree/bindings/arm/cpus.txt
@@ -215,6 +215,12 @@ nodes to be present and contain the properties described below.
 		Value type: <phandle>
 		Definition: Specifies the ACC[2] node associated with this CPU.
 
+	- cpu-idle-states
+		Usage: Optional
+		Value type: <prop-encoded-array>
+		Definition:
+			# List of phandles to idle state nodes supported
+			  by this cpu [3].
 
 Example 1 (dual-cluster big.LITTLE system 32-bit):
 
@@ -411,3 +417,5 @@ cpus {
 --
 [1] arm/msm/qcom,saw2.txt
 [2] arm/msm/qcom,kpss-acc.txt
+[3] ARM Linux kernel documentation - idle states bindings
+    Documentation/devicetree/bindings/arm/idle-states.txt
diff --git a/Documentation/devicetree/bindings/arm/idle-states.txt b/Documentation/devicetree/bindings/arm/idle-states.txt
new file mode 100644
index 0000000..223c425
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/idle-states.txt
@@ -0,0 +1,507 @@
+==========================================
+ARM idle states binding description
+==========================================
+
+==========================================
+1 - Introduction
+==========================================
+
+ARM systems contain HW capable of managing power consumption dynamically,
+where cores can be put in different low-power states (ranging from simple
+wfi to power gating) according to OSPM policies. The CPU states representing
+the range of dynamic idle states that a processor can enter at run-time, can be
+specified through device tree bindings representing the parameters required
+to enter/exit specific idle states on a given processor.
+
+According to the Server Base System Architecture document (SBSA, [3]), the
+power states an ARM CPU can be put into are identified by the following list:
+
+- Running
+- Idle_standby
+- Idle_retention
+- Sleep
+- Off
+
+The power states described in the SBSA document define the basic CPU states on
+top of which ARM platforms implement power management schemes that allow an OS
+PM implementation to put the processor in different idle states (which include
+states listed above; "off" state is not an idle state since it does not have
+wake-up capabilities, hence it is not considered in this document).
+
+Idle state parameters (eg entry latency) are platform specific and need to be
+characterized with bindings that provide the required information to OSPM
+code so that it can build the required tables and use them at runtime.
+
+The device tree binding definition for ARM idle states is the subject of this
+document.
+
+===========================================
+2 - idle-states node
+===========================================
+
+ARM processor idle states are defined within the idle-states node, which is
+a direct child of the cpus node [1] and provides a container where the
+processor idle states, defined as device tree nodes, are listed.
+
+- idle-states node
+
+	Usage: Optional - On ARM systems, is a container of processor idle
+			  states nodes. If the system does not provide CPU
+			  power management capabilities or the processor just
+			  supports idle_standby an idle-states node is not
+			  required.
+
+	Description: idle-states node is a container node, where its
+		     subnodes describe the CPU idle states.
+
+	Node name must be "idle-states".
+
+	The idle-states node's parent node must be the cpus node.
+
+	The idle-states node's child nodes can be:
+
+	- one or more state nodes
+
+	Any other configuration is considered invalid.
+
+	An idle-states node defines the following properties:
+
+	- entry-method
+		Usage: Required
+		Value type: <stringlist>
+		Definition: Describes the method by which a CPU enters the
+			    idle states. This property is required and must be
+			    one of:
+
+			    - "arm,psci"
+			      ARM PSCI firmware interface [2].
+
+			    - "[vendor],[method]"
+			      An implementation dependent string with
+			      format "vendor,method", where vendor is a string
+			      denoting the name of the manufacturer and
+			      method is a string specifying the mechanism
+			      used to enter the idle state.
+
+The nodes describing the idle states (state) can only be defined within the
+idle-states node, any other configuration is considered invalid and therefore
+must be ignored.
+
+===========================================
+3 - state node
+===========================================
+
+A state node represents an idle state description and must be defined as
+follows:
+
+- state node
+
+	Description: must be child of the idle-states node
+
+	The state node name shall follow standard device tree naming
+	rules ([5], 2.2.1 "Node names"), in particular state nodes which
+	are siblings within a single common parent must be given a unique name.
+
+	The idle state entered by executing the wfi instruction (idle_standby
+	SBSA,[3][4]) is considered standard on all ARM platforms and therefore
+	must not be listed.
+
+	A state node defines the following properties:
+
+	- compatible
+		Usage: Required
+		Value type: <stringlist>
+		Definition: Must be "arm,idle-state".
+
+	- logic-state-retained
+		Usage: See definition
+		Value type: <none>
+		Definition: if present logic is retained on state entry,
+			    otherwise it is lost.
+
+	- cache-state-retained
+		Usage: See definition
+		Value type: <none>
+		Definition: if present cache memory is retained on state entry,
+			    otherwise it is lost.
+
+	- entry-method-param
+		Usage: See definition.
+		Value type: <u32>
+		Definition: Depends on the idle-states node entry-method
+			    property value. Refer to the entry-method bindings
+			    for this property value definition.
+
+	- entry-latency-us
+		Usage: Required
+		Value type: <prop-encoded-array>
+		Definition: u32 value representing worst case latency
+			    in microseconds required to enter the idle state.
+
+	- exit-latency-us
+		Usage: Required
+		Value type: <prop-encoded-array>
+		Definition: u32 value representing worst case latency
+			    in microseconds required to exit the idle state.
+
+	- min-residency-us
+		Usage: Required
+		Value type: <prop-encoded-array>
+		Definition: u32 value representing duration in microseconds
+			    after which this state becomes more energy
+			    efficient than any shallower states.
+
+===========================================
+4 - Examples
+===========================================
+
+Example 1 (ARM 64-bit, 16-cpu system):
+
+cpus {
+	#size-cells = <0>;
+	#address-cells = <2>;
+
+	idle-states {
+		entry-method = "arm,psci";
+
+		CPU_RETENTION_0_0: cpu-retention-0-0 {
+			compatible = "arm,idle-state";
+			cache-state-retained;
+			entry-method-param = <0x0010000>;
+			entry-latency-us = <20>;
+			exit-latency-us = <40>;
+			min-residency-us = <30>;
+		};
+
+		CLUSTER_RETENTION_0: cluster-retention-0 {
+			compatible = "arm,idle-state";
+			logic-state-retained;
+			cache-state-retained;
+			entry-method-param = <0x1010000>;
+			entry-latency-us = <50>;
+			exit-latency-us = <100>;
+			min-residency-us = <250>;
+		};
+
+		CPU_SLEEP_0_0: cpu-sleep-0-0 {
+			compatible = "arm,idle-state";
+			entry-method-param = <0x0010000>;
+			entry-latency-us = <250>;
+			exit-latency-us = <500>;
+			min-residency-us = <350>;
+		};
+
+		CLUSTER_SLEEP_0: cluster-sleep-0 {
+			compatible = "arm,idle-state";
+			entry-method-param = <0x1010000>;
+			entry-latency-us = <600>;
+			exit-latency-us = <1100>;
+			min-residency-us = <2700>;
+		};
+
+		CPU_RETENTION_1_0: cpu-retention-1-0 {
+			compatible = "arm,idle-state";
+			cache-state-retained;
+			entry-method-param = <0x0010000>;
+			entry-latency-us = <20>;
+			exit-latency-us = <40>;
+			min-residency-us = <30>;
+		};
+
+		CLUSTER_RETENTION_1: cluster-retention-1 {
+			compatible = "arm,idle-state";
+			logic-state-retained;
+			cache-state-retained;
+			entry-method-param = <0x1010000>;
+			entry-latency-us = <50>;
+			exit-latency-us = <100>;
+			min-residency-us = <270>;
+		};
+
+		CPU_SLEEP_1_0: cpu-sleep-1-0 {
+			compatible = "arm,idle-state";
+			entry-method-param = <0x0010000>;
+			entry-latency-us = <70>;
+			exit-latency-us = <100>;
+			min-residency-us = <100>;
+		};
+
+		CLUSTER_SLEEP_1: cluster-sleep-1 {
+			compatible = "arm,idle-state";
+			entry-method-param = <0x1010000>;
+			entry-latency-us = <500>;
+			exit-latency-us = <1200>;
+			min-residency-us = <3500>;
+		};
+	};
+
+	CPU0: cpu at 0 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a57";
+		reg = <0x0 0x0>;
+		enable-method = "psci";
+		cpu-idle-states = <&CPU_RETENTION_0_0 &CPU_SLEEP_0_0
+				   &CLUSTER_RETENTION_0 &CLUSTER_SLEEP_0>;
+	};
+
+	CPU1: cpu at 1 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a57";
+		reg = <0x0 0x1>;
+		enable-method = "psci";
+		cpu-idle-states = <&CPU_RETENTION_0_0 &CPU_SLEEP_0_0
+				   &CLUSTER_RETENTION_0 &CLUSTER_SLEEP_0>;
+	};
+
+	CPU2: cpu at 100 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a57";
+		reg = <0x0 0x100>;
+		enable-method = "psci";
+		cpu-idle-states = <&CPU_RETENTION_0_0 &CPU_SLEEP_0_0
+				   &CLUSTER_RETENTION_0 &CLUSTER_SLEEP_0>;
+	};
+
+	CPU3: cpu at 101 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a57";
+		reg = <0x0 0x101>;
+		enable-method = "psci";
+		cpu-idle-states = <&CPU_RETENTION_0_0 &CPU_SLEEP_0_0
+				   &CLUSTER_RETENTION_0 &CLUSTER_SLEEP_0>;
+	};
+
+	CPU4: cpu at 10000 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a57";
+		reg = <0x0 0x10000>;
+		enable-method = "psci";
+		cpu-idle-states = <&CPU_RETENTION_0_0 &CPU_SLEEP_0_0
+				   &CLUSTER_RETENTION_0 &CLUSTER_SLEEP_0>;
+	};
+
+	CPU5: cpu at 10001 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a57";
+		reg = <0x0 0x10001>;
+		enable-method = "psci";
+		cpu-idle-states = <&CPU_RETENTION_0_0 &CPU_SLEEP_0_0
+				   &CLUSTER_RETENTION_0 &CLUSTER_SLEEP_0>;
+	};
+
+	CPU6: cpu at 10100 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a57";
+		reg = <0x0 0x10100>;
+		enable-method = "psci";
+		cpu-idle-states = <&CPU_RETENTION_0_0 &CPU_SLEEP_0_0
+				   &CLUSTER_RETENTION_0 &CLUSTER_SLEEP_0>;
+	};
+
+	CPU7: cpu at 10101 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a57";
+		reg = <0x0 0x10101>;
+		enable-method = "psci";
+		cpu-idle-states = <&CPU_RETENTION_0_0 &CPU_SLEEP_0_0
+				   &CLUSTER_RETENTION_0 &CLUSTER_SLEEP_0>;
+	};
+
+	CPU8: cpu at 100000000 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a53";
+		reg = <0x1 0x0>;
+		enable-method = "psci";
+		cpu-idle-states = <&CPU_RETENTION_1_0 &CPU_SLEEP_1_0
+				   &CLUSTER_RETENTION_1 &CLUSTER_SLEEP_1>;
+	};
+
+	CPU9: cpu at 100000001 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a53";
+		reg = <0x1 0x1>;
+		enable-method = "psci";
+		cpu-idle-states = <&CPU_RETENTION_1_0 &CPU_SLEEP_1_0
+				   &CLUSTER_RETENTION_1 &CLUSTER_SLEEP_1>;
+	};
+
+	CPU10: cpu at 100000100 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a53";
+		reg = <0x1 0x100>;
+		enable-method = "psci";
+		cpu-idle-states = <&CPU_RETENTION_1_0 &CPU_SLEEP_1_0
+				   &CLUSTER_RETENTION_1 &CLUSTER_SLEEP_1>;
+	};
+
+	CPU11: cpu at 100000101 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a53";
+		reg = <0x1 0x101>;
+		enable-method = "psci";
+		cpu-idle-states = <&CPU_RETENTION_1_0 &CPU_SLEEP_1_0
+				   &CLUSTER_RETENTION_1 &CLUSTER_SLEEP_1>;
+	};
+
+	CPU12: cpu at 100010000 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a53";
+		reg = <0x1 0x10000>;
+		enable-method = "psci";
+		cpu-idle-states = <&CPU_RETENTION_1_0 &CPU_SLEEP_1_0
+				   &CLUSTER_RETENTION_1 &CLUSTER_SLEEP_1>;
+	};
+
+	CPU13: cpu at 100010001 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a53";
+		reg = <0x1 0x10001>;
+		enable-method = "psci";
+		cpu-idle-states = <&CPU_RETENTION_1_0 &CPU_SLEEP_1_0
+				   &CLUSTER_RETENTION_1 &CLUSTER_SLEEP_1>;
+	};
+
+	CPU14: cpu at 100010100 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a53";
+		reg = <0x1 0x10100>;
+		enable-method = "psci";
+		cpu-idle-states = <&CPU_RETENTION_1_0 &CPU_SLEEP_1_0
+				   &CLUSTER_RETENTION_1 &CLUSTER_SLEEP_1>;
+	};
+
+	CPU15: cpu at 100010101 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a53";
+		reg = <0x1 0x10101>;
+		enable-method = "psci";
+		cpu-idle-states = <&CPU_RETENTION_1_0 &CPU_SLEEP_1_0
+				   &CLUSTER_RETENTION_1 &CLUSTER_SLEEP_1>;
+	};
+};
+
+Example 2 (ARM 32-bit, 8-cpu system, two clusters):
+
+cpus {
+	#size-cells = <0>;
+	#address-cells = <1>;
+
+	idle-states {
+		entry-method = "arm,psci";
+
+		CPU_SLEEP_0_0: cpu-sleep-0-0 {
+			compatible = "arm,idle-state";
+			entry-method-param = <0x0010000>;
+			entry-latency-us = <400>;
+			exit-latency-us = <500>;
+			min-residency-us = <300>;
+		};
+
+		CLUSTER_SLEEP_0: cluster-sleep-0 {
+			compatible = "arm,idle-state";
+			entry-method-param = <0x1010000>;
+			entry-latency-us = <1000>;
+			exit-latency-us = <1500>;
+			min-residency-us = <1500>;
+		};
+
+		CPU_SLEEP_1_0: cpu-sleep-1-0 {
+			compatible = "arm,idle-state";
+			entry-method-param = <0x0010000>;
+			entry-latency-us = <300>;
+			exit-latency-us = <500>;
+			min-residency-us = <500>;
+		};
+
+		CLUSTER_SLEEP_1: cluster-sleep-1 {
+			compatible = "arm,idle-state";
+			entry-method-param = <0x1010000>;
+			entry-latency-us = <800>;
+			exit-latency-us = <2000>;
+			min-residency-us = <6500>;
+		};
+	};
+
+	CPU0: cpu at 0 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a15";
+		reg = <0x0>;
+		enable-method = "psci";
+		cpu-idle-states = <&CPU_SLEEP_0_0 &CLUSTER_SLEEP_0>;
+	};
+
+	CPU1: cpu at 1 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a15";
+		reg = <0x1>;
+		enable-method = "psci";
+		cpu-idle-states = <&CPU_SLEEP_0_0 &CLUSTER_SLEEP_0>;
+	};
+
+	CPU2: cpu at 2 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a15";
+		reg = <0x2>;
+		enable-method = "psci";
+		cpu-idle-states = <&CPU_SLEEP_0_0 &CLUSTER_SLEEP_0>;
+	};
+
+	CPU3: cpu at 3 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a15";
+		reg = <0x3>;
+		enable-method = "psci";
+		cpu-idle-states = <&CPU_SLEEP_0_0 &CLUSTER_SLEEP_0>;
+	};
+
+	CPU4: cpu at 100 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a7";
+		reg = <0x100>;
+		enable-method = "psci";
+		cpu-idle-states = <&CPU_SLEEP_1_0 &CLUSTER_SLEEP_1>;
+	};
+
+	CPU5: cpu at 101 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a7";
+		reg = <0x101>;
+		enable-method = "psci";
+		cpu-idle-states = <&CPU_SLEEP_1_0 &CLUSTER_SLEEP_1>;
+	};
+
+	CPU6: cpu at 102 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a7";
+		reg = <0x102>;
+		enable-method = "psci";
+		cpu-idle-states = <&CPU_SLEEP_1_0 &CLUSTER_SLEEP_1>;
+	};
+
+	CPU7: cpu at 103 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a7";
+		reg = <0x103>;
+		enable-method = "psci";
+		cpu-idle-states = <&CPU_SLEEP_1_0 &CLUSTER_SLEEP_1>;
+	};
+};
+
+===========================================
+4 - References
+===========================================
+
+[1] ARM Linux Kernel documentation - CPUs bindings
+    Documentation/devicetree/bindings/arm/cpus.txt
+
+[2] ARM Linux Kernel documentation - PSCI bindings
+    Documentation/devicetree/bindings/arm/psci.txt
+
+[3] ARM Server Base System Architecture (SBSA)
+    http://infocenter.arm.com/help/index.jsp
+
+[4] ARM Architecture Reference Manuals
+    http://infocenter.arm.com/help/index.jsp
+
+[5] ePAPR standard
+    https://www.power.org/documentation/epapr-version-1-1/
-- 
1.8.4
