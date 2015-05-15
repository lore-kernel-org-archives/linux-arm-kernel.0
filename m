From: shawnguo@kernel.org (shawnguo at kernel.org)
Date: Fri, 15 May 2015 16:11:40 +0800
Subject: [PATCH 2/9] ARM: imx: define an enum for gpt timer device type
In-Reply-To: <1431677507-27420-1-git-send-email-shawnguo@kernel.org>
References: <1431677507-27420-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1431677507-27420-3-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo <shawn.guo@linaro.org>

Define an enum for gpt timer device type in include/soc/imx/timer.h to
tell the gpt block differences among SoCs.  Update non-DT users (clock
drivers) to pass the device type.

As we now have include/soc/imx/timer.h, the declaration of
mxc_timer_init() is moved into there as the best fit.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/time.c    |  6 +++++-
 drivers/clk/imx/clk-imx1.c  |  3 ++-
 drivers/clk/imx/clk-imx21.c |  3 ++-
 drivers/clk/imx/clk-imx27.c |  3 ++-
 drivers/clk/imx/clk-imx31.c |  3 ++-
 drivers/clk/imx/clk-imx35.c |  3 ++-
 drivers/clk/imx/clk.h       |  7 -------
 include/soc/imx/timer.h     | 26 ++++++++++++++++++++++++++
 8 files changed, 41 insertions(+), 13 deletions(-)
 create mode 100644 include/soc/imx/timer.h

diff --git a/arch/arm/mach-imx/time.c b/arch/arm/mach-imx/time.c
index 8ad7cb2a7f08..5241a173fd60 100644
--- a/arch/arm/mach-imx/time.c
+++ b/arch/arm/mach-imx/time.c
@@ -31,6 +31,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
+#include <soc/imx/timer.h>
 
 #include <asm/mach/time.h>
 
@@ -85,6 +86,7 @@ static struct clock_event_device clockevent_mxc;
 static enum clock_event_mode clockevent_mode = CLOCK_EVT_MODE_UNUSED;
 
 struct imx_timer {
+	enum imx_gpt_type type;
 	void __iomem *base;
 	int irq;
 	struct clk *clk_per;
@@ -352,7 +354,7 @@ static void __init _mxc_timer_init(void)
 	setup_irq(imxtm.irq, &mxc_timer_irq);
 }
 
-void __init mxc_timer_init(unsigned long pbase, int irq)
+void __init mxc_timer_init(unsigned long pbase, int irq, enum imx_gpt_type type)
 {
 	imxtm.clk_per = clk_get_sys("imx-gpt.0", "per");
 	imxtm.clk_ipg = clk_get_sys("imx-gpt.0", "ipg");
@@ -360,6 +362,8 @@ void __init mxc_timer_init(unsigned long pbase, int irq)
 	imxtm.base = ioremap(pbase, SZ_4K);
 	BUG_ON(!imxtm.base);
 
+	imxtm.type = type;
+
 	_mxc_timer_init();
 }
 
diff --git a/drivers/clk/imx/clk-imx1.c b/drivers/clk/imx/clk-imx1.c
index c9812dbacac2..c2647fa19f28 100644
--- a/drivers/clk/imx/clk-imx1.c
+++ b/drivers/clk/imx/clk-imx1.c
@@ -23,6 +23,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <dt-bindings/clock/imx1-clock.h>
+#include <soc/imx/timer.h>
 #include <asm/irq.h>
 
 #include "clk.h"
@@ -102,7 +103,7 @@ int __init mx1_clocks_init(unsigned long fref)
 	clk_register_clkdev(clk[IMX1_CLK_DUMMY], "ipg", "imx1-fb.0");
 	clk_register_clkdev(clk[IMX1_CLK_DUMMY], "ahb", "imx1-fb.0");
 
-	mxc_timer_init(MX1_TIM1_BASE_ADDR, MX1_TIM1_INT);
+	mxc_timer_init(MX1_TIM1_BASE_ADDR, MX1_TIM1_INT, GPT_TYPE_IMX1);
 
 	return 0;
 }
diff --git a/drivers/clk/imx/clk-imx21.c b/drivers/clk/imx/clk-imx21.c
index 0ca842cf4ca7..dba987e3b89f 100644
--- a/drivers/clk/imx/clk-imx21.c
+++ b/drivers/clk/imx/clk-imx21.c
@@ -15,6 +15,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <dt-bindings/clock/imx21-clock.h>
+#include <soc/imx/timer.h>
 #include <asm/irq.h>
 
 #include "clk.h"
@@ -156,7 +157,7 @@ int __init mx21_clocks_init(unsigned long lref, unsigned long href)
 	clk_register_clkdev(clk[IMX21_CLK_I2C_GATE], NULL, "imx21-i2c.0");
 	clk_register_clkdev(clk[IMX21_CLK_OWIRE_GATE], NULL, "mxc_w1.0");
 
-	mxc_timer_init(MX21_GPT1_BASE_ADDR, MX21_INT_GPT1);
+	mxc_timer_init(MX21_GPT1_BASE_ADDR, MX21_INT_GPT1, GPT_TYPE_IMX21);
 
 	return 0;
 }
