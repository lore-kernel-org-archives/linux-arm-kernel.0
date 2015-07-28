From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 28 Jul 2015 18:08:05 +0200
Subject: [PATCH v4] clk: at91: add generated clock driver
Message-ID: <1438099685-5592-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a new type of clocks that can be provided to a peripheral.
In addition to the peripheral clock, this new clock that can use several
input clocks as parents can generate divided rates.
This would allow a peripheral to have finer grained clocks for generating
a baud rate, clocking an asynchronous part or having more
options in frequency.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---

Changes in v4:
- protect stored parent_id from incoherency
- use of of_count_phandle_with_args()
- collect Ack tag from Boris

Changes in v3:
- rebase on top of next-20150727
- make use of of_clk_parent_fill helper function
- change determine_rate() according to new prototype

Changes in v2:
- adapt to new xxx_determine_rate() callback prototype
- fix checkpatch errors and use __func__
- fix handling of clocks without clk-output-range property specified.
  Test if range.max is present before using it
- test clock id only at probe time instead of at each API call
- remove useless tests in clk_generated_set_rate()
- change the meaningless config HAVE_AT91_GENERATED to HAVE_AT91_GENERATED_CLK
- wrap some lines over 80 characters

 .../devicetree/bindings/clock/at91-clock.txt       |  35 +++
 arch/arm/mach-at91/Kconfig                         |   3 +
 drivers/clk/at91/Makefile                          |   1 +
 drivers/clk/at91/clk-generated.c                   | 313 +++++++++++++++++++++
 drivers/clk/at91/pmc.c                             |   6 +
 drivers/clk/at91/pmc.h                             |   3 +
 include/linux/clk/at91_pmc.h                       |   7 +
 7 files changed, 368 insertions(+)
 create mode 100644 drivers/clk/at91/clk-generated.c

diff --git a/Documentation/devicetree/bindings/clock/at91-clock.txt b/Documentation/devicetree/bindings/clock/at91-clock.txt
index 5ba6450693b9..5e737d2cd05d 100644
--- a/Documentation/devicetree/bindings/clock/at91-clock.txt
+++ b/Documentation/devicetree/bindings/clock/at91-clock.txt
@@ -77,6 +77,9 @@ Required properties:
 	"atmel,sama5d4-clk-h32mx":
 		at91 h32mx clock
 
+	"atmel,sama5d2-clk-generated":
+		at91 generated clock
+
 Required properties for SCKC node:
 - reg : defines the IO memory reserved for the SCKC.
 - #size-cells : shall be 0 (reg is used to encode clk id).
@@ -461,3 +464,35 @@ For example:
 		compatible = "atmel,sama5d4-clk-h32mx";
 		clocks = <&mck>;
 	};
+
+Required properties for generated clocks:
+- #size-cells : shall be 0 (reg is used to encode clk id).
+- #address-cells : shall be 1 (reg is used to encode clk id).
+- clocks : shall be the generated clock source phandles.
+	e.g. clocks = <&clk32k>, <&main>, <&plladiv>, <&utmi>, <&mck>;
+- name: device tree node describing a specific generated clock.
+	* #clock-cells : from common clock binding; shall be set to 0.
+	* reg: peripheral id. See Atmel's datasheets to get a full
+	  list of peripheral ids.
+	* atmel,clk-output-range : minimum and maximum clock frequency
+	  (two u32 fields).
+
+For example:
+	gck {
+		compatible = "atmel,sama5d2-clk-generated";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&clk32k>, <&main>, <&plladiv>, <&utmi>, <&mck>;
+
+		tcb0_gclk: tcb0_gclk {
+			#clock-cells = <0>;
+			reg = <35>;
+			atmel,clk-output-range = <0 83000000>;
+		};
+
+		pwm_gclk: pwm_gclk {
+			#clock-cells = <0>;
+			reg = <38>;
+			atmel,clk-output-range = <0 83000000>;
+		};
+	};
diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index fd95f34945f4..e8273e79f6ba 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -90,6 +90,9 @@ config HAVE_AT91_SMD
 config HAVE_AT91_H32MX
 	bool
 
