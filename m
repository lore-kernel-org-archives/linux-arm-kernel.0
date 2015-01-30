From: mathieu.poirier@linaro.org (mathieu.poirier at linaro.org)
Date: Fri, 30 Jan 2015 15:54:25 -0700
Subject: [PATCH 1/2] arm64: adding cpu lookup functionality
In-Reply-To: <1422658466-23984-1-git-send-email-mathieu.poirier@linaro.org>
References: <1422658466-23984-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1422658466-23984-2-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mathieu Poirier <mathieu.poirier@linaro.org>

Adding a lookup function allowing for quick and easy mapping
between processor HWID (as found, for example) in DT specifications
and the CPU index known to the kernel.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 arch/arm64/include/asm/smp_plat.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/include/asm/smp_plat.h b/arch/arm64/include/asm/smp_plat.h
index 59e282311b58..8e4b011303b1 100644
--- a/arch/arm64/include/asm/smp_plat.h
+++ b/arch/arm64/include/asm/smp_plat.h
@@ -19,6 +19,7 @@
 #ifndef __ASM_SMP_PLAT_H
 #define __ASM_SMP_PLAT_H
 
+#include <linux/cpumask.h>
 #include <asm/types.h>
 
 struct mpidr_hash {
@@ -40,4 +41,15 @@ static inline u32 mpidr_hash_size(void)
 extern u64 __cpu_logical_map[NR_CPUS];
 #define cpu_logical_map(cpu)    __cpu_logical_map[cpu]
 
+static inline int get_logical_index(u64 mpidr)
+{
+	int cpu;
+
+	for (cpu = 0; cpu < nr_cpu_ids; cpu++)
+		if (cpu_logical_map(cpu) == mpidr)
+			return cpu;
+	return -EINVAL;
+}
+
+
 #endif /* __ASM_SMP_PLAT_H */
-- 
1.9.1
