From: robherring2@gmail.com (Rob Herring)
Date: Thu, 12 Jan 2012 11:31:13 -0600
Subject: [PATCH v2 4/7] ARM: exynos: remove incorrect BSYM usage
In-Reply-To: <1326389476-11569-1-git-send-email-robherring2@gmail.com>
References: <1326389476-11569-1-git-send-email-robherring2@gmail.com>
Message-ID: <1326389476-11569-5-git-send-email-robherring2@gmail.com>
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
 arch/arm/mach-exynos/headsmp.S |    1 +
 arch/arm/mach-exynos/platsmp.c |    5 ++---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-exynos/headsmp.S b/arch/arm/mach-exynos/headsmp.S
index 3cdeb36..b6a0ee2 100644
--- a/arch/arm/mach-exynos/headsmp.S
+++ b/arch/arm/mach-exynos/headsmp.S
@@ -36,6 +36,7 @@ pen:	ldr	r7, [r6]
 	 * should now contain the SVC stack for this core
 	 */
 	b	secondary_startup
+ENDPROC(exynos4_secondary_startup)
 
 1:	.long	.
 	.long	pen_release
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
