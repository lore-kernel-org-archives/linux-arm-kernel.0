From: ludovic.desroches@microchip.com (Ludovic Desroches)
Date: Mon, 4 Sep 2017 11:52:26 +0200
Subject: [PATCH v2] clk: at91: utmi: set the mainck rate
Message-ID: <20170904095226.29336-1-ludovic.desroches@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

By default, it is assumed that the UTMI clock is generated from a 12 MHz
reference clock (MAINCK). If it's not the case, the FREQ field of the
SFR_UTMICKTRIM has to be updated to generate the UTMI clock in the
proper way.

The UTMI clock has a fixed rate of 480 MHz. In fact, there is no
multiplier we can configure. The multiplier is managed internally,
depending on the reference clock frequency, to achieve the target of
480 MHz.

Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
---

Hi,

I have put back the configuration of the SFR register in the prepare function
as suggested by Boris.

Ingo, can you give a try to this patch? Thanks.

Changes:
- v2: move SFR configuration to prepare function

 drivers/clk/at91/clk-utmi.c  | 82 ++++++++++++++++++++++++++++++++++++--------
 include/soc/at91/atmel-sfr.h |  2 ++
 2 files changed, 70 insertions(+), 14 deletions(-)

diff --git a/drivers/clk/at91/clk-utmi.c b/drivers/clk/at91/clk-utmi.c
index aadabd9d1e2b..dcf68b475a4f 100644
--- a/drivers/clk/at91/clk-utmi.c
+++ b/drivers/clk/at91/clk-utmi.c
@@ -14,14 +14,20 @@
 #include <linux/of.h>
 #include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
+#include <soc/at91/atmel-sfr.h>
 
 #include "pmc.h"
 
-#define UTMI_FIXED_MUL		40
+/*
+ * The purpose of this clock is to generate a 480 MHz signal. A different
+ * rate can't be configured.
+ */
+#define UTMI_RATE	480000000
 
 struct clk_utmi {
 	struct clk_hw hw;
-	struct regmap *regmap;
+	struct regmap *regmap_pmc;
+	struct regmap *regmap_sfr;
 };
 
 #define to_clk_utmi(hw) container_of(hw, struct clk_utmi, hw)
