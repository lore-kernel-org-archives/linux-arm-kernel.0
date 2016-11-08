From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Tue, 08 Nov 2016 08:44:23 +0530
Subject: [PATCH v2 1/2] ARM: EXYNOS: Remove static mapping of SCU SFR
In-Reply-To: <1478574864-24683-1-git-send-email-pankaj.dubey@samsung.com>
References: <1478574864-24683-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1478574864-24683-2-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lets remove static mapping of SCU SFR mainly used in CORTEX-A9 SoC based
boards. Instead use mapping from device tree node of SCU.

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 arch/arm/mach-exynos/exynos.c                | 22 ----------------------
 arch/arm/mach-exynos/firmware.c              | 17 +++++++++++++++++
 arch/arm/mach-exynos/include/mach/map.h      |  2 --
 arch/arm/mach-exynos/platsmp.c               | 20 +++++++++++++-------
 arch/arm/mach-exynos/pm.c                    |  4 +---
 arch/arm/mach-exynos/suspend.c               |  5 -----
 arch/arm/plat-samsung/include/plat/map-s5p.h |  4 ----
 7 files changed, 31 insertions(+), 43 deletions(-)

diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index 757fc11..fa08ef9 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -28,15 +28,6 @@
 
 #include "common.h"
 
-static struct map_desc exynos4_iodesc[] __initdata = {
-	{
-		.virtual	= (unsigned long)S5P_VA_COREPERI_BASE,
-		.pfn		= __phys_to_pfn(EXYNOS4_PA_COREPERI),
-		.length		= SZ_8K,
-		.type		= MT_DEVICE,
-	},
-};
-
 static struct platform_device exynos_cpuidle = {
 	.name              = "exynos_cpuidle",
 #ifdef CONFIG_ARM_EXYNOS_CPUIDLE
@@ -99,17 +90,6 @@ static int __init exynos_fdt_map_chipid(unsigned long node, const char *uname,
 	return 1;
 }
 
-/*
- * exynos_map_io
- *
- * register the standard cpu IO areas
- */
-static void __init exynos_map_io(void)
-{
-	if (soc_is_exynos4())
-		iotable_init(exynos4_iodesc, ARRAY_SIZE(exynos4_iodesc));
-}
-
 static void __init exynos_init_io(void)
 {
 	debug_ll_io_init();
@@ -118,8 +98,6 @@ static void __init exynos_init_io(void)
 
 	/* detect cpu id and rev. */
 	s5p_init_cpu(S5P_VA_CHIPID);
-
-	exynos_map_io();
 }
 
 /*
diff --git a/arch/arm/mach-exynos/firmware.c b/arch/arm/mach-exynos/firmware.c
index fd6da54..f33558e 100644
--- a/arch/arm/mach-exynos/firmware.c
+++ b/arch/arm/mach-exynos/firmware.c
@@ -18,6 +18,7 @@
 #include <asm/cputype.h>
 #include <asm/firmware.h>
 #include <asm/hardware/cache-l2x0.h>
+#include <asm/smp_scu.h>
 #include <asm/suspend.h>
 
 #include "common.h"
@@ -141,8 +142,24 @@ static int exynos_suspend(void)
 	return cpu_suspend(0, exynos_cpu_suspend);
 }
 
+static void exynos_scu_enable(void)
+{
+	struct device_node *np;
+	void __iomem *scu_base;
+
+	np = of_find_compatible_node(NULL, NULL, "arm,cortex-a9-scu");
+	scu_base = of_iomap(np, 0);
+	of_node_put(np);
+	if (!scu_base) {
+		pr_err("%s failed to map scu_base\n", __func__);
+		return;
+	}
+}
+
 static int exynos_resume(void)
 {
+	exynos_scu_enable();
+
 	writel(0, sysram_ns_base_addr + EXYNOS_BOOT_FLAG);
 
 	return 0;
diff --git a/arch/arm/mach-exynos/include/mach/map.h b/arch/arm/mach-exynos/include/mach/map.h
index 5fb0040..0eef407 100644
--- a/arch/arm/mach-exynos/include/mach/map.h
+++ b/arch/arm/mach-exynos/include/mach/map.h
@@ -18,6 +18,4 @@
 
 #define EXYNOS_PA_CHIPID		0x10000000
 
-#define EXYNOS4_PA_COREPERI		0x10500000
-
 #endif /* __ASM_ARCH_MAP_H */
diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
index a5d6841..a0afa4b 100644
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@ -224,11 +224,6 @@ static void write_pen_release(int val)
 	sync_cache_w(&pen_release);
 }
 
