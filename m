From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Thu, 30 Mar 2017 18:47:01 +0530
Subject: [PATCH v9 07/12] ARM: EXYNOS: introduce soc specific pm ops
In-Reply-To: <1490879826-16754-1-git-send-email-pankaj.dubey@samsung.com>
References: <1490879826-16754-1-git-send-email-pankaj.dubey@samsung.com>
 <CGME20170330131434epcas1p4e42fe06bae3456c39e0f93a2f8ae4bc0@epcas1p4.samsung.com>
Message-ID: <1490879826-16754-8-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For s2r various Exynos SoC needs different programming sequence and data.
Currently this is handled by adding lots of soc_is_exynosMMM checks in the
code, in an attempt to remove the dependency of such helper functions
specific to each SoC, let's separate these programming sequence by
introducing a new struct exynos_s2r_data. This struct will contain
different function hooks and data for differentiating these programming
sequences based on SoC's soc_id and revision parameters which can be
matched by using generic API "soc_device_match".

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 arch/arm/mach-exynos/pm.c | 122 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 116 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index 4a73b02..fa24098 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -20,6 +20,7 @@
 #include <linux/of.h>
 #include <linux/soc/samsung/exynos-regs-pmu.h>
 #include <linux/soc/samsung/exynos-pmu.h>
+#include <linux/sys_soc.h>
 
 #include <asm/firmware.h>
 #include <asm/smp_scu.h>
@@ -30,6 +31,12 @@
 
 #include "common.h"
 
+struct exynos_s2r_data {
+	void (*enter_aftr)(void);
+};
+
+static const struct exynos_s2r_data *s2r_data;
+
 static inline void __iomem *exynos_boot_vector_addr(void)
 {
 	if (samsung_rev() == EXYNOS4210_REV_1_1)
@@ -160,13 +167,26 @@ static int exynos_aftr_finisher(unsigned long flags)
 
 void exynos_enter_aftr(void)
 {
+	if (s2r_data && s2r_data->enter_aftr)
+		s2r_data->enter_aftr();
+}
+
+static void exynos3_enter_aftr(void)
+{
 	unsigned int cpuid = smp_processor_id();
 
 	cpu_pm_enter();
+	exynos_set_boot_flag(cpuid, C2_STATE);
+	exynos_pm_central_suspend();
+	cpu_suspend(0, exynos_aftr_finisher);
+	exynos_pm_central_resume();
+	exynos_clear_boot_flag(cpuid, C2_STATE);
+	cpu_pm_exit();
+}
 
-	if (of_machine_is_compatible("samsung,exynos3250"))
-		exynos_set_boot_flag(cpuid, C2_STATE);
-
+static void exynos4_enter_aftr(void)
+{
+	cpu_pm_enter();
 	exynos_pm_central_suspend();
 
 	if (of_machine_is_compatible("samsung,exynos4212") ||
@@ -185,13 +205,103 @@ void exynos_enter_aftr(void)
 	}
 
 	exynos_pm_central_resume();
+	cpu_pm_exit();
+}
 
-	if (of_machine_is_compatible("samsung,exynos3250"))
-		exynos_clear_boot_flag(cpuid, C2_STATE);
-
+static void exynos5_enter_aftr(void)
+{
+	cpu_pm_enter();
+	exynos_pm_central_suspend();
+	cpu_suspend(0, exynos_aftr_finisher);
+	exynos_pm_central_resume();
 	cpu_pm_exit();
 }
 
+static const struct exynos_s2r_data exynos_common_s2r_data = {
+	.enter_aftr		= exynos5_enter_aftr,
+};
+
+static const struct exynos_s2r_data exynos3250_s2r_data = {
+	.enter_aftr		= exynos3_enter_aftr,
+};
+
+static const struct exynos_s2r_data exynos4210_rev11_s2r_data = {
+	.enter_aftr		= exynos4_enter_aftr,
+};
+
+static const struct exynos_s2r_data exynos4210_rev10_s2r_data = {
+	.enter_aftr		= exynos4_enter_aftr,
+};
+
+static const struct exynos_s2r_data exynos4x12_s2r_data = {
+	.enter_aftr		= exynos4_enter_aftr,
+};
+
+static const struct soc_device_attribute exynos_soc_revision[] __initconst = {
+	{
+		.soc_id = "EXYNOS3250",
+		.data = &exynos3250_s2r_data
+	},
+	{
+		.soc_id = "EXYNOS4210",
+		.revision = "11",
+		.data = &exynos4210_rev11_s2r_data
+	},
+	{
+		.soc_id = "EXYNOS4210",
+		.revision = "10",
+		.data = &exynos4210_rev10_s2r_data
+	},
+	{
+		.soc_id = "EXYNOS4212",
+		.data = &exynos4x12_s2r_data
+	},
+	{
+		.soc_id = "EXYNOS4412",
+		.data = &exynos4x12_s2r_data
+	},
+	{
+		.soc_id = "EXYNOS5250",
+		.data = &exynos_common_s2r_data
+	},
+	{
+		.soc_id = "EXYNOS5260",
+		.data = &exynos_common_s2r_data
+	},
+	{
+		.soc_id = "EXYNOS5440",
+		.data = &exynos_common_s2r_data
+	},
+	{
+		.soc_id = "EXYNOS5410",
+		.data = &exynos_common_s2r_data
+	},
+	{
+		.soc_id = "EXYNOS5420",
+		.data = &exynos_common_s2r_data
+	},
+	{
+		.soc_id = "EXYNOS5800",
+		.data = &exynos_common_s2r_data
+	},
+};
+
+int __init exynos_s2r_init(void)
+{
+	const struct soc_device_attribute *match;
+
+	match = soc_device_match(exynos_soc_revision);
+
+	if (match)
+		s2r_data = (const struct exynos_s2r_data *) match->data;
+
+	if (!s2r_data)
+		return -ENODEV;
+
+	return 0;
+}
+arch_initcall(exynos_s2r_init);
+
 #if defined(CONFIG_SMP) && defined(CONFIG_ARM_EXYNOS_CPUIDLE)
 static atomic_t cpu1_wakeup = ATOMIC_INIT(0);
 
-- 
2.7.4
