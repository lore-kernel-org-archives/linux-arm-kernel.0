From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 28 Jul 2015 12:43:24 +1000
Subject: linux-next: build failure after merge of the tip tree
Message-ID: <20150728124324.40f44f01@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

After merging the tip tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

arch/arm/mach-mvebu/board-v7.c: In function 'mvebu_init_irq':
arch/arm/mach-mvebu/board-v7.c:138:3: error: implicit declaration of function 'gic_set_irqchip_flags' [-Werror=implicit-function-declaration]
   gic_set_irqchip_flags(IRQCHIP_SKIP_SET_WAKE |
   ^

Caused by commit

  e6f134f8e30e ("ARM: mvebu: Allow using the GIC for wakeup in standby mode")

from the mvebu tree interacting with commit

  0d3f2c92e004 ("irqchip/gic: Remove redundant gic_set_irqchip_flags")

from the tip tree.

I have applied the following merge fix patch for today:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 28 Jul 2015 12:26:21 +1000
Subject: [PATCH] irqchip/gic: merge fix for "Remove redundant gic_set_irqchip_flags"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/arm/mach-mvebu/board-v7.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm/mach-mvebu/board-v7.c b/arch/arm/mach-mvebu/board-v7.c
index a6d2b4d6701a..b5ef80f369e7 100644
--- a/arch/arm/mach-mvebu/board-v7.c
+++ b/arch/arm/mach-mvebu/board-v7.c
@@ -131,13 +131,6 @@ static int armada_375_external_abort_wa(unsigned long addr, unsigned int fsr,
 
 static void __init mvebu_init_irq(void)
 {
-	struct device_node *np;
-
-	np = of_find_compatible_node(NULL, NULL, "arm,cortex-a9-gic");
-	if (np)
-		gic_set_irqchip_flags(IRQCHIP_SKIP_SET_WAKE |
-				      IRQCHIP_MASK_ON_SUSPEND);
-	of_node_put(np);
 	irqchip_init();
 	mvebu_scu_enable();
 	coherency_init();
-- 
2.4.6

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
