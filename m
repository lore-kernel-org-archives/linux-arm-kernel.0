From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 20 Jan 2014 17:47:59 +0000
Subject: [PATCH RFC v2 2/2] Documentation: arm: define DT C-states bindings
In-Reply-To: <1390240079-6495-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1390240079-6495-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1390240079-6495-3-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM based platforms implement a variety of power management schemes that
allow processors to enter at run-time low-power states, aka C-states
in ACPI jargon. The parameters defining these C-states vary on a per-platform
basis forcing the OS to hardcode the state parameters in platform
specific static tables whose size grows as the number of platforms supported
in the kernel increases and hampers device drivers standardization.

Therefore, this patch aims at standardizing C-state device tree bindings for
ARM platforms. Bindings define C-state parameters inclusive of entry methods
and state latencies, to allow operating systems to retrieve the
configuration entries from the device tree and initialize the related
power management drivers, paving the way for common code in the kernel
to deal with power states and removing the need for static data in current
and previous kernel versions.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 Documentation/devicetree/bindings/arm/c-states.txt | 774 +++++++++++++++++++++
 Documentation/devicetree/bindings/arm/cpus.txt     |  10 +
 2 files changed, 784 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/c-states.txt

diff --git a/Documentation/devicetree/bindings/arm/c-states.txt b/Documentation/devicetree/bindings/arm/c-states.txt
new file mode 100644
index 0000000..0b5617b
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/c-states.txt
@@ -0,0 +1,774 @@
+==========================================
+ARM C-states binding description
+==========================================
+
+==========================================
+1 - Introduction
+==========================================
+
+ARM systems contain HW capable of managing power consumption dynamically,
+where cores can be put in different low-power states (ranging from simple
+wfi to power gating) according to OSPM policies. Borrowing concepts
+from the ACPI specification[1], the CPU states representing the range of
+dynamic states that a processor can enter at run-time, aka C-state, can be
+specified through device tree bindings representing the parameters required to
+enter/exit specific C-states on a given processor.
+
+The state an ARM CPU can be put into is loosely identified by one of the
+following operating modes:
+
+- Running:
+	 # Processor core is executing instructions
+
+- Wait for Interrupt:
+	# An ARM processor enters wait for interrupt (WFI) low power
+	  state by executing a wfi instruction. When a processor enters
+	  wfi state it disables most of the clocks while keeping the processor
+	  powered up. This state is standard on all ARM processors and it is
+	  defined as C1 in the remainder of this document.
+
+- Dormant:
+	# Dormant mode is entered by executing wfi instructions and by sending
+	  platform specific commands to the platform power controller (coupled
+	  with processor specific SW/HW control sequences).
+	  In dormant mode, most of the processor control and debug logic is
+	  powered up but cache RAM can be put in retention state, providing
+	  additional power savings.
+
+- Sleep:
+	# Sleep mode is entered by executing the wfi instruction and by sending
+	  platform specific commands to the platform power controller (coupled
+	  with processor specific SW/HW control sequences). In sleep mode, a
+	  processor and its caches are shutdown, the entire processor state is
+	  lost.
+
+Building on top of the previous processor modes, ARM platforms implement power
+management schemes that allow an OS PM implementation to put the processor in
+different CPU states (C-states). C-states parameters (eg latency) are
+platform specific and need to be characterized with bindings that provide the
+required information to OSPM code so that it can build the required tables and
+use them at runtime.
+
+The device tree binding definition for ARM C-states is the subject of this
+document.
+
+===========================================
+2 - cpu-power-states node
+===========================================
+
+ARM processor C-states are defined within the cpu-power-states node, which is
+a direct child of the cpus node and provides a container where the processor
+states, defined as device tree nodes, are listed.
+
+- cpu-power-states node
+
+	Usage: Optional - On ARM systems, is a container of processor C-state
+			  nodes. If the system does not provide CPU power
+			  management capabilities or the processor just
+			  supports WFI (C1 state) a cpu-power-states node is
+			  not required.
+
+	Description: cpu-power-states node is a container node, where its
+		     subnodes describe the CPU low-power C-states.
+
+	Node name must be "cpu-power-states".
+
+	The cpu-power-states node's parent node must be cpus node.
+
+	The cpu-power-states node's child nodes can be:
+
+	- one or more state nodes
+
+	Any other configuration is considered invalid.
+
+The nodes describing the C-states (state) can only be defined within the
+cpu-power-states node.
+
+Any other configuration is consider invalid and therefore must be ignored.
+
+===========================================
+2 - state node
+===========================================
+
+A state node represents a C-state description and must be defined as follows:
+
+- state node
+
+	Description: must be child of either the cpu-power-states node or
+		     a state node.
+
+	The state node name shall be "stateN", where N = {0, 1, ...} is
+	the node number; state nodes which are siblings within a single common
+	parent node must be given a unique and sequential N value, starting
+	from 0.
+
+	A state node can contain state child nodes. Child nodes inherit
+	properties from the parent state nodes that work as state
+	properties aggregators (ie contain properties valid on all state
+	nodes children).
+
+	A state node defines the following properties (either explicitly
+	or by inheriting them from a parent node):
+
+	- compatible
+		Usage: Required
+		Value type: <stringlist>
+		Definition: Must be "arm,cpu-power-state".
+
+	- index
+		Usage: Required
+		Value type: <u32>
+		Definition: It represents C-state index, starting from 2 (index
+			    0 represents the processor state "running" and
+			    index 1 represents processor mode "WFI"; indexes 0
+			    and 1 are standard ARM states that need not be
+			    described).
+
+	- power-domain
+		Usage: Required
+		Value type: <prop-encoded-array>
+		Definition: List of phandle and power domain specifiers
+			    as defined by bindings of power controller
+			    specified by the phandle [3]. It represents the
+			    power domains associated with the C-state. The
+			    power domains list can be used by OSPM to
+			    retrieve the devices belonging to the power
+			    domains and carry out corresponding actions to
+			    preserve functionality across power cycles
+			    (ie context save/restore, cache flushing).
+
+	- entry-method
+		Usage: Required
+		Value type: <stringlist>
+		Definition: Describes the method by which a CPU enters the
+			    C-state. This property is required and must be one
+			    of:
+
+			    - "psci"
+			      ARM Standard firmware interface
+
+			    - "[vendor],[method]"
+			      An implementation dependent string with
+			      format "vendor,method", where vendor is a string
+			      denoting the name of the manufacturer and
+			      method is a string specifying the mechanism
+			      used to enter the C-state.
+
+	- psci-power-state
+		Usage: Required if entry-method property value is set to
+		       "psci".
+		Value type: <u32>
+		Definition: power_state parameter to pass to the PSCI
+			    suspend call to enter the C-state.
+
+	- latency
+		Usage: Required
+		Value type: <prop-encoded-array>
+		Definition: List of u32 values representing worst case latency
+			    in microseconds required to enter and exit the
+			    C-state, one value per OPP [2]. The list should
+			    be specified in the same order as the operating
+			    points property list of the cpu this state is
+			    valid on.
+			    If no OPP bindings are present, the latency value
+			    is associated with the current OPP of CPUs in the
+			    system.
+
+	- min-residency
+		Usage: Required
+		Value type: <prop-encoded-array>
+		Definition: List of u32 values representing time in
+			    microseconds required for the CPU to be in
+			    the C-state to make up for the dynamic power
+			    consumed to enter/exit the C-state in order to
+			    break even in terms of power consumption compared
+			    to C1 state (wfi), one value per-OPP [2].
+			    This parameter depends on the operating conditions
+			    (HW state) and must assume worst case scenario.
+			    The list should be specified in the same order as
+			    the operating points property list of the cpu this
+			    state is valid on.
+			    If no OPP bindings are present the min-residency
+			    value is associated with the current OPP of CPUs
+			    in the system.
+
+===========================================
+3 - Examples
+===========================================
+
+Example 1 (ARM 64-bit, 16-cpu system, two clusters of clusters):
+
+pd_clusters: power-domain-clusters at 80002000 {
+	compatible = "arm,power-controller";
+	reg = <0x0 0x80002000 0x0 0x1000>;
+	#power-domain-cells = <1>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	pd_cores: power-domain-cores at 80000000 {
+		compatible = "arm,power-controller";
+		reg = <0x0 0x80000000 0x0 0x1000>;
+		#power-domain-cells = <1>;
+	};
+};
+
+cpus {
+	#size-cells = <0>;
+	#address-cells = <2>;
+
+	cpu-power-states {
+
+		state0 {
+			compatible = "arm,cpu-power-state";
+			index = <2>;
+			entry-method = "psci";
+			psci-power-state = <0x1010000>;
+			latency = <400>;
+			min-residency = <300>;
+			STATE0_0: state0 {
+				compatible = "arm,cpu-power-state";
+				power-domain = <&pd_cores 0>;
+			};
+			STATE0_1: state1 {
+				compatible = "arm,cpu-power-state";
+				power-domain = <&pd_cores 1>;
+			};
+			STATE0_2: state2 {
+				compatible = "arm,cpu-power-state";
+				power-domain = <&pd_cores 2>;
+			};
+			STATE0_3: state3 {
+				compatible = "arm,cpu-power-state";
+				power-domain = <&pd_cores 3>;
+			};
+			STATE0_4: state4 {
+				compatible = "arm,cpu-power-state";
+				power-domain = <&pd_cores 4>;
+			};
+			STATE0_5: state5 {
+				compatible = "arm,cpu-power-state";
+				power-domain = <&pd_cores 5>;
+			};
+			STATE0_6: state6 {
+				compatible = "arm,cpu-power-state";
+				power-domain = <&pd_cores 6>;
+			};
+			STATE0_7: state7 {
+				compatible = "arm,cpu-power-state";
+				power-domain = <&pd_cores 7>;
+			};
+		};
+
+		state1 {
+			compatible = "arm,cpu-power-state";
+			index = <2>;
+			entry-method = "psci";
+			psci-power-state = <0x1010000>;
+			latency = <400>;
+			min-residency = <500>;
+			STATE1_0: state0 {
+				compatible = "arm,cpu-power-state";
+				power-domain = <&pd_cores 8>;
+			};
+			STATE1_1: state1 {
+				compatible = "arm,cpu-power-state";
+				power-domain = <&pd_cores 9>;
+			};
+			STATE1_2: state2 {
+				compatible = "arm,cpu-power-state";
+				power-domain = <&pd_cores 10>;
+			};
+			STATE1_3: state3 {
+				compatible = "arm,cpu-power-state";
+				power-domain = <&pd_cores 11>;
+			};
+			STATE1_4: state4 {
+				compatible = "arm,cpu-power-state";
+				power-domain = <&pd_cores 12>;
+			};
+			STATE1_5: state5 {
+				compatible = "arm,cpu-power-state";
+				power-domain = <&pd_cores 13>;
+			};
+			STATE1_6: state6 {
+				compatible = "arm,cpu-power-state";
+				power-domain = <&pd_cores 14>;
+			};
+			STATE1_7: state7 {
+				compatible = "arm,cpu-power-state";
+				power-domain = <&pd_cores 15>;
+			};
+		};
+
+		STATE2: state2 {
+			compatible = "arm,cpu-power-state";
+			index = <3>;
+			entry-method = "psci";
+			psci-power-state = <0x3010000>;
+			latency = <1000>;
+			min-residency = <2500>;
+			power-domain = <&pd_clusters 0>;
+		};
+
+		STATE3: state3 {
+			compatible = "arm,cpu-power-state";
+			index = <3>;
+			entry-method = "psci";
+			psci-power-state = <0x3010000>;
+			latency = <4500>;
+			min-residency = <6500>;
+			power-domain = <&pd_clusters 1>;
+		};
+	};
+
+	CPU0: cpu at 0 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a57";
+		reg = <0x0 0x0>;
+		enable-method = "psci";
+		next-level-cache = <&L1_0>;
+		cpu-power-states = <&STATE0_0 &STATE2>;
+		L1_0: l1-cache {
+			compatible = "arm,arch-cache";
+			next-level-cache = <&L2_0>;
+			power-domain = <&pd_cores 0>;
+		};
+		L2_0: l2-cache {
+			compatible = "arm,arch-cache";
+			power-domain = <&pd_clusters 0>;
+		};
+	};
+
+	CPU1: cpu at 1 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a57";
+		reg = <0x0 0x1>;
+		enable-method = "psci";
+		next-level-cache = <&L1_1>;
+		cpu-power-states = <&STATE0_1 &STATE2>;
+		L1_1: l1-cache {
+			compatible = "arm,arch-cache";
+			next-level-cache = <&L2_0>;
+			power-domain = <&pd_cores 1>;
+		};
+	};
+
+	CPU2: cpu at 100 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a57";
+		reg = <0x0 0x100>;
+		enable-method = "psci";
+		next-level-cache = <&L1_2>;
+		cpu-power-states = <&STATE0_2 &STATE2>;
+		L1_2: l1-cache {
+			compatible = "arm,arch-cache";
+			next-level-cache = <&L2_0>;
+			power-domain = <&pd_cores 2>;
+		};
+	};
+
+	CPU3: cpu at 101 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a57";
+		reg = <0x0 0x101>;
+		enable-method = "psci";
+		next-level-cache = <&L1_3>;
+		cpu-power-states = <&STATE0_3 &STATE2>;
+		L1_3: l1-cache {
+			compatible = "arm,arch-cache";
+			next-level-cache = <&L2_0>;
+			power-domain = <&pd_cores 3>;
+		};
+	};
+
+	CPU4: cpu at 10000 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a57";
+		reg = <0x0 0x10000>;
+		enable-method = "psci";
+		next-level-cache = <&L1_4>;
+		cpu-power-states = <&STATE0_4 &STATE2>;
+		L1_4: l1-cache {
+			compatible = "arm,arch-cache";
+			next-level-cache = <&L2_0>;
+			power-domain = <&pd_cores 4>;
+		};
+	};
+
+	CPU5: cpu at 10001 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a57";
+		reg = <0x0 0x10001>;
+		enable-method = "psci";
+		next-level-cache = <&L1_5>;
+		cpu-power-states = <&STATE0_5 &STATE2>;
+		L1_5: l1-cache {
+			compatible = "arm,arch-cache";
+			next-level-cache = <&L2_0>;
+			power-domain = <&pd_cores 5>;
+		};
+	};
+
+	CPU6: cpu at 10100 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a57";
+		reg = <0x0 0x10100>;
+		enable-method = "psci";
+		next-level-cache = <&L1_6>;
+		cpu-power-states = <&STATE0_6 &STATE2>;
+		L1_6: l1-cache {
+			compatible = "arm,arch-cache";
+			next-level-cache = <&L2_0>;
+			power-domain = <&pd_cores 6>;
+		};
+	};
+
+	CPU7: cpu at 10101 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a57";
+		reg = <0x0 0x10101>;
+		enable-method = "psci";
+		next-level-cache = <&L1_7>;
+		cpu-power-states = <&STATE0_7 &STATE2>;
+		L1_7: l1-cache {
+			compatible = "arm,arch-cache";
+			next-level-cache = <&L2_0>;
+			power-domain = <&pd_cores 7>;
+		};
+	};
+
+	CPU8: cpu at 100000000 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a53";
+		reg = <0x1 0x0>;
+		enable-method = "psci";
+		next-level-cache = <&L1_8>;
+		cpu-power-states = <&STATE1_0 &STATE3>;
+		L1_8: l1-cache {
+			compatible = "arm,arch-cache";
+			next-level-cache = <&L2_1>;
+			power-domain = <&pd_cores 8>;
+		};
+		L2_1: l2-cache {
+			compatible = "arm,arch-cache";
+			power-domain = <&pd_clusters 1>;
+		};
+	};
+
+	CPU9: cpu at 100000001 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a53";
+		reg = <0x1 0x1>;
+		enable-method = "psci";
+		next-level-cache = <&L1_9>;
+		cpu-power-states = <&STATE1_1 &STATE3>;
+		L1_9: l1-cache {
+			compatible = "arm,arch-cache";
+			next-level-cache = <&L2_1>;
+			power-domain = <&pd_cores 9>;
+		};
+	};
+
+	CPU10: cpu at 100000100 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a53";
+		reg = <0x1 0x100>;
+		enable-method = "psci";
+		next-level-cache = <&L1_10>;
+		cpu-power-states = <&STATE1_2 &STATE3>;
+		L1_10: l1-cache {
+			compatible = "arm,arch-cache";
+			next-level-cache = <&L2_1>;
+			power-domain = <&pd_cores 10>;
+		};
+	};
+
+	CPU11: cpu at 100000101 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a53";
+		reg = <0x1 0x101>;
+		enable-method = "psci";
+		next-level-cache = <&L1_11>;
+		cpu-power-states = <&STATE1_3 &STATE3>;
+		L1_11: l1-cache {
+			compatible = "arm,arch-cache";
+			next-level-cache = <&L2_1>;
+			power-domain = <&pd_cores 11>;
+		};
+	};
+
+	CPU12: cpu at 100010000 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a53";
+		reg = <0x1 0x10000>;
+		enable-method = "psci";
+		next-level-cache = <&L1_12>;
+		cpu-power-states = <&STATE1_4 &STATE3>;
+		L1_12: l1-cache {
+			compatible = "arm,arch-cache";
+			next-level-cache = <&L2_1>;
+			power-domain = <&pd_cores 12>;
+		};
+	};
+
+	CPU13: cpu at 100010001 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a53";
+		reg = <0x1 0x10001>;
+		enable-method = "psci";
+		next-level-cache = <&L1_13>;
+		cpu-power-states = <&STATE1_5 &STATE3>;
+		L1_13: l1-cache {
+			compatible = "arm,arch-cache";
+			next-level-cache = <&L2_1>;
+			power-domain = <&pd_cores 13>;
+		};
+	};
+
+	CPU14: cpu at 100010100 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a53";
+		reg = <0x1 0x10100>;
+		enable-method = "psci";
+		next-level-cache = <&L1_14>;
+		cpu-power-states = <&STATE1_6 &STATE3>;
+		L1_14: l1-cache {
+			compatible = "arm,arch-cache";
+			next-level-cache = <&L2_1>;
+			power-domain = <&pd_cores 14>;
+		};
+	};
+
+	CPU15: cpu at 100010101 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a53";
+		reg = <0x1 0x10101>;
+		enable-method = "psci";
+		next-level-cache = <&L1_15>;
+		cpu-power-states = <&STATE1_7 &STATE3>;
+		L1_15: l1-cache {
+			compatible = "arm,arch-cache";
+			next-level-cache = <&L2_1>;
+			power-domain = <&pd_cores 15>;
+		};
+	};
+};
+
+Example 2 (ARM 32-bit, 8-cpu system, two clusters):
+
+pd_clusters: power-domain-clusters at 80002000 {
+	compatible = "arm,power-controller";
+	reg = <0x80002000 0x1000>;
+	#power-domain-cells = <1>;
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	pd_cores: power-domain-cores at 80000000 {
+		compatible = "arm,power-controller";
+		reg = <0x80000000 0x1000>;
+		#power-domain-cells = <1>;
+	};
+};
+
+cpus {
+	#size-cells = <0>;
+	#address-cells = <1>;
+
+	cpu-power-states {
+
+		state0 {
+			compatible = "arm,cpu-power-state";
+			index = <2>;
+			entry-method = "psci";
+			psci-power-state = <0x1010000>;
+			latency = <400>;
+			min-residency = <300>;
+			STATE0_0: state0 {
+				compatible = "arm,cpu-power-state";
+				power-domain = <&pd_cores 0>;
+			};
+			STATE0_1: state1 {
+				compatible = "arm,cpu-power-state";
+				power-domain = <&pd_cores 1>;
+			};
+			STATE0_2: state2 {
+				compatible = "arm,cpu-power-state";
+				power-domain = <&pd_cores 2>;
+			};
+			STATE0_3: state3 {
+				compatible = "arm,cpu-power-state";
+				power-domain = <&pd_cores 3>;
+			};
+		};
+
+		state1 {
+			compatible = "arm,cpu-power-state";
+			index = <2>;
+			entry-method = "psci";
+			psci-power-state = <0x1010000>;
+			latency = <400>;
+			min-residency = <500>;
+			STATE1_0: state0 {
+				compatible = "arm,cpu-power-state";
+				power-domain = <&pd_cores 4>;
+			};
+			STATE1_1: state1 {
+				compatible = "arm,cpu-power-state";
+				power-domain = <&pd_cores 5>;
+			};
+			STATE1_2: state2 {
+				compatible = "arm,cpu-power-state";
+				power-domain = <&pd_cores 6>;
+			};
+			STATE1_3: state3 {
+				compatible = "arm,cpu-power-state";
+				power-domain = <&pd_cores 7>;
+			};
+		};
+
+		STATE2: state2 {
+			compatible = "arm,cpu-power-state";
+			index = <3>;
+			entry-method = "psci";
+			psci-power-state = <0x3010000>;
+			latency = <1000>;
+			min-residency = <1500>;
+			power-domain = <&pd_clusters 0>;
+		};
+
+		STATE3: state3 {
+			compatible = "arm,cpu-power-state";
+			index = <3>;
+			entry-method = "psci";
+			psci-power-state = <0x3010000>;
+			latency = <4500>;
+			min-residency = <6500>;
+			power-domain = <&pd_clusters 1>;
+		};
+	};
+
+	CPU0: cpu at 0 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a15";
+		reg = <0x0>;
+		next-level-cache = <&L1_0>;
+		cpu-power-states = <&STATE0_0 &STATE2>;
+		L1_0: l1-cache {
+			compatible = "arm,arch-cache";
+			next-level-cache = <&L2_0>;
+			power-domain = <&pd_cores 0>;
+		};
+		L2_0: l2-cache {
+			compatible = "arm,arch-cache";
+			power-domain = <&pd_clusters 0>;
+		};
+	};
+
+	CPU1: cpu at 1 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a15";
+		reg = <0x1>;
+		next-level-cache = <&L1_1>;
+		cpu-power-states = <&STATE0_1 &STATE2>;
+		L1_1: l1-cache {
+			compatible = "arm,arch-cache";
+			next-level-cache = <&L2_0>;
+			power-domain = <&pd_cores 1>;
+		};
+	};
+
+	CPU2: cpu at 2 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a15";
+		reg = <0x2>;
+		next-level-cache = <&L1_2>;
+		cpu-power-states = <&STATE0_2 &STATE2>;
+		L1_2: l1-cache {
+			compatible = "arm,arch-cache";
+			next-level-cache = <&L2_0>;
+			power-domain = <&pd_cores 2>;
+		};
+	};
+
+	CPU3: cpu at 3 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a15";
+		reg = <0x3>;
+		next-level-cache = <&L1_3>;
+		cpu-power-states = <&STATE0_3 &STATE2>;
+		L1_3: l1-cache {
+			compatible = "arm,arch-cache";
+			next-level-cache = <&L2_0>;
+			power-domain = <&pd_cores 3>;
+		};
+	};
+
+	CPU4: cpu at 100 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a7";
+		reg = <0x100>;
+		next-level-cache = <&L1_4>;
+		cpu-power-states = <&STATE1_0 &STATE3>;
+		L1_4: l1-cache {
+			compatible = "arm,arch-cache";
+			next-level-cache = <&L2_1>;
+			power-domain = <&pd_cores 4>;
+		};
+		L2_1: l2-cache {
+			compatible = "arm,arch-cache";
+			power-domain = <&pd_clusters 1>;
+		};
+	};
+
+	CPU5: cpu at 101 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a7";
+		reg = <0x101>;
+		next-level-cache = <&L1_5>;
+		cpu-power-states = <&STATE1_1 &STATE3>;
+		L1_5: l1-cache {
+			compatible = "arm,arch-cache";
+			next-level-cache = <&L2_1>;
+			power-domain = <&pd_cores 5>;
+		};
+	};
+
+	CPU6: cpu at 102 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a7";
+		reg = <0x102>;
+		next-level-cache = <&L1_6>;
+		cpu-power-states = <&STATE1_2 &STATE3>;
+		L1_6: l1-cache {
+			compatible = "arm,arch-cache";
+			next-level-cache = <&L2_1>;
+			power-domain = <&pd_cores 6>;
+		};
+	};
+
+	CPU7: cpu at 103 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a7";
+		reg = <0x103>;
+		next-level-cache = <&L1_7>;
+		cpu-power-states = <&STATE1_3 &STATE3>;
+		L1_7: l1-cache {
+			compatible = "arm,arch-cache";
+			next-level-cache = <&L2_1>;
+			power-domain = <&pd_cores 7>;
+		};
+	};
+};
+
+===========================================
+4 - References
+===========================================
+
+[1] ACPI v5.0 specification
+    http://www.acpi.info/spec50.htm
+
+[2] ARM Linux kernel documentation - OPP bindings
+    Documentation/devicetree/bindings/power/opp.txt
+
+[3] ARM Linux Kernel documentation - power domain bindings
+    Documentation/devicetree/bindings/power/power_domain.txt
diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
index 9130435..a3c9193 100644
--- a/Documentation/devicetree/bindings/arm/cpus.txt
+++ b/Documentation/devicetree/bindings/arm/cpus.txt
@@ -191,6 +191,13 @@ nodes to be present and contain the properties described below.
 			  property identifying a 64-bit zero-initialised
 			  memory location.
 
+	- cpu-power-states
+		Usage: Optional
+		Value type: <prop-encoded-array>
+		Definition:
+			# List of phandles to cpu power state nodes supported
+			  by this cpu [1].
+
 Example 1 (dual-cluster big.LITTLE system 32-bit):
 
 	cpus {
@@ -382,3 +389,6 @@ cpus {
 		cpu-release-addr = <0 0x20000000>;
 	};
 };
+
+[1] ARM Linux kernel documentation - C-state bindings
+    Documentation/devicetree/bindings/arm/c-states.txt
-- 
1.8.4
