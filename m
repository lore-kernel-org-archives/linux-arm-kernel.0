From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 17 Jul 2013 23:28:34 -0400
Subject: [PATCH 2/4] drivers/platform: vexpress: add Serial Power Controller
 (SPC) support
In-Reply-To: <1374118116-16836-1-git-send-email-nicolas.pitre@linaro.org>
References: <1374118116-16836-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1374118116-16836-3-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

The TC2 versatile express core tile integrates a logic block that provides
the interface between the dual cluster test-chip and the M3 microcontroller
that carries out power management. The logic block, called Serial Power
Controller (SPC), contains several memory mapped registers to control among
other things low-power states, wake-up irqs and per-CPU jump addresses
registers.

This patch provides a driver that enables run-time control of features
implemented by the SPC power management control logic with an API to
be used by different subsystem drivers on top.

The SPC control logic is required to be programmed very early in the boot
process to reset secondary CPUs on the TC2 testchip, set-up jump addresses
and wake-up IRQs for power management. Hence, waiting for core changes to
be made in the device core code to enable early registration of platform
devices, the driver puts in place an early init scheme that allows kernel
drivers to initialize the SPC driver directly from the components requiring
it, if their initialization routine is called before this driver init
function during the boot process.

Device tree bindings documentation for the SPC component is also provided.

Cc: Olof Johansson <olof@lixom.net>
Cc: Amit Kucheria <amit.kucheria@linaro.org>
Cc: Jon Medhurst <tixy@linaro.org>
Signed-off-by: Achin Gupta <achin.gupta@arm.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Acked-by: Pawel Moll <pawel.moll@arm.com>
[ np: moved from drivers/mfd/ to drivers/platform/vexpress/ ]
Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 .../devicetree/bindings/arm/vexpress-spc.txt       |  36 +++
 drivers/platform/Kconfig                           |   4 +-
 drivers/platform/Makefile                          |   1 +
 drivers/platform/vexpress/Kconfig                  |   9 +
 drivers/platform/vexpress/Makefile                 |   1 +
 drivers/platform/vexpress/spc.c                    | 253 +++++++++++++++++++++
 include/linux/vexpress.h                           |  17 ++
 7 files changed, 320 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/arm/vexpress-spc.txt
 create mode 100644 drivers/platform/vexpress/Kconfig
 create mode 100644 drivers/platform/vexpress/Makefile
 create mode 100644 drivers/platform/vexpress/spc.c

diff --git a/Documentation/devicetree/bindings/arm/vexpress-spc.txt b/Documentation/devicetree/bindings/arm/vexpress-spc.txt
new file mode 100644
index 0000000000..1614725918
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/vexpress-spc.txt
@@ -0,0 +1,36 @@
+* ARM Versatile Express Serial Power Controller device tree bindings
+
+Latest ARM development boards implement a power management interface (serial
+power controller - SPC) that is capable of managing power states transitions,
+wake-up IRQs and resume addresses for ARM multiprocessor testchips.
+The serial controller can be programmed through a memory mapped interface
+that enables communication between firmware running on the microcontroller
+managing power states and the application processors.
+
+The SPC DT bindings are defined as follows:
+
+- spc node
+
+	- compatible:
+		Usage: required
+		Value type: <stringlist>
+		Definition: must be
+			    "arm,vexpress-spc,v2p-ca15_a7", "arm,vexpress-spc"
+	- reg:
+		Usage: required
+		Value type: <prop-encode-array>
+		Definition: A standard property that specifies the base address
+			    and the size of the SPC address space
+	- interrupts:
+		Usage: required
+		Value type: <prop-encoded-array>
+		Definition:  SPC interrupt configuration. A standard property
+			     that follows ePAPR interrupts specifications
+
+Example:
+
+spc: spc at 7fff0000 {
+	compatible = "arm,vexpress-spc,v2p-ca15_a7", "arm,vexpress-spc";
+	reg = <0x7fff0000 0x1000>;
+	interrupts = <0 95 4>;
+};
diff --git a/drivers/platform/Kconfig b/drivers/platform/Kconfig
index 69616aeaa9..449010e828 100644
--- a/drivers/platform/Kconfig
+++ b/drivers/platform/Kconfig
@@ -4,4 +4,6 @@ endif
 if GOLDFISH
 source "drivers/platform/goldfish/Kconfig"
 endif
