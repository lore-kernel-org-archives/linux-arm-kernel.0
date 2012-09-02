From: sylvester.nawrocki@gmail.com (Sylwester Nawrocki)
Date: Sun,  2 Sep 2012 18:37:03 +0200
Subject: [PATCH] ARM: Samsung: Remove unused code for the clocks debug-fs
 interface
Message-ID: <1346603823-14422-1-git-send-email-sylvester.nawrocki@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit f86c6660927614fcda257 "ARM: SAMSUNG: Add clkdev infrastructure"
disabled population of the 'clocks' list - the clocks are now on the
clkdev clock list. However, this effectively broke the existing clocks
debug-fs interface on all Samsung platforms. Nobody complained about
this missing feature for over one year, so remove the unused code.

This functionality will be restored when switching to the common clock
framework.

Signed-off-by: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
---
 arch/arm/plat-samsung/clock.c              |   92 ----------------------------
 arch/arm/plat-samsung/include/plat/clock.h |    8 +--
 2 files changed, 1 insertions(+), 99 deletions(-)

diff --git a/arch/arm/plat-samsung/clock.c b/arch/arm/plat-samsung/clock.c
index 65c5eca..a8a69af 100644
--- a/arch/arm/plat-samsung/clock.c
+++ b/arch/arm/plat-samsung/clock.c
@@ -39,25 +39,17 @@
 #include <linux/clk.h>
 #include <linux/spinlock.h>
 #include <linux/io.h>
-#if defined(CONFIG_DEBUG_FS)
-#include <linux/debugfs.h>
-#endif

 #include <mach/hardware.h>
 #include <asm/irq.h>

 #include <plat/cpu-freq.h>
-
 #include <plat/clock.h>
 #include <plat/cpu.h>

 #include <linux/serial_core.h>
 #include <plat/regs-serial.h> /* for s3c24xx_uart_devs */

-/* clock information */
-
-static LIST_HEAD(clocks);
-
 /* We originally used an mutex here, but some contexts (see resume)
  * are calling functions such as clk_set_parent() with IRQs disabled
  * causing an BUG to be triggered.
@@ -381,87 +373,3 @@ int __init s3c24xx_register_baseclocks(unsigned long xtal)

 	return 0;
 }
-
-#if defined(CONFIG_PM_DEBUG) && defined(CONFIG_DEBUG_FS)
-/* debugfs support to trace clock tree hierarchy and attributes */
-
-static struct dentry *clk_debugfs_root;
-
-static int clk_debugfs_register_one(struct clk *c)
-{
-	int err;
-	struct dentry *d;
-	struct clk *pa = c->parent;
-	char s[255];
-	char *p = s;
-
-	p += sprintf(p, "%s", c->devname);
-
-	d = debugfs_create_dir(s, pa ? pa->dent : clk_debugfs_root);
-	if (!d)
-		return -ENOMEM;
-
-	c->dent = d;
-
-	d = debugfs_create_u8("usecount", S_IRUGO, c->dent, (u8 *)&c->usage);
-	if (!d) {
-		err = -ENOMEM;
-		goto err_out;
-	}
-
-	d = debugfs_create_u32("rate", S_IRUGO, c->dent, (u32 *)&c->rate);
-	if (!d) {
-		err = -ENOMEM;
-		goto err_out;
-	}
-	return 0;
-
-err_out:
-	debugfs_remove_recursive(c->dent);
-	return err;
-}
-
-static int clk_debugfs_register(struct clk *c)
-{
-	int err;
-	struct clk *pa = c->parent;
-
-	if (pa && !pa->dent) {
-		err = clk_debugfs_register(pa);
-		if (err)
-			return err;
-	}
-
-	if (!c->dent) {
-		err = clk_debugfs_register_one(c);
-		if (err)
-			return err;
-	}
-	return 0;
-}
-
-static int __init clk_debugfs_init(void)
-{
-	struct clk *c;
-	struct dentry *d;
-	int err;
-
-	d = debugfs_create_dir("clock", NULL);
-	if (!d)
-		return -ENOMEM;
-	clk_debugfs_root = d;
-
-	list_for_each_entry(c, &clocks, list) {
-		err = clk_debugfs_register(c);
-		if (err)
-			goto err_out;
-	}
-	return 0;
-
-err_out:
-	debugfs_remove_recursive(clk_debugfs_root);
-	return err;
-}
-late_initcall(clk_debugfs_init);
-
-#endif /* defined(CONFIG_PM_DEBUG) && defined(CONFIG_DEBUG_FS) */
diff --git a/arch/arm/plat-samsung/include/plat/clock.h b/arch/arm/plat-samsung/include/plat/clock.h
index a62753d..16f3cd6 100644
--- a/arch/arm/plat-samsung/include/plat/clock.h
+++ b/arch/arm/plat-samsung/include/plat/clock.h
@@ -1,5 +1,4 @@
-/* linux/arch/arm/plat-s3c/include/plat/clock.h
- *
+/*
  * Copyright (c) 2004-2005 Simtec Electronics
  *	http://www.simtec.co.uk/products/SWLINUX/
  *	Written by Ben Dooks, <ben@simtec.co.uk>
@@ -40,8 +39,6 @@ struct clk_ops {
 };

 struct clk {
-	struct list_head      list;
-	struct module        *owner;
 	struct clk           *parent;
 	const char           *name;
 	const char		*devname;
@@ -53,9 +50,6 @@ struct clk {
 	struct clk_ops		*ops;
 	int		    (*enable)(struct clk *, int enable);
 	struct clk_lookup	lookup;
-#if defined(CONFIG_PM_DEBUG) && defined(CONFIG_DEBUG_FS)
-	struct dentry		*dent;	/* For visible tree hierarchy */
-#endif
 };

 /* other clocks which may be registered by board support */
--
1.7.4.1
