From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 11 Oct 2013 19:24:06 +0100
Subject: [PATCHv4 6/6] arm64: read enable-method for CPU0
In-Reply-To: <1381515846-1684-1-git-send-email-mark.rutland@arm.com>
References: <1381515846-1684-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1381515846-1684-7-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the advent of CPU_HOTPLUG, the enable-method property for CPU0 may
tells us something useful (i.e. how to hotplug it back on), so we must
read it along with all the enable-method for all the other CPUs.  Even
on UP the enable-method may tell us useful information (e.g. if a core
has some mechanism that might be usable for cpuidle), so we should
always read it.

This patch factors out the reading of the enable method, and ensures
that CPU0's enable method is read regardless of whether the kernel is
built with SMP support.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/include/asm/cpu_ops.h |  3 ++-
 arch/arm64/kernel/cpu_ops.c      | 49 +++++++++++++++++++++++++++++++++++++++-
 arch/arm64/kernel/setup.c        |  2 ++
 arch/arm64/kernel/smp.c          | 18 +--------------
 4 files changed, 53 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/include/asm/cpu_ops.h b/arch/arm64/include/asm/cpu_ops.h
index f4a11a3..f53409f 100644
--- a/arch/arm64/include/asm/cpu_ops.h
+++ b/arch/arm64/include/asm/cpu_ops.h
@@ -53,6 +53,7 @@ struct cpu_operations {
 };
 
 extern const struct cpu_operations *cpu_ops[NR_CPUS];
-extern const struct cpu_operations * __init cpu_get_ops(const char *name);
+extern int __init cpu_read_ops(struct device_node *dn, int cpu);
+extern void __init cpu_read_bootcpu_ops(void);
 
 #endif /* ifndef __ASM_CPU_OPS_H */
diff --git a/arch/arm64/kernel/cpu_ops.c b/arch/arm64/kernel/cpu_ops.c
index e2652aa..de78d22 100644
--- a/arch/arm64/kernel/cpu_ops.c
+++ b/arch/arm64/kernel/cpu_ops.c
@@ -17,6 +17,9 @@
  */
 
 #include <asm/cpu_ops.h>
+#include <asm/smp_plat.h>
+#include <linux/errno.h>
+#include <linux/of.h>
 #include <linux/string.h>
 
 extern const struct cpu_operations smp_spin_table_ops;
@@ -32,7 +35,7 @@ static const struct cpu_operations *supported_cpu_ops[] __initconst = {
 	NULL,
 };
 
-const struct cpu_operations * __init cpu_get_ops(const char *name)
+static const struct cpu_operations * __init cpu_get_ops(const char *name)
 {
 	const struct cpu_operations **ops = supported_cpu_ops;
 
@@ -45,3 +48,47 @@ const struct cpu_operations * __init cpu_get_ops(const char *name)
 
 	return NULL;
 }
+
+/*
+ * Read a cpu's enable method from the device tree and record it in cpu_ops.
+ */
+int __init cpu_read_ops(struct device_node *dn, int cpu)
+{
+	const char *enable_method = of_get_property(dn, "enable-method", NULL);
+	if (!enable_method) {
+		pr_err("%s: missing enable-method property\n",
+			dn->full_name);
+		return -ENOENT;
+	}
+
+	cpu_ops[cpu] = cpu_get_ops(enable_method);
+	if (!cpu_ops[cpu]) {
+		pr_err("%s: invalid enable-method property: %s\n",
+		       dn->full_name, enable_method);
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+void __init cpu_read_bootcpu_ops(void)
+{
+	struct device_node *dn = NULL;
+	u64 mpidr = cpu_logical_map(0);
+
+	while ((dn = of_find_node_by_type(dn, "cpu"))) {
+		u64 hwid;
+		const __be32 *prop;
+
+		prop = of_get_property(dn, "reg", NULL);
+		if (!prop)
+			continue;
+
+		hwid = of_read_number(prop, of_n_addr_cells(dn));
+		if (hwid == mpidr) {
+			cpu_read_ops(dn, 0);
+			of_node_put(dn);
+			return;
+		}
+	}
+}
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 055cfb8..b65c132 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -45,6 +45,7 @@
 #include <asm/cputype.h>
 #include <asm/elf.h>
 #include <asm/cputable.h>
+#include <asm/cpu_ops.h>
 #include <asm/sections.h>
 #include <asm/setup.h>
 #include <asm/smp_plat.h>
@@ -264,6 +265,7 @@ void __init setup_arch(char **cmdline_p)
 	psci_init();
 
 	cpu_logical_map(0) = read_cpuid_mpidr() & MPIDR_HWID_BITMASK;
+	cpu_read_bootcpu_ops();
 #ifdef CONFIG_SMP
 	smp_init_cpus();
 #endif
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 888776e..d5488f8 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -282,7 +282,6 @@ static void (*smp_cross_call)(const struct cpumask *, unsigned int);
  */
 void __init smp_init_cpus(void)
 {
-	const char *enable_method;
 	struct device_node *dn = NULL;
 	unsigned int i, cpu = 1;
 	bool bootcpu_valid = false;
@@ -353,23 +352,8 @@ void __init smp_init_cpus(void)
 		if (cpu >= NR_CPUS)
 			goto next;
 
-		/*
-		 * We currently support only the "spin-table" enable-method.
-		 */
-		enable_method = of_get_property(dn, "enable-method", NULL);
-		if (!enable_method) {
-			pr_err("%s: missing enable-method property\n",
-				dn->full_name);
+		if (cpu_read_ops(dn, cpu) != 0)
 			goto next;
-		}
-
-		cpu_ops[cpu] = cpu_get_ops(enable_method);
-
-		if (!cpu_ops[cpu]) {
-			pr_err("%s: invalid enable-method property: %s\n",
-			       dn->full_name, enable_method);
-			goto next;
-		}
 
 		if (cpu_ops[cpu]->cpu_init(dn, cpu))
 			goto next;
-- 
1.8.1.1
