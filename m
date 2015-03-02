From: rnayak@codeaurora.org (Rajendra Nayak)
Date: Mon,  2 Mar 2015 12:32:24 +0530
Subject: [PATCH 1/6] clk: qcom: Add support for GDSCs
In-Reply-To: <1425279749-16625-1-git-send-email-rnayak@codeaurora.org>
References: <1425279749-16625-1-git-send-email-rnayak@codeaurora.org>
Message-ID: <1425279749-16625-2-git-send-email-rnayak@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Boyd <sboyd@codeaurora.org>

GDSCs (Global Distributed Switch Controllers) are responsible for
safely collapsing and restoring power to peripherals in the SoC.
These are best modelled as power domains using genpd and given
the registers are scattered throughout the clock controller register
space, its best to have the support added through the clock driver.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 drivers/clk/qcom/Kconfig  |   5 ++
 drivers/clk/qcom/Makefile |   1 +
 drivers/clk/qcom/gdsc.c   | 130 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/qcom/gdsc.h   |  43 +++++++++++++++
 4 files changed, 179 insertions(+)
 create mode 100644 drivers/clk/qcom/gdsc.c
 create mode 100644 drivers/clk/qcom/gdsc.h

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 48d5151..f436bcf 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -38,6 +38,11 @@ config IPQ_LCC_806X
 	  Say Y if you want to use audio devices such as i2s, pcm,
 	  S/PDIF, etc.
 
+config QCOM_GDSC
+	bool
+	select PM_GENERIC_DOMAINS if PM
+	depends on COMMON_CLK_QCOM
+
 config MSM_GCC_8660
 	tristate "MSM8660 Global Clock Controller"
 	depends on COMMON_CLK_QCOM
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index 50b337a..fe62523 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -9,6 +9,7 @@ clk-qcom-y += clk-branch.o
 clk-qcom-y += clk-regmap-divider.o
 clk-qcom-y += clk-regmap-mux.o
 clk-qcom-y += reset.o
+clk-qcom-$(CONFIG_QCOM_GDSC) += gdsc.o
 
 obj-$(CONFIG_APQ_GCC_8084) += gcc-apq8084.o
 obj-$(CONFIG_APQ_MMCC_8084) += mmcc-apq8084.o
diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
new file mode 100644
index 0000000..c1dd762
--- /dev/null
+++ b/drivers/clk/qcom/gdsc.c
@@ -0,0 +1,130 @@
+/*
+ * Copyright (c) 2015, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/pm_domain.h>
+#include <linux/regmap.h>
+#include <linux/jiffies.h>
+#include <linux/export.h>
+
+#include "gdsc.h"
+
+#define PWR_ON_MASK		BIT(31)
+#define EN_REST_WAIT_MASK	(0xF << 20)
+#define EN_FEW_WAIT_MASK	(0xF << 16)
+#define CLK_DIS_WAIT_MASK	(0xF << 12)
+#define SW_OVERRIDE_MASK	BIT(2)
+#define HW_CONTROL_MASK		BIT(1)
+#define SW_COLLAPSE_MASK	BIT(0)
+
+/* Wait 2^n CXO cycles between all states. Here, n=2 (4 cycles). */
+#define EN_REST_WAIT_VAL	(0x2 << 20)
+#define EN_FEW_WAIT_VAL		(0x8 << 16)
+#define CLK_DIS_WAIT_VAL	(0x2 << 12)
+
+#define TIMEOUT_US		100
+
+static int gdsc_is_enabled(struct gdsc *sc)
+{
+	u32 val;
+
+	regmap_read(sc->regmap, sc->gdscr, &val);
+	return !!(val & PWR_ON_MASK);
+}
+
+static int gdsc_toggle_logic(struct gdsc *sc, bool en)
+{
+	int ret;
+	u32 val = en ? 0 : SW_COLLAPSE_MASK;
+	u32 check = en ? PWR_ON_MASK : 0;
+	unsigned long timeout;
+
+	ret = regmap_update_bits(sc->regmap, sc->gdscr, SW_COLLAPSE_MASK, val);
+	if (ret)
+		return ret;
+
+	timeout = jiffies + usecs_to_jiffies(TIMEOUT_US);
+	do {
+		regmap_read(sc->regmap, sc->gdscr, &val);
+		if ((val & PWR_ON_MASK) == check)
+			return 0;
+	} while (time_before(jiffies, timeout));
+	regmap_read(sc->regmap, sc->gdscr, &val);
+	if ((val & PWR_ON_MASK) == check)
+		return 0;
+
+	pr_err("%s %s timed out\n", en ? "enabling" : "disabling", sc->pd.name);
+	return -ETIMEDOUT;
+}
+
+static int gdsc_enable(struct generic_pm_domain *domain)
+{
+	struct gdsc *sc = domain_to_gdsc(domain);
+	int ret;
+
+	ret = gdsc_toggle_logic(sc, true);
+	if (ret)
+		return ret;
+	/*
+	 * If clocks to this power domain were already on, they will take an
+	 * additional 4 clock cycles to re-enable after the power domain is
+	 * enabled. Delay to account for this. A delay is also needed to ensure
+	 * clocks are not enabled within 400ns of enabling power to the
+	 * memories.
+	 */
+	udelay(1);
+
+	return 0;
+}
+
+static int gdsc_disable(struct generic_pm_domain *domain)
+{
+	struct gdsc *sc = domain_to_gdsc(domain);
+	int ret = 0;
+
+	ret = gdsc_toggle_logic(sc, false);
+	if (ret)
+		return ret;
+
+	return ret;
+}
+
+int gdsc_init(struct generic_pm_domain *domain, struct regmap *regmap)
+{
+	struct gdsc *sc = domain_to_gdsc(domain);
+	u32 mask;
+	u32 val;
+	int on;
+
+	sc->regmap = regmap;
+
+	/*
+	 * Disable HW trigger: collapse/restore occur based on registers writes.
+	 * Disable SW override: Use hardware state-machine for sequencing.
+	 * Configure wait time between states.
+	 */
+	mask = HW_CONTROL_MASK | SW_OVERRIDE_MASK |
+	       EN_REST_WAIT_MASK | EN_FEW_WAIT_MASK | CLK_DIS_WAIT_MASK;
+	val = EN_REST_WAIT_VAL | EN_FEW_WAIT_VAL | CLK_DIS_WAIT_VAL;
+	regmap_update_bits(sc->regmap, sc->gdscr, mask, val);
+
+	on = gdsc_is_enabled(sc);
+
+	pm_genpd_init(&sc->pd, NULL, !on);
+	sc->pd.power_off = gdsc_disable;
+	sc->pd.power_on = gdsc_enable;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(gdsc_init);
diff --git a/drivers/clk/qcom/gdsc.h b/drivers/clk/qcom/gdsc.h
new file mode 100644
index 0000000..82a26d9
--- /dev/null
+++ b/drivers/clk/qcom/gdsc.h
@@ -0,0 +1,43 @@
+/*
+ * Copyright (c) 2015, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __QCOM_GDSC_H__
+#define __QCOM_GDSC_H__
+
+#include <linux/pm_domain.h>
+
+struct regmap;
+
+/**
+ * struct gdsc - Globally Distributed Switch Controller
+ * pd: power domain
+ * @regmap: regmap for MMIO accesses
+ * @gdscr: gsdc control register
+ */
+struct gdsc {
+	struct generic_pm_domain	pd;
+	struct regmap			*regmap;
+	unsigned int			gdscr;
+};
+
+#define domain_to_gdsc(domain) container_of(domain, struct gdsc, pd)
+
+#ifdef CONFIG_QCOM_GDSC
+int gdsc_init(struct generic_pm_domain *domain, struct regmap *regmap);
+#else
+int gdsc_init(struct generic_pm_domain *domain, struct regmap *regmap)
+{
+	return 0;
+}
+#endif /* CONFIG_QCOM_GDSC */
+#endif /* __QCOM_GDSC_H__ */
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
