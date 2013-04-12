From: t.figa@samsung.com (Tomasz Figa)
Date: Fri, 12 Apr 2013 21:17:19 +0200
Subject: [PATCH v5 03/14] clocksource: samsung-pwm: Add infrastructure to share
 PWM hardware
In-Reply-To: <1365794250-14436-1-git-send-email-t.figa@samsung.com>
References: <1365794250-14436-1-git-send-email-t.figa@samsung.com>
Message-ID: <1365794250-14436-4-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch extends samsung PWM clocksource driver with infrastructure
that allows sharing of PWM hardware between clocksource and PWM drivers.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 .../devicetree/bindings/pwm/pwm-samsung.txt        |  43 ++++
 drivers/clocksource/samsung_pwm.c                  | 250 +++++++++++++++++++++
 include/clocksource/samsung_pwm.h                  |  44 ++++
 3 files changed, 337 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-samsung.txt
 create mode 100644 include/clocksource/samsung_pwm.h

diff --git a/Documentation/devicetree/bindings/pwm/pwm-samsung.txt b/Documentation/devicetree/bindings/pwm/pwm-samsung.txt
new file mode 100644
index 0000000..cc17c4c
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-samsung.txt
@@ -0,0 +1,43 @@
+* Samsung PWM timers
+
+Samsung SoCs contain PWM timer blocks which can be used for system clock source
+and clock event timers, as well as to drive SoC outputs with PWM signal. Each
+PWM timer block provides 5 PWM channels (not all of them can drive physical
+outputs - see SoC and board manual).
+
+Be aware that the clocksource driver supports only uniprocessor systems.
+
+Required properties:
+- compatible : should be one of following:
+    samsung,s3c2410-pwm - for 16-bit timers present on S3C24xx SoCs
+    samsung,s3c6400-pwm - for 32-bit timers present on S3C64xx SoCs
+    samsung,s5p6440-pwm - for 32-bit timers present on S5P64x0 SoCs
+    samsung,s5pc100-pwm - for 32-bit timers present on S5PC100, S5PV210,
+			  Exynos4210 rev0 SoCs
+    samsung,exynos4210-pwm - for 32-bit timers present on Exynos4210,
+                          Exynos4x12 and Exynos5250 SoCs
+- reg: base address and size of register area
+- interrupts: list of timer interrupts (one interrupt per timer, starting at
+  timer 0)
+- #pwm-cells: number of cells used for PWM specifier - must be 4
+   the specifier format is as follows:
+     - phandle to PWM controller node
+     - index of PWM channel (from 0 to 4)
+     - PWM signal period in nanoseconds
+     - bitmask of PWM flags:
+        0x1 - invert PWM signal
+
+Optional properties:
+- samsung,pwm-outputs: list of PWM channels used as PWM outputs on particular
+    platform - an array of up to 5 elements being indices of PWM channels
+    (from 0 to 4), the order does not matter.
+
+Example:
+	pwm at 7f006000 {
+		compatible = "samsung,s3c6400-pwm";
+		reg = <0x7f006000 0x1000>;
+		interrupt-parent = <&vic0>;
+		interrupts = <23>, <24>, <25>, <27>, <28>;
+		samsung,pwm-outputs = <0>, <1>;
+		#pwm-cells = <2>;
+	}
diff --git a/drivers/clocksource/samsung_pwm.c b/drivers/clocksource/samsung_pwm.c
index 974675b..7bbd55c 100644
--- a/drivers/clocksource/samsung_pwm.c
+++ b/drivers/clocksource/samsung_pwm.c
@@ -14,7 +14,15 @@
 #include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/clockchips.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
 #include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include <clocksource/samsung_pwm.h>
 
 #include <asm/smp_twd.h>
 #include <asm/mach/time.h>
@@ -27,6 +35,248 @@
 #include <plat/regs-timer.h>
 #include <plat/samsung-time.h>
 
