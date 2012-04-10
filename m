From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 10 Apr 2012 15:45:50 +0200
Subject: [PATCH 37/40] ARM i.MX: remove unused legacy clock support
In-Reply-To: <1334065553-7565-1-git-send-email-s.hauer@pengutronix.de>
References: <1334065553-7565-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1334065553-7565-38-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/plat-mxc/clock.c              |  188 +-------------------------------
 arch/arm/plat-mxc/include/mach/clock.h |   43 --------
 2 files changed, 1 insertion(+), 230 deletions(-)

diff --git a/arch/arm/plat-mxc/clock.c b/arch/arm/plat-mxc/clock.c
index 0ed0954..2b73f3f 100644
--- a/arch/arm/plat-mxc/clock.c
+++ b/arch/arm/plat-mxc/clock.c
@@ -1,9 +1,4 @@
 /*
- * Based on arch/arm/plat-omap/clock.c
- *
- * Copyright (C) 2004 - 2005 Nokia corporation
- * Written by Tuukka Tikkanen <tuukka.tikkanen@elektrobit.com>
- * Modified for omap shared clock framework by Tony Lindgren <tony@atomide.com>
  * Copyright 2007 Freescale Semiconductor, Inc. All Rights Reserved.
  * Copyright 2008 Juergen Beisert, kernel at pengutronix.de
  *
@@ -21,192 +16,11 @@
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
  * MA  02110-1301, USA.
  */
-
-/* #define DEBUG */
-
-#include <linux/clk.h>
-#include <linux/err.h>
-#include <linux/errno.h>
-#include <linux/init.h>
-#include <linux/io.h>
-#include <linux/kernel.h>
-#include <linux/list.h>
-#include <linux/module.h>
-#include <linux/mutex.h>
-#include <linux/platform_device.h>
-#include <linux/proc_fs.h>
-#include <linux/semaphore.h>
-#include <linux/string.h>
-
+#include <linux/spinlock.h>
 #include <mach/clock.h>
-#include <mach/hardware.h>
-
-#ifndef CONFIG_COMMON_CLK
-static LIST_HEAD(clocks);
-static DEFINE_MUTEX(clocks_mutex);
-
-/*-------------------------------------------------------------------------
- * Standard clock functions defined in include/linux/clk.h
- *-------------------------------------------------------------------------*/
-
-static void __clk_disable(struct clk *clk)
-{
-	if (clk == NULL || IS_ERR(clk))
-		return;
-	WARN_ON(!clk->usecount);
-
-	if (!(--clk->usecount)) {
-		if (clk->disable)
-			clk->disable(clk);
-		__clk_disable(clk->parent);
-		__clk_disable(clk->secondary);
-	}
-}
-
-static int __clk_enable(struct clk *clk)
-{
-	if (clk == NULL || IS_ERR(clk))
-		return -EINVAL;
-
-	if (clk->usecount++ == 0) {
-		__clk_enable(clk->parent);
-		__clk_enable(clk->secondary);
-
-		if (clk->enable)
-			clk->enable(clk);
-	}
-	return 0;
-}
-
-/* This function increments the reference count on the clock and enables the
- * clock if not already enabled. The parent clock tree is recursively enabled
- */
-int clk_enable(struct clk *clk)
-{
-	int ret = 0;
-
-	if (clk == NULL || IS_ERR(clk))
-		return -EINVAL;
-
-	mutex_lock(&clocks_mutex);
-	ret = __clk_enable(clk);
-	mutex_unlock(&clocks_mutex);
-
-	return ret;
-}
-EXPORT_SYMBOL(clk_enable);
-
-/* This function decrements the reference count on the clock and disables
- * the clock when reference count is 0. The parent clock tree is
- * recursively disabled
- */
-void clk_disable(struct clk *clk)
-{
-	if (clk == NULL || IS_ERR(clk))
-		return;
-
-	mutex_lock(&clocks_mutex);
-	__clk_disable(clk);
-	mutex_unlock(&clocks_mutex);
-}
-EXPORT_SYMBOL(clk_disable);
-
-/* Retrieve the *current* clock rate. If the clock itself
- * does not provide a special calculation routine, ask
- * its parent and so on, until one is able to return
- * a valid clock rate
- */
-unsigned long clk_get_rate(struct clk *clk)
-{
-	if (clk == NULL || IS_ERR(clk))
-		return 0UL;
-
-	if (clk->get_rate)
-		return clk->get_rate(clk);
-
-	return clk_get_rate(clk->parent);
-}
-EXPORT_SYMBOL(clk_get_rate);
-
-/* Round the requested clock rate to the nearest supported
- * rate that is less than or equal to the requested rate.
- * This is dependent on the clock's current parent.
- */
-long clk_round_rate(struct clk *clk, unsigned long rate)
-{
-	if (clk == NULL || IS_ERR(clk) || !clk->round_rate)
-		return 0;
-
-	return clk->round_rate(clk, rate);
-}
-EXPORT_SYMBOL(clk_round_rate);
-
-/* Set the clock to the requested clock rate. The rate must
- * match a supported rate exactly based on what clk_round_rate returns
- */
-int clk_set_rate(struct clk *clk, unsigned long rate)
-{
-	int ret = -EINVAL;
-
-	if (clk == NULL || IS_ERR(clk) || clk->set_rate == NULL || rate == 0)
-		return ret;
-
-	mutex_lock(&clocks_mutex);
-	ret = clk->set_rate(clk, rate);
-	mutex_unlock(&clocks_mutex);
-
-	return ret;
-}
-EXPORT_SYMBOL(clk_set_rate);
-
-/* Set the clock's parent to another clock source */
-int clk_set_parent(struct clk *clk, struct clk *parent)
-{
-	int ret = -EINVAL;
-	struct clk *old;
-
-	if (clk == NULL || IS_ERR(clk) || parent == NULL ||
-	    IS_ERR(parent) || clk->set_parent == NULL)
-		return ret;
-
-	if (clk->usecount)
-		clk_enable(parent);
-
-	mutex_lock(&clocks_mutex);
-	ret = clk->set_parent(clk, parent);
-	if (ret == 0) {
-		old = clk->parent;
-		clk->parent = parent;
-	} else {
-		old = parent;
-	}
-	mutex_unlock(&clocks_mutex);
-
-	if (clk->usecount)
-		clk_disable(old);
-
-	return ret;
-}
-EXPORT_SYMBOL(clk_set_parent);
-
-/* Retrieve the clock's parent clock source */
-struct clk *clk_get_parent(struct clk *clk)
-{
-	struct clk *ret = NULL;
-
-	if (clk == NULL || IS_ERR(clk))
-		return ret;
-
-	return clk->parent;
-}
-EXPORT_SYMBOL(clk_get_parent);
-
-#else
 
 /*
  * Lock to protect the clock module (ccm) registers. Used
  * on all i.MXs
  */
 DEFINE_SPINLOCK(imx_ccm_lock);
