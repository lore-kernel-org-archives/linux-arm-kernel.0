From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 30 Sep 2015 18:11:00 +0200
Subject: [PATCH 07/16] clk: at91: make IRQ optional and register them later
In-Reply-To: <1443629469-15086-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1443629469-15086-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1443629469-15086-8-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The AT91 clock drivers make use of IRQs to avoid polling when waiting for
some clocks to be enabled. Unfortunately, this leads to a crash when those
IRQs are threaded (which happens when using preempt-rt) because they are
registered before thread creation is possible.

Use polling on those clocks until the IRQ is registered and register the
IRQ at module probe time.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/clk/at91/clk-main.c   | 152 ++++++++++++++++++++++--------------------
 drivers/clk/at91/clk-master.c |  74 ++++++++++++++------
 drivers/clk/at91/clk-pll.c    |  75 +++++++++++++++------
 drivers/clk/at91/clk-system.c |  79 +++++++++++++++-------
 drivers/clk/at91/clk-utmi.c   |  75 ++++++++++++++-------
 drivers/clk/at91/pmc.c        |  98 ++++++++++++---------------
 6 files changed, 336 insertions(+), 217 deletions(-)

diff --git a/drivers/clk/at91/clk-main.c b/drivers/clk/at91/clk-main.c
index 79a380cd1f4e..ab8824d78a68 100644
--- a/drivers/clk/at91/clk-main.c
+++ b/drivers/clk/at91/clk-main.c
@@ -8,6 +8,7 @@
  *
  */
 
+#include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/clkdev.h>
 #include <linux/clk/at91_pmc.h>
@@ -22,6 +23,8 @@
 #include <linux/regmap.h>
 #include <linux/sched.h>
 #include <linux/wait.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
 
 #include "pmc.h"
 
@@ -117,9 +120,13 @@ static int clk_main_osc_prepare(struct clk_hw *hw)
 	}
 
 	while (!clk_main_osc_ready(regmap)) {
-		enable_irq(osc->irq);
-		wait_event(osc->wait,
-			   clk_main_osc_ready(regmap));
+		if (osc->irq) {
+			enable_irq(osc->irq);
+			wait_event(osc->wait,
+				   clk_main_osc_ready(regmap));
+		} else {
+			cpu_relax();
+		}
 	}
 
 	return 0;
