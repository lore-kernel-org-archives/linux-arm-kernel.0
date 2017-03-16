From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 16 Mar 2017 09:30:29 +0100
Subject: [PATCH v2 2/7] memory: atmel-ebi: Simplify SMC config code
In-Reply-To: <1489653034-17777-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1489653034-17777-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1489653034-17777-3-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

New helpers/macros have been to atmel-smc.h introduced to simplify SMC
regs manipulation. Rework the code to use those helpers, and simplify
the ->xlate_config(), ->get_config() and ->apply_config() implementations.

SMC configs are now stored in a struct atmel_smc_cs_conf object that
directly contains registers values, which should help implementing
->suspend()/->resume() hooks.

We can also get rid of those regmap fields (and the associated ->init()
hook) which are not longer needed thanks to the
atmel_[h]smc_cs_conf_{apply,get}() helpers.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/memory/Kconfig     |   1 +
 drivers/memory/atmel-ebi.c | 430 +++++++++++++--------------------------------
 2 files changed, 128 insertions(+), 303 deletions(-)

diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
index ec80e35c8dfe..3ecc429297a0 100644
--- a/drivers/memory/Kconfig
+++ b/drivers/memory/Kconfig
@@ -30,6 +30,7 @@ config ATMEL_EBI
 	default y
 	depends on ARCH_AT91 && OF
 	select MFD_SYSCON
+	select MFD_ATMEL_SMC
 	help
 	  Driver for Atmel EBI controller.
 	  Used to configure the EBI (external bus interface) when the device-
diff --git a/drivers/memory/atmel-ebi.c b/drivers/memory/atmel-ebi.c
index 4e83a8b92665..e1b8590e7d23 100644
--- a/drivers/memory/atmel-ebi.c
+++ b/drivers/memory/atmel-ebi.c
@@ -18,37 +18,9 @@
 #include <linux/of_device.h>
 #include <linux/regmap.h>
 
-struct at91sam9_smc_timings {
-	u32 ncs_rd_setup_ns;
-	u32 nrd_setup_ns;
-	u32 ncs_wr_setup_ns;
-	u32 nwe_setup_ns;
-	u32 ncs_rd_pulse_ns;
-	u32 nrd_pulse_ns;
-	u32 ncs_wr_pulse_ns;
-	u32 nwe_pulse_ns;
-	u32 nrd_cycle_ns;
-	u32 nwe_cycle_ns;
-	u32 tdf_ns;
-};
-
-struct at91sam9_smc_generic_fields {
-	struct regmap_field *setup;
-	struct regmap_field *pulse;
-	struct regmap_field *cycle;
-	struct regmap_field *mode;
-};
-
-struct at91sam9_ebi_dev_config {
-	struct at91sam9_smc_timings timings;
-	u32 mode;
-};
-
 struct at91_ebi_dev_config {
 	int cs;
-	union {
-		struct at91sam9_ebi_dev_config sam9;
-	};
+	struct atmel_smc_cs_conf smcconf;
 };
 
 struct at91_ebi;
