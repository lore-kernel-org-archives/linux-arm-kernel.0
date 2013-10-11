From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 11 Oct 2013 19:24:02 +0100
Subject: [PATCHv4 2/6] arm64: reorganise smp_enable_ops
In-Reply-To: <1381515846-1684-1-git-send-email-mark.rutland@arm.com>
References: <1381515846-1684-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1381515846-1684-3-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For hotplug support, we're going to want a place to store operations
that do more than bring CPUs online, and it makes sense to group these
with our current smp_enable_ops. For cpuidle support, we'll want to
group additional functions, and we may want them even for UP kernels.

This patch renames smp_enable_ops to the more general cpu_operations,
and pulls the definitions out of smp code such that they can be used in
UP kernels. While we're at it, fix up instances of the cpu parameter to
be an unsigned int, drop the init markings and rename the *_cpu
functions to cpu_* to reduce future churn when cpu_operations is
extended.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/include/asm/cpu_ops.h   | 33 ++++++++++++++++++++++++++
 arch/arm64/include/asm/smp.h       | 11 ---------
 arch/arm64/kernel/Makefile         |  2 +-
 arch/arm64/kernel/cpu_ops.c        | 47 ++++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/psci.c           | 11 +++++----
 arch/arm64/kernel/smp.c            | 39 ++++++++-----------------------
 arch/arm64/kernel/smp_spin_table.c | 11 +++++----
 7 files changed, 102 insertions(+), 52 deletions(-)
 create mode 100644 arch/arm64/include/asm/cpu_ops.h
 create mode 100644 arch/arm64/kernel/cpu_ops.c

diff --git a/arch/arm64/include/asm/cpu_ops.h b/arch/arm64/include/asm/cpu_ops.h
new file mode 100644
index 0000000..3c60c8d
--- /dev/null
+++ b/arch/arm64/include/asm/cpu_ops.h
@@ -0,0 +1,33 @@
+/*
+ * Copyright (C) 2013 ARM Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#ifndef __ASM_CPU_OPS_H
+#define __ASM_CPU_OPS_H
+
+#include <linux/init.h>
+#include <linux/threads.h>
+
+struct device_node;
+
+struct cpu_operations {
+	const char	*name;
+	int		(*cpu_init)(struct device_node *, unsigned int);
+	int		(*cpu_prepare)(unsigned int);
+};
+
+extern const struct cpu_operations *cpu_ops[NR_CPUS];
+extern const struct cpu_operations * __init cpu_get_ops(const char *name);
+
+#endif /* ifndef __ASM_CPU_OPS_H */
diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
index 4b8023c..7e34295 100644
--- a/arch/arm64/include/asm/smp.h
+++ b/arch/arm64/include/asm/smp.h
@@ -66,15 +66,4 @@ extern volatile unsigned long secondary_holding_pen_release;
 extern void arch_send_call_function_single_ipi(int cpu);
 extern void arch_send_call_function_ipi_mask(const struct cpumask *mask);
 
-struct device_node;
-
-struct smp_enable_ops {
-	const char	*name;
-	int		(*init_cpu)(struct device_node *, int);
-	int		(*prepare_cpu)(int);
-};
-
-extern const struct smp_enable_ops smp_spin_table_ops;
-extern const struct smp_enable_ops smp_psci_ops;
-
 #endif /* ifndef __ASM_SMP_H */
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 75a90c1..5ba2fd4 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -9,7 +9,7 @@ AFLAGS_head.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
 arm64-obj-y		:= cputable.o debug-monitors.o entry.o irq.o fpsimd.o	\
 			   entry-fpsimd.o process.o ptrace.o setup.o signal.o	\
 			   sys.o stacktrace.o time.o traps.o io.o vdso.o	\
-			   hyp-stub.o psci.o
+			   hyp-stub.o psci.o cpu_ops.o
 
 arm64-obj-$(CONFIG_COMPAT)		+= sys32.o kuser32.o signal32.o 	\
 					   sys_compat.o
