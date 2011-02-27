From: linux@prisktech.co.nz (Linux Mailing List Email Account)
Date: Sun, 27 Feb 2011 00:05:15 -0000
Subject: [PATCH 2/3] VIA/Wondermedia clock support
Message-ID: <76F764B079F92A4E843589C893D0A0228CC1@SERVER.prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Tony Prisk (linux at prisktech.co.nz)
--- /dev/null   2011-02-26 19:04:30.530140059 +1300
+++ arch/arm/mach-vt8500/clock.c     2011-02-27 12:12:39.000000000 +1300
@@ -0,0 +1,164 @@
+/*
+ *  arch/arm/mach-vt8500/clock.c
+ *
+ *  Copyright (C) 2011 Tony Prisk
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/mutex.h>
+#include <linux/io.h>
+#include <linux/delay.h>
+#include <linux/list.h>
+
+#include "clock.h"
+
+static LIST_HEAD(clocks);
+
+static DEFINE_SPINLOCK(clocks_lock);
+static DEFINE_MUTEX(clocks_mutex);
+
+static void __clk_enable(struct clk *clk)
+{
+    if (clk->parent)
+          __clk_enable(clk->parent);
+    if (clk->usecount++ == 0)
+          if (clk->type & CLK_ENABLE)
+               clk->ops->enable(clk);
+}
+
+static void __clk_disable(struct clk *clk)
+{
+    if (--clk->usecount == 0)
+          if (clk->type & CLK_ENABLE)
+               clk->ops->disable(clk);
+    if (clk->parent)
+          __clk_disable(clk->parent);
+}
+
+int clk_enable(struct clk *clk)
+{
+    unsigned long flags;
+
+    spin_lock_irqsave(&clocks_lock, flags);
+    __clk_enable(clk);
+    spin_unlock_irqrestore(&clocks_lock, flags);
+
+    if (clk->delay)
+          udelay(clk->delay);
+
+    return 0;
+}
+EXPORT_SYMBOL(clk_enable);
+
+void clk_disable(struct clk *clk)
+{
+    unsigned long flags;
+
+    WARN_ON(clk->usecount == 0);
+
+    spin_lock_irqsave(&clocks_lock, flags);
+    __clk_disable(clk);
+    spin_unlock_irqrestore(&clocks_lock, flags);
+}
+EXPORT_SYMBOL(clk_disable);
+
+unsigned long clk_get_rate(struct clk *clk)
+{
+    unsigned long rate;
+
+    if (clk == NULL || IS_ERR(clk))
+          return -EINVAL;
+
+    rate = clk->rate;
+    if ((clk->ops->getrate) && (clk->type & CLK_PROGRAMABLE))
+          rate = clk->ops->getrate(clk);
+
+    return rate;
+}
+EXPORT_SYMBOL(clk_get_rate);
+
+static void propagate_rate(struct clk *root)
+{
+    struct clk *clk;
+
+    list_for_each_entry(clk, &root->children, childnode) {
+          if (clk->ops->setrate)
+               clk->ops->setrate(clk, clk->rate);
+          if (clk->ops->getrate)
+               clk->rate = clk->ops->getrate(clk);
+          propagate_rate(clk);
+    }
+}
+
+int clk_set_rate(struct clk *clk, unsigned long rate)
+{
+    unsigned long flags;
+
+    if (clk == NULL || IS_ERR(clk))
+          return -EINVAL;
+
+    if (!(clk->type & CLK_PROGRAMABLE))
+          return -EINVAL;
+
+    if (clk->ops->setrate)
+          clk->ops->setrate(clk, rate);
+
+    if (clk->ops->getrate)
+          clk->rate = clk->ops->getrate(clk);
+
+    spin_lock_irqsave(&clocks_lock, flags);
+    if (!(clk->type & CLK_NO_PROPAGATE))
+          propagate_rate(clk);
+    spin_unlock_irqrestore(&clocks_lock, flags);
+
+    return 0;
+}
+EXPORT_SYMBOL(clk_set_rate);
+
+int clk_register(struct clk *clk)
+{
+    if (clk == NULL || IS_ERR(clk))
+          return -EINVAL;
+
+    if (clk->parent && !clk->parent->rate)
+          return -EINVAL;
+
+    INIT_LIST_HEAD(&clk->children);
+
+    mutex_lock(&clocks_mutex);
+    list_add_tail(&clk->node, &clocks);
+    if (clk->parent)
+          list_add_tail(&clk->childnode, &clk->parent->children);
+    mutex_unlock(&clocks_mutex);
+
+    /* if rate already set, use it */
+    if (clk->rate)
+          return 0;
+
+    /* see if we can calculate the rate */
+    if (clk->ops->getrate)
+          clk->ops->getrate(clk);
+    /* otherwise use the parents rate */
+    else if (clk->parent)
+          clk->rate = clk->parent->rate;
+
+    return 0;
+}


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110227/1fe5ec4a/attachment.html>
