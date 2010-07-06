From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Tue, 06 Jul 2010 14:41:12 +0900
Subject: [RFC PATCH 1/3] ARM: SAMSUNG: Add common struct clk support for
	Samsung SoCs
In-Reply-To: <1278394874-8695-1-git-send-email-myungjoo.ham@samsung.com>
References: <1278394874-8695-1-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <1278394874-8695-2-git-send-email-myungjoo.ham@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Based on the common struct clk patch ([PATCH 0/2] Common struct clk
implementation, v5) by Jeremy Kerr, we have revised struct clk support
for Samsung SoCs.

Because there are machines without common struct clk patch, we have
separated common-clk and the conventional clk codes; i.e.,
*-common-clk.c files have common-struct-clk specific codes and their
counter parts have the conventional struct-clk specific codes. However,
when we may need to merge them if having separated codes cost too much.

To accompany with common struct clk, we have defined struct clk_samsung
that contains info from the conventional struct clk and the common
struct clk:

struct clk_samsung {
        struct clk              clk;

        struct list_head        list;
        struct module           *owner;
        struct clk              *parent;
        const char              *name;
        int                     id;
        unsigned long           rate;
        unsigned long           ctrlbit;
        int                     (*enable)(struct clk_samsung *, int enable);
};

In principal, we have implemented/changed ops for clk_samsung with
common struct clk and modified register functions for common struct clk.
Besides, definitions for clocks have been modified in order to accompany
with the changed structure.

Note that unlike the previous clk framework, which assigns default ops
automatically, each clk should be initialized with every 'ops' needed.
However, if "ops" is NULL when initialized, clock register function
in arch/arm/plat-samsung/clock-common-clk.c assigns the default ops
(declared at arch/arm/plat-samsung/include/plat/clock.h). The clock
register function will incur WARN_ON if any of ops is not set.

Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/plat-samsung/Kconfig                     |    9 +
 arch/arm/plat-samsung/Makefile                    |    9 +-
 arch/arm/plat-samsung/clock-clksrc-common-clk.c   |  238 ++++++++++
 arch/arm/plat-samsung/clock-common-clk.c          |  471 +++++++++++++++++++
 arch/arm/plat-samsung/include/plat/clock-clksrc.h |    8 +
 arch/arm/plat-samsung/include/plat/clock.h        |   68 +++
 arch/arm/plat-samsung/pwm-clock-common-clk.c      |  499 +++++++++++++++++++++
 7 files changed, 1299 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/plat-samsung/clock-clksrc-common-clk.c
 create mode 100644 arch/arm/plat-samsung/clock-common-clk.c
 create mode 100644 arch/arm/plat-samsung/pwm-clock-common-clk.c

diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index 2753fb3..5709537 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -293,4 +293,13 @@ config SAMSUNG_WAKEMASK
 	  and above. This code allows a set of interrupt to wakeup-mask
 	  mappings. See <plat/wakeup-mask.h>
 
+config SAMSUNG_CLKSRC_USE_COMMON_STRUCT_CLK
+	def_bool (SAMSUNG_CLKSRC && USE_COMMON_STRUCT_CLK)
+
+config SAMSUNG_CLKSRC_USE_NONCOMMON_STRUCT_CLK
+	def_bool (SAMSUNG_CLKSRC && !USE_COMMON_STRUCT_CLK)
+
+config USE_NONCOMMON_STRUCT_CLK
+        def_bool (!USE_COMMON_STRUCT_CLK)
+
 endif
diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
index b1d82cc..9e22c73 100644
--- a/arch/arm/plat-samsung/Makefile
+++ b/arch/arm/plat-samsung/Makefile
@@ -13,13 +13,16 @@ obj-				:=
 
 obj-y				+= init.o
 obj-y				+= time.o
-obj-y				+= clock.o
-obj-y				+= pwm-clock.o
+obj-$(CONFIG_USE_NONCOMMON_STRUCT_CLK)				+= clock.o
+obj-$(CONFIG_USE_COMMON_STRUCT_CLK)				+= clock-common-clk.o
+obj-$(CONFIG_USE_NONCOMMON_STRUCT_CLK)				+= pwm-clock.o
+obj-$(CONFIG_USE_COMMON_STRUCT_CLK)				+= pwm-clock-common-clk.o
 obj-y				+= gpio.o
 obj-y				+= gpio-config.o
 
 obj-$(CONFIG_SAMSUNG_GPIOLIB_4BIT)	+= gpiolib.o
-obj-$(CONFIG_SAMSUNG_CLKSRC)	+= clock-clksrc.o
+obj-$(CONFIG_SAMSUNG_CLKSRC_USE_NONCOMMON_STRUCT_CLK)	+= clock-clksrc.o
+obj-$(CONFIG_SAMSUNG_CLKSRC_USE_COMMON_STRUCT_CLK)	+= clock-clksrc-common-clk.o
 
 obj-$(CONFIG_SAMSUNG_IRQ_UART)	+= irq-uart.o
 obj-$(CONFIG_SAMSUNG_IRQ_VIC_TIMER) += irq-vic-timer.o
