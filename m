From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue, 23 Feb 2016 10:31:41 +0000
Subject: [PATCH v5 3/7] arm64: Move cpu_die_early to smp.c
In-Reply-To: <1456223505-2955-1-git-send-email-suzuki.poulose@arm.com>
References: <1456223505-2955-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1456223505-2955-4-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves cpu_die_early to smp.c, where it fits better.
No functional changes, except for adding the necessary checks
for CONFIG_HOTPLUG_CPU.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/smp.h   |    1 +
 arch/arm64/kernel/cpufeature.c |   19 -------------------
 arch/arm64/kernel/smp.c        |   22 ++++++++++++++++++++++
 3 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
index 53b53a9..32e75ee 100644
--- a/arch/arm64/include/asm/smp.h
+++ b/arch/arm64/include/asm/smp.h
@@ -68,6 +68,7 @@ extern int __cpu_disable(void);
 
 extern void __cpu_die(unsigned int cpu);
 extern void cpu_die(void);
+extern void cpu_die_early(void);
 
 static inline void cpu_park_loop(void)
 {
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 8275e7d..60c3f47 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -827,25 +827,6 @@ static u64 __raw_read_system_reg(u32 sys_id)
 }
 
 /*
- * Kill the calling secondary CPU, early in bringup before it is turned
- * online.
- */
-void cpu_die_early(void)
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
-	cpu_park_loop();
-}
-
-/*
  * Run through the enabled system capabilities and enable() it on this CPU.
  * The capabilities were decided based on the available CPUs at the boot time.
  * Any new CPU should match the system wide status of the capability. If the
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index b1adc51..59f032b 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -313,6 +313,28 @@ void cpu_die(void)
 }
 #endif
 
+/*
+ * Kill the calling secondary CPU, early in bringup before it is turned
+ * online.
+ */
+void cpu_die_early(void)
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
+	cpu_park_loop();
+}
+
 static void __init hyp_mode_check(void)
 {
 	if (is_hyp_mode_available())
-- 
1.7.9.5
