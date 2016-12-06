From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 6 Dec 2016 11:55:58 +0100
Subject: [RFC PATCH 1/3] clk: at91: add audio pll clock driver
In-Reply-To: <cover.1481021115.git.nicolas.ferre@atmel.com>
References: <cover.1481021115.git.nicolas.ferre@atmel.com>
Message-ID: <30b3faf4af27dc658541846c70408ad4e168b850.1481021115.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This new clock driver set allows to have a fractional divided clock that
would generate a precise clock particularly suitable for audio applications.

The main audio pll clock has two children clocks: one that is connected to
the PMC, the other that can directly drive a pad. As these two routes have
different enable bits and different dividers and divider formula, they are
handled by two different drivers. Each of them would modify the rate of
the main audio pll parent.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 .../devicetree/bindings/clock/at91-clock.txt       |  10 +
 arch/arm/mach-at91/Kconfig                         |   4 +
 drivers/clk/at91/Makefile                          |   2 +
 drivers/clk/at91/clk-audio-pll-pad.c               | 238 +++++++++++++++++++
 drivers/clk/at91/clk-audio-pll-pmc.c               | 184 +++++++++++++++
 drivers/clk/at91/clk-audio-pll.c                   | 253 +++++++++++++++++++++
 include/linux/clk/at91_pmc.h                       |  25 ++
 7 files changed, 716 insertions(+)
 create mode 100644 drivers/clk/at91/clk-audio-pll-pad.c
 create mode 100644 drivers/clk/at91/clk-audio-pll-pmc.c
 create mode 100644 drivers/clk/at91/clk-audio-pll.c

diff --git a/Documentation/devicetree/bindings/clock/at91-clock.txt b/Documentation/devicetree/bindings/clock/at91-clock.txt
index 5f3ad65daf69..bbf3ed9d9166 100644
--- a/Documentation/devicetree/bindings/clock/at91-clock.txt
+++ b/Documentation/devicetree/bindings/clock/at91-clock.txt
@@ -81,6 +81,16 @@ Required properties:
 	"atmel,sama5d2-clk-generated":
 		at91 generated clock
 
+	"atmel,sama5d2-clk-audio-pll-frac":
+		at91 audio fractional pll
+
+	"atmel,sama5d2-clk-audio-pll-pad":
+		at91 audio pll CLK_AUDIO output pin
+
+	"atmel,sama5d2-clk-audio-pll-pmc"
+		at91 audio pll ouput on AUDIOPLLCLK that feeds the PMC
+		and can be used by peripheral clock or generic clock
+
 Required properties for SCKC node:
 - reg : defines the IO memory reserved for the SCKC.
 - #size-cells : shall be 0 (reg is used to encode clk id).
diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 841e924143f9..bc1f56dcda8a 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -17,6 +17,7 @@ config SOC_SAMA5D2
 	select HAVE_AT91_USB_CLK
 	select HAVE_AT91_H32MX
 	select HAVE_AT91_GENERATED_CLK
+	select HAVE_AT91_AUDIO_PLL
 	select PINCTRL_AT91PIO4
 	help
 	  Select this if ou are using one of Atmel's SAMA5D2 family SoC.
@@ -114,6 +115,9 @@ config HAVE_AT91_H32MX
 config HAVE_AT91_GENERATED_CLK
 	bool
 
+config HAVE_AT91_AUDIO_PLL
+	bool
+
 config SOC_SAM_V4_V5
 	bool
 
diff --git a/drivers/clk/at91/Makefile b/drivers/clk/at91/Makefile
index 13e67bd35cff..c9353d17763a 100644
--- a/drivers/clk/at91/Makefile
+++ b/drivers/clk/at91/Makefile
@@ -6,6 +6,8 @@ obj-y += pmc.o sckc.o
 obj-y += clk-slow.o clk-main.o clk-pll.o clk-plldiv.o clk-master.o
 obj-y += clk-system.o clk-peripheral.o clk-programmable.o
 
+obj-$(CONFIG_HAVE_AT91_AUDIO_PLL)	+= clk-audio-pll.o
+obj-$(CONFIG_HAVE_AT91_AUDIO_PLL)	+= clk-audio-pll-pmc.o clk-audio-pll-pad.o
 obj-$(CONFIG_HAVE_AT91_UTMI)		+= clk-utmi.o
 obj-$(CONFIG_HAVE_AT91_USB_CLK)		+= clk-usb.o
 obj-$(CONFIG_HAVE_AT91_SMD)		+= clk-smd.o
