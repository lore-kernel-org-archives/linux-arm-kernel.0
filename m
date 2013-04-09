From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue,  9 Apr 2013 23:26:14 +0200
Subject: [PATCHv1 1/5] ARM: mvebu: move L2 cache initialization in init_early()
In-Reply-To: <1365542778-27959-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1365542778-27959-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1365542778-27959-2-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation for moving the IRQ controller driver to
drivers/irqchip/, we don't want the IRQ controller driver to be
responsible for initializing the L2 cache. Instead, let's initialize
the L2 cache at the init_early() level, like mach-exynos/common.c is
doing.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/armada-370-xp.c     |    5 +++++
 arch/arm/mach-mvebu/irq-armada-370-xp.c |    4 ----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-mvebu/armada-370-xp.c b/arch/arm/mach-mvebu/armada-370-xp.c
index a5ea616d..c1bbfa7 100644
--- a/arch/arm/mach-mvebu/armada-370-xp.c
+++ b/arch/arm/mach-mvebu/armada-370-xp.c
@@ -19,6 +19,7 @@
 #include <linux/time-armada-370-xp.h>
 #include <linux/clk/mvebu.h>
 #include <linux/dma-mapping.h>
+#include <asm/hardware/cache-l2x0.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
@@ -54,6 +55,10 @@ void __init armada_370_xp_init_early(void)
 	 * to make sure such the allocations won't fail.
 	 */
 	init_dma_coherent_pool_size(SZ_1M);
+
+#ifdef CONFIG_CACHE_L2X0
+	l2x0_of_init(0, ~0UL);
+#endif
 }
 
 static void __init armada_370_xp_dt_init(void)
diff --git a/arch/arm/mach-mvebu/irq-armada-370-xp.c b/arch/arm/mach-mvebu/irq-armada-370-xp.c
index 6a9195e..f6699f3 100644
--- a/arch/arm/mach-mvebu/irq-armada-370-xp.c
+++ b/arch/arm/mach-mvebu/irq-armada-370-xp.c
@@ -25,7 +25,6 @@
 #include <asm/mach/arch.h>
 #include <asm/exception.h>
 #include <asm/smp_plat.h>
-#include <asm/hardware/cache-l2x0.h>
 
 /* Interrupt Controller Registers Map */
 #define ARMADA_370_XP_INT_SET_MASK_OFFS		(0x48)
@@ -292,7 +291,4 @@ static const struct of_device_id mpic_of_match[] __initconst = {
 void __init armada_370_xp_init_irq(void)
 {
 	of_irq_init(mpic_of_match);
-#ifdef CONFIG_CACHE_L2X0
-	l2x0_of_init(0, ~0UL);
-#endif
 }
-- 
1.7.9.5
