From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 12 Oct 2015 16:28:41 +0200
Subject: [PATCH v2 04/14] clk: at91: clk-main: factorize irq handling
In-Reply-To: <1444660131-14954-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1444660131-14954-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1444660131-14954-5-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The three different irq handlers are doing the same thing, factorize their
code in a generic irq handler.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/clk/at91/clk-main.c | 144 +++++++++++++++++++-------------------------
 1 file changed, 63 insertions(+), 81 deletions(-)

diff --git a/drivers/clk/at91/clk-main.c b/drivers/clk/at91/clk-main.c
index c1f119748bdc..5841eb958f83 100644
--- a/drivers/clk/at91/clk-main.c
+++ b/drivers/clk/at91/clk-main.c
@@ -34,25 +34,28 @@
 
 #define MOR_KEY_MASK		(0xff << 16)
 
-struct clk_main_osc {
+struct clk_main {
 	struct clk_hw hw;
 	struct regmap *regmap;
 	unsigned int irq;
 	wait_queue_head_t wait;
 };
 
-#define to_clk_main_osc(hw) container_of(hw, struct clk_main_osc, hw)
+#define to_clk_main(hw) container_of(hw, struct clk_main, hw)
+
+struct clk_main_osc {
+	struct clk_main base;
+};
+
+#define to_clk_main_osc(hw) container_of(hw, struct clk_main_osc, base.hw)
 
 struct clk_main_rc_osc {
-	struct clk_hw hw;
-	struct regmap *regmap;
-	unsigned int irq;
-	wait_queue_head_t wait;
+	struct clk_main base;
 	unsigned long frequency;
 	unsigned long accuracy;
 };
 
-#define to_clk_main_rc_osc(hw) container_of(hw, struct clk_main_rc_osc, hw)
+#define to_clk_main_rc_osc(hw) container_of(hw, struct clk_main_rc_osc, base.hw)
 
 struct clk_rm9200_main {
 	struct clk_hw hw;
@@ -62,21 +65,20 @@ struct clk_rm9200_main {
 #define to_clk_rm9200_main(hw) container_of(hw, struct clk_rm9200_main, hw)
 
 struct clk_sam9x5_main {
-	struct clk_hw hw;
-	struct regmap *regmap;
-	unsigned int irq;
-	wait_queue_head_t wait;
+	struct clk_main base;
 	u8 parent;
 };
 
-#define to_clk_sam9x5_main(hw) container_of(hw, struct clk_sam9x5_main, hw)
+#define to_clk_sam9x5_main(hw) container_of(hw, struct clk_sam9x5_main, base.hw)
 
-static irqreturn_t clk_main_osc_irq_handler(int irq, void *dev_id)
+/* Generic structure */
+
+static irqreturn_t clk_main_irq_handler(int irq, void *dev_id)
 {
-	struct clk_main_osc *osc = dev_id;
+	struct clk_main *clkmain = dev_id;
 
-	wake_up(&osc->wait);
-	disable_irq_nosync(osc->irq);
+	wake_up(&clkmain->wait);
+	disable_irq_nosync(clkmain->irq);
 
 	return IRQ_HANDLED;
 }
@@ -93,7 +95,7 @@ static inline bool clk_main_osc_ready(struct regmap *regmap)
 static int clk_main_osc_prepare(struct clk_hw *hw)
 {
 	struct clk_main_osc *osc = to_clk_main_osc(hw);
-	struct regmap *regmap = osc->regmap;
+	struct regmap *regmap = osc->base.regmap;
 	u32 tmp;
 
 	regmap_read(regmap, AT91_CKGR_MOR, &tmp);
@@ -108,8 +110,8 @@ static int clk_main_osc_prepare(struct clk_hw *hw)
 	}
 
 	while (!clk_main_osc_ready(regmap)) {
-		enable_irq(osc->irq);
-		wait_event(osc->wait,
+		enable_irq(osc->base.irq);
+		wait_event(osc->base.wait,
 			   clk_main_osc_ready(regmap));
 	}
 
@@ -119,7 +121,7 @@ static int clk_main_osc_prepare(struct clk_hw *hw)
 static void clk_main_osc_unprepare(struct clk_hw *hw)
 {
 	struct clk_main_osc *osc = to_clk_main_osc(hw);
-	struct regmap *regmap = osc->regmap;
+	struct regmap *regmap = osc->base.regmap;
 	u32 tmp;
 
 	regmap_read(regmap, AT91_CKGR_MOR, &tmp);
@@ -136,7 +138,7 @@ static void clk_main_osc_unprepare(struct clk_hw *hw)
 static int clk_main_osc_is_prepared(struct clk_hw *hw)
 {
 	struct clk_main_osc *osc = to_clk_main_osc(hw);
-	struct regmap *regmap = osc->regmap;
+	struct regmap *regmap = osc->base.regmap;
 	u32 tmp, status;
 
 	regmap_read(regmap, AT91_CKGR_MOR, &tmp);
@@ -179,14 +181,14 @@ at91_clk_register_main_osc(struct regmap *regmap,
 	init.num_parents = 1;
 	init.flags = CLK_IGNORE_UNUSED;
 
-	osc->hw.init = &init;
-	osc->regmap = regmap;
-	osc->irq = irq;
+	osc->base.hw.init = &init;
+	osc->base.regmap = regmap;
+	osc->base.irq = irq;
 
-	init_waitqueue_head(&osc->wait);
-	irq_set_status_flags(osc->irq, IRQ_NOAUTOEN);
-	ret = request_irq(osc->irq, clk_main_osc_irq_handler,
-			  IRQF_TRIGGER_HIGH, name, osc);
+	init_waitqueue_head(&osc->base.wait);
+	irq_set_status_flags(irq, IRQ_NOAUTOEN);
+	ret = request_irq(irq, clk_main_irq_handler,
+			  IRQF_TRIGGER_HIGH, name, &osc->base);
 	if (ret) {
 		kfree(osc);
 		return ERR_PTR(ret);
@@ -198,7 +200,7 @@ at91_clk_register_main_osc(struct regmap *regmap,
 				   AT91_PMC_MOSCEN,
 				   AT91_PMC_OSCBYPASS | AT91_PMC_KEY);
 
-	clk = clk_register(NULL, &osc->hw);
+	clk = clk_register(NULL, &osc->base.hw);
 	if (IS_ERR(clk)) {
 		free_irq(irq, osc);
 		kfree(osc);
@@ -237,16 +239,6 @@ static void __init of_at91rm9200_clk_main_osc_setup(struct device_node *np)
 CLK_OF_DECLARE(at91rm9200_clk_main_osc, "atmel,at91rm9200-clk-main-osc",
 	       of_at91rm9200_clk_main_osc_setup);
 
-static irqreturn_t clk_main_rc_osc_irq_handler(int irq, void *dev_id)
-{
-	struct clk_main_rc_osc *osc = dev_id;
-
-	wake_up(&osc->wait);
-	disable_irq_nosync(osc->irq);
-
-	return IRQ_HANDLED;
-}
-
 static bool clk_main_rc_osc_ready(struct regmap *regmap)
 {
 	unsigned int status;
@@ -259,7 +251,7 @@ static bool clk_main_rc_osc_ready(struct regmap *regmap)
 static int clk_main_rc_osc_prepare(struct clk_hw *hw)
 {
 	struct clk_main_rc_osc *osc = to_clk_main_rc_osc(hw);
-	struct regmap *regmap = osc->regmap;
+	struct regmap *regmap = osc->base.regmap;
 	unsigned int mor;
 
 	regmap_read(regmap, AT91_CKGR_MOR, &mor);
@@ -270,8 +262,8 @@ static int clk_main_rc_osc_prepare(struct clk_hw *hw)
 				   AT91_PMC_MOSCRCEN | AT91_PMC_KEY);
 
 	while (!clk_main_rc_osc_ready(regmap)) {
-		enable_irq(osc->irq);
-		wait_event(osc->wait,
+		enable_irq(osc->base.irq);
+		wait_event(osc->base.wait,
 			   clk_main_rc_osc_ready(regmap));
 	}
 
@@ -281,7 +273,7 @@ static int clk_main_rc_osc_prepare(struct clk_hw *hw)
 static void clk_main_rc_osc_unprepare(struct clk_hw *hw)
 {
 	struct clk_main_rc_osc *osc = to_clk_main_rc_osc(hw);
-	struct regmap *regmap = osc->regmap;
+	struct regmap *regmap = osc->base.regmap;
 	unsigned int mor;
 
 	regmap_read(regmap, AT91_CKGR_MOR, &mor);
@@ -296,7 +288,7 @@ static void clk_main_rc_osc_unprepare(struct clk_hw *hw)
 static int clk_main_rc_osc_is_prepared(struct clk_hw *hw)
 {
 	struct clk_main_rc_osc *osc = to_clk_main_rc_osc(hw);
-	struct regmap *regmap = osc->regmap;
+	struct regmap *regmap = osc->base.regmap;
 	unsigned int mor, status;
 
 	regmap_read(regmap, AT91_CKGR_MOR, &mor);
@@ -353,20 +345,20 @@ at91_clk_register_main_rc_osc(struct regmap *regmap,
 	init.num_parents = 0;
 	init.flags = CLK_IS_ROOT | CLK_IGNORE_UNUSED;
 
-	osc->hw.init = &init;
-	osc->regmap = regmap;
-	osc->irq = irq;
+	osc->base.hw.init = &init;
+	osc->base.regmap = regmap;
+	osc->base.irq = irq;
 	osc->frequency = frequency;
 	osc->accuracy = accuracy;
 
-	init_waitqueue_head(&osc->wait);
-	irq_set_status_flags(osc->irq, IRQ_NOAUTOEN);
-	ret = request_irq(osc->irq, clk_main_rc_osc_irq_handler,
-			  IRQF_TRIGGER_HIGH, name, osc);
+	init_waitqueue_head(&osc->base.wait);
+	irq_set_status_flags(irq, IRQ_NOAUTOEN);
+	ret = request_irq(irq, clk_main_irq_handler,
+			  IRQF_TRIGGER_HIGH, name, &osc->base);
 	if (ret)
 		return ERR_PTR(ret);
 
-	clk = clk_register(NULL, &osc->hw);
+	clk = clk_register(NULL, &osc->base.hw);
 	if (IS_ERR(clk)) {
 		free_irq(irq, osc);
 		kfree(osc);
@@ -529,16 +521,6 @@ static void __init of_at91rm9200_clk_main_setup(struct device_node *np)
 CLK_OF_DECLARE(at91rm9200_clk_main, "atmel,at91rm9200-clk-main",
 	       of_at91rm9200_clk_main_setup);
 
-static irqreturn_t clk_sam9x5_main_irq_handler(int irq, void *dev_id)
-{
-	struct clk_sam9x5_main *clkmain = dev_id;
-
-	wake_up(&clkmain->wait);
-	disable_irq_nosync(clkmain->irq);
-
-	return IRQ_HANDLED;
-}
-
 static inline bool clk_sam9x5_main_ready(struct regmap *regmap)
 {
 	unsigned int status;
@@ -551,11 +533,11 @@ static inline bool clk_sam9x5_main_ready(struct regmap *regmap)
 static int clk_sam9x5_main_prepare(struct clk_hw *hw)
 {
 	struct clk_sam9x5_main *clkmain = to_clk_sam9x5_main(hw);
-	struct regmap *regmap = clkmain->regmap;
+	struct regmap *regmap = clkmain->base.regmap;
 
 	while (!clk_sam9x5_main_ready(regmap)) {
-		enable_irq(clkmain->irq);
-		wait_event(clkmain->wait,
+		enable_irq(clkmain->base.irq);
+		wait_event(clkmain->base.wait,
 			   clk_sam9x5_main_ready(regmap));
 	}
 
@@ -566,7 +548,7 @@ static int clk_sam9x5_main_is_prepared(struct clk_hw *hw)
 {
 	struct clk_sam9x5_main *clkmain = to_clk_sam9x5_main(hw);
 
-	return clk_sam9x5_main_ready(clkmain->regmap);
+	return clk_sam9x5_main_ready(clkmain->base.regmap);
 }
 
 static unsigned long clk_sam9x5_main_recalc_rate(struct clk_hw *hw,
@@ -574,13 +556,13 @@ static unsigned long clk_sam9x5_main_recalc_rate(struct clk_hw *hw,
 {
 	struct clk_sam9x5_main *clkmain = to_clk_sam9x5_main(hw);
 
-	return clk_main_recalc_rate(clkmain->regmap, parent_rate);
+	return clk_main_recalc_rate(clkmain->base.regmap, parent_rate);
 }
 
 static int clk_sam9x5_main_set_parent(struct clk_hw *hw, u8 index)
 {
 	struct clk_sam9x5_main *clkmain = to_clk_sam9x5_main(hw);
-	struct regmap *regmap = clkmain->regmap;
+	struct regmap *regmap = clkmain->base.regmap;
 	unsigned int tmp;
 
 	if (index > 1)
@@ -595,8 +577,8 @@ static int clk_sam9x5_main_set_parent(struct clk_hw *hw, u8 index)
 		regmap_write(regmap, AT91_CKGR_MOR, tmp & ~AT91_PMC_MOSCSEL);
 
 	while (!clk_sam9x5_main_ready(regmap)) {
-		enable_irq(clkmain->irq);
-		wait_event(clkmain->wait,
+		enable_irq(clkmain->base.irq);
+		wait_event(clkmain->base.wait,
 			   clk_sam9x5_main_ready(regmap));
 	}
 
@@ -608,7 +590,7 @@ static u8 clk_sam9x5_main_get_parent(struct clk_hw *hw)
 	struct clk_sam9x5_main *clkmain = to_clk_sam9x5_main(hw);
 	unsigned int status;
 
-	regmap_read(clkmain->regmap, AT91_CKGR_MOR, &status);
+	regmap_read(clkmain->base.regmap, AT91_CKGR_MOR, &status);
 
 	return status & AT91_PMC_MOSCEN ? 1 : 0;
 }
@@ -650,21 +632,21 @@ at91_clk_register_sam9x5_main(struct regmap *regmap,
 	init.num_parents = num_parents;
 	init.flags = CLK_SET_PARENT_GATE;
 
-	clkmain->hw.init = &init;
-	clkmain->regmap = regmap;
-	clkmain->irq = irq;
-	regmap_read(clkmain->regmap, AT91_CKGR_MOR, &status);
+	clkmain->base.hw.init = &init;
+	clkmain->base.regmap = regmap;
+	clkmain->base.irq = irq;
+	regmap_read(clkmain->base.regmap, AT91_CKGR_MOR, &status);
 	clkmain->parent = status & AT91_PMC_MOSCEN ? 1 : 0;
-	init_waitqueue_head(&clkmain->wait);
-	irq_set_status_flags(clkmain->irq, IRQ_NOAUTOEN);
-	ret = request_irq(clkmain->irq, clk_sam9x5_main_irq_handler,
-			  IRQF_TRIGGER_HIGH, name, clkmain);
+	init_waitqueue_head(&clkmain->base.wait);
+	irq_set_status_flags(irq, IRQ_NOAUTOEN);
+	ret = request_irq(irq, clk_main_irq_handler,
+			  IRQF_TRIGGER_HIGH, name, &clkmain->base);
 	if (ret)
 		return ERR_PTR(ret);
 
-	clk = clk_register(NULL, &clkmain->hw);
+	clk = clk_register(NULL, &clkmain->base.hw);
 	if (IS_ERR(clk)) {
-		free_irq(clkmain->irq, clkmain);
+		free_irq(irq, clkmain);
 		kfree(clkmain);
 	}
 
-- 
2.1.4
