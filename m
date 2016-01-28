From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 28 Jan 2016 12:12:38 -0800
Subject: [PATCH] ARM: Use generic clkdev.h header
In-Reply-To: <6141409.WI4q6BtOxa@wuerfel>
References: <1453932702-6930-1-git-send-email-sboyd@codeaurora.org>
 <6141409.WI4q6BtOxa@wuerfel>
Message-ID: <20160128201238.GN12841@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/28, Arnd Bergmann wrote:
> On Wednesday 27 January 2016 14:11:42 Stephen Boyd wrote:
> > Get rid of the clkdev.h file in the ARM port and use the generic
> > one because we've gotten rid of all the machine specific
> > mach/clkdev.h files.
> > 
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> > 
> 
> Ah, nice! I had not even noticed it was the last one.
> 
> The file is still also referenced by arch/arm/plat-versatile/clock.c,
> but we don't build that file any more and should remove it as well.
> 

Good catch. Here's that patch too.

---8<----
From: Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH] ARM: plat-versatile: Remove unused clock.c file

This file isn't compiled anymore because PLAT_VERSATILE_CLOCK is
never selected. Remove the file and the config.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/plat-versatile/Kconfig  |  3 --
 arch/arm/plat-versatile/Makefile |  1 -
 arch/arm/plat-versatile/clock.c  | 74 ----------------------------------------
 3 files changed, 78 deletions(-)
 delete mode 100644 arch/arm/plat-versatile/clock.c

diff --git a/arch/arm/plat-versatile/Kconfig b/arch/arm/plat-versatile/Kconfig
index 49b8ef91584a..98b9b8e9f698 100644
--- a/arch/arm/plat-versatile/Kconfig
+++ b/arch/arm/plat-versatile/Kconfig
@@ -1,8 +1,5 @@
 if PLAT_VERSATILE
 
-config PLAT_VERSATILE_CLOCK
-	bool
-
 config PLAT_VERSATILE_SCHED_CLOCK
 	bool
 
diff --git a/arch/arm/plat-versatile/Makefile b/arch/arm/plat-versatile/Makefile
index 03c4900ac3f4..bff3ba889882 100644
--- a/arch/arm/plat-versatile/Makefile
+++ b/arch/arm/plat-versatile/Makefile
@@ -1,5 +1,4 @@
 ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include
 
-obj-$(CONFIG_PLAT_VERSATILE_CLOCK) += clock.o
 obj-$(CONFIG_PLAT_VERSATILE_SCHED_CLOCK) += sched-clock.o
 obj-$(CONFIG_SMP) += headsmp.o platsmp.o
diff --git a/arch/arm/plat-versatile/clock.c b/arch/arm/plat-versatile/clock.c
deleted file mode 100644
index 5c8b6564fdc2..000000000000
--- a/arch/arm/plat-versatile/clock.c
+++ /dev/null
@@ -1,74 +0,0 @@
-/*
- *  linux/arch/arm/plat-versatile/clock.c
- *
- *  Copyright (C) 2004 ARM Limited.
- *  Written by Deep Blue Solutions Limited.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/errno.h>
-#include <linux/clk.h>
-#include <linux/mutex.h>
-
-#include <asm/hardware/icst.h>
-
-#include <mach/clkdev.h>
-
-int clk_enable(struct clk *clk)
-{
-	return 0;
-}
-EXPORT_SYMBOL(clk_enable);
-
-void clk_disable(struct clk *clk)
-{
-}
-EXPORT_SYMBOL(clk_disable);
-
-unsigned long clk_get_rate(struct clk *clk)
-{
-	return clk->rate;
-}
-EXPORT_SYMBOL(clk_get_rate);
-
-long clk_round_rate(struct clk *clk, unsigned long rate)
-{
-	long ret = -EIO;
-	if (clk->ops && clk->ops->round)
-		ret = clk->ops->round(clk, rate);
-	return ret;
-}
-EXPORT_SYMBOL(clk_round_rate);
-
-int clk_set_rate(struct clk *clk, unsigned long rate)
-{
-	int ret = -EIO;
-	if (clk->ops && clk->ops->set)
-		ret = clk->ops->set(clk, rate);
-	return ret;
-}
-EXPORT_SYMBOL(clk_set_rate);
-
-long icst_clk_round(struct clk *clk, unsigned long rate)
-{
-	struct icst_vco vco;
-	vco = icst_hz_to_vco(clk->params, rate);
-	return icst_hz(clk->params, vco);
-}
-EXPORT_SYMBOL(icst_clk_round);
-
-int icst_clk_set(struct clk *clk, unsigned long rate)
-{
-	struct icst_vco vco;
-
-	vco = icst_hz_to_vco(clk->params, rate);
-	clk->rate = icst_hz(clk->params, vco);
-	clk->ops->setvco(clk, vco);
-
-	return 0;
-}
-EXPORT_SYMBOL(icst_clk_set);
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