+config HAVE_AT91_GENERATED_CLK
+	bool
+
 config SOC_SAM_V4_V5
 	bool
 
diff --git a/drivers/clk/at91/Makefile b/drivers/clk/at91/Makefile
index 89a48a7bd5df..13e67bd35cff 100644
--- a/drivers/clk/at91/Makefile
+++ b/drivers/clk/at91/Makefile
@@ -10,3 +10,4 @@ obj-$(CONFIG_HAVE_AT91_UTMI)		+= clk-utmi.o
 obj-$(CONFIG_HAVE_AT91_USB_CLK)		+= clk-usb.o
 obj-$(CONFIG_HAVE_AT91_SMD)		+= clk-smd.o
 obj-$(CONFIG_HAVE_AT91_H32MX)		+= clk-h32mx.o
+obj-$(CONFIG_HAVE_AT91_GENERATED_CLK)	+= clk-generated.o
diff --git a/drivers/clk/at91/clk-generated.c b/drivers/clk/at91/clk-generated.c
new file mode 100644
index 000000000000..642366f45742
--- /dev/null
+++ b/drivers/clk/at91/clk-generated.c
@@ -0,0 +1,313 @@
+/*
+ *  Copyright (C) 2015 Atmel Corporation,
+ *                     Nicolas Ferre <nicolas.ferre@atmel.com>
+ *
+ * Based on clk-programmable & clk-peripheral drivers by Boris BREZILLON.
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
+#define PERIPHERAL_MAX		64
+#define PERIPHERAL_ID_MIN	2
+
+#define GENERATED_SOURCE_MAX	6
+#define GENERATED_MAX_DIV	255
+
+struct clk_generated {
+	struct clk_hw hw;
+	struct at91_pmc *pmc;
+	struct clk_range range;
+	u32 id;
+	u32 gckdiv;
+	u8 parent_id;
+};
+
+#define to_clk_generated(hw) \
+	container_of(hw, struct clk_generated, hw)
+
+static int clk_generated_enable(struct clk_hw *hw)
+{
+	struct clk_generated *gck = to_clk_generated(hw);
+	struct at91_pmc *pmc = gck->pmc;
+	u32 tmp;
+
+	pr_debug("GCLK: %s, gckdiv = %d, parent id = %d\n",
+		 __func__, gck->gckdiv, gck->parent_id);
+
+	pmc_lock(pmc);
+	pmc_write(pmc, AT91_PMC_PCR, (gck->id & AT91_PMC_PCR_PID_MASK));
+	tmp = pmc_read(pmc, AT91_PMC_PCR) &
+			~(AT91_PMC_PCR_GCKDIV_MASK | AT91_PMC_PCR_GCKCSS_MASK);
+	pmc_write(pmc, AT91_PMC_PCR, tmp | AT91_PMC_PCR_GCKCSS(gck->parent_id)
+					 | AT91_PMC_PCR_CMD
+					 | AT91_PMC_PCR_GCKDIV(gck->gckdiv)
+					 | AT91_PMC_PCR_GCKEN);
+	pmc_unlock(pmc);
+	return 0;
+}
+
+static void clk_generated_disable(struct clk_hw *hw)
+{
+	struct clk_generated *gck = to_clk_generated(hw);
+	struct at91_pmc *pmc = gck->pmc;
+	u32 tmp;
+
+	pmc_lock(pmc);
+	pmc_write(pmc, AT91_PMC_PCR, (gck->id & AT91_PMC_PCR_PID_MASK));
+	tmp = pmc_read(pmc, AT91_PMC_PCR) & ~AT91_PMC_PCR_GCKEN;
+	pmc_write(pmc, AT91_PMC_PCR, tmp | AT91_PMC_PCR_CMD);
+	pmc_unlock(pmc);
+}
+
+static int clk_generated_is_enabled(struct clk_hw *hw)
+{
+	struct clk_generated *gck = to_clk_generated(hw);
+	struct at91_pmc *pmc = gck->pmc;
+	int ret;
+
+	pmc_lock(pmc);
+	pmc_write(pmc, AT91_PMC_PCR, (gck->id & AT91_PMC_PCR_PID_MASK));
+	ret = !!(pmc_read(pmc, AT91_PMC_PCR) & AT91_PMC_PCR_GCKEN);
+	pmc_unlock(pmc);
+
+	return ret;
+}
+
+static unsigned long
+clk_generated_recalc_rate(struct clk_hw *hw,
+			  unsigned long parent_rate)
+{
+	struct clk_generated *gck = to_clk_generated(hw);
+
+	return DIV_ROUND_CLOSEST(parent_rate, gck->gckdiv + 1);
+}
+
+static int clk_generated_determine_rate(struct clk_hw *hw,
+					struct clk_rate_request *req)
+{
+	struct clk_generated *gck = to_clk_generated(hw);
+	struct clk *parent = NULL;
+	long best_rate = -EINVAL;
+	unsigned long tmp_rate, min_rate;
+	int best_diff = -1;
+	int tmp_diff;
+	int i;
+
+	for (i = 0; i < __clk_get_num_parents(hw->clk); i++) {
+		u32 div;
+		unsigned long parent_rate;
+
+		parent = clk_get_parent_by_index(hw->clk, i);
+		if (!parent)
+			continue;
+
+		parent_rate = __clk_get_rate(parent);
+		min_rate = DIV_ROUND_CLOSEST(parent_rate, GENERATED_MAX_DIV + 1);
+		if (!parent_rate ||
+		    (gck->range.max && min_rate > gck->range.max))
+			continue;
+
+		for (div = 1; div < GENERATED_MAX_DIV + 2; div++) {
+			tmp_rate = DIV_ROUND_CLOSEST(parent_rate, div);
+			tmp_diff = abs(req->rate - tmp_rate);
+
+			if (best_diff < 0 || best_diff > tmp_diff) {
+				best_rate = tmp_rate;
+				best_diff = tmp_diff;
+				req->best_parent_rate = parent_rate;
+				req->best_parent_hw = __clk_get_hw(parent);
+			}
+
+			if (!best_diff || tmp_rate < req->rate)
+				break;
+		}
+
+		if (!best_diff)
+			break;
+	}
+
+	pr_debug("GCLK: %s, best_rate = %ld, parent clk: %s @ %ld\n",
+		 __func__, best_rate,
+		 __clk_get_name((req->best_parent_hw)->clk),
+		 req->best_parent_rate);
+
+	if (best_rate < 0)
+		return best_rate;
+
+	req->rate = best_rate;
+	return 0;
+}
+
+/* No modification of hardware as we have the flag CLK_SET_PARENT_GATE set */
+static int clk_generated_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct clk_generated *gck = to_clk_generated(hw);
+
+	if (index >= __clk_get_num_parents(hw->clk))
+		return -EINVAL;
+
+	gck->parent_id = index;
+	return 0;
+}
+
+static u8 clk_generated_get_parent(struct clk_hw *hw)
+{
+	struct clk_generated *gck = to_clk_generated(hw);
+
+	return gck->parent_id;
+}
+
+/* No modification of hardware as we have the flag CLK_SET_RATE_GATE set */
+static int clk_generated_set_rate(struct clk_hw *hw,
+				  unsigned long rate,
+				  unsigned long parent_rate)
+{
+	struct clk_generated *gck = to_clk_generated(hw);
+	u32 div;
+
+	if (!rate)
+		return -EINVAL;
+
+	if (gck->range.max && rate > gck->range.max)
+		return -EINVAL;
+
+	div = DIV_ROUND_CLOSEST(parent_rate, rate);
+	if (div > GENERATED_MAX_DIV + 1 || !div)
+		return -EINVAL;
+
+	gck->gckdiv = div - 1;
+	return 0;
+}
+
+static const struct clk_ops generated_ops = {
+	.enable = clk_generated_enable,
+	.disable = clk_generated_disable,
+	.is_enabled = clk_generated_is_enabled,
+	.recalc_rate = clk_generated_recalc_rate,
+	.determine_rate = clk_generated_determine_rate,
+	.get_parent = clk_generated_get_parent,
+	.set_parent = clk_generated_set_parent,
+	.set_rate = clk_generated_set_rate,
+};
+
+/**
+ * clk_generated_startup - Initialize a given clock to its default parent and
+ * divisor parameter.
+ *
+ * @gck:	Generated clock to set the startup parameters for.
+ *
+ * Take parameters from the hardware and update local clock configuration
+ * accordingly.
+ */
+static void clk_generated_startup(struct clk_generated *gck)
+{
+	struct at91_pmc *pmc = gck->pmc;
+	u32 tmp;
+
+	pmc_lock(pmc);
+	pmc_write(pmc, AT91_PMC_PCR, (gck->id & AT91_PMC_PCR_PID_MASK));
+	tmp = pmc_read(pmc, AT91_PMC_PCR);
+	pmc_unlock(pmc);
+
+	gck->parent_id = (tmp & AT91_PMC_PCR_GCKCSS_MASK)
+					>> AT91_PMC_PCR_GCKCSS_OFFSET;
+	/*
+	 * make sure that what we read in hardware is coherent with
+	 * what we've just probed
+	 */
+	if (gck->parent_id >= __clk_get_num_parents(gck->hw.clk))
+		gck->parent_id = 0;
+
+	gck->gckdiv = (tmp & AT91_PMC_PCR_GCKDIV_MASK)
+					>> AT91_PMC_PCR_GCKDIV_OFFSET;
+}
+
+static struct clk * __init
+at91_clk_register_generated(struct at91_pmc *pmc, const char *name,
+			    const char **parent_names, u8 num_parents,
+			    u8 id, const struct clk_range *range)
+{
+	struct clk_generated *gck;
+	struct clk *clk = NULL;
+	struct clk_init_data init;
+
+	gck = kzalloc(sizeof(*gck), GFP_KERNEL);
+	if (!gck)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.ops = &generated_ops;
+	init.parent_names = parent_names;
+	init.num_parents = num_parents;
+	init.flags = CLK_SET_RATE_GATE | CLK_SET_PARENT_GATE;
+
+	gck->id = id;
+	gck->hw.init = &init;
+	gck->pmc = pmc;
+	gck->range = *range;
+
+	clk = clk_register(NULL, &gck->hw);
+	if (IS_ERR(clk))
+		kfree(gck);
+	else
+		clk_generated_startup(gck);
+
+	return clk;
+}
+
+void __init of_sama5d2_clk_generated_setup(struct device_node *np,
+					   struct at91_pmc *pmc)
+{
+	int num;
+	u32 id;
+	const char *name;
+	struct clk *clk;
+	int num_parents;
+	const char *parent_names[GENERATED_SOURCE_MAX];
+	struct device_node *gcknp;
+	struct clk_range range = CLK_RANGE(0, 0);
+
+	num_parents = of_clk_get_parent_count(np);
+	if (num_parents <= 0 || num_parents > GENERATED_SOURCE_MAX)
+		return;
+
+	of_clk_parent_fill(np, parent_names, num_parents);
+
+	num = of_get_child_count(np);
+	if (!num || num > PERIPHERAL_MAX)
+		return;
+
+	for_each_child_of_node(np, gcknp) {
+		if (of_property_read_u32(gcknp, "reg", &id))
+			continue;
+
+		if (id < PERIPHERAL_ID_MIN || id >= PERIPHERAL_MAX)
+			continue;
+
+		if (of_property_read_string(np, "clock-output-names", &name))
+			name = gcknp->name;
+
+		of_at91_get_clk_range(gcknp, "atmel,clk-output-range",
+				      &range);
+
+		clk = at91_clk_register_generated(pmc, name, parent_names,
+						  num_parents, id, &range);
+		if (IS_ERR(clk))
+			continue;
+
+		of_clk_add_provider(gcknp, of_clk_src_simple_get, clk);
+	}
+}
diff --git a/drivers/clk/at91/pmc.c b/drivers/clk/at91/pmc.c
index 39be2be82b0a..3775d82c213d 100644
--- a/drivers/clk/at91/pmc.c
+++ b/drivers/clk/at91/pmc.c
@@ -370,6 +370,12 @@ static const struct of_device_id pmc_clk_ids[] __initconst = {
 		.data = of_sama5d4_clk_h32mx_setup,
 	},
 #endif
