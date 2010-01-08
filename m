From: ben-linux@fluff.org (Ben Dooks)
Date: Fri,  8 Jan 2010 02:30:13 +0000
Subject: [S3C-CLK] ARM: SAMSUNG: Add core clock implementation for clksrc
	based clocks
In-Reply-To: <1262917822-26004-1-git-send-email-ben-linux@fluff.org>
References: <1262917822-26004-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1262917822-26004-6-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Harald Welte <laforge@gnumonks.org>

Add a core for the clksrc clock implementation, which is found in many of
the newer Samsung SoCs into plat-samsung.

Signed-off-by: Harald Welte <laforge@gnumonks.org>
[ben-linux at fluff.org: split from original patch to make change smaller]
[ben-linux at fluff.org: split clk and clksrc changes]
[ben-linux at fluff.org: moved to plat-samsung from plat-s3c]
[ben-linux at fluff.org: re-wrote headers after splits]
[ben-linux at fluff.org: added better documentation to headers]
Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/plat-samsung/Kconfig                     |    5 +
 arch/arm/plat-samsung/Makefile                    |    1 +
 arch/arm/plat-samsung/clock-clksrc.c              |  177 +++++++++++++++++++++
 arch/arm/plat-samsung/include/plat/clock-clksrc.h |   75 +++++++++
 4 files changed, 258 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-samsung/clock-clksrc.c
 create mode 100644 arch/arm/plat-samsung/include/plat/clock-clksrc.h

diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index 486a0d6..e3ae684 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -13,5 +13,10 @@ config PLAT_SAMSUNG
 
 if PLAT_SAMSUNG
 
+config SAMSUNG_CLKSRC
+	bool
+	help
+	  Select the clock code for the clksrc implementation
+	  used by newer systems such as the S3C64XX.
 
 endif
diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
index 4478b9f..ce736ce 100644
--- a/arch/arm/plat-samsung/Makefile
+++ b/arch/arm/plat-samsung/Makefile
@@ -9,3 +9,4 @@ obj-m				:=
 obj-n				:= dummy.o
 obj-				:=
 
