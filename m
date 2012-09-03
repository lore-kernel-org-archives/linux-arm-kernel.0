From: pawel.moll@arm.com (Pawel Moll)
Date: Mon,  3 Sep 2012 17:25:26 +0100
Subject: [PATCH 06/11] clk: Common clocks implementation for Versatile Express
In-Reply-To: <1346689531-7212-1-git-send-email-pawel.moll@arm.com>
References: <1346689531-7212-1-git-send-email-pawel.moll@arm.com>
Message-ID: <1346689531-7212-7-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a DT and non-DT based implementation of
the common clock infrastructure for Versatile Express
platform. It registers (statically or using DT) all
required fixed clocks, initialises motherboard's SP810
cell (that provides clocks for SP804 timers) and
explicitely registers VE "osc" driver, to make the
clock generators availalable early.

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
Cc: Mike Turquette <mturquette@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/clk/Kconfig                  |    8 +-
 drivers/clk/versatile/Makefile       |    1 +
 drivers/clk/versatile/clk-vexpress.c |  174 ++++++++++++++++++++++++++++++++++
 include/linux/vexpress.h             |    4 +
 4 files changed, 184 insertions(+), 3 deletions(-)
 create mode 100644 drivers/clk/versatile/clk-vexpress.c

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 89b726d..3e4eda2 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -42,9 +42,11 @@ config COMMON_CLK_WM831X
 
 config COMMON_CLK_VERSATILE
 	tristate "Clock driver for ARM Reference designs"
-	depends on ARCH_INTEGRATOR || ARCH_REALVIEW
+	depends on ARCH_INTEGRATOR || ARCH_REALVIEW || ARCH_VEXPRESS
 	---help---
-          Supports clocking on ARM Reference designs Integrator/AP,
-	  Integrator/CP, RealView PB1176, EB, PB11MP and PBX.
+          Supports clocking on ARM Reference designs:
+	  - Integrator/AP and Integrator/CP
+	  - RealView PB1176, EB, PB11MP and PBX
+	  - Versatile Express
 
 endmenu
diff --git a/drivers/clk/versatile/Makefile b/drivers/clk/versatile/Makefile
index dd32e77..c2a5868 100644
--- a/drivers/clk/versatile/Makefile
+++ b/drivers/clk/versatile/Makefile
@@ -2,4 +2,5 @@
 obj-$(CONFIG_ICST)		+= clk-icst.o
 obj-$(CONFIG_ARCH_INTEGRATOR)	+= clk-integrator.o
 obj-$(CONFIG_ARCH_REALVIEW)	+= clk-realview.o
+obj-$(CONFIG_ARCH_VEXPRESS)	+= clk-vexpress.o
 obj-$(CONFIG_VEXPRESS_CONFIG_BUS) += clk-vexpress-osc.o