-
-#endif /* CONFIG_COMMON_CLK */
diff --git a/arch/arm/plat-mxc/include/mach/clock.h b/arch/arm/plat-mxc/include/mach/clock.h
index 0c4ad77..76b990c 100644
--- a/arch/arm/plat-mxc/include/mach/clock.h
+++ b/arch/arm/plat-mxc/include/mach/clock.h
@@ -20,49 +20,6 @@
 #ifndef __ASM_ARCH_MXC_CLOCK_H__
 #define __ASM_ARCH_MXC_CLOCK_H__
 
-#ifndef __ASSEMBLY__
-#include <linux/list.h>
-
-#ifndef CONFIG_COMMON_CLK
-struct module;
-
-struct clk {
-	int id;
-	/* Source clock this clk depends on */
-	struct clk *parent;
-	/* Secondary clock to enable/disable with this clock */
-	struct clk *secondary;
-	/* Reference count of clock enable/disable */
-	__s8 usecount;
-	/* Register bit position for clock's enable/disable control. */
-	u8 enable_shift;
-	/* Register address for clock's enable/disable control. */
-	void __iomem *enable_reg;
-	u32 flags;
-	/* get the current clock rate (always a fresh value) */
-	unsigned long (*get_rate) (struct clk *);
-	/* Function ptr to set the clock to a new rate. The rate must match a
-	   supported rate returned from round_rate. Leave blank if clock is not
-	   programmable */
-	int (*set_rate) (struct clk *, unsigned long);
-	/* Function ptr to round the requested clock rate to the nearest
-	   supported rate that is less than or equal to the requested rate. */
-	unsigned long (*round_rate) (struct clk *, unsigned long);
-	/* Function ptr to enable the clock. Leave blank if clock can not
-	   be gated. */
-	int (*enable) (struct clk *);
-	/* Function ptr to disable the clock. Leave blank if clock can not
-	   be gated. */
-	void (*disable) (struct clk *);
-	/* Function ptr to set the parent clock of the clock. */
-	int (*set_parent) (struct clk *, struct clk *);
-};
-
-int clk_register(struct clk *clk);
-void clk_unregister(struct clk *clk);
-#endif /* CONFIG_COMMON_CLK */
-
 extern spinlock_t imx_ccm_lock;
 
-#endif /* __ASSEMBLY__ */
 #endif /* __ASM_ARCH_MXC_CLOCK_H__ */
-- 
1.7.9.5