+/*
+ * PWM master driver
+ */
+
+struct samsung_pwm_drvdata {
+	struct samsung_pwm pwm;
+	struct platform_device *pdev;
+	struct device_node *of_node;
+	struct resource resource;
+	struct list_head list;
+};
+
+static LIST_HEAD(pwm_list);
+
+#ifdef CONFIG_OF
+static int samsung_pwm_parse_dt(struct samsung_pwm_drvdata *drvdata)
+{
+	struct samsung_pwm *pwm = &drvdata->pwm;
+	struct samsung_pwm_variant *variant = &pwm->variant;
+	struct device_node *np = drvdata->of_node;
+	struct property *prop;
+	const __be32 *cur;
+	u32 val;
+	int i;
+
+	for (i = 0; i < SAMSUNG_PWM_NUM; ++i)
+		pwm->irq[i] = irq_of_parse_and_map(np, i);
+
+	of_property_for_each_u32(np, "samsung,pwm-outputs", prop, cur, val) {
+		if (val >= SAMSUNG_PWM_NUM) {
+			pr_warning("%s: invalid channel index in samsung,pwm-outputs property\n",
+								__func__);
+			continue;
+		}
+		variant->output_mask |= 1 << val;
+	}
+
+	return 0;
+}
+
+static const struct samsung_pwm_variant s3c24xx_variant = {
+	.bits		= 16,
+	.div_base	= 1,
+	.has_tint_cstat	= false,
+	.tclk_mask	= (1 << 4),
+};
+
+static const struct samsung_pwm_variant s3c64xx_variant = {
+	.bits		= 32,
+	.div_base	= 0,
+	.has_tint_cstat	= true,
+	.tclk_mask	= (1 << 7) | (1 << 6) | (1 << 5),
+};
+
+static const struct samsung_pwm_variant s5p64x0_variant = {
+	.bits		= 32,
+	.div_base	= 0,
+	.has_tint_cstat	= true,
+	.tclk_mask	= 0,
+};
+
+static const struct samsung_pwm_variant s5p_variant = {
+	.bits		= 32,
+	.div_base	= 0,
+	.has_tint_cstat	= true,
+	.tclk_mask	= (1 << 5),
+};
+
+static const struct of_device_id samsung_pwm_matches[] = {
+	{ .compatible = "samsung,s3c2410-pwm", .data = &s3c24xx_variant, },
+	{ .compatible = "samsung,s3c6400-pwm", .data = &s3c64xx_variant, },
+	{ .compatible = "samsung,s5p6440-pwm", .data = &s5p64x0_variant, },
+	{ .compatible = "samsung,s5pc100-pwm", .data = &s5p_variant, },
+	{ .compatible = "samsung,exynos4210-pwm", .data = &s5p_variant, },
+	{},
+};
+
+static struct samsung_pwm_drvdata *samsung_pwm_alloc(
+		struct platform_device *pdev, struct device_node *of_node,
+		const struct samsung_pwm_variant *variant)
+{
+	struct samsung_pwm_drvdata *drvdata;
+
+	drvdata = kzalloc(sizeof(*drvdata), GFP_KERNEL);
+	if (!drvdata)
+		return NULL;
+
+	memcpy(&drvdata->pwm.variant, variant, sizeof(drvdata->pwm.variant));
+
+	spin_lock_init(&drvdata->pwm.slock);
+
+	drvdata->pdev = pdev;
+	drvdata->of_node = of_node;
+
+	return drvdata;
+}
+
+static struct samsung_pwm_drvdata *samsung_pwm_of_add(struct device_node *np)
+{
+	const struct samsung_pwm_variant *variant;
+	const struct of_device_id *match;
+	struct samsung_pwm_drvdata *pwm;
+	int ret;
+
+	if (!np) {
+		np = of_find_matching_node(NULL, samsung_pwm_matches);
+		if (!np) {
+			pr_err("%s: could not find PWM device\n", __func__);
+			return ERR_PTR(-ENODEV);
+		}
+	}
+
+	match = of_match_node(samsung_pwm_matches, np);
+	if (!match) {
+		pr_err("%s: failed to match given OF node\n", __func__);
+		return ERR_PTR(-EINVAL);
+	}
+	variant = match->data;
+
+	pwm = samsung_pwm_alloc(NULL, np, variant);
+	if (!pwm) {
+		pr_err("%s: could not allocate PWM device struct\n", __func__);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	ret = of_address_to_resource(np, 0, &pwm->resource);
+	if (ret < 0) {
+		pr_err("%s: could not get IO resource\n", __func__);
+		goto err_free;
+	}
+
+	ret = samsung_pwm_parse_dt(pwm);
+	if (ret < 0) {
+		pr_err("%s: failed to parse device tree node\n", __func__);
+		goto err_free;
+	}
+
+	list_add_tail(&pwm->list, &pwm_list);
+
+	return pwm;
+
+err_free:
+	kfree(pwm);
+
+	return ERR_PTR(ret);
+}
+#else
+static struct samsung_pwm_drvdata *samsung_pwm_of_add(struct device_node *np)
+{
+	return ERR_PTR(-ENODEV);
+}
+#endif
+
+static struct samsung_pwm_drvdata *samsung_pwm_add(struct platform_device *pdev)
+{
+	struct samsung_pwm_variant *variant = pdev->dev.platform_data;
+	struct samsung_pwm_drvdata *pwm;
+	struct resource *res;
+	int i;
+
+	if (!variant) {
+		pr_err("%s: no platform data specified\n", __func__);
+		return ERR_PTR(-EINVAL);
+	}
+
+	pwm = samsung_pwm_alloc(pdev, pdev->dev.of_node, variant);
+	if (!pwm) {
+		pr_err("%s: could not allocate PWM device struct\n", __func__);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		pr_err("%s: could not get IO resource\n", __func__);
+		kfree(pwm);
+		return ERR_PTR(-EINVAL);
+	}
+	pwm->resource = *res;
+
+	for (i = 0; i < SAMSUNG_PWM_NUM; ++i)
+		pwm->pwm.irq[i] = platform_get_irq(pdev, i);
+
+	list_add_tail(&pwm->list, &pwm_list);
+
+	return pwm;
+}
+
+static struct samsung_pwm_drvdata *samsung_pwm_find(
+			struct platform_device *pdev, struct device_node *np)
+{
+	struct samsung_pwm_drvdata *pwm;
+
+	if (pdev)
+		np = pdev->dev.of_node;
+
+	list_for_each_entry(pwm, &pwm_list, list)
+		if ((np && pwm->of_node == np) || !pdev || pwm->pdev == pdev)
+			return pwm;
+
+	if (pdev && !np)
+		return samsung_pwm_add(pdev);
+
+	return samsung_pwm_of_add(np);
+}
+
+struct samsung_pwm *samsung_pwm_get(struct platform_device *pdev,
+						struct device_node *of_node)
+{
+	struct samsung_pwm_drvdata *pwm;
+	struct resource *res;
+
+	pwm = samsung_pwm_find(pdev, of_node);
+	if (IS_ERR(pwm)) {
+		pr_err("%s: failed to instantiate PWM device\n", __func__);
+		return &pwm->pwm;
+	}
+
+	if (pwm->pwm.base)
+		return &pwm->pwm;
+
+	res = request_mem_region(pwm->resource.start,
+				resource_size(&pwm->resource), "samsung-pwm");
+	if (!res) {
+		pr_err("%s: failed to request IO mem region\n", __func__);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	pwm->pwm.base = ioremap(res->start, resource_size(res));
+	if (!pwm->pwm.base) {
+		pr_err("%s: failed to map PWM registers\n", __func__);
+		release_mem_region(res->start, resource_size(res));
+		return ERR_PTR(-ENOMEM);
+	}
+
+	return &pwm->pwm;
+}
+EXPORT_SYMBOL(samsung_pwm_get);
+
+/*
+ * Clocksource driver
+ */
+
 struct samsung_timer_source {
 	unsigned int event_id;
 	unsigned int source_id;
diff --git a/include/clocksource/samsung_pwm.h b/include/clocksource/samsung_pwm.h
new file mode 100644
index 0000000..d16415f
--- /dev/null
+++ b/include/clocksource/samsung_pwm.h
@@ -0,0 +1,44 @@
+/*
+ * Copyright (C) 2013 Samsung Electronics Co., Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#ifndef __CLOCKSOURCE_SAMSUNG_PWM_H
+#define __CLOCKSOURCE_SAMSUNG_PWM_H
+
+#include <linux/spinlock.h>
+
+#define SAMSUNG_PWM_NUM		5
+
+struct platform_device;
+struct device_node;
+
+struct samsung_pwm_variant {
+	u8 bits;
+	u8 div_base;
+	u8 tclk_mask;
+	u8 output_mask;
+	bool has_tint_cstat;
+};
+
+struct samsung_pwm {
+	struct samsung_pwm_variant variant;
+	spinlock_t slock;
+	void __iomem *base;
+	int irq[SAMSUNG_PWM_NUM];
+};
+
+extern struct samsung_pwm *samsung_pwm_get(struct platform_device *,
+							struct device_node *);
+
+#endif /* __CLOCKSOURCE_SAMSUNG_PWM_H */
-- 
1.8.1.5
