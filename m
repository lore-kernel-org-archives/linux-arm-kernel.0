From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 20 Feb 2017 17:54:59 +0100
Subject: [PATCH 5/7] memory: atmel-ebi: Change naming scheme
In-Reply-To: <1487609701-10300-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1487609701-10300-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1487609701-10300-6-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The EBI block is not only available on at91 SoCs, but also on avr32 ones.
Change the structure and function prefixes from at91_ebi to atmel_ebi to
match this fact and make the prefix and driver name consistent.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/memory/atmel-ebi.c | 120 ++++++++++++++++++++++-----------------------
 1 file changed, 60 insertions(+), 60 deletions(-)

diff --git a/drivers/memory/atmel-ebi.c b/drivers/memory/atmel-ebi.c
index 6b3c9fc7a602..833af8d02424 100644
--- a/drivers/memory/atmel-ebi.c
+++ b/drivers/memory/atmel-ebi.c
@@ -18,34 +18,34 @@
 #include <linux/of_device.h>
 #include <linux/regmap.h>
 
-struct at91_ebi_dev_config {
+struct atmel_ebi_dev_config {
 	int cs;
 	struct atmel_smc_cs_conf smcconf;
 };
 
-struct at91_ebi;
+struct atmel_ebi;
 
-struct at91_ebi_dev {
+struct atmel_ebi_dev {
 	struct list_head node;
-	struct at91_ebi *ebi;
+	struct atmel_ebi *ebi;
 	u32 mode;
 	int numcs;
-	struct at91_ebi_dev_config configs[];
+	struct atmel_ebi_dev_config configs[];
 };
 
-struct at91_ebi_caps {
+struct atmel_ebi_caps {
 	unsigned int available_cs;
 	unsigned int ebi_csa_offs;
-	void (*get_config)(struct at91_ebi_dev *ebid,
-			   struct at91_ebi_dev_config *conf);
-	int (*xlate_config)(struct at91_ebi_dev *ebid,
+	void (*get_config)(struct atmel_ebi_dev *ebid,
+			   struct atmel_ebi_dev_config *conf);
+	int (*xlate_config)(struct atmel_ebi_dev *ebid,
 			    struct device_node *configs_np,
-			    struct at91_ebi_dev_config *conf);
-	void (*apply_config)(struct at91_ebi_dev *ebid,
-			     struct at91_ebi_dev_config *conf);
+			    struct atmel_ebi_dev_config *conf);
+	void (*apply_config)(struct atmel_ebi_dev *ebid,
+			     struct atmel_ebi_dev_config *conf);
 };
 
-struct at91_ebi {
+struct atmel_ebi {
 	struct clk *clk;
 	struct regmap *matrix;
 	struct  {
@@ -54,7 +54,7 @@ struct at91_ebi {
 	} smc;
 
 	struct device *dev;
-	const struct at91_ebi_caps *caps;
+	const struct atmel_ebi_caps *caps;
 	struct list_head devs;
 };
 
@@ -74,15 +74,15 @@ struct atmel_smc_timing_xlate {
 #define ATMEL_SMC_CYCLE_XLATE(nm, pos)	\
 	{ .name = nm, .converter = atmel_smc_cs_conf_set_setup, .shift = pos}
 
-static void at91sam9_ebi_get_config(struct at91_ebi_dev *ebid,
-				    struct at91_ebi_dev_config *conf)
+static void at91sam9_ebi_get_config(struct atmel_ebi_dev *ebid,
+				    struct atmel_ebi_dev_config *conf)
 {
 	atmel_smc_cs_conf_get(ebid->ebi->smc.regmap, conf->cs,
 			      &conf->smcconf);
 }
 
-static void sama5_ebi_get_config(struct at91_ebi_dev *ebid,
-				 struct at91_ebi_dev_config *conf)
+static void sama5_ebi_get_config(struct atmel_ebi_dev *ebid,
+				 struct atmel_ebi_dev_config *conf)
 {
 	atmel_hsmc_cs_conf_get(ebid->ebi->smc.regmap, conf->cs,
 			       &conf->smcconf);
@@ -105,9 +105,9 @@ static const struct atmel_smc_timing_xlate timings_xlate_table[] = {
 	ATMEL_SMC_CYCLE_XLATE("atmel,smc-nwe-cycle-ns", ATMEL_SMC_NWE_SHIFT),
 };
 
-static int at91_ebi_xslate_smc_timings(struct at91_ebi_dev *ebid,
-				       struct device_node *np,
-				       struct atmel_smc_cs_conf *smcconf)
+static int atmel_ebi_xslate_smc_timings(struct atmel_ebi_dev *ebid,
+					struct device_node *np,
+					struct atmel_smc_cs_conf *smcconf)
 {
 	unsigned int clk_rate = clk_get_rate(ebid->ebi->clk);
 	unsigned int clk_period_ns = NSEC_PER_SEC / clk_rate;
@@ -163,9 +163,9 @@ static int at91_ebi_xslate_smc_timings(struct at91_ebi_dev *ebid,
 	return required;
 }
 
-static int at91_ebi_xslate_smc_config(struct at91_ebi_dev *ebid,
-				      struct device_node *np,
-				      struct at91_ebi_dev_config *conf)
+static int atmel_ebi_xslate_smc_config(struct atmel_ebi_dev *ebid,
+				       struct device_node *np,
+				       struct atmel_ebi_dev_config *conf)
 {
 	struct atmel_smc_cs_conf *smcconf = &conf->smcconf;
 	bool required = false;
@@ -261,7 +261,7 @@ static int at91_ebi_xslate_smc_config(struct at91_ebi_dev *ebid,
 		required = true;
 	}
 
-	ret = at91_ebi_xslate_smc_timings(ebid, np, &conf->smcconf);
+	ret = atmel_ebi_xslate_smc_timings(ebid, np, &conf->smcconf);
 	if (ret)
 		return -EINVAL;
 
@@ -274,27 +274,27 @@ static int at91_ebi_xslate_smc_config(struct at91_ebi_dev *ebid,
 	return required;
 }
 
-static void at91sam9_ebi_apply_config(struct at91_ebi_dev *ebid,
-				      struct at91_ebi_dev_config *conf)
+static void at91sam9_ebi_apply_config(struct atmel_ebi_dev *ebid,
+				      struct atmel_ebi_dev_config *conf)
 {
 	atmel_smc_cs_conf_apply(ebid->ebi->smc.regmap, conf->cs,
 				&conf->smcconf);
 }
 
-static void sama5_ebi_apply_config(struct at91_ebi_dev *ebid,
-				   struct at91_ebi_dev_config *conf)
+static void sama5_ebi_apply_config(struct atmel_ebi_dev *ebid,
+				   struct atmel_ebi_dev_config *conf)
 {
 	atmel_hsmc_cs_conf_apply(ebid->ebi->smc.regmap, conf->cs,
 				 &conf->smcconf);
 }
 
-static int at91_ebi_dev_setup(struct at91_ebi *ebi, struct device_node *np,
-			      int reg_cells)
+static int atmel_ebi_dev_setup(struct atmel_ebi *ebi, struct device_node *np,
+			       int reg_cells)
 {
-	const struct at91_ebi_caps *caps = ebi->caps;
-	struct at91_ebi_dev_config conf = { };
+	const struct atmel_ebi_caps *caps = ebi->caps;
+	struct atmel_ebi_dev_config conf = { };
 	struct device *dev = ebi->dev;
-	struct at91_ebi_dev *ebid;
+	struct atmel_ebi_dev *ebid;
 	unsigned long cslines = 0;
 	int ret, numcs = 0, nentries, i;
 	bool apply = false;
@@ -366,70 +366,70 @@ static int at91_ebi_dev_setup(struct at91_ebi *ebi, struct device_node *np,
 	return 0;
 }
 
-static const struct at91_ebi_caps at91sam9260_ebi_caps = {
+static const struct atmel_ebi_caps at91sam9260_ebi_caps = {
 	.available_cs = 0xff,
 	.ebi_csa_offs = AT91SAM9260_MATRIX_EBICSA,
 	.get_config = at91sam9_ebi_get_config,
-	.xlate_config = at91_ebi_xslate_smc_config,
+	.xlate_config = atmel_ebi_xslate_smc_config,
 	.apply_config = at91sam9_ebi_apply_config,
 };
 
-static const struct at91_ebi_caps at91sam9261_ebi_caps = {
+static const struct atmel_ebi_caps at91sam9261_ebi_caps = {
 	.available_cs = 0xff,
 	.ebi_csa_offs = AT91SAM9261_MATRIX_EBICSA,
 	.get_config = at91sam9_ebi_get_config,
-	.xlate_config = at91_ebi_xslate_smc_config,
+	.xlate_config = atmel_ebi_xslate_smc_config,
 	.apply_config = at91sam9_ebi_apply_config,
 };
 
-static const struct at91_ebi_caps at91sam9263_ebi0_caps = {
+static const struct atmel_ebi_caps at91sam9263_ebi0_caps = {
 	.available_cs = 0x3f,
 	.ebi_csa_offs = AT91SAM9263_MATRIX_EBI0CSA,
 	.get_config = at91sam9_ebi_get_config,
-	.xlate_config = at91_ebi_xslate_smc_config,
+	.xlate_config = atmel_ebi_xslate_smc_config,
 	.apply_config = at91sam9_ebi_apply_config,
 };
 
-static const struct at91_ebi_caps at91sam9263_ebi1_caps = {
+static const struct atmel_ebi_caps at91sam9263_ebi1_caps = {
 	.available_cs = 0x7,
 	.ebi_csa_offs = AT91SAM9263_MATRIX_EBI1CSA,
 	.get_config = at91sam9_ebi_get_config,
-	.xlate_config = at91_ebi_xslate_smc_config,
+	.xlate_config = atmel_ebi_xslate_smc_config,
 	.apply_config = at91sam9_ebi_apply_config,
 };
 
-static const struct at91_ebi_caps at91sam9rl_ebi_caps = {
+static const struct atmel_ebi_caps at91sam9rl_ebi_caps = {
 	.available_cs = 0x3f,
 	.ebi_csa_offs = AT91SAM9RL_MATRIX_EBICSA,
 	.get_config = at91sam9_ebi_get_config,
-	.xlate_config = at91_ebi_xslate_smc_config,
+	.xlate_config = atmel_ebi_xslate_smc_config,
 	.apply_config = at91sam9_ebi_apply_config,
 };
 
-static const struct at91_ebi_caps at91sam9g45_ebi_caps = {
+static const struct atmel_ebi_caps at91sam9g45_ebi_caps = {
 	.available_cs = 0x3f,
 	.ebi_csa_offs = AT91SAM9G45_MATRIX_EBICSA,
 	.get_config = at91sam9_ebi_get_config,
-	.xlate_config = at91_ebi_xslate_smc_config,
+	.xlate_config = atmel_ebi_xslate_smc_config,
 	.apply_config = at91sam9_ebi_apply_config,
 };
 
-static const struct at91_ebi_caps at91sam9x5_ebi_caps = {
+static const struct atmel_ebi_caps at91sam9x5_ebi_caps = {
 	.available_cs = 0x3f,
 	.ebi_csa_offs = AT91SAM9X5_MATRIX_EBICSA,
 	.get_config = at91sam9_ebi_get_config,
-	.xlate_config = at91_ebi_xslate_smc_config,
+	.xlate_config = atmel_ebi_xslate_smc_config,
 	.apply_config = at91sam9_ebi_apply_config,
 };
 
-static const struct at91_ebi_caps sama5d3_ebi_caps = {
+static const struct atmel_ebi_caps sama5d3_ebi_caps = {
 	.available_cs = 0xf,
 	.get_config = sama5_ebi_get_config,
-	.xlate_config = at91_ebi_xslate_smc_config,
+	.xlate_config = atmel_ebi_xslate_smc_config,
 	.apply_config = sama5_ebi_apply_config,
 };
 
-static const struct of_device_id at91_ebi_id_table[] = {
+static const struct of_device_id atmel_ebi_id_table[] = {
 	{
 		.compatible = "atmel,at91sam9260-ebi",
 		.data = &at91sam9260_ebi_caps,
@@ -465,7 +465,7 @@ static const struct of_device_id at91_ebi_id_table[] = {
 	{ /* sentinel */ }
 };
 
-static int at91_ebi_dev_disable(struct at91_ebi *ebi, struct device_node *np)
+static int atmel_ebi_dev_disable(struct atmel_ebi *ebi, struct device_node *np)
 {
 	struct device *dev = ebi->dev;
 	struct property *newprop;
@@ -487,17 +487,17 @@ static int at91_ebi_dev_disable(struct at91_ebi *ebi, struct device_node *np)
 	return of_update_property(np, newprop);
 }
 
-static int at91_ebi_probe(struct platform_device *pdev)
+static int atmel_ebi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *child, *np = dev->of_node, *smc_np;
 	const struct of_device_id *match;
-	struct at91_ebi *ebi;
+	struct atmel_ebi *ebi;
 	int ret, reg_cells;
 	struct clk *clk;
 	u32 val;
 
-	match = of_match_device(at91_ebi_id_table, dev);
+	match = of_match_device(atmel_ebi_id_table, dev);
 	if (!match || !match->data)
 		return -EINVAL;
 
@@ -563,12 +563,12 @@ static int at91_ebi_probe(struct platform_device *pdev)
 		if (!of_find_property(child, "reg", NULL))
 			continue;
 
-		ret = at91_ebi_dev_setup(ebi, child, reg_cells);
+		ret = atmel_ebi_dev_setup(ebi, child, reg_cells);
 		if (ret) {
 			dev_err(dev, "failed to configure EBI bus for %s, disabling the device",
 				child->full_name);
 
-			ret = at91_ebi_dev_disable(ebi, child);
+			ret = atmel_ebi_dev_disable(ebi, child);
 			if (ret)
 				return ret;
 		}
@@ -577,10 +577,10 @@ static int at91_ebi_probe(struct platform_device *pdev)
 	return of_platform_populate(np, NULL, NULL, dev);
 }
 
-static struct platform_driver at91_ebi_driver = {
+static struct platform_driver atmel_ebi_driver = {
 	.driver = {
 		.name = "atmel-ebi",
-		.of_match_table	= at91_ebi_id_table,
+		.of_match_table	= atmel_ebi_id_table,
 	},
 };
-builtin_platform_driver_probe(at91_ebi_driver, at91_ebi_probe);
+builtin_platform_driver_probe(atmel_ebi_driver, atmel_ebi_probe);
-- 
2.7.4
