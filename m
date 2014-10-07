From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Tue, 07 Oct 2014 13:23:21 +0530
Subject: [PATCH v3 2/2] ARM: EXYNOS: PMU: move restart code into pmu driver
In-Reply-To: <1412668401-21837-1-git-send-email-pankaj.dubey@samsung.com>
References: <1412668401-21837-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1412668401-21837-3-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let's register restart handler from PMU driver for reboot
functionality. So that we can remove restart hooks from
machine specific file, and thus moving ahead when PMU moved
to driver folder, this functionality can be reused for ARM64
based Exynos SoC's.

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 arch/arm/mach-exynos/common.h |    1 -
 arch/arm/mach-exynos/exynos.c |    6 ------
 arch/arm/mach-exynos/pmu.c    |   24 ++++++++++++++++++++++++
 3 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
index 9019d86..e8afbe6 100644
--- a/arch/arm/mach-exynos/common.h
+++ b/arch/arm/mach-exynos/common.h
@@ -12,7 +12,6 @@
 #ifndef __ARCH_ARM_MACH_EXYNOS_COMMON_H
 #define __ARCH_ARM_MACH_EXYNOS_COMMON_H
 
-#include <linux/reboot.h>
 #include <linux/of.h>
 
 #define EXYNOS3250_SOC_ID	0xE3472000
diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index e9ddf69..0e0101b 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -137,11 +137,6 @@ static struct map_desc exynos5_iodesc[] __initdata = {
 	},
 };
 
-static void exynos_restart(enum reboot_mode mode, const char *cmd)
-{
-	__raw_writel(0x1, pmu_base_addr + EXYNOS_SWRESET);
-}
-
 static struct platform_device exynos_cpuidle = {
 	.name              = "exynos_cpuidle",
 #ifdef CONFIG_ARM_EXYNOS_CPUIDLE
@@ -361,7 +356,6 @@ DT_MACHINE_START(EXYNOS_DT, "SAMSUNG EXYNOS (Flattened Device Tree)")
 	.init_machine	= exynos_dt_machine_init,
 	.init_late	= exynos_init_late,
 	.dt_compat	= exynos_dt_compat,
-	.restart	= exynos_restart,
 	.reserve	= exynos_reserve,
 	.dt_fixup	= exynos_dt_fixup,
 MACHINE_END
diff --git a/arch/arm/mach-exynos/pmu.c b/arch/arm/mach-exynos/pmu.c
index 1993e08..0b84998 100644
--- a/arch/arm/mach-exynos/pmu.c
+++ b/arch/arm/mach-exynos/pmu.c
@@ -11,7 +11,10 @@
 
 #include <linux/io.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/platform_device.h>
+#include <linux/notifier.h>
+#include <linux/reboot.h>
 
 #include "exynos-pmu.h"
 #include "regs-pmu.h"
@@ -439,6 +442,14 @@ static void exynos5250_pmu_init(void)
 	pmu_raw_writel(value, EXYNOS5_MASK_WDTRESET_REQUEST);
 }
 
+static int pmu_restart_notify(struct notifier_block *this,
+		unsigned long code, void *unused)
+{
+	pmu_raw_writel(0x1, EXYNOS_SWRESET);
+
+	return NOTIFY_DONE;
+}
+
 static const struct exynos_pmu_data exynos4210_pmu_data = {
 	.pmu_config	= exynos4210_pmu_config,
 };
@@ -478,11 +489,20 @@ static const struct of_device_id exynos_pmu_of_device_ids[] = {
 	{ /*sentinel*/ },
 };
 
+/*
+ * Exynos PMU reboot notifier, handles reboot functionality
+ */
+static struct notifier_block pmu_restart_handler = {
+	.notifier_call = pmu_restart_notify,
+	.priority = 128,
+};
+
 static int exynos_pmu_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *match;
 	struct device *dev = &pdev->dev;
 	struct resource *res;
+	int ret;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	pmu_base_addr = devm_ioremap_resource(dev, res);
@@ -507,6 +527,10 @@ static int exynos_pmu_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, pmu_context);
 
+	ret = register_restart_handler(&pmu_restart_handler);
+	if (ret)
+		dev_err(dev, "can't register restart handler err=%d\n", ret);
+
 	dev_dbg(dev, "Exynos PMU Driver probe done\n");
 	return 0;
 }
-- 
1.7.9.5
