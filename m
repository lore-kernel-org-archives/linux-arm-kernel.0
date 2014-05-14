From: chander.kashyap@linaro.org (Chander Kashyap)
Date: Wed, 14 May 2014 13:33:53 +0530
Subject: [PATCH v5 2/6] arm: exynos: add generic function to calculate cpu
 number
In-Reply-To: <1400054637-21505-1-git-send-email-chander.kashyap@linaro.org>
References: <ANuQgHGSPJ45tbrVppAVpOqF0OfHacPWfX=S5mOVxTPr66f7vg@mail.gmail.com>
 <1400054637-21505-1-git-send-email-chander.kashyap@linaro.org>
Message-ID: <1400054637-21505-3-git-send-email-chander.kashyap@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The address of cpu power registers in pmu is based on cpu number
offsets. This function calculate the same. This is essentially
required in case of multi-cluster SoC's e.g Exynos5420.

Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
Signed-off-by: Chander Kashyap <k.chander@samsung.com>
---
 arch/arm/mach-exynos/regs-pmu.h |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/mach-exynos/regs-pmu.h b/arch/arm/mach-exynos/regs-pmu.h
index 4179f6a..485aefd 100644
--- a/arch/arm/mach-exynos/regs-pmu.h
+++ b/arch/arm/mach-exynos/regs-pmu.h
@@ -325,4 +325,13 @@
 
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
