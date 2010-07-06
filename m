From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Tue, 06 Jul 2010 14:41:13 +0900
Subject: [RFC PATCH 2/3] ARM: S5P: common struct clk support.
In-Reply-To: <1278394874-8695-2-git-send-email-myungjoo.ham@samsung.com>
References: <1278394874-8695-1-git-send-email-myungjoo.ham@samsung.com>
	<1278394874-8695-2-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <1278394874-8695-3-git-send-email-myungjoo.ham@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The (struct clk --> struct clk_samsung) clocks declared
at arch/arm/plat-s5p/clock.c are revised and rewritten at
arch/arm/plat-s5p/clock-common-clk.c to support common struct clk.

Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/plat-s5p/Makefile                 |    3 +-
 arch/arm/plat-s5p/clock-common-clk.c       |  163 ++++++++++++++++++++++++++++
 arch/arm/plat-s5p/include/plat/s5p-clock.h |   18 +++
 3 files changed, 183 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/plat-s5p/clock-common-clk.c

diff --git a/arch/arm/plat-s5p/Makefile b/arch/arm/plat-s5p/Makefile
index 39c242b..df4555f 100644
--- a/arch/arm/plat-s5p/Makefile
+++ b/arch/arm/plat-s5p/Makefile
@@ -14,7 +14,8 @@ obj-				:=
 
 obj-y				+= dev-uart.o
 obj-y				+= cpu.o
-obj-y				+= clock.o
+obj-$(CONFIG_USE_NONCOMMON_STRUCT_CLK)	+= clock.o
+obj-$(CONFIG_USE_COMMON_STRUCT_CLK)		+= clock-common-clk.o
 obj-y				+= irq.o
 obj-$(CONFIG_S5P_EXT_INT)	+= irq-eint.o
 