diff --git a/arch/arm64/kernel/cpu_ops.c b/arch/arm64/kernel/cpu_ops.c
new file mode 100644
index 0000000..e2652aa
--- /dev/null
+++ b/arch/arm64/kernel/cpu_ops.c
@@ -0,0 +1,47 @@
+/*
+ * CPU kernel entry/exit control
+ *
+ * Copyright (C) 2013 ARM Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <asm/cpu_ops.h>
+#include <linux/string.h>
+
+extern const struct cpu_operations smp_spin_table_ops;
+extern const struct cpu_operations cpu_psci_ops;
+
+const struct cpu_operations *cpu_ops[NR_CPUS];
+
+static const struct cpu_operations *supported_cpu_ops[] __initconst = {
+#ifdef CONFIG_SMP
+	&smp_spin_table_ops,
+	&cpu_psci_ops,
+#endif
+	NULL,
+};
+
+const struct cpu_operations * __init cpu_get_ops(const char *name)
+{
+	const struct cpu_operations **ops = supported_cpu_ops;
+
+	while (*ops) {
+		if (!strcmp(name, (*ops)->name))
+			return *ops;
+
+		ops++;
+	}
+
+	return NULL;
+}
diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
index 368b787..ccec2ca 100644
--- a/arch/arm64/kernel/psci.c
+++ b/arch/arm64/kernel/psci.c
@@ -20,6 +20,7 @@
 #include <linux/smp.h>
 
 #include <asm/compiler.h>
+#include <asm/cpu_ops.h>
 #include <asm/errno.h>
 #include <asm/psci.h>
 #include <asm/smp_plat.h>
@@ -231,12 +232,12 @@ out_put_node:
 
 #ifdef CONFIG_SMP
 
-static int __init smp_psci_init_cpu(struct device_node *dn, int cpu)
+static int __init cpu_psci_cpu_init(struct device_node *dn, unsigned int cpu)
 {
 	return 0;
 }
 
-static int __init smp_psci_prepare_cpu(int cpu)
+static int __init cpu_psci_cpu_prepare(unsigned int cpu)
 {
 	int err;
 
@@ -254,10 +255,10 @@ static int __init smp_psci_prepare_cpu(int cpu)
 	return 0;
 }
 
-const struct smp_enable_ops smp_psci_ops __initconst = {
+const struct cpu_operations cpu_psci_ops = {
 	.name		= "psci",
-	.init_cpu	= smp_psci_init_cpu,
-	.prepare_cpu	= smp_psci_prepare_cpu,
+	.cpu_init	= cpu_psci_cpu_init,
+	.cpu_prepare	= cpu_psci_cpu_prepare,
 };
 
 #endif
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 78db90d..8965fb7 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -39,6 +39,7 @@
 #include <asm/atomic.h>
 #include <asm/cacheflush.h>
 #include <asm/cputype.h>
+#include <asm/cpu_ops.h>
 #include <asm/mmu_context.h>
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -232,28 +233,6 @@ void __init smp_prepare_boot_cpu(void)
 
 static void (*smp_cross_call)(const struct cpumask *, unsigned int);
 
-static const struct smp_enable_ops *enable_ops[] __initconst = {
-	&smp_spin_table_ops,
-	&smp_psci_ops,
-	NULL,
-};
-
-static const struct smp_enable_ops *smp_enable_ops[NR_CPUS];
-
-static const struct smp_enable_ops * __init smp_get_enable_ops(const char *name)
-{
-	const struct smp_enable_ops **ops = enable_ops;
-
-	while (*ops) {
-		if (!strcmp(name, (*ops)->name))
-			return *ops;
-
-		ops++;
-	}
-
-	return NULL;
-}
-
 /*
  * Enumerate the possible CPU set from the device tree and build the
  * cpu logical map array containing MPIDR values related to logical
@@ -263,7 +242,7 @@ void __init smp_init_cpus(void)
 {
 	const char *enable_method;
 	struct device_node *dn = NULL;
-	int i, cpu = 1;
+	unsigned int i, cpu = 1;
 	bool bootcpu_valid = false;
 
 	while ((dn = of_find_node_by_type(dn, "cpu"))) {
@@ -342,15 +321,15 @@ void __init smp_init_cpus(void)
 			goto next;
 		}
 
-		smp_enable_ops[cpu] = smp_get_enable_ops(enable_method);
+		cpu_ops[cpu] = cpu_get_ops(enable_method);
 
-		if (!smp_enable_ops[cpu]) {
+		if (!cpu_ops[cpu]) {
 			pr_err("%s: invalid enable-method property: %s\n",
 			       dn->full_name, enable_method);
 			goto next;
 		}
 
-		if (smp_enable_ops[cpu]->init_cpu(dn, cpu))
+		if (cpu_ops[cpu]->cpu_init(dn, cpu))
 			goto next;
 
 		pr_debug("cpu logical map 0x%llx\n", hwid);
@@ -380,8 +359,8 @@ next:
 
 void __init smp_prepare_cpus(unsigned int max_cpus)
 {
-	int cpu, err;
-	unsigned int ncores = num_possible_cpus();
+	int err;
+	unsigned int cpu, ncores = num_possible_cpus();
 
 	/*
 	 * are we trying to boot more cores than exist?
@@ -408,10 +387,10 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 		if (cpu == smp_processor_id())
 			continue;
 
-		if (!smp_enable_ops[cpu])
+		if (!cpu_ops[cpu])
 			continue;
 
-		err = smp_enable_ops[cpu]->prepare_cpu(cpu);
+		err = cpu_ops[cpu]->cpu_prepare(cpu);
 		if (err)
 			continue;
 
diff --git a/arch/arm64/kernel/smp_spin_table.c b/arch/arm64/kernel/smp_spin_table.c
index 7c35fa6..a8b76e4 100644
--- a/arch/arm64/kernel/smp_spin_table.c
+++ b/arch/arm64/kernel/smp_spin_table.c
@@ -21,10 +21,11 @@
 #include <linux/smp.h>
 
 #include <asm/cacheflush.h>
+#include <asm/cpu_ops.h>
 
 static phys_addr_t cpu_release_addr[NR_CPUS];
 
-static int __init smp_spin_table_init_cpu(struct device_node *dn, int cpu)
+static int smp_spin_table_cpu_init(struct device_node *dn, unsigned int cpu)
 {
 	/*
 	 * Determine the address from which the CPU is polling.
@@ -40,7 +41,7 @@ static int __init smp_spin_table_init_cpu(struct device_node *dn, int cpu)
 	return 0;
 }
 
-static int __init smp_spin_table_prepare_cpu(int cpu)
+static int smp_spin_table_cpu_prepare(unsigned int cpu)
 {
 	void **release_addr;
 
@@ -59,8 +60,8 @@ static int __init smp_spin_table_prepare_cpu(int cpu)
 	return 0;
 }
 
-const struct smp_enable_ops smp_spin_table_ops __initconst = {
+const struct cpu_operations smp_spin_table_ops = {
 	.name		= "spin-table",
-	.init_cpu 	= smp_spin_table_init_cpu,
-	.prepare_cpu	= smp_spin_table_prepare_cpu,
+	.cpu_init	= smp_spin_table_cpu_init,
+	.cpu_prepare	= smp_spin_table_cpu_prepare,
 };
-- 
1.8.1.1
