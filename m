From: alim.akhtar@samsung.com (Alim Akhtar)
Date: Fri, 20 Nov 2015 10:47:09 +0530
Subject: [PATCH v3 5/5] ARM: exynos: select POWER_RESET_SYSCON and
 POWER_RESET_SYSCON_POWEROFF
In-Reply-To: <1447996629-18232-1-git-send-email-alim.akhtar@samsung.com>
References: <1447996629-18232-1-git-send-email-alim.akhtar@samsung.com>
Message-ID: <1447996629-18232-6-git-send-email-alim.akhtar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since we switch to use generic syscon regmap based reset/poweroff
driver for exynos SoC, lets select it from ARCH_EXYNOS instead of
enabling it from various defconfigs. This also select POWER_RESET
as SYSCON-{reset, poweroff} drivers depends on it.

Also because of the above changes we don't need special handling
for reboot/poweroff in exynos pmu driver. This patch also removes
the same from exynos pmu driver to keep git bisect working.

Note: This will break reboot/poweroff on boards with older dtbs
with a newer kernel.

Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
Acked-by: Moritz Fischer <moritz.fischer@ettus.com>
---
 arch/arm/mach-exynos/Kconfig |    3 +++
 arch/arm/mach-exynos/pmu.c   |   43 ------------------------------------------
 2 files changed, 3 insertions(+), 43 deletions(-)

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index 3a10f1a8317a..d279edf9b10d 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -27,6 +27,9 @@ menuconfig ARCH_EXYNOS
 	select SRAM
 	select THERMAL
 	select MFD_SYSCON
+	select POWER_RESET
+	select POWER_RESET_SYSCON
+	select POWER_RESET_SYSCON_POWEROFF
 	help
 	  Support for SAMSUNG EXYNOS SoCs (EXYNOS4/5)
 
diff --git a/arch/arm/mach-exynos/pmu.c b/arch/arm/mach-exynos/pmu.c
index de68938ee6aa..393c04aa727e 100644
--- a/arch/arm/mach-exynos/pmu.c
+++ b/arch/arm/mach-exynos/pmu.c
@@ -14,9 +14,6 @@
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/delay.h>
-#include <linux/notifier.h>
-#include <linux/reboot.h>
-
 
 #include "exynos-pmu.h"
 #include "regs-pmu.h"
@@ -681,23 +678,6 @@ static unsigned int const exynos5420_list_disable_pmu_reg[] = {
 	EXYNOS5420_CMU_RESET_FSYS_SYS_PWR_REG,
 };
 
-static void exynos_power_off(void)
-{
-	unsigned int tmp;
-
-	pr_info("Power down.\n");
-	tmp = pmu_raw_readl(EXYNOS_PS_HOLD_CONTROL);
-	tmp ^= (1 << 8);
-	pmu_raw_writel(tmp, EXYNOS_PS_HOLD_CONTROL);
-
-	/* Wait a little so we don't give a false warning below */
-	mdelay(100);
-
-	pr_err("Power down failed, please power off system manually.\n");
-	while (1)
-		;
-}
-
 static void exynos5420_powerdown_conf(enum sys_powerdown mode)
 {
 	u32 this_cluster;
@@ -875,14 +855,6 @@ static void exynos5420_pmu_init(void)
 	pr_info("EXYNOS5420 PMU initialized\n");
 }
 
-static int pmu_restart_notify(struct notifier_block *this,
-		unsigned long code, void *unused)
-{
-	pmu_raw_writel(0x1, EXYNOS_SWRESET);
-
-	return NOTIFY_DONE;
-}
-
 static const struct exynos_pmu_data exynos3250_pmu_data = {
 	.pmu_config	= exynos3250_pmu_config,
 	.pmu_init	= exynos3250_pmu_init,
@@ -940,20 +912,11 @@ static const struct of_device_id exynos_pmu_of_device_ids[] = {
 	{ /*sentinel*/ },
 };
 
-/*
- * Exynos PMU restart notifier, handles restart functionality
- */
-static struct notifier_block pmu_restart_handler = {
-	.notifier_call = pmu_restart_notify,
-	.priority = 128,
-};
-
 static int exynos_pmu_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *match;
 	struct device *dev = &pdev->dev;
 	struct resource *res;
-	int ret;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	pmu_base_addr = devm_ioremap_resource(dev, res);
@@ -978,12 +941,6 @@ static int exynos_pmu_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, pmu_context);
 
-	ret = register_restart_handler(&pmu_restart_handler);
-	if (ret)
-		dev_warn(dev, "can't register restart handler err=%d\n", ret);
-
-	pm_power_off = exynos_power_off;
-
 	dev_dbg(dev, "Exynos PMU Driver probe done\n");
 	return 0;
 }
-- 
1.7.10.4
