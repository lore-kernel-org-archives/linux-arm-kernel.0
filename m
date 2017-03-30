From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Thu, 30 Mar 2017 18:47:04 +0530
Subject: [PATCH v9 10/12] ARM: EXYNOS: move power_{down, up} to per SoC struct
 exynos_cpu_info
In-Reply-To: <1490879826-16754-1-git-send-email-pankaj.dubey@samsung.com>
References: <1490879826-16754-1-git-send-email-pankaj.dubey@samsung.com>
 <CGME20170330131440epcas1p4f27192272761aa593b6cf083453e8adc@epcas1p4.samsung.com>
Message-ID: <1490879826-16754-11-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Various Exynos SoC handles CPU power_up and power_down operation
differently. To handle this difference until now we were using
soc_is_exynosMMM helper functions, in an attempt to remove the dependency
of such helper functions specific to each SoC, let's move power_{down,up}
functionality as a SoC specific function pointer hooks in
struct exynos_cpu_info.

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 arch/arm/mach-exynos/platsmp.c | 61 +++++++++++++++++++++++++++++++-----------
 1 file changed, 46 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
index ff369b9..6f08b15 100644
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@ -37,9 +37,13 @@ extern void exynos4_secondary_startup(void);
 /*
  * struct exynos_cpu_info - Exynos CPU related info/operations
  * @cpu_boot_reg: computes cpu boot address for requested cpu
+ * @cpu_power_down: handles cpu power down routine for requested cpu
+ * @cpu_power_up: handles cpu power up routine for requested cpu
  */
 struct exynos_cpu_info {
 	void __iomem* (*cpu_boot_reg)(u32 cpu);
+	void (*cpu_power_down)(u32 cpu);
+	void (*cpu_power_up)(u32 cpu);
 };
 
 static const struct exynos_cpu_info *cpu_info;
@@ -92,19 +96,29 @@ static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
 }
 #endif /* CONFIG_HOTPLUG_CPU */
 
-/**
- * exynos_core_power_down : power down the specified cpu
+/*
+ * exynos_core_power_down - power down the specified cpu
  * @cpu : the cpu to power down
- *
- * Power down the specified cpu. The sequence must be finished by a
- * call to cpu_do_idle()
- *
+ * The sequence must be finished by a call to cpu_do_idle()
  */
 void exynos_cpu_power_down(int cpu)
 {
+	if (cpu_info && cpu_info->cpu_power_down)
+		cpu_info->cpu_power_down(cpu);
+}
+
+static void exynos_common_cpu_power_down(u32 cpu)
+{
 	u32 core_conf;
 
-	if (cpu == 0 && (soc_is_exynos5420() || soc_is_exynos5800())) {
+	core_conf = pmu_raw_readl(EXYNOS_ARM_CORE_CONFIGURATION(cpu));
+	core_conf &= ~S5P_CORE_LOCAL_PWR_EN;
+	pmu_raw_writel(core_conf, EXYNOS_ARM_CORE_CONFIGURATION(cpu));
+}
+
+static void exynos5420_cpu_power_down(u32 cpu)
+{
+	if (cpu == 0) {
 		/*
 		 * Bypass power down for CPU0 during suspend. Check for
 		 * the SYS_PWR_REG value to decide if we are suspending
@@ -116,24 +130,31 @@ void exynos_cpu_power_down(int cpu)
 			return;
 	}
 
-	core_conf = pmu_raw_readl(EXYNOS_ARM_CORE_CONFIGURATION(cpu));
-	core_conf &= ~S5P_CORE_LOCAL_PWR_EN;
-	pmu_raw_writel(core_conf, EXYNOS_ARM_CORE_CONFIGURATION(cpu));
+	exynos_common_cpu_power_down(cpu);
 }
 
-/**
+/*
  * exynos_cpu_power_up : power up the specified cpu
  * @cpu : the cpu to power up
- *
- * Power up the specified cpu
  */
 void exynos_cpu_power_up(int cpu)
 {
+	if (cpu_info && cpu_info->cpu_power_up)
+		cpu_info->cpu_power_up(cpu);
+}
+
+static void exynos_common_cpu_power_up(u32 cpu)
+{
 	u32 core_conf = S5P_CORE_LOCAL_PWR_EN;
+	pmu_raw_writel(core_conf,
+			EXYNOS_ARM_CORE_CONFIGURATION(cpu));
+}
 
-	if (soc_is_exynos3250())
-		core_conf |= S5P_CORE_AUTOWAKEUP_EN;
+static void exynos3250_cpu_power_up(u32 cpu)
+{
+	u32 core_conf = S5P_CORE_LOCAL_PWR_EN;
 
+	core_conf |= S5P_CORE_AUTOWAKEUP_EN;
 	pmu_raw_writel(core_conf,
 			EXYNOS_ARM_CORE_CONFIGURATION(cpu));
 }
@@ -339,22 +360,32 @@ int exynos_get_boot_addr(u32 core_id, unsigned long *boot_addr)
 
 static const struct exynos_cpu_info exynos3250_cpu_info = {
 	.cpu_boot_reg = exynos_common_cpu_boot_reg,
+	.cpu_power_down = exynos_common_cpu_power_down,
+	.cpu_power_up = exynos3250_cpu_power_up,
 };
 
 static const struct exynos_cpu_info exynos5420_cpu_info = {
 	.cpu_boot_reg = exynos5420_cpu_boot_reg,
+	.cpu_power_down = exynos5420_cpu_power_down,
+	.cpu_power_up = exynos_common_cpu_power_up,
 };
 
 static const struct exynos_cpu_info exynos4210_rev11_cpu_info = {
 	.cpu_boot_reg = exynos4210_rev11_cpu_boot_reg,
+	.cpu_power_down = exynos_common_cpu_power_down,
+	.cpu_power_up = exynos_common_cpu_power_up,
 };
 
 static const struct exynos_cpu_info exynos4412_cpu_info = {
 	.cpu_boot_reg = exynos4412_cpu_boot_reg,
+	.cpu_power_down = exynos_common_cpu_power_down,
+	.cpu_power_up = exynos_common_cpu_power_up,
 };
 
 static const struct exynos_cpu_info exynos_common_cpu_info = {
 	.cpu_boot_reg = exynos_common_cpu_boot_reg,
+	.cpu_power_down = exynos_common_cpu_power_down,
+	.cpu_power_up = exynos_common_cpu_power_up,
 };
 
 static const struct soc_device_attribute exynos_soc_revision[] = {
-- 
2.7.4