diff --git a/drivers/clk/at91/clk-audio-pll-pad.c b/drivers/clk/at91/clk-audio-pll-pad.c
new file mode 100644
index 000000000000..39cee71f15c6
--- /dev/null
+++ b/drivers/clk/at91/clk-audio-pll-pad.c
@@ -0,0 +1,238 @@
+/*
+ *  Copyright (C) 2016 Atmel Corporation,
+ *                     Nicolas Ferre <nicolas.ferre@atmel.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/clkdev.h>
+#include <linux/clk/at91_pmc.h>
+#include <linux/of.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
+
+#include "pmc.h"
+
+/*
+ * DOC: PAD output for fractional PLL clock for audio
+ *
+ * Traits of this clock:
+ * enable - clk_enable writes qdpad (which is ext_div and (div2,div3)),
+ *          and enables PAD output
+ * rate - rate is adjustable.
+ *        clk->rate = parent->rate / (ext_div * (div2,div3))
+ * parent - fixed parent.  No clk_set_parent support
+ */
+
+#define AUDIO_PLL_FOUT_MIN		620000000
+#define AUDIO_PLL_FOUT_MAX		700000000
+#define AUDIO_PLL_REFERENCE_FOUT	660000000
+
+#define AUDIO_PLL_QDPAD_MAX	((AT91_PMC_AUDIO_PLL_QDPAD_DIV_MASK >> \
+				    AT91_PMC_AUDIO_PLL_QDPAD_DIV_OFFSET) * \
+					AT91_PMC_AUDIO_PLL_QDPAD_EXTDIV_MAX)
+#define AUDIO_PLL_QDPAD_EXTDIV_OFFSET	(AT91_PMC_AUDIO_PLL_QDPAD_EXTDIV_OFFSET - \
+					     AT91_PMC_AUDIO_PLL_QDPAD_OFFSET)
+#define AUDIO_PLL_DIV2QD(div, ext_div)	((div) | ((ext_div) << \
+						  AUDIO_PLL_QDPAD_EXTDIV_OFFSET))
+#define AUDIO_PLL_QD2DIV(qd)	((qd) & (AT91_PMC_AUDIO_PLL_QDPAD_DIV_MASK >> \
+					  AT91_PMC_AUDIO_PLL_QDPAD_DIV_OFFSET))
+#define AUDIO_PLL_QD2EXTDIV(qd)	(((qd) >> AUDIO_PLL_QDPAD_EXTDIV_OFFSET) \
+				 & (AT91_PMC_AUDIO_PLL_QDPAD_EXTDIV_MASK >> \
+					  AT91_PMC_AUDIO_PLL_QDPAD_EXTDIV_OFFSET))
+
+struct clk_audio_pad {
+	struct clk_hw hw;
+	struct regmap *regmap;
+	spinlock_t *lock;
+	u8 qdpad;
+};
+
+#define to_clk_audio_pad(hw) container_of(hw, struct clk_audio_pad, hw)
+
+static int clk_audio_pll_pad_enable(struct clk_hw *hw)
+{
+	struct clk_audio_pad *apad_ck = to_clk_audio_pad(hw);
+	unsigned long flags;
+
+	spin_lock_irqsave(apad_ck->lock, flags);
+	regmap_update_bits(apad_ck->regmap, AT91_PMC_AUDIO_PLL1,
+			   AT91_PMC_AUDIO_PLL_QDPAD_MASK,
+			   AT91_PMC_AUDIO_PLL_QDPAD(apad_ck->qdpad));
+	regmap_update_bits(apad_ck->regmap, AT91_PMC_AUDIO_PLL0,
+			   AT91_PMC_AUDIO_PLL_PADEN, AT91_PMC_AUDIO_PLL_PADEN);
+	spin_unlock_irqrestore(apad_ck->lock, flags);
+	return 0;
+}
+
+static void clk_audio_pll_pad_disable(struct clk_hw *hw)
+{
+	struct clk_audio_pad *apad_ck = to_clk_audio_pad(hw);
+
+	regmap_update_bits(apad_ck->regmap, AT91_PMC_AUDIO_PLL0,
+			   AT91_PMC_AUDIO_PLL_PADEN, 0);
+}
+
+static unsigned long clk_audio_pll_pad_recalc_rate(struct clk_hw *hw,
+					           unsigned long parent_rate)
+{
+	struct clk_audio_pad *apad_ck = to_clk_audio_pad(hw);
+	unsigned long apad_rate = 0;
+	u8 tmp_div = AUDIO_PLL_QD2DIV(apad_ck->qdpad);
+	u8 tmp_ext_div = AUDIO_PLL_QD2EXTDIV(apad_ck->qdpad);
+
+	if (tmp_div && tmp_ext_div)
+		apad_rate = parent_rate / (tmp_div * tmp_ext_div);
+
+	pr_debug("A PLL/PAD: %s, apad_rate = %lu (div = %u, ext_div = %u)\n" ,
+		 __func__ , apad_rate, tmp_div, tmp_ext_div);
+
+	return apad_rate;
+}
+
+static int clk_audio_pll_compute_qdpad(unsigned long q_rate, unsigned long rate,
+				       unsigned long *qd, u8 *div, u8 *ext_div)
+{
+	unsigned long tmp_qd;
+	unsigned long rem2, rem3;
+	unsigned long ldiv, lext_div;;
+
+	if (!rate)
+		return -EINVAL;
+
+	tmp_qd = q_rate / rate;
+	if (!tmp_qd || tmp_qd > AUDIO_PLL_QDPAD_MAX)
+		return -EINVAL;
+
+	if (tmp_qd <= AT91_PMC_AUDIO_PLL_QDPAD_EXTDIV_MAX) {
+		ldiv = 1;
+		lext_div = tmp_qd;
+	} else {
+		rem2 = tmp_qd % 2;
+		rem3 = tmp_qd % 3;
+
+		if (rem3 == 0 ||
+		    tmp_qd > AT91_PMC_AUDIO_PLL_QDPAD_EXTDIV_MAX * 2 ||
+		    rem3 < rem2) {
+			ldiv = 3;
+			lext_div = tmp_qd / 3;
+		} else {
+			ldiv = 2;
+			lext_div = tmp_qd >> 1;
+		}
+	}
+
+	pr_debug("A PLL/PAD: %s, qd = %lu (div = %lu, ext_div = %lu)\n" ,
+		 __func__ , ldiv * lext_div, ldiv, lext_div);
+
+	/* if we were given variable to store, we can provide them */
+	if (qd)
+		*qd = ldiv * lext_div;
+	if (div && ext_div) {
+		/* we can cast here as we verified the bounds just above */
+		*div = (u8)ldiv;
+		*ext_div = (u8)lext_div;
+	}
+
+	return 0;
+}
+
+static long clk_audio_pll_pad_round_rate(struct clk_hw *hw, unsigned long rate,
+					 unsigned long *parent_rate)
+{
+	struct clk_hw *pclk = clk_hw_get_parent(hw);
+	long best_rate = -EINVAL;
+	unsigned long best_parent_rate = 0;
+	unsigned long tmp_qd;
+
+	pr_debug("A PLL/PAD: %s, rate = %lu (parent_rate = %lu)\n" ,
+		 __func__ , rate, *parent_rate);
+
+	if (clk_audio_pll_compute_qdpad(AUDIO_PLL_REFERENCE_FOUT, rate,
+				        &tmp_qd, NULL, NULL))
+		return -EINVAL;
+
+	best_parent_rate = clk_hw_round_rate(pclk, rate * tmp_qd);
+	best_rate = best_parent_rate / tmp_qd;
+
+	pr_debug("A PLL/PAD: %s, best_rate = %ld, best_parent_rate = %lu\n",
+		 __func__, best_rate, best_parent_rate);
+
+	*parent_rate = best_parent_rate;
+	return best_rate;
+}
+
+static int clk_audio_pll_pad_set_rate(struct clk_hw *hw, unsigned long rate,
+				      unsigned long parent_rate)
+{
+	struct clk_audio_pad *apad_ck = to_clk_audio_pad(hw);
+	u8 tmp_div, tmp_ext_div;
+	int ret;
+
+	pr_debug("A PLL/PAD: %s, rate = %lu (parent_rate = %lu)\n" ,
+		 __func__ , rate, parent_rate);
+
+	ret = clk_audio_pll_compute_qdpad(parent_rate, rate, NULL,
+					  &tmp_div, &tmp_ext_div);
+	if (!ret)
+		apad_ck->qdpad = AUDIO_PLL_DIV2QD(tmp_div, tmp_ext_div);
+
+	return ret;
+}
+
+static const struct clk_ops audio_pll_pad_ops = {
+	.enable = clk_audio_pll_pad_enable,
+	.disable = clk_audio_pll_pad_disable,
+	.recalc_rate = clk_audio_pll_pad_recalc_rate,
+	.round_rate = clk_audio_pll_pad_round_rate,
+	.set_rate = clk_audio_pll_pad_set_rate,
+};
+
+static void __init of_sama5d2_clk_audio_pll_pad_setup(struct device_node *np)
+{
+	struct clk_audio_pad *apad_ck;
+	struct clk_init_data init;
+	struct regmap *regmap;
+	const char *parent_name;
+	const char *name = np->name;
+	int ret;
+
+	parent_name = of_clk_get_parent_name(np, 0);
+
+	of_property_read_string(np, "clock-output-names", &name);
+
+	regmap = syscon_node_to_regmap(of_get_parent(np));
+	if (IS_ERR(regmap))
+		return;
+
+	apad_ck = kzalloc(sizeof(*apad_ck), GFP_KERNEL);
+	if (!apad_ck)
+		return;
+
+	init.name = name;
+	init.ops = &audio_pll_pad_ops;
+	init.parent_names = (parent_name ? &parent_name : NULL);
+	init.num_parents = 1;
+	init.flags = CLK_SET_RATE_GATE |
+		     CLK_SET_PARENT_GATE | CLK_SET_RATE_PARENT;
+
+	apad_ck->hw.init = &init;
+	apad_ck->regmap = regmap;
+	apad_ck->lock = &pmc_pcr_lock;
+
+	ret = clk_hw_register(NULL, &apad_ck->hw);
+	if (ret)
+		kfree(apad_ck);
+	else
+		of_clk_add_hw_provider(np, of_clk_hw_simple_get, &apad_ck->hw);
+
+	return;
+}
+CLK_OF_DECLARE(of_sama5d2_clk_audio_pll_pad_setup,
+	       "atmel,sama5d2-clk-audio-pll-pad",
+	       of_sama5d2_clk_audio_pll_pad_setup);
diff --git a/drivers/clk/at91/clk-audio-pll-pmc.c b/drivers/clk/at91/clk-audio-pll-pmc.c
new file mode 100644
index 000000000000..fadc51e25bac
--- /dev/null
+++ b/drivers/clk/at91/clk-audio-pll-pmc.c
@@ -0,0 +1,184 @@
+/*
+ *  Copyright (C) 2016 Atmel Corporation,
+ *                     Nicolas Ferre <nicolas.ferre@atmel.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/clkdev.h>
+#include <linux/clk/at91_pmc.h>
+#include <linux/of.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
+
+#include "pmc.h"
+
+/*
+ * DOC: PMC output for fractional PLL clock for audio
+ *
+ * Traits of this clock:
+ * enable - clk_enable writes qdpmc, and enables PMC output
+ * rate - rate is adjustable.
+ *        clk->rate = parent->rate / (qdpmc + 1)
+ * parent - fixed parent.  No clk_set_parent support
+ */
+
+#define AUDIO_PLL_FOUT_MIN		620000000
+#define AUDIO_PLL_FOUT_MAX		700000000
+#define AUDIO_PLL_REFERENCE_FOUT	660000000
+#define AUDIO_PLL_QDPMC_MAX		(AT91_PMC_AUDIO_PLL_QDPMC_MASK >> \
+						AT91_PMC_AUDIO_PLL_QDPMC_OFFSET)
+struct clk_audio_pmc {
+	struct clk_hw hw;
+	struct regmap *regmap;
+	u8 qdpmc;
+};
+
+#define to_clk_audio_pmc(hw) container_of(hw, struct clk_audio_pmc, hw)
+
+static int clk_audio_pll_pmc_enable(struct clk_hw *hw)
+{
+	struct clk_audio_pmc *apmc_ck = to_clk_audio_pmc(hw);
+
+	regmap_update_bits(apmc_ck->regmap, AT91_PMC_AUDIO_PLL0,
+			   AT91_PMC_AUDIO_PLL_PMCEN |
+			   AT91_PMC_AUDIO_PLL_QDPMC_MASK,
+			   AT91_PMC_AUDIO_PLL_PMCEN |
+			   AT91_PMC_AUDIO_PLL_QDPMC(apmc_ck->qdpmc));
+	return 0;
+}
+
+static void clk_audio_pll_pmc_disable(struct clk_hw *hw)
+{
+	struct clk_audio_pmc *apmc_ck = to_clk_audio_pmc(hw);
+
+	regmap_update_bits(apmc_ck->regmap, AT91_PMC_AUDIO_PLL0,
+			   AT91_PMC_AUDIO_PLL_PMCEN, 0);
+}
+
+static unsigned long clk_audio_pll_pmc_recalc_rate(struct clk_hw *hw,
+					           unsigned long parent_rate)
+{
+	struct clk_audio_pmc *apmc_ck = to_clk_audio_pmc(hw);
+	unsigned long apmc_rate = 0;
+
+	apmc_rate = parent_rate / (apmc_ck->qdpmc + 1);
+
+	pr_debug("A PLL/PMC: %s, apmc_rate = %lu (qdpmc = %u)\n" ,
+		 __func__ , apmc_rate, apmc_ck->qdpmc);
+
+	return apmc_rate;
+}
+
+static int clk_audio_pll_compute_qdpmc(unsigned long q_rate, unsigned long rate,
+				       unsigned long *qd)
+{
+	unsigned long tmp_qd;
+
+	if (!rate)
+		return -EINVAL;
+
+	tmp_qd = q_rate / rate;
+	if (!tmp_qd || tmp_qd > AUDIO_PLL_QDPMC_MAX)
+		return -EINVAL;
+
+	*qd = tmp_qd;
+	return 0;
+}
+
+static long clk_audio_pll_pmc_round_rate(struct clk_hw *hw, unsigned long rate,
+					 unsigned long *parent_rate)
+{
+	struct clk_hw *pclk = clk_hw_get_parent(hw);
+	long best_rate = -EINVAL;
+	unsigned long best_parent_rate = 0;
+	unsigned long tmp_qd;
+
+	pr_debug("A PLL/PMC: %s, rate = %lu (parent_rate = %lu)\n" ,
+		 __func__ , rate, *parent_rate);
+
+	if (clk_audio_pll_compute_qdpmc(AUDIO_PLL_REFERENCE_FOUT, rate, &tmp_qd))
+		return -EINVAL;
+
+	best_parent_rate = clk_hw_round_rate(pclk, rate * tmp_qd);
+	best_rate = best_parent_rate / tmp_qd;
+
+	pr_debug("A PLL/PMC: %s, best_rate = %ld, best_parent_rate = %lu (qd = %lu)\n",
+		 __func__, best_rate, best_parent_rate, tmp_qd - 1);
+
+	*parent_rate = best_parent_rate;
+	return best_rate;
+}
+
+static int clk_audio_pll_pmc_set_rate(struct clk_hw *hw, unsigned long rate,
+				      unsigned long parent_rate)
+{
+	struct clk_audio_pmc *apmc_ck = to_clk_audio_pmc(hw);
+	unsigned long tmp_qd;
+	int ret;
+
+	pr_debug("A PLL/PMC: %s, rate = %lu (parent_rate = %lu)\n" ,
+		 __func__ , rate, parent_rate);
+
+	ret = clk_audio_pll_compute_qdpmc(parent_rate, rate, &tmp_qd);
+	if (!ret)
+		apmc_ck->qdpmc = tmp_qd - 1;
+
+	return ret;
+}
+
+static const struct clk_ops audio_pll_pmc_ops = {
+	.enable = clk_audio_pll_pmc_enable,
+	.disable = clk_audio_pll_pmc_disable,
+	.recalc_rate = clk_audio_pll_pmc_recalc_rate,
+	.round_rate = clk_audio_pll_pmc_round_rate,
+	.set_rate = clk_audio_pll_pmc_set_rate,
+};
+
+static void __init of_sama5d2_clk_audio_pll_pmc_setup(struct device_node *np)
+{
+	struct clk_audio_pmc *apmc_ck;
+	struct clk_init_data init;
+	struct regmap *regmap;
+	const char *parent_name;
+	const char *name = np->name;
+	int ret;
+
+	parent_name = of_clk_get_parent_name(np, 0);
+
+	of_property_read_string(np, "clock-output-names", &name);
+
+	regmap = syscon_node_to_regmap(of_get_parent(np));
+	if (IS_ERR(regmap))
+		return;
+
+	apmc_ck = kzalloc(sizeof(*apmc_ck), GFP_KERNEL);
+	if (!apmc_ck)
+		return;
+
+	init.name = name;
+	init.ops = &audio_pll_pmc_ops;
+	init.parent_names = (parent_name ? &parent_name : NULL);
+	init.num_parents = 1;
+	init.flags = CLK_SET_RATE_GATE |
+		     CLK_SET_PARENT_GATE | CLK_SET_RATE_PARENT;
+
+	apmc_ck->hw.init = &init;
+	apmc_ck->regmap = regmap;
+
+	ret = clk_hw_register(NULL, &apmc_ck->hw);
+	if (ret)
+		kfree(apmc_ck);
+	else
+		of_clk_add_hw_provider(np, of_clk_hw_simple_get, &apmc_ck->hw);
+
+	return;
+}
+CLK_OF_DECLARE(of_sama5d2_clk_audio_pll_pmc_setup,
+	       "atmel,sama5d2-clk-audio-pll-pmc",
+	       of_sama5d2_clk_audio_pll_pmc_setup);
diff --git a/drivers/clk/at91/clk-audio-pll.c b/drivers/clk/at91/clk-audio-pll.c
new file mode 100644
index 000000000000..76261bcb204f
--- /dev/null
+++ b/drivers/clk/at91/clk-audio-pll.c
@@ -0,0 +1,253 @@
+/*
+ *  Copyright (C) 2016 Atmel Corporation,
+ *  		       Songjun Wu <songjun.wu@atmel.com>,
+ *                     Nicolas Ferre <nicolas.ferre@atmel.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+#include <linux/clk-provider.h>
+#include <linux/clkdev.h>
+#include <linux/clk/at91_pmc.h>
+#include <linux/of.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
+
+#include "pmc.h"
+
+/*
+ * DOC: Fractional PLL clock for audio
+ *
+ * Traits of this clock:
+ * prepare - clk_prepare puts audio PLL in reset state
+ * enable - clk_enable writes nd, fracr parameters and enables PLL
+ * rate - rate is adjustable.
+ *        clk->rate = parent->rate * ((nd + 1) + (fracr / 2^22))
+ * parent - fixed parent.  No clk_set_parent support
+ */
+
+#define AUDIO_PLL_DIV_FRAC	(1 << 22)
+#define AUDIO_PLL_ND_MAX	(AT91_PMC_AUDIO_PLL_ND_MASK >> \
+					AT91_PMC_AUDIO_PLL_ND_OFFSET)
+
+struct clk_audio_frac {
+	struct clk_hw hw;
+	struct regmap *regmap;
+	spinlock_t *lock;
+	u32 fracr;
+	u8 nd;
+};
+
+#define to_clk_audio_frac(hw) container_of(hw, struct clk_audio_frac, hw)
+
+/* make sure that pll is in reset state beforehand */
+static int clk_audio_pll_prepare(struct clk_hw *hw)
+{
+	struct clk_audio_frac *fck = to_clk_audio_frac(hw);
+
+	regmap_update_bits(fck->regmap, AT91_PMC_AUDIO_PLL0,
+			   AT91_PMC_AUDIO_PLL_RESETN, 0);
+	return 0;
+}
+
+static void clk_audio_pll_unprepare(struct clk_hw *hw)
+{
+	clk_audio_pll_prepare(hw);
+}
+
+static int clk_audio_pll_enable(struct clk_hw *hw)
+{
+	struct clk_audio_frac *fck = to_clk_audio_frac(hw);
+	unsigned long flags;
+
+	spin_lock_irqsave(fck->lock, flags);
+	regmap_update_bits(fck->regmap, AT91_PMC_AUDIO_PLL0,
+			   AT91_PMC_AUDIO_PLL_RESETN,
+			   AT91_PMC_AUDIO_PLL_RESETN);
+	regmap_update_bits(fck->regmap, AT91_PMC_AUDIO_PLL1,
+			   AT91_PMC_AUDIO_PLL_FRACR_MASK, fck->fracr);
+
+	/*
+	 * reset and enable have to be done in 2 separated writes
+	 * for AT91_PMC_AUDIO_PLL0
+	 */
+	regmap_update_bits(fck->regmap, AT91_PMC_AUDIO_PLL0,
+			   AT91_PMC_AUDIO_PLL_PLLEN |
+			   AT91_PMC_AUDIO_PLL_ND_MASK,
+			   AT91_PMC_AUDIO_PLL_PLLEN |
+			   AT91_PMC_AUDIO_PLL_ND(fck->nd));
+	spin_unlock_irqrestore(fck->lock, flags);
+	return 0;
+}
+
+static void clk_audio_pll_disable(struct clk_hw *hw)
+{
+	struct clk_audio_frac *fck = to_clk_audio_frac(hw);
+	unsigned long flags;
+
+	spin_lock_irqsave(fck->lock, flags);
+	regmap_update_bits(fck->regmap, AT91_PMC_AUDIO_PLL0,
+			   AT91_PMC_AUDIO_PLL_PLLEN, 0);
+	/* do it in 2 separated writes */
+	regmap_update_bits(fck->regmap, AT91_PMC_AUDIO_PLL0,
+			   AT91_PMC_AUDIO_PLL_RESETN, 0);
+	spin_unlock_irqrestore(fck->lock, flags);
+}
+
+static unsigned long clk_audio_pll_fout(unsigned long parent_rate,
+					unsigned long nd, unsigned long fracr)
+{
+	unsigned long long fr = (unsigned long long)parent_rate *
+						(unsigned long long)fracr;
+
+	pr_debug("A PLL: %s, fr = %llu\n" ,
+		 __func__ , fr);
+
+	fr = DIV_ROUND_CLOSEST_ULL(fr, AUDIO_PLL_DIV_FRAC);
+
+	pr_debug("A PLL: %s, fr = %llu\n" ,
+		 __func__ , fr);
+
+	return parent_rate * (nd + 1) + fr;
+}
+
+static unsigned long clk_audio_pll_recalc_rate(struct clk_hw *hw,
+					       unsigned long parent_rate)
+{
+	struct clk_audio_frac *fck = to_clk_audio_frac(hw);
+	unsigned long fout;
+
+	fout = clk_audio_pll_fout(parent_rate, fck->nd, fck->fracr);
+
+	pr_debug("A PLL: %s, fout = %lu (nd = %u, fracr = %lu)\n" ,
+		 __func__ , fout, fck->nd, (unsigned long)fck->fracr);
+
+	return fout;
+}
+
+static int clk_audio_pll_compute_frac(unsigned long rate, unsigned long parent_rate,
+				      unsigned long *nd, unsigned long *fracr)
+{
+	unsigned long long tmp;
+	unsigned long long r;
+
+	if (!rate)
+		return -EINVAL;
+
+	tmp = rate;
+	r = do_div(tmp, parent_rate);
+	if (tmp == 0 || (tmp - 1) > AUDIO_PLL_ND_MAX)
+		return -EINVAL;
+
+	*nd = tmp - 1;
+
+	tmp = r * AUDIO_PLL_DIV_FRAC;
+	tmp = DIV_ROUND_CLOSEST_ULL(tmp, parent_rate);
+	if (tmp > AT91_PMC_AUDIO_PLL_FRACR_MASK)
+		return -EINVAL;
+
+	/* we can cast here as we verified the bounds just above */
+	*fracr = (unsigned long)tmp;
+
+	return 0;
+}
+
+static long clk_audio_pll_round_rate(struct clk_hw *hw, unsigned long rate,
+				     unsigned long *parent_rate)
+{
+	long best_rate = -EINVAL;
+	unsigned long fracr;
+	unsigned long nd;
+	int ret;
+
+	pr_debug("A PLL: %s, rate = %lu (parent_rate = %lu)\n" ,
+		 __func__ , rate, *parent_rate);
+
+	ret = clk_audio_pll_compute_frac(rate, *parent_rate, &nd, &fracr);
+	if (ret)
+		return ret;
+
+	best_rate = clk_audio_pll_fout(*parent_rate, nd, fracr);
+
+	pr_debug("A PLL: %s, best_rate = %lu (nd = %lu, fracr = %lu)\n" ,
+		 __func__ , best_rate, nd, fracr);
+
+	return best_rate;
+}
+
+static int clk_audio_pll_set_rate(struct clk_hw *hw, unsigned long rate,
+				  unsigned long parent_rate)
+{
+	struct clk_audio_frac *fck = to_clk_audio_frac(hw);
+	unsigned long fracr;
+	unsigned long nd;
+	int ret;
+
+	pr_debug("A PLL: %s, rate = %lu (parent_rate = %lu)\n" ,
+		 __func__ , rate, parent_rate);
+
+	ret = clk_audio_pll_compute_frac(rate, parent_rate, &nd, &fracr);
+	if (ret)
+		return ret;
+
+	fck->nd = nd;
+	fck->fracr = fracr;
+
+	return 0;
+}
+
+static const struct clk_ops audio_pll_ops = {
+	.prepare = clk_audio_pll_prepare,
+	.unprepare = clk_audio_pll_unprepare,
+	.enable = clk_audio_pll_enable,
+	.disable = clk_audio_pll_disable,
+	.recalc_rate = clk_audio_pll_recalc_rate,
+	.round_rate = clk_audio_pll_round_rate,
+	.set_rate = clk_audio_pll_set_rate,
+};
+
+static void __init of_sama5d2_clk_audio_pll_setup(struct device_node *np)
+{
+	struct clk_audio_frac *fck;
+	struct clk_init_data init;
+	struct regmap *regmap;
+	const char *parent_name;
+	const char *name = np->name;
+	int ret;
+
+	parent_name = of_clk_get_parent_name(np, 0);
+
+	of_property_read_string(np, "clock-output-names", &name);
+
+	regmap = syscon_node_to_regmap(of_get_parent(np));
+	if (IS_ERR(regmap))
+		return;
+
+	fck = kzalloc(sizeof(*fck), GFP_KERNEL);
+	if (!fck)
+		return;
+
+	init.name = name;
+	init.ops = &audio_pll_ops;
+	init.parent_names = (parent_name ? &parent_name : NULL);
+	init.num_parents = 1;
+	init.flags = CLK_SET_RATE_GATE;
+
+	fck->hw.init = &init;
+	fck->regmap = regmap;
+	fck->lock = &pmc_pcr_lock;
+
+	ret = clk_hw_register(NULL, &fck->hw);
+	if (ret)
+		kfree(fck);
+	else
+		of_clk_add_hw_provider(np, of_clk_hw_simple_get, &fck->hw);
+
+	return;
+}
+CLK_OF_DECLARE(of_sama5d2_clk_audio_pll_setup,
+	       "atmel,sama5d2-clk-audio-pll-frac",
+	       of_sama5d2_clk_audio_pll_setup);
diff --git a/include/linux/clk/at91_pmc.h b/include/linux/clk/at91_pmc.h
index 17f413bbbedf..6aca5ce8a99a 100644
--- a/include/linux/clk/at91_pmc.h
+++ b/include/linux/clk/at91_pmc.h
@@ -185,4 +185,29 @@
 #define		AT91_PMC_PCR_EN			(0x1  <<  28)				/* Enable */
 #define		AT91_PMC_PCR_GCKEN		(0x1  <<  29)				/* GCK Enable */
 
