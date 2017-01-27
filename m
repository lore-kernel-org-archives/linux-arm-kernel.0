From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Fri, 27 Jan 2017 10:24:09 +0100
Subject: [PATCH] memory: atmel-ebi: Enable the SMC clock if specified
Message-ID: <1485509049-372-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Newer versions of the SMC block requires the SMC clock to be enabled
before the SMC logic can be used.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/memory/atmel-ebi.c | 51 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 37 insertions(+), 14 deletions(-)

diff --git a/drivers/memory/atmel-ebi.c b/drivers/memory/atmel-ebi.c
index 46657eaaedf6..4e83a8b92665 100644
--- a/drivers/memory/atmel-ebi.c
+++ b/drivers/memory/atmel-ebi.c
@@ -76,9 +76,11 @@ struct at91_ebi_caps {
 
 struct at91_ebi {
 	struct clk *clk;
-	struct regmap *smc;
 	struct regmap *matrix;
-
+	struct  {
+		struct regmap *regmap;
+		struct clk *clk;
+	} smc;
 	struct regmap_field *ebi_csa;
 
 	struct device *dev;
@@ -395,22 +397,26 @@ static int at91sam9_ebi_init(struct at91_ebi *ebi)
 	field.id_offset = AT91SAM9_SMC_GENERIC_BLK_SZ;
 
 	field.reg = AT91SAM9_SMC_SETUP(AT91SAM9_SMC_GENERIC);
-	fields->setup = devm_regmap_field_alloc(ebi->dev, ebi->smc, field);
+	fields->setup = devm_regmap_field_alloc(ebi->dev, ebi->smc.regmap,
+						field);
 	if (IS_ERR(fields->setup))
 		return PTR_ERR(fields->setup);
 
 	field.reg = AT91SAM9_SMC_PULSE(AT91SAM9_SMC_GENERIC);
-	fields->pulse = devm_regmap_field_alloc(ebi->dev, ebi->smc, field);
+	fields->pulse = devm_regmap_field_alloc(ebi->dev, ebi->smc.regmap,
+						field);
 	if (IS_ERR(fields->pulse))
 		return PTR_ERR(fields->pulse);
 
 	field.reg = AT91SAM9_SMC_CYCLE(AT91SAM9_SMC_GENERIC);
-	fields->cycle = devm_regmap_field_alloc(ebi->dev, ebi->smc, field);
+	fields->cycle = devm_regmap_field_alloc(ebi->dev, ebi->smc.regmap,
+						field);
 	if (IS_ERR(fields->cycle))
 		return PTR_ERR(fields->cycle);
 
 	field.reg = AT91SAM9_SMC_MODE(AT91SAM9_SMC_GENERIC);
-	fields->mode = devm_regmap_field_alloc(ebi->dev, ebi->smc, field);
+	fields->mode = devm_regmap_field_alloc(ebi->dev, ebi->smc.regmap,
+					       field);
 	return PTR_ERR_OR_ZERO(fields->mode);
 }
 
@@ -423,22 +429,26 @@ static int sama5d3_ebi_init(struct at91_ebi *ebi)
 	field.id_offset = SAMA5_SMC_GENERIC_BLK_SZ;
 
 	field.reg = AT91SAM9_SMC_SETUP(SAMA5_SMC_GENERIC);
-	fields->setup = devm_regmap_field_alloc(ebi->dev, ebi->smc, field);
+	fields->setup = devm_regmap_field_alloc(ebi->dev, ebi->smc.regmap,
+						field);
 	if (IS_ERR(fields->setup))
 		return PTR_ERR(fields->setup);
 
 	field.reg = AT91SAM9_SMC_PULSE(SAMA5_SMC_GENERIC);
-	fields->pulse = devm_regmap_field_alloc(ebi->dev, ebi->smc, field);
+	fields->pulse = devm_regmap_field_alloc(ebi->dev, ebi->smc.regmap,
+						field);
 	if (IS_ERR(fields->pulse))
 		return PTR_ERR(fields->pulse);
 
 	field.reg = AT91SAM9_SMC_CYCLE(SAMA5_SMC_GENERIC);
-	fields->cycle = devm_regmap_field_alloc(ebi->dev, ebi->smc, field);
+	fields->cycle = devm_regmap_field_alloc(ebi->dev, ebi->smc.regmap,
+						field);
 	if (IS_ERR(fields->cycle))
 		return PTR_ERR(fields->cycle);
 
 	field.reg = SAMA5_SMC_MODE(SAMA5_SMC_GENERIC);
-	fields->mode = devm_regmap_field_alloc(ebi->dev, ebi->smc, field);
+	fields->mode = devm_regmap_field_alloc(ebi->dev, ebi->smc.regmap,
+					       field);
 	return PTR_ERR_OR_ZERO(fields->mode);
 }
 
@@ -677,7 +687,7 @@ static int at91_ebi_dev_disable(struct at91_ebi *ebi, struct device_node *np)
 static int at91_ebi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct device_node *child, *np = dev->of_node;
+	struct device_node *child, *np = dev->of_node, *smc_np;
 	const struct of_device_id *match;
 	struct at91_ebi *ebi;
 	int ret, reg_cells;
@@ -702,9 +712,22 @@ static int at91_ebi_probe(struct platform_device *pdev)
 
 	ebi->clk = clk;
 
-	ebi->smc = syscon_regmap_lookup_by_phandle(np, "atmel,smc");
-	if (IS_ERR(ebi->smc))
-		return PTR_ERR(ebi->smc);
+	smc_np = of_parse_phandle(dev->of_node, "atmel,smc", 0);
+
+	ebi->smc.regmap = syscon_node_to_regmap(smc_np);
+	if (IS_ERR(ebi->smc.regmap))
+		return PTR_ERR(ebi->smc.regmap);
+
+	ebi->smc.clk = of_clk_get(smc_np, 0);
+	if (IS_ERR(ebi->smc.clk)) {
+		if (PTR_ERR(ebi->smc.clk) != -ENOENT)
+			return PTR_ERR(ebi->smc.clk);
+
+		ebi->smc.clk = NULL;
+	}
+	ret = clk_prepare_enable(ebi->smc.clk);
+	if (ret)
+		return ret;
 
 	/*
 	 * The sama5d3 does not provide an EBICSA register and thus does need
-- 
2.7.4
