From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Wed, 25 Jun 2014 19:33:48 +0530
Subject: [PATCH v5 1/5] ARM: EXYNOS: Add support for mapping PMU base address
 via DT
In-Reply-To: <1403705032-14835-1-git-send-email-pankaj.dubey@samsung.com>
References: <1403705032-14835-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1403705032-14835-2-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for mapping Samsung Power Management Unit (PMU)
base address from device tree.

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 arch/arm/mach-exynos/common.h |    1 +
 arch/arm/mach-exynos/exynos.c |   45 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
index 3f25f89..f3114be 100644
--- a/arch/arm/mach-exynos/common.h
+++ b/arch/arm/mach-exynos/common.h
@@ -113,6 +113,7 @@ IS_SAMSUNG_CPU(exynos5800, EXYNOS5800_SOC_ID, EXYNOS5_SOC_MASK)
 
 extern void __iomem *sysram_ns_base_addr;
 extern void __iomem *sysram_base_addr;
+extern void __iomem *pmu_base_addr;
 
 void exynos_firmware_init(void);
 
diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index 4a69b3f..82dabc8 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -19,6 +19,8 @@
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
+#include <linux/clocksource.h>
+#include <linux/clk-provider.h>
 
 #include <asm/cacheflush.h>
 #include <asm/hardware/cache-l2x0.h>
@@ -31,6 +33,8 @@
 #include "regs-pmu.h"
 #include "regs-sys.h"
 
+void __iomem *pmu_base_addr;
+
 static struct map_desc exynos4_iodesc[] __initdata = {
 	{
 		.virtual	= (unsigned long)S3C_VA_SYS,
@@ -231,6 +235,46 @@ static void __init exynos_init_io(void)
 	exynos_map_io();
 }
 
+static const struct of_device_id exynos_dt_pmu_match[] = {
+	{ .compatible = "samsung,exynos3250-pmu" },
+	{ .compatible = "samsung,exynos4210-pmu" },
+	{ .compatible = "samsung,exynos4212-pmu" },
+	{ .compatible = "samsung,exynos4412-pmu" },
+	{ .compatible = "samsung,exynos5250-pmu" },
+	{ .compatible = "samsung,exynos5420-pmu" },
+	{},
+};
+
+static void exynos_map_pmu(void)
+{
+	struct device_node *np = NULL;
+
+	np = of_find_matching_node(NULL, exynos_dt_pmu_match);
+
+	if (!np) {
+		pr_err("Failed to find PMU node\n");
+		return;
+	}
+
+	pmu_base_addr = of_iomap(np, 0);
+
+	if (!pmu_base_addr)
+		panic("failed to find exynos pmu register\n");
+}
+
+static void __init exynos_init_time(void)
+{
+	/* Nothing to do timer specific.
+	 * Since platsmp.c needs pmu base address by the time
+	 * DT is not unflatten so we can't use DT APIs before
+	 * init_time
+	 */
+	exynos_map_pmu();
+
+	of_clk_init(NULL);
+	clocksource_of_init();
+}
+
 static void __init exynos_dt_machine_init(void)
 {
 	struct device_node *i2c_np;
@@ -306,6 +350,7 @@ DT_MACHINE_START(EXYNOS_DT, "SAMSUNG EXYNOS (Flattened Device Tree)")
 	.smp		= smp_ops(exynos_smp_ops),
 	.map_io		= exynos_init_io,
 	.init_early	= exynos_firmware_init,
+	.init_time	= exynos_init_time,
 	.init_machine	= exynos_dt_machine_init,
 	.init_late	= exynos_init_late,
 	.dt_compat	= exynos_dt_compat,
-- 
1.7.9.5
