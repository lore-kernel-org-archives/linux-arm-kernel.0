From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 18 May 2015 11:38:13 +0100
Subject: [PATCHv2 02/12] arm64: smp_plat: add get_logical_index
In-Reply-To: <1431945503-6939-1-git-send-email-mark.rutland@arm.com>
References: <1431945503-6939-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1431945503-6939-3-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PSCI MIGRATE_INFO_UP_CPU call returns a physical ID, which we will
need to map back to a Linux logical ID.

Implement a reusable get_logical_index to map from a physical ID to a
logical ID.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/smp_plat.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/include/asm/smp_plat.h b/arch/arm64/include/asm/smp_plat.h
index 8dcd61e..7abf757 100644
--- a/arch/arm64/include/asm/smp_plat.h
+++ b/arch/arm64/include/asm/smp_plat.h
@@ -19,6 +19,8 @@
 #ifndef __ASM_SMP_PLAT_H
 #define __ASM_SMP_PLAT_H
 
+#include <linux/cpumask.h>
+
 #include <asm/types.h>
 
 struct mpidr_hash {
@@ -39,6 +41,20 @@ static inline u32 mpidr_hash_size(void)
  */
 extern u64 __cpu_logical_map[NR_CPUS];
 #define cpu_logical_map(cpu)    __cpu_logical_map[cpu]
+/*
+ * Retrieve logical cpu index corresponding to a given MPIDR.Aff*
+ *  - mpidr: MPIDR.Aff* bits to be used for the look-up
+ *
+ * Returns the cpu logical index or -EINVAL on look-up error
+ */
+static inline int get_logical_index(u64 mpidr)
+{
+	int cpu;
+	for (cpu = 0; cpu < nr_cpu_ids; cpu++)
+		if (cpu_logical_map(cpu) == mpidr)
+			return cpu;
+	return -EINVAL;
+}
 
 void __init do_post_cpus_up_work(void);
 
-- 
1.9.1
