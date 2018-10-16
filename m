From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Tue, 16 Oct 2018 16:21:47 +0200
Subject: [PATCH v2 09/22] clk: at91: add new DT lookup function
In-Reply-To: <20181016142200.19741-1-alexandre.belloni@bootlin.com>
References: <20181016142200.19741-1-alexandre.belloni@bootlin.com>
Message-ID: <20181016142200.19741-10-alexandre.belloni@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a new DT lookup function to lookup for PMC clocks.

Note that the #ifndef AT91_PMC_MOSCS section will be removed once all the
platforms are converted.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 drivers/clk/at91/pmc.c           | 34 ++++++++++++++++++++++++++++++++
 include/dt-bindings/clock/at91.h | 15 ++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/drivers/clk/at91/pmc.c b/drivers/clk/at91/pmc.c
index 0f8b3add1b04..db24539d5740 100644
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
+		if (idx < pmc_data->ncore)
+			return pmc_data->chws[idx];
+		break;
+	case PMC_TYPE_SYSTEM:
+		if (idx < pmc_data->nsystem)
+			return pmc_data->shws[idx];
+		break;
+	case PMC_TYPE_PERIPHERAL:
+		if (idx < pmc_data->nperiph)
+			return pmc_data->phws[idx];
+		break;
+	case PMC_TYPE_GCK:
+		if (idx < pmc_data->ngck)
+			return pmc_data->ghws[idx];
+		break;
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
index ab3ee241d10c..ed30da28d820 100644
--- a/include/dt-bindings/clock/at91.h
+++ b/include/dt-bindings/clock/at91.h
@@ -9,6 +9,20 @@
 #ifndef _DT_BINDINGS_CLK_AT91_H
 #define _DT_BINDINGS_CLK_AT91_H
 
+#define PMC_TYPE_CORE		0
+#define PMC_TYPE_SYSTEM		1
+#define PMC_TYPE_PERIPHERAL	2
+#define PMC_TYPE_GCK		3
+
+#define PMC_SLOW		0
+#define PMC_MCK			1
+#define PMC_UTMI		2
+#define PMC_MAIN		3
+#define PMC_MCK2		4
+#define PMC_I2S0_MUX		5
+#define PMC_I2S1_MUX		6
+
+#ifndef AT91_PMC_MOSCS
 #define AT91_PMC_MOSCS		0		/* MOSCS Flag */
 #define AT91_PMC_LOCKA		1		/* PLLA Lock */
 #define AT91_PMC_LOCKB		2		/* PLLB Lock */
@@ -19,5 +33,6 @@
 #define AT91_PMC_MOSCRCS	17		/* Main On-Chip RC */
 #define AT91_PMC_CFDEV		18		/* Clock Failure Detector Event */
 #define AT91_PMC_GCKRDY		24		/* Generated Clocks */
+#endif
 
 #endif
-- 
2.19.1
