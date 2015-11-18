From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Wed, 18 Nov 2015 17:09:00 +0000
Subject: [PATCH 5/5] arm64: Ensure the secondary CPUs have safe ASIDBits size
In-Reply-To: <1447866540-23207-1-git-send-email-suzuki.poulose@arm.com>
References: <1447866238-22970-1-git-send-email-suzuki.poulose@arm.com>
 <1447866540-23207-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1447866540-23207-5-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ID_AA64MMFR0_EL1:ASIDBits determines the size of the mm context
id and is used in the early boot to make decisions. The value is
picked up from the Boot CPU and cannot be delayed until other CPUs
are up. If a secondary CPU has a smaller size than that of the Boot
CPU, things will break horribly and the usual SANITY check is not good
enough to prevent the system from crashing. Prevent this by failing CPUs with
ASID smaller than that of the boot CPU.

Also moves the fail_incapable_cpu() out of the CONFIG_HOTPLUG_CPU.

Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/kernel/cpufeature.c |   81 +++++++++++++++++++++++++++++-----------
 1 file changed, 59 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 5629f2c..769782a 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -293,6 +293,28 @@ static struct arm64_ftr_reg arm64_ftr_regs[] = {
 	ARM64_FTR_REG(SYS_CNTFRQ_EL0, ftr_generic32),
 };
 
+/*
+ * Park the calling CPU which doesn't have the capability
+ * as advertised by the system.
+ */
+static void fail_incapable_cpu(void)
+{
+	int cpu = smp_processor_id();
+
+	pr_crit("CPU%d: will not boot\n", cpu);
+
+	/* Mark this CPU absent */
+	set_cpu_present(cpu, 0);
+
+	/* Check if we can park ourselves */
+	if (cpu_ops[cpu] && cpu_ops[cpu]->cpu_die)
+		cpu_ops[cpu]->cpu_die(cpu);
+	asm(
+	"1:	wfe\n"
+	"	wfi\n"
+	"	b	1b");
+}
+
 static int search_cmp_ftr_reg(const void *id, const void *regp)
 {
 	return (int)(unsigned long)id - (int)((const struct arm64_ftr_reg *)regp)->sys_id;
@@ -459,6 +481,40 @@ static int check_update_ftr_reg(u32 sys_id, int cpu, u64 val, u64 boot)
 }
 
 /*
+ * The asid_bits, which determine the width of the mm context
+ * id, is based on the boot CPU value. If the new CPU doesn't
+ * have an ASID >= boot CPU, we are in trouble. Fail this CPU.
+ */
+static void check_cpu_asid_bits(int cpu,
+				struct cpuinfo_arm64 *info,
+				struct cpuinfo_arm64 *boot)
+{
+	u32 asid_boot = cpuid_feature_extract_unsigned_field(boot->reg_id_aa64mmfr0,
+							ID_AA64MMFR0_ASID_SHIFT);
+	u32 asid_cur = cpuid_feature_extract_unsigned_field(info->reg_id_aa64mmfr0,
+							ID_AA64MMFR0_ASID_SHIFT);
+	if (asid_cur < asid_boot) {
+		pr_crit("CPU%d: has incompatible ASIDBits: %u vs Boot CPU:%u\n",
+				cpu, asid_cur, asid_boot);
+		fail_incapable_cpu();
+	}
+	return;
+}
+
+/*
+ * Checks whether the cpu is missing any of the features
+ * the kernel has already started using@early boot,
+ * before the other CPUs are brought up. This is intended
+ * for checking features where variations can be fatal.
+ */
+static void check_early_cpu_features(int cpu,
+				struct cpuinfo_arm64 *info,
+				struct cpuinfo_arm64 *boot)
+{
+	check_cpu_asid_bits(cpu, info, boot);
+}
+
+/*
  * Update system wide CPU feature registers with the values from a
  * non-boot CPU. Also performs SANITY checks to make sure that there
  * aren't any insane variations from that of the boot CPU.
@@ -469,6 +525,9 @@ void update_cpu_features(int cpu,
 {
 	int taint = 0;
 
+	/* Make sure there are no fatal feature variations for this cpu */
+	check_early_cpu_features(cpu, info, boot);
+
 	/*
 	 * The kernel can handle differing I-cache policies, but otherwise
 	 * caches should look identical. Userspace JITs will make use of
@@ -826,28 +885,6 @@ static u64 __raw_read_system_reg(u32 sys_id)
 }
 
 /*
- * Park the calling CPU which doesn't have the capability
- * as advertised by the system.
- */
-static void fail_incapable_cpu(void)
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
-- 
1.7.9.5
