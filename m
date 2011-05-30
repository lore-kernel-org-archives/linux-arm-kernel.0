From: inderpal.singh@linaro.org (Inderpal Singh)
Date: Mon, 30 May 2011 14:43:01 +0530
Subject: [PATCH] ARM: EXYNOS4: Fix secondary CPU boot after wake-up
Message-ID: <1306746781-21511-1-git-send-email-inderpal.s@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

1. After wake-up, the system-wide flags register loses its value.
   Hence, write the address of secondary startup function to
   successfully boot the secondary CPU.

2. Fix to remove the "Unknown IPI message 0x1" message when
   secondary CPU boots.

Signed-off-by: Inderpal Singh <inderpal.s@samsung.com>
---
 arch/arm/mach-exynos4/platsmp.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-exynos4/platsmp.c b/arch/arm/mach-exynos4/platsmp.c
index 6d35878..11234c7 100644
--- a/arch/arm/mach-exynos4/platsmp.c
+++ b/arch/arm/mach-exynos4/platsmp.c
@@ -100,11 +100,17 @@ int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
 	write_pen_release(cpu);
 
 	/*
+	 * After wake-up, the system-wide flags register loses its value.
+	 * Hence, write the address of secondary startup function again.
+	 */ 
+	 __raw_writel(BSYM(virt_to_phys(exynos4_secondary_startup)), S5P_VA_SYSRAM);
+
+	/*
 	 * Send the secondary CPU a soft interrupt, thereby causing
 	 * the boot monitor to read the system wide flags register,
 	 * and branch to the address found there.
 	 */
-	smp_cross_call(cpumask_of(cpu), 1);
+	smp_send_reschedule(cpu);
 
 	timeout = jiffies + (1 * HZ);
 	while (time_before(jiffies, timeout)) {
-- 
1.7.1
