From: peter.griffin@linaro.org (Peter Griffin)
Date: Fri, 17 Apr 2015 11:50:19 +0100
Subject: [PATCH 1/5] clocksource: st_lpc: Add LPC timer as a clocksource.
In-Reply-To: <1429267823-8879-1-git-send-email-peter.griffin@linaro.org>
References: <1429267823-8879-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1429267823-8879-2-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for the LPC timer as a clocksource
which is found on stih407 family SoCs.

We wish to use the LPC timer as a clocksource instead of
arm_global_timer, as the latter is tied to CPU frequency, and
that driver currently makes no account for frequency scaling.

Once this driver is merged cpufreq can be enabled for stih407
family SoCs without also effecting sched_clock.

Signed-off-by: Ajit Pal Singh <ajitpal.singh@st.com>
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 drivers/clocksource/Kconfig  |  16 +++++
 drivers/clocksource/Makefile |   1 +
 drivers/clocksource/st_lpc.c | 154 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 171 insertions(+)
 create mode 100644 drivers/clocksource/st_lpc.c

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index a0b036c..29cd67d 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -253,4 +253,20 @@ config CLKSRC_PXA
 	help
 	  This enables OST0 support available on PXA and SA-11x0
 	  platforms.
+
+config CLKSRC_ST_LPC_CLOCK
+	bool
+	depends on ARCH_STI
+	select CLKSRC_OF if OF
+	help
+	  Enable this option to use the Low Power controller timer
+	  as clock source.
+
+config CLKSRC_ST_LPC_TIMER_SCHED_CLOCK
+	bool
+	depends on ST_LPC_CLOCK
+	default y
+	help
+	  Use Low Power controller timer clock source as sched_clock
+
 endmenu
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 752d5c7..356d331 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -51,3 +51,4 @@ obj-$(CONFIG_ARCH_INTEGRATOR_AP)	+= timer-integrator-ap.o
 obj-$(CONFIG_CLKSRC_VERSATILE)		+= versatile.o
 obj-$(CONFIG_CLKSRC_MIPS_GIC)		+= mips-gic-timer.o
 obj-$(CONFIG_ASM9260_TIMER)		+= asm9260_timer.o
