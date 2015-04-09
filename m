From: galak@codeaurora.org (Kumar Gala)
Date: Thu,  9 Apr 2015 12:37:09 -0500
Subject: [RFC PATCH 3/5] arm64: introduce CPU_OF_TABLES for cpu ops selection
In-Reply-To: <1428601031-5366-1-git-send-email-galak@codeaurora.org>
References: <1428601031-5366-1-git-send-email-galak@codeaurora.org>
Message-ID: <1428601031-5366-4-git-send-email-galak@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Abhimanyu Kapur <abhimany@codeaurora.org>

Add support to arm64 to provide a dt-based method to allow soc-vendors to
supply cpu_ops. Also move psci and smp_spin_table ops to use CPU_OF_TABLES.

Signed-off-by: Abhimanyu Kapur <abhimany@codeaurora.org>
Signed-off-by: Kumar Gala <galak@codeaurora.org>
---
 arch/arm64/include/asm/cpu_ops.h   |  5 +++++
 arch/arm64/kernel/cpu_ops.c        | 27 +++++++++------------------
 arch/arm64/kernel/psci.c           |  1 +
 arch/arm64/kernel/smp_spin_table.c |  3 ++-
 4 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/include/asm/cpu_ops.h b/arch/arm64/include/asm/cpu_ops.h
index da301ee..a7efab8 100644
--- a/arch/arm64/include/asm/cpu_ops.h
+++ b/arch/arm64/include/asm/cpu_ops.h
@@ -67,4 +67,9 @@ extern const struct cpu_operations *cpu_ops[NR_CPUS];
 int __init cpu_read_ops(struct device_node *dn, int cpu);
 void __init cpu_read_bootcpu_ops(void);
 
+#define CPU_METHOD_OF_DECLARE(name, __ops)				\
+	static const struct cpu_operations *__cpu_method_table_##name	\
+	__used __section(__cpu_method_of_table)				\
+	= __ops;
+
 #endif /* ifndef __ASM_CPU_OPS_H */
diff --git a/arch/arm64/kernel/cpu_ops.c b/arch/arm64/kernel/cpu_ops.c
index cce9524..ad33f98 100644
--- a/arch/arm64/kernel/cpu_ops.c
+++ b/arch/arm64/kernel/cpu_ops.c
@@ -22,29 +22,20 @@
 #include <linux/of.h>
 #include <linux/string.h>
 
-extern const struct cpu_operations smp_spin_table_ops;
-extern const struct cpu_operations cpu_psci_ops;
-
 const struct cpu_operations *cpu_ops[NR_CPUS];
 
-static const struct cpu_operations *supported_cpu_ops[] __initconst = {
-#ifdef CONFIG_SMP
-	&smp_spin_table_ops,
-#endif
-	&cpu_psci_ops,
-	NULL,
-};
+extern struct cpu_operations __cpu_method_of_table[];
+static const struct cpu_operations *__cpu_method_of_table_sentinel
+	__used __section(__cpu_method_of_table_end);
 
-static const struct cpu_operations * __init cpu_get_ops(const char *name)
+const struct cpu_operations * __init cpu_get_ops(const char *name)
 {
-	const struct cpu_operations **ops = supported_cpu_ops;
-
-	while (*ops) {
-		if (!strcmp(name, (*ops)->name))
-			return *ops;
+	const struct cpu_operations **start = (void *)__cpu_method_of_table;
 
-		ops++;
-	}
+	for (; *start; start++) {
+		if (!strcmp((*start)->name, name))
+			return *start;
+	};
 
 	return NULL;
 }
diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
index 9b8a70a..2f255c7 100644
--- a/arch/arm64/kernel/psci.c
+++ b/arch/arm64/kernel/psci.c
@@ -523,3 +523,4 @@ const struct cpu_operations cpu_psci_ops = {
 #endif
 };
 
+CPU_METHOD_OF_DECLARE(psci, &cpu_psci_ops);
diff --git a/arch/arm64/kernel/smp_spin_table.c b/arch/arm64/kernel/smp_spin_table.c
index 14944e5..b41a8b4 100644
--- a/arch/arm64/kernel/smp_spin_table.c
+++ b/arch/arm64/kernel/smp_spin_table.c
@@ -119,9 +119,10 @@ static int smp_spin_table_cpu_boot(unsigned int cpu)
 	return 0;
 }
 
-const struct cpu_operations smp_spin_table_ops = {
+static const struct cpu_operations smp_spin_table_ops = {
 	.name		= "spin-table",
 	.cpu_init	= smp_spin_table_cpu_init,
 	.cpu_prepare	= smp_spin_table_cpu_prepare,
 	.cpu_boot	= smp_spin_table_cpu_boot,
 };
+CPU_METHOD_OF_DECLARE(spin_table, &smp_spin_table_ops);
-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
