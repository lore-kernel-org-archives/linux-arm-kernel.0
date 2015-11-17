From: gkulkarni@caviumnetworks.com (Ganapatrao Kulkarni)
Date: Tue, 17 Nov 2015 22:50:41 +0530
Subject: [PATCH v7 2/4] Documentation, dt, arm64/arm: dt bindings for numa.
In-Reply-To: <1447780843-9223-1-git-send-email-gkulkarni@caviumnetworks.com>
References: <1447780843-9223-1-git-send-email-gkulkarni@caviumnetworks.com>
Message-ID: <1447780843-9223-3-git-send-email-gkulkarni@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DT bindings for numa mapping of memory, cores and IOs.

Reviewed-by: Robert Richter <rrichter@cavium.com>
Signed-off-by: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>
---
 Documentation/devicetree/bindings/arm/numa.txt | 272 +++++++++++++++++++++++++
 1 file changed, 272 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/numa.txt

diff --git a/Documentation/devicetree/bindings/arm/numa.txt b/Documentation/devicetree/bindings/arm/numa.txt
new file mode 100644
index 0000000..b87bf4f
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/numa.txt
@@ -0,0 +1,272 @@
+==============================================================================
+NUMA binding description.
+==============================================================================
+
+==============================================================================
+1 - Introduction
+==============================================================================
+
+Systems employing a Non Uniform Memory Access (NUMA) architecture contain
+collections of hardware resources including processors, memory, and I/O buses,
+that comprise what is commonly known as a NUMA node.
+Processor accesses to memory within the local NUMA node is generally faster
+than processor accesses to memory outside of the local NUMA node.
+DT defines interfaces that allow the platform to convey NUMA node
+topology information to OS.
+
+==============================================================================
+2 - numa-node-id
+==============================================================================
+The device node property numa-node-id describes numa domains within a
+machine. This property can be used in device nodes like cpu, memory, bus and
+devices to map to respective numa nodes.
+
+numa-node-id property is a 32-bit integer which defines numa node id to which
+this device node has numa domain association.
+
+Example:
+	/* numa node 0 */
+	numa-node-id = <0>;
+
+	/* numa node 1 */
+	numa-node-id = <1>;
+
+==============================================================================
+3 - distance-map
+==============================================================================
+
+The device tree node distance-map describes the relative
+distance (memory latency) between all numa nodes.
+
+- compatible : Should at least contain "numa,distance-map-v1".
+
+- distance-matrix
+  This property defines a matrix to describe the relative distances
+  between all numa nodes.
+  It is represented as a list of node pairs and their relative distance.
+
+  Note:
+	1. Each entry represents distance from first node to second node.
+	2. If both directions between 2 nodes have the same distance, only
+	       one entry is required.
+	2. distance-matrix shold have entries in lexicographical ascending order of nodes.
+	3. There must be only one Device node distance-map and must reside in the root node.
+
+Example:
+	4 nodes connected in mesh/ring topology as below,
+
+		0_______20______1
+		|               |
+		|               |
+	      20|               |20
+		|               |
+		|               |
+		|_______________|
+		3       20      2
+
+	if relative distance for each hop is 20,
+	then inter node distance would be for this topology will be,
+	      0 -> 1 = 20
+	      1 -> 2 = 20
+	      2 -> 3 = 20
+	      3 -> 0 = 20
+	      0 -> 2 = 40
+	      1 -> 3 = 40
+
+     and dt presentation for this distance matrix is,
+
+		distance-map {
+			 compatible = "numa,distance-map-v1";
+			 distance-matrix = <0 0  10>,
+					   <0 1  20>,
+					   <0 2  40>,
+					   <0 3  20>,
+					   <1 0  20>,
+					   <1 1  10>,
+					   <1 2  20>,
+					   <1 3  40>,
+					   <2 0  40>,
+					   <2 1  20>,
+					   <2 2  10>,
+					   <2 3  20>,
+					   <3 0  20>,
+					   <3 1  40>,
+					   <3 2  20>,
+					   <3 3  10>;
+		};
+
+Note:
+	 1. The entries like <1 0> can be optional if <0 1> and <1 0>
+	    are of same distance.
+
+==============================================================================
+4 - Example dts
+==============================================================================
+
+2 sockets system consists of 2 boards connected through ccn bus and
+each board having one socket/soc of 8 cpus, memory and pci bus.
+
+	memory at 00c00000 {
+		device_type = "memory";
+		reg = <0x0 0x00c00000 0x0 0x80000000>;
+		/* node 0 */
+		numa-node-id = <0>;
+	};
+
+	memory at 10000000000 {
+		device_type = "memory";
+		reg = <0x100 0x00000000 0x0 0x80000000>;
+		/* node 1 */
+		numa-node-id = <1>;
+	};
+
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cpu at 000 {
+			device_type = "cpu";
+			compatible =  "arm,armv8";
+			reg = <0x0 0x000>;
+			enable-method = "psci";
+			/* node 0 */
+			numa-node-id = <0>;
+		};
+		cpu at 001 {
+			device_type = "cpu";
+			compatible =  "arm,armv8";
+			reg = <0x0 0x001>;
+			enable-method = "psci";
+			numa-node-id = <0>;
+		};
+		cpu at 002 {
+			device_type = "cpu";
+			compatible =  "arm,armv8";
+			reg = <0x0 0x002>;
+			enable-method = "psci";
+			numa-node-id = <0>;
+		};
+		cpu at 003 {
+			device_type = "cpu";
+			compatible =  "arm,armv8";
+			reg = <0x0 0x003>;
+			enable-method = "psci";
+			numa-node-id = <0>;
+		};
+		cpu at 004 {
+			device_type = "cpu";
+			compatible =  "arm,armv8";
+			reg = <0x0 0x004>;
+			enable-method = "psci";
+			numa-node-id = <0>;
+		};
+		cpu at 005 {
+			device_type = "cpu";
+			compatible =  "arm,armv8";
+			reg = <0x0 0x005>;
+			enable-method = "psci";
+			numa-node-id = <0>;
+		};
+		cpu at 006 {
+			device_type = "cpu";
+			compatible =  "arm,armv8";
+			reg = <0x0 0x006>;
+			enable-method = "psci";
+			numa-node-id = <0>;
+		};
+		cpu at 007 {
+			device_type = "cpu";
+			compatible =  "arm,armv8";
+			reg = <0x0 0x007>;
+			enable-method = "psci";
+			numa-node-id = <0>;
+		};
+		cpu at 008 {
+			device_type = "cpu";
+			compatible =  "arm,armv8";
+			reg = <0x0 0x008>;
+			enable-method = "psci";
+			/* node 1 */
+			numa-node-id = <1>;
+		};
+		cpu at 009 {
+			device_type = "cpu";
+			compatible =  "arm,armv8";
+			reg = <0x0 0x009>;
+			enable-method = "psci";
+			numa-node-id = <1>;
+		};
+		cpu at 00a {
+			device_type = "cpu";
+			compatible =  "arm,armv8";
+			reg = <0x0 0x00a>;
+			enable-method = "psci";
+			numa-node-id = <1>;
+		};
+		cpu at 00b {
+			device_type = "cpu";
+			compatible =  "arm,armv8";
+			reg = <0x0 0x00b>;
+			enable-method = "psci";
+			numa-node-id = <1>;
+		};
+		cpu at 00c {
+			device_type = "cpu";
+			compatible =  "arm,armv8";
+			reg = <0x0 0x00c>;
+			enable-method = "psci";
+			numa-node-id = <1>;
+		};
+		cpu at 00d {
+			device_type = "cpu";
+			compatible =  "arm,armv8";
+			reg = <0x0 0x00d>;
+			enable-method = "psci";
+			numa-node-id = <1>;
+		};
+		cpu at 00e {
+			device_type = "cpu";
+			compatible =  "arm,armv8";
+			reg = <0x0 0x00e>;
+			enable-method = "psci";
+			numa-node-id = <1>;
+		};
+		cpu at 00f {
+			device_type = "cpu";
+			compatible =  "arm,armv8";
+			reg = <0x0 0x00f>;
+			enable-method = "psci";
+			numa-node-id = <1>;
+		};
+	};
+
+	pcie0: pcie0 at 0x8480,00000000 {
+		compatible = "arm,armv8";
+		device_type = "pci";
+		bus-range = <0 255>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <0x8480 0x00000000 0 0x10000000>;  /* Configuration space */
+		ranges = <0x03000000 0x8010 0x00000000 0x8010 0x00000000 0x70 0x00000000>;
+		/* node 0 */
+		numa-node-id = <0>;
+        };
+
+	pcie1: pcie1 at 0x9480,00000000 {
+		compatible = "arm,armv8";
+		device_type = "pci";
+		bus-range = <0 255>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <0x9480 0x00000000 0 0x10000000>;  /* Configuration space */
+		ranges = <0x03000000 0x9010 0x00000000 0x9010 0x00000000 0x70 0x00000000>;
+		/* node 1 */
+		numa-node-id = <1>;
+        };
+
+	distance-map {
+		compatible = "numa,distance-map-v1";
+		distance-matrix = <0 0 10>,
+				  <0 1 20>,
+				  <1 1 10>;
+	};
-- 
1.8.1.4