diff --git a/arch/arm/plat-s5p/clock-common-clk.c b/arch/arm/plat-s5p/clock-common-clk.c
new file mode 100644
index 0000000..2e2bd31
--- /dev/null
+++ b/arch/arm/plat-s5p/clock-common-clk.c
@@ -0,0 +1,163 @@
+/* linux/arch/arm/plat-s5p/clock.c
+ *
+ * Copyright 2009 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * S5P - Common clock support
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
+#include <asm/div64.h>
+
+#include <plat/clock.h>
+#include <plat/clock-clksrc.h>
+#include <plat/s5p-clock.h>
+
+/* fin_apll, fin_mpll and fin_epll are all the same clock, which we call
+ * clk_ext_xtal_mux.
+*/
+struct clk_samsung clk_ext_xtal_mux = {
+	.name		= "ext_xtal",
+	.id		= -1,
+};
+
+struct clk_samsung clk_xusbxti = {
+	.name		= "xusbxti",
+	.id		= -1,
+};
+
+struct clk_samsung s5p_clk_27m = {
+	.name		= "clk_27m",
+	.id		= -1,
+	.rate		= 27000000,
+};
+
+/* 48MHz USB Phy clock output */
+struct clk_samsung clk_48m = {
+	.name		= "clk_48m",
+	.id		= -1,
+	.rate		= 48000000,
+};
+
+/* APLL clock output
+ * No need .ctrlbit, this is always on
+*/
+struct clk_samsung clk_fout_apll = {
+	.name		= "fout_apll",
+	.id		= -1,
+};
+
+/* MPLL clock output
+ * No need .ctrlbit, this is always on
+*/
+struct clk_samsung clk_fout_mpll = {
+	.name		= "fout_mpll",
+	.id		= -1,
+};
+
+/* EPLL clock output */
+struct clk_samsung clk_fout_epll = {
+	.name		= "fout_epll",
+	.id		= -1,
+	.ctrlbit	= (1 << 31),
+};
+
+/* VPLL clock output */
+struct clk_samsung clk_fout_vpll = {
+	.name		= "fout_vpll",
+	.id		= -1,
+	.ctrlbit	= (1 << 31),
+};
+
+/* ARM clock */
+struct clk_samsung clk_arm = {
+	.name		= "armclk",
+	.id		= -1,
+	.rate		= 0,
+	.ctrlbit	= 0,
+};
+
+/* Possible clock sources for APLL Mux */
+static struct clk_samsung *clk_src_apll_list[] = {
+	[0] = &clk_fin_apll,
+	[1] = &clk_fout_apll,
+};
+
+struct clksrc_sources clk_src_apll = {
+	.sources	= clk_src_apll_list,
+	.nr_sources	= ARRAY_SIZE(clk_src_apll_list),
+};
+
+/* Possible clock sources for MPLL Mux */
+static struct clk_samsung *clk_src_mpll_list[] = {
+	[0] = &clk_fin_mpll,
+	[1] = &clk_fout_mpll,
+};
+
+struct clksrc_sources clk_src_mpll = {
+	.sources	= clk_src_mpll_list,
+	.nr_sources	= ARRAY_SIZE(clk_src_mpll_list),
+};
+
+/* Possible clock sources for EPLL Mux */
+static struct clk_samsung *clk_src_epll_list[] = {
+	[0] = &clk_fin_epll,
+	[1] = &clk_fout_epll,
+};
+
+struct clksrc_sources clk_src_epll = {
+	.sources	= clk_src_epll_list,
+	.nr_sources	= ARRAY_SIZE(clk_src_epll_list),
+};
+
+struct clk_samsung clk_vpll = {
+	.name		= "vpll",
+	.id		= -1,
+};
+
+int s5p_gatectrl(void __iomem *reg, struct clk_samsung *clk, int enable)
+{
+	unsigned int ctrlbit = clk->ctrlbit;
+	u32 con;
+
+	con = __raw_readl(reg);
+	con = enable ? (con | ctrlbit) : (con & ~ctrlbit);
+	__raw_writel(con, reg);
+	return 0;
+}
+
+static struct clk_samsung *s5p_clks[] __initdata = {
+	&clk_ext_xtal_mux,
+	&clk_48m,
+	&s5p_clk_27m,
+	&clk_fout_apll,
+	&clk_fout_mpll,
+	&clk_fout_epll,
+	&clk_fout_vpll,
+	&clk_arm,
+	&clk_vpll,
+	&clk_xusbxti,
+};
+
+void __init s5p_register_clocks(unsigned long xtal_freq)
+{
+	int ret;
+
+	clk_ext_xtal_mux.rate = xtal_freq;
+
+	ret = s3c24xx_register_clocks(s5p_clks, ARRAY_SIZE(s5p_clks));
+	if (ret > 0)
+		printk(KERN_ERR "Failed to register s5p clocks\n");
+}
diff --git a/arch/arm/plat-s5p/include/plat/s5p-clock.h b/arch/arm/plat-s5p/include/plat/s5p-clock.h
index 09418b1..e39a595 100644
--- a/arch/arm/plat-s5p/include/plat/s5p-clock.h
+++ b/arch/arm/plat-s5p/include/plat/s5p-clock.h
@@ -23,6 +23,18 @@
 #define clk_fin_vpll clk_ext_xtal_mux
 #define clk_fin_hpll clk_ext_xtal_mux
 
+#ifdef CONFIG_USE_COMMON_STRUCT_CLK
+extern struct clk_samsung clk_ext_xtal_mux;
+extern struct clk_samsung clk_xusbxti;
+extern struct clk_samsung clk_48m;
+extern struct clk_samsung s5p_clk_27m;
+extern struct clk_samsung clk_fout_apll;
+extern struct clk_samsung clk_fout_mpll;
+extern struct clk_samsung clk_fout_epll;
+extern struct clk_samsung clk_fout_vpll;
+extern struct clk_samsung clk_arm;
+extern struct clk_samsung clk_vpll;
+#else
 extern struct clk clk_ext_xtal_mux;
 extern struct clk clk_xusbxti;
 extern struct clk clk_48m;
@@ -33,12 +45,18 @@ extern struct clk clk_fout_epll;
 extern struct clk clk_fout_vpll;
 extern struct clk clk_arm;
 extern struct clk clk_vpll;
+#endif
 
 extern struct clksrc_sources clk_src_apll;
 extern struct clksrc_sources clk_src_mpll;
 extern struct clksrc_sources clk_src_epll;
 
+#ifdef CONFIG_USE_COMMON_STRUCT_CLK
+extern int s5p6440_clk48m_ctrl(struct clk_samsung *clk, int enable);
+extern int s5p_gatectrl(void __iomem *reg, struct clk_samsung *clk, int enable);
+#else
 extern int s5p6440_clk48m_ctrl(struct clk *clk, int enable);
 extern int s5p_gatectrl(void __iomem *reg, struct clk *clk, int enable);
+#endif
 
 #endif /* __ASM_PLAT_S5P_CLOCK_H */
-- 
1.6.3.3
