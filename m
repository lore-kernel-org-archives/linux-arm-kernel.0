From: padma.v@samsung.com (Padmavathi Venna)
Date: Fri, 05 Apr 2013 11:53:47 +0530
Subject: [PATCH 1/3] clk: exynos: register audio subsystem clocks using common
 clock framework
Message-ID: <1365143029-16936-1-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Audio subsystem is introduced in exynos platforms. This has seperate
clock controller which can control i2s0 and pcm0 clocks. This patch
registers the audio subsystem clocks with the common clock framework.

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---
 drivers/clk/samsung/Makefile           |    1 +
 drivers/clk/samsung/clk-exynos-audss.c |  139 ++++++++++++++++++++++++++++++++
 2 files changed, 140 insertions(+), 0 deletions(-)
 create mode 100644 drivers/clk/samsung/clk-exynos-audss.c

diff --git a/drivers/clk/samsung/Makefile b/drivers/clk/samsung/Makefile
index b7c232e..1876810 100644
--- a/drivers/clk/samsung/Makefile
+++ b/drivers/clk/samsung/Makefile
@@ -6,3 +6,4 @@ obj-$(CONFIG_COMMON_CLK)	+= clk.o clk-pll.o
 obj-$(CONFIG_ARCH_EXYNOS4)	+= clk-exynos4.o
 obj-$(CONFIG_SOC_EXYNOS5250)	+= clk-exynos5250.o
 obj-$(CONFIG_SOC_EXYNOS5440)	+= clk-exynos5440.o
+obj-$(CONFIG_ARCH_EXYNOS)	+= clk-exynos-audss.o
diff --git a/drivers/clk/samsung/clk-exynos-audss.c b/drivers/clk/samsung/clk-exynos-audss.c
new file mode 100644
index 0000000..d7f9aa8
--- /dev/null
+++ b/drivers/clk/samsung/clk-exynos-audss.c
@@ -0,0 +1,139 @@
+/*
+ * Copyright (c) 2013 Samsung Electronics Co., Ltd.
+ * Author: Padmavathi Venna <padma.v@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Common Clock Framework support for Audio clks.
+*/
+
+#include <linux/clkdev.h>
+#include <linux/io.h>
+#include <linux/clk-provider.h>
+#include <linux/of_address.h>
+#include <linux/syscore_ops.h>
+
+static DEFINE_SPINLOCK(lock);
+static struct clk **clk_table;
+static void __iomem *reg_base;
+#ifdef CONFIG_OF
+static struct clk_onecell_data clk_data;
+#endif
+
+#define ASS_CLK_SRC 0x0
+#define ASS_CLK_DIV 0x4
+#define ASS_CLK_GATE 0x8
+
+static unsigned long reg_save[][2] = {
+	{ASS_CLK_SRC,  0x0},
+	{ASS_CLK_DIV,  0x0},
+	{ASS_CLK_GATE, 0x0},
+};
+
+/*
+ * Let each supported clock get a unique id. This id is used to lookup the clock
+ * for device tree based platforms.
+ *
+ * When adding a new clock to this list, it is advised to add it to the end.
+ * That is because the device tree source file is referring to these ids and
+ * any change in the sequence number of existing clocks will require
+ * corresponding change in the device tree files. This limitation would go away
+ * when pre-processor support for dtc would be available.
+ */
+enum exynos_audss_clks {
+	/* audss clocks */
+	mout_audss, mout_i2s,
+	dout_srp, dout_bus, dout_i2s,
+	srp_clk, i2s_bus, sclk_i2s0,
+
+	nr_clks,
+};
+
+/* list of all parent clock list */
+static const char *mout_audss_p[] = { "fin_pll", "fout_epll" };
+static const char *mout_i2s_p[] = { "mout_audss", "cdclk0", "sclk_audio0" };
+
+#ifdef CONFIG_PM_SLEEP
+static int exynos_audss_clk_suspend(void)
+{
+	int i;
+
+	for (i = 0; i < 3; i++)
+		reg_save[i][1] = __raw_readl(reg_base + reg_save[i][0]);
+
+	return 0;
+}
+
+static void exynos_audss_clk_resume(void)
+{
+	int i;
+
+	for (i = 0; i < 3; i++)
+		__raw_writel(reg_save[i][1], reg_base + reg_save[i][0]);
+}
+
+static struct syscore_ops exynos_audss_clk_syscore_ops = {
+	.suspend	= exynos_audss_clk_suspend,
+	.resume		= exynos_audss_clk_resume,
+};
+#endif /* CONFIG_PM_SLEEP */
+
+/* register exynos_audss clocks */
+void __init exynos_audss_clk_init(struct device_node *np)
+{
+	if (np) {
+		reg_base = of_iomap(np, 0);
+		if (!reg_base)
+			panic("%s: failed to map registers\n", __func__);
+	} else
+		panic("%s: unable to determine soc\n", __func__);
+
+	clk_table = kzalloc(sizeof(struct clk *) * nr_clks, GFP_KERNEL);
+	if (!clk_table)
+		panic("could not allocate clock lookup table\n");
+
+	clk_data.clks = clk_table;
+	clk_data.clk_num = nr_clks;
+	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
+
+	clk_table[mout_audss] = clk_register_mux(NULL, "mout_audss",
+				mout_audss_p, ARRAY_SIZE(mout_audss_p), 0,
+				reg_base + ASS_CLK_SRC, 0, 1, 0, &lock);
+	clk_register_clkdev(clk_table[mout_audss], "mout_audss", NULL);
+
+	clk_table[mout_i2s] = clk_register_mux(NULL, "mout_i2s", mout_i2s_p,
+				ARRAY_SIZE(mout_i2s_p), 0,
+				reg_base + ASS_CLK_SRC, 2, 2, 0, &lock);
+	clk_register_clkdev(clk_table[mout_i2s], "mout_i2s", NULL);
+
+	clk_table[dout_srp] = clk_register_divider(NULL, "dout_srp",
+				"mout_audss", 0, reg_base + ASS_CLK_DIV, 0, 4,
+				0, &lock);
+
+	clk_table[dout_bus] = clk_register_divider(NULL, "dout_bus",
+				"dout_srp", 0, reg_base + ASS_CLK_DIV, 4, 4, 0,
+				&lock);
+
+	clk_table[dout_i2s] = clk_register_divider(NULL, "dout_i2s",
+				"mout_i2s", 0, reg_base + ASS_CLK_DIV, 8, 4, 0,
+				&lock);
+
+	clk_table[srp_clk] = clk_register_gate(NULL, "srp_clk", "dout_srp",
+				CLK_SET_RATE_PARENT, reg_base + ASS_CLK_GATE, 0,
+				0, &lock);
+
+	clk_table[i2s_bus] = clk_register_gate(NULL, "i2s_bus", "dout_bus",
+				CLK_SET_RATE_PARENT, reg_base + ASS_CLK_GATE, 2,
+				0, &lock);
+
+	clk_table[sclk_i2s0] = clk_register_gate(NULL, "sclk_i2s0", "dout_i2s",
+				CLK_SET_RATE_PARENT, reg_base + ASS_CLK_GATE, 3,
+				0, &lock);
+#ifdef CONFIG_PM_SLEEP
+	register_syscore_ops(&exynos_audss_clk_syscore_ops);
+#endif
+	pr_info("Exynos: Audss: clock setup completed\n");
+}
+CLK_OF_DECLARE(exynos_audss_clk, "samsung,exynos-audss-clock", exynos_audss_clk_init);
-- 
1.7.4.4
