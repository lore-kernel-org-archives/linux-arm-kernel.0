From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 20 Nov 2012 19:54:56 +0100
Subject: [PATCH v2] clk: move IM-PD1 clocks to drivers/clk
Message-ID: <1353437696-23285-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARM IM-PD1 add-on module has a few clock of its own, let's
move also these down to the drivers/clk/versatile driver dir
and get rid of any remaining oldschool Integrator clocks.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2: add GPL header.
---
 arch/arm/mach-integrator/impd1.c             |  68 +-----------------
 drivers/clk/versatile/Makefile               |   1 +
 drivers/clk/versatile/clk-impd1.c            | 104 +++++++++++++++++++++++++++
 drivers/clk/versatile/clk-integrator.c       |   3 +-
 include/linux/platform_data/clk-integrator.h |   1 +
 5 files changed, 110 insertions(+), 67 deletions(-)
 create mode 100644 drivers/clk/versatile/clk-impd1.c

diff --git a/arch/arm/mach-integrator/impd1.c b/arch/arm/mach-integrator/impd1.c
index e428f3a..1ddfb38 100644
--- a/arch/arm/mach-integrator/impd1.c
+++ b/arch/arm/mach-integrator/impd1.c
@@ -21,10 +21,9 @@
 #include <linux/amba/bus.h>
 #include <linux/amba/clcd.h>
 #include <linux/io.h>
+#include <linux/platform_data/clk-integrator.h>
 #include <linux/slab.h>
-#include <linux/clkdev.h>
 
-#include <asm/hardware/icst.h>
 #include <mach/lm.h>
 #include <mach/impd1.h>
 #include <asm/sizes.h>
@@ -36,45 +35,6 @@ MODULE_PARM_DESC(lmid, "logic module stack position");
 
 struct impd1_module {
 	void __iomem	*base;
-	struct clk	vcos[2];
-	struct clk_lookup *clks[3];
-};
-
-static const struct icst_params impd1_vco_params = {
-	.ref		= 24000000,	/* 24 MHz */
-	.vco_max	= ICST525_VCO_MAX_3V,
-	.vco_min	= ICST525_VCO_MIN,
-	.vd_min		= 12,
-	.vd_max		= 519,
-	.rd_min		= 3,
-	.rd_max		= 120,
-	.s2div		= icst525_s2div,
-	.idx2s		= icst525_idx2s,
-};
-
-static void impd1_setvco(struct clk *clk, struct icst_vco vco)
-{
-	struct impd1_module *impd1 = clk->data;
-	u32 val = vco.v | (vco.r << 9) | (vco.s << 16);
-
-	writel(0xa05f, impd1->base + IMPD1_LOCK);
-	writel(val, clk->vcoreg);
-	writel(0, impd1->base + IMPD1_LOCK);
-
-#ifdef DEBUG
-	vco.v = val & 0x1ff;
-	vco.r = (val >> 9) & 0x7f;
-	vco.s = (val >> 16) & 7;
-
-	pr_debug("IM-PD1: VCO%d clock is %ld Hz\n",
-		 vconr, icst525_hz(&impd1_vco_params, vco));
-#endif
-}
-
-static const struct clk_ops impd1_clk_ops = {
-	.round	= icst_clk_round,
-	.set	= icst_clk_set,
-	.setvco	= impd1_setvco,
 };
 
 void impd1_tweak_control(struct device *dev, u32 mask, u32 val)
@@ -344,10 +304,6 @@ static struct impd1_device impd1_devs[] = {
 	}
 };
 
