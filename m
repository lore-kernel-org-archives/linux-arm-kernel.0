From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Tue, 13 May 2014 17:28:40 +0530
Subject: [PATCH v6 1/5] ARM: EXYNOS: Add generic cpu power control functions
 for all exynos based SoCs
In-Reply-To: <1399982324-27879-1-git-send-email-a.kesavan@samsung.com>
References: <1399982324-27879-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <1399982324-27879-2-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Leela Krishna Amudala <leela.krishna@linaro.org>

Add generic cpu power control functions for exynos based SoCS
for cpu power up/down and to know the cpu status.

Signed-off-by: Leela Krishna Amudala <leela.krishna@linaro.org>
Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
 arch/arm/mach-exynos/common.h   |    3 +++
 arch/arm/mach-exynos/pm.c       |   36 ++++++++++++++++++++++++++++++++++++
 arch/arm/mach-exynos/regs-pmu.h |    6 ++++++
 3 files changed, 45 insertions(+)

diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
index 278b573..20adc2c 100644
--- a/arch/arm/mach-exynos/common.h
+++ b/arch/arm/mach-exynos/common.h
@@ -132,6 +132,9 @@ struct exynos_pmu_conf {
 };
 
 extern void exynos_sys_powerdown_conf(enum sys_powerdown mode);
+extern void exynos_cpu_power_down(int cpu);
+extern void exynos_cpu_power_up(int cpu);
+extern int  exynos_cpu_power_state(int cpu);
 
 extern void s5p_init_cpu(void __iomem *cpuid_addr);
 extern unsigned int samsung_rev(void);
diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index ca672e2..60c3356 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -99,6 +99,42 @@ static int exynos_irq_set_wake(struct irq_data *data, unsigned int state)
 	return -ENOENT;
 }
 
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
 /* For Cortex-A9 Diagnostic and Power control register */
 static unsigned int save_arm_register[2];
 
diff --git a/arch/arm/mach-exynos/regs-pmu.h b/arch/arm/mach-exynos/regs-pmu.h
index 4f6a256..84634ac 100644
--- a/arch/arm/mach-exynos/regs-pmu.h
+++ b/arch/arm/mach-exynos/regs-pmu.h
@@ -105,6 +105,12 @@
 #define S5P_GPS_LOWPWR				S5P_PMUREG(0x139C)
 #define S5P_GPS_ALIVE_LOWPWR			S5P_PMUREG(0x13A0)
 
+#define EXYNOS_ARM_CORE0_CONFIGURATION		S5P_PMUREG(0x2000)
+#define EXYNOS_ARM_CORE_CONFIGURATION(_nr)	\
+			(EXYNOS_ARM_CORE0_CONFIGURATION + (0x80 * (_nr)))
+#define EXYNOS_ARM_CORE_STATUS(_nr)		\
+			(EXYNOS_ARM_CORE_CONFIGURATION(_nr) + 0x4)
+
 #define S5P_ARM_CORE1_CONFIGURATION		S5P_PMUREG(0x2080)
 #define S5P_ARM_CORE1_STATUS			S5P_PMUREG(0x2084)
 
-- 
1.7.9.5