+#define AT91_PMC_AUDIO_PLL0	0x14c
+#define		AT91_PMC_AUDIO_PLL_PLLEN	(1  <<  0)
+#define		AT91_PMC_AUDIO_PLL_PADEN	(1  <<  1)
+#define		AT91_PMC_AUDIO_PLL_PMCEN	(1  <<  2)
+#define		AT91_PMC_AUDIO_PLL_RESETN	(1  <<  3)
+#define		AT91_PMC_AUDIO_PLL_ND_OFFSET	8
+#define		AT91_PMC_AUDIO_PLL_ND_MASK	(0x7f << AT91_PMC_AUDIO_PLL_ND_OFFSET)
+#define		AT91_PMC_AUDIO_PLL_ND(n)	((n)  << AT91_PMC_AUDIO_PLL_ND_OFFSET)
+#define		AT91_PMC_AUDIO_PLL_QDPMC_OFFSET	16
+#define		AT91_PMC_AUDIO_PLL_QDPMC_MASK	(0x7f << AT91_PMC_AUDIO_PLL_QDPMC_OFFSET)
+#define		AT91_PMC_AUDIO_PLL_QDPMC(n)	((n)  << AT91_PMC_AUDIO_PLL_QDPMC_OFFSET)
+
+#define AT91_PMC_AUDIO_PLL1	0x150
+#define		AT91_PMC_AUDIO_PLL_FRACR_MASK		0x3fffff
+#define		AT91_PMC_AUDIO_PLL_QDPAD_OFFSET		24
+#define		AT91_PMC_AUDIO_PLL_QDPAD_MASK		(0x7f << AT91_PMC_AUDIO_PLL_QDPAD_OFFSET)
+#define		AT91_PMC_AUDIO_PLL_QDPAD(n)		((n)  << AT91_PMC_AUDIO_PLL_QDPAD_OFFSET)
+#define		AT91_PMC_AUDIO_PLL_QDPAD_DIV_OFFSET	AT91_PMC_AUDIO_PLL_QDPAD_OFFSET
+#define		AT91_PMC_AUDIO_PLL_QDPAD_DIV_MASK	(0x3  << AT91_PMC_AUDIO_PLL_QDPAD_DIV_OFFSET)
+#define		AT91_PMC_AUDIO_PLL_QDPAD_DIV(n)		((n)  << AT91_PMC_AUDIO_PLL_QDPAD_DIV_OFFSET)
+#define		AT91_PMC_AUDIO_PLL_QDPAD_EXTDIV_OFFSET	26
+#define		AT91_PMC_AUDIO_PLL_QDPAD_EXTDIV_MAX	0x1f
+#define		AT91_PMC_AUDIO_PLL_QDPAD_EXTDIV_MASK	(AT91_PMC_AUDIO_PLL_QDPAD_EXTDIV_MAX << AT91_PMC_AUDIO_PLL_QDPAD_EXTDIV_OFFSET)
+#define		AT91_PMC_AUDIO_PLL_QDPAD_EXTDIV(n)	((n)  << AT91_PMC_AUDIO_PLL_QDPAD_EXTDIV_OFFSET)
+
 #endif
-- 
2.9.0
