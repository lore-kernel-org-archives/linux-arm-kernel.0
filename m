From: amartin@nvidia.com (Allen Martin)
Date: Tue, 8 Jul 2014 12:14:20 -0700
Subject: [PATCH] arm64: Get the number of bits in ASID from the CPU
Message-ID: <1404846860-15055-1-git-send-email-amartin@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alex Van Brunt <avanbrunt@nvidia.com>

Instead of hard coding the number of ASID bits to 16, read the value
from the CPU through the register ID_AA64MMFR0_EL1 at boot time.  This
is required on Tegra132 Denver CPU which implements 8 bits.

Signed-off-by: Alex Van Brunt <avanbrunt@nvidia.com>
Signed-off-by: Allen Martin <amartin@nvidia.com>
Reviewed-by: Peng Du <pdu@nvidia.com>
Reviewed-by: Bo Yan <byan@nvidia.com>
---
 arch/arm64/include/asm/mmu_context.h |  4 ++--
 arch/arm64/kernel/setup.c            | 13 ++++++++++++-
 arch/arm64/mm/context.c              | 13 ++++++-------
 3 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index a9eee33dfa62..ddd78cad98a5 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -28,7 +28,7 @@
 #include <asm/cputype.h>
 #include <asm/pgtable.h>
 
-#define MAX_ASID_BITS	16
+extern unsigned int max_asid_bits;
 
 extern unsigned int cpu_last_asid;
 
@@ -84,7 +84,7 @@ static inline void check_and_switch_context(struct mm_struct *mm,
 	 */
 	cpu_set_reserved_ttbr0();
 
-	if (!((mm->context.id ^ cpu_last_asid) >> MAX_ASID_BITS))
+	if (!((mm->context.id ^ cpu_last_asid) >> max_asid_bits))
 		/*
 		 * The ASID is from the current generation, just switch to the
 		 * new pgd. This condition is only true for calls from
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 46d1125571f6..420fb6662309 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -58,6 +58,7 @@
 #include <asm/memblock.h>
 #include <asm/psci.h>
 #include <asm/efi.h>
+#include <asm/mmu_context.h>
 
 unsigned int processor_id;
 EXPORT_SYMBOL(processor_id);
@@ -200,7 +201,7 @@ static void __init smp_build_mpidr_hash(void)
 static void __init setup_processor(void)
 {
 	struct cpu_info *cpu_info;
-	u64 features, block;
+	u64 features, block, reg_value;
 	u32 cwg;
 	int cls;
 
@@ -219,6 +220,16 @@ static void __init setup_processor(void)
 	sprintf(init_utsname()->machine, ELF_PLATFORM);
 	elf_hwcap = 0;
 
+	/* Read the number of ASID bits */
+	reg_value = read_cpuid(ID_AA64MMFR0_EL1) & 0xf0;
+	if (reg_value == 0x00)
+		max_asid_bits = 8;
+	else if (reg_value == 0x20)
+		max_asid_bits = 16;
+	else
+		BUG_ON(1);
+	cpu_last_asid = 1 << max_asid_bits;
+
 	/*
 	 * Check for sane CTR_EL0.CWG value.
 	 */
diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
index baa758d37021..fbc4256d66ac 100644
--- a/arch/arm64/mm/context.c
+++ b/arch/arm64/mm/context.c
@@ -30,10 +30,9 @@
 #define asid_bits(reg) \
 	(((read_cpuid(ID_AA64MMFR0_EL1) & 0xf0) >> 2) + 8)
 
-#define ASID_FIRST_VERSION	(1 << MAX_ASID_BITS)
-
 static DEFINE_RAW_SPINLOCK(cpu_asid_lock);
-unsigned int cpu_last_asid = ASID_FIRST_VERSION;
+unsigned int max_asid_bits;
+unsigned int cpu_last_asid;
 
 /*
  * We fork()ed a process, and we need a new context for the child to run in.
@@ -66,7 +65,7 @@ static void set_mm_context(struct mm_struct *mm, unsigned int asid)
 	 * mm->context.id_lock has to be IRQ-safe.
 	 */
 	raw_spin_lock_irqsave(&mm->context.id_lock, flags);
-	if (likely((mm->context.id ^ cpu_last_asid) >> MAX_ASID_BITS)) {
+	if (likely((mm->context.id ^ cpu_last_asid) >> max_asid_bits)) {
 		/*
 		 * Old version of ASID found. Set the new one and reset
 		 * mm_cpumask(mm).
@@ -123,7 +122,7 @@ void __new_context(struct mm_struct *mm)
 	 * Check the ASID again, in case the change was broadcast from another
 	 * CPU before we acquired the lock.
 	 */
-	if (!unlikely((mm->context.id ^ cpu_last_asid) >> MAX_ASID_BITS)) {
+	if (!unlikely((mm->context.id ^ cpu_last_asid) >> max_asid_bits)) {
 		cpumask_set_cpu(smp_processor_id(), mm_cpumask(mm));
 		raw_spin_unlock(&cpu_asid_lock);
 		return;
@@ -142,9 +141,9 @@ void __new_context(struct mm_struct *mm)
 	 */
 	if (unlikely((asid & ((1 << bits) - 1)) == 0)) {
 		/* increment the ASID version */
-		cpu_last_asid += (1 << MAX_ASID_BITS) - (1 << bits);
+		cpu_last_asid += (1 << max_asid_bits) - (1 << bits);
 		if (cpu_last_asid == 0)
-			cpu_last_asid = ASID_FIRST_VERSION;
+			cpu_last_asid = 1 << max_asid_bits;
 		asid = cpu_last_asid + smp_processor_id();
 		flush_context();
 #ifdef CONFIG_SMP
-- 
1.8.1.5
