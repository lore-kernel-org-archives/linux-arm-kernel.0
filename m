From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Wed, 09 Jul 2014 09:30:52 +0530
Subject: [PATCH v7 1/4] ARM: EXYNOS: Add support for mapping PMU base address
 via DT
In-Reply-To: <1404878455-31518-1-git-send-email-pankaj.dubey@samsung.com>
References: <1404878455-31518-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1404878455-31518-2-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for mapping Samsung Power Management Unit (PMU)
base address from device tree.

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Reviewed-by: Tomasz Figa <t.figa@samsung.com>
---
 arch/arm/mach-exynos/common.h |    1 +
 arch/arm/mach-exynos/exynos.c |   37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
index 152b464..f8daa9c 100644
--- a/arch/arm/mach-exynos/common.h
+++ b/arch/arm/mach-exynos/common.h
@@ -113,6 +113,7 @@ IS_SAMSUNG_CPU(exynos5800, EXYNOS5800_SOC_ID, EXYNOS5_SOC_MASK)
 
 extern void __iomem *sysram_ns_base_addr;
 extern void __iomem *sysram_base_addr;
+extern void __iomem *pmu_base_addr;
 void exynos_sysram_init(void);
 
 void exynos_firmware_init(void);
diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index 186f35d..173aac8 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -19,6 +19,7 @@
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
+#include <linux/irqchip.h>
 
 #include <asm/cacheflush.h>
 #include <asm/hardware/cache-l2x0.h>
@@ -31,6 +32,8 @@
 #include "regs-pmu.h"
 #include "regs-sys.h"
 
+void __iomem *pmu_base_addr;
+
 static struct map_desc exynos4_iodesc[] __initdata = {
 	{
 		.virtual	= (unsigned long)S3C_VA_SYS,
@@ -253,6 +256,39 @@ static void __init exynos_init_io(void)
 	exynos_map_io();
 }
 
+static const struct of_device_id exynos_dt_pmu_match[] = {
+	{ .compatible = "samsung,exynos3250-pmu" },
+	{ .compatible = "samsung,exynos4210-pmu" },
+	{ .compatible = "samsung,exynos4212-pmu" },
+	{ .compatible = "samsung,exynos4412-pmu" },
+	{ .compatible = "samsung,exynos5250-pmu" },
+	{ .compatible = "samsung,exynos5420-pmu" },
+	{ /*sentinel*/ },
+};
+
+static void exynos_map_pmu(void)
+{
+	struct device_node *np;
+
+	np = of_find_matching_node(NULL, exynos_dt_pmu_match);
+	if (np)
+		pmu_base_addr = of_iomap(np, 0);
+
+	if (!pmu_base_addr)
+		panic("failed to find exynos pmu register\n");
+}
+
+static void __init exynos_init_irq(void)
+{
+	irqchip_init();
+	/*
+	 * Since platsmp.c needs pmu base address by the time
+	 * DT is not unflatten so we can't use DT APIs before
+	 * init_irq
+	 */
+	exynos_map_pmu();
+}
+
 static void __init exynos_dt_machine_init(void)
 {
 	struct device_node *i2c_np;
@@ -336,6 +372,7 @@ DT_MACHINE_START(EXYNOS_DT, "SAMSUNG EXYNOS (Flattened Device Tree)")
 	.smp		= smp_ops(exynos_smp_ops),
 	.map_io		= exynos_init_io,
 	.init_early	= exynos_firmware_init,
+	.init_irq	= exynos_init_irq,
 	.init_machine	= exynos_dt_machine_init,
 	.init_late	= exynos_init_late,
 	.dt_compat	= exynos_dt_compat,
-- 
1.7.9.5