@@ -37,13 +43,54 @@ static inline bool clk_utmi_ready(struct regmap *regmap)
 
 static int clk_utmi_prepare(struct clk_hw *hw)
 {
+	struct clk_hw *hw_parent;
 	struct clk_utmi *utmi = to_clk_utmi(hw);
 	unsigned int uckr = AT91_PMC_UPLLEN | AT91_PMC_UPLLCOUNT |
 			    AT91_PMC_BIASEN;
+	unsigned int utmi_ref_clk_freq;
+	unsigned long parent_rate;
+
+	/*
+	 * If mainck rate is different from 12 MHz, we have to configure the
+	 * FREQ field of the SFR_UTMICKTRIM register to generate properly
+	 * the utmi clock.
+	 */
+	hw_parent = clk_hw_get_parent(hw);
+	parent_rate = clk_hw_get_rate(hw_parent);
+
+	switch (parent_rate) {
+	case 12000000:
+		utmi_ref_clk_freq = 0;
+		break;
+	case 16000000:
+		utmi_ref_clk_freq = 1;
+		break;
+	case 24000000:
+		utmi_ref_clk_freq = 2;
+		break;
+	/*
+	 * Not supported on SAMA5D2 but it's not an issue since MAINCK
+	 * maximum value is 24 MHz.
+	 */
+	case 48000000:
+		utmi_ref_clk_freq = 3;
+		break;
+	default:
+		pr_err("UTMICK: unsupported mainck rate\n");
+		return -EINVAL;
+	}
 
-	regmap_update_bits(utmi->regmap, AT91_CKGR_UCKR, uckr, uckr);
+	if (utmi->regmap_sfr) {
+		regmap_update_bits(utmi->regmap_sfr, AT91_SFR_UTMICKTRIM,
+				   AT91_UTMICKTRIM_FREQ, utmi_ref_clk_freq);
+	} else if (utmi_ref_clk_freq) {
+		pr_err("UTMICK: sfr node required\n");
+		return -EINVAL;
+	}
+
+	regmap_update_bits(utmi->regmap_pmc, AT91_CKGR_UCKR, uckr, uckr);
 
-	while (!clk_utmi_ready(utmi->regmap))
+	while (!clk_utmi_ready(utmi->regmap_pmc))
 		cpu_relax();
 
 	return 0;
@@ -53,21 +100,22 @@ static int clk_utmi_is_prepared(struct clk_hw *hw)
 {
 	struct clk_utmi *utmi = to_clk_utmi(hw);
 
-	return clk_utmi_ready(utmi->regmap);
+	return clk_utmi_ready(utmi->regmap_pmc);
 }
 
 static void clk_utmi_unprepare(struct clk_hw *hw)
 {
 	struct clk_utmi *utmi = to_clk_utmi(hw);
 
-	regmap_update_bits(utmi->regmap, AT91_CKGR_UCKR, AT91_PMC_UPLLEN, 0);
+	regmap_update_bits(utmi->regmap_pmc, AT91_CKGR_UCKR,
+			   AT91_PMC_UPLLEN, 0);
 }
 
 static unsigned long clk_utmi_recalc_rate(struct clk_hw *hw,
 					  unsigned long parent_rate)
 {
-	/* UTMI clk is a fixed clk multiplier */
-	return parent_rate * UTMI_FIXED_MUL;
+	/* UTMI clk rate is fixed. */
+	return UTMI_RATE;
 }
 
 static const struct clk_ops utmi_ops = {
@@ -78,7 +126,7 @@ static const struct clk_ops utmi_ops = {
 };
 
 static struct clk_hw * __init
-at91_clk_register_utmi(struct regmap *regmap,
+at91_clk_register_utmi(struct regmap *regmap_pmc, struct regmap *regmap_sfr,
 		       const char *name, const char *parent_name)
 {
 	struct clk_utmi *utmi;
@@ -97,7 +145,8 @@ at91_clk_register_utmi(struct regmap *regmap,
 	init.flags = CLK_SET_RATE_GATE;
 
 	utmi->hw.init = &init;
-	utmi->regmap = regmap;
+	utmi->regmap_pmc = regmap_pmc;
+	utmi->regmap_sfr = regmap_sfr;
 
 	hw = &utmi->hw;
 	ret = clk_hw_register(NULL, &utmi->hw);
@@ -114,17 +163,22 @@ static void __init of_at91sam9x5_clk_utmi_setup(struct device_node *np)
 	struct clk_hw *hw;
 	const char *parent_name;
 	const char *name = np->name;
-	struct regmap *regmap;
+	struct regmap *regmap_pmc, *regmap_sfr;
 
 	parent_name = of_clk_get_parent_name(np, 0);
 
 	of_property_read_string(np, "clock-output-names", &name);
 
-	regmap = syscon_node_to_regmap(of_get_parent(np));
-	if (IS_ERR(regmap))
+	regmap_pmc = syscon_node_to_regmap(of_get_parent(np));
+	if (IS_ERR(regmap_pmc))
 		return;
 
-	hw = at91_clk_register_utmi(regmap, name, parent_name);
+	/* SFR node missing is not necessarily an issue. */
+	regmap_sfr = syscon_regmap_lookup_by_compatible("atmel,sama5d2-sfr");
+	if (IS_ERR(regmap_sfr))
+		regmap_sfr = NULL;
+
+	hw = at91_clk_register_utmi(regmap_pmc, regmap_sfr, name, parent_name);
 	if (IS_ERR(hw))
 		return;
 
diff --git a/include/soc/at91/atmel-sfr.h b/include/soc/at91/atmel-sfr.h
index 506ea8ffda19..482337af06b8 100644
--- a/include/soc/at91/atmel-sfr.h
+++ b/include/soc/at91/atmel-sfr.h
@@ -17,6 +17,7 @@
 /* 0x08 ~ 0x0c: Reserved */
 #define AT91_SFR_OHCIICR	0x10	/* OHCI INT Configuration Register */
 #define AT91_SFR_OHCIISR	0x14	/* OHCI INT Status Register */
+#define AT91_SFR_UTMICKTRIM	0x30	/* UTMI Clock Trimming Register */
 #define AT91_SFR_I2SCLKSEL	0x90	/* I2SC Register */
 
 /* Field definitions */
@@ -28,5 +29,6 @@
 					 AT91_OHCIICR_SUSPEND_B | \
 					 AT91_OHCIICR_SUSPEND_C)
 
+#define AT91_UTMICKTRIM_FREQ	GENMASK(1, 0)
 
 #endif /* _LINUX_MFD_SYSCON_ATMEL_SFR_H */
-- 
2.12.2
