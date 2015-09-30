From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 30 Sep 2015 18:11:02 +0200
Subject: [PATCH 09/16] clk: at91: pmc: merge at91_pmc_init in atmel_pmc_probe
In-Reply-To: <1443629469-15086-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1443629469-15086-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1443629469-15086-10-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

at91_pmc_init() doesn't do much anymore, merge it in atmel_pmc_probe().

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/clk/at91/pmc.c | 31 ++++++-------------------------
 1 file changed, 6 insertions(+), 25 deletions(-)

diff --git a/drivers/clk/at91/pmc.c b/drivers/clk/at91/pmc.c
index 45dd32bf2531..acc8f518b392 100644
--- a/drivers/clk/at91/pmc.c
+++ b/drivers/clk/at91/pmc.c
@@ -223,29 +223,6 @@ static const struct at91_pmc_caps sama5d3_caps = {
 			  AT91_PMC_CFDEV,
 };
 
-static struct at91_pmc *__init at91_pmc_init(struct device_node *np,
-					     struct regmap *regmap,
-					     void __iomem *regbase, int virq,
-					     const struct at91_pmc_caps *caps)
-{
-	struct at91_pmc *pmc;
-
-	if (!regbase || !virq ||  !caps)
-		return NULL;
-
-	at91_pmc_base = regbase;
-
-	pmc = kzalloc(sizeof(*pmc), GFP_KERNEL);
-	if (!pmc)
-		return NULL;
-
-	pmc->regmap = regmap;
-	pmc->virq = virq;
-	pmc->caps = caps;
-
-	return pmc;
-}
-
 static const struct of_device_id atmel_pmc_dt_ids[] = {
 	{ .compatible = "atmel,at91rm9200-pmc", .data = &at91rm9200_caps },
 	{ .compatible = "atmel,at91sam9260-pmc", .data = &at91sam9260_caps },
@@ -262,11 +239,12 @@ static int __init atmel_pmc_probe(struct platform_device *pdev)
 	const struct at91_pmc_caps *caps;
 	struct device_node *np = pdev->dev.of_node;
 	struct at91_pmc *pmc;
-	void __iomem *regbase = of_iomap(np, 0);
 	struct regmap *regmap;
 	int virq;
 	int ret = 0;
 
+	at91_pmc_base = of_iomap(np, 0);
+
 	regmap = syscon_node_to_regmap(np);
 	if (IS_ERR(regmap))
 		panic("Could not retrieve syscon regmap");
@@ -278,10 +256,13 @@ static int __init atmel_pmc_probe(struct platform_device *pdev)
 	of_id = of_match_device(atmel_pmc_dt_ids, &pdev->dev);
 	caps = of_id->data;
 
-	pmc = at91_pmc_init(np, regmap, regbase, virq, caps);
+	pmc = kzalloc(sizeof(*pmc), GFP_KERNEL);
 	if (!pmc)
 		return 0;
 
+	pmc->regmap = regmap;
+	pmc->virq = virq;
+	pmc->caps = caps;
 	pmc->irqdomain = irq_domain_add_linear(pdev->dev.of_node, 32,
 					       &pmc_irq_ops, pmc);
 	if (!pmc->irqdomain)
-- 
2.1.4
