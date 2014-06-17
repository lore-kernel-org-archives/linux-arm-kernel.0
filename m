From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 17 Jun 2014 18:04:34 +0100
Subject: [PATCHv2 4/4] arm64: add runtime system sanity checks
In-Reply-To: <1403024674-25108-1-git-send-email-mark.rutland@arm.com>
References: <1403024674-25108-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1403024674-25108-5-git-send-email-mark.rutland@arm.com>
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

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/include/asm/cpu.h | 19 ++++++++-
 arch/arm64/kernel/cpuinfo.c  | 94 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 111 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/cpu.h b/arch/arm64/include/asm/cpu.h
index daca48d..8e6c9aa 100644
--- a/arch/arm64/include/asm/cpu.h
+++ b/arch/arm64/include/asm/cpu.h
@@ -16,12 +16,29 @@
 /*
  * Records attributes of an individual CPU.
  *
- * This is used to cache data for /proc/cpuinfo.
+ * This is used to cache data for /proc/cpuinfo and run-time sanity checks.
  */
 struct cpuinfo_arm64 {
 	struct cpu	cpu;
 	u32		reg_ctr;
+	u32		reg_cntfrq;
 	u32		reg_midr;
+
+	u64		reg_id_aa64isar0;
+	u64		reg_id_aa64mmfr0;
+	u64		reg_id_aa64pfr0;
+	u32		reg_id_isar0;
+	u32		reg_id_isar1;
+	u32		reg_id_isar2;
+	u32		reg_id_isar3;
+	u32		reg_id_isar4;
+	u32		reg_id_isar5;
+	u32		reg_id_mmfr0;
+	u32		reg_id_mmfr1;
+	u32		reg_id_mmfr2;
+	u32		reg_id_mmfr3;
+	u32		reg_id_pfr0;
+	u32		reg_id_pfr1;
 };
 
 DECLARE_PER_CPU(struct cpuinfo_arm64, cpu_data);
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index b146148..5ef96a0 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -1,5 +1,6 @@
 /*
- * Record CPU attributes for later retrieval
+ * Record CPU attributes for later retrieval, and sanity-check that processor
+ * features do not vary unexpectedly.
  *
  * Copyright (C) 2014 ARM Ltd.
  * This program is free software; you can redistribute it and/or modify
@@ -14,6 +15,7 @@
  * You should have received a copy of the GNU General Public License
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
+#include <asm/arch_timer.h>
 #include <asm/cachetype.h>
 #include <asm/cpu.h>
 #include <asm/cputype.h>
@@ -21,6 +23,7 @@
 #include <linux/bitops.h>
 #include <linux/printk.h>
 #include <linux/smp.h>
+#include <linux/types.h>
 
 DEFINE_PER_CPU(struct cpuinfo_arm64, cpu_data);
 
@@ -45,13 +48,102 @@ static void cpuinfo_detect_icache_policy(struct cpuinfo_arm64 *info, int cpu)
 	pr_info("Detected %s I-cache on CPU%d", icache_policy_str[l1ip], cpu);
 }
 
+static void check_reg_mask(char *name, u64 mask, u64 boot, u64 cur, int cpu)
+{
+	if ((boot & mask) == (cur & mask))
+		return;
+
+	pr_warn("SANITY CHECK: Unexpected variation in %s. cpu0: %#016lx, cpu%d: %#016lx\n",
+		name, (unsigned long)boot, cpu, (unsigned long)cur);
+}
+
+#define CHECK_MASK(field, mask, boot, cur, cpu) \
+	check_reg_mask(#field, mask, (boot)->reg_ ## field, (cur)->reg_ ## field, cpu)
+
+#define CHECK(field, boot, cur, cpu) \
+	CHECK_MASK(field, (u64)-1, boot, cur, cpu)
+
+/*
+ * Verify that CPUs don't have unexpected differences that will cause problems.
+ */
+void cpuinfo_sanity_check(struct cpuinfo_arm64 *cur)
+{
+	struct cpuinfo_arm64 *boot = &per_cpu(cpu_data, 0);
+	int cpu = smp_processor_id();
+
+	/*
+	 * The kernel can handle differing I-cache policies, but otherwise
+	 * caches should look identical. Userspace JITs will make use of
+	 * *minLine.
+	 */
+	CHECK_MASK(ctr, 0xffff3fff, boot, cur, cpu);
+
+	/* If different, timekeeping will be broken (especially with KVM) */
+	CHECK(cntfrq, boot, cur, cpu);
+
+	/*
+	 * Even in big.LITTLE, processors should be identical instruction-set
+	 * wise.
+	 */
+	CHECK(id_aa64isar0, boot, cur, cpu);
+
+	/*
+	 * Differing PARange support is fine as long as all peripherals and
+	 * memory are mapped within the minimum PARange of all CPUs.
+	 * Linux should not care about secure memory.
+	 */
+	CHECK_MASK(id_aa64mmfr0, 0xffffffffffff0ff0, boot, cur, cpu);
+
+	/*
+	 * EL3 is not our concern, and GIC system register support only matters
+	 * if GICv3 is in use.
+	 */
+	CHECK_MASK(id_aa64pfr0, 0xfffffffff0ff0fff, boot, cur, cpu);
+
+	/*
+	 * If we have AArch32, we care about 32-bit features for compat. These
+	 * registers should be RES0 otherwise.
+	 */
+	CHECK(id_isar0, boot, cur, cpu);
+	CHECK(id_isar1, boot, cur, cpu);
+	CHECK(id_isar2, boot, cur, cpu);
+	CHECK(id_isar3, boot, cur, cpu);
+	CHECK(id_isar4, boot, cur, cpu);
+	CHECK(id_isar5, boot, cur, cpu);
+	CHECK(id_mmfr0, boot, cur, cpu);
+	CHECK(id_mmfr1, boot, cur, cpu);
+	CHECK(id_mmfr2, boot, cur, cpu);
+	CHECK(id_mmfr3, boot, cur, cpu);
+	CHECK(id_pfr0, boot, cur, cpu);
+	CHECK(id_pfr1, boot, cur, cpu);
+}
+
 void cpuinfo_store_cpu(void)
 {
 	int cpu = smp_processor_id();
 	struct cpuinfo_arm64 *cpuinfo = &per_cpu(cpu_data, cpu);
 
+	cpuinfo->reg_cntfrq = arch_timer_get_cntfrq();
 	cpuinfo->reg_ctr = read_cpuid_cachetype();
 	cpuinfo->reg_midr = read_cpuid_id();
 
+	cpuinfo->reg_id_aa64isar0 = read_cpuid(ID_AA64ISAR0_EL1);
+	cpuinfo->reg_id_aa64mmfr0 = read_cpuid(ID_AA64MMFR0_EL1);
+	cpuinfo->reg_id_aa64pfr0 = read_cpuid(ID_AA64PFR0_EL1);
+
+	cpuinfo->reg_id_isar0 = read_cpuid(ID_ISAR0_EL1);
+	cpuinfo->reg_id_isar1 = read_cpuid(ID_ISAR1_EL1);
+	cpuinfo->reg_id_isar2 = read_cpuid(ID_ISAR2_EL1);
+	cpuinfo->reg_id_isar3 = read_cpuid(ID_ISAR3_EL1);
+	cpuinfo->reg_id_isar4 = read_cpuid(ID_ISAR4_EL1);
+	cpuinfo->reg_id_isar5 = read_cpuid(ID_ISAR5_EL1);
+	cpuinfo->reg_id_mmfr0 = read_cpuid(ID_MMFR0_EL1);
+	cpuinfo->reg_id_mmfr1 = read_cpuid(ID_MMFR1_EL1);
+	cpuinfo->reg_id_mmfr2 = read_cpuid(ID_MMFR2_EL1);
+	cpuinfo->reg_id_mmfr3 = read_cpuid(ID_MMFR3_EL1);
+	cpuinfo->reg_id_pfr0 = read_cpuid(ID_PFR0_EL1);
+	cpuinfo->reg_id_pfr1 = read_cpuid(ID_PFR1_EL1);
+
 	cpuinfo_detect_icache_policy(cpuinfo, cpu);
+	cpuinfo_sanity_check(cpuinfo);
 }
-- 
1.9.1
