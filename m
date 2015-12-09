From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Wed,  9 Dec 2015 09:57:19 +0000
Subject: [RFC PATCH v3 8/8] arm64: Ensure the secondary CPUs have safe
 ASIDBits size
In-Reply-To: <1449655039-22022-1-git-send-email-suzuki.poulose@arm.com>
References: <1449655039-22022-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1449655039-22022-9-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ID_AA64MMFR0_EL1:ASIDBits determines the size of the mm context
id and is used in the early boot to make decisions. The value is
picked up from the Boot CPU and cannot be delayed until other CPUs
are up. If a secondary CPU has a smaller size than that of the Boot
CPU, things will break horribly and the usual SANITY check is not good
enough to prevent the system from crashing. So, crash the system with
enough information.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/mmu_context.h |    2 ++
 arch/arm64/kernel/cpufeature.c       |    2 ++
 arch/arm64/mm/context.c              |   16 ++++++++++++++++
 3 files changed, 20 insertions(+)

diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index 2416578..bd8a0b9 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -147,4 +147,6 @@ switch_mm(struct mm_struct *prev, struct mm_struct *next,
 #define deactivate_mm(tsk,mm)	do { } while (0)
 #define activate_mm(prev,next)	switch_mm(prev, next, NULL)
 
+void verify_cpu_asid_bits(void);
+
 #endif
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index e63da0f..f7bcd30 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -24,6 +24,7 @@
 #include <asm/cpu.h>
 #include <asm/cpufeature.h>
 #include <asm/cpu_ops.h>
+#include <asm/mmu_context.h>
 #include <asm/processor.h>
 #include <asm/sysreg.h>
 
@@ -829,6 +830,7 @@ static u64 __raw_read_system_reg(u32 sys_id)
  */
 static void check_early_cpu_features(void)
 {
+	verify_cpu_asid_bits();
 }
 
 /*
diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
index 643bf4b..b945bb4 100644
--- a/arch/arm64/mm/context.c
+++ b/arch/arm64/mm/context.c
@@ -24,6 +24,7 @@
 
 #include <asm/cpufeature.h>
 #include <asm/mmu_context.h>
+#include <asm/smp.h>
 #include <asm/tlbflush.h>
 
 static u32 asid_bits;
@@ -62,6 +63,21 @@ static u32 get_cpu_asid_bits(void)
 	return asid;
 }
 
+/* Check if the current cpu's ASIDBits is compatible with asid_bits */
+void verify_cpu_asid_bits(void)
+{
+	u32 asid = get_cpu_asid_bits();
+
+	if (asid < asid_bits) {
+		/* Differing ASIDBits is dangerous, crash the system */
+		pr_crit("CPU%d: has smaller ASIDBits(%u) than the one in use (%u)\n",
+				smp_processor_id(), asid, asid_bits);
+		update_cpu_boot_status(CPU_PANIC_KERNEL);
+		isb();
+		while(1);
+	}
+}
+
 static void flush_context(unsigned int cpu)
 {
 	int i;
-- 
1.7.9.5
