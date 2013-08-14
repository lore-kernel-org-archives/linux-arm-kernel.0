From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 14 Aug 2013 17:20:24 +0100
Subject: [PATCHv3 1/5] arm64: reorganise smp_enable_ops
In-Reply-To: <1376497228-20543-1-git-send-email-mark.rutland@arm.com>
References: <1376497228-20543-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1376497228-20543-2-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For hotplug support, we're going to want a place to store operations
that do more than bring CPUs online, and it makes sense to group these
with our current smp_enable_ops.

This patch renames smp_enable_ops to smp_ops to make the intended use of
the structure clearer. While we're at it, fix up instances of the cpu
parameter to be an unsigned int, drop the init markinss and rename the
*_cpu functions to cpu_* to reduce future churn when smp_operations is
extended.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/include/asm/smp.h       | 10 +++++-----
 arch/arm64/kernel/smp.c            | 24 ++++++++++++------------
 arch/arm64/kernel/smp_psci.c       | 10 +++++-----
 arch/arm64/kernel/smp_spin_table.c | 10 +++++-----
 4 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
index 4b8023c..90626b6 100644
--- a/arch/arm64/include/asm/smp.h
+++ b/arch/arm64/include/asm/smp.h
@@ -68,13 +68,13 @@ extern void arch_send_call_function_ipi_mask(const struct cpumask *mask);
 
 struct device_node;
 
-struct smp_enable_ops {
+struct smp_operations {
 	const char	*name;
-	int		(*init_cpu)(struct device_node *, int);
-	int		(*prepare_cpu)(int);
+	int		(*cpu_init)(struct device_node *, unsigned int);
+	int		(*cpu_prepare)(unsigned int);
 };
 
-extern const struct smp_enable_ops smp_spin_table_ops;
-extern const struct smp_enable_ops smp_psci_ops;
+extern const struct smp_operations smp_spin_table_ops;
+extern const struct smp_operations smp_psci_ops;
 
 #endif /* ifndef __ASM_SMP_H */
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index fee5cce..533f405 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -236,17 +236,17 @@ void __init smp_prepare_boot_cpu(void)
 
 static void (*smp_cross_call)(const struct cpumask *, unsigned int);
 
-static const struct smp_enable_ops *enable_ops[] __initconst = {
+static const struct smp_operations *supported_smp_ops[] __initconst = {
 	&smp_spin_table_ops,
 	&smp_psci_ops,
 	NULL,
 };
 
-static const struct smp_enable_ops *smp_enable_ops[NR_CPUS];
+static const struct smp_operations *smp_ops[NR_CPUS];
 
-static const struct smp_enable_ops * __init smp_get_enable_ops(const char *name)
+static const struct smp_operations * __init smp_get_ops(const char *name)
 {
-	const struct smp_enable_ops **ops = enable_ops;
+	const struct smp_operations **ops = supported_smp_ops;
 
 	while (*ops) {
 		if (!strcmp(name, (*ops)->name))
@@ -267,7 +267,7 @@ void __init smp_init_cpus(void)
 {
 	const char *enable_method;
 	struct device_node *dn = NULL;
-	int i, cpu = 1;
+	unsigned int i, cpu = 1;
 	bool bootcpu_valid = false;
 
 	while ((dn = of_find_node_by_type(dn, "cpu"))) {
@@ -346,15 +346,15 @@ void __init smp_init_cpus(void)
 			goto next;
 		}
 
-		smp_enable_ops[cpu] = smp_get_enable_ops(enable_method);
+		smp_ops[cpu] = smp_get_ops(enable_method);
 
-		if (!smp_enable_ops[cpu]) {
+		if (!smp_ops[cpu]) {
 			pr_err("%s: invalid enable-method property: %s\n",
 			       dn->full_name, enable_method);
 			goto next;
 		}
 
-		if (smp_enable_ops[cpu]->init_cpu(dn, cpu))
+		if (smp_ops[cpu]->cpu_init(dn, cpu))
 			goto next;
 
 		pr_debug("cpu logical map 0x%llx\n", hwid);
@@ -384,8 +384,8 @@ next:
 
 void __init smp_prepare_cpus(unsigned int max_cpus)
 {
-	int cpu, err;
-	unsigned int ncores = num_possible_cpus();
+	int err;
+	unsigned int cpu, ncores = num_possible_cpus();
 
 	/*
 	 * are we trying to boot more cores than exist?
@@ -412,10 +412,10 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 		if (cpu == smp_processor_id())
 			continue;
 
-		if (!smp_enable_ops[cpu])
+		if (!smp_ops[cpu])
 			continue;
 
-		err = smp_enable_ops[cpu]->prepare_cpu(cpu);
+		err = smp_ops[cpu]->cpu_prepare(cpu);
 		if (err)
 			continue;
 
diff --git a/arch/arm64/kernel/smp_psci.c b/arch/arm64/kernel/smp_psci.c
index 0c53330..2f0d3dd 100644
--- a/arch/arm64/kernel/smp_psci.c
+++ b/arch/arm64/kernel/smp_psci.c
@@ -23,12 +23,12 @@
 #include <asm/psci.h>
 #include <asm/smp_plat.h>
 
-static int __init smp_psci_init_cpu(struct device_node *dn, int cpu)
+static int smp_psci_cpu_init(struct device_node *dn, unsigned int cpu)
 {
 	return 0;
 }
 
-static int __init smp_psci_prepare_cpu(int cpu)
+static int smp_psci_cpu_prepare(unsigned int cpu)
 {
 	int err;
 
@@ -46,8 +46,8 @@ static int __init smp_psci_prepare_cpu(int cpu)
 	return 0;
 }
 
-const struct smp_enable_ops smp_psci_ops __initconst = {
+const struct smp_operations smp_psci_ops = {
 	.name		= "psci",
-	.init_cpu	= smp_psci_init_cpu,
-	.prepare_cpu	= smp_psci_prepare_cpu,
+	.cpu_init	= smp_psci_cpu_init,
+	.cpu_prepare	= smp_psci_cpu_prepare,
 };
diff --git a/arch/arm64/kernel/smp_spin_table.c b/arch/arm64/kernel/smp_spin_table.c
index 7c35fa6..5fecffc 100644
--- a/arch/arm64/kernel/smp_spin_table.c
+++ b/arch/arm64/kernel/smp_spin_table.c
@@ -24,7 +24,7 @@
 
 static phys_addr_t cpu_release_addr[NR_CPUS];
 
-static int __init smp_spin_table_init_cpu(struct device_node *dn, int cpu)
+static int smp_spin_table_cpu_init(struct device_node *dn, unsigned int cpu)
 {
 	/*
 	 * Determine the address from which the CPU is polling.
@@ -40,7 +40,7 @@ static int __init smp_spin_table_init_cpu(struct device_node *dn, int cpu)
 	return 0;
 }
 
-static int __init smp_spin_table_prepare_cpu(int cpu)
+static int smp_spin_table_cpu_prepare(unsigned int cpu)
 {
 	void **release_addr;
 
@@ -59,8 +59,8 @@ static int __init smp_spin_table_prepare_cpu(int cpu)
 	return 0;
 }
 
-const struct smp_enable_ops smp_spin_table_ops __initconst = {
+const struct smp_operations smp_spin_table_ops = {
 	.name		= "spin-table",
-	.init_cpu 	= smp_spin_table_init_cpu,
-	.prepare_cpu	= smp_spin_table_prepare_cpu,
+	.cpu_init	= smp_spin_table_cpu_init,
+	.cpu_prepare	= smp_spin_table_cpu_prepare,
 };
-- 
1.8.1.1
