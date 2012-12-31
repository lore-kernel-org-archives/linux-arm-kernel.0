From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 31 Dec 2012 11:09:40 -0800
Subject: [PATCH] ARM: EXYNOS: enable 4 cores secondary cpu up for exynos5440
Message-ID: <1356980980-3387-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No need to check power on/off with pmu control to support hotplug
in/out on exynos5440. And this patch enables 4 cores on exynos5440.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-exynos/platsmp.c |   37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
index c5c840e..495a501 100644
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@ -40,6 +40,8 @@ static inline void __iomem *cpu_boot_reg_base(void)
 {
 	if (soc_is_exynos4210() && samsung_rev() == EXYNOS4210_REV_1_1)
 		return S5P_INFORM5;
+	else if (soc_is_exynos5440())
+		return (S5P_VA_CHIPID + 0x560);
 	return S5P_VA_SYSRAM;
 }
 
@@ -116,27 +118,30 @@ static int __cpuinit exynos_boot_secondary(unsigned int cpu, struct task_struct
 	 */
 	write_pen_release(phys_cpu);
 
-	if (!(__raw_readl(S5P_ARM_CORE1_STATUS) & S5P_CORE_LOCAL_PWR_EN)) {
-		__raw_writel(S5P_CORE_LOCAL_PWR_EN,
-			     S5P_ARM_CORE1_CONFIGURATION);
+	if (!soc_is_exynos5440()) {
+		if (!(__raw_readl(S5P_ARM_CORE1_STATUS) & S5P_CORE_LOCAL_PWR_EN)) {
+			__raw_writel(S5P_CORE_LOCAL_PWR_EN,
+				     S5P_ARM_CORE1_CONFIGURATION);
 
-		timeout = 10;
+			timeout = 10;
 
-		/* wait max 10 ms until cpu1 is on */
-		while ((__raw_readl(S5P_ARM_CORE1_STATUS)
-			& S5P_CORE_LOCAL_PWR_EN) != S5P_CORE_LOCAL_PWR_EN) {
-			if (timeout-- == 0)
-				break;
+			/* wait max 10 ms until cpu1 is on */
+			while ((__raw_readl(S5P_ARM_CORE1_STATUS)
+				& S5P_CORE_LOCAL_PWR_EN) != S5P_CORE_LOCAL_PWR_EN) {
+				if (timeout-- == 0)
+					break;
 
-			mdelay(1);
-		}
+				mdelay(1);
+			}
 
-		if (timeout == 0) {
-			printk(KERN_ERR "cpu1 power enable failed");
-			spin_unlock(&boot_lock);
-			return -ETIMEDOUT;
+			if (timeout == 0) {
+				printk(KERN_ERR "cpu1 power enable failed");
+				spin_unlock(&boot_lock);
+				return -ETIMEDOUT;
+			}
 		}
 	}
+
 	/*
 	 * Send the secondary CPU a soft interrupt, thereby causing
 	 * the boot monitor to read the system wide flags register,
@@ -178,6 +183,8 @@ static void __init exynos_smp_init_cpus(void)
 
 	if (soc_is_exynos5250())
 		ncores = 2;
+	else if (soc_is_exynos5440())
+		ncores = 4;
 	else
 		ncores = scu_base ? scu_get_core_count(scu_base) : 1;
 
-- 
1.7.10.4