diff --git a/drivers/clk/versatile/clk-vexpress.c b/drivers/clk/versatile/clk-vexpress.c
new file mode 100644
index 0000000..375e259
--- /dev/null
+++ b/drivers/clk/versatile/clk-vexpress.c
@@ -0,0 +1,174 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * Copyright (C) 2012 ARM Limited
+ */
+
+#include <linux/clkdev.h>
+#include <linux/clk-provider.h>
+#include <linux/err.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/vexpress.h>
+
+#include <asm/hardware/sp810.h>
+
+static struct clk *vexpress_sp810_timerclken[4];
+static DEFINE_SPINLOCK(vexpress_sp810_lock);
+
+static void __init vexpress_sp810_init(void __iomem *base)
+{
+	int i;
+
+	if (WARN_ON(!base))
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(vexpress_sp810_timerclken); i++) {
+		char name[12];
+		const char *parents[] = {
+			"v2m:refclk32khz", /* REFCLK */
+			"v2m:refclk1mhz" /* TIMCLK */
+		};
+
+		snprintf(name, ARRAY_SIZE(name), "timerclken%d", i);
+
+		vexpress_sp810_timerclken[i] = clk_register_mux(NULL, name,
+				parents, 2, 0, base + SCCTRL,
+				SCCTRL_TIMERENnSEL_SHIFT(i), 1,
+				0, &vexpress_sp810_lock);
+
+		if (WARN_ON(IS_ERR(vexpress_sp810_timerclken[i])))
+			break;
+	}
+}
+
+static const char * const vexpress_clk_24mhz_periphs[] __initconst = {
+	"mb:mmci", "mb:kmi0", "mb:kmi1"
+};
+
+static const char * const vexpress_osc_clk1_periphs[] = {
+	"mb:clcd",
+	NULL
+};
+
+static struct vexpress_osc_info vexpress_osc_clk1_info = {
+	.clock_name	= "v2m:osc_clk1",
+	.rate_min	= 23750000,
+	.rate_max	= 63500000,
+	.dev_ids	= vexpress_osc_clk1_periphs,
+};
+
+static struct vexpress_config_device vexpress_osc1_device = {
+	.name		= "mb:osc1",
+	.func		= VEXPRESS_CONFIG_FUNC_OSC,
+	.addr		= { VEXPRESS_SITE_MB, 0, 0, 1 },
+	.dev.platform_data = &vexpress_osc_clk1_info,
+};
+
+static const char * const vexpress_osc_clk2_periphs[] __initconst = {
+	"mb:uart0", "mb:uart1", "mb:uart2", "mb:uart3"
+};
+
+void __init vexpress_clk_init(void __iomem *sp810_base)
+{
+	struct clk *clk;
+	int i;
+
+	clk = clk_register_fixed_rate(NULL, "dummy_apb_pclk", NULL,
+			CLK_IS_ROOT, 0);
+	WARN_ON(clk_register_clkdev(clk, "apb_pclk", NULL));
+
+	clk = clk_register_fixed_rate(NULL, "v2m:clk_24mhz", NULL,
+			CLK_IS_ROOT, 24000000);
+	for (i = 0; i < ARRAY_SIZE(vexpress_clk_24mhz_periphs); i++)
+		WARN_ON(clk_register_clkdev(clk, NULL,
+				vexpress_clk_24mhz_periphs[i]));
+
+	clk = clk_register_fixed_rate(NULL, "v2m:refclk32khz", NULL,
+			CLK_IS_ROOT, 32768);
+	WARN_ON(clk_register_clkdev(clk, NULL, "v2m:wdt"));
+
+	clk = clk_register_fixed_rate(NULL, "v2m:refclk1mhz", NULL,
+			CLK_IS_ROOT, 1000000);
+
+	vexpress_sp810_init(sp810_base);
+
+	for (i = 0; i < ARRAY_SIZE(vexpress_sp810_timerclken); i++)
+		WARN_ON(clk_set_parent(vexpress_sp810_timerclken[i], clk));
+
+	WARN_ON(clk_register_clkdev(vexpress_sp810_timerclken[0],
+				"v2m-timer0", "sp804"));
+	WARN_ON(clk_register_clkdev(vexpress_sp810_timerclken[1],
+				"v2m-timer1", "sp804"));
+
+	vexpress_config_device_register(&vexpress_osc1_device);
+
+	clk = clk_register_fixed_rate(NULL, "v2m:osc_clk2", NULL,
+			CLK_IS_ROOT, 24000000);
+	for (i = 0; i < ARRAY_SIZE(vexpress_osc_clk2_periphs); i++)
+		WARN_ON(clk_register_clkdev(clk, NULL,
+				vexpress_osc_clk2_periphs[i]));
+
+	vexpress_osc_driver_register();
+}
+
+#if defined(CONFIG_OF)
+
+struct clk *vexpress_sp810_of_get(struct of_phandle_args *clkspec, void *data)
+{
+	if (WARN_ON(clkspec->args_count != 1 || clkspec->args[0] >
+			ARRAY_SIZE(vexpress_sp810_timerclken)))
+		return NULL;
+
+	return vexpress_sp810_timerclken[clkspec->args[0]];
+}
+
+static const __initconst struct of_device_id vexpress_fixed_clk_match[] = {
+	{ .compatible = "fixed-clock", .data = of_fixed_clk_setup, },
+	{}
+};
+
+void __init vexpress_clk_of_init(void)
+{
+	struct device_node *node;
+	struct clk *refclk, *timclk;
+
+	of_clk_init(vexpress_fixed_clk_match);
+
+	node = of_find_compatible_node(NULL, NULL, "arm,sp810");
+	vexpress_sp810_init(of_iomap(node, 0));
+	of_clk_add_provider(node, vexpress_sp810_of_get, NULL);
+
+	/* Select better ("faster") parent */
+	refclk = of_clk_get_by_name(node, "refclk");
+	timclk = of_clk_get_by_name(node, "timclk");
+	if (!WARN_ON(IS_ERR(refclk) || IS_ERR(timclk))) {
+		struct clk *clk;
+		int i = 0;
+
+		if (clk_get_rate(refclk) > clk_get_rate(timclk))
+			clk = refclk;
+		else
+			clk = timclk;
+
+		for (i = 0; i < ARRAY_SIZE(vexpress_sp810_timerclken); i++)
+			WARN_ON(clk_set_parent(vexpress_sp810_timerclken[i],
+					clk));
+	}
+
+	WARN_ON(clk_register_clkdev(vexpress_sp810_timerclken[0],
+				"v2m-timer0", "sp804"));
+	WARN_ON(clk_register_clkdev(vexpress_sp810_timerclken[1],
+				"v2m-timer1", "sp804"));
+
+	vexpress_osc_driver_register();
+}
+
+#endif
diff --git a/include/linux/vexpress.h b/include/linux/vexpress.h
index 4768e6e..18f03d1 100644
--- a/include/linux/vexpress.h
+++ b/include/linux/vexpress.h
@@ -130,4 +130,8 @@ struct vexpress_osc_info {
 };
 int vexpress_osc_driver_register(void);
 
+/* Clocks */
+void vexpress_clk_init(void __iomem *sp810_base);
+void vexpress_clk_of_init(void);
+
 #endif
-- 
1.7.9.5