diff --git a/arch/arm/plat-samsung/clock-clksrc-common-clk.c b/arch/arm/plat-samsung/clock-clksrc-common-clk.c
new file mode 100644
index 0000000..dd26bc2
--- /dev/null
+++ b/arch/arm/plat-samsung/clock-clksrc-common-clk.c
@@ -0,0 +1,238 @@
+/* linux/arch/arm/plat-samsung/clock-clksrc.c
+ *
+ * Copyright 2008 Simtec Electronics
+ *	Ben Dooks <ben@simtec.co.uk>
+ *	http://armlinux.simtec.co.uk/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/errno.h>
+#include <linux/err.h>
+#include <linux/clk.h>
+#include <linux/sysdev.h>
+#include <linux/io.h>
+
+#include <plat/clock.h>
+#include <plat/clock-clksrc.h>
+#include <plat/cpu-freq.h>
+
+static inline struct clksrc_clk *to_clksrc(struct clk_samsung *clk)
+{
+	return container_of(clk, struct clksrc_clk, clk);
+}
+
+static inline u32 bit_mask(u32 shift, u32 nr_bits)
+{
+	u32 mask = 0xffffffff >> (32 - nr_bits);
+
+	return mask << shift;
+}
+
+static unsigned long s3c_getrate_clksrc(struct clk *_clk)
+{
+	struct clk_samsung *clk = to_clk_samsung(_clk);
+	struct clksrc_clk *sclk = to_clksrc(clk);
+	unsigned long rate = clk_get_rate(clk->parent);
+	u32 clkdiv = __raw_readl(sclk->reg_div.reg);
+	u32 mask = bit_mask(sclk->reg_div.shift, sclk->reg_div.size);
+
+	clkdiv &= mask;
+	clkdiv >>= sclk->reg_div.shift;
+	clkdiv++;
+
+	rate /= clkdiv;
+	return rate;
+}
+
+static int s3c_setrate_clksrc(struct clk *_clk, unsigned long rate)
+{
+	struct clk_samsung *clk = to_clk_samsung(_clk);
+	struct clksrc_clk *sclk = to_clksrc(clk);
+	void __iomem *reg = sclk->reg_div.reg;
+	unsigned int div;
+	u32 mask = bit_mask(sclk->reg_div.shift, sclk->reg_div.size);
+	u32 val;
+
+	rate = clk_round_rate(&clk->clk, rate);
+	div = clk_get_rate(clk->parent) / rate;
+	if (div > (1 << sclk->reg_div.size))
+		return -EINVAL;
+
+	val = __raw_readl(reg);
+	val &= ~mask;
+	val |= (div - 1) << sclk->reg_div.shift;
+	__raw_writel(val, reg);
+
+	return 0;
+}
+
+static int s3c_setparent_clksrc(struct clk *_clk, struct clk *parent)
+{
+	struct clk_samsung *clk = to_clk_samsung(_clk);
+	struct clksrc_clk *sclk = to_clksrc(clk);
+	struct clksrc_sources *srcs = sclk->sources;
+	u32 clksrc = __raw_readl(sclk->reg_src.reg);
+	u32 mask = bit_mask(sclk->reg_src.shift, sclk->reg_src.size);
+	int src_nr = -1;
+	int ptr;
+
+	for (ptr = 0; ptr < srcs->nr_sources; ptr++)
+		if (&srcs->sources[ptr]->clk == parent) {
+			src_nr = ptr;
+			break;
+		}
+
+	if (src_nr >= 0) {
+		clk->parent = parent;
+
+		clksrc &= ~mask;
+		clksrc |= src_nr << sclk->reg_src.shift;
+
+		__raw_writel(clksrc, sclk->reg_src.reg);
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static long s3c_roundrate_clksrc(struct clk *_clk,
+					      unsigned long rate)
+{
+	struct clk_samsung *clk = to_clk_samsung(_clk);
+	struct clksrc_clk *sclk = to_clksrc(clk);
+	unsigned long parent_rate = clk_get_rate(clk->parent);
+	int max_div = 1 << sclk->reg_div.size;
+	int div;
+
+	if (rate >= parent_rate)
+		rate = parent_rate;
+	else {
+		div = parent_rate / rate;
+		if (parent_rate % rate)
+			div++;
+
+		if (div == 0)
+			div = 1;
+		if (div > max_div)
+			div = max_div;
+
+		rate = parent_rate / div;
+	}
+
+	return rate;
+}
+
+/* Clock initialisation code */
+
+void __init_or_cpufreq s3c_set_clksrc(struct clksrc_clk *clk, bool announce)
+{
+	struct clksrc_sources *srcs = clk->sources;
+	u32 mask = bit_mask(clk->reg_src.shift, clk->reg_src.size);
+	u32 clksrc;
+
+	if (!clk->reg_src.reg) {
+		if (!clk->clk.parent)
+			printk(KERN_ERR "%s: no parent clock specified\n",
+				clk->clk.name);
+		return;
+	}
+
+	clksrc = __raw_readl(clk->reg_src.reg);
+	clksrc &= mask;
+	clksrc >>= clk->reg_src.shift;
+
+	if (clksrc > srcs->nr_sources || !srcs->sources[clksrc]) {
+		printk(KERN_ERR "%s: bad source %d\n",
+		       clk->clk.name, clksrc);
+		return;
+	}
+
+	clk->clk.parent = &srcs->sources[clksrc]->clk;
+
+	if (announce)
+		printk(KERN_INFO "%s: source is %s (%d), rate is %ld\n",
+		       clk->clk.name, to_clk_samsung(clk->clk.parent)->name,
+		       clksrc, clk_get_rate(&clk->clk.clk));
+}
+
+static struct clk_ops clksrc_ops = {
+	.enable		= ps_default_clk_enable,
+	.disable	= ps_default_clk_disable,
+	.get		= ps_default_clk_get,
+	.put		= ps_default_clk_put,
+	.get_parent	= ps_default_clk_get_parent,
+
+	.set_parent	= s3c_setparent_clksrc,
+	.get_rate	= s3c_getrate_clksrc,
+	.set_rate	= s3c_setrate_clksrc,
+	.round_rate	= s3c_roundrate_clksrc,
+};
+
+static struct clk_ops clksrc_ops_nodiv = {
+	.enable		= ps_default_clk_enable,
+	.disable	= ps_default_clk_disable,
+	.get		= ps_default_clk_get,
+	.put		= ps_default_clk_put,
+	.get_rate	= ps_default_clk_get_rate,
+	.round_rate	= ps_default_clk_round_rate,
+	.set_rate	= ps_default_clk_set_rate,
+	.get_parent	= ps_default_clk_get_parent,
+
+	.set_parent	= s3c_setparent_clksrc,
+};
+
+static struct clk_ops clksrc_ops_nosrc = {
+	.enable		= ps_default_clk_enable,
+	.disable	= ps_default_clk_disable,
+	.get		= ps_default_clk_get,
+	.put		= ps_default_clk_put,
+	.get_parent	= ps_default_clk_get_parent,
+	.set_parent	= ps_default_clk_set_parent,
+
+	.get_rate	= s3c_getrate_clksrc,
+	.set_rate	= s3c_setrate_clksrc,
+	.round_rate	= s3c_roundrate_clksrc,
+};
+
+void __init s3c_register_clksrc(struct clksrc_clk *clksrc, int size)
+{
+	int ret;
+
+	for (; size > 0; size--, clksrc++) {
+		if (!clksrc->reg_div.reg && !clksrc->reg_src.reg)
+			printk(KERN_ERR "%s: clock %s has no registers set\n",
+			       __func__, clksrc->clk.name);
+
+		/* fill in the default functions */
+
+		if (!clksrc->clk.clk.ops) {
+			if (!clksrc->reg_div.reg)
+				clksrc->clk.clk.ops = &clksrc_ops_nodiv;
+			else if (!clksrc->reg_src.reg)
+				clksrc->clk.clk.ops = &clksrc_ops_nosrc;
+			else
+				clksrc->clk.clk.ops = &clksrc_ops;
+		}
+
+		/* setup the clocksource, but do not announce it
+		 * as it may be re-set by the setup routines
+		 * called after the rest of the clocks have been
+		 * registered
+		 */
+		s3c_set_clksrc(clksrc, false);
+
+		ret = s3c24xx_register_clock(&clksrc->clk);
+
+		if (ret < 0) {
+			printk(KERN_ERR "%s: failed to register %s (%d)\n",
+			       __func__, clksrc->clk.name, ret);
+		}
+	}
+}
diff --git a/arch/arm/plat-samsung/clock-common-clk.c b/arch/arm/plat-samsung/clock-common-clk.c
new file mode 100644
index 0000000..5940fd5
--- /dev/null
+++ b/arch/arm/plat-samsung/clock-common-clk.c
@@ -0,0 +1,471 @@
+/* linux/arch/arm/plat-s3c24xx/clock.c
+ *
+ * Copyright 2004-2005 Simtec Electronics
+ *	Ben Dooks <ben@simtec.co.uk>
+ *
+ * S3C24XX Core clock control support
+ *
+ * Based on, and code from linux/arch/arm/mach-versatile/clock.c
+ **
+ **  Copyright (C) 2004 ARM Limited.
+ **  Written by Deep Blue Solutions Limited.
+ *
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
+*/
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/errno.h>
+#include <linux/err.h>
+#include <linux/platform_device.h>
+#include <linux/sysdev.h>
+#include <linux/interrupt.h>
+#include <linux/ioport.h>
+#include <linux/clk.h>
+#include <linux/spinlock.h>
+#include <linux/io.h>
+
+#include <mach/hardware.h>
+#include <asm/irq.h>
+
+#include <plat/cpu-freq.h>
+
+#include <plat/clock.h>
+#include <plat/cpu.h>
+
+/* clock information */
+
+static LIST_HEAD(clocks);
+
+/* We originally used an mutex here, but some contexts (see resume)
+ * are calling functions such as clk_set_parent() with IRQs disabled
+ * causing an BUG to be triggered.
+ */
+DEFINE_SPINLOCK(clocks_lock);
+
+/* enable and disable calls for use with the clk struct */
+
+static int clk_null_enable(struct clk_samsung *clk, int enable)
+{
+	return 0;
+}
+
+/* Clock API call: clk_get */
+struct clk *clk_get(struct device *dev, const char *id)
+{
+	struct clk_samsung *p;
+	struct clk *clk = ERR_PTR(-ENOENT);
+	int idno;
+
+	if (dev == NULL || dev->bus != &platform_bus_type)
+		idno = -1;
+	else
+		idno = to_platform_device(dev)->id;
+
+	spin_lock(&clocks_lock);
+
+	list_for_each_entry(p, &clocks, list) {
+		if (p->id == idno &&
+		    strcmp(id, p->name) == 0 &&
+		    try_module_get(p->owner)) {
+			clk = &p->clk;
+			break;
+		}
+	}
+
+	/* check for the case where a device was supplied, but the
+	 * clock that was being searched for is not device specific */
+
+	if (IS_ERR(clk)) {
+		list_for_each_entry(p, &clocks, list) {
+			if (p->id == -1 && strcmp(id, p->name) == 0 &&
+			    try_module_get(p->owner)) {
+				clk = &p->clk;
+				break;
+			}
+		}
+	}
+
+	spin_unlock(&clocks_lock);
+
+	if (!IS_ERR(clk) && !__clk_get(clk))
+		return ERR_PTR(-EINVAL);
+
+	return clk;
+}
+EXPORT_SYMBOL(clk_get);
+
+/* Default ops for struct clk of struct clk_samsung
+ * They are used ONLY if the coressponding entry of struct clk_samsung.clk.ops
+ * is NULL.
+ */
+void ps_default_clk_put(struct clk *_clk)
+{
+	struct clk_samsung *clk;
+
+	if (IS_ERR(_clk) || _clk == NULL)
+		return;
+
+	clk = to_clk_samsung(_clk);
+
+	module_put(clk->owner);
+}
+
+int ps_default_clk_enable(struct clk *_clk)
+{
+	struct clk_samsung *clk;
+	int ret = 0;
+
+	if (IS_ERR(_clk) || _clk == NULL)
+		return -EINVAL;
+
+	clk = to_clk_samsung(_clk);
+
+	if (clk->parent)
+		clk_enable(clk->parent);
+
+	spin_lock(&clocks_lock);
+
+	if (clk->enable)
+		ret = clk->enable(clk, 1);
+
+	spin_unlock(&clocks_lock);
+
+	return ret;
+}
+
+void ps_default_clk_disable(struct clk *_clk)
+{
+	struct clk_samsung *clk;
+
+	if (IS_ERR(_clk) || _clk == NULL)
+		return;
+
+	clk = to_clk_samsung(_clk);
+
+	spin_lock(&clocks_lock);
+
+	if (clk->enable)
+		clk->enable(clk, 0);
+
+	spin_unlock(&clocks_lock);
+
+	if (clk->parent)
+		clk_disable(clk->parent);
+}
+
+unsigned long ps_default_clk_get_rate(struct clk *_clk)
+{
+	struct clk_samsung *clk;
+
+	if (IS_ERR(_clk) || _clk == NULL)
+		return 0;
+
+	clk = to_clk_samsung(_clk);
+
+	if (clk->rate != 0)
+		return clk->rate;
+
+	if (clk->parent != NULL)
+		return clk_get_rate(clk->parent);
+
+	return clk->rate;
+}
+
+long ps_default_clk_round_rate(struct clk *clk, unsigned long rate)
+{
+	return -ENOSYS; /* "Not Implemented" */
+}
+
+int ps_default_clk_set_rate(struct clk *clk, unsigned long rate)
+{
+	return -ENOSYS; /* "Not Implemented" */
+}
+
+struct clk *ps_default_clk_get_parent(struct clk *_clk)
+{
+	struct clk_samsung *clk;
+
+	if (IS_ERR(_clk) || _clk == NULL)
+		return ERR_PTR(-EINVAL);
+
+	clk = to_clk_samsung(_clk);
+
+	return clk->parent;
+}
+
+int ps_default_clk_set_parent(struct clk *clk, struct clk *parent)
+{
+	return -ENOSYS; /* "Not Implemented" */
+}
+
+int ps_default_clk_get(struct clk *clk)
+{
+	return 1;
+}
+
+static struct clk_ops ps_default_ops = {
+	.enable		= ps_default_clk_enable,
+	.disable	= ps_default_clk_disable,
+	.get		= ps_default_clk_get,
+	.put		= ps_default_clk_put,
+	.get_rate	= ps_default_clk_get_rate,
+	.round_rate	= ps_default_clk_round_rate,
+	.set_rate	= ps_default_clk_set_rate,
+	.set_parent	= ps_default_clk_set_parent,
+	.get_parent	= ps_default_clk_get_parent,
+};
+
+
+/* base clocks */
+
+int clk_default_setrate(struct clk *_clk, unsigned long rate)
+{
+	struct clk_samsung *clk = to_clk_samsung(_clk);
+	clk->rate = rate;
+	return 0;
+}
+
+struct clk_ops clk_ops_def_setrate = {
+	.enable		= ps_default_clk_enable,
+	.disable	= ps_default_clk_disable,
+	.get		= ps_default_clk_get,
+	.put		= ps_default_clk_put,
+	.get_rate	= ps_default_clk_get_rate,
+	.round_rate	= ps_default_clk_round_rate,
+	.set_parent	= ps_default_clk_set_parent,
+	.get_parent	= ps_default_clk_get_parent,
+
+	.set_rate	= clk_default_setrate,
+};
+
+struct clk_samsung clk_xtal = {
+	.name		= "xtal",
+	.id		= -1,
+	.rate		= 0,
+	.parent		= NULL,
+	.ctrlbit	= 0,
+};
+
+struct clk_samsung clk_ext = {
+	.name		= "ext",
+	.id		= -1,
+};
+
+struct clk_samsung clk_epll = {
+	.name		= "epll",
+	.id		= -1,
+};
+
+struct clk_samsung clk_mpll = {
+	.clk		= {
+		.ops		= &clk_ops_def_setrate,
+	},
+	.name		= "mpll",
+	.id		= -1,
+};
+
+struct clk_samsung clk_upll = {
+	.name		= "upll",
+	.id		= -1,
+	.parent		= NULL,
+	.ctrlbit	= 0,
+};
+
+struct clk_samsung clk_f = {
+	.name		= "fclk",
+	.id		= -1,
+	.rate		= 0,
+	.parent		= &clk_mpll.clk,
+	.ctrlbit	= 0,
+};
+
+struct clk_samsung clk_h = {
+	.clk		= {
+		.ops		= &clk_ops_def_setrate,
+	},
+	.name		= "hclk",
+	.id		= -1,
+	.rate		= 0,
+	.parent		= NULL,
+	.ctrlbit	= 0,
+};
+
+struct clk_samsung clk_p = {
+	.clk		= {
+		.ops		= &clk_ops_def_setrate,
+	},
+	.name		= "pclk",
+	.id		= -1,
+	.rate		= 0,
+	.parent		= NULL,
+	.ctrlbit	= 0,
+};
+
+struct clk_samsung clk_usb_bus = {
+	.name		= "usb-bus",
+	.id		= -1,
+	.rate		= 0,
+	.parent		= &clk_upll.clk,
+};
+
+
+struct clk_samsung s3c24xx_uclk = {
+	.name		= "uclk",
+	.id		= -1,
+};
+
+/* initialise the clock system */
+
+/**
+ * s3c24xx_register_clock() - register a clock
+ * @clk: The clock to register
+ *
+ * Add the specified clock to the list of clocks known by the system.
+ */
+int s3c24xx_register_clock(struct clk_samsung *clk)
+{
+	if (clk->enable == NULL)
+		clk->enable = clk_null_enable;
+
+	/* add to the list of available clocks */
+
+	/* Quick check to see if this clock has already been registered. */
+	BUG_ON(clk->list.prev != clk->list.next);
+
+	spin_lock(&clocks_lock);
+	list_add(&clk->list, &clocks);
+
+	mutex_init(&clk->clk.mutex);
+	clk->clk.enable_count = 0;
+
+	if (!clk->clk.ops) {
+		clk->clk.ops = &ps_default_ops;
+	} else {
+		/* Check if the list is full! */
+
+		WARN_ON(!clk->clk.ops->enable);
+		WARN_ON(!clk->clk.ops->disable);
+		WARN_ON(!clk->clk.ops->get);
+		WARN_ON(!clk->clk.ops->put);
+		WARN_ON(!clk->clk.ops->get_rate);
+		WARN_ON(!clk->clk.ops->set_rate);
+		WARN_ON(!clk->clk.ops->round_rate);
+		WARN_ON(!clk->clk.ops->get_parent);
+		WARN_ON(!clk->clk.ops->set_parent);
+	}
+
+	spin_unlock(&clocks_lock);
+
+	return 0;
+}
+
+/**
+ * s3c24xx_register_clocks() - register an array of clock pointers
+ * @clks: Pointer to an array of struct clk pointers
+ * @nr_clks: The number of clocks in the @clks array.
+ *
+ * Call s3c24xx_register_clock() for all the clock pointers contained
+ * in the @clks list. Returns the number of failures.
+ */
+int s3c24xx_register_clocks(struct clk_samsung **clks, int nr_clks)
+{
+	int fails = 0;
+
+	for (; nr_clks > 0; nr_clks--, clks++) {
+		if (s3c24xx_register_clock(*clks) < 0) {
+			struct clk_samsung *clk = *clks;
+			printk(KERN_ERR "%s: failed to register %p: %s\n",
+			       __func__, clk, clk->name);
+			fails++;
+		}
+	}
+
+	return fails;
+}
+
+/**
+ * s3c_register_clocks() - register an array of clocks
+ * @clkp: Pointer to the first clock in the array.
+ * @nr_clks: Number of clocks to register.
+ *
+ * Call s3c24xx_register_clock() on the @clkp array given, printing an
+ * error if it fails to register the clock (unlikely).
+ */
+void __init s3c_register_clocks(struct clk_samsung *clkp, int nr_clks)
+{
+	int ret;
+
+	for (; nr_clks > 0; nr_clks--, clkp++) {
+		ret = s3c24xx_register_clock(clkp);
+
+		if (ret < 0) {
+			printk(KERN_ERR "Failed to register clock %s (%d)\n",
+			       clkp->name, ret);
+		} else
+			printk(KERN_INFO "Registering %s:%d (%d)\n",
+					clkp->name, clkp->id, ret);
+	}
+}
+
+/**
+ * s3c_disable_clocks() - disable an array of clocks
+ * @clkp: Pointer to the first clock in the array.
+ * @nr_clks: Number of clocks to register.
+ *
+ * for internal use only at initialisation time. disable the clocks in the
+ * @clkp array.
+ */
+
+void __init s3c_disable_clocks(struct clk_samsung *clkp, int nr_clks)
+{
+	for (; nr_clks > 0; nr_clks--, clkp++)
+		(clkp->enable)(clkp, 0);
+}
+
+/* initalise all the clocks */
+
+int __init s3c24xx_register_baseclocks(unsigned long xtal)
+{
+	printk(KERN_INFO "S3C24XX Clocks, Copyright 2004 Simtec Electronics\n");
+
+	clk_xtal.rate = xtal;
+
+	/* register our clocks */
+
+	if (s3c24xx_register_clock(&clk_xtal) < 0)
+		printk(KERN_ERR "failed to register master xtal\n");
+
+	if (s3c24xx_register_clock(&clk_mpll) < 0)
+		printk(KERN_ERR "failed to register mpll clock\n");
+
+	if (s3c24xx_register_clock(&clk_upll) < 0)
+		printk(KERN_ERR "failed to register upll clock\n");
+
+	if (s3c24xx_register_clock(&clk_f) < 0)
+		printk(KERN_ERR "failed to register cpu fclk\n");
+
+	if (s3c24xx_register_clock(&clk_h) < 0)
+		printk(KERN_ERR "failed to register cpu hclk\n");
+
+	if (s3c24xx_register_clock(&clk_p) < 0)
+		printk(KERN_ERR "failed to register cpu pclk\n");
+
+	return 0;
+}
+
diff --git a/arch/arm/plat-samsung/include/plat/clock-clksrc.h b/arch/arm/plat-samsung/include/plat/clock-clksrc.h
index 50a8ca7..e4cc3ef 100644
--- a/arch/arm/plat-samsung/include/plat/clock-clksrc.h
+++ b/arch/arm/plat-samsung/include/plat/clock-clksrc.h
@@ -21,7 +21,11 @@
  */
 struct clksrc_sources {
 	unsigned int	nr_sources;
+#ifdef CONFIG_USE_COMMON_STRUCT_CLK
+	struct clk_samsung	**sources;
+#else
 	struct clk	**sources;
+#endif
 };
 
 /**
@@ -56,7 +60,11 @@ struct clksrc_reg {
  * the output.
  */
 struct clksrc_clk {
+#ifdef CONFIG_USE_COMMON_STRUCT_CLK
+	struct clk_samsung	clk;
+#else /* !CONFIG_USE_COMMON_STRUCT_CLK */
 	struct clk		clk;
+#endif /* !CONFIG_USE_COMMON_STRUCT_CLK */
 	struct clksrc_sources	*sources;
 
 	struct clksrc_reg	reg_src;
diff --git a/arch/arm/plat-samsung/include/plat/clock.h b/arch/arm/plat-samsung/include/plat/clock.h
index 0fbcd0e..cdb6bbf 100644
--- a/arch/arm/plat-samsung/include/plat/clock.h
+++ b/arch/arm/plat-samsung/include/plat/clock.h
@@ -11,6 +11,36 @@
 
 #include <linux/spinlock.h>
 
+#ifdef CONFIG_USE_COMMON_STRUCT_CLK
+#include <linux/clk.h>
+
+struct clk_samsung {
+	struct clk		clk;
+
+	struct list_head	list;
+	struct module		*owner;
+	struct clk		*parent;
+	const char		*name;
+	int			id;
+	unsigned long		rate;
+	unsigned long		ctrlbit;
+	int			(*enable)(struct clk_samsung *, int enable);
+};
+
+#define to_clk_samsung(x)		\
+	(container_of(x, struct clk_samsung, clk))
+
+extern int ps_default_clk_enable (struct clk *);
+extern void ps_default_clk_disable (struct clk *);
+extern int ps_default_clk_get (struct clk *);
+extern void ps_default_clk_put (struct clk *);
+extern unsigned long ps_default_clk_get_rate (struct clk *);
+extern long ps_default_clk_round_rate (struct clk *, unsigned long);
+extern int ps_default_clk_set_rate (struct clk *, unsigned long);
+extern int ps_default_clk_set_parent (struct clk *, struct clk *);
+extern struct clk *ps_default_clk_get_parent (struct clk *);
+
+#else /* !CONFIG_USE_COMMON_STRUCT_CLK */
 struct clk;
 
 /**
@@ -48,9 +78,36 @@ struct clk {
 	struct clk_ops		*ops;
 	int		    (*enable)(struct clk *, int enable);
 };
+#endif /* !CONFIG_USE_COMMON_STRUCT_CLK */
 
 /* other clocks which may be registered by board support */
 
+#ifdef CONFIG_USE_COMMON_STRUCT_CLK
+extern struct clk_samsung s3c24xx_dclk0;
+extern struct clk_samsung s3c24xx_dclk1;
+extern struct clk_samsung s3c24xx_clkout0;
+extern struct clk_samsung s3c24xx_clkout1;
+extern struct clk_samsung s3c24xx_uclk;
+
+extern struct clk_samsung clk_usb_bus;
+
+/* core clock support */
+
+extern struct clk_samsung clk_f;
+extern struct clk_samsung clk_h;
+extern struct clk_samsung clk_p;
+extern struct clk_samsung clk_mpll;
+extern struct clk_samsung clk_upll;
+extern struct clk_samsung clk_epll;
+extern struct clk_samsung clk_xtal;
+extern struct clk_samsung clk_ext;
+
+/* S3C64XX specific clocks */
+extern struct clk_samsung clk_h2;
+extern struct clk_samsung clk_27m;
+extern struct clk_samsung clk_48m;
+extern struct clk_samsung clk_xusbxti;
+#else /* !CONFIG_USE_COMMON_STRUCT_CLK */
 extern struct clk s3c24xx_dclk0;
 extern struct clk s3c24xx_dclk1;
 extern struct clk s3c24xx_clkout0;
@@ -75,6 +132,7 @@ extern struct clk clk_h2;
 extern struct clk clk_27m;
 extern struct clk clk_48m;
 extern struct clk clk_xusbxti;
+#endif /* !CONFIG_USE_COMMON_STRUCT_CLK */
 
 extern int clk_default_setrate(struct clk *clk, unsigned long rate);
 extern struct clk_ops clk_ops_def_setrate;
@@ -86,6 +144,15 @@ extern struct clk_ops clk_ops_def_setrate;
 
 extern spinlock_t clocks_lock;
 
+#ifdef CONFIG_USE_COMMON_STRUCT_CLK
+extern int s3c2410_clkcon_enable(struct clk_samsung *clk, int enable);
+
+extern int s3c24xx_register_clock(struct clk_samsung *clk);
+extern int s3c24xx_register_clocks(struct clk_samsung **clk, int nr_clks);
+
+extern void s3c_register_clocks(struct clk_samsung *clk, int nr_clks);
+extern void s3c_disable_clocks(struct clk_samsung *clkp, int nr_clks);
+#else
 extern int s3c2410_clkcon_enable(struct clk *clk, int enable);
 
 extern int s3c24xx_register_clock(struct clk *clk);
@@ -93,6 +160,7 @@ extern int s3c24xx_register_clocks(struct clk **clk, int nr_clks);
 
 extern void s3c_register_clocks(struct clk *clk, int nr_clks);
 extern void s3c_disable_clocks(struct clk *clkp, int nr_clks);
+#endif
 
 extern int s3c24xx_register_baseclocks(unsigned long xtal);
 
diff --git a/arch/arm/plat-samsung/pwm-clock-common-clk.c b/arch/arm/plat-samsung/pwm-clock-common-clk.c
new file mode 100644
index 0000000..f784c82
--- /dev/null
+++ b/arch/arm/plat-samsung/pwm-clock-common-clk.c
@@ -0,0 +1,499 @@
+/* linux/arch/arm/plat-s3c24xx/pwm-clock.c
+ *
+ * Copyright (c) 2007 Simtec Electronics
+ * Copyright (c) 2007, 2008 Ben Dooks
+ *	Ben Dooks <ben-linux@fluff.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License.
+*/
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/errno.h>
+#include <linux/log2.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/io.h>
+
+#include <mach/hardware.h>
+#include <mach/map.h>
+#include <asm/irq.h>
+
+#include <plat/clock.h>
+#include <plat/cpu.h>
+
+#include <plat/regs-timer.h>
+#include <mach/pwm-clock.h>
+
+/* Each of the timers 0 through 5 go through the following
+ * clock tree, with the inputs depending on the timers.
+ *
+ * pclk ---- [ prescaler 0 ] -+---> timer 0
+ *			      +---> timer 1
+ *
+ * pclk ---- [ prescaler 1 ] -+---> timer 2
+ *			      +---> timer 3
+ *			      \---> timer 4
+ *
+ * Which are fed into the timers as so:
+ *
+ * prescaled 0 ---- [ div 2,4,8,16 ] ---\
+ *				       [mux] -> timer 0
+ * tclk 0 ------------------------------/
+ *
+ * prescaled 0 ---- [ div 2,4,8,16 ] ---\
+ *				       [mux] -> timer 1
+ * tclk 0 ------------------------------/
+ *
+ *
+ * prescaled 1 ---- [ div 2,4,8,16 ] ---\
+ *				       [mux] -> timer 2
+ * tclk 1 ------------------------------/
+ *
+ * prescaled 1 ---- [ div 2,4,8,16 ] ---\
+ *				       [mux] -> timer 3
+ * tclk 1 ------------------------------/
+ *
+ * prescaled 1 ---- [ div 2,4,8, 16 ] --\
+ *				       [mux] -> timer 4
+ * tclk 1 ------------------------------/
+ *
+ * Since the mux and the divider are tied together in the
+ * same register space, it is impossible to set the parent
+ * and the rate at the same time. To avoid this, we add an
+ * intermediate 'prescaled-and-divided' clock to select
+ * as the parent for the timer input clock called tdiv.
+ *
+ * prescaled clk --> pwm-tdiv ---\
+ *                             [ mux ] --> timer X
+ * tclk -------------------------/
+*/
+
+static struct clk_samsung clk_timer_scaler[];
+
+static unsigned long clk_pwm_scaler_get_rate(struct clk *clk)
+{
+	unsigned long tcfg0 = __raw_readl(S3C2410_TCFG0);
+
+	if (clk == &clk_timer_scaler[1].clk) {
+		tcfg0 &= S3C2410_TCFG_PRESCALER1_MASK;
+		tcfg0 >>= S3C2410_TCFG_PRESCALER1_SHIFT;
+	} else {
+		tcfg0 &= S3C2410_TCFG_PRESCALER0_MASK;
+	}
+
+	return clk_get_rate(clk_get_parent(clk)) / (tcfg0 + 1);
+}
+
+static long clk_pwm_scaler_round_rate(struct clk *clk,
+					       unsigned long rate)
+{
+	unsigned long parent_rate = clk_get_rate(clk_get_parent(clk));
+	unsigned long divisor = parent_rate / rate;
+
+	if (divisor > 256)
+		divisor = 256;
+	else if (divisor < 2)
+		divisor = 2;
+
+	return parent_rate / divisor;
+}
+
+static int clk_pwm_scaler_set_rate(struct clk *clk, unsigned long rate)
+{
+	unsigned long round = clk_pwm_scaler_round_rate(clk, rate);
+	unsigned long tcfg0;
+	unsigned long divisor;
+	unsigned long flags;
+
+	divisor = clk_get_rate(clk_get_parent(clk)) / round;
+	divisor--;
+
+	local_irq_save(flags);
+	tcfg0 = __raw_readl(S3C2410_TCFG0);
+
+	if (clk == &clk_timer_scaler[1].clk) {
+		tcfg0 &= ~S3C2410_TCFG_PRESCALER1_MASK;
+		tcfg0 |= divisor << S3C2410_TCFG_PRESCALER1_SHIFT;
+	} else {
+		tcfg0 &= ~S3C2410_TCFG_PRESCALER0_MASK;
+		tcfg0 |= divisor;
+	}
+
+	__raw_writel(tcfg0, S3C2410_TCFG0);
+	local_irq_restore(flags);
+
+	return 0;
+}
+
+static struct clk_ops clk_pwm_scaler_ops = {
+	.enable         = ps_default_clk_enable,
+	.disable        = ps_default_clk_disable,
+	.get            = ps_default_clk_get,
+	.put            = ps_default_clk_put,
+	.set_parent     = ps_default_clk_set_parent,
+	.get_parent     = ps_default_clk_get_parent,
+
+	.get_rate	= clk_pwm_scaler_get_rate,
+	.set_rate	= clk_pwm_scaler_set_rate,
+	.round_rate	= clk_pwm_scaler_round_rate,
+};
+
+static struct clk_samsung clk_timer_scaler[] = {
+	[0]	= {
+		.clk		= {
+			.ops		= &clk_pwm_scaler_ops,
+		},
+		.name		= "pwm-scaler0",
+		.id		= -1,
+	},
+	[1]	= {
+		.clk		= {
+			.ops		= &clk_pwm_scaler_ops,
+		},
+		.name		= "pwm-scaler1",
+		.id		= -1,
+	},
+};
+
+static struct clk_samsung clk_timer_tclk[] = {
+	[0]	= {
+		.name		= "pwm-tclk0",
+		.id		= -1,
+	},
+	[1]	= {
+		.name		= "pwm-tclk1",
+		.id		= -1,
+	},
+};
+
+struct pwm_tdiv_clk {
+	struct clk_samsung	clk;
+	unsigned int	divisor;
+};
+
+static inline struct pwm_tdiv_clk *to_tdiv(struct clk_samsung *clk)
+{
+	return container_of(clk, struct pwm_tdiv_clk, clk);
+}
+
+static unsigned long clk_pwm_tdiv_get_rate(struct clk *clk)
+{
+	unsigned long tcfg1 = __raw_readl(S3C2410_TCFG1);
+	unsigned int divisor;
+	struct clk_samsung *clk_s = to_clk_samsung(clk);
+
+	tcfg1 >>= S3C2410_TCFG1_SHIFT(clk_s->id);
+	tcfg1 &= S3C2410_TCFG1_MUX_MASK;
+
+	if (pwm_cfg_src_is_tclk(tcfg1))
+		divisor = to_tdiv(clk_s)->divisor;
+	else
+		divisor = tcfg_to_divisor(tcfg1);
+
+	return clk_get_rate(clk_get_parent(clk)) / divisor;
+}
+
+static long clk_pwm_tdiv_round_rate(struct clk *clk,
+					     unsigned long rate)
+{
+	unsigned long parent_rate;
+	unsigned long divisor;
+
+	parent_rate = clk_get_rate(clk_get_parent(clk));
+	divisor = parent_rate / rate;
+
+	if (divisor <= 1 && pwm_tdiv_has_div1())
+		divisor = 1;
+	else if (divisor <= 2)
+		divisor = 2;
+	else if (divisor <= 4)
+		divisor = 4;
+	else if (divisor <= 8)
+		divisor = 8;
+	else
+		divisor = 16;
+
+	return parent_rate / divisor;
+}
+
+static unsigned long clk_pwm_tdiv_bits(struct pwm_tdiv_clk *divclk)
+{
+	return pwm_tdiv_div_bits(divclk->divisor);
+}
+
+static void clk_pwm_tdiv_update(struct pwm_tdiv_clk *divclk)
+{
+	unsigned long tcfg1 = __raw_readl(S3C2410_TCFG1);
+	unsigned long bits = clk_pwm_tdiv_bits(divclk);
+	unsigned long flags;
+	unsigned long shift =  S3C2410_TCFG1_SHIFT(divclk->clk.id);
+
+	local_irq_save(flags);
+
+	tcfg1 = __raw_readl(S3C2410_TCFG1);
+	tcfg1 &= ~(S3C2410_TCFG1_MUX_MASK << shift);
+	tcfg1 |= bits << shift;
+	__raw_writel(tcfg1, S3C2410_TCFG1);
+
+	local_irq_restore(flags);
+}
+
+static int clk_pwm_tdiv_set_rate(struct clk *clk, unsigned long rate)
+{
+	struct pwm_tdiv_clk *divclk;
+	unsigned long tcfg1 = __raw_readl(S3C2410_TCFG1);
+	unsigned long parent_rate = clk_get_rate(clk_get_parent(clk));
+	unsigned long divisor;
+	struct clk_samsung *clk_s = to_clk_samsung(clk);
+
+	divclk = to_tdiv(clk_s);
+
+	tcfg1 >>= S3C2410_TCFG1_SHIFT(clk_s->id);
+	tcfg1 &= S3C2410_TCFG1_MUX_MASK;
+
+	rate = clk_round_rate(clk, rate);
+	divisor = parent_rate / rate;
+
+	if (divisor > 16)
+		return -EINVAL;
+
+	divclk->divisor = divisor;
+
+	/* Update the current MUX settings if we are currently
+	 * selected as the clock source for this clock. */
+
+	if (!pwm_cfg_src_is_tclk(tcfg1))
+		clk_pwm_tdiv_update(divclk);
+
+	return 0;
+}
+
+static struct clk_ops clk_tdiv_ops = {
+	.enable         = ps_default_clk_enable,
+	.disable        = ps_default_clk_disable,
+	.get            = ps_default_clk_get,
+	.put            = ps_default_clk_put,
+	.set_parent     = ps_default_clk_set_parent,
+	.get_parent     = ps_default_clk_get_parent,
+
+	.get_rate	= clk_pwm_tdiv_get_rate,
+	.set_rate	= clk_pwm_tdiv_set_rate,
+	.round_rate	= clk_pwm_tdiv_round_rate,
+};
+
+static struct pwm_tdiv_clk clk_timer_tdiv[] = {
+	[0]	= {
+		.clk	= {
+			.clk	= {
+				.ops	= &clk_tdiv_ops,
+			},
+			.name	= "pwm-tdiv",
+			.parent	= &clk_timer_scaler[0].clk,
+		},
+	},
+	[1]	= {
+		.clk	= {
+			.clk	= {
+				.ops	= &clk_tdiv_ops,
+			},
+			.name	= "pwm-tdiv",
+			.parent	= &clk_timer_scaler[0].clk,
+		}
+	},
+	[2]	= {
+		.clk	= {
+			.clk	= {
+				.ops	= &clk_tdiv_ops,
+			},
+			.name	= "pwm-tdiv",
+			.parent	= &clk_timer_scaler[1].clk,
+		},
+	},
+	[3]	= {
+		.clk	= {
+			.clk	= {
+				.ops	= &clk_tdiv_ops,
+			},
+			.name	= "pwm-tdiv",
+			.parent	= &clk_timer_scaler[1].clk,
+		},
+	},
+	[4]	= {
+		.clk	= {
+			.clk	= {
+				.ops	= &clk_tdiv_ops,
+			},
+			.name	= "pwm-tdiv",
+			.parent	= &clk_timer_scaler[1].clk,
+		},
+	},
+};
+
+static int __init clk_pwm_tdiv_register(unsigned int id)
+{
+	struct pwm_tdiv_clk *divclk = &clk_timer_tdiv[id];
+	unsigned long tcfg1 = __raw_readl(S3C2410_TCFG1);
+
+	tcfg1 >>= S3C2410_TCFG1_SHIFT(id);
+	tcfg1 &= S3C2410_TCFG1_MUX_MASK;
+
+	divclk->clk.id = id;
+	divclk->divisor = tcfg_to_divisor(tcfg1);
+
+	return s3c24xx_register_clock(&divclk->clk);
+}
+
+static inline struct clk *s3c24xx_pwmclk_tclk(unsigned int id)
+{
+	return (id >= 2) ? &clk_timer_tclk[1].clk : &clk_timer_tclk[0].clk;
+}
+
+static inline struct clk *s3c24xx_pwmclk_tdiv(unsigned int id)
+{
+	return &clk_timer_tdiv[id].clk.clk;
+}
+
+static int clk_pwm_tin_set_parent(struct clk *_clk, struct clk *parent)
+{
+	struct clk_samsung *clk = to_clk_samsung(_clk);
+	unsigned int id = clk->id;
+	unsigned long tcfg1;
+	unsigned long flags;
+	unsigned long bits;
+	unsigned long shift = S3C2410_TCFG1_SHIFT(id);
+
+	if (parent == s3c24xx_pwmclk_tclk(id))
+		bits = S3C_TCFG1_MUX_TCLK << shift;
+	else if (parent == s3c24xx_pwmclk_tdiv(id))
+		bits = clk_pwm_tdiv_bits(to_tdiv(to_clk_samsung(parent)))
+			<< shift;
+	else
+		return -EINVAL;
+
+	clk->parent = parent;
+
+	local_irq_save(flags);
+
+	tcfg1 = __raw_readl(S3C2410_TCFG1);
+	tcfg1 &= ~(S3C2410_TCFG1_MUX_MASK << shift);
+	__raw_writel(tcfg1 | bits, S3C2410_TCFG1);
+
+	local_irq_restore(flags);
+
+	return 0;
+}
+
+static struct clk_ops clk_tin_ops = {
+	.enable = ps_default_clk_enable,
+	.disable = ps_default_clk_disable,
+	.get = ps_default_clk_get,
+	.put = ps_default_clk_put,
+	.get_rate = ps_default_clk_get_rate,
+	.round_rate = ps_default_clk_round_rate,
+	.set_rate = ps_default_clk_set_rate,
+	.get_parent = ps_default_clk_get_parent,
+
+	.set_parent	= clk_pwm_tin_set_parent,
+};
+
+static struct clk_samsung clk_tin[] = {
+	[0]	= {
+		.name	= "pwm-tin",
+		.id	= 0,
+		.clk	= INIT_CLK(clk_tin_ops),
+	},
+	[1]	= {
+		.name	= "pwm-tin",
+		.id	= 1,
+		.clk	= INIT_CLK(clk_tin_ops),
+	},
+	[2]	= {
+		.name	= "pwm-tin",
+		.id	= 2,
+		.clk	= INIT_CLK(clk_tin_ops),
+	},
+	[3]	= {
+		.name	= "pwm-tin",
+		.id	= 3,
+		.clk	= INIT_CLK(clk_tin_ops),
+	},
+	[4]	= {
+		.name	= "pwm-tin",
+		.id	= 4,
+		.clk	= INIT_CLK(clk_tin_ops),
+	},
+};
+
+static __init int clk_pwm_tin_register(struct clk *pwm)
+{
+	struct clk_samsung *cs_pwm = to_clk_samsung(pwm);
+	unsigned long tcfg1 = __raw_readl(S3C2410_TCFG1);
+	unsigned int id = cs_pwm->id;
+
+	struct clk *parent;
+	int ret;
+
+	ret = s3c24xx_register_clock(cs_pwm);
+	if (ret < 0)
+		return ret;
+
+	tcfg1 >>= S3C2410_TCFG1_SHIFT(id);
+	tcfg1 &= S3C2410_TCFG1_MUX_MASK;
+
+	if (pwm_cfg_src_is_tclk(tcfg1))
+		parent = s3c24xx_pwmclk_tclk(id);
+	else
+		parent = s3c24xx_pwmclk_tdiv(id);
+
+	return clk_set_parent(pwm, parent);
+}
+
+/**
+ * s3c_pwmclk_init() - initialise pwm clocks
+ *
+ * Initialise and register the clocks which provide the inputs for the
+ * pwm timer blocks.
+ *
+ * Note, this call is required by the time core, so must be called after
+ * the base clocks are added and before any of the initcalls are run.
+ */
+__init void s3c_pwmclk_init(void)
+{
+	struct clk *clk_timers;
+	unsigned int clk;
+	int ret;
+
+	clk_timers = clk_get(NULL, "timers");
+	if (IS_ERR(clk_timers)) {
+		printk(KERN_ERR "%s: no parent clock\n", __func__);
+		return;
+	}
+
+	for (clk = 0; clk < ARRAY_SIZE(clk_timer_scaler); clk++)
+		clk_timer_scaler[clk].parent = clk_timers;
+
+	s3c_register_clocks(clk_timer_scaler, ARRAY_SIZE(clk_timer_scaler));
+	s3c_register_clocks(clk_timer_tclk, ARRAY_SIZE(clk_timer_tclk));
+
+	for (clk = 0; clk < ARRAY_SIZE(clk_timer_tdiv); clk++) {
+		ret = clk_pwm_tdiv_register(clk);
+
+		if (ret < 0) {
+			printk(KERN_ERR "error adding pwm%d tdiv clock\n", clk);
+			return;
+		}
+	}
+
+	for (clk = 0; clk < ARRAY_SIZE(clk_tin); clk++) {
+		ret = clk_pwm_tin_register(&clk_tin[clk].clk);
+		if (ret < 0) {
+			printk(KERN_ERR "error adding pwm%d tin clock\n", clk);
+			return;
+		}
+	}
+}
-- 
1.6.3.3
