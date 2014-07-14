From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 14 Jul 2014 09:45:53 +0200
Subject: [PATCH v2] ARM: EXYNOS: Fix build with PM_SLEEP=n
Message-ID: <1405323953-25954-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix building of exynos defconfig with disabled PM_SLEEP:
CONFIG_PM_SLEEP=n
CONFIG_PM_SLEEP_SMP=n
CONFIG_SUSPEND=n
by moving functions for power up/down of CPU and cluster to platsmp.c

The build error messages:
arch/arm/mach-exynos/built-in.o: In function `exynos_boot_secondary':
arch/arm/mach-exynos/platsmp.c:111: undefined reference to `exynos_cpu_power_state'
arch/arm/mach-exynos/platsmp.c:112: undefined reference to `exynos_cpu_power_up'
arch/arm/mach-exynos/platsmp.c:116: undefined reference to `exynos_cpu_power_state'
make: *** [vmlinux] Error 1

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

---
Changes since v1:
1. Use different solution - just move the power up/down functions to a
   common place instead of adding stubs in common.h. Suggested by Tomasz
   Figa.
---
 arch/arm/mach-exynos/platsmp.c | 66 ++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-exynos/pm.c      | 66 ------------------------------------------
 2 files changed, 66 insertions(+), 66 deletions(-)

diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
index b15ea30faa7c..d435175671e0 100644
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@ -31,6 +31,72 @@
 
 extern void exynos4_secondary_startup(void);
 
+/**
+ * exynos_core_power_down : power down the specified cpu
+ * @cpu : the cpu to power down
+ *
+ * Power down the specified cpu. The sequence must be finished by a
+ * call to cpu_do_idle()
+ *
+ */
+void exynos_cpu_power_down(int cpu)
+{
+	__raw_writel(0, EXYNOS_ARM_CORE_CONFIGURATION(cpu));
+}
+
+/**
+ * exynos_cpu_power_up : power up the specified cpu
+ * @cpu : the cpu to power up
+ *
+ * Power up the specified cpu
+ */
+void exynos_cpu_power_up(int cpu)
+{
+	__raw_writel(S5P_CORE_LOCAL_PWR_EN,
+		     EXYNOS_ARM_CORE_CONFIGURATION(cpu));
+}
+
+/**
+ * exynos_cpu_power_state : returns the power state of the cpu
+ * @cpu : the cpu to retrieve the power state from
+ *
+ */
+int exynos_cpu_power_state(int cpu)
+{
+	return (__raw_readl(EXYNOS_ARM_CORE_STATUS(cpu)) &
+			S5P_CORE_LOCAL_PWR_EN);
+}
+
+/**
+ * exynos_cluster_power_down : power down the specified cluster
+ * @cluster : the cluster to power down
+ */
+void exynos_cluster_power_down(int cluster)
+{
+	__raw_writel(0, EXYNOS_COMMON_CONFIGURATION(cluster));
+}
+
+/**
+ * exynos_cluster_power_up : power up the specified cluster
+ * @cluster : the cluster to power up
+ */
+void exynos_cluster_power_up(int cluster)
+{
+	__raw_writel(S5P_CORE_LOCAL_PWR_EN,
+		     EXYNOS_COMMON_CONFIGURATION(cluster));
+}
+
+/**
+ * exynos_cluster_power_state : returns the power state of the cluster
+ * @cluster : the cluster to retrieve the power state from
+ *
+ */
+int exynos_cluster_power_state(int cluster)
+{
+	return (__raw_readl(EXYNOS_COMMON_STATUS(cluster)) &
+			S5P_CORE_LOCAL_PWR_EN);
+}
+
 static inline void __iomem *cpu_boot_reg_base(void)
 {
 	if (soc_is_exynos4210() && samsung_rev() == EXYNOS4210_REV_1_1)
diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index fa7218a99580..6ab68a068e93 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -101,72 +101,6 @@ static int exynos_irq_set_wake(struct irq_data *data, unsigned int state)
 	return -ENOENT;
 }
 
-/**
- * exynos_core_power_down : power down the specified cpu
- * @cpu : the cpu to power down
- *
- * Power down the specified cpu. The sequence must be finished by a
- * call to cpu_do_idle()
- *
- */
-void exynos_cpu_power_down(int cpu)
-{
-	__raw_writel(0, EXYNOS_ARM_CORE_CONFIGURATION(cpu));
-}
-
-/**
- * exynos_cpu_power_up : power up the specified cpu
- * @cpu : the cpu to power up
- *
- * Power up the specified cpu
- */
-void exynos_cpu_power_up(int cpu)
-{
-	__raw_writel(S5P_CORE_LOCAL_PWR_EN,
-		     EXYNOS_ARM_CORE_CONFIGURATION(cpu));
-}
-
-/**
- * exynos_cpu_power_state : returns the power state of the cpu
- * @cpu : the cpu to retrieve the power state from
- *
- */
-int exynos_cpu_power_state(int cpu)
-{
-	return (__raw_readl(EXYNOS_ARM_CORE_STATUS(cpu)) &
-			S5P_CORE_LOCAL_PWR_EN);
-}
-
-/**
- * exynos_cluster_power_down : power down the specified cluster
- * @cluster : the cluster to power down
- */
-void exynos_cluster_power_down(int cluster)
-{
-	__raw_writel(0, EXYNOS_COMMON_CONFIGURATION(cluster));
-}
-
-/**
- * exynos_cluster_power_up : power up the specified cluster
- * @cluster : the cluster to power up
- */
-void exynos_cluster_power_up(int cluster)
-{
-	__raw_writel(S5P_CORE_LOCAL_PWR_EN,
-		     EXYNOS_COMMON_CONFIGURATION(cluster));
-}
-
-/**
- * exynos_cluster_power_state : returns the power state of the cluster
- * @cluster : the cluster to retrieve the power state from
- *
- */
-int exynos_cluster_power_state(int cluster)
-{
-	return (__raw_readl(EXYNOS_COMMON_STATUS(cluster)) &
-			S5P_CORE_LOCAL_PWR_EN);
-}
-
 #define EXYNOS_BOOT_VECTOR_ADDR	(samsung_rev() == EXYNOS4210_REV_1_1 ? \
 			S5P_INFORM7 : (samsung_rev() == EXYNOS4210_REV_1_0 ? \
 			(sysram_base_addr + 0x24) : S5P_INFORM0))
-- 
1.9.1
