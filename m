From: geoff@infradead.org (Geoff Levand)
Date: Fri, 09 May 2014 00:48:17 +0000
Subject: [PATCH 2/8] arm64: Make cpu_read_ops generic
In-Reply-To: <cover.1399594544.git.geoff@infradead.org>
References: <cover.1399594544.git.geoff@infradead.org>
Message-ID: <20478f830f1d1a426fbe7a379e6f19562082ec7e.1399594544.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the __init attribute from the cpu_read_ops() routine and the __initconst
attribute from the supported_cpu_ops[] variable to allow cpu_read_ops() to be
used after kernel initialization.  Change cpu_read_ops() from acting on the
static local variable cpu_ops to acting on a pointer to an array of struct
cpu_operations passed as a cpu_read_ops() parameter.  Also change any calls to
cpu_read_ops() to pass the local cpu_ops variable.

This change has no functional effect.  The kexec_load syscall handling can
re-use the cpu_read_ops() routine in its parsing of the device tree for the
2nd stage kernel.  kexec_load syscall can be called after kernel init, so
cannot use any routines with the __init attribute.

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/arm64/include/asm/cpu_ops.h |  3 ++-
 arch/arm64/kernel/cpu_ops.c      | 11 ++++++-----
 arch/arm64/kernel/smp.c          |  2 +-
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/cpu_ops.h b/arch/arm64/include/asm/cpu_ops.h
index 1524130..872f61a 100644
--- a/arch/arm64/include/asm/cpu_ops.h
+++ b/arch/arm64/include/asm/cpu_ops.h
@@ -59,7 +59,8 @@ struct cpu_operations {
 };
 
 extern const struct cpu_operations *cpu_ops[NR_CPUS];
-extern int __init cpu_read_ops(struct device_node *dn, int cpu);
+extern int cpu_read_ops(struct device_node *dn, int cpu,
+	const struct cpu_operations **cpu_ops);
 extern void __init cpu_read_bootcpu_ops(void);
 
 #endif /* ifndef __ASM_CPU_OPS_H */
diff --git a/arch/arm64/kernel/cpu_ops.c b/arch/arm64/kernel/cpu_ops.c
index d62d12f..6ccba89 100644
--- a/arch/arm64/kernel/cpu_ops.c
+++ b/arch/arm64/kernel/cpu_ops.c
@@ -27,7 +27,7 @@ extern const struct cpu_operations cpu_psci_ops;
 
 const struct cpu_operations *cpu_ops[NR_CPUS];
 
-static const struct cpu_operations *supported_cpu_ops[] __initconst = {
+static const struct cpu_operations *supported_cpu_ops[] = {
 #ifdef CONFIG_SMP
 	&smp_spin_table_ops,
 	&cpu_psci_ops,
@@ -52,7 +52,8 @@ static const struct cpu_operations * __init cpu_get_ops(const char *name)
 /*
  * Read a cpu's enable method from the device tree and record it in cpu_ops.
  */
-int __init cpu_read_ops(struct device_node *dn, int cpu)
+int cpu_read_ops(struct device_node *dn, int cpu,
+	const struct cpu_operations **cpu_ops)
 {
 	const char *enable_method = of_get_property(dn, "enable-method", NULL);
 	if (!enable_method) {
@@ -66,8 +67,8 @@ int __init cpu_read_ops(struct device_node *dn, int cpu)
 		return -ENOENT;
 	}
 
-	cpu_ops[cpu] = cpu_get_ops(enable_method);
-	if (!cpu_ops[cpu]) {
+	*cpu_ops = cpu_get_ops(enable_method);
+	if (!*cpu_ops) {
 		pr_warn("%s: unsupported enable-method property: %s\n",
 			dn->full_name, enable_method);
 		return -EOPNOTSUPP;
@@ -83,5 +84,5 @@ void __init cpu_read_bootcpu_ops(void)
 		pr_err("Failed to find device node for boot cpu\n");
 		return;
 	}
-	cpu_read_ops(dn, 0);
+	cpu_read_ops(dn, 0, &cpu_ops[0]);
 }
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 020bbd5..f9241c1 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -362,7 +362,7 @@ void __init smp_init_cpus(void)
 		if (cpu >= NR_CPUS)
 			goto next;
 
-		if (cpu_read_ops(dn, cpu) != 0)
+		if (cpu_read_ops(dn, cpu, &cpu_ops[cpu]))
 			goto next;
 
 		if (cpu_ops[cpu]->cpu_init(dn, cpu))
-- 
1.9.1