+obj-$(CONFIG_SAMSUNG_CLKSRC)	+= clock-clksrc.o
diff --git a/arch/arm/plat-samsung/clock-clksrc.c b/arch/arm/plat-samsung/clock-clksrc.c
new file mode 100644
index 0000000..5872f0b
--- /dev/null
+++ b/arch/arm/plat-samsung/clock-clksrc.c
@@ -0,0 +1,177 @@
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
+static inline struct clksrc_clk *to_clksrc(struct clk *clk)
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
+static unsigned long s3c_getrate_clksrc(struct clk *clk)
+{
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
+static int s3c_setrate_clksrc(struct clk *clk, unsigned long rate)
+{
+	struct clksrc_clk *sclk = to_clksrc(clk);
+	void __iomem *reg = sclk->reg_div.reg;
+	unsigned int div;
+	u32 mask = bit_mask(sclk->reg_div.shift, sclk->reg_div.size);
+	u32 val;
+
+	rate = clk_round_rate(clk, rate);
+	div = clk_get_rate(clk->parent) / rate;
+	if (div > 16)
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
+static int s3c_setparent_clksrc(struct clk *clk, struct clk *parent)
+{
+	struct clksrc_clk *sclk = to_clksrc(clk);
+	struct clksrc_sources *srcs = sclk->sources;
+	u32 clksrc = __raw_readl(sclk->reg_src.reg);
+	u32 mask = bit_mask(sclk->reg_src.shift, sclk->reg_src.size);
+	int src_nr = -1;
+	int ptr;
+
+	for (ptr = 0; ptr < srcs->nr_sources; ptr++)
+		if (srcs->sources[ptr] == parent) {
+			src_nr = ptr;
+			break;
+		}
+
+	if (src_nr >= 0 && sclk->reg_src.reg) {
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
+static unsigned long s3c_roundrate_clksrc(struct clk *clk,
+					      unsigned long rate)
+{
+	unsigned long parent_rate = clk_get_rate(clk->parent);
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
+		if (div > 16)
+			div = 16;
+
+		rate = parent_rate / div;
+	}
+
+	return rate;
+}
+
+/* Clock initialisation code */
+
+void __init_or_cpufreq s3c_set_clksrc(struct clksrc_clk *clk)
+{
+	struct clksrc_sources *srcs = clk->sources;
+	u32 mask = bit_mask(clk->reg_src.shift, clk->reg_src.size);
+	u32 clksrc = 0;
+
+	if (clk->reg_src.reg)
+		clksrc = __raw_readl(clk->reg_src.reg);
+
+	clksrc &= mask;
+	clksrc >>= clk->reg_src.shift;
+
+	if (clksrc > srcs->nr_sources || !srcs->sources[clksrc]) {
+		printk(KERN_ERR "%s: bad source %d\n",
+		       clk->clk.name, clksrc);
+		return;
+	}
+
+	clk->clk.parent = srcs->sources[clksrc];
+
+	printk(KERN_INFO "%s: source is %s (%d), rate is %ld\n",
+	       clk->clk.name, clk->clk.parent->name, clksrc,
+	       clk_get_rate(&clk->clk));
+}
+
+void __init s3c_register_clksrc(struct clksrc_clk *clksrc, int size)
+{
+	int ret;
+
+	for (; size > 0; size--, clksrc++) {
+		/* fill in the default functions */
+		if (!clksrc->clk.set_parent)
+			clksrc->clk.set_parent = s3c_setparent_clksrc;
+		if (!clksrc->clk.get_rate)
+			clksrc->clk.get_rate = s3c_getrate_clksrc;
+		if (!clksrc->clk.set_rate)
+			clksrc->clk.set_rate = s3c_setrate_clksrc;
+		if (!clksrc->clk.round_rate)
+			clksrc->clk.round_rate = s3c_roundrate_clksrc;
+
+		s3c_set_clksrc(clksrc);
+
+		ret = s3c24xx_register_clock(&clksrc->clk);
+
+		if (ret < 0) {
+			printk(KERN_ERR "%s: failed to register %s (%d)\n",
+			       __func__, clksrc->clk.name, ret);
+		}
+	}
+}
diff --git a/arch/arm/plat-samsung/include/plat/clock-clksrc.h b/arch/arm/plat-samsung/include/plat/clock-clksrc.h
new file mode 100644
index 0000000..283dfa0
--- /dev/null
+++ b/arch/arm/plat-samsung/include/plat/clock-clksrc.h
@@ -0,0 +1,75 @@
+/* linux/arch/arm/plat-samsung/include/plat/clock-clksrc.h
+ *
+ * Parts taken from arch/arm/plat-s3c64xx/clock.c
+ *	Copyright 2008 Openmoko, Inc.
+ *	Copyright 2008 Simtec Electronics
+ *		Ben Dooks <ben@simtec.co.uk>
+ *		http://armlinux.simtec.co.uk/
+ *
+ * Copyright 2009 Ben Dooks <ben-linux@fluff.org>
+ * Copyright 2009 Harald Welte
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+/**
+ * struct clksrc_sources - list of sources for a given clock
+ * @sources: array of pointers to clocks
+ * @nr_sources: The size of @sources
+ */
+struct clksrc_sources {
+	unsigned int	nr_sources;
+	struct clk	**sources;
+};
+
+/**
+ * struct clksrc_reg - register definition for clock control bits
+ * @reg: pointer to the register in virtual memory.
+ * @shift: the shift in bits to where the bitfield is.
+ * @size: the size in bits of the bitfield.
+ *
+ * This specifies the size and position of the bits we are interested
+ * in within the register specified by @reg.
+ */
+struct clksrc_reg {
+	void __iomem		*reg;
+	unsigned short		shift;
+	unsigned short		size;
+};
+
+/**
+ * struct clksrc_clk - class of clock for newer style samsung devices.
+ * @clk: the standard clock representation
+ * @sources: the sources for this clock
+ * @reg_src: the register definition for selecting the clock's source
+ * @reg_div: the register definition for the clock's output divisor
+ *
+ * This clock implements the features required by the newer SoCs where
+ * the standard clock block provides an input mux and a post-mux divisor
+ * to provide the periperhal's clock.
+ *
+ * The array of @sources provides the mapping of mux position to the
+ * clock, and @reg_src shows the code where to modify to change the mux
+ * position. The @reg_div defines how to change the divider settings on
+ * the output.
+ */
+struct clksrc_clk {
+	struct clk		clk;
+	struct clksrc_sources	*sources;
+
+	struct clksrc_reg	reg_src;
+	struct clksrc_reg	reg_div;
+};
+
+extern void s3c_set_clksrc(struct clksrc_clk *clk);
+
+/**
+ * s3c_register_clksrc() register clocks from an array of clksrc clocks
+ * @srcs: The array of clocks to register
+ * @size: The size of the @srcs array.
+ *
+ * Initialise and register the array of clocks described by @srcs.
+ */
+extern void s3c_register_clksrc(struct clksrc_clk *srcs, int size);
-- 
1.6.0.4
