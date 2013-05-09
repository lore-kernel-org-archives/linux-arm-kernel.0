From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu,  9 May 2013 11:34:00 +0100
Subject: [RFC PATCH v3] drivers: bus: add ARM CCI support
In-Reply-To: <1368095640-3675-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1368095640-3675-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1368095640-3675-2-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ARM multi-cluster systems coherency between cores running on
different clusters is managed by the cache-coherent interconnect (CCI).
It allows broadcasting of TLB invalidates and memory barriers and it
guarantees cache coherency at system level through snooping of slave
interfaces connected to it.

This patch enables the basic infrastructure required in Linux to handle and
programme the CCI component.

Non-local variables used by the CCI management functions called by power
down function calls after disabling the cache must be flushed out to main
memory in advance, otherwise incoherency of those values may occur if they
are sitting in the cache of some other CPU when power down functions
execute. Driver code ensures that relevant data structures are flushed
from inner and outer caches after the driver probe is completed.

CCI slave port resources are linked to set of CPUs through bus masters
phandle properties that link the interface resources to masters node in
the device tree.

Documentation describing the CCI DT bindings is provided with the patch.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 Documentation/devicetree/bindings/arm/cci.txt | 161 ++++++++++
 drivers/bus/Kconfig                           |   7 +
 drivers/bus/Makefile                          |   2 +
 drivers/bus/arm-cci.c                         | 420 ++++++++++++++++++++++++++
 include/linux/arm-cci.h                       |  61 ++++
 5 files changed, 651 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/cci.txt
 create mode 100644 drivers/bus/arm-cci.c
 create mode 100644 include/linux/arm-cci.h

diff --git a/Documentation/devicetree/bindings/arm/cci.txt b/Documentation/devicetree/bindings/arm/cci.txt
new file mode 100644
index 0000000..384b460
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/cci.txt
@@ -0,0 +1,161 @@
+=======================================================
+ARM CCI cache coherent interconnect binding description
+=======================================================
+
+ARM multi-cluster systems maintain intra-cluster coherency through a
+cache coherent interconnect (CCI) that is capable of monitoring bus
+transactions and manage coherency, TLB invalidations and memory barriers.
+
+It allows snooping and distributed virtual memory message broadcast across
+clusters, through memory mapped interface, with a global control register
+space and multiple sets of interface control registers, one per slave
+interface.
+
+Bindings for the CCI node follow the ePAPR standard, available from:
+
+www.power.org/documentation/epapr-version-1-1/
+
+with the addition of the bindings described in this document which are
+specific to ARM.
+
+* CCI interconnect node
+
+	Description: Describes a CCI cache coherent Interconnect component
+
+	Node name must be "cci".
+	Node's parent must be the root node /, and the address space visible
+	through the CCI interconnect is the same as the one seen from the
+	root node (ie from CPUs perspective as per DT standard).
+	Every CCI node has to define the following properties:
+
+	- compatible
+		Usage: required
+		Value type: <string>
+		Definition: must be set to
+			"arm,cci-400"
+
+	- reg
+		Usage: required
+		Value type: <prop-encoded-array>
+		Definition: A standard property. Specifies base physical
+			    address of CCI control registers common to all
+			    interfaces.
+
+	- ranges:
+		Usage: required
+		Value type: <prop-encoded-array>
+		Definition: A standard property. Follow rules in the ePAPR for
+			    hierarchical bus addressing. CCI interfaces
+			    addresses refer to the parent node addressing
+			    scheme to declare their register bases.
+
+	CCI interconnect node can define the following child nodes:
+
+	- CCI control interface nodes
+
+		Node name must be "slave-if".
+		Parent node must be CCI interconnect node.
+
+		A CCI interface node must contain the following properties:
+		- interface-type:
+			Usage: required
+			Value type: <string>
+			Definition: must be set to one of {"ace", "ace-lite"}
+				    depending on the interface type the node
+				    represents.
+
+		- reg:
+			Usage: required
+			Value type: <prop-encoded-array>
+			Definition: the base address and size of the
+				    corresponding interface programming
+				    registers.
+
+* CCI interconnect bus masters
+
+	Description: masters in the device tree connected to a CCI port
+		     (inclusive of CPUs and their cpu nodes).
+
+	A CCI interconnect bus master node must contain the following
+	properties:
+
+	- cci-control-port:
+		Usage: required
+		Value type: <phandle>
+		Definition: a phandle containing the CCI control interface node
+			    the master is connected to.
+
+Example:
+
+	cpus {
+		#size-cells = <0>;
+		#address-cells = <1>;
+
+		CPU0: cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			cci-control-port = <&cci_control1>;
+			reg = <0x0>;
+		};
+
+		CPU1: cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			cci-control-port = <&cci_control1>;
+			reg = <0x1>;
+		};
+
+		CPU2: cpu at 100 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			cci-control-port = <&cci_control2>;
+			reg = <0x100>;
+		};
+
+		CPU3: cpu at 101 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			cci-control-port = <&cci_control2>;
+			reg = <0x101>;
+		};
+
+	};
+
+	dma0: dma at 3000000 {
+		compatible = "arm,pl330", "arm,primecell";
+		cci-control-port = <&cci_control0>;
+		reg = <0x0 0x3000000 0x0 0x1000>;
+		interrupts = <10>;
+		#dma-cells = <1>;
+		#dma-channels = <8>;
+		#dma-requests = <32>;
+	};
+
+	cci at 2c090000 {
+		compatible = "arm,cci";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0x0 0x2c090000 0 0x1000>;
+		ranges = <0x0 0x0 0x2c090000 0x6000>;
+
+		cci_control0 : slave-if at 1000 {
+			interface-type = "ace-lite";
+			reg = <0x1000 0x1000>;
+		};
+
+		cci_control1 : slave-if at 4000 {
+			interface-type = "ace";
+			reg = <0x4000 0x1000>;
+		};
+
+		cci_control2 : slave-if at 5000 {
+			interface-type = "ace";
+			reg = <0x5000 0x1000>;
+		};
+	};
+
+This CCI node corresponds to a CCI component whose control registers sits
+at address 0x000000002c090000.
+CCI slave interface @0x000000002c091000 is connected to dma controller dma0.
+CCI slave interface @0x000000002c094000 is connected to CPUs {CPU0, CPU1};
+CCI slave interface @0x000000002c095000 is connected to CPUs {CPU2, CPU3};
diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index 0f51ed6..38ea85c 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -19,4 +19,11 @@ config OMAP_INTERCONNECT
 
 	help
 	  Driver to enable OMAP interconnect error handling driver.