-static struct clk fixed_14745600 = {
-	.rate = 14745600,
-};
-
 static int impd1_probe(struct lm_device *dev)
 {
 	struct impd1_module *impd1;
@@ -376,23 +332,7 @@ static int impd1_probe(struct lm_device *dev)
 	printk("IM-PD1 found at 0x%08lx\n",
 		(unsigned long)dev->resource.start);
 
-	for (i = 0; i < ARRAY_SIZE(impd1->vcos); i++) {
-		impd1->vcos[i].ops = &impd1_clk_ops,
-		impd1->vcos[i].owner = THIS_MODULE,
-		impd1->vcos[i].params = &impd1_vco_params,
-		impd1->vcos[i].data = impd1;
-	}
-	impd1->vcos[0].vcoreg = impd1->base + IMPD1_OSC1;
-	impd1->vcos[1].vcoreg = impd1->base + IMPD1_OSC2;
-
-	impd1->clks[0] = clkdev_alloc(&impd1->vcos[0], NULL, "lm%x:01000",
-					dev->id);
-	impd1->clks[1] = clkdev_alloc(&fixed_14745600, NULL, "lm%x:00100",
-					dev->id);
-	impd1->clks[2] = clkdev_alloc(&fixed_14745600, NULL, "lm%x:00200",
-					dev->id);
-	for (i = 0; i < ARRAY_SIZE(impd1->clks); i++)
-		clkdev_add(impd1->clks[i]);
+	integrator_impd1_clk_init(impd1->base, dev->id);
 
 	for (i = 0; i < ARRAY_SIZE(impd1_devs); i++) {
 		struct impd1_device *idev = impd1_devs + i;
@@ -431,13 +371,9 @@ static int impd1_remove_one(struct device *dev, void *data)
 static void impd1_remove(struct lm_device *dev)
 {
 	struct impd1_module *impd1 = lm_get_drvdata(dev);
-	int i;
 
 	device_for_each_child(&dev->dev, NULL, impd1_remove_one);
 
-	for (i = 0; i < ARRAY_SIZE(impd1->clks); i++)
-		clkdev_drop(impd1->clks[i]);
-
 	lm_set_drvdata(dev, NULL);
 
 	iounmap(impd1->base);
diff --git a/drivers/clk/versatile/Makefile b/drivers/clk/versatile/Makefile
index c0a0f64..884e362 100644
--- a/drivers/clk/versatile/Makefile
+++ b/drivers/clk/versatile/Makefile
@@ -1,4 +1,5 @@
 # Makefile for Versatile-specific clocks
 obj-$(CONFIG_ICST)		+= clk-icst.o
 obj-$(CONFIG_ARCH_INTEGRATOR)	+= clk-integrator.o
+obj-$(CONFIG_INTEGRATOR_IMPD1)	+= clk-impd1.o
 obj-$(CONFIG_ARCH_REALVIEW)	+= clk-realview.o
diff --git a/drivers/clk/versatile/clk-impd1.c b/drivers/clk/versatile/clk-impd1.c
new file mode 100644
index 0000000..fd9113c
--- /dev/null
+++ b/drivers/clk/versatile/clk-impd1.c
@@ -0,0 +1,104 @@
+/*
+ * Clock driver for the ARM Integrator/IM-PD1 board
+ * Copyright (C) 2012 Linus Walleij
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/clk-provider.h>
+#include <linux/clk.h>
+#include <linux/clkdev.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/platform_data/clk-integrator.h>
+
+#include <mach/impd1.h>
+
+#include "clk-icst.h"
+
+static void __iomem *impd1_base;
+
+/*
+ * There are two VCO's on the IM-PD1 but only one is used by the
+ * kernel, that is why we are only implementing the control of
+ * IMPD1_OSC1 here.
+ */
+
+/**
+ * cp_auxvco_get() - get ICST VCO settings for the Integrator/IM-PD1
+ * @vco: ICST VCO parameters to update with hardware status
+ */
+static struct icst_vco impd1_vco_get(void)
+{
+	u32 val;
+	struct icst_vco vco;
+
+	val = readl(impd1_base + IMPD1_OSC1);
+	vco.v = val & 0x1ff;
+	vco.r = (val >> 9) & 0x7f;
+	vco.s = (val >> 16) & 03;
+	return vco;
+}
+
+/**
+ * impd1_vco_set() - commit changes to Integrator/IM-PD1 ICST VCO
+ * @vco: ICST VCO parameters to commit
+ */
+static void impd1_vco_set(struct icst_vco vco)
+{
+	u32 val;
+
+	val = readl(impd1_base + IMPD1_OSC1) & ~0x7ffff;
+	val |= vco.v | (vco.r << 9) | (vco.s << 16);
+
+	/* This magic unlocks the IM-PD1 VCO so it can be controlled */
+	writel(0xa05f, impd1_base + IMPD1_LOCK);
+	writel(val, impd1_base + IMPD1_OSC1);
+	/* This locks the IM-PD1 again */
+	writel(0, impd1_base + IMPD1_LOCK);
+}
+
+static const struct icst_params impd1_vco_params = {
+	.ref		= 24000000,	/* 24 MHz */
+	.vco_max	= ICST525_VCO_MAX_3V,
+	.vco_min	= ICST525_VCO_MIN,
+	.vd_min		= 12,
+	.vd_max		= 519,
+	.rd_min		= 3,
+	.rd_max		= 120,
+	.s2div		= icst525_s2div,
+	.idx2s		= icst525_idx2s,
+};
+
+static const struct clk_icst_desc __initdata impd1_icst_desc = {
+	.params = &impd1_vco_params,
+	.getvco = impd1_vco_get,
+	.setvco = impd1_vco_set,
+};
+
+static struct clk_lookup *clks[3];
+
+/*
+ * integrator_clk_init() - set up the integrator clock tree
+ * @is_cp: pass true if it's the Integrator/CP else AP is assumed
+ */
+void __init integrator_impd1_clk_init(void __iomem *base, unsigned int id)
+{
+	struct clk *clk;
+	int i;
+
+	impd1_base = base;
+
+	clk = icst_clk_register(NULL, &impd1_icst_desc);
+	clks[0] = clkdev_alloc(clk, NULL, "lm%x:01000", id);
+
+	/* UART reference clock */
+	clk = clk_register_fixed_rate(NULL, "uartclk", NULL, CLK_IS_ROOT,
+				14745600);
+	clks[1] = clkdev_alloc(clk, NULL, "lm%x:00100", id);
+	clks[2] = clkdev_alloc(clk, NULL, "lm%x:00200", id);
+
+	for (i = 0; i < ARRAY_SIZE(clks); i++)
+		clkdev_add(clks[i]);
+}
diff --git a/drivers/clk/versatile/clk-integrator.c b/drivers/clk/versatile/clk-integrator.c
index a505392..5aa6ab9 100644
--- a/drivers/clk/versatile/clk-integrator.c
+++ b/drivers/clk/versatile/clk-integrator.c
@@ -1,8 +1,9 @@
+#include <linux/clk-provider.h>
 #include <linux/clk.h>
 #include <linux/clkdev.h>
 #include <linux/err.h>
 #include <linux/io.h>
-#include <linux/clk-provider.h>
+#include <linux/platform_data/clk-integrator.h>
 
 #include <mach/hardware.h>
 #include <mach/platform.h>
diff --git a/include/linux/platform_data/clk-integrator.h b/include/linux/platform_data/clk-integrator.h
index 83fe9c2..a8a704d 100644
--- a/include/linux/platform_data/clk-integrator.h
+++ b/include/linux/platform_data/clk-integrator.h
@@ -1 +1,2 @@
 void integrator_clk_init(bool is_cp);
+void integrator_impd1_clk_init(void __iomem *base, unsigned int id);
-- 
1.7.11.7
