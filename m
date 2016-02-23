From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue, 23 Feb 2016 10:31:45 +0000
Subject: [PATCH v5 7/7] arm64: Ensure the secondary CPUs have safe ASIDBits
 size
In-Reply-To: <1456223505-2955-1-git-send-email-suzuki.poulose@arm.com>
References: <1456223505-2955-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1456223505-2955-8-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds a hook for checking whether a secondary CPU has the
features used already by the kernel during early boot, based
on the boot CPU and plugs in the check for ASID size.

The ID_AA64MMFR0_EL1:ASIDBits determines the size of the mm context
id and is used in the early boot to make decisions. The value is
picked up from the Boot CPU and cannot be delayed until other CPUs
are up. If a secondary CPU has a smaller size than that of the Boot
CPU, things will break horribly and the usual SANITY check is not good
enough to prevent the system from crashing. So, crash the system with
enough information.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/mmu_context.h |    2 ++
 arch/arm64/kernel/cpufeature.c       |   12 ++++++++++++
 arch/arm64/mm/context.c              |   18 ++++++++++++++++++
 3 files changed, 32 insertions(+)

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
index 5ba3ef1..3614066 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -24,6 +24,7 @@
 #include <asm/cpu.h>
 #include <asm/cpufeature.h>
 #include <asm/cpu_ops.h>
+#include <asm/mmu_context.h>
 #include <asm/processor.h>
 #include <asm/sysreg.h>
 
@@ -825,6 +826,15 @@ static u64 __raw_read_system_reg(u32 sys_id)
 }
 
 /*
+ * Check for CPU features that are used in early boot
+ * based on the Boot CPU value.
+ */
+static void check_early_cpu_features(void)
+{
+	verify_cpu_asid_bits();
+}
+
+/*
  * Run through the enabled system capabilities and enable() it on this CPU.
  * The capabilities were decided based on the available CPUs at the boot time.
  * Any new CPU should match the system wide status of the capability. If the
@@ -837,6 +847,8 @@ void verify_local_cpu_capabilities(void)
 	int i;
 	const struct arm64_cpu_capabilities *caps;
 
+	check_early_cpu_features();
+
 	/*
 	 * If we haven't computed the system capabilities, there is nothing
 	 * to verify.
diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
index 643bf4b..3b23cb4 100644
--- a/arch/arm64/mm/context.c
+++ b/arch/arm64/mm/context.c
@@ -24,6 +24,7 @@
 
 #include <asm/cpufeature.h>
 #include <asm/mmu_context.h>
+#include <asm/smp.h>
 #include <asm/tlbflush.h>
 
 static u32 asid_bits;
@@ -62,6 +63,23 @@ static u32 get_cpu_asid_bits(void)
 	return asid;
 }
 
+/* Check if the current cpu's ASIDBits is compatible with asid_bits */
+void verify_cpu_asid_bits(void)
+{
+	u32 asid = get_cpu_asid_bits();
+
+	if (asid < asid_bits) {
+		/*
+		 * We cannot decrease the ASID size@runtime, so panic if we support
+		 * fewer ASID bits than the boot CPU.
+		 */
+		pr_crit("CPU%d: smaller ASID size(%u) than boot CPU (%u)\n",
+				smp_processor_id(), asid, asid_bits);
+		update_cpu_boot_status(CPU_PANIC_KERNEL);
+		cpu_park_loop();
+	}
+}
+
 static void flush_context(unsigned int cpu)
 {
 	int i;
-- 
1.7.9.5
