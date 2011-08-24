From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 24 Aug 2011 11:23:28 +0200
Subject: [PATCH 1/3] mach-ux500: factor out l2x0 handling code
Message-ID: <1314177808-19114-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

Following mach-imx we break out the l2x0 handling into its
own file, avoiding some ifdefs. Also remove unnecessary creation
of local pointers when there is already one file-local readily
available.

Cc: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
Cc: Rabin Vincent <rabin.vincent@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/Makefile     |    1 +
 arch/arm/mach-ux500/cache-l2x0.c |   72 ++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-ux500/cpu.c        |   69 ------------------------------------
 3 files changed, 73 insertions(+), 69 deletions(-)
 create mode 100644 arch/arm/mach-ux500/cache-l2x0.c

diff --git a/arch/arm/mach-ux500/Makefile b/arch/arm/mach-ux500/Makefile
index 1694916..9fd00a6 100644
--- a/arch/arm/mach-ux500/Makefile
+++ b/arch/arm/mach-ux500/Makefile
@@ -4,6 +4,7 @@
 
 obj-y				:= clock.o cpu.o devices.o devices-common.o \
 				   id.o usb.o
+obj-$(CONFIG_CACHE_L2X0)	+= cache-l2x0.o
 obj-$(CONFIG_UX500_SOC_DB5500)	+= cpu-db5500.o dma-db5500.o
 obj-$(CONFIG_UX500_SOC_DB8500)	+= cpu-db8500.o devices-db8500.o
 obj-$(CONFIG_MACH_U8500)	+= board-mop500.o board-mop500-sdi.o \
diff --git a/arch/arm/mach-ux500/cache-l2x0.c b/arch/arm/mach-ux500/cache-l2x0.c
new file mode 100644
index 0000000..9d09e4d
--- /dev/null
+++ b/arch/arm/mach-ux500/cache-l2x0.c
@@ -0,0 +1,72 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2011
+ *
+ * License terms: GNU General Public License (GPL) version 2
+ */
+
+#include <linux/io.h>
+#include <asm/cacheflush.h>
+#include <asm/hardware/cache-l2x0.h>
+#include <mach/hardware.h>
+#include <mach/id.h>
+
+static void __iomem *l2x0_base;
+
+static inline void ux500_cache_wait(void __iomem *reg, unsigned long mask)
+{
+	/* wait for the operation to complete */
+	while (readl_relaxed(reg) & mask)
+		cpu_relax();
+}
+
+static inline void ux500_cache_sync(void)
+{
+	writel_relaxed(0, l2x0_base + L2X0_CACHE_SYNC);
+	ux500_cache_wait(l2x0_base + L2X0_CACHE_SYNC, 1);
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
+	uint32_t l2x0_way_mask = (1<<16) - 1;	/* Bitmask of active ways */
+
+	/* invalidate all ways */
+	writel_relaxed(l2x0_way_mask, l2x0_base + L2X0_INV_WAY);
+	ux500_cache_wait(l2x0_base + L2X0_INV_WAY, l2x0_way_mask);
+	ux500_cache_sync();
+}
+
+static int ux500_l2x0_init(void)
+{
+	if (cpu_is_u5500())
+		l2x0_base = __io_address(U5500_L2CC_BASE);
+	else if (cpu_is_u8500())
+		l2x0_base = __io_address(U8500_L2CC_BASE);
+	else
+		ux500_unknown_soc();
+
+	/* 64KB way size, 8 way associativity, force WA */
+	l2x0_init(l2x0_base, 0x3e060000, 0xc0000fff);
+
+	/* Override invalidate function */
+	outer_cache.disable = ux500_l2x0_disable;
+	outer_cache.inv_all = ux500_l2x0_inv_all;
+
+	return 0;
+}
+
+early_initcall(ux500_l2x0_init);
diff --git a/arch/arm/mach-ux500/cpu.c b/arch/arm/mach-ux500/cpu.c
index 76ee355..252e8b3 100644
--- a/arch/arm/mach-ux500/cpu.c
+++ b/arch/arm/mach-ux500/cpu.c
@@ -11,8 +11,6 @@
 #include <linux/mfd/db8500-prcmu.h>
 #include <linux/mfd/db5500-prcmu.h>
 
-#include <asm/cacheflush.h>
-#include <asm/hardware/cache-l2x0.h>
 #include <asm/hardware/gic.h>
 #include <asm/mach/map.h>
 #include <asm/localtimer.h>
@@ -26,10 +24,6 @@
 
 void __iomem *_PRCMU_BASE;
 
-#ifdef CONFIG_CACHE_L2X0
-static void __iomem *l2x0_base;
-#endif
-
 void __init ux500_init_irq(void)
 {
 	void __iomem *dist_base;
@@ -57,69 +51,6 @@ void __init ux500_init_irq(void)
 	clk_init();
 }
 
-#ifdef CONFIG_CACHE_L2X0
-static inline void ux500_cache_wait(void __iomem *reg, unsigned long mask)
-{
-	/* wait for the operation to complete */
-	while (readl_relaxed(reg) & mask)
-		cpu_relax();
-}
-
-static inline void ux500_cache_sync(void)
-{
-	void __iomem *base = l2x0_base;
-
-	writel_relaxed(0, base + L2X0_CACHE_SYNC);
-	ux500_cache_wait(base + L2X0_CACHE_SYNC, 1);
-}
-
-/*
- * The L2 cache cannot be turned off in the non-secure world.
- * Dummy until a secure service is in place.
- */
-static void ux500_l2x0_disable(void)
-{
-}
-
-/*
- * This is only called when doing a kexec, just after turning off the L2
- * and L1 cache, and it is surrounded by a spinlock in the generic version.
- * However, we're not really turning off the L2 cache right now and the
- * PL310 does not support exclusive accesses (used to implement the spinlock).
- * So, the invalidation needs to be done without the spinlock.
- */
-static void ux500_l2x0_inv_all(void)
-{
-	void __iomem *base = l2x0_base;
-	uint32_t l2x0_way_mask = (1<<16) - 1;	/* Bitmask of active ways */
-
-	/* invalidate all ways */
-	writel_relaxed(l2x0_way_mask, base + L2X0_INV_WAY);
-	ux500_cache_wait(base + L2X0_INV_WAY, l2x0_way_mask);
-	ux500_cache_sync();
-}
-
-static int ux500_l2x0_init(void)
-{
-	if (cpu_is_u5500())
-		l2x0_base = __io_address(U5500_L2CC_BASE);
-	else if (cpu_is_u8500())
-		l2x0_base = __io_address(U8500_L2CC_BASE);
-	else
-		ux500_unknown_soc();
-
-	/* 64KB way size, 8 way associativity, force WA */
-	l2x0_init(l2x0_base, 0x3e060000, 0xc0000fff);
-
-	/* Override invalidate function */
-	outer_cache.disable = ux500_l2x0_disable;
-	outer_cache.inv_all = ux500_l2x0_inv_all;
-
-	return 0;
-}
-early_initcall(ux500_l2x0_init);
-#endif
-
 static void __init ux500_timer_init(void)
 {
 #ifdef CONFIG_LOCAL_TIMERS
-- 
1.7.3.2
