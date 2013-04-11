From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 11 Apr 2013 15:47:59 +0100
Subject: [RFC PATCH] drivers: bus: add ARM CCI support
In-Reply-To: <1365691679-28674-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1365691679-28674-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1365691679-28674-2-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ARM multi-cluster systems coherency between cores running on
different clusters is managed by the cache-coherent interconnect (CCI).
It allows broadcasting of TLB invalidates and memory barriers and it
guarantees cache coherency at system level through snooping of slave
interfaces connected to it.

This patch enables the basic infrastructure required in Linux to handle and
programme the CCI component. The first implementation is based on a platform
device, its relative DT compatible property and a simple programming interface.

Non-local variables used by the CCI management functions called by power
down function calls after disabling the cache must be flushed out to main
memory in advance, otherwise incoherency of those values may occur if they
are sitting in the cache of some other CPU when power down functions
execute. Driver code insures that relevant data structures are flushed
from inner and outer caches after the driver probe is completed.

CCI slave port resources are linked to set of CPUs through CCI interfaces
phandle properties that link the interface resources to topology node in
the device tree.

Documentation describing the CCI DT bindings is provided with the patch.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 Documentation/devicetree/bindings/arm/cci.txt | 184 ++++++++++++++
 drivers/bus/Kconfig                           |   7 +
 drivers/bus/Makefile                          |   2 +
 drivers/bus/arm-cci.c                         | 344 ++++++++++++++++++++++++++
 include/linux/arm-cci.h                       |  44 ++++
 5 files changed, 581 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/cci.txt
 create mode 100644 drivers/bus/arm-cci.c
 create mode 100644 include/linux/arm-cci.h

