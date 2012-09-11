From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 11 Sep 2012 08:53:16 +0200
Subject: [PATCH 2/2] ARM: i.MX remove last leftovers from legacy clock support
In-Reply-To: <1347346396-27669-1-git-send-email-s.hauer@pengutronix.de>
References: <1347346396-27669-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1347346396-27669-3-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This also removes mach/clock.h along the way

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-imx/Makefile             |    2 +-
 arch/arm/mach-imx/clk-pllv1.c          |    2 +-
 arch/arm/mach-imx/clk.c                |    3 +
 arch/arm/mach-imx/clk.h                |    3 +-
 arch/arm/mach-imx/mach-kzm_arm11_01.c  |    1 -
 arch/arm/plat-mxc/Makefile             |    2 +-
 arch/arm/plat-mxc/clock.c              |  212 --------------------------------
 arch/arm/plat-mxc/cpufreq.c            |    1 -
 arch/arm/plat-mxc/include/mach/clock.h |   68 ----------
 9 files changed, 8 insertions(+), 286 deletions(-)
 create mode 100644 arch/arm/mach-imx/clk.c
 delete mode 100644 arch/arm/plat-mxc/clock.c
 delete mode 100644 arch/arm/plat-mxc/include/mach/clock.h

diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 07f7c22..e407d92 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -12,7 +12,7 @@ obj-$(CONFIG_SOC_IMX35) += mm-imx3.o cpu-imx35.o clk-imx35.o ehci-imx35.o pm-imx
 obj-$(CONFIG_SOC_IMX5) += cpu-imx5.o mm-imx5.o clk-imx51-imx53.o ehci-imx5.o pm-imx5.o cpu_op-mx51.o
 
 obj-$(CONFIG_COMMON_CLK) += clk-pllv1.o clk-pllv2.o clk-pllv3.o clk-gate2.o \
-			    clk-pfd.o clk-busy.o
+			    clk-pfd.o clk-busy.o clk.o
 
 # Support for CMOS sensor interface
 obj-$(CONFIG_MX1_VIDEO) += mx1-camera-fiq.o mx1-camera-fiq-ksym.o
diff --git a/arch/arm/mach-imx/clk-pllv1.c b/arch/arm/mach-imx/clk-pllv1.c
index 4a03c93..02be731 100644
--- a/arch/arm/mach-imx/clk-pllv1.c
+++ b/arch/arm/mach-imx/clk-pllv1.c
@@ -6,7 +6,7 @@
 #include <linux/err.h>
 #include <mach/common.h>
 #include <mach/hardware.h>
-#include <mach/clock.h>
+
 #include "clk.h"
 
 /**
diff --git a/arch/arm/mach-imx/clk.c b/arch/arm/mach-imx/clk.c
new file mode 100644
index 0000000..f5e8be8
--- /dev/null
+++ b/arch/arm/mach-imx/clk.c
@@ -0,0 +1,3 @@
+#include <linux/spinlock.h>
+
+DEFINE_SPINLOCK(imx_ccm_lock);
diff --git a/arch/arm/mach-imx/clk.h b/arch/arm/mach-imx/clk.h
index 1bf64fe..5f2d8ac 100644
--- a/arch/arm/mach-imx/clk.h
+++ b/arch/arm/mach-imx/clk.h
@@ -3,7 +3,8 @@
 
 #include <linux/spinlock.h>
 #include <linux/clk-provider.h>
-#include <mach/clock.h>
+
+extern spinlock_t imx_ccm_lock;
 
 struct clk *imx_clk_pllv1(const char *name, const char *parent,
 		void __iomem *base);
diff --git a/arch/arm/mach-imx/mach-kzm_arm11_01.c b/arch/arm/mach-imx/mach-kzm_arm11_01.c
index 5d08533..8dc9d3e 100644
--- a/arch/arm/mach-imx/mach-kzm_arm11_01.c
+++ b/arch/arm/mach-imx/mach-kzm_arm11_01.c
@@ -36,7 +36,6 @@
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
 
-#include <mach/clock.h>
 #include <mach/common.h>
 #include <mach/hardware.h>
 #include <mach/iomux-mx3.h>
diff --git a/arch/arm/plat-mxc/Makefile b/arch/arm/plat-mxc/Makefile
index 6ac7200..149237e 100644
--- a/arch/arm/plat-mxc/Makefile
+++ b/arch/arm/plat-mxc/Makefile
@@ -3,7 +3,7 @@
 #
 
 # Common support
-obj-y := clock.o time.o devices.o cpu.o system.o irq-common.o
+obj-y := time.o devices.o cpu.o system.o irq-common.o
 
 obj-$(CONFIG_MXC_TZIC) += tzic.o
 obj-$(CONFIG_MXC_AVIC) += avic.o
diff --git a/arch/arm/plat-mxc/clock.c b/arch/arm/plat-mxc/clock.c
deleted file mode 100644
index 0ed0954..0000000
--- a/arch/arm/plat-mxc/clock.c
+++ /dev/null
@@ -1,212 +0,0 @@
-/*
- * Based on arch/arm/plat-omap/clock.c
- *
- * Copyright (C) 2004 - 2005 Nokia corporation
- * Written by Tuukka Tikkanen <tuukka.tikkanen@elektrobit.com>
- * Modified for omap shared clock framework by Tony Lindgren <tony@atomide.com>
- * Copyright 2007 Freescale Semiconductor, Inc. All Rights Reserved.
- * Copyright 2008 Juergen Beisert, kernel at pengutronix.de
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version 2
- * of the License, or (at your option) any later version.
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
- * MA  02110-1301, USA.
- */
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
-#include <mach/clock.h>
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
-
-/*
- * Lock to protect the clock module (ccm) registers. Used
- * on all i.MXs
- */
-DEFINE_SPINLOCK(imx_ccm_lock);
-
-#endif /* CONFIG_COMMON_CLK */
diff --git a/arch/arm/plat-mxc/cpufreq.c b/arch/arm/plat-mxc/cpufreq.c
index 73db34b..b5b6f80 100644
--- a/arch/arm/plat-mxc/cpufreq.c
+++ b/arch/arm/plat-mxc/cpufreq.c
@@ -23,7 +23,6 @@
 #include <linux/err.h>
 #include <linux/slab.h>
 #include <mach/hardware.h>
-#include <mach/clock.h>
 
 #define CLK32_FREQ	32768
 #define NANOSECOND	(1000 * 1000 * 1000)
diff --git a/arch/arm/plat-mxc/include/mach/clock.h b/arch/arm/plat-mxc/include/mach/clock.h
deleted file mode 100644
index 0c4ad77..0000000
--- a/arch/arm/plat-mxc/include/mach/clock.h
+++ /dev/null
@@ -1,68 +0,0 @@
-/*
- * Copyright 2005-2007 Freescale Semiconductor, Inc. All Rights Reserved.
- * Copyright 2008 Juergen Beisert, kernel at pengutronix.de
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version 2
- * of the License, or (at your option) any later version.
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
- * MA  02110-1301, USA.
- */
-
-#ifndef __ASM_ARCH_MXC_CLOCK_H__
-#define __ASM_ARCH_MXC_CLOCK_H__
-
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
-extern spinlock_t imx_ccm_lock;
-
-#endif /* __ASSEMBLY__ */
-#endif /* __ASM_ARCH_MXC_CLOCK_H__ */
-- 
1.7.10.4
