From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 30 Sep 2015 18:10:59 +0200
Subject: [PATCH 06/16] clk: at91: clk-main: factorize irq handling
In-Reply-To: <1443629469-15086-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1443629469-15086-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1443629469-15086-7-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The three different irq handlers are doing the same thing, factorize their
code in a generic irq handler.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/clk/at91/clk-main.c | 43 ++++++++++++++++---------------------------
 1 file changed, 16 insertions(+), 27 deletions(-)

diff --git a/drivers/clk/at91/clk-main.c b/drivers/clk/at91/clk-main.c
index c1f119748bdc..79a380cd1f4e 100644
--- a/drivers/clk/at91/clk-main.c
+++ b/drivers/clk/at91/clk-main.c
@@ -71,12 +71,21 @@ struct clk_sam9x5_main {
 
 #define to_clk_sam9x5_main(hw) container_of(hw, struct clk_sam9x5_main, hw)
 
-static irqreturn_t clk_main_osc_irq_handler(int irq, void *dev_id)
+/* Generic structure */
+struct clk_main {
+	struct clk_hw hw;
+	struct at91_pmc *pmc;
+	unsigned int irq;
+	wait_queue_head_t wait;
+};
+#define to_clk_main(hw) container_of(hw, struct clk_main, hw)
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
@@ -185,7 +194,7 @@ at91_clk_register_main_osc(struct regmap *regmap,
 
 	init_waitqueue_head(&osc->wait);
 	irq_set_status_flags(osc->irq, IRQ_NOAUTOEN);
-	ret = request_irq(osc->irq, clk_main_osc_irq_handler,
+	ret = request_irq(osc->irq, clk_main_irq_handler,
 			  IRQF_TRIGGER_HIGH, name, osc);
 	if (ret) {
 		kfree(osc);
@@ -237,16 +246,6 @@ static void __init of_at91rm9200_clk_main_osc_setup(struct device_node *np)
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
@@ -361,7 +360,7 @@ at91_clk_register_main_rc_osc(struct regmap *regmap,
 
 	init_waitqueue_head(&osc->wait);
 	irq_set_status_flags(osc->irq, IRQ_NOAUTOEN);
-	ret = request_irq(osc->irq, clk_main_rc_osc_irq_handler,
+	ret = request_irq(osc->irq, clk_main_irq_handler,
 			  IRQF_TRIGGER_HIGH, name, osc);
 	if (ret)
 		return ERR_PTR(ret);
@@ -529,16 +528,6 @@ static void __init of_at91rm9200_clk_main_setup(struct device_node *np)
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
@@ -657,7 +646,7 @@ at91_clk_register_sam9x5_main(struct regmap *regmap,
 	clkmain->parent = status & AT91_PMC_MOSCEN ? 1 : 0;
 	init_waitqueue_head(&clkmain->wait);
 	irq_set_status_flags(clkmain->irq, IRQ_NOAUTOEN);
-	ret = request_irq(clkmain->irq, clk_sam9x5_main_irq_handler,
+	ret = request_irq(clkmain->irq, clk_main_irq_handler,
 			  IRQF_TRIGGER_HIGH, name, clkmain);
 	if (ret)
 		return ERR_PTR(ret);
-- 
2.1.4
