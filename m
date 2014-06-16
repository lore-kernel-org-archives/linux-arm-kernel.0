From: k.chander@samsung.com (Chander Kashyap)
Date: Mon, 16 Jun 2014 15:56:19 +0530
Subject: [Patch v7 2/6] arm: exynos: add generic function to calculate cpu
 number
In-Reply-To: <1402914383-20471-1-git-send-email-k.chander@samsung.com>
References: <1402914383-20471-1-git-send-email-k.chander@samsung.com>
Message-ID: <1402914383-20471-3-git-send-email-k.chander@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chander Kashyap <chander.kashyap@linaro.org>

The address of cpu power registers in pmu is based on cpu number
offsets. This function calculate the same. This is essentially
required in case of multi-cluster SoC's e.g Exynos5420.

Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
Signed-off-by: Chander Kashyap <k.chander@samsung.com>
Reviewed-by: Tomasz Figa <t.figa@samsung.com>
---
 arch/arm/mach-exynos/regs-pmu.h |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/mach-exynos/regs-pmu.h b/arch/arm/mach-exynos/regs-pmu.h
index 1d13b08..aff23bd 100644
--- a/arch/arm/mach-exynos/regs-pmu.h
+++ b/arch/arm/mach-exynos/regs-pmu.h
@@ -323,4 +323,13 @@
 
 #define EXYNOS5420_SWRESET_KFC_SEL				0x3
 
+#include <asm/cputype.h>
+#define MAX_CPUS_IN_CLUSTER	4
+
+static inline unsigned int exynos_pmu_cpunr(unsigned int mpidr)
+{
+	return ((MPIDR_AFFINITY_LEVEL(mpidr, 1) * MAX_CPUS_IN_CLUSTER)
+		 + MPIDR_AFFINITY_LEVEL(mpidr, 0));
+}
+
 #endif /* __ASM_ARCH_REGS_PMU_H */
-- 
1.7.9.5