@@ -165,17 +172,15 @@ static const struct clk_ops main_osc_ops = {
 
 static struct clk * __init
 at91_clk_register_main_osc(struct regmap *regmap,
-			   unsigned int irq,
 			   const char *name,
 			   const char *parent_name,
 			   bool bypass)
 {
-	int ret;
 	struct clk_main_osc *osc;
 	struct clk *clk = NULL;
 	struct clk_init_data init;
 
-	if (!irq || !name || !parent_name)
+	if (!name || !parent_name)
 		return ERR_PTR(-EINVAL);
 
 	osc = kzalloc(sizeof(*osc), GFP_KERNEL);
@@ -190,16 +195,6 @@ at91_clk_register_main_osc(struct regmap *regmap,
 
 	osc->hw.init = &init;
 	osc->regmap = regmap;
-	osc->irq = irq;
-
-	init_waitqueue_head(&osc->wait);
-	irq_set_status_flags(osc->irq, IRQ_NOAUTOEN);
-	ret = request_irq(osc->irq, clk_main_irq_handler,
-			  IRQF_TRIGGER_HIGH, name, osc);
-	if (ret) {
-		kfree(osc);
-		return ERR_PTR(ret);
-	}
 
 	if (bypass)
 		regmap_update_bits(regmap,
@@ -208,10 +203,8 @@ at91_clk_register_main_osc(struct regmap *regmap,
 				   AT91_PMC_OSCBYPASS | AT91_PMC_KEY);
 
 	clk = clk_register(NULL, &osc->hw);
-	if (IS_ERR(clk)) {
-		free_irq(irq, osc);
+	if (IS_ERR(clk))
 		kfree(osc);
-	}
 
 	return clk;
 }
@@ -219,7 +212,6 @@ at91_clk_register_main_osc(struct regmap *regmap,
 static void __init of_at91rm9200_clk_main_osc_setup(struct device_node *np)
 {
 	struct clk *clk;
-	unsigned int irq;
 	const char *name = np->name;
 	const char *parent_name;
 	struct regmap *regmap;
@@ -233,11 +225,7 @@ static void __init of_at91rm9200_clk_main_osc_setup(struct device_node *np)
 	if (IS_ERR(regmap))
 		return;
 
-	irq = irq_of_parse_and_map(np, 0);
-	if (!irq)
-		return;
-
-	clk = at91_clk_register_main_osc(regmap, irq, name, parent_name, bypass);
+	clk = at91_clk_register_main_osc(regmap, name, parent_name, bypass);
 	if (IS_ERR(clk))
 		return;
 
@@ -269,9 +257,13 @@ static int clk_main_rc_osc_prepare(struct clk_hw *hw)
 				   AT91_PMC_MOSCRCEN | AT91_PMC_KEY);
 
 	while (!clk_main_rc_osc_ready(regmap)) {
-		enable_irq(osc->irq);
-		wait_event(osc->wait,
-			   clk_main_rc_osc_ready(regmap));
+		if (osc->irq) {
+			enable_irq(osc->irq);
+			wait_event(osc->wait,
+				   clk_main_rc_osc_ready(regmap));
+		} else {
+			cpu_relax();
+		}
 	}
 
 	return 0;
@@ -330,11 +322,9 @@ static const struct clk_ops main_rc_osc_ops = {
 
 static struct clk * __init
 at91_clk_register_main_rc_osc(struct regmap *regmap,
-			      unsigned int irq,
 			      const char *name,
 			      u32 frequency, u32 accuracy)
 {
-	int ret;
 	struct clk_main_rc_osc *osc;
 	struct clk *clk = NULL;
 	struct clk_init_data init;
@@ -354,22 +344,12 @@ at91_clk_register_main_rc_osc(struct regmap *regmap,
 
 	osc->hw.init = &init;
 	osc->regmap = regmap;
-	osc->irq = irq;
 	osc->frequency = frequency;
 	osc->accuracy = accuracy;
 
-	init_waitqueue_head(&osc->wait);
-	irq_set_status_flags(osc->irq, IRQ_NOAUTOEN);
-	ret = request_irq(osc->irq, clk_main_irq_handler,
-			  IRQF_TRIGGER_HIGH, name, osc);
-	if (ret)
-		return ERR_PTR(ret);
-
 	clk = clk_register(NULL, &osc->hw);
-	if (IS_ERR(clk)) {
-		free_irq(irq, osc);
+	if (IS_ERR(clk))
 		kfree(osc);
-	}
 
 	return clk;
 }
@@ -377,7 +357,6 @@ at91_clk_register_main_rc_osc(struct regmap *regmap,
 static void __init of_at91sam9x5_clk_main_rc_osc_setup(struct device_node *np)
 {
 	struct clk *clk;
-	unsigned int irq;
 	u32 frequency = 0;
 	u32 accuracy = 0;
 	const char *name = np->name;
@@ -387,16 +366,11 @@ static void __init of_at91sam9x5_clk_main_rc_osc_setup(struct device_node *np)
 	of_property_read_u32(np, "clock-frequency", &frequency);
 	of_property_read_u32(np, "clock-accuracy", &accuracy);
 
-	irq = irq_of_parse_and_map(np, 0);
-	if (!irq)
-		return;
-
 	regmap = syscon_node_to_regmap(of_get_parent(np));
 	if (IS_ERR(regmap))
 		return;
 
-	clk = at91_clk_register_main_rc_osc(regmap, irq, name, frequency,
-					    accuracy);
+	clk = at91_clk_register_main_rc_osc(regmap, name, frequency, accuracy);
 	if (IS_ERR(clk))
 		return;
 
@@ -543,9 +517,13 @@ static int clk_sam9x5_main_prepare(struct clk_hw *hw)
 	struct regmap *regmap = clkmain->regmap;
 
 	while (!clk_sam9x5_main_ready(regmap)) {
-		enable_irq(clkmain->irq);
-		wait_event(clkmain->wait,
-			   clk_sam9x5_main_ready(regmap));
+		if (clkmain->irq) {
+			enable_irq(clkmain->irq);
+			wait_event(clkmain->wait,
+				   clk_sam9x5_main_ready(regmap));
+		} else {
+			cpu_relax();
+		}
 	}
 
 	return clk_main_probe_frequency(regmap);
@@ -584,9 +562,13 @@ static int clk_sam9x5_main_set_parent(struct clk_hw *hw, u8 index)
 		regmap_write(regmap, AT91_CKGR_MOR, tmp & ~AT91_PMC_MOSCSEL);
 
 	while (!clk_sam9x5_main_ready(regmap)) {
-		enable_irq(clkmain->irq);
-		wait_event(clkmain->wait,
-			   clk_sam9x5_main_ready(regmap));
+		if (clkmain->irq) {
+			enable_irq(clkmain->irq);
+			wait_event(clkmain->wait,
+				   clk_sam9x5_main_ready(regmap));
+		} else {
+			cpu_relax();
+		}
 	}
 
 	return 0;
@@ -612,12 +594,10 @@ static const struct clk_ops sam9x5_main_ops = {
 
 static struct clk * __init
 at91_clk_register_sam9x5_main(struct regmap *regmap,
-			      unsigned int irq,
 			      const char *name,
 			      const char **parent_names,
 			      int num_parents)
 {
-	int ret;
 	struct clk_sam9x5_main *clkmain;
 	struct clk *clk = NULL;
 	struct clk_init_data init;
@@ -641,21 +621,12 @@ at91_clk_register_sam9x5_main(struct regmap *regmap,
 
 	clkmain->hw.init = &init;
 	clkmain->regmap = regmap;
-	clkmain->irq = irq;
 	regmap_read(clkmain->regmap, AT91_CKGR_MOR, &status);
 	clkmain->parent = status & AT91_PMC_MOSCEN ? 1 : 0;
-	init_waitqueue_head(&clkmain->wait);
-	irq_set_status_flags(clkmain->irq, IRQ_NOAUTOEN);
-	ret = request_irq(clkmain->irq, clk_main_irq_handler,
-			  IRQF_TRIGGER_HIGH, name, clkmain);
-	if (ret)
-		return ERR_PTR(ret);
 
 	clk = clk_register(NULL, &clkmain->hw);
-	if (IS_ERR(clk)) {
-		free_irq(clkmain->irq, clkmain);
+	if (IS_ERR(clk))
 		kfree(clkmain);
-	}
 
 	return clk;
 }
@@ -665,7 +636,6 @@ static void __init of_at91sam9x5_clk_main_setup(struct device_node *np)
 	struct clk *clk;
 	const char *parent_names[2];
 	int num_parents;
-	unsigned int irq;
 	const char *name = np->name;
 	struct regmap *regmap;
 
@@ -680,11 +650,7 @@ static void __init of_at91sam9x5_clk_main_setup(struct device_node *np)
 
 	of_property_read_string(np, "clock-output-names", &name);
 
-	irq = irq_of_parse_and_map(np, 0);
-	if (!irq)
-		return;
-
-	clk = at91_clk_register_sam9x5_main(regmap, irq, name, parent_names,
+	clk = at91_clk_register_sam9x5_main(regmap, name, parent_names,
 					    num_parents);
 	if (IS_ERR(clk))
 		return;
@@ -693,3 +659,45 @@ static void __init of_at91sam9x5_clk_main_setup(struct device_node *np)
 }
 CLK_OF_DECLARE(at91sam9x5_clk_main, "atmel,at91sam9x5-clk-main",
 	       of_at91sam9x5_clk_main_setup);
+
+static const struct of_device_id atmel_clk_main_dt_ids[] = {
+	{ .compatible = "atmel,at91rm9200-clk-main-osc" },
+	{ .compatible = "atmel,at91sam9x5-clk-main-rc-osc" },
+	{ .compatible = "atmel,at91sam9x5-clk-main" },
+	{ /* sentinel */ }
+};
+
+static int __init atmel_clk_main_probe(struct platform_device *pdev)
+{
+	struct of_phandle_args clkspec = { .np = pdev->dev.of_node};
+	struct clk_main *clkmain;
+	struct clk_hw *hw;
+	int ret;
+
+	hw = __clk_get_hw(of_clk_get_from_provider(&clkspec));
+	if (!hw)
+		return -ENODEV;
+
+	clkmain = to_clk_main(hw);
+	clkmain->irq = platform_get_irq(pdev, 0);
+	if (!clkmain->irq)
+		return 0;
+
+	init_waitqueue_head(&clkmain->wait);
+	irq_set_status_flags(clkmain->irq, IRQ_NOAUTOEN);
+	ret = devm_request_irq(&pdev->dev, clkmain->irq, clk_main_irq_handler,
+			       IRQF_TRIGGER_HIGH, __clk_get_name(hw->clk),
+			       clkmain);
+	if (ret)
+		clkmain->irq = 0;
+
+	return ret;
+}
+
+static struct platform_driver atmel_clk_main = {
+	.driver = {
+		.name = "atmel-clk-main",
+		.of_match_table = atmel_clk_main_dt_ids,
+	},
+};
+module_platform_driver_probe(atmel_clk_main, atmel_clk_main_probe);
diff --git a/drivers/clk/at91/clk-master.c b/drivers/clk/at91/clk-master.c
index 8d94ddfc9c72..700d0cbf5cd4 100644
--- a/drivers/clk/at91/clk-master.c
+++ b/drivers/clk/at91/clk-master.c
@@ -8,12 +8,15 @@
  *
  */
 
+#include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/clkdev.h>
 #include <linux/clk/at91_pmc.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/wait.h>
 #include <linux/sched.h>
@@ -77,9 +80,13 @@ static int clk_master_prepare(struct clk_hw *hw)
 	struct clk_master *master = to_clk_master(hw);
 
 	while (!clk_master_ready(master->regmap)) {
-		enable_irq(master->irq);
-		wait_event(master->wait,
-			   clk_master_ready(master->regmap));
+		if (master->irq) {
+			enable_irq(master->irq);
+			wait_event(master->wait,
+				   clk_master_ready(master->regmap));
+		} else {
+			cpu_relax();
+		}
 	}
 
 	return 0;
@@ -143,13 +150,12 @@ static const struct clk_ops master_ops = {
 };
 
 static struct clk * __init
-at91_clk_register_master(struct regmap *regmap, unsigned int irq,
+at91_clk_register_master(struct regmap *regmap,
 		const char *name, int num_parents,
 		const char **parent_names,
 		const struct clk_master_layout *layout,
 		const struct clk_master_characteristics *characteristics)
 {
-	int ret;
 	struct clk_master *master;
 	struct clk *clk = NULL;
 	struct clk_init_data init;
@@ -171,19 +177,9 @@ at91_clk_register_master(struct regmap *regmap, unsigned int irq,
 	master->layout = layout;
 	master->characteristics = characteristics;
 	master->regmap = regmap;
-	master->irq = irq;
-	init_waitqueue_head(&master->wait);
-	irq_set_status_flags(master->irq, IRQ_NOAUTOEN);
-	ret = request_irq(master->irq, clk_master_irq_handler,
-			  IRQF_TRIGGER_HIGH, "clk-master", master);
-	if (ret) {
-		kfree(master);
-		return ERR_PTR(ret);
-	}
 
 	clk = clk_register(NULL, &master->hw);
 	if (IS_ERR(clk)) {
-		free_irq(master->irq, master);
 		kfree(master);
 	}
 
@@ -233,7 +229,6 @@ of_at91_clk_master_setup(struct device_node *np,
 {
 	struct clk *clk;
 	int num_parents;
-	unsigned int irq;
 	const char *parent_names[MASTER_SOURCE_MAX];
 	const char *name = np->name;
 	struct clk_master_characteristics *characteristics;
@@ -255,11 +250,7 @@ of_at91_clk_master_setup(struct device_node *np,
 	if (IS_ERR(regmap))
 		return;
 
-	irq = irq_of_parse_and_map(np, 0);
-	if (!irq)
-		goto out_free_characteristics;
-
-	clk = at91_clk_register_master(regmap, irq, name, num_parents,
+	clk = at91_clk_register_master(regmap, name, num_parents,
 				       parent_names, layout,
 				       characteristics);
 	if (IS_ERR(clk))
@@ -285,3 +276,44 @@ static void __init of_at91sam9x5_clk_master_setup(struct device_node *np)
 }
 CLK_OF_DECLARE(at91sam9x5_clk_master, "atmel,at91sam9x5-clk-master",
 	       of_at91sam9x5_clk_master_setup);
+
+static const struct of_device_id atmel_clk_master_dt_ids[] = {
+	{ .compatible = "atmel,at91rm9200-clk-master" },
+	{ .compatible = "atmel,at91sam9x5-clk-master" },
+	{ /* sentinel */ }
+};
+
+static int __init atmel_clk_master_probe(struct platform_device *pdev)
+{
+	struct of_phandle_args clkspec = { .np = pdev->dev.of_node};
+	struct clk_master *master;
+	struct clk_hw *hw;
+	int ret;
+
+	hw = __clk_get_hw(of_clk_get_from_provider(&clkspec));
+	if (!hw)
+		return -ENODEV;
+
+	master = to_clk_master(hw);
+	master->irq = platform_get_irq(pdev, 0);
+	if (!master->irq)
+		return 0;
+
+	init_waitqueue_head(&master->wait);
+	irq_set_status_flags(master->irq, IRQ_NOAUTOEN);
+	ret = devm_request_irq(&pdev->dev, master->irq, clk_master_irq_handler,
+			       IRQF_TRIGGER_HIGH, __clk_get_name(hw->clk),
+			       master);
+	if (ret)
+		master->irq = 0;
+
+	return ret;
+}
+
+static struct platform_driver atmel_clk_master = {
+	.driver = {
+		.name = "atmel-clk-master",
+		.of_match_table = atmel_clk_master_dt_ids,
+	},
+};
+module_platform_driver_probe(atmel_clk_master, atmel_clk_master_probe);
diff --git a/drivers/clk/at91/clk-pll.c b/drivers/clk/at91/clk-pll.c
index 5f4c6ce628e0..0cf69865c2c8 100644
--- a/drivers/clk/at91/clk-pll.c
+++ b/drivers/clk/at91/clk-pll.c
@@ -8,6 +8,7 @@
  *
  */
 
+#include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/clkdev.h>
 #include <linux/clk/at91_pmc.h>
@@ -21,6 +22,8 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
 #include <linux/regmap.h>
 
 #include "pmc.h"
@@ -128,9 +131,13 @@ static int clk_pll_prepare(struct clk_hw *hw)
 			((pll->mul & layout->mul_mask) << layout->mul_shift));
 
 	while (!clk_pll_ready(regmap, pll->id)) {
-		enable_irq(pll->irq);
-		wait_event(pll->wait,
-			   clk_pll_ready(regmap, pll->id));
+		if (pll->irq) {
+			enable_irq(pll->irq);
+			wait_event(pll->wait,
+				   clk_pll_ready(regmap, pll->id));
+		} else {
+			cpu_relax();
+		}
 	}
 
 	return 0;
@@ -320,7 +327,7 @@ static const struct clk_ops pll_ops = {
 };
 
 static struct clk * __init
-at91_clk_register_pll(struct regmap *regmap, unsigned int irq, const char *name,
+at91_clk_register_pll(struct regmap *regmap, const char *name,
 		      const char *parent_name, u8 id,
 		      const struct clk_pll_layout *layout,
 		      const struct clk_pll_characteristics *characteristics)
@@ -328,7 +335,6 @@ at91_clk_register_pll(struct regmap *regmap, unsigned int irq, const char *name,
 	struct clk_pll *pll;
 	struct clk *clk = NULL;
 	struct clk_init_data init;
-	int ret;
 	int offset = PLL_REG(id);
 	unsigned int pllr;
 
@@ -350,22 +356,12 @@ at91_clk_register_pll(struct regmap *regmap, unsigned int irq, const char *name,
 	pll->layout = layout;
 	pll->characteristics = characteristics;
 	pll->regmap = regmap;
-	pll->irq = irq;
 	regmap_read(regmap, offset, &pllr);
 	pll->div = PLL_DIV(pllr);
 	pll->mul = PLL_MUL(pllr, layout);
-	init_waitqueue_head(&pll->wait);
-	irq_set_status_flags(pll->irq, IRQ_NOAUTOEN);
-	ret = request_irq(pll->irq, clk_pll_irq_handler, IRQF_TRIGGER_HIGH,
-			  id ? "clk-pllb" : "clk-plla", pll);
-	if (ret) {
-		kfree(pll);
-		return ERR_PTR(ret);
-	}
 
 	clk = clk_register(NULL, &pll->hw);
 	if (IS_ERR(clk)) {
-		free_irq(pll->irq, pll);
 		kfree(pll);
 	}
 
@@ -499,7 +495,6 @@ of_at91_clk_pll_setup(struct device_node *np,
 		      const struct clk_pll_layout *layout)
 {
 	u32 id;
-	unsigned int irq;
 	struct clk *clk;
 	struct regmap *regmap;
 	const char *parent_name;
@@ -521,11 +516,7 @@ of_at91_clk_pll_setup(struct device_node *np,
 	if (!characteristics)
 		return;
 
-	irq = irq_of_parse_and_map(np, 0);
-	if (!irq)
-		return;
-
-	clk = at91_clk_register_pll(regmap, irq, name, parent_name, id, layout,
+	clk = at91_clk_register_pll(regmap, name, parent_name, id, layout,
 				    characteristics);
 	if (IS_ERR(clk))
 		goto out_free_characteristics;
@@ -564,3 +555,45 @@ static void __init of_sama5d3_clk_pll_setup(struct device_node *np)
 }
 CLK_OF_DECLARE(sama5d3_clk_pll, "atmel,sama5d3-clk-pll",
 	       of_sama5d3_clk_pll_setup);
+
+static const struct of_device_id atmel_clk_pll_dt_ids[] = {
+	{ .compatible = "atmel,at91rm9200-clk-pll" },
+	{ .compatible = "atmel,at91sam9g45-clk-pll" },
+	{ .compatible = "atmel,at91sam9g20-clk-pllb" },
+	{ .compatible = "atmel,sama5d3-clk-pll" },
+	{ /* sentinel */ }
+};
+
+static int __init atmel_clk_pll_probe(struct platform_device *pdev)
+{
+	struct of_phandle_args clkspec = { .np = pdev->dev.of_node};
+	struct clk_pll *pll;
+	struct clk_hw *hw;
+	int ret;
+
+	hw = __clk_get_hw(of_clk_get_from_provider(&clkspec));
+	if (!hw)
+		return -ENODEV;
+
+	pll = to_clk_pll(hw);
+	pll->irq = platform_get_irq(pdev, 0);
+	if (!pll->irq)
+		return 0;
+
+	init_waitqueue_head(&pll->wait);
+	irq_set_status_flags(pll->irq, IRQ_NOAUTOEN);
+	ret = devm_request_irq(&pdev->dev, pll->irq, clk_pll_irq_handler,
+			       IRQF_TRIGGER_HIGH, __clk_get_name(hw->clk), pll);
+	if (ret)
+		pll->irq = 0;
+
+	return ret;
+}
+
+static struct platform_driver atmel_clk_pll = {
+	.driver = {
+		.name = "atmel-clk-pll",
+		.of_match_table = atmel_clk_pll_dt_ids,
+	},
+};
+module_platform_driver_probe(atmel_clk_pll, atmel_clk_pll_probe);
diff --git a/drivers/clk/at91/clk-system.c b/drivers/clk/at91/clk-system.c
index 0593adf1bf4b..d5fc7bbcc6b3 100644
--- a/drivers/clk/at91/clk-system.c
+++ b/drivers/clk/at91/clk-system.c
@@ -8,6 +8,7 @@
  *
  */
 
+#include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/clkdev.h>
 #include <linux/clk/at91_pmc.h>
@@ -20,6 +21,8 @@
 #include <linux/wait.h>
 #include <linux/sched.h>
 #include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
 #include <linux/regmap.h>
 
 #include "pmc.h"
@@ -41,6 +44,7 @@ static inline int is_pck(int id)
 {
 	return (id >= 8) && (id <= 15);
 }
+
 static irqreturn_t clk_system_irq_handler(int irq, void *dev_id)
 {
 	struct clk_system *sys = (struct clk_system *)dev_id;
@@ -114,12 +118,11 @@ static const struct clk_ops system_ops = {
 
 static struct clk * __init
 at91_clk_register_system(struct regmap *regmap, const char *name,
-			 const char *parent_name, u8 id, int irq)
+			 const char *parent_name, u8 id)
 {
 	struct clk_system *sys;
 	struct clk *clk = NULL;
 	struct clk_init_data init;
-	int ret;
 
 	if (!parent_name || id > SYSTEM_MAX_ID)
 		return ERR_PTR(-EINVAL);
@@ -137,24 +140,10 @@ at91_clk_register_system(struct regmap *regmap, const char *name,
 	sys->id = id;
 	sys->hw.init = &init;
 	sys->regmap = regmap;
-	sys->irq = irq;
-	if (irq) {
-		init_waitqueue_head(&sys->wait);
-		irq_set_status_flags(sys->irq, IRQ_NOAUTOEN);
-		ret = request_irq(sys->irq, clk_system_irq_handler,
-				IRQF_TRIGGER_HIGH, name, sys);
-		if (ret) {
-			kfree(sys);
-			return ERR_PTR(ret);
-		}
-	}
 
 	clk = clk_register(NULL, &sys->hw);
-	if (IS_ERR(clk)) {
-		if (irq)
-			free_irq(sys->irq, sys);
+	if (IS_ERR(clk))
 		kfree(sys);
-	}
 
 	return clk;
 }
@@ -162,7 +151,6 @@ at91_clk_register_system(struct regmap *regmap, const char *name,
 static void __init of_at91rm9200_clk_sys_setup(struct device_node *np)
 {
 	int num;
-	int irq = 0;
 	u32 id;
 	struct clk *clk;
 	const char *name;
@@ -185,13 +173,9 @@ static void __init of_at91rm9200_clk_sys_setup(struct device_node *np)
 		if (of_property_read_string(np, "clock-output-names", &name))
 			name = sysclknp->name;
 
-		if (is_pck(id))
-			irq = irq_of_parse_and_map(sysclknp, 0);
-
 		parent_name = of_clk_get_parent_name(sysclknp, 0);
 
-		clk = at91_clk_register_system(regmap, name, parent_name, id,
-					       irq);
+		clk = at91_clk_register_system(regmap, name, parent_name, id);
 		if (IS_ERR(clk))
 			continue;
 
@@ -200,3 +184,52 @@ static void __init of_at91rm9200_clk_sys_setup(struct device_node *np)
 }
 CLK_OF_DECLARE(at91rm9200_clk_sys, "atmel,at91rm9200-clk-system",
 	       of_at91rm9200_clk_sys_setup);
+
+static const struct of_device_id atmel_clk_sys_dt_ids[] = {
+	{ .compatible = "atmel,at91rm9200-clk-system" },
+	{ /* sentinel */ }
+};
+
+static int __init atmel_clk_sys_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct device_node *sysclknp;
+
+	for_each_child_of_node(np, sysclknp) {
+		struct of_phandle_args clkspec = { .np = sysclknp};
+		struct clk_hw *hw;
+		struct clk_system *sys;
+		int err;
+
+		hw = __clk_get_hw(of_clk_get_from_provider(&clkspec));
+		if (!hw)
+			continue;
+
+		sys = to_clk_system(hw);
+		if (!is_pck(sys->id))
+			continue;
+
+		sys->irq = irq_of_parse_and_map(sysclknp, 0);
+		if (!sys->irq)
+			continue;
+
+		init_waitqueue_head(&sys->wait);
+		irq_set_status_flags(sys->irq, IRQ_NOAUTOEN);
+		err = devm_request_irq(&pdev->dev, sys->irq,
+				       clk_system_irq_handler,
+				       IRQF_TRIGGER_HIGH,
+				       __clk_get_name(hw->clk), sys);
+		if (err)
+			sys->irq = 0;
+	}
+
+	return 0;
+}
+
+static struct platform_driver atmel_clk_sys = {
+	.driver = {
+		.name = "atmel-clk-sys",
+		.of_match_table = atmel_clk_sys_dt_ids,
+	},
+};
+module_platform_driver_probe(atmel_clk_sys, atmel_clk_sys_probe);
diff --git a/drivers/clk/at91/clk-utmi.c b/drivers/clk/at91/clk-utmi.c
index 58a310e5768c..1f2fbf3bd13e 100644
--- a/drivers/clk/at91/clk-utmi.c
+++ b/drivers/clk/at91/clk-utmi.c
@@ -8,6 +8,7 @@
  *
  */
 
+#include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/clkdev.h>
 #include <linux/clk/at91_pmc.h>
@@ -20,6 +21,8 @@
 #include <linux/sched.h>
 #include <linux/wait.h>
 #include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
 #include <linux/regmap.h>
 
 #include "pmc.h"
@@ -63,9 +66,13 @@ static int clk_utmi_prepare(struct clk_hw *hw)
 	regmap_update_bits(utmi->regmap, AT91_CKGR_UCKR, uckr, uckr);
 
 	while (!clk_utmi_ready(utmi->regmap)) {
-		enable_irq(utmi->irq);
-		wait_event(utmi->wait,
-			   clk_utmi_ready(utmi->regmap));
+		if (utmi->irq) {
+			enable_irq(utmi->irq);
+			wait_event(utmi->wait,
+				   clk_utmi_ready(utmi->regmap));
+		} else {
+			cpu_relax();
+		}
 	}
 
 	return 0;
@@ -100,10 +107,9 @@ static const struct clk_ops utmi_ops = {
 };
 
 static struct clk * __init
-at91_clk_register_utmi(struct regmap *regmap, unsigned int irq,
+at91_clk_register_utmi(struct regmap *regmap,
 		       const char *name, const char *parent_name)
 {
-	int ret;
 	struct clk_utmi *utmi;
 	struct clk *clk = NULL;
 	struct clk_init_data init;
@@ -120,28 +126,16 @@ at91_clk_register_utmi(struct regmap *regmap, unsigned int irq,
 
 	utmi->hw.init = &init;
 	utmi->regmap = regmap;
-	utmi->irq = irq;
-	init_waitqueue_head(&utmi->wait);
-	irq_set_status_flags(utmi->irq, IRQ_NOAUTOEN);
-	ret = request_irq(utmi->irq, clk_utmi_irq_handler,
-			  IRQF_TRIGGER_HIGH, "clk-utmi", utmi);
-	if (ret) {
-		kfree(utmi);
-		return ERR_PTR(ret);
-	}
 
 	clk = clk_register(NULL, &utmi->hw);
-	if (IS_ERR(clk)) {
-		free_irq(utmi->irq, utmi);
+	if (IS_ERR(clk))
 		kfree(utmi);
-	}
 
 	return clk;
 }
 
 static void __init of_at91sam9x5_clk_utmi_setup(struct device_node *np)
 {
-	unsigned int irq;
 	struct clk *clk;
 	const char *parent_name;
 	const char *name = np->name;
@@ -151,15 +145,11 @@ static void __init of_at91sam9x5_clk_utmi_setup(struct device_node *np)
 
 	of_property_read_string(np, "clock-output-names", &name);
 
-	irq = irq_of_parse_and_map(np, 0);
-	if (!irq)
-		return;
-
 	regmap = syscon_node_to_regmap(of_get_parent(np));
 	if (IS_ERR(regmap))
 		return;
 
-	clk = at91_clk_register_utmi(regmap, irq, name, parent_name);
+	clk = at91_clk_register_utmi(regmap, name, parent_name);
 	if (IS_ERR(clk))
 		return;
 
@@ -168,3 +158,42 @@ static void __init of_at91sam9x5_clk_utmi_setup(struct device_node *np)
 }
 CLK_OF_DECLARE(at91sam9x5_clk_utmi, "atmel,at91sam9x5-clk-utmi",
 	       of_at91sam9x5_clk_utmi_setup);
+
+static const struct of_device_id atmel_clk_utmi_dt_ids[] = {
+	{ .compatible = "atmel,at91sam9x5-clk-utmi" },
+	{ /* sentinel */ }
+};
+
+static int __init atmel_clk_utmi_probe(struct platform_device *pdev)
+{
+	struct of_phandle_args clkspec = { .np = pdev->dev.of_node};
+	struct clk_utmi *utmi;
+	struct clk_hw *hw;
+	int ret;
+
+	hw = __clk_get_hw(of_clk_get_from_provider(&clkspec));
+	if (!hw)
+		return -ENODEV;
+
+	utmi = to_clk_utmi(hw);
+	utmi->irq = platform_get_irq(pdev, 0);
+	if (!utmi->irq)
+		return 0;
+
+	init_waitqueue_head(&utmi->wait);
+	irq_set_status_flags(utmi->irq, IRQ_NOAUTOEN);
+	ret = devm_request_irq(&pdev->dev, utmi->irq, clk_utmi_irq_handler,
+			       IRQF_TRIGGER_HIGH, __clk_get_name(hw->clk), utmi);
+	if (ret)
+		utmi->irq = 0;
+
+	return ret;
+}
+
+static struct platform_driver atmel_clk_utmi = {
+	.driver = {
+		.name = "atmel-clk-utmi",
+		.of_match_table = atmel_clk_utmi_dt_ids,
+	},
+};
+module_platform_driver_probe(atmel_clk_utmi, atmel_clk_utmi_probe);
diff --git a/drivers/clk/at91/pmc.c b/drivers/clk/at91/pmc.c
index a1cc7afc5885..6c1f08a73373 100644
--- a/drivers/clk/at91/pmc.c
+++ b/drivers/clk/at91/pmc.c
@@ -20,6 +20,9 @@
 #include <linux/irqdomain.h>
 #include <linux/of_irq.h>
 #include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/regmap.h>
 
 #include <asm/proc-fns.h>
@@ -240,32 +243,29 @@ static struct at91_pmc *__init at91_pmc_init(struct device_node *np,
 	pmc->virq = virq;
 	pmc->caps = caps;
 
-	pmc->irqdomain = irq_domain_add_linear(np, 32, &pmc_irq_ops, pmc);
-	if (!pmc->irqdomain)
-		goto out_free_pmc;
-
-	regmap_write(pmc->regmap, AT91_PMC_IDR, 0xffffffff);
-	if (request_irq(pmc->virq, pmc_irq_handler,
-			IRQF_SHARED | IRQF_COND_SUSPEND, "pmc", pmc))
-		goto out_remove_irqdomain;
-
 	return pmc;
-
-out_remove_irqdomain:
-	irq_domain_remove(pmc->irqdomain);
-out_free_pmc:
-	kfree(pmc);
-
-	return NULL;
 }
 
-static void __init of_at91_pmc_setup(struct device_node *np,
-				     const struct at91_pmc_caps *caps)
+static const struct of_device_id atmel_pmc_dt_ids[] = {
+	{ .compatible = "atmel,at91rm9200-pmc", .data = &at91rm9200_caps },
+	{ .compatible = "atmel,at91sam9260-pmc", .data = &at91sam9260_caps },
+	{ .compatible = "atmel,at91sam9g45-pmc", .data = &at91sam9g45_caps },
+	{ .compatible = "atmel,at91sam9n12-pmc", .data = &at91sam9n12_caps },
+	{ .compatible = "atmel,at91sam9x5-pmc", .data = &at91sam9x5_caps },
+	{ .compatible = "atmel,sama5d3-pmc", .data = &sama5d3_caps },
+	{ /* sentinel */ },
+};
+
+static int __init atmel_pmc_probe(struct platform_device *pdev)
 {
+	const struct of_device_id *of_id;
+	const struct at91_pmc_caps *caps;
+	struct device_node *np = pdev->dev.of_node;
 	struct at91_pmc *pmc;
 	void __iomem *regbase = of_iomap(np, 0);
 	struct regmap *regmap;
 	int virq;
+	int ret = 0;
 
 	regmap = syscon_node_to_regmap(np);
 	if (IS_ERR(regmap))
@@ -273,51 +273,35 @@ static void __init of_at91_pmc_setup(struct device_node *np,
 
 	virq = irq_of_parse_and_map(np, 0);
 	if (!virq)
-		return;
+		return 0;
+
+	of_id = of_match_device(atmel_pmc_dt_ids, &pdev->dev);
+	caps = of_id->data;
 
 	pmc = at91_pmc_init(np, regmap, regbase, virq, caps);
 	if (!pmc)
-		return;
-}
+		return 0;
 
-static void __init of_at91rm9200_pmc_setup(struct device_node *np)
-{
-	of_at91_pmc_setup(np, &at91rm9200_caps);
-}
-CLK_OF_DECLARE(at91rm9200_clk_pmc, "atmel,at91rm9200-pmc",
-	       of_at91rm9200_pmc_setup);
-
-static void __init of_at91sam9260_pmc_setup(struct device_node *np)
-{
-	of_at91_pmc_setup(np, &at91sam9260_caps);
-}
-CLK_OF_DECLARE(at91sam9260_clk_pmc, "atmel,at91sam9260-pmc",
-	       of_at91sam9260_pmc_setup);
+	pmc->irqdomain = irq_domain_add_linear(pdev->dev.of_node, 32,
+					       &pmc_irq_ops, pmc);
+	if (!pmc->irqdomain)
+		return 0;
 
-static void __init of_at91sam9g45_pmc_setup(struct device_node *np)
-{
-	of_at91_pmc_setup(np, &at91sam9g45_caps);
-}
-CLK_OF_DECLARE(at91sam9g45_clk_pmc, "atmel,at91sam9g45-pmc",
-	       of_at91sam9g45_pmc_setup);
+	regmap_write(pmc->regmap, AT91_PMC_IDR, 0xffffffff);
+	ret = request_irq(pmc->virq, pmc_irq_handler,
+			  IRQF_SHARED | IRQF_COND_SUSPEND, "pmc", pmc);
+	if (ret)
+		return ret;
 
-static void __init of_at91sam9n12_pmc_setup(struct device_node *np)
-{
-	of_at91_pmc_setup(np, &at91sam9n12_caps);
-}
-CLK_OF_DECLARE(at91sam9n12_clk_pmc, "atmel,at91sam9n12-pmc",
-	       of_at91sam9n12_pmc_setup);
+	of_platform_populate(pdev->dev.of_node, NULL, NULL, &pdev->dev);
 
-static void __init of_at91sam9x5_pmc_setup(struct device_node *np)
-{
-	of_at91_pmc_setup(np, &at91sam9x5_caps);
+	return 0;
 }
-CLK_OF_DECLARE(at91sam9x5_clk_pmc, "atmel,at91sam9x5-pmc",
-	       of_at91sam9x5_pmc_setup);
 
-static void __init of_sama5d3_pmc_setup(struct device_node *np)
-{
-	of_at91_pmc_setup(np, &sama5d3_caps);
-}
-CLK_OF_DECLARE(sama5d3_clk_pmc, "atmel,sama5d3-pmc",
-	       of_sama5d3_pmc_setup);
+static struct platform_driver atmel_pmc = {
+	.driver = {
+		.name = "atmel-pmc",
+		.of_match_table = atmel_pmc_dt_ids,
+	},
+};
+module_platform_driver_probe(atmel_pmc, atmel_pmc_probe);
-- 
2.1.4
