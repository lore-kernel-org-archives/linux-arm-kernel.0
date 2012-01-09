From: robherring2@gmail.com (Rob Herring)
Date: Mon,  9 Jan 2012 16:45:41 -0600
Subject: [PATCH 1/6] ARM: exynos: remove incorrect BSYM usage
In-Reply-To: <1326149146-19756-1-git-send-email-robherring2@gmail.com>
References: <1326149146-19756-1-git-send-email-robherring2@gmail.com>
Message-ID: <1326149146-19756-2-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

BSYM macro is only needed for assembly files and its usage in c files is
wrong, so remove it. The linker will correctly set bit 0 for Thumb2
kernels.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Dave Martin <dave.martin@linaro.org>
Cc: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-exynos/platsmp.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
index 60bc45e..683aec7 100644
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@ -24,7 +24,6 @@
 #include <asm/cacheflush.h>
 #include <asm/hardware/gic.h>
 #include <asm/smp_scu.h>
-#include <asm/unified.h>
 
 #include <mach/hardware.h>
 #include <mach/regs-clock.h>
@@ -137,7 +136,7 @@ int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
 	while (time_before(jiffies, timeout)) {
 		smp_rmb();
 
-		__raw_writel(BSYM(virt_to_phys(exynos4_secondary_startup)),
+		__raw_writel(virt_to_phys(exynos4_secondary_startup),
 			CPU1_BOOT_REG);
 		gic_raise_softirq(cpumask_of(cpu), 1);
 
@@ -192,6 +191,6 @@ void __init platform_smp_prepare_cpus(unsigned int max_cpus)
 	 * until it receives a soft interrupt, and then the
 	 * secondary CPU branches to this address.
 	 */
-	__raw_writel(BSYM(virt_to_phys(exynos4_secondary_startup)),
+	__raw_writel(virt_to_phys(exynos4_secondary_startup),
 			CPU1_BOOT_REG);
 }
-- 
1.7.5.4