+obj-$(CONFIG_CLKSRC_ST_LPC_CLOCK)	+= st_lpc.o
diff --git a/drivers/clocksource/st_lpc.c b/drivers/clocksource/st_lpc.c
new file mode 100644
index 0000000..f9abded
--- /dev/null
+++ b/drivers/clocksource/st_lpc.c
@@ -0,0 +1,154 @@
+/*
+ * This driver implements a Clocksource using the Low Power Timer in
+ * the Low Power Controller (LPC) in some STMicroelectronics
+ * STi series SoCs
+ *
+ * Copyright (C) 2015 STMicroelectronics Limited
+ * Author: Francesco Virlinzi <francesco.virlinzi@st.com>
+ * Author: Ajit Pal Singh <ajitpal.singh@st.com>
+ *
+ * May be copied or modified under the terms of the GNU General Public
+ * License.  See linux/COPYING for more information.
+ */
+
+#include <linux/clk.h>
+#include <linux/clocksource.h>
+#include <linux/init.h>
+#include <linux/of_address.h>
+#include <linux/sched_clock.h>
+#include <linux/slab.h>
+
+/* Low Power Timer */
+#define LPC_LPT_LSB_OFF		0x400
+#define LPC_LPT_MSB_OFF		0x404
+#define LPC_LPT_START_OFF	0x408
+
+struct st_lpc {
+	struct clk *clk;
+	void __iomem *iomem_cs;
+};
+
+static struct st_lpc *st_lpc;
+
+static u64 notrace st_lpc_counter_read(void)
+{
+	u64 counter;
+	u32 lower;
+	u32 upper, old_upper;
+
+	upper = readl_relaxed(st_lpc->iomem_cs + LPC_LPT_MSB_OFF);
+	do {
+		old_upper = upper;
+		lower = readl_relaxed(st_lpc->iomem_cs + LPC_LPT_LSB_OFF);
+		upper = readl_relaxed(st_lpc->iomem_cs + LPC_LPT_MSB_OFF);
+	} while (upper != old_upper);
+
+	counter = upper;
+	counter <<= 32;
+	counter |= lower;
+	return counter;
+}
+
+static cycle_t st_lpc_clocksource_read(struct clocksource *cs)
+{
+	return st_lpc_counter_read();
+}
+
+static void st_lpc_clocksource_reset(struct clocksource *cs)
+{
+	writel_relaxed(0, st_lpc->iomem_cs + LPC_LPT_START_OFF);
+	writel_relaxed(0, st_lpc->iomem_cs + LPC_LPT_MSB_OFF);
+	writel_relaxed(0, st_lpc->iomem_cs + LPC_LPT_LSB_OFF);
+	writel_relaxed(1, st_lpc->iomem_cs + LPC_LPT_START_OFF);
+}
+
+static struct clocksource st_lpc_clocksource = {
+	.name   = "st-lpc clocksource",
+	.rating = 301,
+	.read   = st_lpc_clocksource_read,
+	.mask   = CLOCKSOURCE_MASK(64),
+	.flags  = CLOCK_SOURCE_IS_CONTINUOUS,
+};
+
+#ifdef CONFIG_CLKSRC_LPC_TIMER_SCHED_CLOCK
+static u64 notrace st_lpc_sched_clock_read(void)
+{
+	return st_lpc_counter_read();
+}
+#endif
+
+static void __init st_lpc_clocksource_init(void)
+{
+	unsigned long rate;
+
+	st_lpc_clocksource_reset(&st_lpc_clocksource);
+
+	rate = clk_get_rate(st_lpc->clk);
+#ifdef CONFIG_CLKSRC_LPC_TIMER_SCHED_CLOCK
+	sched_clock_register(st_lpc_sched_clock_read, 64, rate);
+#endif
+	clocksource_register_hz(&st_lpc_clocksource, rate);
+
+}
+
+static int st_lpc_setup_clk(struct device_node *np)
+{
+	char *clk_name = "lpc_clk";
+	struct clk *clk;
+	int ret;
+
+	clk = of_clk_get_by_name(np, clk_name);
+	if (IS_ERR(clk)) {
+		pr_err("st-lpc: unable to get lpc clock\n");
+		ret = PTR_ERR(clk);
+		return ret;
+	}
+
+	if (clk_prepare_enable(clk)) {
+		pr_err("st-lpc: %s could not be enabled\n", clk_name);
+		return -EINVAL;
+	}
+
+	if (!clk_get_rate(clk)) {
+		pr_err("st-lpc: Unable to get clock rate\n");
+		clk_disable_unprepare(clk);
+		return -EINVAL;
+	}
+
+	pr_info("st-lpc: %s running @ %lu Hz\n",
+		clk_name, clk_get_rate(clk));
+
+	st_lpc->clk = clk;
+
+	return 0;
+}
+
+static void __init st_lpc_of_register(struct device_node *np)
+{
+	st_lpc = kzalloc(sizeof(*st_lpc), GFP_KERNEL);
+	if (!st_lpc) {
+		pr_err("st-lpc: No memory available\n");
+		return;
+	}
+
+	st_lpc->iomem_cs = of_iomap(np, 0);
+	if (!st_lpc->iomem_cs) {
+		pr_err("st-lpc: Unable to map iomem\n");
+		goto err_kfree;
+	}
+
+	if (st_lpc_setup_clk(np))
+		goto err_iounmap;
+
+	st_lpc_clocksource_init();
+
+	pr_info("st-lpc: clocksource initialised: iomem: %p\n",
+		st_lpc->iomem_cs);
+	return;
+err_iounmap:
+	iounmap(st_lpc->iomem_cs);
+err_kfree:
+	kfree(st_lpc);
+}
+
+CLOCKSOURCE_OF_DECLARE(st_lpc, "st,st_lpc_timer", st_lpc_of_register);
-- 
1.9.1
