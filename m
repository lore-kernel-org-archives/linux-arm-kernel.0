From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Tue,  1 Dec 2015 15:12:07 +0000
Subject: [PATCH v2 2/6] arm64: Move kill_cpu_early to smp.c
In-Reply-To: <1448982731-17182-1-git-send-email-suzuki.poulose@arm.com>
References: <1448982731-17182-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1448982731-17182-3-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves kill_cpu_early to smp.c, where it fits better.
No functional changes, except for adding the necessary checks
for CONFIG_HOTPLUG_CPU.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/smp.h   |    1 +
 arch/arm64/kernel/cpufeature.c |   22 ----------------------
 arch/arm64/kernel/smp.c        |   25 +++++++++++++++++++++++++
 3 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
index d9c3d6a..d23d482 100644
--- a/arch/arm64/include/asm/smp.h
+++ b/arch/arm64/include/asm/smp.h
@@ -68,5 +68,6 @@ extern int __cpu_disable(void);
 
 extern void __cpu_die(unsigned int cpu);
 extern void cpu_die(void);
+extern void kill_cpu_early(void);
 
 #endif /* ifndef __ASM_SMP_H */
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index a7e2262..a17fde9 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -826,28 +826,6 @@ static u64 __raw_read_system_reg(u32 sys_id)
 }
 
 /*
- * Kill the calling secondary CPU, early in bringup before it is turned
- * online.
- */
-void kill_cpu_early(void)
-{
-	int cpu = smp_processor_id();
-
-	pr_crit("CPU%d: will not boot\n", cpu);
-
-	/* Mark this CPU absent */
-	set_cpu_present(cpu, 0);
-
-	/* Check if we can park ourselves */
-	if (cpu_ops[cpu] && cpu_ops[cpu]->cpu_die)
-		cpu_ops[cpu]->cpu_die(cpu);
-	asm(
-	"1:	wfe\n"
-	"	wfi\n"
-	"	b	1b");
-}
-
-/*
  * Run through the enabled system capabilities and enable() it on this CPU.
  * The capabilities were decided based on the available CPUs at the boot time.
  * Any new CPU should match the system wide status of the capability. If the
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index b1adc51..ba33615 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -313,6 +313,31 @@ void cpu_die(void)
 }
 #endif
 
+/*
+ * Kill the calling secondary CPU, early in bringup before it is turned
+ * online.
+ */
+void kill_cpu_early(void)
+{
+	int cpu = smp_processor_id();
+
+	pr_crit("CPU%d: will not boot\n", cpu);
+
+	/* Mark this CPU absent */
+	set_cpu_present(cpu, 0);
+
+#ifdef CONFIG_HOTPLUG_CPU
+	/* Check if we can park ourselves */
+	if (cpu_ops[cpu] && cpu_ops[cpu]->cpu_die)
+		cpu_ops[cpu]->cpu_die(cpu);
+#endif
+
+	asm(
+	"1:	wfe\n"
+	"	wfi\n"
+	"	b	1b");
+}
+
 static void __init hyp_mode_check(void)
 {
 	if (is_hyp_mode_available())
-- 
1.7.9.5
