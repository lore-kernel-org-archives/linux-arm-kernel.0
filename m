From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 31 Jul 2015 12:17:44 +0200
Subject: [PATCH] clk: at91: add audio pll clock driver
Message-ID: <1438337864-27949-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This new clock driver set allows to have a fractional divided clock
that would generate a precise clock particularly suitable for
audio applications.

The main audio pll clock has two children clocks: one that is connected
to the PMC, the other that can directly drive a pad. As these two routes
have different enable bits and different dividers and divider formula,
they are handled by two different drivers.
Each of them would modify the rate of the main audio pll parent.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 .../devicetree/bindings/clock/at91-clock.txt       |  38 +++
 drivers/clk/at91/Makefile                          |   2 +
 drivers/clk/at91/clk-audio-pll-pad.c               | 220 +++++++++++++++++
 drivers/clk/at91/clk-audio-pll-pmc.c               | 171 ++++++++++++++
 drivers/clk/at91/clk-audio-pll.c                   | 261 +++++++++++++++++++++
 drivers/clk/at91/pmc.c                             |  14 ++
 drivers/clk/at91/pmc.h                             |   7 +
 include/linux/clk/at91_pmc.h                       |  25 ++
 8 files changed, 738 insertions(+)
 create mode 100644 drivers/clk/at91/clk-audio-pll-pad.c
 create mode 100644 drivers/clk/at91/clk-audio-pll-pmc.c
 create mode 100644 drivers/clk/at91/clk-audio-pll.c

diff --git a/Documentation/devicetree/bindings/clock/at91-clock.txt b/Documentation/devicetree/bindings/clock/at91-clock.txt
index 181bc8ac4e3a..67ba7714ec8e 100644
--- a/Documentation/devicetree/bindings/clock/at91-clock.txt
+++ b/Documentation/devicetree/bindings/clock/at91-clock.txt
@@ -55,6 +55,13 @@ Required properties:
 	"atmel,at91sam9x5-clk-plldiv":
 		at91 plla divisor
 
+	"atmel,sama5d2-clk-audio-pll-frac":
+		at91 fractional audio pll
+	"atmel,sama5d2-clk-audio-pll-pad"
+		at91 audio pll multiplexed to the dedicated pad
+	"atmel,sama5d2-clk-audio-pll-pmc"
+		at91 audio pll multiplexed to the PMC
+
 	"atmel,at91rm9200-clk-programmable" or
 	"atmel,at91sam9g45-clk-programmable" or
 	"atmel,at91sam9x5-clk-programmable":
@@ -336,6 +343,37 @@ For example:
 		clocks = <&plla>;
 	};
 