@@ -69,9 +41,8 @@ struct at91_ebi_caps {
 	int (*xlate_config)(struct at91_ebi_dev *ebid,
 			    struct device_node *configs_np,
 			    struct at91_ebi_dev_config *conf);
-	int (*apply_config)(struct at91_ebi_dev *ebid,
-			    struct at91_ebi_dev_config *conf);
-	int (*init)(struct at91_ebi *ebi);
+	void (*apply_config)(struct at91_ebi_dev *ebid,
+			     struct at91_ebi_dev_config *conf);
 };
 
 struct at91_ebi {
@@ -86,151 +57,119 @@ struct at91_ebi {
 	struct device *dev;
 	const struct at91_ebi_caps *caps;
 	struct list_head devs;
-	union {
-		struct at91sam9_smc_generic_fields sam9;
-	};
 };
 
+struct atmel_smc_timing_xlate {
+	const char *name;
+	int (*converter)(struct atmel_smc_cs_conf *conf,
+			 unsigned int shift, unsigned int nycles);
+	unsigned int shift;
+};
+
+#define ATMEL_SMC_SETUP_XLATE(nm, pos)	\
+	{ .name = nm, .converter = atmel_smc_cs_conf_set_setup, .shift = pos}
+
+#define ATMEL_SMC_PULSE_XLATE(nm, pos)	\
+	{ .name = nm, .converter = atmel_smc_cs_conf_set_pulse, .shift = pos}
+
+#define ATMEL_SMC_CYCLE_XLATE(nm, pos)	\
+	{ .name = nm, .converter = atmel_smc_cs_conf_set_setup, .shift = pos}
+
 static void at91sam9_ebi_get_config(struct at91_ebi_dev *ebid,
 				    struct at91_ebi_dev_config *conf)
 {
-	struct at91sam9_smc_generic_fields *fields = &ebid->ebi->sam9;
-	unsigned int clk_period = NSEC_PER_SEC / clk_get_rate(ebid->ebi->clk);
-	struct at91sam9_ebi_dev_config *config = &conf->sam9;
-	struct at91sam9_smc_timings *timings = &config->timings;
-	unsigned int val;
-
-	regmap_fields_read(fields->mode, conf->cs, &val);
-	config->mode = val & ~AT91_SMC_TDF;
-
-	val = (val & AT91_SMC_TDF) >> 16;
-	timings->tdf_ns = clk_period * val;
-
-	regmap_fields_read(fields->setup, conf->cs, &val);
-	timings->ncs_rd_setup_ns = (val >> 24) & 0x1f;
-	timings->ncs_rd_setup_ns += ((val >> 29) & 0x1) * 128;
-	timings->ncs_rd_setup_ns *= clk_period;
-	timings->nrd_setup_ns = (val >> 16) & 0x1f;
-	timings->nrd_setup_ns += ((val >> 21) & 0x1) * 128;
-	timings->nrd_setup_ns *= clk_period;
-	timings->ncs_wr_setup_ns = (val >> 8) & 0x1f;
-	timings->ncs_wr_setup_ns += ((val >> 13) & 0x1) * 128;
-	timings->ncs_wr_setup_ns *= clk_period;
-	timings->nwe_setup_ns = val & 0x1f;
-	timings->nwe_setup_ns += ((val >> 5) & 0x1) * 128;
-	timings->nwe_setup_ns *= clk_period;
-
-	regmap_fields_read(fields->pulse, conf->cs, &val);
-	timings->ncs_rd_pulse_ns = (val >> 24) & 0x3f;
-	timings->ncs_rd_pulse_ns += ((val >> 30) & 0x1) * 256;
-	timings->ncs_rd_pulse_ns *= clk_period;
-	timings->nrd_pulse_ns = (val >> 16) & 0x3f;
-	timings->nrd_pulse_ns += ((val >> 22) & 0x1) * 256;
-	timings->nrd_pulse_ns *= clk_period;
-	timings->ncs_wr_pulse_ns = (val >> 8) & 0x3f;
-	timings->ncs_wr_pulse_ns += ((val >> 14) & 0x1) * 256;
-	timings->ncs_wr_pulse_ns *= clk_period;
-	timings->nwe_pulse_ns = val & 0x3f;
-	timings->nwe_pulse_ns += ((val >> 6) & 0x1) * 256;
-	timings->nwe_pulse_ns *= clk_period;
-
-	regmap_fields_read(fields->cycle, conf->cs, &val);
-	timings->nrd_cycle_ns = (val >> 16) & 0x7f;
-	timings->nrd_cycle_ns += ((val >> 23) & 0x3) * 256;
-	timings->nrd_cycle_ns *= clk_period;
-	timings->nwe_cycle_ns = val & 0x7f;
-	timings->nwe_cycle_ns += ((val >> 7) & 0x3) * 256;
-	timings->nwe_cycle_ns *= clk_period;
+	atmel_smc_cs_conf_get(ebid->ebi->smc.regmap, conf->cs,
+			      &conf->smcconf);
 }
 
-static int at91_xlate_timing(struct device_node *np, const char *prop,
-			     u32 *val, bool *required)
+static void sama5_ebi_get_config(struct at91_ebi_dev *ebid,
+				 struct at91_ebi_dev_config *conf)
 {
-	if (!of_property_read_u32(np, prop, val)) {
-		*required = true;
-		return 0;
-	}
-
-	if (*required)
-		return -EINVAL;
-
-	return 0;
+	atmel_hsmc_cs_conf_get(ebid->ebi->smc.regmap, conf->cs,
+			       &conf->smcconf);
 }
 
-static int at91sam9_smc_xslate_timings(struct at91_ebi_dev *ebid,
+static const struct atmel_smc_timing_xlate timings_xlate_table[] = {
+	ATMEL_SMC_SETUP_XLATE("atmel,smc-ncs-rd-setup-ns",
+			      ATMEL_SMC_NCS_RD_SHIFT),
+	ATMEL_SMC_SETUP_XLATE("atmel,smc-ncs-wr-setup-ns",
+			      ATMEL_SMC_NCS_WR_SHIFT),
+	ATMEL_SMC_SETUP_XLATE("atmel,smc-nrd-setup-ns", ATMEL_SMC_NRD_SHIFT),
+	ATMEL_SMC_SETUP_XLATE("atmel,smc-nwe-setup-ns", ATMEL_SMC_NWE_SHIFT),
+	ATMEL_SMC_PULSE_XLATE("atmel,smc-ncs-rd-pulse-ns",
+			      ATMEL_SMC_NCS_RD_SHIFT),
+	ATMEL_SMC_PULSE_XLATE("atmel,smc-ncs-wr-pulse-ns",
+			      ATMEL_SMC_NCS_WR_SHIFT),
+	ATMEL_SMC_PULSE_XLATE("atmel,smc-nrd-pulse-ns", ATMEL_SMC_NRD_SHIFT),
+	ATMEL_SMC_PULSE_XLATE("atmel,smc-nwe-pulse-ns", ATMEL_SMC_NWE_SHIFT),
+	ATMEL_SMC_CYCLE_XLATE("atmel,smc-nrd-cycle-ns", ATMEL_SMC_NRD_SHIFT),
+	ATMEL_SMC_CYCLE_XLATE("atmel,smc-nwe-cycle-ns", ATMEL_SMC_NWE_SHIFT),
+};
+
+static int at91_ebi_xslate_smc_timings(struct at91_ebi_dev *ebid,
 				       struct device_node *np,
-				       struct at91sam9_smc_timings *timings,
-				       bool *required)
+				       struct atmel_smc_cs_conf *smcconf)
 {
-	int ret;
-
-	ret = at91_xlate_timing(np, "atmel,smc-ncs-rd-setup-ns",
-				&timings->ncs_rd_setup_ns, required);
-	if (ret)
-		goto out;
-
-	ret = at91_xlate_timing(np, "atmel,smc-nrd-setup-ns",
-				&timings->nrd_setup_ns, required);
-	if (ret)
-		goto out;
-
-	ret = at91_xlate_timing(np, "atmel,smc-ncs-wr-setup-ns",
-				&timings->ncs_wr_setup_ns, required);
-	if (ret)
-		goto out;
+	unsigned int clk_rate = clk_get_rate(ebid->ebi->clk);
+	unsigned int clk_period_ns = NSEC_PER_SEC / clk_rate;
+	bool required = false;
+	unsigned int ncycles;
+	int ret, i;
+	u32 val;
 
-	ret = at91_xlate_timing(np, "atmel,smc-nwe-setup-ns",
-				&timings->nwe_setup_ns, required);
-	if (ret)
-		goto out;
+	ret = of_property_read_u32(np, "atmel,smc-tdf-ns", &val);
+	if (!ret) {
+		required = true;
+		ncycles = DIV_ROUND_UP(val, clk_period_ns);
+		if (ncycles > ATMEL_SMC_MODE_TDF_MAX ||
+		    ncycles < ATMEL_SMC_MODE_TDF_MIN) {
+			ret = -EINVAL;
+			goto out;
+		}
 
-	ret = at91_xlate_timing(np, "atmel,smc-ncs-rd-pulse-ns",
-				&timings->ncs_rd_pulse_ns, required);
-	if (ret)
-		goto out;
+		smcconf->mode |= ATMEL_SMC_MODE_TDF(ncycles);
+	}
 
-	ret = at91_xlate_timing(np, "atmel,smc-nrd-pulse-ns",
-				&timings->nrd_pulse_ns, required);
-	if (ret)
-		goto out;
+	for (i = 0; i < ARRAY_SIZE(timings_xlate_table); i++) {
+		const struct atmel_smc_timing_xlate *xlate;
 
-	ret = at91_xlate_timing(np, "atmel,smc-ncs-wr-pulse-ns",
-				&timings->ncs_wr_pulse_ns, required);
-	if (ret)
-		goto out;
+		xlate = &timings_xlate_table[i];
 
-	ret = at91_xlate_timing(np, "atmel,smc-nwe-pulse-ns",
-				&timings->nwe_pulse_ns, required);
-	if (ret)
-		goto out;
-
-	ret = at91_xlate_timing(np, "atmel,smc-nwe-cycle-ns",
-				&timings->nwe_cycle_ns, required);
-	if (ret)
-		goto out;
+		ret = of_property_read_u32(np, xlate->name, &val);
+		if (ret) {
+			if (!required)
+				continue;
+			else
+				break;
+		}
 
-	ret = at91_xlate_timing(np, "atmel,smc-nrd-cycle-ns",
-				&timings->nrd_cycle_ns, required);
-	if (ret)
-		goto out;
+		if (!required) {
+			ret = -EINVAL;
+			break;
+		}
 
-	ret = at91_xlate_timing(np, "atmel,smc-tdf-ns",
-				&timings->tdf_ns, required);
+		ncycles = DIV_ROUND_UP(val, clk_period_ns);
+		ret = xlate->converter(smcconf, xlate->shift, ncycles);
+		if (ret)
+			goto out;
+	}
 
 out:
-	if (ret)
+	if (ret) {
 		dev_err(ebid->ebi->dev,
 			"missing or invalid timings definition in %s",
 			np->full_name);
+		return ret;
+	}
 
-	return ret;
+	return required;
 }
 
-static int at91sam9_ebi_xslate_config(struct at91_ebi_dev *ebid,
+static int at91_ebi_xslate_smc_config(struct at91_ebi_dev *ebid,
 				      struct device_node *np,
 				      struct at91_ebi_dev_config *conf)
 {
-	struct at91sam9_ebi_dev_config *config = &conf->sam9;
+	struct atmel_smc_cs_conf *smcconf = &conf->smcconf;
 	bool required = false;
 	const char *tmp_str;
 	u32 tmp;
@@ -240,15 +179,15 @@ static int at91sam9_ebi_xslate_config(struct at91_ebi_dev *ebid,
 	if (!ret) {
 		switch (tmp) {
 		case 8:
-			config->mode |= AT91_SMC_DBW_8;
+			smcconf->mode |= ATMEL_SMC_MODE_DBW_8;
 			break;
 
 		case 16:
-			config->mode |= AT91_SMC_DBW_16;
+			smcconf->mode |= ATMEL_SMC_MODE_DBW_16;
 			break;
 
 		case 32:
-			config->mode |= AT91_SMC_DBW_32;
+			smcconf->mode |= ATMEL_SMC_MODE_DBW_32;
 			break;
 
 		default:
@@ -259,28 +198,28 @@ static int at91sam9_ebi_xslate_config(struct at91_ebi_dev *ebid,
 	}
 
 	if (of_property_read_bool(np, "atmel,smc-tdf-optimized")) {
-		config->mode |= AT91_SMC_TDFMODE_OPTIMIZED;
+		smcconf->mode |= ATMEL_SMC_MODE_TDFMODE_OPTIMIZED;
 		required = true;
 	}
 
 	tmp_str = NULL;
 	of_property_read_string(np, "atmel,smc-byte-access-type", &tmp_str);
 	if (tmp_str && !strcmp(tmp_str, "write")) {
-		config->mode |= AT91_SMC_BAT_WRITE;
+		smcconf->mode |= ATMEL_SMC_MODE_BAT_WRITE;
 		required = true;
 	}
 
 	tmp_str = NULL;
 	of_property_read_string(np, "atmel,smc-read-mode", &tmp_str);
 	if (tmp_str && !strcmp(tmp_str, "nrd")) {
-		config->mode |= AT91_SMC_READMODE_NRD;
+		smcconf->mode |= ATMEL_SMC_MODE_READMODE_NRD;
 		required = true;
 	}
 
 	tmp_str = NULL;
 	of_property_read_string(np, "atmel,smc-write-mode", &tmp_str);
 	if (tmp_str && !strcmp(tmp_str, "nwe")) {
-		config->mode |= AT91_SMC_WRITEMODE_NWE;
+		smcconf->mode |= ATMEL_SMC_MODE_WRITEMODE_NWE;
 		required = true;
 	}
 
@@ -288,9 +227,9 @@ static int at91sam9_ebi_xslate_config(struct at91_ebi_dev *ebid,
 	of_property_read_string(np, "atmel,smc-exnw-mode", &tmp_str);
 	if (tmp_str) {
 		if (!strcmp(tmp_str, "frozen"))
-			config->mode |= AT91_SMC_EXNWMODE_FROZEN;
+			smcconf->mode |= ATMEL_SMC_MODE_EXNWMODE_FROZEN;
 		else if (!strcmp(tmp_str, "ready"))
-			config->mode |= AT91_SMC_EXNWMODE_READY;
+			smcconf->mode |= ATMEL_SMC_MODE_EXNWMODE_READY;
 		else if (strcmp(tmp_str, "disabled"))
 			return -EINVAL;
 
@@ -301,155 +240,54 @@ static int at91sam9_ebi_xslate_config(struct at91_ebi_dev *ebid,
 	if (!ret) {
 		switch (tmp) {
 		case 4:
-			config->mode |= AT91_SMC_PS_4;
+			smcconf->mode |= ATMEL_SMC_MODE_PS_4;
 			break;
 
 		case 8:
-			config->mode |= AT91_SMC_PS_8;
+			smcconf->mode |= ATMEL_SMC_MODE_PS_8;
 			break;
 
 		case 16:
-			config->mode |= AT91_SMC_PS_16;
+			smcconf->mode |= ATMEL_SMC_MODE_PS_16;
 			break;
 
 		case 32:
-			config->mode |= AT91_SMC_PS_32;
+			smcconf->mode |= ATMEL_SMC_MODE_PS_32;
 			break;
 
 		default:
 			return -EINVAL;
 		}
 
-		config->mode |= AT91_SMC_PMEN;
+		smcconf->mode |= ATMEL_SMC_MODE_PMEN;
 		required = true;
 	}
 
-	ret = at91sam9_smc_xslate_timings(ebid, np, &config->timings,
-					  &required);
+	ret = at91_ebi_xslate_smc_timings(ebid, np, &conf->smcconf);
 	if (ret)
-		return ret;
-
-	return required;
-}
-
-static int at91sam9_ebi_apply_config(struct at91_ebi_dev *ebid,
-				     struct at91_ebi_dev_config *conf)
-{
-	unsigned int clk_rate = clk_get_rate(ebid->ebi->clk);
-	unsigned int clk_period = NSEC_PER_SEC / clk_rate;
-	struct at91sam9_ebi_dev_config *config = &conf->sam9;
-	struct at91sam9_smc_timings *timings = &config->timings;
-	struct at91sam9_smc_generic_fields *fields = &ebid->ebi->sam9;
-	u32 coded_val;
-	u32 val;
+		return -EINVAL;
 
-	coded_val = at91sam9_smc_setup_ns_to_cycles(clk_rate,
-						    timings->ncs_rd_setup_ns);
-	val = AT91SAM9_SMC_NCS_NRDSETUP(coded_val);
-	coded_val = at91sam9_smc_setup_ns_to_cycles(clk_rate,
-						    timings->nrd_setup_ns);
-	val |= AT91SAM9_SMC_NRDSETUP(coded_val);
-	coded_val = at91sam9_smc_setup_ns_to_cycles(clk_rate,
-						    timings->ncs_wr_setup_ns);
-	val |= AT91SAM9_SMC_NCS_WRSETUP(coded_val);
-	coded_val = at91sam9_smc_setup_ns_to_cycles(clk_rate,
-						    timings->nwe_setup_ns);
-	val |= AT91SAM9_SMC_NWESETUP(coded_val);
-	regmap_fields_write(fields->setup, conf->cs, val);
-
-	coded_val = at91sam9_smc_pulse_ns_to_cycles(clk_rate,
-						    timings->ncs_rd_pulse_ns);
-	val = AT91SAM9_SMC_NCS_NRDPULSE(coded_val);
-	coded_val = at91sam9_smc_pulse_ns_to_cycles(clk_rate,
-						    timings->nrd_pulse_ns);
-	val |= AT91SAM9_SMC_NRDPULSE(coded_val);
-	coded_val = at91sam9_smc_pulse_ns_to_cycles(clk_rate,
-						    timings->ncs_wr_pulse_ns);
-	val |= AT91SAM9_SMC_NCS_WRPULSE(coded_val);
-	coded_val = at91sam9_smc_pulse_ns_to_cycles(clk_rate,
-						    timings->nwe_pulse_ns);
-	val |= AT91SAM9_SMC_NWEPULSE(coded_val);
-	regmap_fields_write(fields->pulse, conf->cs, val);
-
-	coded_val = at91sam9_smc_cycle_ns_to_cycles(clk_rate,
-						    timings->nrd_cycle_ns);
-	val = AT91SAM9_SMC_NRDCYCLE(coded_val);
-	coded_val = at91sam9_smc_cycle_ns_to_cycles(clk_rate,
-						    timings->nwe_cycle_ns);
-	val |= AT91SAM9_SMC_NWECYCLE(coded_val);
-	regmap_fields_write(fields->cycle, conf->cs, val);
-
-	val = DIV_ROUND_UP(timings->tdf_ns, clk_period);
-	if (val > AT91_SMC_TDF_MAX)
-		val = AT91_SMC_TDF_MAX;
-	regmap_fields_write(fields->mode, conf->cs,
-			    config->mode | AT91_SMC_TDF_(val));
+	if ((ret > 0 && !required) || (!ret && required)) {
+		dev_err(ebid->ebi->dev, "missing atmel,smc- properties in %s",
+			np->full_name);
+		return -EINVAL;
+	}
 
-	return 0;
+	return required;
 }
 
-static int at91sam9_ebi_init(struct at91_ebi *ebi)
+static void at91sam9_ebi_apply_config(struct at91_ebi_dev *ebid,
+				      struct at91_ebi_dev_config *conf)
 {
-	struct at91sam9_smc_generic_fields *fields = &ebi->sam9;
-	struct reg_field field = REG_FIELD(0, 0, 31);
-
-	field.id_size = fls(ebi->caps->available_cs);
-	field.id_offset = AT91SAM9_SMC_GENERIC_BLK_SZ;
-
-	field.reg = AT91SAM9_SMC_SETUP(AT91SAM9_SMC_GENERIC);
-	fields->setup = devm_regmap_field_alloc(ebi->dev, ebi->smc.regmap,
-						field);
-	if (IS_ERR(fields->setup))
-		return PTR_ERR(fields->setup);
-
-	field.reg = AT91SAM9_SMC_PULSE(AT91SAM9_SMC_GENERIC);
-	fields->pulse = devm_regmap_field_alloc(ebi->dev, ebi->smc.regmap,
-						field);
-	if (IS_ERR(fields->pulse))
-		return PTR_ERR(fields->pulse);
-
-	field.reg = AT91SAM9_SMC_CYCLE(AT91SAM9_SMC_GENERIC);
-	fields->cycle = devm_regmap_field_alloc(ebi->dev, ebi->smc.regmap,
-						field);
-	if (IS_ERR(fields->cycle))
-		return PTR_ERR(fields->cycle);
-
-	field.reg = AT91SAM9_SMC_MODE(AT91SAM9_SMC_GENERIC);
-	fields->mode = devm_regmap_field_alloc(ebi->dev, ebi->smc.regmap,
-					       field);
-	return PTR_ERR_OR_ZERO(fields->mode);
+	atmel_smc_cs_conf_apply(ebid->ebi->smc.regmap, conf->cs,
+				&conf->smcconf);
 }
 
-static int sama5d3_ebi_init(struct at91_ebi *ebi)
+static void sama5_ebi_apply_config(struct at91_ebi_dev *ebid,
+				   struct at91_ebi_dev_config *conf)
 {
-	struct at91sam9_smc_generic_fields *fields = &ebi->sam9;
-	struct reg_field field = REG_FIELD(0, 0, 31);
-
-	field.id_size = fls(ebi->caps->available_cs);
-	field.id_offset = SAMA5_SMC_GENERIC_BLK_SZ;
-
-	field.reg = AT91SAM9_SMC_SETUP(SAMA5_SMC_GENERIC);
-	fields->setup = devm_regmap_field_alloc(ebi->dev, ebi->smc.regmap,
-						field);
-	if (IS_ERR(fields->setup))
-		return PTR_ERR(fields->setup);
-
-	field.reg = AT91SAM9_SMC_PULSE(SAMA5_SMC_GENERIC);
-	fields->pulse = devm_regmap_field_alloc(ebi->dev, ebi->smc.regmap,
-						field);
-	if (IS_ERR(fields->pulse))
-		return PTR_ERR(fields->pulse);
-
-	field.reg = AT91SAM9_SMC_CYCLE(SAMA5_SMC_GENERIC);
-	fields->cycle = devm_regmap_field_alloc(ebi->dev, ebi->smc.regmap,
-						field);
-	if (IS_ERR(fields->cycle))
-		return PTR_ERR(fields->cycle);
-
-	field.reg = SAMA5_SMC_MODE(SAMA5_SMC_GENERIC);
-	fields->mode = devm_regmap_field_alloc(ebi->dev, ebi->smc.regmap,
-					       field);
-	return PTR_ERR_OR_ZERO(fields->mode);
+	atmel_hsmc_cs_conf_apply(ebid->ebi->smc.regmap, conf->cs,
+				 &conf->smcconf);
 }
 
 static int at91_ebi_dev_setup(struct at91_ebi *ebi, struct device_node *np,
@@ -508,9 +346,7 @@ static int at91_ebi_dev_setup(struct at91_ebi *ebi, struct device_node *np,
 
 		if (apply) {
 			conf.cs = cs;
-			ret = caps->apply_config(ebid, &conf);
-			if (ret)
-				return ret;
+			caps->apply_config(ebid, &conf);
 		}
 
 		caps->get_config(ebid, &ebid->configs[i]);
@@ -539,9 +375,8 @@ static const struct at91_ebi_caps at91sam9260_ebi_caps = {
 	.available_cs = 0xff,
 	.ebi_csa = &at91sam9260_ebi_csa,
 	.get_config = at91sam9_ebi_get_config,
-	.xlate_config = at91sam9_ebi_xslate_config,
+	.xlate_config = at91_ebi_xslate_smc_config,
 	.apply_config = at91sam9_ebi_apply_config,
-	.init = at91sam9_ebi_init,
 };
 
 static const struct reg_field at91sam9261_ebi_csa =
@@ -552,9 +387,8 @@ static const struct at91_ebi_caps at91sam9261_ebi_caps = {
 	.available_cs = 0xff,
 	.ebi_csa = &at91sam9261_ebi_csa,
 	.get_config = at91sam9_ebi_get_config,
-	.xlate_config = at91sam9_ebi_xslate_config,
+	.xlate_config = at91_ebi_xslate_smc_config,
 	.apply_config = at91sam9_ebi_apply_config,
-	.init = at91sam9_ebi_init,
 };
 
 static const struct reg_field at91sam9263_ebi0_csa =
@@ -565,9 +399,8 @@ static const struct at91_ebi_caps at91sam9263_ebi0_caps = {
 	.available_cs = 0x3f,
 	.ebi_csa = &at91sam9263_ebi0_csa,
 	.get_config = at91sam9_ebi_get_config,
-	.xlate_config = at91sam9_ebi_xslate_config,
+	.xlate_config = at91_ebi_xslate_smc_config,
 	.apply_config = at91sam9_ebi_apply_config,
-	.init = at91sam9_ebi_init,
 };
 
 static const struct reg_field at91sam9263_ebi1_csa =
@@ -578,9 +411,8 @@ static const struct at91_ebi_caps at91sam9263_ebi1_caps = {
 	.available_cs = 0x7,
 	.ebi_csa = &at91sam9263_ebi1_csa,
 	.get_config = at91sam9_ebi_get_config,
-	.xlate_config = at91sam9_ebi_xslate_config,
+	.xlate_config = at91_ebi_xslate_smc_config,
 	.apply_config = at91sam9_ebi_apply_config,
-	.init = at91sam9_ebi_init,
 };
 
 static const struct reg_field at91sam9rl_ebi_csa =
@@ -591,9 +423,8 @@ static const struct at91_ebi_caps at91sam9rl_ebi_caps = {
 	.available_cs = 0x3f,
 	.ebi_csa = &at91sam9rl_ebi_csa,
 	.get_config = at91sam9_ebi_get_config,
-	.xlate_config = at91sam9_ebi_xslate_config,
+	.xlate_config = at91_ebi_xslate_smc_config,
 	.apply_config = at91sam9_ebi_apply_config,
-	.init = at91sam9_ebi_init,
 };
 
 static const struct reg_field at91sam9g45_ebi_csa =
@@ -604,26 +435,23 @@ static const struct at91_ebi_caps at91sam9g45_ebi_caps = {
 	.available_cs = 0x3f,
 	.ebi_csa = &at91sam9g45_ebi_csa,
 	.get_config = at91sam9_ebi_get_config,
-	.xlate_config = at91sam9_ebi_xslate_config,
+	.xlate_config = at91_ebi_xslate_smc_config,
 	.apply_config = at91sam9_ebi_apply_config,
-	.init = at91sam9_ebi_init,
 };
 
 static const struct at91_ebi_caps at91sam9x5_ebi_caps = {
 	.available_cs = 0x3f,
 	.ebi_csa = &at91sam9263_ebi0_csa,
 	.get_config = at91sam9_ebi_get_config,
-	.xlate_config = at91sam9_ebi_xslate_config,
+	.xlate_config = at91_ebi_xslate_smc_config,
 	.apply_config = at91sam9_ebi_apply_config,
-	.init = at91sam9_ebi_init,
 };
 
 static const struct at91_ebi_caps sama5d3_ebi_caps = {
 	.available_cs = 0xf,
-	.get_config = at91sam9_ebi_get_config,
-	.xlate_config = at91sam9_ebi_xslate_config,
-	.apply_config = at91sam9_ebi_apply_config,
-	.init = sama5d3_ebi_init,
+	.get_config = sama5_ebi_get_config,
+	.xlate_config = at91_ebi_xslate_smc_config,
+	.apply_config = sama5_ebi_apply_config,
 };
 
 static const struct of_device_id at91_ebi_id_table[] = {
@@ -745,10 +573,6 @@ static int at91_ebi_probe(struct platform_device *pdev)
 			return PTR_ERR(ebi->ebi_csa);
 	}
 
-	ret = ebi->caps->init(ebi);
-	if (ret)
-		return ret;
-
 	ret = of_property_read_u32(np, "#address-cells", &val);
 	if (ret) {
 		dev_err(dev, "missing #address-cells property\n");
-- 
2.7.4