+#if defined(CONFIG_HAVE_AT91_GENERATED_CLK)
+	{
+		.compatible = "atmel,sama5d2-clk-generated",
+		.data = of_sama5d2_clk_generated_setup,
+	},
+#endif
 	{ /*sentinel*/ }
 };
 
diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index 8b87771c69b2..f65739272779 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -118,4 +118,7 @@ void of_at91sam9x5_clk_smd_setup(struct device_node *np,
 void of_sama5d4_clk_h32mx_setup(struct device_node *np,
 				struct at91_pmc *pmc);
 
+void of_sama5d2_clk_generated_setup(struct device_node *np,
+				    struct at91_pmc *pmc);
+
 #endif /* __PMC_H_ */
diff --git a/include/linux/clk/at91_pmc.h b/include/linux/clk/at91_pmc.h
index dfc59e2b64fb..ae61860e6892 100644
--- a/include/linux/clk/at91_pmc.h
+++ b/include/linux/clk/at91_pmc.h
@@ -183,10 +183,17 @@ extern void __iomem *at91_pmc_base;
 
 #define AT91_PMC_PCR		0x10c			/* Peripheral Control Register [some SAM9 and SAMA5] */
 #define		AT91_PMC_PCR_PID_MASK		0x3f
+#define		AT91_PMC_PCR_GCKCSS_OFFSET	8
+#define		AT91_PMC_PCR_GCKCSS_MASK	(0x7  << AT91_PMC_PCR_GCKCSS_OFFSET)
+#define		AT91_PMC_PCR_GCKCSS(n)		((n)  << AT91_PMC_PCR_GCKCSS_OFFSET)	/* GCK Clock Source Selection */
 #define		AT91_PMC_PCR_CMD		(0x1  <<  12)				/* Command (read=0, write=1) */
 #define		AT91_PMC_PCR_DIV_OFFSET		16
 #define		AT91_PMC_PCR_DIV_MASK		(0x3  << AT91_PMC_PCR_DIV_OFFSET)
 #define		AT91_PMC_PCR_DIV(n)		((n)  << AT91_PMC_PCR_DIV_OFFSET)	/* Divisor Value */
+#define		AT91_PMC_PCR_GCKDIV_OFFSET	20
+#define		AT91_PMC_PCR_GCKDIV_MASK	(0xff  << AT91_PMC_PCR_GCKDIV_OFFSET)
+#define		AT91_PMC_PCR_GCKDIV(n)		((n)  << AT91_PMC_PCR_GCKDIV_OFFSET)	/* Generated Clock Divisor Value */
 #define		AT91_PMC_PCR_EN			(0x1  <<  28)				/* Enable */
+#define		AT91_PMC_PCR_GCKEN		(0x1  <<  29)				/* GCK Enable */
 
 #endif
-- 
2.1.3
