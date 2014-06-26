From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 26 Jun 2014 16:18:46 +0100
Subject: [PATCHv3 5/5] arm64: add runtime system sanity checks
In-Reply-To: <1403795926-17139-1-git-send-email-mark.rutland@arm.com>
References: <1403795926-17139-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1403795926-17139-6-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Unexpected variation in certain system register values across CPUs is an
indicator of potential problems with a system. The kernel expects CPUs
to be mostly identical in terms of supported features, even in systems
with heterogeneous CPUs, with uniform instruction set support being
critical for the correct operation of userspace.

To help detect issues early where hardware violates the expectations of
the kernel, this patch adds simple runtime sanity checks on important ID
registers in the bring up path of each CPU.

Where CPUs are fundamentally mismatched, set TAINT_CPU_OUT_OF_SPEC.
Given that the kernel assumes CPUs are identical feature wise, let's not
pretend that we expect such configurations to work. Supporting such
configurations would require massive rework, and hopefully they will
never exist.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/kernel/cpuinfo.c | 92 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 20ca6d0..fb4a70e 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -21,6 +21,7 @@
 
 #include <linux/bitops.h>
 #include <linux/init.h>
+#include <linux/kernel.h>
 #include <linux/printk.h>
 #include <linux/smp.h>
 
@@ -54,6 +55,96 @@ static void cpuinfo_detect_icache_policy(struct cpuinfo_arm64 *info,
 	pr_info("Detected %s I-cache on CPU%d", icache_policy_str[l1ip], cpu);
 }
 
+static int check_reg_mask(char *name, u64 mask, u64 boot, u64 cur, int cpu)
+{
+	if ((boot & mask) == (cur & mask))
+		return 0;
+
+	pr_warn("SANITY CHECK: Unexpected variation in %s. Boot CPU: %#016lx, CPU%d: %#016lx\n",
+		name, (unsigned long)boot, cpu, (unsigned long)cur);
+
+	return 1;
+}
+
+#define CHECK_MASK(field, mask, boot, cur, cpu) \
+	check_reg_mask(#field, mask, (boot)->reg_ ## field, (cur)->reg_ ## field, cpu)
+
+#define CHECK(field, boot, cur, cpu) \
+	CHECK_MASK(field, ~0ULL, boot, cur, cpu)
+
+/*
+ * Verify that CPUs don't have unexpected differences that will cause problems.
+ */
+static void cpuinfo_sanity_check(struct cpuinfo_arm64 *cur, int cpu)
+{
+	struct cpuinfo_arm64 *boot = &boot_cpu_data;
+	unsigned int diff = 0;
+
+	/*
+	 * The kernel can handle differing I-cache policies, but otherwise
+	 * caches should look identical. Userspace JITs will make use of
+	 * *minLine.
+	 */
+	diff |= CHECK_MASK(ctr, 0xffff3fff, boot, cur, cpu);
+
+	/*
+	 * Userspace may perform DC ZVA instructions. Mismatched block sizes
+	 * could result in too much or too little memory being zeroed if a
+	 * process is preempted and migrated between CPUs.
+	 */
+	diff |= CHECK(dczid, boot, cur, cpu);
+
+	/* If different, timekeeping will be broken (especially with KVM) */
+	diff |= CHECK(cntfrq, boot, cur, cpu);
+
+	/*
+	 * Even in big.LITTLE, processors should be identical instruction-set
+	 * wise.
+	 */
+	diff |= CHECK(id_aa64isar0, boot, cur, cpu);
+	diff |= CHECK(id_aa64isar1, boot, cur, cpu);
+
+	/*
+	 * Differing PARange support is fine as long as all peripherals and
+	 * memory are mapped within the minimum PARange of all CPUs.
+	 * Linux should not care about secure memory.
+	 * ID_AA64MMFR1 is currently RES0.
+	 */
+	diff |= CHECK_MASK(id_aa64mmfr0, 0xffffffffffff0ff0, boot, cur, cpu);
+	diff |= CHECK(id_aa64mmfr1, boot, cur, cpu);
+
+	/*
+	 * EL3 is not our concern.
+	 * ID_AA64PFR1 is currently RES0.
+	 */
+	diff |= CHECK_MASK(id_aa64pfr0, 0xffffffffffff0fff, boot, cur, cpu);
+	diff |= CHECK(id_aa64pfr1, boot, cur, cpu);
+
+	/*
+	 * If we have AArch32, we care about 32-bit features for compat. These
+	 * registers should be RES0 otherwise.
+	 */
+	diff |= CHECK(id_isar0, boot, cur, cpu);
+	diff |= CHECK(id_isar1, boot, cur, cpu);
+	diff |= CHECK(id_isar2, boot, cur, cpu);
+	diff |= CHECK(id_isar3, boot, cur, cpu);
+	diff |= CHECK(id_isar4, boot, cur, cpu);
+	diff |= CHECK(id_isar5, boot, cur, cpu);
+	diff |= CHECK(id_mmfr0, boot, cur, cpu);
+	diff |= CHECK(id_mmfr1, boot, cur, cpu);
+	diff |= CHECK(id_mmfr2, boot, cur, cpu);
+	diff |= CHECK(id_mmfr3, boot, cur, cpu);
+	diff |= CHECK(id_pfr0, boot, cur, cpu);
+	diff |= CHECK(id_pfr1, boot, cur, cpu);
+
+	/*
+	 * Mismatched CPU features are a recipe for disaster. Don't even
+	 * pretend to support them.
+	 */
+	WARN_TAINT_ONCE(diff, TAINT_CPU_OUT_OF_SPEC,
+			"Unsupported CPU feature variation.");
+}
+
 static void __cpuinfo_store_cpu(struct cpuinfo_arm64 *info, unsigned int cpu)
 {
 	info->reg_cntfrq = arch_timer_get_cntfrq();
@@ -89,6 +180,7 @@ void cpuinfo_store_cpu(void)
 	unsigned int cpu = smp_processor_id();
 	struct cpuinfo_arm64 *info = &per_cpu(cpu_data, cpu);
 	__cpuinfo_store_cpu(info, cpu);
+	cpuinfo_sanity_check(info, cpu);
 }
 
 void __init cpuinfo_store_boot_cpu(void)
-- 
1.9.1