-
+if ARCH_VEXPRESS
+source "drivers/platform/vexpress/Kconfig"
+endif
diff --git a/drivers/platform/Makefile b/drivers/platform/Makefile
index 8a44a4cd6d..c1173d6e15 100644
--- a/drivers/platform/Makefile
+++ b/drivers/platform/Makefile
@@ -5,3 +5,4 @@
 obj-$(CONFIG_X86)		+= x86/
 obj-$(CONFIG_OLPC)		+= olpc/
 obj-$(CONFIG_GOLDFISH)		+= goldfish/
+obj-$(CONFIG_ARCH_VEXPRESS)	+= vexpress/
diff --git a/drivers/platform/vexpress/Kconfig b/drivers/platform/vexpress/Kconfig
new file mode 100644
index 0000000000..d09a7c45bd
--- /dev/null
+++ b/drivers/platform/vexpress/Kconfig
@@ -0,0 +1,9 @@
+config VEXPRESS_SPC
+	bool "Versatile Express SPC driver support"
+	help
+	  The Serial Power Controller (SPC) for ARM Ltd. test chips, is
+	  an IP that provides a memory mapped interface to power controller
+	  HW. The driver provides an API abstraction meant to be used by
+	  subsystem drivers allowing to program registers controlling
+	  low-level power management features like power down flags,
+	  global and per-cpu wake-up IRQs.
diff --git a/drivers/platform/vexpress/Makefile b/drivers/platform/vexpress/Makefile
new file mode 100644
index 0000000000..d31eca24f4
--- /dev/null
+++ b/drivers/platform/vexpress/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_VEXPRESS_SPC)	+= spc.o
diff --git a/drivers/platform/vexpress/spc.c b/drivers/platform/vexpress/spc.c
new file mode 100644
index 0000000000..aa8c2a4862
--- /dev/null
+++ b/drivers/platform/vexpress/spc.c
@@ -0,0 +1,253 @@
+/*
+ * Versatile Express Serial Power Controller (SPC) support
+ *
+ * Copyright (C) 2013 ARM Ltd.
+ *
+ * Authors: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
+ *          Achin Gupta           <achin.gupta@arm.com>
+ *          Lorenzo Pieralisi     <lorenzo.pieralisi@arm.com>
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
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/of_address.h>
+#include <linux/slab.h>
+#include <linux/vexpress.h>
+
+#include <asm/cacheflush.h>
+
+#define SPCLOG "vexpress-spc: "
+
+/* SCC conf registers */
+#define A15_CONF		0x400
+#define SYS_INFO		0x700
+
+/* SPC registers base */
+#define SPC_BASE		0xB00
+
+/* SPC wake-up IRQs status and mask */
+#define WAKE_INT_MASK		(SPC_BASE + 0x24)
+#define WAKE_INT_RAW		(SPC_BASE + 0x28)
+#define WAKE_INT_STAT		(SPC_BASE + 0x2c)
+/* SPC power down registers */
+#define A15_PWRDN_EN		(SPC_BASE + 0x30)
+#define A7_PWRDN_EN		(SPC_BASE + 0x34)
+/* SPC per-CPU mailboxes */
+#define A15_BX_ADDR0		(SPC_BASE + 0x68)
+#define A7_BX_ADDR0		(SPC_BASE + 0x78)
+
+/* wake-up interrupt masks */
+#define GBL_WAKEUP_INT_MSK	(0x3 << 10)
+
+/* TC2 static dual-cluster configuration */
+#define MAX_CLUSTERS		2
+
+struct ve_spc_drvdata {
+	void __iomem *baseaddr;
+	/*
+	 * A15s cluster identifier
+	 * It corresponds to A15 processors MPIDR[15:8] bitfield
+	 */
+	u32 a15_clusid;
+};
+
+static struct ve_spc_drvdata *info;
+
+static inline bool cluster_is_a15(u32 cluster)
+{
+	return cluster == info->a15_clusid;
+}
+
+/**
+ * ve_spc_global_wakeup_irq()
+ *
+ * Function to set/clear global wakeup IRQs. Not protected by locking since
+ * it might be used in code paths where normal cacheable locks are not
+ * working. Locking must be provided by the caller to ensure atomicity.
+ *
+ * @set: if true, global wake-up IRQs are set, if false they are cleared
+ */
+void ve_spc_global_wakeup_irq(bool set)
+{
+	u32 reg;
+
+	reg = readl_relaxed(info->baseaddr + WAKE_INT_MASK);
+
+	if (set)
+		reg |= GBL_WAKEUP_INT_MSK;
+	else
+		reg &= ~GBL_WAKEUP_INT_MSK;
+
+	writel_relaxed(reg, info->baseaddr + WAKE_INT_MASK);
+}
+
+/**
+ * ve_spc_cpu_wakeup_irq()
+ *
+ * Function to set/clear per-CPU wake-up IRQs. Not protected by locking since
+ * it might be used in code paths where normal cacheable locks are not
+ * working. Locking must be provided by the caller to ensure atomicity.
+ *
+ * @cluster: mpidr[15:8] bitfield describing cluster affinity level
+ * @cpu: mpidr[7:0] bitfield describing cpu affinity level
+ * @set: if true, wake-up IRQs are set, if false they are cleared
+ */
+void ve_spc_cpu_wakeup_irq(u32 cluster, u32 cpu, bool set)
+{
+	u32 mask, reg;
+
+	if (cluster >= MAX_CLUSTERS)
+		return;
+
+	mask = 1 << cpu;
+
+	if (!cluster_is_a15(cluster))
+		mask <<= 4;
+
+	reg = readl_relaxed(info->baseaddr + WAKE_INT_MASK);
+
+	if (set)
+		reg |= mask;
+	else
+		reg &= ~mask;
+
+	writel_relaxed(reg, info->baseaddr + WAKE_INT_MASK);
+}
+
+/**
+ * ve_spc_set_resume_addr() - set the jump address used for warm boot
+ *
+ * @cluster: mpidr[15:8] bitfield describing cluster affinity level
+ * @cpu: mpidr[7:0] bitfield describing cpu affinity level
+ * @addr: physical resume address
+ */
+void ve_spc_set_resume_addr(u32 cluster, u32 cpu, u32 addr)
+{
+	void __iomem *baseaddr;
+
+	if (cluster >= MAX_CLUSTERS)
+		return;
+
+	if (cluster_is_a15(cluster))
+		baseaddr = info->baseaddr + A15_BX_ADDR0 + (cpu << 2);
+	else
+		baseaddr = info->baseaddr + A7_BX_ADDR0 + (cpu << 2);
+
+	writel_relaxed(addr, baseaddr);
+}
+
+/**
+ * ve_spc_get_nr_cpus() - get number of cpus in a cluster
+ *
+ * @cluster: mpidr[15:8] bitfield describing cluster affinity level
+ *
+ * Return: > 0 number of cpus in the cluster
+ *         or 0 if cluster number invalid
+ */
+u32 ve_spc_get_nr_cpus(u32 cluster)
+{
+	u32 val;
+
+	if (cluster >= MAX_CLUSTERS)
+		return 0;
+
+	val = readl_relaxed(info->baseaddr + SYS_INFO);
+	val = cluster_is_a15(cluster) ? (val >> 16) : (val >> 20);
+	return val & 0xf;
+}
+
+/**
+ * ve_spc_powerdown()
+ *
+ * Function to enable/disable cluster powerdown. Not protected by locking
+ * since it might be used in code paths where normal cacheable locks are not
+ * working. Locking must be provided by the caller to ensure atomicity.
+ *
+ * @cluster: mpidr[15:8] bitfield describing cluster affinity level
+ * @enable: if true enables powerdown, if false disables it
+ */
+void ve_spc_powerdown(u32 cluster, bool enable)
+{
+	u32 pwdrn_reg;
+
+	if (cluster >= MAX_CLUSTERS)
+		return;
+
+	pwdrn_reg = cluster_is_a15(cluster) ? A15_PWRDN_EN : A7_PWRDN_EN;
+	writel_relaxed(enable, info->baseaddr + pwdrn_reg);
+}
+
+static const struct of_device_id ve_spc_ids[] __initconst = {
+	{ .compatible = "arm,vexpress-spc,v2p-ca15_a7" },
+	{ .compatible = "arm,vexpress-spc" },
+	{},
+};
+
+static int __init ve_spc_probe(void)
+{
+	int ret;
+	struct device_node *node = of_find_matching_node(NULL, ve_spc_ids);
+
+	if (!node)
+		return -ENODEV;
+
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (!info) {
+		pr_err(SPCLOG "unable to allocate mem\n");
+		return -ENOMEM;
+	}
+
+	info->baseaddr = of_iomap(node, 0);
+	if (!info->baseaddr) {
+		pr_err(SPCLOG "unable to ioremap memory\n");
+		ret = -ENXIO;
+		goto mem_free;
+	}
+
+	info->a15_clusid = readl_relaxed(info->baseaddr + A15_CONF) & 0xf;
+
+	/*
+	 * Multi-cluster systems may need this data when non-coherent, during
+	 * cluster power-up/power-down. Make sure driver info reaches main
+	 * memory.
+	 */
+	sync_cache_w(info);
+	sync_cache_w(&info);
+	pr_info("vexpress-spc loaded at %p\n", info->baseaddr);
+	return 0;
+
+mem_free:
+	kfree(info);
+	return ret;
+}
+
+/**
+ * ve_spc_init()
+ *
+ * Function exported to manage pre early_initcall initialization.
+ * SPC code is needed very early in the boot process to bring CPUs out of
+ * reset and initialize power management back-end so an init interface is
+ * provided to platform code to allow early initialization. The init
+ * interface can be removed as soon as the DT layer and platform bus allow
+ * platform device creation and probing before SMP boot.
+ */
+int __init ve_spc_init(void)
+{
+	static int ve_spc_init_status __initdata = -EAGAIN;
+
+	if (ve_spc_init_status == -EAGAIN)
+		ve_spc_init_status = ve_spc_probe();
+
+	return ve_spc_init_status;
+}
+early_initcall(ve_spc_init);
diff --git a/include/linux/vexpress.h b/include/linux/vexpress.h
index 617c01b8f7..3e35556b22 100644
--- a/include/linux/vexpress.h
+++ b/include/linux/vexpress.h
@@ -124,4 +124,21 @@ void vexpress_osc_of_setup(struct device_node *node);
 void vexpress_clk_init(void __iomem *sp810_base);
 void vexpress_clk_of_init(void);
 
+/* SPC */
+
+#ifdef CONFIG_VEXPRESS_SPC
+int __init ve_spc_init(void);
+void ve_spc_global_wakeup_irq(bool set);
+void ve_spc_cpu_wakeup_irq(u32 cluster, u32 cpu, bool set);
+void ve_spc_set_resume_addr(u32 cluster, u32 cpu, u32 addr);
+u32 ve_spc_get_nr_cpus(u32 cluster);
+void ve_spc_powerdown(u32 cluster, bool enable);
+#else
+static inline int ve_spc_init(void) { return -ENODEV; }
+static inline void ve_spc_global_wakeup_irq(bool set) { }
+static inline void ve_spc_cpu_wakeup_irq(u32 cluster, u32 cpu, bool set) { }
+static inline void ve_spc_set_resume_addr(u32 cluster, u32 cpu, u32 addr) { }
+static inline u32 ve_spc_get_nr_cpus(u32 cluster) { return 0; }
+static inline void ve_spc_powerdown(u32 cluster, bool enable) { }
+#endif
 #endif
-- 
1.8.1.2
