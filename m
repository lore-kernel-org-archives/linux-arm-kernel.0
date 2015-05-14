From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 14 May 2015 18:13:01 +0200
Subject: [PATCH 04/10] ARM: ux500: get SCU base from device tree
Message-ID: <1431619981-14972-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SMP startup/shutdown code relied on a static SCU base
address, let's get this from the device tree instead.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/platsmp.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-ux500/platsmp.c b/arch/arm/mach-ux500/platsmp.c
index 1e13d0a8ad77..62b1de922bd8 100644
--- a/arch/arm/mach-ux500/platsmp.c
+++ b/arch/arm/mach-ux500/platsmp.c
@@ -16,6 +16,8 @@
 #include <linux/device.h>
 #include <linux/smp.h>
 #include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
 
 #include <asm/cacheflush.h>
 #include <asm/smp_plat.h>
@@ -122,8 +124,13 @@ static void __init wakeup_secondary(void)
 static void __init ux500_smp_init_cpus(void)
 {
 	unsigned int i, ncores;
+	struct device_node *np;
 
-	scu_base = ioremap(U8500_SCU_BASE, 0x100);
+	np = of_find_compatible_node(NULL, NULL, "arm,cortex-a9-scu");
+	scu_base = of_iomap(np, 0);
+	of_node_put(np);
+	if (!scu_base)
+		return;
 	backupram = ioremap(U8500_BACKUPRAM0_BASE, SZ_8K);
 	ncores = scu_get_core_count(scu_base);
 
-- 
1.9.3