diff --git a/Documentation/devicetree/bindings/arm/cci.txt b/Documentation/devicetree/bindings/arm/cci.txt
new file mode 100644
index 0000000..9a7bb7b
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/cci.txt
@@ -0,0 +1,184 @@
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
+http://devicetree.org
+
+with the addition of the bindings described in this document which are
+specific to ARM.
+
+- cci node
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
+- CCI interface nodes
+
+	Node name must be "slave-if".
+
+	A CCI interface node must contain the following properties:
+	- interface-type:
+		Usage: required
+		Value type: <string>
+		Definition: must be set to one of {"ace", "ace-lite"}
+			    depending on the interface type the node
+			    represents.
+
+	- reg:
+		Usage: required
+		Value type: <prop-encoded-array>
+                Definition: the base address and size of the corresponding
+			    interface programming registers.
+
+	- master:
+		Usage: required
+		Value type: <phandle>
+		Definition: if the interface-type is set to "ace", so the
+			    interface is an ACE port, this property must be a
+			    phandle to the node within the cpu-map node ([1])
+			    that describes the CPUs connected to the interface
+			    port. Valid phandles are nodes contained in
+			    the cpu-map node, as defined in [1]. If the
+			    interface-type is set to "ace-lite" so the
+			    interface describes an ACE LITE port, this property
+			    must be a phandle pointing at the device node
+			    representing the bus-master connected to this port.
+
+Example:
+
+	cpu-map {
+
+		cluster0 {
+
+			core0 {
+				cpu = <&CPU0>;
+			};
+
+			core1 {
+				cpu = <&CPU1>;
+			};
+
+		};
+
+		cluster1 {
+
+			core0 {
+				cpu = <&CPU2>;
+			};
+
+			core1 {
+				cpu = <&CPU3>;
+			};
+
+		};
+	};
+
+	cpus {
+		#size-cells = <0>;
+		#address-cells = <1>;
+
+		CPU0: cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <0x0>;
+		};
+
+		CPU1: cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <0x1>;
+		};
+
+		CPU2: cpu at 100 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0x100>;
+		};
+
+		CPU3: cpu at 101 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0x101>;
+		};
+
+	};
+
+	dma0: dma at 3000000 {
+		compatible = "arm,pl330", "arm,primecell";
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
+		slave-if at 1000 {
+			interface-type = "ace-lite";
+			reg = <0x1000 0x1000>;
+			master = <&dma0>;
+		};
+
+		slave-if at 4000 {
+			interface-type = "ace";
+			reg = <0x4000 0x1000>;
+			master = <&cluster0>;
+		};
+
+		slave-if at 5000 {
+			interface-type = "ace";
+			reg = <0x5000 0x1000>;
+			master = <&cluster1>;
+		};
+	};
+
+This CCI node corresponds to a CCI component whose control registers sits
+at address 0x000000002c090000.
+CCI slave interface @0x000000002c091000 maps to dma controller dma0.
+CCI slave interface @0x000000002c094000 maps to all CPUs contained in cluster0.
+CCI slave interface @0x000000002c095000 maps to all CPUs contained in cluster1.
+
+[1] Linux kernel documentation,
+	Documentation/devicetree/bindings/arm/topology.txt
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
index 0000000..81953de
--- /dev/null
+++ b/drivers/bus/arm-cci.c
@@ -0,0 +1,344 @@
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
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include <asm/cacheflush.h>
+#include <asm/dt_affinity.h>
+#include <asm/outercache.h>
+#include <asm/smp_plat.h>
+
+#define DRIVER_NAME		"CCI"
+#define CCI_CTRL_STATUS		0xc
+
+#define CCI_PORT_CTRL		0x0
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
+	int type;
+	union {
+		cpumask_t match_mask;
+		struct device_node *np;
+	} match;
+};
+
+static struct cci_ace_port *ports;
+static unsigned int nb_cci_ports;
+
+static void __iomem *cci_ctrl_base;
+#define INVALID_PORT_IDX	-1
+static int cpu_port[NR_CPUS] = { [0 ... NR_CPUS-1] = INVALID_PORT_IDX };
+
+static void __init cci_ace_init_ports(void)
+{
+	bool is_ace;
+	int port, cpu;
+	/*
+	 * Port index look-up speeds up the function disabling ports by CPU,
+	 * since the logical to port index mapping is done once and does
+	 * not change after system boot.
+	 * The stashed index array is initialized for all possible CPUs
+	 * at probe time.
+	 */
+	for_each_possible_cpu(cpu) {
+		for (port = 0; port < nb_cci_ports; port++) {
+			is_ace = ports[port].type == ACE_PORT;
+			if (is_ace && cpu_isset(cpu,
+					 ports[port].match.match_mask)) {
+				cpu_port[cpu] = port;
+				break;
+			}
+		}
+		WARN(cpu_port[cpu] == INVALID_PORT_IDX, "CPU %d has an invalid"
+							" CCI port index\n",
+							cpu);
+	}
+}
+
+/*
+ * cci_ace_lite_port - Function to retrieve the port index corresponding to
+ *		       a device tree node
+ *
+ * @np = device tree node to match
+ *
+ * Return value:
+ *	- ACE LITE port index if success
+ *	- -EINVAL if failure
+ *
+ */
+static int cci_ace_lite_port(struct device_node *np)
+{
+	int i;
+	bool is_ace_lite;
+
+	for (i = 0; i < nb_cci_ports; i++) {
+		is_ace_lite = ports[i].type == ACE_LITE_PORT;
+		if (is_ace_lite && np == ports[i].match.np)
+			return i;
+	}
+	return -ENODEV;
+}
+
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
+/*
+ * cci_port_control()
+ *	@port = index of the port to setup
+ *	@enable = if true enables the port, if false disables it
+ */
+static void notrace cci_port_control(unsigned int port, bool enable)
+{
+	void __iomem *base = ports[port].base;
+
+	if (!base)
+		return;
+
+	writel_relaxed(enable, base + CCI_PORT_CTRL);
+	while (readl_relaxed(cci_ctrl_base + CCI_CTRL_STATUS) & 0x1)
+			;
+}
+
+/*
+ * cci_disable_port_by_cpu()
+ *	@mpidr = mpidr of the CPU whose CCI port should be disabled
+ *	Returns:
+ *		0 on success
+ *		-ENODEV on port look-up failure
+ *
+ * Disabling a CCI port for a CPU implies disabling the CCI port
+ * controlling that CPU cluster. Code disabling CPU CCI ports
+ * must make sure that the CPU running the code is the last active CPU
+ * in the cluster ie all other CPUs are quiescent in a low power state.
+ */
+int notrace cci_disable_port_by_cpu(u64 mpidr)
+{
+	int cpu = get_logical_index(mpidr & MPIDR_HWID_BITMASK);
+
+	if (cpu < 0 || cpu_port[cpu] == INVALID_PORT_IDX)
+		return -ENODEV;
+	cci_port_control(cpu_port[cpu], false);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cci_disable_port_by_cpu);
+
+/*
+ * __cci_control_port_by_device()
+ *	@np = device_node of the device whose CCI port should be enabled
+ *	@enable = if true enables the port, if false disables it
+ *	Returns:
+ *		0 on success
+ *		-ENODEV on port look-up failure
+ */
+int notrace __cci_control_port_by_device(struct device_node *np, bool enable)
+{
+	int port = cci_ace_lite_port(np);
+	if (WARN_ONCE(port < 0,
+		      "ACE lite port look-up failure, node %p\n", np))
+		return -ENODEV;
+	cci_port_control(port, enable);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(__cci_control_port_by_device);
+
+static const struct of_device_id arm_cci_matches[];
+
+static int __init cci_driver_probe(struct platform_device *pdev)
+{
+	const struct of_device_id *match;
+	struct cci_nb_ports const *cci_config;
+	int ret, j, i, nb_ace = 0, nb_ace_lite = 0;
+	struct device_node *np, *cp;
+	const char *match_str;
+
+	match = of_match_device(arm_cci_matches, &pdev->dev);
+
+	if (!match)
+		return -ENODEV;
+
+	cci_config = (struct cci_nb_ports const *)match->data;
+	nb_cci_ports = cci_config->nb_ace + cci_config->nb_ace_lite;
+	ports = kzalloc(sizeof(*ports) * nb_cci_ports, GFP_KERNEL);
+	if (!ports)
+		return -ENOMEM;
+
+	np = pdev->dev.of_node;
+	cci_ctrl_base = of_iomap(np, 0);
+
+	if (!cci_ctrl_base) {
+		dev_err(&pdev->dev, "unable to ioremap CCI ctrl\n");
+		ret = -ENXIO;
+		goto memalloc_err;
+	}
+	for_each_child_of_node(np, cp) {
+		i = nb_ace + nb_ace_lite;
+
+		if (i >= nb_cci_ports)
+			break;
+
+		if (of_property_read_string(cp, "interface-type",
+					    &match_str)) {
+			WARN(1, " * %s missing interface-type property\n",
+				  cp->full_name);
+			continue;
+		}
+
+		/*
+		 * A CCI interface has to define a "master" affinity
+		 * property otherwise it is not considered valid
+		 */
+		if (!strcmp(match_str, "ace")) {
+			if (WARN_ON(nb_ace >= cci_config->nb_ace))
+				continue;
+			cpumask_clear(&ports[i].match.match_mask);
+			if (arm_dt_affine_get_mask(cp, "master", 0,
+					&ports[i].match.match_mask))
+				continue;
+			ports[i].type = ACE_PORT;
+			++nb_ace;
+		} else if (!strcmp(match_str, "ace-lite")) {
+			if (WARN_ON(nb_ace_lite >= cci_config->nb_ace_lite))
+				continue;
+
+			ports[i].match.np =
+				of_parse_phandle(cp, "master", 0);
+
+			if (!ports[i].match.np)
+				continue;
+			of_node_put(ports[i].match.np);
+			ports[i].type = ACE_LITE_PORT;
+			++nb_ace_lite;
+		} else {
+			WARN(1, " * %s containing invalid interface-type"
+				" property, skipping it\n", cp->full_name);
+			continue;
+		}
+
+		ports[i].base = of_iomap(cp, 0);
+
+		if (!ports[i].base) {
+			dev_err(&pdev->dev, "unable to ioremap "
+					    "ace port %d\n", i);
+			ret = -ENXIO;
+			goto ioremap_err;
+		}
+	}
+	cci_ace_init_ports();
+	/*
+	 * Multi-cluster systems may need this data when non-coherent, during
+	 * cluster power-up/power-down. Make sure it reaches main memory:
+	 */
+	__cpuc_flush_dcache_area(ports, sizeof(*ports) * nb_cci_ports);
+	__cpuc_flush_dcache_area(&cci_ctrl_base, sizeof cci_ctrl_base);
+	__cpuc_flush_dcache_area(cpu_port, sizeof cpu_port);
+	outer_clean_range(virt_to_phys(ports),
+			  virt_to_phys(ports + nb_cci_ports));
+	outer_clean_range(virt_to_phys(&cci_ctrl_base),
+			  virt_to_phys(&cci_ctrl_base + 1));
+	outer_clean_range(virt_to_phys(cpu_port),
+			  virt_to_phys(cpu_port + NR_CPUS));
+	dev_info(&pdev->dev, "ARM CCI driver probed\n");
+	return 0;
+
+ioremap_err:
+	for (j = 0; j < nb_cci_ports; j++) {
+		if (j == i)
+			break;
+		iounmap(ports[j].base);
+	}
+
+	iounmap(cci_ctrl_base);
+memalloc_err:
+
+	kfree(ports);
+	return ret;
+}
+
+static int __exit cci_driver_remove(struct platform_device *pdev)
+{
+	int i;
+
+	for (i = 0; i < nb_cci_ports; i++)
+		if (ports[i].base)
+			iounmap(ports[i].base);
+
+	iounmap(cci_ctrl_base);
+	kfree(ports);
+	return 0;
+}
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
+static struct platform_driver cci_platform_driver = {
+	.driver = {
+		   .owner = THIS_MODULE,
+		   .name = DRIVER_NAME,
+		   .of_match_table = arm_cci_matches,
+		   },
+	.probe = cci_driver_probe,
+	.remove = cci_driver_remove,
+};
+
+static int __init cci_init(void)
+{
+	return platform_driver_register(&cci_platform_driver);
+}
+
+static void __exit cci_exit(void)
+{
+	platform_driver_unregister(&cci_platform_driver);
+}
+
+core_initcall(cci_init);
+module_exit(cci_exit);
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("ARM CCI support");
diff --git a/include/linux/arm-cci.h b/include/linux/arm-cci.h
new file mode 100644
index 0000000..e9514a2
--- /dev/null
+++ b/include/linux/arm-cci.h
@@ -0,0 +1,44 @@
+/*
+ * CCI cache coherent interconnect support
+ *
+ * Copyright (C) 2012 ARM Ltd.
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
+#include <linux/of.h>
+#include <linux/types.h>
+
+#ifdef CONFIG_ARM_CCI
+extern int cci_disable_port_by_cpu(u64 mpidr);
+extern int __cci_control_port_by_device(struct device_node *np, bool enable);
+#else
+static inline int cci_disable_port_by_cpu(u64 mpidr) { return -ENODEV; }
+static inline int __cci_control_port_by_device(struct device_node *np,
+						bool enable)
+{
+	return -ENODEV;
+}
+#endif
+#define cci_disable_port_by_device(node) \
+	__cci_control_port_by_device(node, false)
+#define cci_enable_port_by_device(node) \
+	__cci_control_port_by_device(node, true)
+
+#endif
-- 
1.7.12
