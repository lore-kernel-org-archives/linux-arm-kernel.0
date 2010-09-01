From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 1 Sep 2010 16:09:57 +0200
Subject: [PATCH] ARM: ux500 specific L2 cache code
Message-ID: <1283350197-22195-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Per Fransson <per.xx.fransson@stericsson.com>

The generic version of l2x0_inv_all is only called just after disabling
the L2 cache and is surrounded by a spinlock. However, we're not really
turning off the L2 cache right now, and the PL310 does not support
exclusive accesses (used to implement the spinlock). So, the
invalidation needs to be done without the spinlock.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Hans-Juergen Koch <hjk@linutronix.de>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Per Fransson <per.xx.fransson@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
This is based on top of Tomas Gleixners patch titled:
"arm: Disable outer (L2) cache in kexec" adding the .inv_all()
and .disable() functions to L2X0.

Thomas, can you fold this into your patchset since you're pursuing
this? Are you maintaining this in your own git or will you send
it to Russell BTW?
---
 arch/arm/mach-ux500/cpu.c |   45 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-ux500/cpu.c b/arch/arm/mach-ux500/cpu.c
index e0fd747..73fb1a5 100644
--- a/arch/arm/mach-ux500/cpu.c
+++ b/arch/arm/mach-ux500/cpu.c
@@ -10,6 +10,7 @@
 #include <linux/io.h>
 #include <linux/clk.h>
 
+#include <asm/cacheflush.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/hardware/gic.h>
 #include <asm/mach/map.h>
@@ -71,6 +72,46 @@ void __init ux500_init_irq(void)
 }
 
 #ifdef CONFIG_CACHE_L2X0
+static inline void ux500_cache_wait(void __iomem *reg, unsigned long mask)
+{
+	/* wait for the operation to complete */
+	while (readl(reg) & mask)
+		;
+}
+
+static inline void ux500_cache_sync(void)
+{
+	void __iomem *base = __io_address(UX500_L2CC_BASE);
+	writel(0, base + L2X0_CACHE_SYNC);
+	ux500_cache_wait(base + L2X0_CACHE_SYNC, 1);
+}
+
+/*
+ * The L2 cache cannot be turned off in the non-secure world.
+ * Dummy until a secure service is in place.
+ */
+static void ux500_l2x0_disable(void)
+{
+}
+
+/*
+ * This is only called when doing a kexec, just after turning off the L2
+ * and L1 cache, and it is surrounded by a spinlock in the generic version.
+ * However, we're not really turning off the L2 cache right now and the
+ * PL310 does not support exclusive accesses (used to implement the spinlock).
+ * So, the invalidation needs to be done without the spinlock.
+ */
+static void ux500_l2x0_inv_all(void)
+{
+	void __iomem *l2x0_base = __io_address(UX500_L2CC_BASE);
+	uint32_t l2x0_way_mask = (1<<16) - 1;	/* Bitmask of active ways */
+
+	/* invalidate all ways */
+	writel(l2x0_way_mask, l2x0_base + L2X0_INV_WAY);
+	ux500_cache_wait(l2x0_base + L2X0_INV_WAY, l2x0_way_mask);
+	ux500_cache_sync();
+}
+
 static int ux500_l2x0_init(void)
 {
 	void __iomem *l2x0_base;
@@ -80,6 +121,10 @@ static int ux500_l2x0_init(void)
 	/* 64KB way size, 8 way associativity, force WA */
 	l2x0_init(l2x0_base, 0x3e060000, 0xc0000fff);
 
+	/* Override invalidate function */
+	outer_cache.disable = ux500_l2x0_disable;
+	outer_cache.inv_all = ux500_l2x0_inv_all;
+
 	return 0;
 }
 early_initcall(ux500_l2x0_init);
-- 
1.6.3.3
