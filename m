From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue, 12 Apr 2016 15:46:00 +0100
Subject: [PATCH 1/2] arm64: Add cpu_panic_kernel helper
Message-ID: <1460472361-28419-1-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

During the activation of a secondary CPU, we could report serious
configuration issues and hence request to crash the kernel. We do
this for CPU ASID bit check now. We will need it also for handling
mismatched exception levels for the CPUs with VHE. Hence, add a
helper to do the same for reusability.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/smp.h |   11 +++++++++++
 arch/arm64/mm/context.c      |    3 +--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
index 817a067..433e504 100644
--- a/arch/arm64/include/asm/smp.h
+++ b/arch/arm64/include/asm/smp.h
@@ -113,6 +113,17 @@ static inline void update_cpu_boot_status(int val)
 	dsb(ishst);
 }
 
+/*
+ * The calling secondary CPU has detected serious configuration mismatch,
+ * which calls for a kernel panic. Update the boot status and park the calling
+ * CPU.
+ */
+static inline void cpu_panic_kernel(void)
+{
+	update_cpu_boot_status(CPU_PANIC_KERNEL);
+	cpu_park_loop();
+}
+
 #endif /* ifndef __ASSEMBLY__ */
 
 #endif /* ifndef __ASM_SMP_H */
diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
index c90c3c5..b7b3978 100644
--- a/arch/arm64/mm/context.c
+++ b/arch/arm64/mm/context.c
@@ -75,8 +75,7 @@ void verify_cpu_asid_bits(void)
 		 */
 		pr_crit("CPU%d: smaller ASID size(%u) than boot CPU (%u)\n",
 				smp_processor_id(), asid, asid_bits);
-		update_cpu_boot_status(CPU_PANIC_KERNEL);
-		cpu_park_loop();
+		cpu_panic_kernel();
 	}
 }
 
-- 
1.7.9.5
