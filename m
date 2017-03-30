From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Thu, 30 Mar 2017 18:47:05 +0530
Subject: [PATCH v9 11/12] ARM: EXYNOS: move cpu_restart as a SoC specific
 hook to exynos_cpu_info
In-Reply-To: <1490879826-16754-1-git-send-email-pankaj.dubey@samsung.com>
References: <1490879826-16754-1-git-send-email-pankaj.dubey@samsung.com>
 <CGME20170330131442epcas5p4f2be72cb3ec506847d8e832675e682c4@epcas5p4.samsung.com>
Message-ID: <1490879826-16754-12-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To handle differences in cpu_restart functionality among various Exynos SoC
let's move cpu_restart as a SoC specific function hook to exynos_cpu_info.

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 arch/arm/mach-exynos/platsmp.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
index 6f08b15..af9332c 100644
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@ -39,11 +39,13 @@ extern void exynos4_secondary_startup(void);
  * @cpu_boot_reg: computes cpu boot address for requested cpu
  * @cpu_power_down: handles cpu power down routine for requested cpu
  * @cpu_power_up: handles cpu power up routine for requested cpu
+ * @cpu_restart: handles cpu restart routine for requested cpu
  */
 struct exynos_cpu_info {
 	void __iomem* (*cpu_boot_reg)(u32 cpu);
 	void (*cpu_power_down)(u32 cpu);
 	void (*cpu_power_up)(u32 cpu);
+	void (*cpu_restart)(u32 cpu);
 };
 
 static const struct exynos_cpu_info *cpu_info;
@@ -252,16 +254,19 @@ static inline void __iomem *cpu_boot_reg(int cpu)
 }
 
 /*
- * Set wake up by local power mode and execute software reset for given core.
- *
+ * exynos_core_restart : restart the specified cpu
+ * @core_id : the cpu to be restarted
  * Currently this is needed only when booting secondary CPU on Exynos3250.
  */
 void exynos_core_restart(u32 core_id)
 {
-	u32 val;
+	if (cpu_info && cpu_info->cpu_restart)
+		cpu_info->cpu_restart(core_id);
+}
 
-	if (!of_machine_is_compatible("samsung,exynos3250"))
-		return;
+static void exynos3250_core_restart(u32 core_id)
+{
+	u32 val;
 
 	while (!pmu_raw_readl(S5P_PMU_SPARE2))
 		udelay(10);
@@ -362,6 +367,7 @@ static const struct exynos_cpu_info exynos3250_cpu_info = {
 	.cpu_boot_reg = exynos_common_cpu_boot_reg,
 	.cpu_power_down = exynos_common_cpu_power_down,
 	.cpu_power_up = exynos3250_cpu_power_up,
+	.cpu_restart = exynos3250_core_restart,
 };
 
 static const struct exynos_cpu_info exynos5420_cpu_info = {
-- 
2.7.4