-static void __iomem *scu_base_addr(void)
-{
-	return (void __iomem *)(S5P_VA_SCU);
-}
-
 static DEFINE_SPINLOCK(boot_lock);
 
 static void exynos_secondary_init(unsigned int cpu)
@@ -387,14 +382,25 @@ static int exynos_boot_secondary(unsigned int cpu, struct task_struct *idle)
 
 static void __init exynos_smp_prepare_cpus(unsigned int max_cpus)
 {
+	struct device_node *np;
+	void __iomem *scu_base;
 	int i;
 
 	exynos_sysram_init();
 
 	exynos_set_delayed_reset_assertion(true);
 
-	if (read_cpuid_part() == ARM_CPU_PART_CORTEX_A9)
-		scu_enable(scu_base_addr());
+	if (read_cpuid_part() == ARM_CPU_PART_CORTEX_A9) {
+		np = of_find_compatible_node(NULL, NULL, "arm,cortex-a9-scu");
+		scu_base = of_iomap(np, 0);
+		of_node_put(np);
+		if (!scu_base) {
+			pr_err("%s failed to map scu_base\n", __func__);
+			return;
+		}
+		scu_enable(scu_base);
+		iounmap(scu_base);
+	}
 
 	/*
 	 * Write the address of secondary startup into the
diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index 487295f..b8c5565 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -18,6 +18,7 @@
 #include <linux/cpu_pm.h>
 #include <linux/io.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/soc/samsung/exynos-regs-pmu.h>
 #include <linux/soc/samsung/exynos-pmu.h>
 
@@ -26,8 +27,6 @@
 #include <asm/suspend.h>
 #include <asm/cacheflush.h>
 
-#include <mach/map.h>
-
 #include "common.h"
 
 static inline void __iomem *exynos_boot_vector_addr(void)
@@ -177,7 +176,6 @@ void exynos_enter_aftr(void)
 	cpu_suspend(0, exynos_aftr_finisher);
 
 	if (read_cpuid_part() == ARM_CPU_PART_CORTEX_A9) {
-		scu_enable(S5P_VA_SCU);
 		if (call_firmware_op(resume) == -ENOSYS)
 			exynos_cpu_restore_register();
 	}
diff --git a/arch/arm/mach-exynos/suspend.c b/arch/arm/mach-exynos/suspend.c
index 06332f6..6ccd466 100644
--- a/arch/arm/mach-exynos/suspend.c
+++ b/arch/arm/mach-exynos/suspend.c
@@ -34,8 +34,6 @@
 #include <asm/smp_scu.h>
 #include <asm/suspend.h>
 
-#include <mach/map.h>
-
 #include <plat/pm-common.h>
 
 #include "common.h"
@@ -461,9 +459,6 @@ static void exynos_pm_resume(void)
 	/* For release retention */
 	exynos_pm_release_retention();
 
-	if (cpuid == ARM_CPU_PART_CORTEX_A9)
-		scu_enable(S5P_VA_SCU);
-
 	if (call_firmware_op(resume) == -ENOSYS
 	    && cpuid == ARM_CPU_PART_CORTEX_A9)
 		exynos_cpu_restore_register();
diff --git a/arch/arm/plat-samsung/include/plat/map-s5p.h b/arch/arm/plat-samsung/include/plat/map-s5p.h
index 0fe2828..512ed1f 100644
--- a/arch/arm/plat-samsung/include/plat/map-s5p.h
+++ b/arch/arm/plat-samsung/include/plat/map-s5p.h
@@ -15,10 +15,6 @@
 
 #define S5P_VA_CHIPID		S3C_ADDR(0x02000000)
 
-#define S5P_VA_COREPERI_BASE	S3C_ADDR(0x02800000)
-#define S5P_VA_COREPERI(x)	(S5P_VA_COREPERI_BASE + (x))
-#define S5P_VA_SCU		S5P_VA_COREPERI(0x0)
-
 #define VA_VIC(x)		(S3C_VA_IRQ + ((x) * 0x10000))
 #define VA_VIC0			VA_VIC(0)
 #define VA_VIC1			VA_VIC(1)
-- 
2.7.4