+
+config ARM_CCI
+	bool "ARM CCI driver support"
+	depends on ARM
+	help
+	  Driver supporting the CCI cache coherent interconnect for ARM
+	  platforms.
 endmenu
diff --git a/drivers/bus/Makefile b/drivers/bus/Makefile
index 45d997c..2bd9947 100644
--- a/drivers/bus/Makefile
+++ b/drivers/bus/Makefile
@@ -6,3 +6,5 @@ obj-$(CONFIG_OMAP_OCP2SCP)	+= omap-ocp2scp.o
 
 # Interconnect bus driver for OMAP SoCs.
 obj-$(CONFIG_OMAP_INTERCONNECT)	+= omap_l3_smx.o omap_l3_noc.o
+# CCI cache coherent interconnect for ARM platforms
+obj-$(CONFIG_ARM_CCI)		+= arm-cci.o
diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
new file mode 100644
index 0000000..000102f
--- /dev/null
+++ b/drivers/bus/arm-cci.c
@@ -0,0 +1,420 @@
+/*
+ * CCI cache coherent interconnect driver
+ *
+ * Copyright (C) 2013 ARM Ltd.
+ * Author: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/arm-cci.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/slab.h>
+
+#include <asm/cacheflush.h>
+#include <asm/smp_plat.h>
+
+#define DRIVER_NAME		"CCI"
+
+#define CCI_PORT_CTRL		0x0
+#define CCI_CTRL_STATUS		0xc
+
+#define CCI_ENABLE_SNOOP_REQ	0x1
+#define CCI_ENABLE_DVM_REQ	0x2
+#define CCI_ENABLE_REQ		(CCI_ENABLE_SNOOP_REQ | CCI_ENABLE_DVM_REQ)
+
+struct cci_nb_ports {
+	unsigned int nb_ace;
+	unsigned int nb_ace_lite;
+};
+
+enum cci_ace_port_type {
+	ACE_INVALID_PORT = 0x0,
+	ACE_PORT,
+	ACE_LITE_PORT,
+};
+
+struct cci_ace_port {
+	void __iomem *base;
+	enum cci_ace_port_type type;
+	struct device_node *dn;
+};
+
+static struct cci_ace_port *ports;
+static unsigned int nb_cci_ports;
+
+static void __iomem *cci_ctrl_base;
+
+struct cpu_port {
+	u64 mpidr;
+	u32 port;
+};
+/*
+ * Use the port MSB as valid flag, shift can be made dynamic
+ * by computing number of bits required for port indexes.
+ * Code disabling CCI cpu ports runs with D-cache invalidated
+ * and SCTLR bit clear so data accesses must be kept to a minimum
+ * to improve performance; for now shift is left static to
+ * avoid one more data access while disabling the CCI port.
+ */
+#define PORT_VALID_SHIFT	31
+#define PORT_VALID		(0x1 << PORT_VALID_SHIFT)
+
+static inline void init_cpu_port(struct cpu_port *port, u32 index, u32 mpidr)
+{
+	port->port = PORT_VALID | index;
+	port->mpidr = mpidr;
+}
+
+static inline bool cpu_port_is_valid(struct cpu_port *port)
+{
+	return !!(port->port & PORT_VALID);
+}
+
+static inline bool cpu_port_match(struct cpu_port *port, u32 mpidr)
+{
+	return port->mpidr == (mpidr & MPIDR_HWID_BITMASK);
+}
+
+static struct cpu_port cpu_port[NR_CPUS];
+
+/**
+ * __cci_ace_get_port - Function to retrieve the port index connected to
+ *			a cpu or device.
+ *
+ * @dn: device node of the device to look-up
+ * @type: port type
+ *
+ * Return value:
+ *	- CCI port index if success
+ *	- -ENODEV if failure
+ */
+static int __cci_ace_get_port(struct device_node *dn, int type)
+{
+	int i;
+	bool ace_match;
+	struct device_node *cci_portn;
+
+	cci_portn = of_parse_phandle(dn, "cci-control-port", 0);
+	for (i = 0; i < nb_cci_ports; i++) {
+		ace_match = ports[i].type == type;
+		if (ace_match && cci_portn == ports[i].dn)
+			return i;
+	}
+	return -ENODEV;
+}
+
+int cci_ace_get_port(struct device_node *dn)
+{
+	return __cci_ace_get_port(dn, ACE_LITE_PORT);
+}
+EXPORT_SYMBOL_GPL(cci_ace_get_port);
+
+static void __init cci_ace_init_ports(void)
+{
+	int port, ac, cpu;
+	u64 hwid;
+	const u32 *cell;
+	struct device_node *cpun, *cpus;
+
+	cpus = of_find_node_by_path("/cpus");
+	if (WARN(!cpus, "Missing cpus node, bailing out\n"))
+		return;
+
+	if (WARN_ON(of_property_read_u32(cpus, "#address-cells", &ac)))
+		ac = of_n_addr_cells(cpus);
+
+	/*
+	 * Port index look-up speeds up the function disabling ports by CPU,
+	 * since the logical to port index mapping is done once and does
+	 * not change after system boot.
+	 * The stashed index array is initialized for all possible CPUs
+	 *@probe time.
+	 */
+	for_each_child_of_node(cpus, cpun) {
+		if (of_node_cmp(cpun->type, "cpu"))
+			continue;
+		cell = of_get_property(cpun, "reg", NULL);
+		if (WARN(!cell, "%s: missing reg property\n", cpun->full_name))
+			continue;
+
+		hwid = of_read_number(cell, ac);
+		cpu = get_logical_index(hwid & MPIDR_HWID_BITMASK);
+
+		if (cpu < 0 || !cpu_possible(cpu))
+			continue;
+		port = __cci_ace_get_port(cpun, ACE_PORT);
+		if (port < 0)
+			continue;
+
+		init_cpu_port(&cpu_port[cpu], port, cpu_logical_map(cpu));
+	}
+
+	for_each_possible_cpu(cpu) {
+		WARN(!cpu_port_is_valid(&cpu_port[cpu]),
+			"CPU %u does not have an associated CCI port\n",
+			cpu);
+	}
+}
+/*
+ * Functions to enable/disable a CCI interconnect slave port
+ *
+ * They are called by low-level power management code to disable slave
+ * interfaces snoops and DVM broadcast.
+ * Since they may execute with cache data allocation disabled and
+ * after the caches have been cleaned and invalidated the functions provide
+ * no explicit locking since they may run with D-cache disabled, so normal
+ * cacheable kernel locks based on ldrex/strex may not work.
+ * Locking has to be provided by BSP implementations to ensure proper
+ * operations.
+ */
+
+/**
+ * cci_port_control() - function to control a CCI port
+ *
+ * @port: index of the port to setup
+ * @enable: if true enables the port, if false disables it
+ */
+static void notrace cci_port_control(unsigned int port, bool enable)
+{
+	void __iomem *base = ports[port].base;
+
+	writel_relaxed(enable ? CCI_ENABLE_REQ : 0, base + CCI_PORT_CTRL);
+	/*
+	 * This function is called from power down procedures
+	 * and must not execute any instruction that might
+	 * cause the processor to be put in a quiescent state
+	 * (eg wfi). Hence, cpu_relax() can not be added to this
+	 * read loop to optimize power, since it might hide possibly
+	 * disruptive operations.
+	 */
+	while (readl_relaxed(cci_ctrl_base + CCI_CTRL_STATUS) & 0x1)
+			;
+}
+
+/**
+ * cci_disable_port_by_cpu() - function to disable a CCI port by CPU
+ *			       reference
+ *
+ * @mpidr: mpidr of the CPU whose CCI port should be disabled
+ *
+ * Disabling a CCI port for a CPU implies disabling the CCI port
+ * controlling that CPU cluster. Code disabling CPU CCI ports
+ * must make sure that the CPU running the code is the last active CPU
+ * in the cluster ie all other CPUs are quiescent in a low power state.
+ *
+ * Return:
+ *	0 on success
+ *	-ENODEV on port look-up failure
+ */
+int notrace cci_disable_port_by_cpu(u64 mpidr)
+{
+	int cpu;
+	bool is_valid;
+	for (cpu = 0; cpu < nr_cpu_ids; cpu++) {
+		is_valid = cpu_port_is_valid(&cpu_port[cpu]);
+		if (is_valid && cpu_port_match(&cpu_port[cpu], mpidr)) {
+			cci_port_control(cpu_port[cpu].port, false);
+			return 0;
+		}
+	}
+	return -ENODEV;
+}
+EXPORT_SYMBOL_GPL(cci_disable_port_by_cpu);
+
+/**
+ * __cci_control_port_by_device() - function to control a CCI port by device
+ *				    reference
+ *
+ * @dn: device node pointer of the device whose CCI port should be
+ *      controlled
+ * @enable: if true enables the port, if false disables it
+ *
+ * Return:
+ *	0 on success
+ *	-ENODEV on port look-up failure
+ */
+int notrace __cci_control_port_by_device(struct device_node *dn, bool enable)
+{
+	int port;
+
+	if (!dn)
+		return -ENODEV;
+
+	port = __cci_ace_get_port(dn, ACE_LITE_PORT);
+	if (WARN_ONCE(port < 0, "node %s ACE lite port look-up failure\n",
+				dn->full_name))
+		return -ENODEV;
+	cci_port_control(port, enable);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(__cci_control_port_by_device);
+
+/**
+ * __cci_control_port_by_index() - function to control a CCI port by port index
+ *
+ * @port: port index previously retrieved with cci_ace_get_port()
+ * @enable: if true enables the port, if false disables it
+ *
+ * Return:
+ *	0 on success
+ *	-ENODEV on port index out of range
+ *	-EPERM if operation carried out on an ACE PORT
+ */
+int notrace __cci_control_port_by_index(u32 port, bool enable)
+{
+	if (port >= nb_cci_ports || ports[port].type == ACE_INVALID_PORT)
+		return -ENODEV;
+	/*
+	 * CCI control for ports connected to CPUS is extremely fragile
+	 * and must be made to go through a specific and controlled
+	 * interface (ie cci_disable_port_by_cpu(); control by general purpose
+	 * indexing is therefore disabled for ACE ports.
+	 */
+	if (ports[port].type == ACE_PORT)
+		return -EPERM;
+
+	cci_port_control(port, enable);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(__cci_control_port_by_index);
+
+static const struct cci_nb_ports cci400_ports = {
+	.nb_ace = 2,
+	.nb_ace_lite = 3
+};
+
+static const struct of_device_id arm_cci_matches[] = {
+	{.compatible = "arm,cci-400", .data = &cci400_ports },
+	{},
+};
+
+static int __init cci_probe(void)
+{
+	struct cci_nb_ports const *cci_config;
+	int ret, i, nb_ace = 0, nb_ace_lite = 0;
+	struct device_node *np, *cp;
+	const char *match_str;
+	bool is_ace;
+
+	np = of_find_matching_node(NULL, arm_cci_matches);
+	if (!np)
+		return -ENODEV;
+
+	cci_config = of_match_node(arm_cci_matches, np)->data;
+	if (!cci_config)
+		return -ENODEV;
+
+	nb_cci_ports = cci_config->nb_ace + cci_config->nb_ace_lite;
+
+	ports = kcalloc(sizeof(*ports), nb_cci_ports, GFP_KERNEL);
+	if (!ports)
+		return -ENOMEM;
+
+	cci_ctrl_base = of_iomap(np, 0);
+
+	if (!cci_ctrl_base) {
+		WARN(1, "unable to ioremap CCI ctrl\n");
+		ret = -ENXIO;
+		goto memalloc_err;
+	}
+
+	for_each_child_of_node(np, cp) {
+		i = nb_ace + nb_ace_lite;
+
+		if (i >= nb_cci_ports)
+			break;
+
+		if (of_property_read_string(cp, "interface-type",
+					&match_str)) {
+			WARN(1, "node %s missing interface-type property\n",
+				  cp->full_name);
+			continue;
+		}
+		is_ace = strcmp(match_str, "ace") == 0;
+		if (!is_ace && strcmp(match_str, "ace-lite")) {
+			WARN(1, "node %s containing invalid interface-type property, skipping it\n",
+					cp->full_name);
+			continue;
+		}
+
+		ports[i].base = of_iomap(cp, 0);
+
+		if (!ports[i].base) {
+			WARN(1, "unable to ioremap CCI port %d\n", i);
+			continue;
+		}
+
+		if (is_ace) {
+			if (WARN_ON(nb_ace >= cci_config->nb_ace))
+				continue;
+			ports[i].type = ACE_PORT;
+			++nb_ace;
+		} else {
+			if (WARN_ON(nb_ace_lite >= cci_config->nb_ace_lite))
+				continue;
+			ports[i].type = ACE_LITE_PORT;
+			++nb_ace_lite;
+		}
+		ports[i].dn = cp;
+	}
+
+	 /* initialize a stashed array of ACE ports to speed-up look-up */
+	cci_ace_init_ports();
+
+	/*
+	 * Multi-cluster systems may need this data when non-coherent, during
+	 * cluster power-up/power-down. Make sure it reaches main memory.
+	 */
+	sync_cache_w(&cci_ctrl_base);
+	sync_cache_w(&ports);
+	sync_cache_w(&cpu_port);
+	__sync_cache_range_w(ports, sizeof(*ports) * nb_cci_ports);
+	pr_info("ARM CCI driver probed\n");
+	return 0;
+
+memalloc_err:
+
+	kfree(ports);
+	return ret;
+}
+
+static int cci_init_status = -EAGAIN;
+static DEFINE_MUTEX(cci_probing);
+
+static int __init cci_init(void)
+{
+	if (cci_init_status != -EAGAIN)
+		return cci_init_status;
+
+	mutex_lock(&cci_probing);
+	if (cci_init_status == -EAGAIN)
+		cci_init_status = cci_probe();
+	mutex_unlock(&cci_probing);
+	return cci_init_status;
+}
+
+/*
+ * To sort out early init calls ordering a helper function is provided to
+ * check if the CCI driver has beed initialized. Function check if the driver
+ * has been initialized, if not it calls the init function that probes
+ * the driver and updates the return value.
+ */
+bool __init cci_probed(void)
+{
+	return cci_init() == 0;
+}
+EXPORT_SYMBOL_GPL(cci_probed);
+
+early_initcall(cci_init);
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("ARM CCI support");
diff --git a/include/linux/arm-cci.h b/include/linux/arm-cci.h
new file mode 100644
index 0000000..79d6edf
--- /dev/null
+++ b/include/linux/arm-cci.h
@@ -0,0 +1,61 @@
+/*
+ * CCI cache coherent interconnect support
+ *
+ * Copyright (C) 2013 ARM Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifndef __LINUX_ARM_CCI_H
+#define __LINUX_ARM_CCI_H
+
+#include <linux/errno.h>
+#include <linux/types.h>
+
+struct device_node;
+
+#ifdef CONFIG_ARM_CCI
+extern bool cci_probed(void);
+extern int cci_ace_get_port(struct device_node *dn);
+extern int cci_disable_port_by_cpu(u64 mpidr);
+extern int __cci_control_port_by_device(struct device_node *dn, bool enable);
+extern int __cci_control_port_by_index(u32 port, bool enable);
+#else
+static inline bool cci_probed(void) { return false; }
+static inline int cci_ace_get_port(struct device_node *dn)
+{
+	return -ENODEV;
+}
+static inline int cci_disable_port_by_cpu(u64 mpidr) { return -ENODEV; }
+static inline int __cci_control_port_by_device(struct device_node *dn,
+					       bool enable)
+{
+	return -ENODEV;
+}
+static inline int __cci_control_port_by_index(u32 port, bool enable)
+{
+	return -ENODEV;
+}
+#endif
+#define cci_disable_port_by_device(dev) \
+	__cci_control_port_by_device(dev, false)
+#define cci_enable_port_by_device(dev) \
+	__cci_control_port_by_device(dev, true)
+#define cci_disable_port_by_index(dev) \
+	__cci_control_port_by_index(dev, false)
+#define cci_enable_port_by_index(dev) \
+	__cci_control_port_by_index(dev, true)
+
+#endif
-- 
1.8.2.2
