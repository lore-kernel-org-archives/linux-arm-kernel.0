From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Wed, 18 Jul 2018 00:27:50 +0200
Subject: [PATCH 09/16] clk: at91: add new DT lookup function
In-Reply-To: <20180717222757.10253-1-alexandre.belloni@bootlin.com>
References: <20180717222757.10253-1-alexandre.belloni@bootlin.com>
Message-ID: <20180717222757.10253-10-alexandre.belloni@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a new DT lookup function to lookup for PMC clocks.

Note that the #ifndef AT91_PMC_MOSCS section will be removed once all the
platforms are converted.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/clk/at91/pmc.c           | 34 ++++++++++++++++++++++++++++++++
 include/dt-bindings/clock/at91.h | 14 +++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/drivers/clk/at91/pmc.c b/drivers/clk/at91/pmc.c
index 0f8b3add1b04..f5697092ec52 100644
--- a/drivers/clk/at91/pmc.c
+++ b/drivers/clk/at91/pmc.c
@@ -19,6 +19,8 @@
 
 #include <asm/proc-fns.h>
 
+#include <dt-bindings/clock/at91.h>
+
 #include "pmc.h"
 
 #define PMC_MAX_IDS 128
@@ -47,6 +49,38 @@ int of_at91_get_clk_range(struct device_node *np, const char *propname,
 }
 EXPORT_SYMBOL_GPL(of_at91_get_clk_range);
 
+struct clk_hw *of_clk_hw_pmc_get(struct of_phandle_args *clkspec, void *data)
+{
+	unsigned int type = clkspec->args[0];
+	unsigned int idx = clkspec->args[1];
+	struct pmc_data *pmc_data = data;
+
+	switch (type) {
+	case PMC_TYPE_CORE:
+		if (idx >= pmc_data->ncore)
+			return ERR_PTR(-EINVAL);
+		return pmc_data->chws[idx];
+	case PMC_TYPE_SYSTEM:
+		if (idx >= pmc_data->nsystem)
+			return ERR_PTR(-EINVAL);
+		return pmc_data->shws[idx];
+	case PMC_TYPE_PERIPHERAL:
+		if (idx >= pmc_data->nperiph)
+			return ERR_PTR(-EINVAL);
+		return pmc_data->phws[idx];
+	case PMC_TYPE_GCK:
+		if (idx >= pmc_data->ngck)
+			return ERR_PTR(-EINVAL);
+		return pmc_data->ghws[idx];
+	default:
+		break;
+	}
+
+	pr_err("%s: invalid type (%u) or index (%u)\n", __func__, type, idx);
+
+	return ERR_PTR(-EINVAL);
+}
+
 void pmc_data_free(struct pmc_data *pmc_data)
 {
 	kfree(pmc_data->chws);
diff --git a/include/dt-bindings/clock/at91.h b/include/dt-bindings/clock/at91.h
index ab3ee241d10c..c007adcb5512 100644
--- a/include/dt-bindings/clock/at91.h
+++ b/include/dt-bindings/clock/at91.h
@@ -9,6 +9,19 @@
 #ifndef _DT_BINDINGS_CLK_AT91_H
 #define _DT_BINDINGS_CLK_AT91_H
 
+#define PMC_TYPE_CORE		0
+#define PMC_TYPE_SYSTEM		1
+#define PMC_TYPE_PERIPHERAL	2
+#define PMC_TYPE_GCK		3
+
+#define PMC_MCK			0
+#define PMC_UTMI		1
+#define PMC_MCK2		2
+#define PMC_MAIN		3
+#define PMC_I2S0_MUX		4
+#define PMC_I2S1_MUX		5
+
+#ifndef AT91_PMC_MOSCS
 #define AT91_PMC_MOSCS		0		/* MOSCS Flag */
 #define AT91_PMC_LOCKA		1		/* PLLA Lock */
 #define AT91_PMC_LOCKB		2		/* PLLB Lock */
@@ -19,5 +32,6 @@
 #define AT91_PMC_MOSCRCS	17		/* Main On-Chip RC */
 #define AT91_PMC_CFDEV		18		/* Clock Failure Detector Event */
 #define AT91_PMC_GCKRDY		24		/* Generated Clocks */
+#endif
 
 #endif
-- 
2.18.0
