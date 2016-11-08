From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue,  8 Nov 2016 16:29:36 +0000
Subject: [PATCH 1/2] mfd: pm8921: add support to pm8821
Message-ID: <1478622577-20699-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support to PM8821 PMIC and interrupt support.
PM8821 is companion device that supplements primary PMIC PM8921 IC.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
Tested this patch for MPP and IRQ functionality on IFC6410 and SD600 EVAL
board with mpps PM8821 and PM8921.

 .../devicetree/bindings/mfd/qcom-pm8xxx.txt        |   1 +
 drivers/mfd/pm8921-core.c                          | 368 +++++++++++++++++++--
 2 files changed, 340 insertions(+), 29 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/qcom-pm8xxx.txt b/Documentation/devicetree/bindings/mfd/qcom-pm8xxx.txt
index 37a088f..8f1b4ec 100644
--- a/Documentation/devicetree/bindings/mfd/qcom-pm8xxx.txt
+++ b/Documentation/devicetree/bindings/mfd/qcom-pm8xxx.txt
@@ -11,6 +11,7 @@ voltages and other various functionality to Qualcomm SoCs.
 	Definition: must be one of:
 		    "qcom,pm8058"
 		    "qcom,pm8921"
+		    "qcom,pm8821"
 
 - #address-cells:
 	Usage: required
diff --git a/drivers/mfd/pm8921-core.c b/drivers/mfd/pm8921-core.c
index 0e3a2ea..28c2470 100644
--- a/drivers/mfd/pm8921-core.c
+++ b/drivers/mfd/pm8921-core.c
@@ -28,16 +28,26 @@
 #include <linux/mfd/core.h>
 
 #define	SSBI_REG_ADDR_IRQ_BASE		0x1BB
-
-#define	SSBI_REG_ADDR_IRQ_ROOT		(SSBI_REG_ADDR_IRQ_BASE + 0)
-#define	SSBI_REG_ADDR_IRQ_M_STATUS1	(SSBI_REG_ADDR_IRQ_BASE + 1)
-#define	SSBI_REG_ADDR_IRQ_M_STATUS2	(SSBI_REG_ADDR_IRQ_BASE + 2)
-#define	SSBI_REG_ADDR_IRQ_M_STATUS3	(SSBI_REG_ADDR_IRQ_BASE + 3)
-#define	SSBI_REG_ADDR_IRQ_M_STATUS4	(SSBI_REG_ADDR_IRQ_BASE + 4)
-#define	SSBI_REG_ADDR_IRQ_BLK_SEL	(SSBI_REG_ADDR_IRQ_BASE + 5)
-#define	SSBI_REG_ADDR_IRQ_IT_STATUS	(SSBI_REG_ADDR_IRQ_BASE + 6)
-#define	SSBI_REG_ADDR_IRQ_CONFIG	(SSBI_REG_ADDR_IRQ_BASE + 7)
-#define	SSBI_REG_ADDR_IRQ_RT_STATUS	(SSBI_REG_ADDR_IRQ_BASE + 8)
+#define	SSBI_PM8821_REG_ADDR_IRQ_BASE	0x100
+
+#define	SSBI_REG_ADDR_IRQ_ROOT		(0)
+#define	SSBI_REG_ADDR_IRQ_M_STATUS1	(1)
+#define	SSBI_REG_ADDR_IRQ_M_STATUS2	(2)
+#define	SSBI_REG_ADDR_IRQ_M_STATUS3	(3)
+#define	SSBI_REG_ADDR_IRQ_M_STATUS4	(4)
+#define	SSBI_REG_ADDR_IRQ_BLK_SEL	(5)
+#define	SSBI_REG_ADDR_IRQ_IT_STATUS	(6)
+#define	SSBI_REG_ADDR_IRQ_CONFIG	(7)
+#define	SSBI_REG_ADDR_IRQ_RT_STATUS	(8)
+
+#define	PM8821_TOTAL_IRQ_MASTERS	2
+#define	PM8821_BLOCKS_PER_MASTER	7
+#define	PM8821_IRQ_MASTER1_SET		0x01
+#define	PM8821_IRQ_CLEAR_OFFSET		0x01
+#define	PM8821_IRQ_RT_STATUS_OFFSET	0x0f
+#define	PM8821_IRQ_MASK_REG_OFFSET	0x08
+#define	SSBI_REG_ADDR_IRQ_MASTER0	0x30
+#define	SSBI_REG_ADDR_IRQ_MASTER1	0xb0
 
 #define	PM_IRQF_LVL_SEL			0x01	/* level select */
 #define	PM_IRQF_MASK_FE			0x02	/* mask falling edge */
