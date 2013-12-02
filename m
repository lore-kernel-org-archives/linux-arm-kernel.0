From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon,  2 Dec 2013 16:20:05 +0000
Subject: [PATCH RFC 2/2] Documentation: arm: define DT C-states bindings
In-Reply-To: <1386001205-11978-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1386001205-11978-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1386001205-11978-3-git-send-email-lorenzo.pieralisi@arm.com>
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
 Documentation/devicetree/bindings/arm/c-states.txt | 830 +++++++++++++++++++++
 1 file changed, 830 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/c-states.txt

diff --git a/Documentation/devicetree/bindings/arm/c-states.txt b/Documentation/devicetree/bindings/arm/c-states.txt
new file mode 100644
index 0000000..f568417
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/c-states.txt
@@ -0,0 +1,830 @@
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
+	The cpu-power-states node must contain the following properties:
+
+	- compatible
+		Value type: <stringlist>
+		Usage: Required
+		Definition: Must be "arm,cpu-power-states".
+
+	- #address-cells
+		Usage: Required
+		Value type: <u32>
+		Definition: must be set to 1.
+
+	- #size-cells
+		Usage: Required
+		Value type: <u32>
+		Definition: must be set to 0.
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
+	Description: must be child of the cpu-power-states node.
+
+	The state node name must be "state", with unit address provided by the
+	"reg" property following standard DT requirements[4].
+
+	A state node defines the following properties:
+
+	- reg
+		Usage: Required
+		Value type: <u32>
+		Definition: Standard device tree property [4] used for
+			    enumeration purposes.
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
+	- entry-method
+		Value type: <stringlist>
+		Usage: Required
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
+		Value type: <u32>
+		Definition: Worst case latency in microseconds required to
+			    enter and exit the C-state.
+
+	- min-residency
+		Usage: Required
+		Value type: <u32>
+		Definition: Time in microseconds required for the CPU to be in
+			    the C-state to make up for the dynamic power
+			    consumed to enter/exit the C-state in order to
+			    break even in terms of power consumption compared
+			    to C1 state (wfi).
+			    This parameter depends on the operating conditions
+			    (operating point, cache state) and must assume
+			    worst case scenario.
+
+	- cpus
+		Usage: Optional
+		Value type: <phandle>
+		Definition: If defined, the phandle points to a node in the
+			    cpu-map[2] representing all CPUs on which C-state
+			    is valid. If not present or system is UP, the
+			    C-state has to be considered valid for all CPUs in
+			    the system.
+
+	- affinity
+		Usage: Optional
+		Value type: <phandle>
+		Definition: If defined, phandle points to a node in the
+			    cpu-map[2] that represents all CPUs that are
+			    affected (ie share) by the C-state and have to
+			    be coordinated on C-state entry/exit. If not
+			    present or system is UP, the C-state is local to
+			    a CPU and need no coordination (ie it is a CPU
+			    state, that does not require coordination with
+			    other CPUs). If present, the affinity property
+			    must contain a phandle to a cpu-map node that
+			    represents a subset, possibly inclusive of the
+			    CPUs described through the cpus property.
+
+	- power-depth
+		Usage: Required
+		Value type: <u32>
+		Definition: Integer value, starting from 2 (value 0 meaning
+			    running and value 1 representing power depth of
+			    wfi (C1)), that defines the level of depth of a
+			    power state.
+			    The system denotes power states with different
+			    depths, an increasing value meaning less power
+			    consumption and might involve powering down more
+			    components.  Devices that are affected by
+			    C-states entry must define the maximum power
+			    depth supported in their respective device tree
+			    bindings so that OSPM can take decision on how
+			    to handle the device in question when the C-state
+			    is entered. All devices (per-CPU or external) with
+			    a power depth lower than the one defined in the
+			    C-state entry stop operating when the C-state
+			    is entered and action is required by OSPM to
+			    guarantee their logic and memory content is saved
+			    restored to guarantee proper functioning.
+
+	- cache-level-lost:
+		Usage: Required if "entry-method" differs from "psci".
+		Value type: <u32>
+		Definition: An integer value representing the uppermost cache
+			    level (inclusive) that is lost upon state entry.
+			    This property requires the definition of cache
+			    nodes as specified in [3]. Cache levels that are
+			    shared between processors, according to [3], should
+			    coordinate cache cleaning and invalidation to
+			    maximize performance (ie a shared cache level
+			    must be cleaned only if all CPUs sharing the
+			    cache entered the state). If missing, cache
+			    state has to be considered retained.
+
+	- processor-state-retained:
+		Usage: See definition
+		Value type: <none>
+		Definition: if present CPU processor logic is retained on
+			    power down, otherwise it is lost.
+
+
+===========================================
+3 - Examples
+===========================================
+
+Example 1 (ARM 64-bit, 16-cpu system, two clusters of clusters):
+
+cpus {
+	#size-cells = <0>;
+	#address-cells = <2>;
+
+	cpu-map {
+		CLUSTER0: cluster0 {
+			CLUSTER2: cluster0 {
+				core0 {
+					thread0 {
+						cpu = <&CPU0>;
+					};
+					thread1 {
+						cpu = <&CPU1>;
+					};
+				};
+
+				core1 {
+					thread0 {
+						cpu = <&CPU2>;
+					};
+					thread1 {
+						cpu = <&CPU3>;
+					};
+				};
+			};
+
+			CLUSTER3: cluster1 {
+				core0 {
+					thread0 {
+						cpu = <&CPU4>;
+					};
+					thread1 {
+						cpu = <&CPU5>;
+					};
+				};
+
+				core1 {
+					thread0 {
+						cpu = <&CPU6>;
+					};
+					thread1 {
+						cpu = <&CPU7>;
+					};
+				};
+			};
+		};
+
+		CLUSTER1: cluster1 {
+			CLUSTER4: cluster0 {
+				core0 {
+					thread0 {
+						cpu = <&CPU8>;
+					};
+					thread1 {
+						cpu = <&CPU9>;
+					};
+				};
+				core1 {
+					thread0 {
+						cpu = <&CPU10>;
+					};
+					thread1 {
+						cpu = <&CPU11>;
+					};
+				};
+			};
+
+			CLUSTER5: cluster1 {
+				core0 {
+					thread0 {
+						cpu = <&CPU12>;
+					};
+					thread1 {
+						cpu = <&CPU13>;
+					};
+				};
+				core1 {
+					thread0 {
+						cpu = <&CPU14>;
+					};
+					thread1 {
+						cpu = <&CPU15>;
+					};
+				};
+			};
+		};
+	};
+
+	cpu-power-states {
+		compatible = "arm,cpu-power-states";
+		#size-cells = <0>;
+		#address-cells = <1>;
+
+		state at 0 {
+			reg = <0>;
+			index = <2>;
+			entry-method = "psci";
+			psci-power-state = <0x1010000>;
+			latency = <400>;
+			min-residency = <300>;
+			power-depth = <2>;
+			cache-level-lost = <1>;
+			cpus = <&CLUSTER0>;
+		};
+
+		state at 1 {
+			reg = <1>;
+			index = <2>;
+			entry-method = "psci";
+			psci-power-state = <0x1010000>;
+			latency = <400>;
+			min-residency = <500>;
+			power-depth = <2>;
+			cache-level-lost = <1>;
+			cpus = <&CLUSTER1>;
+		};
+
+		state at 2 {
+			reg = <2>;
+			index = <3>;
+			entry-method = "psci";
+			psci-power-state = <0x3010000>;
+			latency = <1000>;
+			power-depth = <4>;
+			cache-level-lost = <2>;
+			cpus = <&CLUSTER0>;
+			affinity = <&CLUSTER0>;
+		};
+
+		state at 3 {
+			reg = <3>;
+			index = <3>;
+			entry-method = "psci";
+			latency = <4500>;
+			min-residency = <6500>;
+			psci-power-state = <0x3010000>;
+			power-depth = <4>;
+			cache-level-lost = <2>;
+			cpus = <&CLUSTER1>;
+			affinity = <&CLUSTER1>;
+		};
+	};
+
+	CPU0: cpu at 0 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a57";
+		reg = <0x0 0x0>;
+		enable-method = "psci";
+		next-cache-level = <&L1_0>;
+		L1_0: l1-cache {
+			compatible = "cache";
+			cache-level = <1>;
+			next-cache-level = <&L2_0>;
+		};
+		L2_0: l2-cache {
+			compatible = "cache";
+			cache-level = <2>;
+		};
+	};
+
+	CPU1: cpu at 1 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a57";
+		reg = <0x0 0x1>;
+		enable-method = "psci";
+		next-cache-level = <&L1_1>;
+		L1_1: l1-cache {
+			compatible = "cache";
+			cache-level = <1>;
+			next-cache-level = <&L2_0>;
+		};
+	};
+
+	CPU2: cpu at 100 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a57";
+		reg = <0x0 0x100>;
+		enable-method = "psci";
+		next-cache-level = <&L1_2>;
+		L1_2: l1-cache {
+			compatible = "cache";
+			cache-level = <1>;
+			next-cache-level = <&L2_0>;
+		};
+	};
+
+	CPU3: cpu at 101 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a57";
+		reg = <0x0 0x101>;
+		enable-method = "psci";
+		next-cache-level = <&L1_3>;
+		L1_3: l1-cache {
+			compatible = "cache";
+			cache-level = <1>;
+			next-cache-level = <&L2_0>;
+		};
+	};
+
+	CPU4: cpu at 10000 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a57";
+		reg = <0x0 0x10000>;
+		enable-method = "psci";
+		next-cache-level = <&L1_4>;
+		L1_4: l1-cache {
+			compatible = "cache";
+			cache-level = <1>;
+			next-cache-level = <&L2_0>;
+		};
+	};
+
+	CPU5: cpu at 10001 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a57";
+		reg = <0x0 0x10001>;
+		enable-method = "psci";
+		next-cache-level = <&L1_5>;
+		L1_5: l1-cache {
+			compatible = "cache";
+			cache-level = <1>;
+			next-cache-level = <&L2_0>;
+		};
+	};
+
+	CPU6: cpu at 10100 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a57";
+		reg = <0x0 0x10100>;
+		enable-method = "psci";
+		next-cache-level = <&L1_6>;
+		L1_6: l1-cache {
+			compatible = "cache";
+			cache-level = <1>;
+			next-cache-level = <&L2_0>;
+		};
+	};
+
+	CPU7: cpu at 10101 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a57";
+		reg = <0x0 0x10101>;
+		enable-method = "psci";
+		next-cache-level = <&L1_7>;
+		L1_7: l1-cache {
+			compatible = "cache";
+			cache-level = <1>;
+			next-cache-level = <&L2_0>;
+		};
+	};
+
+	CPU8: cpu at 100000000 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a53";
+		reg = <0x1 0x0>;
+		enable-method = "psci";
+		next-cache-level = <&L1_8>;
+		L1_8: l1-cache {
+			compatible = "cache";
+			cache-level = <1>;
+			next-cache-level = <&L2_1>;
+		};
+		L2_1: l2-cache {
+			compatible = "cache";
+			cache-level = <2>;
+		};
+	};
+
+	CPU9: cpu at 100000001 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a53";
+		reg = <0x1 0x1>;
+		enable-method = "psci";
+		next-cache-level = <&L1_9>;
+		L1_9: l1-cache {
+			compatible = "cache";
+			cache-level = <1>;
+			next-cache-level = <&L2_1>;
+		};
+	};
+
+	CPU10: cpu at 100000100 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a53";
+		reg = <0x1 0x100>;
+		enable-method = "psci";
+		next-cache-level = <&L1_10>;
+		L1_10: l1-cache {
+			compatible = "cache";
+			cache-level = <1>;
+			next-cache-level = <&L2_1>;
+		};
+	};
+
+	CPU11: cpu at 100000101 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a53";
+		reg = <0x1 0x101>;
+		enable-method = "psci";
+		next-cache-level = <&L1_11>;
+		L1_11: l1-cache {
+			compatible = "cache";
+			cache-level = <1>;
+			next-cache-level = <&L2_1>;
+		};
+	};
+
+	CPU12: cpu at 100010000 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a53";
+		reg = <0x1 0x10000>;
+		enable-method = "psci";
+		next-cache-level = <&L1_12>;
+		L1_12: l1-cache {
+			compatible = "cache";
+			cache-level = <1>;
+			next-cache-level = <&L2_1>;
+		};
+	};
+
+	CPU13: cpu at 100010001 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a53";
+		reg = <0x1 0x10001>;
+		enable-method = "psci";
+		next-cache-level = <&L1_13>;
+		L1_13: l1-cache {
+			compatible = "cache";
+			cache-level = <1>;
+			next-cache-level = <&L2_1>;
+		};
+	};
+
+	CPU14: cpu at 100010100 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a53";
+		reg = <0x1 0x10100>;
+		enable-method = "psci";
+		next-cache-level = <&L1_14>;
+		L1_14: l1-cache {
+			compatible = "cache";
+			cache-level = <1>;
+			next-cache-level = <&L2_1>;
+		};
+	};
+
+	CPU15: cpu at 100010101 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a53";
+		reg = <0x1 0x10101>;
+		enable-method = "psci";
+		next-cache-level = <&L1_15>;
+		L1_15: l1-cache {
+			compatible = "cache";
+			cache-level = <1>;
+			next-cache-level = <&L2_1>;
+		};
+	};
+};
+
+Example 2 (ARM 32-bit, 8-cpu system, two clusters):
+
+cpus {
+	#size-cells = <0>;
+	#address-cells = <1>;
+
+	cpu-map {
+		CLUSTER0: cluster0 {
+			core0 {
+				thread0 {
+					cpu = <&CPU0>;
+				};
+				thread1 {
+					cpu = <&CPU1>;
+				};
+			};
+
+			core1 {
+				thread0 {
+					cpu = <&CPU2>;
+				};
+				thread1 {
+					cpu = <&CPU3>;
+				};
+			};
+		};
+
+		CLUSTER1: cluster1 {
+			core0 {
+				thread0 {
+					cpu = <&CPU4>;
+				};
+				thread1 {
+					cpu = <&CPU5>;
+				};
+			};
+
+			core1 {
+				thread0 {
+					cpu = <&CPU6>;
+				};
+				thread1 {
+					cpu = <&CPU7>;
+				};
+			};
+		};
+	};
+
+	cpu-power-states {
+		compatible = "arm,cpu-power-states";
+		#size-cells = <0>;
+		#address-cells = <1>;
+
+		state at 0 {
+			reg = <0>;
+			index = <2>;
+			entry-method = "psci";
+			psci-power-state = <0x1010000>;
+			latency = <400>;
+			min-residency = <300>;
+			power-depth = <2>;
+			cpus = <&CLUSTER0>;
+		};
+
+		state at 1 {
+			reg = <1>;
+			index = <2>;
+			entry-method = "psci";
+			psci-power-state = <0x1010000>;
+			latency = <400>;
+			min-residency = <500>;
+			power-depth = <2>;
+			cpus = <&CLUSTER1>;
+		};
+
+		state at 2 {
+			reg = <2>;
+			index = <3>;
+			entry-method = "psci";
+			psci-power-state = <0x2010000>;
+			latency = <3000>;
+			min-residency = <3000>;
+			cache-level-lost = <2>;
+			power-depth = <3>;
+			cpus = <&CLUSTER0>;
+			affinity = <&CLUSTER0>;
+		};
+
+		state at 3 {
+			reg = <3>;
+			index = <3>;
+			entry-method = "psci";
+			psci-power-state = <0x2010000>;
+			latency = <4000>;
+			min-residency = <5000>;
+			cache-level-lost = <2>;
+			power-depth = <3>;
+			cpus = <&CLUSTER1>;
+			affinity = <&CLUSTER1>;
+		};
+	};
+
+	CPU0: cpu at 0 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a15";
+		reg = <0x0>;
+		next-cache-level = <&L1_0>;
+		L1_0: l1-cache {
+			compatible = "cache";
+			cache-level = <1>;
+		};
+		L2_0: l2-cache {
+			compatible = "cache";
+			cache-level = <2>;
+		};
+	};
+
+	CPU1: cpu at 1 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a15";
+		reg = <0x1>;
+		next-cache-level = <&L1_1>;
+		L1_1: l1-cache {
+			compatible = "cache";
+			cache-level = <1>;
+			next-cache-level = <&L2_0>;
+		};
+	};
+
+	CPU2: cpu at 2 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a15";
+		reg = <0x2>;
+		next-cache-level = <&L1_2>;
+		L1_2: l1-cache {
+			compatible = "cache";
+			cache-level = <1>;
+			next-cache-level = <&L2_0>;
+		};
+	};
+
+	CPU3: cpu at 3 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a15";
+		reg = <0x3>;
+		next-cache-level = <&L1_3>;
+		L1_3: l1-cache {
+			compatible = "cache";
+			cache-level = <1>;
+			next-cache-level = <&L2_0>;
+		};
+	};
+
+	CPU4: cpu at 100 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a7";
+		reg = <0x100>;
+		next-cache-level = <&L1_4>;
+		L1_4: l1-cache {
+			compatible = "cache";
+			cache-level = <1>;
+		};
+		L2_1: l2-cache {
+			compatible = "cache";
+			cache-level = <2>;
+		};
+	};
+
+	CPU5: cpu at 101 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a7";
+		reg = <0x101>;
+		next-cache-level = <&L1_5>;
+		L1_5: l1-cache {
+			compatible = "cache";
+			cache-level = <1>;
+			next-cache-level = <&L2_1>;
+		};
+	};
+
+	CPU6: cpu at 102 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a7";
+		reg = <0x102>;
+		next-cache-level = <&L1_6>;
+		L1_6: l1-cache {
+			compatible = "cache";
+			cache-level = <1>;
+			next-cache-level = <&L2_1>;
+		};
+	};
+
+	CPU7: cpu at 103 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a7";
+		reg = <0x103>;
+		next-cache-level = <&L1_7>;
+		L1_7: l1-cache {
+			compatible = "cache";
+			cache-level = <1>;
+			next-cache-level = <&L2_1>;
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
+[2] ARM Linux kernel documentation - topology bindings
+    Documentation/devicetree/bindings/arm/topology.txt
+
+[3] ARM Linux kernel documentation - cache bindings
+    Documentation/devicetree/bindings/arm/cache.txt
+
+[4] ePAPR standard
+    https://www.power.org/documentation/epapr-version-1-1/
-- 
1.8.4
