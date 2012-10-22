From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 22 Oct 2012 19:02:47 +0200
Subject: [PATCH 5/5] arm: mvebu: Added SMP support for Armada XP
In-Reply-To: <1350925368-24243-1-git-send-email-gregory.clement@free-electrons.com>
References: <1350925368-24243-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1350925368-24243-6-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yehuda Yitschak <yehuday@marvell.com>

1. added smp init functions in platsmp.c
2. added secondary cpu entry point in headsmp.S
3. added hotplog initial support in hotplug.c
4. added SMP support for PJ4B cpu

Signed-off-by: Yehuda Yitschak <yehuday@marvell.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-xp.dtsi    |    4 ++
 arch/arm/configs/mvebu_defconfig    |    3 +
 arch/arm/mach-mvebu/Kconfig         |    1 +
 arch/arm/mach-mvebu/Makefile        |    2 +
 arch/arm/mach-mvebu/armada-370-xp.c |    1 +
 arch/arm/mach-mvebu/common.h        |    3 +
 arch/arm/mach-mvebu/headsmp.S       |   65 ++++++++++++++++++
 arch/arm/mach-mvebu/hotplug.c       |   30 +++++++++
 arch/arm/mach-mvebu/platsmp.c       |  123 +++++++++++++++++++++++++++++++++++
 arch/arm/mm/proc-v7.S               |    3 +
 10 files changed, 235 insertions(+)
 create mode 100644 arch/arm/mach-mvebu/headsmp.S
 create mode 100644 arch/arm/mach-mvebu/hotplug.c
 create mode 100644 arch/arm/mach-mvebu/platsmp.c

diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index 531619f..7f968dc 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -38,24 +38,28 @@
 	    #size-cells = <0>;
 
 	    cpu at 0 {
+		device_type = "cpu";
 	       	compatible = "marvell,sheeva-v7";
 		reg = <0>;
 		clocks = <&cpuclk 0>;
 	    };
 
 	    cpu at 1 {
+		device_type = "cpu";
 		compatible = "marvell,sheeva-v7";
 		reg = <1>;
 		clocks = <&cpuclk 1>;
 	    };
 
 	    cpu at 2 {
+		device_type = "cpu";
 		compatible = "marvell,sheeva-v7";
 		reg = <2>;
 		clocks = <&cpuclk 2>;
 	    };
 
 	    cpu at 3 {
+		device_type = "cpu";
 		compatible = "marvell,sheeva-v7";
 		reg = <3>;
 		clocks = <&cpuclk 3>;
diff --git a/arch/arm/configs/mvebu_defconfig b/arch/arm/configs/mvebu_defconfig
index 7bcf850..c0590c6 100644
--- a/arch/arm/configs/mvebu_defconfig
+++ b/arch/arm/configs/mvebu_defconfig
@@ -10,6 +10,9 @@ CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_ARCH_MVEBU=y
 CONFIG_MACH_ARMADA_370_XP=y
+# CONFIG_SWP_EMULATE is not set
+CONFIG_SMP=y
+# CONFIG_LOCAL_TIMERS is not set
 CONFIG_AEABI=y
 CONFIG_HIGHMEM=y
 CONFIG_USE_OF=y
diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
index 9bfaa0c..d70afe3 100644
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -22,6 +22,7 @@ config MVEBU_CLK_CPU
 config MACH_ARMADA_370_XP
 	bool
 	select ARMADA_370_XP_TIMER
+	select HAVE_SMP
 	select CPU_PJ4B
 
 config MACH_ARMADA_370
diff --git a/arch/arm/mach-mvebu/Makefile b/arch/arm/mach-mvebu/Makefile
index 8e6e50b..eb3cbd1 100644
--- a/arch/arm/mach-mvebu/Makefile
+++ b/arch/arm/mach-mvebu/Makefile
@@ -3,3 +3,5 @@ ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include \
 
 obj-y += system-controller.o
 obj-$(CONFIG_MACH_ARMADA_370_XP) += armada-370-xp.o irq-armada-370-xp.o addr-map.o coherency.o pmsu.o
+obj-$(CONFIG_SMP)                += platsmp.o headsmp.o
+obj-$(CONFIG_HOTPLUG_CPU)        += hotplug.o
diff --git a/arch/arm/mach-mvebu/armada-370-xp.c b/arch/arm/mach-mvebu/armada-370-xp.c
index 2af6ce5..41431a1 100644
--- a/arch/arm/mach-mvebu/armada-370-xp.c
+++ b/arch/arm/mach-mvebu/armada-370-xp.c
@@ -59,6 +59,7 @@ static const char * const armada_370_xp_dt_board_dt_compat[] = {
 };
 
 DT_MACHINE_START(ARMADA_XP_DT, "Marvell Aramada 370/XP (Device Tree)")
+	.smp		= smp_ops(armada_xp_smp_ops),
 	.init_machine	= armada_370_xp_dt_init,
 	.map_io		= armada_370_xp_map_io,
 	.init_irq	= armada_370_xp_init_irq,
diff --git a/arch/arm/mach-mvebu/common.h b/arch/arm/mach-mvebu/common.h
index 74ee0b2..86484bb 100644
--- a/arch/arm/mach-mvebu/common.h
+++ b/arch/arm/mach-mvebu/common.h
@@ -21,7 +21,10 @@ void mvebu_clocks_init(void);
 void armada_370_xp_init_irq(void);
 void armada_370_xp_handle_irq(struct pt_regs *regs);
 
+void armada_xp_cpu_die(unsigned int cpu);
 
 int armada_370_xp_coherency_init(void);
 int armada_370_xp_pmsu_init(void);
+void armada_xp_secondary_startup(void);
+extern struct smp_operations armada_xp_smp_ops;
 #endif
diff --git a/arch/arm/mach-mvebu/headsmp.S b/arch/arm/mach-mvebu/headsmp.S
new file mode 100644
index 0000000..13187f8
--- /dev/null
+++ b/arch/arm/mach-mvebu/headsmp.S
@@ -0,0 +1,65 @@
+/*
+ * SMP support: Entry point for secondary CPUs
+ *
+ * Copyright (C) 2012 Marvell
+ *
+ * Yehuda Yitschak <yehuday@marvell.com>
+ * Gregory CLEMENT <gregory.clement@free-electrons.com>
+ * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ *
+ * This file implements the assembly entry point for secondary CPUs
+ * in an SMP kernel. The only thing we need to do is to add the CPU
+ * to the coherency fabric by writing to 2 registers. Currently these
+ * register addresses are hard coded due to the early initialisation problems.
+ */
+
+#include <linux/linkage.h>
+#include <linux/init.h>
+
+/*
+ * At this stage the secondary CPUs don't have acces yet to the MMU, so
+ * we have to provide physical addresses
+ */
+#define ARMADA_XP_COHERENCY_FABRIC_CTL_REG 0xD0020200
+#define ARMADA_XP_COHERENCY_FABRIC_CFG_REG 0xD0020204
+
+	__INIT
+
+/*
+ * Armada XP specific entry point for secondary CPUs.
+ * We add the CPU to the coherency fabric and then jump to secondary startup
+ */
+
+ENTRY(armada_xp_secondary_startup)
+
+	/* Read CPU id */
+ 	mrc     p15, 0, r1, c0, c0, 5
+	and     r1, r1, #0xF
+
+	/* Add CPU to coherency fabric */
+
+	/* Create bit by cpu index */
+	mov     r2,r1
+	add     r2,r2,#24
+	MOV     r3, #1
+	lsl     r3, r3, r2
+
+	/* Add CPU to SMP group - Atomic */
+	ldr     r0, = ARMADA_XP_COHERENCY_FABRIC_CTL_REG
+	ldr     r10, [r0]
+	orr     r10 , r10, r3
+	str	r10,[r0]
+
+	/* Enable coherency on CPU - Atomic*/
+	ldr     r0, = ARMADA_XP_COHERENCY_FABRIC_CFG_REG
+	ldr     r10, [r0]
+	orr     r10 , r10, r3
+	str     r10,[r0]
+
+	b	secondary_startup
+
+ENDPROC(armada_xp_secondary_startup)
diff --git a/arch/arm/mach-mvebu/hotplug.c b/arch/arm/mach-mvebu/hotplug.c
new file mode 100644
index 0000000..b228b6a
--- /dev/null
+++ b/arch/arm/mach-mvebu/hotplug.c
@@ -0,0 +1,30 @@
+/*
+ * Symmetric Multi Processing (SMP) support for Armada XP
+ *
+ * Copyright (C) 2012 Marvell
+ *
+ * Lior Amsalem <alior@marvell.com>
+ * Gregory CLEMENT <gregory.clement@free-electrons.com>
+ * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/smp.h>
+#include <asm/proc-fns.h>
+
+/*
+ * platform-specific code to shutdown a CPU
+ *
+ * Called with IRQs disabled
+ */
+void __ref armada_xp_cpu_die(unsigned int cpu)
+{
+	cpu_do_idle();
+
+	/* We should never return from idle */
+	panic("mvebu: cpu %d unexpectedly exit from shutdown\n", cpu);
+}
diff --git a/arch/arm/mach-mvebu/platsmp.c b/arch/arm/mach-mvebu/platsmp.c
new file mode 100644
index 0000000..ef278a2
--- /dev/null
+++ b/arch/arm/mach-mvebu/platsmp.c
@@ -0,0 +1,123 @@
+/*
+ * Symmetric Multi Processing (SMP) support for Armada XP
+ *
+ * Copyright (C) 2012 Marvell
+ *
+ * Lior Amsalem <alior@marvell.com>
+ * Yehuda Yitschak <yehuday@marvell.com>
+ * Gregory CLEMENT <gregory.clement@free-electrons.com>
+ * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ *
+ * The Armada XP SoC has 4 ARMv7 PJ4B CPUs running in full HW coherency
+ * This file implements the routines for preparing the SMP infrastructure
+ * and waking up the secondary CPUs
+ */
+
+#include <linux/init.h>
+#include <linux/smp.h>
+#include <linux/clk.h>
+#include <linux/of.h>
+#include <asm/cacheflush.h>
+#include <asm/smp_plat.h>
+#include "common.h"
+#include "armada-370-xp.h"
+#include "pmsu.h"
+#include "coherency.h"
+
+void __init set_secondary_cpus_clock(void)
+{
+	int cpu;
+	unsigned long rate;
+	struct clk *cpu_clk = NULL;
+	struct device_node *np = NULL;
+
+	cpu = smp_processor_id();
+	np = of_find_node_by_type(np, "cpu");
+	np = NULL;
+	while ((np = of_find_node_by_type(np, "cpu"))) {
+		const u32 *reg;
+		int len;
+		reg = of_get_property(np, "reg", &len);
+		if (!reg || len != 4) {
+			pr_err("%s missing reg property\n", np->full_name);
+			continue;
+		}
+		if (be32_to_cpup(reg) == cpu) {
+			cpu_clk = of_clk_get(np, 0);
+			break;
+		}
+	}
+	WARN_ON(IS_ERR(cpu_clk));
+	rate = clk_get_rate(cpu_clk);
+
+	/* set all the other CPU clk to the same rate than the boot CPU */
+	np = NULL;
+	while ((np = of_find_node_by_type(np, "cpu"))) {
+		const u32 *reg;
+		int len;
+		reg = of_get_property(np, "reg", &len);
+		if (!reg || len != 4) {
+			pr_err("%s missing reg property\n", np->full_name);
+			continue;
+		}
+		if (be32_to_cpup(reg) != cpu) {
+			cpu_clk = of_clk_get(np, 0);
+			clk_set_rate(cpu_clk, rate);
+		}
+	}
+}
+
+static void __cpuinit armada_xp_secondary_init(unsigned int cpu)
+{
+	armada_xp_mpic_smp_cpu_init();
+}
+
+static int __cpuinit armada_xp_boot_secondary(unsigned int cpu,
+					      struct task_struct *idle)
+{
+	pr_info("Booting CPU %d\n", cpu);
+
+	armada_xp_boot_cpu(cpu, armada_xp_secondary_startup);
+
+	return 0;
+}
+
+static void __init armada_xp_smp_init_cpus(void)
+{
+	unsigned int i, ncores;
+	ncores = armada_xp_get_cpu_count();
+
+	/* Limit possbile CPUs to defconfig */
+	if (ncores > nr_cpu_ids) {
+		pr_warn("SMP: %d CPUs physically present. Only %d configured.",
+			ncores, nr_cpu_ids);
+		pr_warn("Clipping CPU count to %d\n", nr_cpu_ids);
+		ncores = nr_cpu_ids;
+	}
+
+	for (i = 0; i < ncores; i++)
+		set_cpu_possible(i, true);
+
+	set_smp_cross_call(armada_mpic_send_doorbell);
+}
+
+void __init armada_xp_smp_prepare_cpus(unsigned int max_cpus)
+{
+	set_secondary_cpus_clock();
+	flush_cache_all();
+	armada_370_xp_set_cpu_coherent(cpu_logical_map(smp_processor_id()), 0);
+}
+
+struct smp_operations armada_xp_smp_ops __initdata = {
+	.smp_init_cpus		= armada_xp_smp_init_cpus,
+	.smp_prepare_cpus	= armada_xp_smp_prepare_cpus,
+	.smp_secondary_init	= armada_xp_secondary_init,
+	.smp_boot_secondary	= armada_xp_boot_secondary,
+#ifdef CONFIG_HOTPLUG_CPU
+	.cpu_die		= armada_xp_cpu_die,
+#endif
+};
diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 1a373c2..4add2c4 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -191,6 +191,9 @@ __v7_pj4b_setup:
 
 	/* Auxiliary Functional Modes Control Register 0 */
 	mrc	p15, 1,	r0, c15, c2, 0
+#ifdef CONFIG_SMP
+	orr	r0, r0, #(1 << 1)     @ Set SMP mode. Join the coherncy fabric
+#endif
 	orr	r0, r0, #(1 << 2)     @ Support L1 parity checking
 	orr	r0, r0, #(1 << 8)     @ Broadcast Cache and TLB maintenance
 	mcr	p15, 1,	r0, c15, c2, 0
-- 
1.7.9.5