diff --git a/drivers/clk/imx/clk-imx27.c b/drivers/clk/imx/clk-imx27.c
index df2dfc081c71..d9d50d54ef2a 100644
--- a/drivers/clk/imx/clk-imx27.c
+++ b/drivers/clk/imx/clk-imx27.c
@@ -6,6 +6,7 @@
 #include <linux/of_address.h>
 #include <dt-bindings/clock/imx27-clock.h>
 #include <soc/imx/revision.h>
+#include <soc/imx/timer.h>
 #include <asm/irq.h>
 
 #include "clk.h"
@@ -233,7 +234,7 @@ int __init mx27_clocks_init(unsigned long fref)
 	clk_register_clkdev(clk[IMX27_CLK_EMMA_AHB_GATE], "ahb", "m2m-emmaprp.0");
 	clk_register_clkdev(clk[IMX27_CLK_EMMA_IPG_GATE], "ipg", "m2m-emmaprp.0");
 
-	mxc_timer_init(MX27_GPT1_BASE_ADDR, MX27_INT_GPT1);
+	mxc_timer_init(MX27_GPT1_BASE_ADDR, MX27_INT_GPT1, GPT_TYPE_IMX21);
 
 	return 0;
 }
diff --git a/drivers/clk/imx/clk-imx31.c b/drivers/clk/imx/clk-imx31.c
index a55290c1c264..fe66c40b7be2 100644
--- a/drivers/clk/imx/clk-imx31.c
+++ b/drivers/clk/imx/clk-imx31.c
@@ -22,6 +22,7 @@
 #include <linux/err.h>
 #include <linux/of.h>
 #include <soc/imx/revision.h>
+#include <soc/imx/timer.h>
 #include <asm/irq.h>
 
 #include "clk.h"
@@ -198,7 +199,7 @@ int __init mx31_clocks_init(unsigned long fref)
 	mx31_revision();
 	clk_disable_unprepare(clk[iim_gate]);
 
-	mxc_timer_init(MX31_GPT1_BASE_ADDR, MX31_INT_GPT);
+	mxc_timer_init(MX31_GPT1_BASE_ADDR, MX31_INT_GPT, GPT_TYPE_IMX31);
 
 	return 0;
 }
diff --git a/drivers/clk/imx/clk-imx35.c b/drivers/clk/imx/clk-imx35.c
index f2f3b8164f7b..69138ba3dec7 100644
--- a/drivers/clk/imx/clk-imx35.c
+++ b/drivers/clk/imx/clk-imx35.c
@@ -14,6 +14,7 @@
 #include <linux/of.h>
 #include <linux/err.h>
 #include <soc/imx/revision.h>
+#include <soc/imx/timer.h>
 #include <asm/irq.h>
 
 #include "clk.h"
@@ -293,7 +294,7 @@ int __init mx35_clocks_init(void)
 
 	imx_print_silicon_rev("i.MX35", mx35_revision());
 
-	mxc_timer_init(MX35_GPT1_BASE_ADDR, MX35_INT_GPT);
+	mxc_timer_init(MX35_GPT1_BASE_ADDR, MX35_INT_GPT, GPT_TYPE_IMX31);
 
 	return 0;
 }
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 6bae5374dc83..b5297e457a8e 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -6,13 +6,6 @@
 
 extern spinlock_t imx_ccm_lock;
 
-/*
- * This is a stop-gap solution for clock drivers like imx1/imx21 which call
- * mxc_timer_init() to initialize timer for non-DT boot.  It can be removed
- * when these legacy non-DT support is converted or dropped.
- */
-void mxc_timer_init(unsigned long pbase, int irq);
-
 void imx_check_clocks(struct clk *clks[], unsigned int count);
 
 extern void imx_cscmr1_fixup(u32 *val);
diff --git a/include/soc/imx/timer.h b/include/soc/imx/timer.h
new file mode 100644
index 000000000000..bbbafd65f464
--- /dev/null
+++ b/include/soc/imx/timer.h
@@ -0,0 +1,26 @@
+/*
+ * Copyright 2015 Linaro Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __SOC_IMX_TIMER_H__
+#define __SOC_IMX_TIMER_H__
+
+enum imx_gpt_type {
+	GPT_TYPE_IMX1,		/* i.MX1 */
+	GPT_TYPE_IMX21,		/* i.MX21/27 */
+	GPT_TYPE_IMX31,		/* i.MX31/35/25/37/51/6Q */
+	GPT_TYPE_IMX6DL,	/* i.MX6DL/SX/SL */
+};
+
+/*
+ * This is a stop-gap solution for clock drivers like imx1/imx21 which call
+ * mxc_timer_init() to initialize timer for non-DT boot.  It can be removed
+ * when these legacy non-DT support is converted or dropped.
+ */
+void mxc_timer_init(unsigned long pbase, int irq, enum imx_gpt_type type);
+
+#endif  /* __SOC_IMX_TIMER_H__ */
-- 
1.9.1
