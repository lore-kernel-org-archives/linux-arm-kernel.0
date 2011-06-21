From: inderpal.singh@linaro.org (Inderpal Singh)
Date: Tue, 21 Jun 2011 11:03:05 +0530
Subject: [PATCH] ARM: EXYNOS4: Fix secondary CPU boot after wake-up
Message-ID: <1308634385-8544-1-git-send-email-inderpal.singh@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

1. After wake-up, the system-wide flags register loses its value.
   Hence, write the address of secondary startup function to
   successfully boot the secondary CPU.

2. Changes SGI1 to SGI0 for secondary CPU boot up

Signed-off-by: Inderpal Singh <inderpal.s@samsung.com>
---
1. The below patch is mandatory to boot secondary CPU after wake-up from sleep
http://permalink.gmane.org/gmane.linux.kernel.samsung-soc/4850

2. The change SGI1 to SGI0 for secondary CPU boot up is done as discussed 
at following link
http://comments.gmane.org/gmane.linux.kernel.samsung-soc/4877

 arch/arm/mach-exynos4/platsmp.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-exynos4/platsmp.c b/arch/arm/mach-exynos4/platsmp.c
index c5e65a0..061260c 100644
--- a/arch/arm/mach-exynos4/platsmp.c
+++ b/arch/arm/mach-exynos4/platsmp.c
@@ -101,11 +101,18 @@ int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
 	write_pen_release(cpu);
 
 	/*
+	* After wake-up, the system-wide flags register loses its value.
+	* Hence, write the address of secondary startup function again.
+	*/ 
+	__raw_writel(BSYM(virt_to_phys(exynos4_secondary_startup)), S5P_VA_SYSRAM);
+
+
+	/*
 	 * Send the secondary CPU a soft interrupt, thereby causing
 	 * the boot monitor to read the system wide flags register,
 	 * and branch to the address found there.
 	 */
-	gic_raise_softirq(cpumask_of(cpu), 1);
+	gic_raise_softirq(cpumask_of(cpu), 0);
 
 	timeout = jiffies + (1 * HZ);
 	while (time_before(jiffies, timeout)) {
-- 
1.7.1
