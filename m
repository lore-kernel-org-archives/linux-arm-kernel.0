From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 16 Mar 2017 09:30:30 +0100
Subject: [PATCH v2 3/7] memory: atmel-ebi: Stop using reg_field objects for
 simple things
In-Reply-To: <1489653034-17777-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1489653034-17777-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1489653034-17777-4-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Turn the ->ebi_csa reg field into a simple offset that can be used with
with the matrix regmap. Using reg fields was overkill for this use case.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/memory/atmel-ebi.c | 55 +++++++++++-----------------------------------
 1 file changed, 13 insertions(+), 42 deletions(-)

diff --git a/drivers/memory/atmel-ebi.c b/drivers/memory/atmel-ebi.c
index e1b8590e7d23..8640da386d32 100644
--- a/drivers/memory/atmel-ebi.c
+++ b/drivers/memory/atmel-ebi.c
@@ -35,7 +35,7 @@ struct at91_ebi_dev {
 
 struct at91_ebi_caps {
 	unsigned int available_cs;
-	const struct reg_field *ebi_csa;
+	unsigned int ebi_csa_offs;
 	void (*get_config)(struct at91_ebi_dev *ebid,
 			   struct at91_ebi_dev_config *conf);
 	int (*xlate_config)(struct at91_ebi_dev *ebid,
@@ -52,7 +52,6 @@ struct at91_ebi {
 		struct regmap *regmap;
 		struct clk *clk;
 	} smc;
-	struct regmap_field *ebi_csa;
 
 	struct device *dev;
 	const struct at91_ebi_caps *caps;
@@ -355,9 +354,10 @@ static int at91_ebi_dev_setup(struct at91_ebi *ebi, struct device_node *np,
 		 * Attach the EBI device to the generic SMC logic if at least
 		 * one "atmel,smc-" property is present.
 		 */
-		if (ebi->ebi_csa && apply)
-			regmap_field_update_bits(ebi->ebi_csa,
-						 BIT(cs), 0);
+		if (ebi->caps->ebi_csa_offs && apply)
+			regmap_update_bits(ebi->matrix,
+					   ebi->caps->ebi_csa_offs,
+					   BIT(cs), 0);
 
 		i++;
 	}
@@ -367,73 +367,49 @@ static int at91_ebi_dev_setup(struct at91_ebi *ebi, struct device_node *np,
 	return 0;
 }
 
-static const struct reg_field at91sam9260_ebi_csa =
-				REG_FIELD(AT91SAM9260_MATRIX_EBICSA, 0,
-					  AT91_MATRIX_EBI_NUM_CS - 1);
-
 static const struct at91_ebi_caps at91sam9260_ebi_caps = {
 	.available_cs = 0xff,
-	.ebi_csa = &at91sam9260_ebi_csa,
+	.ebi_csa_offs = AT91SAM9260_MATRIX_EBICSA,
 	.get_config = at91sam9_ebi_get_config,
 	.xlate_config = at91_ebi_xslate_smc_config,
 	.apply_config = at91sam9_ebi_apply_config,
 };
 
-static const struct reg_field at91sam9261_ebi_csa =
-				REG_FIELD(AT91SAM9261_MATRIX_EBICSA, 0,
-					  AT91_MATRIX_EBI_NUM_CS - 1);
-
 static const struct at91_ebi_caps at91sam9261_ebi_caps = {
 	.available_cs = 0xff,
-	.ebi_csa = &at91sam9261_ebi_csa,
+	.ebi_csa_offs = AT91SAM9261_MATRIX_EBICSA,
 	.get_config = at91sam9_ebi_get_config,
 	.xlate_config = at91_ebi_xslate_smc_config,
 	.apply_config = at91sam9_ebi_apply_config,
 };
 
-static const struct reg_field at91sam9263_ebi0_csa =
-				REG_FIELD(AT91SAM9263_MATRIX_EBI0CSA, 0,
-					  AT91_MATRIX_EBI_NUM_CS - 1);
-
 static const struct at91_ebi_caps at91sam9263_ebi0_caps = {
 	.available_cs = 0x3f,
-	.ebi_csa = &at91sam9263_ebi0_csa,
+	.ebi_csa_offs = AT91SAM9263_MATRIX_EBI0CSA,
 	.get_config = at91sam9_ebi_get_config,
 	.xlate_config = at91_ebi_xslate_smc_config,
 	.apply_config = at91sam9_ebi_apply_config,
 };
 
-static const struct reg_field at91sam9263_ebi1_csa =
-				REG_FIELD(AT91SAM9263_MATRIX_EBI1CSA, 0,
-					  AT91_MATRIX_EBI_NUM_CS - 1);
-
 static const struct at91_ebi_caps at91sam9263_ebi1_caps = {
 	.available_cs = 0x7,
-	.ebi_csa = &at91sam9263_ebi1_csa,
+	.ebi_csa_offs = AT91SAM9263_MATRIX_EBI1CSA,
 	.get_config = at91sam9_ebi_get_config,
 	.xlate_config = at91_ebi_xslate_smc_config,
 	.apply_config = at91sam9_ebi_apply_config,
 };
 
-static const struct reg_field at91sam9rl_ebi_csa =
-				REG_FIELD(AT91SAM9RL_MATRIX_EBICSA, 0,
-					  AT91_MATRIX_EBI_NUM_CS - 1);
-
 static const struct at91_ebi_caps at91sam9rl_ebi_caps = {
 	.available_cs = 0x3f,
-	.ebi_csa = &at91sam9rl_ebi_csa,
+	.ebi_csa_offs = AT91SAM9RL_MATRIX_EBICSA,
 	.get_config = at91sam9_ebi_get_config,
 	.xlate_config = at91_ebi_xslate_smc_config,
 	.apply_config = at91sam9_ebi_apply_config,
 };
 
-static const struct reg_field at91sam9g45_ebi_csa =
-				REG_FIELD(AT91SAM9G45_MATRIX_EBICSA, 0,
-					  AT91_MATRIX_EBI_NUM_CS - 1);
-
 static const struct at91_ebi_caps at91sam9g45_ebi_caps = {
 	.available_cs = 0x3f,
-	.ebi_csa = &at91sam9g45_ebi_csa,
+	.ebi_csa_offs = AT91SAM9G45_MATRIX_EBICSA,
 	.get_config = at91sam9_ebi_get_config,
 	.xlate_config = at91_ebi_xslate_smc_config,
 	.apply_config = at91sam9_ebi_apply_config,
@@ -441,7 +417,7 @@ static const struct at91_ebi_caps at91sam9g45_ebi_caps = {
 
 static const struct at91_ebi_caps at91sam9x5_ebi_caps = {
 	.available_cs = 0x3f,
-	.ebi_csa = &at91sam9263_ebi0_csa,
+	.ebi_csa_offs = AT91SAM9X5_MATRIX_EBICSA,
 	.get_config = at91sam9_ebi_get_config,
 	.xlate_config = at91_ebi_xslate_smc_config,
 	.apply_config = at91sam9_ebi_apply_config,
@@ -561,16 +537,11 @@ static int at91_ebi_probe(struct platform_device *pdev)
 	 * The sama5d3 does not provide an EBICSA register and thus does need
 	 * to access the matrix registers.
 	 */
-	if (ebi->caps->ebi_csa) {
+	if (ebi->caps->ebi_csa_offs) {
 		ebi->matrix =
 			syscon_regmap_lookup_by_phandle(np, "atmel,matrix");
 		if (IS_ERR(ebi->matrix))
 			return PTR_ERR(ebi->matrix);
-
-		ebi->ebi_csa = regmap_field_alloc(ebi->matrix,
-						  *ebi->caps->ebi_csa);
-		if (IS_ERR(ebi->ebi_csa))
-			return PTR_ERR(ebi->ebi_csa);
 	}
 
 	ret = of_property_read_u32(np, "#address-cells", &val);
-- 
2.7.4