@@ -54,30 +64,41 @@
 #define REG_HWREV_2		0x0E8  /* PMIC4 revision 2 */
 
 #define PM8921_NR_IRQS		256
+#define PM8821_NR_IRQS		112
 
 struct pm_irq_chip {
 	struct regmap		*regmap;
 	spinlock_t		pm_irq_lock;
 	struct irq_domain	*irqdomain;
+	unsigned int		irq_reg_base;
 	unsigned int		num_irqs;
 	unsigned int		num_blocks;
 	unsigned int		num_masters;
 	u8			config[0];
 };
 
+struct pm8xxx_data {
+	int num_irqs;
+	unsigned int		irq_reg_base;
+	const struct irq_domain_ops  *irq_domain_ops;
+	void (*irq_handler)(struct irq_desc *desc);
+};
+
 static int pm8xxx_read_block_irq(struct pm_irq_chip *chip, unsigned int bp,
 				 unsigned int *ip)
 {
 	int	rc;
 
 	spin_lock(&chip->pm_irq_lock);
-	rc = regmap_write(chip->regmap, SSBI_REG_ADDR_IRQ_BLK_SEL, bp);
+	rc = regmap_write(chip->regmap,
+			  chip->irq_reg_base + SSBI_REG_ADDR_IRQ_BLK_SEL, bp);
 	if (rc) {
 		pr_err("Failed Selecting Block %d rc=%d\n", bp, rc);
 		goto bail;
 	}
 
-	rc = regmap_read(chip->regmap, SSBI_REG_ADDR_IRQ_IT_STATUS, ip);
+	rc = regmap_read(chip->regmap,
+			 chip->irq_reg_base + SSBI_REG_ADDR_IRQ_IT_STATUS, ip);
 	if (rc)
 		pr_err("Failed Reading Status rc=%d\n", rc);
 bail:
@@ -91,14 +112,16 @@ pm8xxx_config_irq(struct pm_irq_chip *chip, unsigned int bp, unsigned int cp)
 	int	rc;
 
 	spin_lock(&chip->pm_irq_lock);
-	rc = regmap_write(chip->regmap, SSBI_REG_ADDR_IRQ_BLK_SEL, bp);
+	rc = regmap_write(chip->regmap,
+			  chip->irq_reg_base + SSBI_REG_ADDR_IRQ_BLK_SEL, bp);
 	if (rc) {
 		pr_err("Failed Selecting Block %d rc=%d\n", bp, rc);
 		goto bail;
 	}
 
 	cp |= PM_IRQF_WRITE;
-	rc = regmap_write(chip->regmap, SSBI_REG_ADDR_IRQ_CONFIG, cp);
+	rc = regmap_write(chip->regmap,
+			  chip->irq_reg_base + SSBI_REG_ADDR_IRQ_CONFIG, cp);
 	if (rc)
 		pr_err("Failed Configuring IRQ rc=%d\n", rc);
 bail:
@@ -137,8 +160,8 @@ static int pm8xxx_irq_master_handler(struct pm_irq_chip *chip, int master)
 	unsigned int blockbits;
 	int block_number, i, ret = 0;
 
-	ret = regmap_read(chip->regmap, SSBI_REG_ADDR_IRQ_M_STATUS1 + master,
-			  &blockbits);
+	ret = regmap_read(chip->regmap, chip->irq_reg_base +
+			  SSBI_REG_ADDR_IRQ_M_STATUS1 + master, &blockbits);
 	if (ret) {
 		pr_err("Failed to read master %d ret=%d\n", master, ret);
 		return ret;
@@ -165,7 +188,8 @@ static void pm8xxx_irq_handler(struct irq_desc *desc)
 
 	chained_irq_enter(irq_chip, desc);
 
-	ret = regmap_read(chip->regmap, SSBI_REG_ADDR_IRQ_ROOT, &root);
+	ret = regmap_read(chip->regmap,
+			  chip->irq_reg_base + SSBI_REG_ADDR_IRQ_ROOT, &root);
 	if (ret) {
 		pr_err("Can't read root status ret=%d\n", ret);
 		return;
@@ -182,6 +206,122 @@ static void pm8xxx_irq_handler(struct irq_desc *desc)
 	chained_irq_exit(irq_chip, desc);
 }
 
+static int pm8821_read_master_irq(const struct pm_irq_chip *chip,
+				  int m, unsigned int *master)
+{
+	unsigned int base;
+
+	if (!m)
+		base = chip->irq_reg_base + SSBI_REG_ADDR_IRQ_MASTER0;
+	else
+		base = chip->irq_reg_base + SSBI_REG_ADDR_IRQ_MASTER1;
+
+	return regmap_read(chip->regmap, base, master);
+}
+
+static int pm8821_read_block_irq(struct pm_irq_chip *chip, int master,
+				 u8 block, unsigned int *bits)
+{
+	int rc;
+
+	unsigned int base;
+
+	if (!master)
+		base = chip->irq_reg_base + SSBI_REG_ADDR_IRQ_MASTER0;
+	else
+		base = chip->irq_reg_base + SSBI_REG_ADDR_IRQ_MASTER1;
+
+	spin_lock(&chip->pm_irq_lock);
+
+	rc = regmap_read(chip->regmap, base + block, bits);
+	if (rc)
+		pr_err("Failed Reading Status rc=%d\n", rc);
+
+	spin_unlock(&chip->pm_irq_lock);
+	return rc;
+}
+
+static int pm8821_irq_block_handler(struct pm_irq_chip *chip,
+				    int master_number, int block)
+{
+	int pmirq, irq, i, ret;
+	unsigned int bits;
+
+	ret = pm8821_read_block_irq(chip, master_number, block, &bits);
+	if (ret) {
+		pr_err("Failed reading %d block ret=%d", block, ret);
+		return ret;
+	}
+	if (!bits) {
+		pr_err("block bit set in master but no irqs: %d", block);
+		return 0;
+	}
+
+	/* Convert block offset to global block number */
+	block += (master_number * PM8821_BLOCKS_PER_MASTER) - 1;
+
+	/* Check IRQ bits */
+	for (i = 0; i < 8; i++) {
+		if (bits & BIT(i)) {
+			pmirq = block * 8 + i;
+			irq = irq_find_mapping(chip->irqdomain, pmirq);
+			generic_handle_irq(irq);
+		}
+	}
+
+	return 0;
+}
+
+static int pm8821_irq_read_master(struct pm_irq_chip *chip,
+				int master_number, u8 master_val)
+{
+	int ret = 0;
+	int block;
+
+	for (block = 1; block < 8; block++) {
+		if (master_val & BIT(block)) {
+			ret |= pm8821_irq_block_handler(chip,
+					master_number, block);
+		}
+	}
+
+	return ret;
+}
+
+static void pm8821_irq_handler(struct irq_desc *desc)
+{
+	struct pm_irq_chip *chip = irq_desc_get_handler_data(desc);
+	struct irq_chip *irq_chip = irq_desc_get_chip(desc);
+	int ret;
+	unsigned int master;
+
+	chained_irq_enter(irq_chip, desc);
+	/* check master 0 */
+	ret = pm8821_read_master_irq(chip, 0, &master);
+	if (ret) {
+		pr_err("Failed to re:Qad master 0 ret=%d\n", ret);
+		return;
+	}
+
+	if (master & ~PM8821_IRQ_MASTER1_SET)
+		pm8821_irq_read_master(chip, 0, master);
+
+	/* check master 1 */
+	if (!(master & PM8821_IRQ_MASTER1_SET))
+		goto done;
+
+	ret = pm8821_read_master_irq(chip, 1, &master);
+	if (ret) {
+		pr_err("Failed to read master 1 ret=%d\n", ret);
+		return;
+	}
+
+	pm8821_irq_read_master(chip, 1, master);
+
+done:
+	chained_irq_exit(irq_chip, desc);
+}
+
 static void pm8xxx_irq_mask_ack(struct irq_data *d)
 {
 	struct pm_irq_chip *chip = irq_data_get_irq_chip_data(d);
@@ -254,13 +394,15 @@ static int pm8xxx_irq_get_irqchip_state(struct irq_data *d,
 	irq_bit = pmirq % 8;
 
 	spin_lock(&chip->pm_irq_lock);
-	rc = regmap_write(chip->regmap, SSBI_REG_ADDR_IRQ_BLK_SEL, block);
+	rc = regmap_write(chip->regmap, chip->irq_reg_base +
+			  SSBI_REG_ADDR_IRQ_BLK_SEL, block);
 	if (rc) {
 		pr_err("Failed Selecting Block %d rc=%d\n", block, rc);
 		goto bail;
 	}
 
-	rc = regmap_read(chip->regmap, SSBI_REG_ADDR_IRQ_RT_STATUS, &bits);
+	rc = regmap_read(chip->regmap, chip->irq_reg_base +
+			 SSBI_REG_ADDR_IRQ_RT_STATUS, &bits);
 	if (rc) {
 		pr_err("Failed Reading Status rc=%d\n", rc);
 		goto bail;
@@ -299,6 +441,151 @@ static const struct irq_domain_ops pm8xxx_irq_domain_ops = {
 	.map = pm8xxx_irq_domain_map,
 };
 
+static void pm8821_irq_mask_ack(struct irq_data *d)
+{
+	struct pm_irq_chip *chip = irq_data_get_irq_chip_data(d);
+	unsigned int base, pmirq = irqd_to_hwirq(d);
+	u8 block, master;
+	int irq_bit, rc;
+
+	block = pmirq / 8;
+	master = block / PM8821_BLOCKS_PER_MASTER;
+	irq_bit = pmirq % 8;
+	block %= PM8821_BLOCKS_PER_MASTER;
+
+	if (!master)
+		base = chip->irq_reg_base + SSBI_REG_ADDR_IRQ_MASTER0;
+	else
+		base = chip->irq_reg_base + SSBI_REG_ADDR_IRQ_MASTER1;
+
+	spin_lock(&chip->pm_irq_lock);
+	rc = regmap_update_bits(chip->regmap,
+				base + PM8821_IRQ_MASK_REG_OFFSET + block,
+				BIT(irq_bit), BIT(irq_bit));
+
+	if (rc) {
+		pr_err("Failed to read/write mask IRQ:%d rc=%d\n", pmirq, rc);
+		goto fail;
+	}
+
+	rc = regmap_update_bits(chip->regmap,
+				base + PM8821_IRQ_CLEAR_OFFSET + block,
+				BIT(irq_bit), BIT(irq_bit));
+
+	if (rc) {
+		pr_err("Failed to read/write IT_CLEAR IRQ:%d rc=%d\n",
+								pmirq, rc);
+	}
+
+fail:
+	spin_unlock(&chip->pm_irq_lock);
+}
+
+static void pm8821_irq_unmask(struct irq_data *d)
+{
+	struct pm_irq_chip *chip = irq_data_get_irq_chip_data(d);
+	unsigned int base, pmirq = irqd_to_hwirq(d);
+	int irq_bit, rc;
+	u8 block, master;
+
+	block = pmirq / 8;
+	master = block / PM8821_BLOCKS_PER_MASTER;
+	irq_bit = pmirq % 8;
+	block %= PM8821_BLOCKS_PER_MASTER;
+
+	if (!master)
+		base = chip->irq_reg_base + SSBI_REG_ADDR_IRQ_MASTER0;
+	else
+		base = chip->irq_reg_base + SSBI_REG_ADDR_IRQ_MASTER1;
+
+	spin_lock(&chip->pm_irq_lock);
+
+	rc = regmap_update_bits(chip->regmap,
+				base + PM8821_IRQ_MASK_REG_OFFSET + block,
+				BIT(irq_bit), ~BIT(irq_bit));
+
+	if (rc)
+		pr_err("Failed to read/write unmask IRQ:%d rc=%d\n", pmirq, rc);
+
+	spin_unlock(&chip->pm_irq_lock);
+}
+
+static int pm8821_irq_set_type(struct irq_data *d, unsigned int flow_type)
+{
+
+	/*
+	 * PM8821 IRQ controller does not have explicit software support for
+	 * IRQ flow type.
+	 */
+	return 0;
+}
+
+static int pm8821_irq_get_irqchip_state(struct irq_data *d,
+					enum irqchip_irq_state which,
+					bool *state)
+{
+	struct pm_irq_chip *chip = irq_data_get_irq_chip_data(d);
+	int pmirq, rc;
+	u8 block, irq_bit, master;
+	unsigned int bits;
+	unsigned int base;
+	unsigned long flags;
+
+	pmirq = irqd_to_hwirq(d);
+
+	block = pmirq / 8;
+	master = block / PM8821_BLOCKS_PER_MASTER;
+	irq_bit = pmirq % 8;
+	block %= PM8821_BLOCKS_PER_MASTER;
+
+	if (!master)
+		base = chip->irq_reg_base + SSBI_REG_ADDR_IRQ_MASTER0;
+	else
+		base = chip->irq_reg_base + SSBI_REG_ADDR_IRQ_MASTER1;
+
+	spin_lock_irqsave(&chip->pm_irq_lock, flags);
+
+	rc = regmap_read(chip->regmap,
+		base + PM8821_IRQ_RT_STATUS_OFFSET + block, &bits);
+	if (rc) {
+		pr_err("Failed Reading Status rc=%d\n", rc);
+		goto bail_out;
+	}
+
+	*state = !!(bits & BIT(irq_bit));
+
+bail_out:
+	spin_unlock_irqrestore(&chip->pm_irq_lock, flags);
+
+	return rc;
+}
+
+static struct irq_chip pm8821_irq_chip = {
+	.name		= "pm8821",
+	.irq_mask_ack	= pm8821_irq_mask_ack,
+	.irq_unmask	= pm8821_irq_unmask,
+	.irq_set_type	= pm8821_irq_set_type,
+	.irq_get_irqchip_state = pm8821_irq_get_irqchip_state,
+	.flags		= IRQCHIP_MASK_ON_SUSPEND | IRQCHIP_SKIP_SET_WAKE,
+};
+
+static int pm8821_irq_domain_map(struct irq_domain *d, unsigned int irq,
+				   irq_hw_number_t hwirq)
+{
+	struct pm_irq_chip *chip = d->host_data;
+
+	irq_set_chip_and_handler(irq, &pm8821_irq_chip, handle_level_irq);
+	irq_set_chip_data(irq, chip);
+	irq_set_noprobe(irq);
+
+	return 0;
+}
+
+static const struct irq_domain_ops pm8821_irq_domain_ops = {
+	.xlate = irq_domain_xlate_twocell,
+	.map = pm8821_irq_domain_map,
+};
+
 static const struct regmap_config ssbi_regmap_config = {
 	.reg_bits = 16,
 	.val_bits = 8,
@@ -308,10 +595,25 @@ static const struct regmap_config ssbi_regmap_config = {
 	.reg_write = ssbi_reg_write
 };
 
+static const struct pm8xxx_data pm8xxx_data = {
+	.num_irqs = PM8921_NR_IRQS,
+	.irq_reg_base = SSBI_REG_ADDR_IRQ_BASE,
+	.irq_domain_ops = &pm8xxx_irq_domain_ops,
+	.irq_handler = pm8xxx_irq_handler,
+};
+
+static const struct pm8xxx_data pm8821_data = {
+	.num_irqs = PM8821_NR_IRQS,
+	.irq_reg_base = SSBI_PM8821_REG_ADDR_IRQ_BASE,
+	.irq_domain_ops = &pm8821_irq_domain_ops,
+	.irq_handler = pm8821_irq_handler,
+};
+
 static const struct of_device_id pm8921_id_table[] = {
-	{ .compatible = "qcom,pm8018", },
-	{ .compatible = "qcom,pm8058", },
-	{ .compatible = "qcom,pm8921", },
+	{ .compatible = "qcom,pm8018", .data = &pm8xxx_data},
+	{ .compatible = "qcom,pm8058", .data = &pm8xxx_data},
+	{ .compatible = "qcom,pm8821", .data = &pm8821_data},
+	{ .compatible = "qcom,pm8921", .data = &pm8xxx_data},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, pm8921_id_table);
@@ -319,11 +621,17 @@ MODULE_DEVICE_TABLE(of, pm8921_id_table);
 static int pm8921_probe(struct platform_device *pdev)
 {
 	struct regmap *regmap;
+	const struct pm8xxx_data *data;
 	int irq, rc;
 	unsigned int val;
 	u32 rev;
 	struct pm_irq_chip *chip;
-	unsigned int nirqs = PM8921_NR_IRQS;
+
+	data = of_match_node(pm8921_id_table, pdev->dev.of_node)->data;
+	if (!data) {
+		dev_err(&pdev->dev, "No matching driver data found\n");
+		return -EINVAL;
+	}
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
@@ -354,25 +662,27 @@ static int pm8921_probe(struct platform_device *pdev)
 	rev |= val << BITS_PER_BYTE;
 
 	chip = devm_kzalloc(&pdev->dev, sizeof(*chip) +
-					sizeof(chip->config[0]) * nirqs,
-					GFP_KERNEL);
+			    sizeof(chip->config[0]) * data->num_irqs,
+			    GFP_KERNEL);
 	if (!chip)
 		return -ENOMEM;
 
 	platform_set_drvdata(pdev, chip);
 	chip->regmap = regmap;
-	chip->num_irqs = nirqs;
+	chip->num_irqs = data->num_irqs;
+	chip->irq_reg_base = data->irq_reg_base;
 	chip->num_blocks = DIV_ROUND_UP(chip->num_irqs, 8);
 	chip->num_masters = DIV_ROUND_UP(chip->num_blocks, 8);
 	spin_lock_init(&chip->pm_irq_lock);
 
-	chip->irqdomain = irq_domain_add_linear(pdev->dev.of_node, nirqs,
-						&pm8xxx_irq_domain_ops,
+	chip->irqdomain = irq_domain_add_linear(pdev->dev.of_node,
+						data->num_irqs,
+						data->irq_domain_ops,
 						chip);
 	if (!chip->irqdomain)
 		return -ENODEV;
 
-	irq_set_chained_handler_and_data(irq, pm8xxx_irq_handler, chip);
+	irq_set_chained_handler_and_data(irq, data->irq_handler, chip);
 	irq_set_irq_wake(irq, 1);
 
 	rc = of_platform_populate(pdev->dev.of_node, NULL, NULL, &pdev->dev);
-- 
2.10.1