+Required properties for fractional audio pll clocks:
+- #clock-cells : from common clock binding; shall be set to 0.
+- clocks : shall be the main clock phandle.
+
+Required properties for audio pll pad clocks:
+- #clock-cells : from common clock binding; shall be set to 0.
+- clocks : shall be the fractional audio pll phandle.
+
+Required properties for audio pll pmc clocks:
+- #clock-cells : from common clock binding; shall be set to 0.
+- clocks : shall be the fractional audio pll phandle.
+
+For example:
+	audio_pll_frac: audiopll_fracck {
+		compatible = "atmel,sama5d2-clk-audio-pll-frac";
+		#clock-cells = <0>;
+		clocks = <&main>;
+	};
+
+	audio_pll_pad: audiopll_padck {
+		compatible = "atmel,sama5d2-clk-audio-pll-pad";
+		#clock-cells = <0>;
+		clocks = <&audio_pll_frac>;
+	};
+
+	audio_pll_pmc: audiopll_pmcck {
+		compatible = "atmel,sama5d2-clk-audio-pll-pmc";
+		#clock-cells = <0>;
+		clocks = <&audio_pll_frac>;
+	};
+
 Required properties for programmable clocks:
 - interrupt-parent : must reference the PMC node.
 - #size-cells : shall be 0 (reg is used to encode clk id).
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
index 000000000000..9f37a20e00a0
--- /dev/null
+++ b/drivers/clk/at91/clk-audio-pll-pad.c
@@ -0,0 +1,220 @@
+/*
+ *  Copyright (C) 2015 Atmel Corporation,
+ *                     Nicolas Ferre <nicolas.ferre@atmel.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/clkdev.h>
+#include <linux/clk/at91_pmc.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/io.h>
+
+#include "pmc.h"
+
+#define AUDIO_PLL_REFERENCE_FOUT	700000000
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
+	struct at91_pmc *pmc;
+	u8 qdpad;
+};
+
+#define to_clk_audio_pad(hw) container_of(hw, struct clk_audio_pad, hw)
+
+static int clk_audio_pll_pad_enable(struct clk_hw *hw)
+{
+	struct clk_audio_pad *apad_ck = to_clk_audio_pad(hw);
+	struct at91_pmc *pmc = apad_ck->pmc;
+	u32 tmp;
+
+	pmc_lock(pmc);
+	tmp = pmc_read(pmc, AT91_PMC_AUDIO_PLL1) &
+						~AT91_PMC_AUDIO_PLL_QDPAD_MASK;
+	tmp |= AT91_PMC_AUDIO_PLL_QDPAD(apad_ck->qdpad);
+	pmc_write(pmc, AT91_PMC_AUDIO_PLL1, tmp);
+	tmp = pmc_read(pmc, AT91_PMC_AUDIO_PLL0);
+	pmc_write(pmc, AT91_PMC_AUDIO_PLL0, tmp | AT91_PMC_AUDIO_PLL_PADEN);
+	pmc_unlock(pmc);
+	return 0;
+}
+
+static void clk_audio_pll_pad_disable(struct clk_hw *hw)
+{
+	struct clk_audio_pad *apad_ck = to_clk_audio_pad(hw);
+	struct at91_pmc *pmc = apad_ck->pmc;
+	u32 tmp;
+
+	pmc_lock(pmc);
+	tmp = pmc_read(pmc, AT91_PMC_AUDIO_PLL0) & ~AT91_PMC_AUDIO_PLL_PADEN;
+	pmc_write(pmc, AT91_PMC_AUDIO_PLL0, tmp);
+	pmc_unlock(pmc);
+}
+
+static unsigned long clk_audio_pll_pad_recalc_rate(struct clk_hw *hw,
+						   unsigned long parent_rate)
+{
+	struct clk_audio_pad *apad_ck = to_clk_audio_pad(hw);
+	unsigned long apad_rate = 0;
+	u8 tmp_div = AUDIO_PLL_QD2DIV(apad_ck->qdpad);
+	u8 tmp_ext_div = AUDIO_PLL_QD2EXTDIV(apad_ck->qdpad);
+
+	if (tmp_div && tmp_ext_div)
+		apad_rate = parent_rate / (tmp_div * tmp_ext_div);
+
+	pr_debug("A PLL/PAD: %s, apad_rate = %lu (div = %u, ext_div = %u)\n",
+		 __func__, apad_rate, tmp_div, tmp_ext_div);
+
+	return apad_rate;
+}
+
+static int clk_audio_pll_compute_qdpad(unsigned long q_rate, unsigned long rate,
+				       unsigned long *qd, u8 *div, u8 *ext_div)
+{
+	unsigned long tmp_qd;
+	unsigned long rem2, rem3;
+	unsigned long ldiv, lext_div;
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
+	pr_debug("A PLL/PAD: %s, qd = %lu (div = %lu, ext_div = %lu)\n",
+		 __func__, ldiv * lext_div, ldiv, lext_div);
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
+	struct clk *pclk = __clk_get_parent(hw->clk);
+	long best_rate = -EINVAL;
+	unsigned long best_parent_rate = 0;
+	unsigned long tmp_qd;
+
+	pr_debug("A PLL/PAD: %s, rate = %lu (parent_rate = %lu)\n",
+		 __func__, rate, *parent_rate);
+
+	if (clk_audio_pll_compute_qdpad(AUDIO_PLL_REFERENCE_FOUT, rate,
+					&tmp_qd, NULL, NULL))
+		return -EINVAL;
+
+	best_parent_rate = __clk_round_rate(pclk, rate * tmp_qd);
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
+	pr_debug("A PLL/PAD: %s, rate = %lu (parent_rate = %lu)\n",
+		 __func__, rate, parent_rate);
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
+void __init of_sama5d2_clk_audio_pll_pad_setup(struct device_node *np,
+					       struct at91_pmc *pmc)
+{
+	struct clk_audio_pad *apad_ck;
+	struct clk *clk = NULL;
+	struct clk_init_data init;
+	const char *parent_name;
+	const char *name = np->name;
+
+	parent_name = of_clk_get_parent_name(np, 0);
+
+	of_property_read_string(np, "clock-output-names", &name);
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
+	apad_ck->pmc = pmc;
+
+	clk = clk_register(NULL, &apad_ck->hw);
+	if (IS_ERR(clk))
+		kfree(apad_ck);
+	else
+		of_clk_add_provider(np, of_clk_src_simple_get, clk);
+}
diff --git a/drivers/clk/at91/clk-audio-pll-pmc.c b/drivers/clk/at91/clk-audio-pll-pmc.c
new file mode 100644
index 000000000000..365b51a6cbfd
--- /dev/null
+++ b/drivers/clk/at91/clk-audio-pll-pmc.c
@@ -0,0 +1,171 @@
+/*
+ *  Copyright (C) 2015 Atmel Corporation,
+ *                     Nicolas Ferre <nicolas.ferre@atmel.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/clkdev.h>
+#include <linux/clk/at91_pmc.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/io.h>
+
+#include "pmc.h"
+
+#define AUDIO_PLL_REFERENCE_FOUT	700000000
+#define AUDIO_PLL_QDPMC_MAX		(AT91_PMC_AUDIO_PLL_QDPMC_MASK >> \
+						AT91_PMC_AUDIO_PLL_QDPMC_OFFSET)
+struct clk_audio_pmc {
+	struct clk_hw hw;
+	struct at91_pmc *pmc;
+	u8 qdpmc;
+};
+
+#define to_clk_audio_pmc(hw) container_of(hw, struct clk_audio_pmc, hw)
+
+static int clk_audio_pll_pmc_enable(struct clk_hw *hw)
+{
+	struct clk_audio_pmc *apmc_ck = to_clk_audio_pmc(hw);
+	struct at91_pmc *pmc = apmc_ck->pmc;
+	u32 tmp;
+
+	pmc_lock(pmc);
+	tmp = pmc_read(pmc, AT91_PMC_AUDIO_PLL0) &
+				~AT91_PMC_AUDIO_PLL_QDPMC_MASK;
+	tmp |= AT91_PMC_AUDIO_PLL_PMCEN |
+				AT91_PMC_AUDIO_PLL_QDPMC(apmc_ck->qdpmc);
+	pmc_write(pmc, AT91_PMC_AUDIO_PLL0, tmp);
+	pmc_unlock(pmc);
+	return 0;
+}
+
+static void clk_audio_pll_pmc_disable(struct clk_hw *hw)
+{
+	struct clk_audio_pmc *apmc_ck = to_clk_audio_pmc(hw);
+	struct at91_pmc *pmc = apmc_ck->pmc;
+	u32 tmp;
+
+	pmc_lock(pmc);
+	tmp = pmc_read(pmc, AT91_PMC_AUDIO_PLL0) & ~AT91_PMC_AUDIO_PLL_PMCEN;
+	pmc_write(pmc, AT91_PMC_AUDIO_PLL0, tmp);
+	pmc_unlock(pmc);
+}
+
+static unsigned long clk_audio_pll_pmc_recalc_rate(struct clk_hw *hw,
+						   unsigned long parent_rate)
+{
+	struct clk_audio_pmc *apmc_ck = to_clk_audio_pmc(hw);
+	unsigned long apmc_rate = 0;
+
+	apmc_rate = parent_rate / (apmc_ck->qdpmc + 1);
+
+	pr_debug("A PLL/PMC: %s, apmc_rate = %lu (qdpmc = %u)\n",
+		 __func__, apmc_rate, apmc_ck->qdpmc);
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
+	struct clk *pclk = __clk_get_parent(hw->clk);
+	long best_rate = -EINVAL;
+	unsigned long best_parent_rate = 0;
+	unsigned long tmp_qd;
+
+	pr_debug("A PLL/PMC: %s, rate = %lu (parent_rate = %lu)\n",
+		 __func__, rate, *parent_rate);
+
+	if (clk_audio_pll_compute_qdpmc(AUDIO_PLL_REFERENCE_FOUT, rate, &tmp_qd))
+		return -EINVAL;
+
+	best_parent_rate = __clk_round_rate(pclk, rate * tmp_qd);
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
+	pr_debug("A PLL/PMC: %s, rate = %lu (parent_rate = %lu)\n",
+		 __func__, rate, parent_rate);
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
+void __init of_sama5d2_clk_audio_pll_pmc_setup(struct device_node *np,
+					       struct at91_pmc *pmc)
+{
+	struct clk_audio_pmc *apmc_ck;
+	struct clk *clk = NULL;
+	struct clk_init_data init;
+	const char *parent_name;
+	const char *name = np->name;
+
+	parent_name = of_clk_get_parent_name(np, 0);
+
+	of_property_read_string(np, "clock-output-names", &name);
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
+	apmc_ck->pmc = pmc;
+
+	clk = clk_register(NULL, &apmc_ck->hw);
+	if (IS_ERR(clk))
+		kfree(apmc_ck);
+	else
+		of_clk_add_provider(np, of_clk_src_simple_get, clk);
+}
diff --git a/drivers/clk/at91/clk-audio-pll.c b/drivers/clk/at91/clk-audio-pll.c
new file mode 100644
index 000000000000..f00898d578f7
--- /dev/null
+++ b/drivers/clk/at91/clk-audio-pll.c
@@ -0,0 +1,261 @@
+/*
+ *  Copyright (C) 2015 Atmel Corporation,
+ *		       Songjun Wu <songjun.wu@atmel.com>,
+ *                     Nicolas Ferre <nicolas.ferre@atmel.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * Here is a little diagram of the audio pll clock tree:
+ *
+ *         Main clk (often @ 12 MHz)
+ *                |
+ *          -------------
+ *          | audio PLL |
+ *          |(ND, FRACR)|
+ *          -------------
+ *                |
+ *             -------  Fout ~ 700 MHz
+ *             |     |
+ *   ------------   ------------
+ *   | / QDPMC  |   | / QDAUDIO|
+ *   ------------   ------------
+ *        |               |
+ *    ---------          [_]
+ *    |  PMC  |        AUDIO PAD
+ *    ---------
+ *     |     |
+ *    Prog  Generated
+ *    CK    CK
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/clkdev.h>
+#include <linux/clk/at91_pmc.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/io.h>
+
+#include "pmc.h"
+
+#define AUDIO_PLL_DIV_FRAC	(1 << 22)
+#define AUDIO_PLL_ND_MAX	(AT91_PMC_AUDIO_PLL_ND_MASK >> \
+					AT91_PMC_AUDIO_PLL_ND_OFFSET)
+
+#define DIV_ROUND_CLOSEST_ULL(ll, d)	\
+({ unsigned long long _tmp = (ll) + (d) / 2; do_div(_tmp, d); _tmp; })
+
+struct clk_audio_frac {
+	struct clk_hw hw;
+	struct at91_pmc *pmc;
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
+	struct at91_pmc *pmc = fck->pmc;
+	u32 tmp;
+
+	pmc_lock(pmc);
+	tmp = pmc_read(pmc, AT91_PMC_AUDIO_PLL0) & ~AT91_PMC_AUDIO_PLL_RESETN;
+	pmc_write(pmc, AT91_PMC_AUDIO_PLL0, tmp);
+	pmc_unlock(pmc);
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
+	struct at91_pmc *pmc = fck->pmc;
+	u32 tmp, tmp2;
+
+	pmc_lock(pmc);
+	tmp = pmc_read(pmc, AT91_PMC_AUDIO_PLL0);
+	pmc_write(pmc, AT91_PMC_AUDIO_PLL0, tmp | AT91_PMC_AUDIO_PLL_RESETN);
+	tmp2 = pmc_read(pmc, AT91_PMC_AUDIO_PLL1) &
+						~AT91_PMC_AUDIO_PLL_FRACR_MASK;
+	pmc_write(pmc, AT91_PMC_AUDIO_PLL1, tmp2 | fck->fracr);
+
+	/*
+	 * reset and enabled have to be done in 2 separated writes
+	 * for AT91_PMC_AUDIO_PLL0
+	 */
+	tmp &= ~AT91_PMC_AUDIO_PLL_ND_MASK;
+	tmp |= AT91_PMC_AUDIO_PLL_RESETN | AT91_PMC_AUDIO_PLL_PLLEN
+					 | AT91_PMC_AUDIO_PLL_ND(fck->nd);
+	pmc_write(pmc, AT91_PMC_AUDIO_PLL0, tmp);
+	pmc_unlock(pmc);
+	return 0;
+}
+
+static void clk_audio_pll_disable(struct clk_hw *hw)
+{
+	struct clk_audio_frac *fck = to_clk_audio_frac(hw);
+	struct at91_pmc *pmc = fck->pmc;
+	u32 tmp;
+
+	pmc_lock(pmc);
+	tmp = pmc_read(pmc, AT91_PMC_AUDIO_PLL0) & ~AT91_PMC_AUDIO_PLL_PLLEN;
+	pmc_write(pmc, AT91_PMC_AUDIO_PLL0, tmp);
+	/* do it in 2 separated writes */
+	pmc_write(pmc, AT91_PMC_AUDIO_PLL0, tmp & ~AT91_PMC_AUDIO_PLL_RESETN);
+	pmc_unlock(pmc);
+}
+
+static unsigned long clk_audio_pll_fout(unsigned long parent_rate,
+					unsigned long nd, unsigned long fracr)
+{
+	unsigned long long fr = (unsigned long long)parent_rate *
+						(unsigned long long)fracr;
+
+	pr_debug("A PLL: %s, fr = %llu\n",
+		 __func__, fr);
+
+	fr = DIV_ROUND_CLOSEST_ULL(fr, AUDIO_PLL_DIV_FRAC);
+
+	pr_debug("A PLL: %s, fr = %llu\n",
+		 __func__, fr);
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
+	pr_debug("A PLL: %s, fout = %lu (nd = %u, fracr = %lu)\n",
+		 __func__, fout, fck->nd, (unsigned long)fck->fracr);
+
+	return fout;
+}
+
+static int clk_audio_pll_compute_frac(unsigned long rate,
+				      unsigned long parent_rate,
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
+	pr_debug("A PLL: %s, rate = %lu (parent_rate = %lu)\n",
+		 __func__, rate, *parent_rate);
+
+	ret = clk_audio_pll_compute_frac(rate, *parent_rate, &nd, &fracr);
+	if (ret)
+		return ret;
+
+	best_rate = clk_audio_pll_fout(*parent_rate, nd, fracr);
+
+	pr_debug("A PLL: %s, best_rate = %lu (nd = %lu, fracr = %lu)\n",
+		 __func__, best_rate, nd, fracr);
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
+	pr_debug("A PLL: %s, rate = %lu (parent_rate = %lu)\n",
+		 __func__, rate, parent_rate);
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
+void __init of_sama5d2_clk_audio_pll_setup(struct device_node *np,
+					   struct at91_pmc *pmc)
+{
+	struct clk_audio_frac *fck;
+	struct clk *clk = NULL;
+	struct clk_init_data init;
+	const char *parent_name;
+	const char *name = np->name;
+
+	parent_name = of_clk_get_parent_name(np, 0);
+
+	of_property_read_string(np, "clock-output-names", &name);
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
+	fck->pmc = pmc;
+
+	clk = clk_register(NULL, &fck->hw);
+	if (IS_ERR(clk))
+		kfree(fck);
+	else
+		of_clk_add_provider(np, of_clk_src_simple_get, clk);
+}
diff --git a/drivers/clk/at91/pmc.c b/drivers/clk/at91/pmc.c
index 1ef44c9fae8d..f81ebc9c1486 100644
--- a/drivers/clk/at91/pmc.c
+++ b/drivers/clk/at91/pmc.c
@@ -307,6 +307,20 @@ static const struct of_device_id pmc_clk_ids[] __initconst = {
 		.compatible = "atmel,at91sam9x5-clk-plldiv",
 		.data = of_at91sam9x5_clk_plldiv_setup,
 	},
+#if defined(CONFIG_HAVE_AT91_AUDIO_PLL)
+	{
+		.compatible = "atmel,sama5d2-clk-audio-pll-frac",
+		.data = of_sama5d2_clk_audio_pll_setup,
+	},
+	{
+		.compatible = "atmel,sama5d2-clk-audio-pll-pad",
+		.data = of_sama5d2_clk_audio_pll_pad_setup,
+	},
+	{
+		.compatible = "atmel,sama5d2-clk-audio-pll-pmc",
+		.data = of_sama5d2_clk_audio_pll_pmc_setup,
+	},
+#endif
 	/* Master clock */
 	{
 		.compatible = "atmel,at91rm9200-clk-master",
diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index f65739272779..8f21fb7fd939 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -82,6 +82,13 @@ void of_sama5d3_clk_pll_setup(struct device_node *np,
 void of_at91sam9x5_clk_plldiv_setup(struct device_node *np,
 				    struct at91_pmc *pmc);
 
+void of_sama5d2_clk_audio_pll_setup(struct device_node *np,
+				    struct at91_pmc *pmc);
+void of_sama5d2_clk_audio_pll_pmc_setup(struct device_node *np,
+					struct at91_pmc *pmc);
+void of_sama5d2_clk_audio_pll_pad_setup(struct device_node *np,
+					struct at91_pmc *pmc);
+
 void of_at91rm9200_clk_master_setup(struct device_node *np,
 				    struct at91_pmc *pmc);
 void of_at91sam9x5_clk_master_setup(struct device_node *np,
diff --git a/include/linux/clk/at91_pmc.h b/include/linux/clk/at91_pmc.h
index 1e6932222e11..975ecd971632 100644
--- a/include/linux/clk/at91_pmc.h
+++ b/include/linux/clk/at91_pmc.h
@@ -197,4 +197,29 @@ extern void __iomem *at91_pmc_base;
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
2.1.3
