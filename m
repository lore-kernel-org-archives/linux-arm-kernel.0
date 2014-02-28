From: ivan.khoronzhuk@ti.com (Ivan Khoronzhuk)
Date: Fri, 28 Feb 2014 20:07:43 +0200
Subject: [PATCH 3/5] ARM: keystone: remove redundant reset stuff
In-Reply-To: <1393610865-23630-1-git-send-email-ivan.khoronzhuk@ti.com>
References: <1393610865-23630-1-git-send-email-ivan.khoronzhuk@ti.com>
Message-ID: <1393610865-23630-4-git-send-email-ivan.khoronzhuk@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove reset stuff in flavour of using keystone reset driver:
driver/power/reset/keystone-reset.c

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
---

CC: Santosh Shilimkar <santosh.shilimkar@ti.com>
CC: Russell King <linux@arm.linux.org.uk>

 arch/arm/mach-keystone/keystone.c | 35 -----------------------------------
 1 file changed, 35 deletions(-)

diff --git a/arch/arm/mach-keystone/keystone.c b/arch/arm/mach-keystone/keystone.c
index 6e6bb7d..4d46e30 100644
--- a/arch/arm/mach-keystone/keystone.c
+++ b/arch/arm/mach-keystone/keystone.c
@@ -23,24 +23,8 @@
 
 #include "keystone.h"
 
-#define PLL_RESET_WRITE_KEY_MASK		0xffff0000
-#define PLL_RESET_WRITE_KEY			0x5a69
-#define PLL_RESET				BIT(16)
-
-static void __iomem *keystone_rstctrl;
-
 static void __init keystone_init(void)
 {
-	struct device_node *node;
-
-	node = of_find_compatible_node(NULL, NULL, "ti,keystone-reset");
-	if (WARN_ON(!node))
-		pr_warn("ti,keystone-reset node undefined\n");
-
-	keystone_rstctrl = of_iomap(node, 0);
-	if (WARN_ON(!keystone_rstctrl))
-		pr_warn("ti,keystone-reset iomap error\n");
-
 	keystone_pm_runtime_init();
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
@@ -50,24 +34,6 @@ static const char *keystone_match[] __initconst = {
 	NULL,
 };
 
-void keystone_restart(enum reboot_mode mode, const char *cmd)
-{
-	u32 val;
-
-	BUG_ON(!keystone_rstctrl);
-
-	/* Enable write access to RSTCTRL */
-	val = readl(keystone_rstctrl);
-	val &= PLL_RESET_WRITE_KEY_MASK;
-	val |= PLL_RESET_WRITE_KEY;
-	writel(val, keystone_rstctrl);
-
-	/* Reset the SOC */
-	val = readl(keystone_rstctrl);
-	val &= ~PLL_RESET;
-	writel(val, keystone_rstctrl);
-}
-
 DT_MACHINE_START(KEYSTONE, "Keystone")
 #if defined(CONFIG_ZONE_DMA) && defined(CONFIG_ARM_LPAE)
 	.dma_zone_size	= SZ_2G,
@@ -75,5 +41,4 @@ DT_MACHINE_START(KEYSTONE, "Keystone")
 	.smp		= smp_ops(keystone_smp_ops),
 	.init_machine	= keystone_init,
 	.dt_compat	= keystone_match,
-	.restart	= keystone_restart,
 MACHINE_END
-- 
1.8.3.2
