From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Tue, 13 May 2014 17:28:42 +0530
Subject: [PATCH v6 3/5] arm: exynos: Add generic cluster power control
 functions
In-Reply-To: <1399982324-27879-1-git-send-email-a.kesavan@samsung.com>
References: <1399982324-27879-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <1399982324-27879-4-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add generic cluster power control functions for exynos based SoCS
for cluster power up/down and to know the cluster status.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
 arch/arm/mach-exynos/common.h   |    3 +++
 arch/arm/mach-exynos/pm.c       |   30 ++++++++++++++++++++++++++++++
 arch/arm/mach-exynos/regs-pmu.h |    6 ++++++
 3 files changed, 39 insertions(+)

diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
index 20adc2c..ae5f648 100644
--- a/arch/arm/mach-exynos/common.h
+++ b/arch/arm/mach-exynos/common.h
@@ -135,6 +135,9 @@ extern void exynos_sys_powerdown_conf(enum sys_powerdown mode);
 extern void exynos_cpu_power_down(int cpu);
 extern void exynos_cpu_power_up(int cpu);
 extern int  exynos_cpu_power_state(int cpu);
+extern void exynos_cluster_power_down(int cluster);
+extern void exynos_cluster_power_up(int cluster);
+extern int  exynos_cluster_power_state(int cluster);
 
 extern void s5p_init_cpu(void __iomem *cpuid_addr);
 extern unsigned int samsung_rev(void);
diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index 60c3356..aba2ff6 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -135,6 +135,36 @@ int exynos_cpu_power_state(int cpu)
 			S5P_CORE_LOCAL_PWR_EN);
 }
 
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
 /* For Cortex-A9 Diagnostic and Power control register */
 static unsigned int save_arm_register[2];
 
diff --git a/arch/arm/mach-exynos/regs-pmu.h b/arch/arm/mach-exynos/regs-pmu.h
index 98fb8d8..f6b68a3 100644
--- a/arch/arm/mach-exynos/regs-pmu.h
+++ b/arch/arm/mach-exynos/regs-pmu.h
@@ -111,6 +111,12 @@
 #define EXYNOS_ARM_CORE_STATUS(_nr)		\
 			(EXYNOS_ARM_CORE_CONFIGURATION(_nr) + 0x4)
 
+#define EXYNOS_ARM_COMMON_CONFIGURATION		S5P_PMUREG(0x2500)
+#define EXYNOS_COMMON_CONFIGURATION(_nr)	\
+			(EXYNOS_ARM_COMMON_CONFIGURATION + (0x80 * (_nr)))
+#define EXYNOS_COMMON_STATUS(_nr)		\
+			(EXYNOS_COMMON_CONFIGURATION(_nr) + 0x4)
+
 #define S5P_PAD_RET_MAUDIO_OPTION		S5P_PMUREG(0x3028)
 #define S5P_PAD_RET_GPIO_OPTION			S5P_PMUREG(0x3108)
 #define S5P_PAD_RET_UART_OPTION			S5P_PMUREG(0x3128)
-- 
1.7.9.5
