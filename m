From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 28 Jan 2014 13:18:38 +0100
Subject: [PATCH 14/18] extcon: max14577: Add support for max77836
In-Reply-To: <1390911522-28209-1-git-send-email-k.kozlowski@samsung.com>
References: <1390911522-28209-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1390911522-28209-15-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for MAX77836 chipset to the max14577 extcon driver. The
MAX77836 MUIC has additional interrupts (VIDRM, ADC1K) so IRQ handling
is split up into two functions: max14577_parse_irq() and
max77836_parse_irq().

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/extcon/extcon-max14577.c     |  107 ++++++++++++++++++++++++++++------
 drivers/mfd/max14577.c               |    1 +
 include/linux/mfd/max14577-private.h |    3 +
 3 files changed, 93 insertions(+), 18 deletions(-)

diff --git a/drivers/extcon/extcon-max14577.c b/drivers/extcon/extcon-max14577.c
index e986a9b92b60..440b19ac5fba 100644
--- a/drivers/extcon/extcon-max14577.c
+++ b/drivers/extcon/extcon-max14577.c
@@ -1,8 +1,9 @@
 /*
- * extcon-max14577.c - MAX14577 extcon driver to support MAX14577 MUIC
+ * extcon-max14577.c - MAX14577/77836 extcon driver to support MUIC
  *
- * Copyright (C) 2013 Samsung Electrnoics
+ * Copyright (C) 2013,2014 Samsung Electrnoics
  * Chanwoo Choi <cw00.choi@samsung.com>
+ * Krzysztof Kozlowski <k.kozlowski@samsung.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -62,6 +63,19 @@ static struct max14577_muic_irq max14577_muic_irqs[] = {
 	{ MAXIM_IRQ_INT2_VBVOLT,	"muic-VBVOLT" },
 };
 
+static struct max14577_muic_irq max77836_muic_irqs[] = {
+	{ MAXIM_IRQ_INT1_ADC,		"muic-ADC" },
+	{ MAXIM_IRQ_INT1_ADCLOW,	"muic-ADCLOW" },
+	{ MAXIM_IRQ_INT1_ADCERR,	"muic-ADCError" },
+	{ MAX77836_IRQ_INT1_ADC1K,	"muic-ADC1K" },
+	{ MAXIM_IRQ_INT2_CHGTYP,	"muic-CHGTYP" },
+	{ MAXIM_IRQ_INT2_CHGDETRUN,	"muic-CHGDETRUN" },
+	{ MAXIM_IRQ_INT2_DCDTMR,	"muic-DCDTMR" },
+	{ MAXIM_IRQ_INT2_DBCHG,		"muic-DBCHG" },
+	{ MAXIM_IRQ_INT2_VBVOLT,	"muic-VBVOLT" },
+	{ MAX77836_IRQ_INT2_VIDRM,	"muic-VIDRM" },
+};
+
 struct max14577_muic_info {
 	struct device *dev;
 	struct maxim_core *maxim_core;
@@ -532,21 +546,12 @@ static void max14577_muic_irq_work(struct work_struct *work)
 	return;
 }
 
-static irqreturn_t max14577_muic_irq_handler(int irq, void *data)
+/*
+ * Sets irq_adc or irq_chg in max14577_muic_info and returns 1.
+ * Returns 0 if irq_type does not match registered IRQ for this device type.
+ */
+static int max14577_parse_irq(struct max14577_muic_info *info, int irq_type)
 {
-	struct max14577_muic_info *info = data;
-	int i, irq_type = -1;
-
-	/*
-	 * We may be called multiple times for different nested IRQ-s.
-	 * Including changes in INT1_ADC and INT2_CGHTYP at once.
-	 * However we only need to know whether it was ADC, charger
-	 * or both interrupts so decode IRQ and turn on proper flags.
-	 */
-	for (i = 0; i < info->muic_irqs_num; i++)
-		if (irq == info->muic_irqs[i].virq)
-			irq_type = info->muic_irqs[i].irq;
-
 	switch (irq_type) {
 	case MAXIM_IRQ_INT1_ADC:
 	case MAXIM_IRQ_INT1_ADCLOW:
@@ -554,7 +559,7 @@ static irqreturn_t max14577_muic_irq_handler(int irq, void *data)
 		/* Handle all of accessory except for
 		   type of charger accessory */
 		info->irq_adc = true;
-		break;
+		return 1;
 	case MAXIM_IRQ_INT2_CHGTYP:
 	case MAXIM_IRQ_INT2_CHGDETRUN:
 	case MAXIM_IRQ_INT2_DCDTMR:
@@ -562,8 +567,62 @@ static irqreturn_t max14577_muic_irq_handler(int irq, void *data)
 	case MAXIM_IRQ_INT2_VBVOLT:
 		/* Handle charger accessory */
 		info->irq_chg = true;
+		return 1;
+	default:
+		return 0;
+	}
+}
+
+/*
+ * Sets irq_adc or irq_chg in max14577_muic_info and returns 1.
+ * Returns 0 if irq_type does not match registered IRQ for this device type.
+ */
+static int max77836_parse_irq(struct max14577_muic_info *info, int irq_type)
+{
+	/* First check common max14577 interrupts */
+	if (max14577_parse_irq(info, irq_type))
+		return 1;
+
+	switch (irq_type) {
+	case MAX77836_IRQ_INT1_ADC1K:
+		info->irq_adc = true;
+		return 1;
+	case MAX77836_IRQ_INT2_VIDRM:
+		/* Handle charger accessory */
+		info->irq_chg = true;
+		return 1;
+	default:
+		return 0;
+	}
+}
+
+static irqreturn_t max14577_muic_irq_handler(int irq, void *data)
+{
+	struct max14577_muic_info *info = data;
+	int i, irq_type = -1;
+	bool irq_parsed;
+
+	/*
+	 * We may be called multiple times for different nested IRQ-s.
+	 * Including changes in INT1_ADC and INT2_CGHTYP at once.
+	 * However we only need to know whether it was ADC, charger
+	 * or both interrupts so decode IRQ and turn on proper flags.
+	 */
+	for (i = 0; i < info->muic_irqs_num; i++)
+		if (irq == info->muic_irqs[i].virq)
+			irq_type = info->muic_irqs[i].irq;
+
+	switch (info->maxim_core->dev_type) {
+	case MAXIM_DEVICE_TYPE_MAX77836:
+		irq_parsed = max77836_parse_irq(info, irq_type);
 		break;
+	case MAXIM_DEVICE_TYPE_MAX14577:
 	default:
+		irq_parsed = max14577_parse_irq(info, irq_type);
+		break;
+	}
+
+	if (!irq_parsed) {
 		dev_err(info->dev, "muic interrupt: irq %d occurred, skipped\n",
 				irq_type);
 		return IRQ_HANDLED;
@@ -649,6 +708,10 @@ static int max14577_muic_probe(struct platform_device *pdev)
 	INIT_WORK(&info->irq_work, max14577_muic_irq_work);
 
 	switch (maxim_core->dev_type) {
+	case MAXIM_DEVICE_TYPE_MAX77836:
+		info->muic_irqs = max77836_muic_irqs;
+		info->muic_irqs_num = ARRAY_SIZE(max77836_muic_irqs);
+		break;
 	case MAXIM_DEVICE_TYPE_MAX14577:
 	default:
 		info->muic_irqs = max14577_muic_irqs;
@@ -748,6 +811,13 @@ static int max14577_muic_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct platform_device_id max14577_muic_id[] = {
+	{ "max14577-muic", MAXIM_DEVICE_TYPE_MAX14577, },
+	{ "max77836-muic", MAXIM_DEVICE_TYPE_MAX77836, },
+	{ }
+};
+MODULE_DEVICE_TABLE(platform, max14577_muic_id);
+
 static struct platform_driver max14577_muic_driver = {
 	.driver		= {
 		.name	= "max14577-muic",
@@ -755,11 +825,12 @@ static struct platform_driver max14577_muic_driver = {
 	},
 	.probe		= max14577_muic_probe,
 	.remove		= max14577_muic_remove,
+	.id_table	= max14577_muic_id,
 };
 
 module_platform_driver(max14577_muic_driver);
 
-MODULE_DESCRIPTION("MAXIM 14577 Extcon driver");
+MODULE_DESCRIPTION("Maxim 14577/77836 Extcon driver");
 MODULE_AUTHOR("Chanwoo Choi <cw00.choi@samsung.com>");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:extcon-max14577");
diff --git a/drivers/mfd/max14577.c b/drivers/mfd/max14577.c
index 5b10f6f89834..561182e24430 100644
--- a/drivers/mfd/max14577.c
+++ b/drivers/mfd/max14577.c
@@ -146,6 +146,7 @@ static const struct regmap_irq max77836_muic_irqs[] = {
 	{ .reg_offset = 0, .mask = MAXIM_INT1_ADC_MASK, },
 	{ .reg_offset = 0, .mask = MAXIM_INT1_ADCLOW_MASK, },
 	{ .reg_offset = 0, .mask = MAXIM_INT1_ADCERR_MASK, },
+	{ .reg_offset = 0, .mask = MAX77836_INT1_ADC1K_MASK, },
 	/* INT2 interrupts */
 	{ .reg_offset = 1, .mask = MAXIM_INT2_CHGTYP_MASK, },
 	{ .reg_offset = 1, .mask = MAXIM_INT2_CHGDETRUN_MASK, },
diff --git a/include/linux/mfd/max14577-private.h b/include/linux/mfd/max14577-private.h
index e0dd27d937d6..f08fb59a21a0 100644
--- a/include/linux/mfd/max14577-private.h
+++ b/include/linux/mfd/max14577-private.h
@@ -77,6 +77,7 @@ enum maxim_muic_charger_type {
 #define MAXIM_INT1_ADC_MASK			(0x1 << 0)
 #define MAXIM_INT1_ADCLOW_MASK			(0x1 << 1)
 #define MAXIM_INT1_ADCERR_MASK			(0x1 << 2)
+#define MAX77836_INT1_ADC1K_MASK		(0x1 << 3)
 
 #define MAXIM_INT2_CHGTYP_MASK			(0x1 << 0)
 #define MAXIM_INT2_CHGDETRUN_MASK		(0x1 << 1)
@@ -311,6 +312,7 @@ enum maxim_irq {
 	MAXIM_IRQ_INT1_ADC,
 	MAXIM_IRQ_INT1_ADCLOW,
 	MAXIM_IRQ_INT1_ADCERR,
+	MAX77836_IRQ_INT1_ADC1K,
 
 	/* INT2 */
 	MAXIM_IRQ_INT2_CHGTYP,
@@ -318,6 +320,7 @@ enum maxim_irq {
 	MAXIM_IRQ_INT2_DCDTMR,
 	MAXIM_IRQ_INT2_DBCHG,
 	MAXIM_IRQ_INT2_VBVOLT,
+	MAX77836_IRQ_INT2_VIDRM,
 
 	/* INT3 */
 	MAXIM_IRQ_INT3_EOC,
-- 
1.7.9.5
