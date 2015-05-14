From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 14 May 2015 18:13:10 +0200
Subject: [PATCH 05/10] ARM: ux500: get rid of static GIC dist base
Message-ID: <1431619990-15014-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GIC distributor was mapped statically for the PM code
but the driver already get the base address from the DT.
Augment the PM code to get the base from the device tree
and remove the static map.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/cpu-db8500.c |  1 -
 arch/arm/mach-ux500/pm.c         | 15 +++++++++++++--
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index 0b3ebbf38702..a36fdd8657d2 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -47,7 +47,6 @@ static struct prcmu_pdata db8500_prcmu_pdata = {
 static struct map_desc u8500_common_io_desc[] __initdata = {
 	/* SCU base also covers GIC CPU BASE and TWD with its 4K page */
 	__IO_DEV_DESC(U8500_SCU_BASE, SZ_4K),
-	__IO_DEV_DESC(U8500_GIC_DIST_BASE, SZ_4K),
 	__IO_DEV_DESC(U8500_L2CC_BASE, SZ_4K),
 	__IO_DEV_DESC(U8500_BACKUPRAM0_BASE, SZ_8K),
 };
diff --git a/arch/arm/mach-ux500/pm.c b/arch/arm/mach-ux500/pm.c
index 2cb587b50905..8538910db202 100644
--- a/arch/arm/mach-ux500/pm.c
+++ b/arch/arm/mach-ux500/pm.c
@@ -15,6 +15,8 @@
 #include <linux/io.h>
 #include <linux/suspend.h>
 #include <linux/platform_data/arm-ux500-pm.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
 
 #include "db8500-regs.h"
 #include "pm_domains.h"
@@ -42,6 +44,7 @@
 #define PRCM_ARMITVAL127TO96	(prcmu_base + 0x26C)
 
 static void __iomem *prcmu_base;
+static void __iomem *dist_base;
 
 /* This function decouple the gic from the prcmu */
 int prcmu_gic_decouple(void)
@@ -88,7 +91,6 @@ bool prcmu_gic_pending_irq(void)
 {
 	u32 pr; /* Pending register */
 	u32 er; /* Enable register */
-	void __iomem *dist_base = __io_address(U8500_GIC_DIST_BASE);
 	int i;
 
 	/* 5 registers. STI & PPI not skipped */
@@ -143,7 +145,6 @@ bool prcmu_is_cpu_in_wfi(int cpu)
 int prcmu_copy_gic_settings(void)
 {
 	u32 er; /* Enable register */
-	void __iomem *dist_base = __io_address(U8500_GIC_DIST_BASE);
 	int i;
 
 	/* We skip the STI and PPI */
@@ -179,11 +180,21 @@ static const struct platform_suspend_ops ux500_suspend_ops = {
 
 void __init ux500_pm_init(u32 phy_base, u32 size)
 {
+	struct device_node *np;
+
 	prcmu_base = ioremap(phy_base, size);
 	if (!prcmu_base) {
 		pr_err("could not remap PRCMU for PM functions\n");
 		return;
 	}
+	np = of_find_compatible_node(NULL, NULL, "arm,cortex-a9-gic");
+	dist_base = of_iomap(np, 0);
+	of_node_put(np);
+	if (!dist_base) {
+		pr_err("could not remap GIC dist base for PM functions\n");
+		return;
+	}
+
 	/*
 	 * On watchdog reboot the GIC is in some cases decoupled.
 	 * This will make sure that the GIC is correctly configured.
-- 
1.9.3
