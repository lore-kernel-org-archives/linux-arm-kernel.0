From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 21 Nov 2016 13:48:09 +0000
Subject: [PATCH v3 1/2] mfd: pm8xxx: add support to pm8821
In-Reply-To: <1479211312-1431-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1479211312-1431-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <20161121134809.GH3917@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 15 Nov 2016, Srinivas Kandagatla wrote:

> This patch adds support to PM8821 PMIC and interrupt support.
> PM8821 is companion device that supplements primary PMIC PM8921 IC.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
> Changes since v2:
> 	- removed few empty lines spotted by Bjorn
> 	- rephrased some debug prints suggested by Bjorn
> 	
>  .../devicetree/bindings/mfd/qcom-pm8xxx.txt        |   1 +
>  drivers/mfd/qcom-pm8xxx.c                          | 231 ++++++++++++++++++++-
>  2 files changed, 222 insertions(+), 10 deletions(-)

Applied, thanks.

> diff --git a/Documentation/devicetree/bindings/mfd/qcom-pm8xxx.txt b/Documentation/devicetree/bindings/mfd/qcom-pm8xxx.txt
> index 37a088f..9e5eba4 100644
> --- a/Documentation/devicetree/bindings/mfd/qcom-pm8xxx.txt
> +++ b/Documentation/devicetree/bindings/mfd/qcom-pm8xxx.txt
> @@ -10,6 +10,7 @@ voltages and other various functionality to Qualcomm SoCs.
>  	Value type: <string>
>  	Definition: must be one of:
>  		    "qcom,pm8058"
> +		    "qcom,pm8821"
>  		    "qcom,pm8921"
>  
>  - #address-cells:
> diff --git a/drivers/mfd/qcom-pm8xxx.c b/drivers/mfd/qcom-pm8xxx.c
> index 7f9620e..f08758f 100644
> --- a/drivers/mfd/qcom-pm8xxx.c
> +++ b/drivers/mfd/qcom-pm8xxx.c
> @@ -39,6 +39,20 @@
>  #define	SSBI_REG_ADDR_IRQ_CONFIG	(SSBI_REG_ADDR_IRQ_BASE + 7)
>  #define	SSBI_REG_ADDR_IRQ_RT_STATUS	(SSBI_REG_ADDR_IRQ_BASE + 8)
>  
> +#define	PM8821_SSBI_REG_ADDR_IRQ_BASE	0x100
> +#define	PM8821_SSBI_REG_ADDR_IRQ_MASTER0 (PM8821_SSBI_REG_ADDR_IRQ_BASE + 0x30)
> +#define	PM8821_SSBI_REG_ADDR_IRQ_MASTER1 (PM8821_SSBI_REG_ADDR_IRQ_BASE + 0xb0)
> +#define	PM8821_SSBI_REG(m, b, offset) \
> +			((m == 0) ? \
> +			(PM8821_SSBI_REG_ADDR_IRQ_MASTER0 + b + offset) : \
> +			(PM8821_SSBI_REG_ADDR_IRQ_MASTER1 + b + offset))
> +#define	PM8821_SSBI_ADDR_IRQ_ROOT(m, b)		PM8821_SSBI_REG(m, b, 0x0)
> +#define	PM8821_SSBI_ADDR_IRQ_CLEAR(m, b)	PM8821_SSBI_REG(m, b, 0x01)
> +#define	PM8821_SSBI_ADDR_IRQ_MASK(m, b)		PM8821_SSBI_REG(m, b, 0x08)
> +#define	PM8821_SSBI_ADDR_IRQ_RT_STATUS(m, b)	PM8821_SSBI_REG(m, b, 0x0f)
> +
> +#define	PM8821_BLOCKS_PER_MASTER	7
> +
>  #define	PM_IRQF_LVL_SEL			0x01	/* level select */
>  #define	PM_IRQF_MASK_FE			0x02	/* mask falling edge */
>  #define	PM_IRQF_MASK_RE			0x04	/* mask rising edge */
> @@ -54,6 +68,7 @@
>  #define REG_HWREV_2		0x0E8  /* PMIC4 revision 2 */
>  
>  #define PM8XXX_NR_IRQS		256
> +#define PM8821_NR_IRQS		112
>  
>  struct pm_irq_chip {
>  	struct regmap		*regmap;
> @@ -65,6 +80,12 @@ struct pm_irq_chip {
>  	u8			config[0];
>  };
>  
> +struct pm_irq_data {
> +	int num_irqs;
> +	const struct irq_domain_ops  *irq_domain_ops;
> +	void (*irq_handler)(struct irq_desc *desc);
> +};
> +
>  static int pm8xxx_read_block_irq(struct pm_irq_chip *chip, unsigned int bp,
>  				 unsigned int *ip)
>  {
> @@ -182,6 +203,78 @@ static void pm8xxx_irq_handler(struct irq_desc *desc)
>  	chained_irq_exit(irq_chip, desc);
>  }
>  
> +static void pm8821_irq_block_handler(struct pm_irq_chip *chip,
> +				     int master, int block)
> +{
> +	int pmirq, irq, i, ret;
> +	unsigned int bits;
> +
> +	ret = regmap_read(chip->regmap,
> +			  PM8821_SSBI_ADDR_IRQ_ROOT(master, block), &bits);
> +	if (ret) {
> +		pr_err("Reading block %d failed ret=%d", block, ret);
> +		return;
> +	}
> +
> +	/* Convert block offset to global block number */
> +	block += (master * PM8821_BLOCKS_PER_MASTER) - 1;
> +
> +	/* Check IRQ bits */
> +	for (i = 0; i < 8; i++) {
> +		if (bits & BIT(i)) {
> +			pmirq = block * 8 + i;
> +			irq = irq_find_mapping(chip->irqdomain, pmirq);
> +			generic_handle_irq(irq);
> +		}
> +	}
> +}
> +
> +static inline void pm8821_irq_master_handler(struct pm_irq_chip *chip,
> +					     int master, u8 master_val)
> +{
> +	int block;
> +
> +	for (block = 1; block < 8; block++)
> +		if (master_val & BIT(block))
> +			pm8821_irq_block_handler(chip, master, block);
> +}
> +
> +static void pm8821_irq_handler(struct irq_desc *desc)
> +{
> +	struct pm_irq_chip *chip = irq_desc_get_handler_data(desc);
> +	struct irq_chip *irq_chip = irq_desc_get_chip(desc);
> +	unsigned int master;
> +	int ret;
> +
> +	chained_irq_enter(irq_chip, desc);
> +	ret = regmap_read(chip->regmap,
> +			  PM8821_SSBI_REG_ADDR_IRQ_MASTER0, &master);
> +	if (ret) {
> +		pr_err("Failed to read master 0 ret=%d\n", ret);
> +		goto done;
> +	}
> +
> +	/* bits 1 through 7 marks the first 7 blocks in master 0 */
> +	if (master & GENMASK(7, 1))
> +		pm8821_irq_master_handler(chip, 0, master);
> +
> +	/* bit 0 marks if master 1 contains any bits */
> +	if (!(master & BIT(0)))
> +		goto done;
> +
> +	ret = regmap_read(chip->regmap,
> +			  PM8821_SSBI_REG_ADDR_IRQ_MASTER1, &master);
> +	if (ret) {
> +		pr_err("Failed to read master 1 ret=%d\n", ret);
> +		goto done;
> +	}
> +
> +	pm8821_irq_master_handler(chip, 1, master);
> +
> +done:
> +	chained_irq_exit(irq_chip, desc);
> +}
> +
>  static void pm8xxx_irq_mask_ack(struct irq_data *d)
>  {
>  	struct pm_irq_chip *chip = irq_data_get_irq_chip_data(d);
> @@ -299,6 +392,104 @@ static const struct irq_domain_ops pm8xxx_irq_domain_ops = {
>  	.map = pm8xxx_irq_domain_map,
>  };
>  
> +static void pm8821_irq_mask_ack(struct irq_data *d)
> +{
> +	struct pm_irq_chip *chip = irq_data_get_irq_chip_data(d);
> +	unsigned int pmirq = irqd_to_hwirq(d);
> +	u8 block, master;
> +	int irq_bit, rc;
> +
> +	block = pmirq / 8;
> +	master = block / PM8821_BLOCKS_PER_MASTER;
> +	irq_bit = pmirq % 8;
> +	block %= PM8821_BLOCKS_PER_MASTER;
> +
> +	rc = regmap_update_bits(chip->regmap,
> +				PM8821_SSBI_ADDR_IRQ_MASK(master, block),
> +				BIT(irq_bit), BIT(irq_bit));
> +	if (rc) {
> +		pr_err("Failed to mask IRQ:%d rc=%d\n", pmirq, rc);
> +		return;
> +	}
> +
> +	rc = regmap_update_bits(chip->regmap,
> +				PM8821_SSBI_ADDR_IRQ_CLEAR(master, block),
> +				BIT(irq_bit), BIT(irq_bit));
> +	if (rc)
> +		pr_err("Failed to CLEAR IRQ:%d rc=%d\n", pmirq, rc);
> +}
> +
> +static void pm8821_irq_unmask(struct irq_data *d)
> +{
> +	struct pm_irq_chip *chip = irq_data_get_irq_chip_data(d);
> +	unsigned int pmirq = irqd_to_hwirq(d);
> +	int irq_bit, rc;
> +	u8 block, master;
> +
> +	block = pmirq / 8;
> +	master = block / PM8821_BLOCKS_PER_MASTER;
> +	irq_bit = pmirq % 8;
> +	block %= PM8821_BLOCKS_PER_MASTER;
> +
> +	rc = regmap_update_bits(chip->regmap,
> +				PM8821_SSBI_ADDR_IRQ_MASK(master, block),
> +				BIT(irq_bit), ~BIT(irq_bit));
> +	if (rc)
> +		pr_err("Failed to read/write unmask IRQ:%d rc=%d\n", pmirq, rc);
> +
> +}
> +
> +static int pm8821_irq_get_irqchip_state(struct irq_data *d,
> +					enum irqchip_irq_state which,
> +					bool *state)
> +{
> +	struct pm_irq_chip *chip = irq_data_get_irq_chip_data(d);
> +	int rc, pmirq = irqd_to_hwirq(d);
> +	u8 block, irq_bit, master;
> +	unsigned int bits;
> +
> +	block = pmirq / 8;
> +	master = block / PM8821_BLOCKS_PER_MASTER;
> +	irq_bit = pmirq % 8;
> +	block %= PM8821_BLOCKS_PER_MASTER;
> +
> +	rc = regmap_read(chip->regmap,
> +		PM8821_SSBI_ADDR_IRQ_RT_STATUS(master, block), &bits);
> +	if (rc) {
> +		pr_err("Reading Status of IRQ %d failed rc=%d\n", pmirq, rc);
> +		return rc;
> +	}
> +
> +	*state = !!(bits & BIT(irq_bit));
> +
> +	return rc;
> +}
> +
> +static struct irq_chip pm8821_irq_chip = {
> +	.name		= "pm8821",
> +	.irq_mask_ack	= pm8821_irq_mask_ack,
> +	.irq_unmask	= pm8821_irq_unmask,
> +	.irq_get_irqchip_state = pm8821_irq_get_irqchip_state,
> +	.flags		= IRQCHIP_MASK_ON_SUSPEND | IRQCHIP_SKIP_SET_WAKE,
> +};
> +
> +static int pm8821_irq_domain_map(struct irq_domain *d, unsigned int irq,
> +				   irq_hw_number_t hwirq)
> +{
> +	struct pm_irq_chip *chip = d->host_data;
> +
> +	irq_set_chip_and_handler(irq, &pm8821_irq_chip, handle_level_irq);
> +	irq_set_chip_data(irq, chip);
> +	irq_set_noprobe(irq);
> +
> +	return 0;
> +}
> +
> +static const struct irq_domain_ops pm8821_irq_domain_ops = {
> +	.xlate = irq_domain_xlate_twocell,
> +	.map = pm8821_irq_domain_map,
> +};
> +
>  static const struct regmap_config ssbi_regmap_config = {
>  	.reg_bits = 16,
>  	.val_bits = 8,
> @@ -308,22 +499,41 @@ static const struct regmap_config ssbi_regmap_config = {
>  	.reg_write = ssbi_reg_write
>  };
>  
> +static const struct pm_irq_data pm8xxx_data = {
> +	.num_irqs = PM8XXX_NR_IRQS,
> +	.irq_domain_ops = &pm8xxx_irq_domain_ops,
> +	.irq_handler = pm8xxx_irq_handler,
> +};
> +
> +static const struct pm_irq_data pm8821_data = {
> +	.num_irqs = PM8821_NR_IRQS,
> +	.irq_domain_ops = &pm8821_irq_domain_ops,
> +	.irq_handler = pm8821_irq_handler,
> +};
> +
>  static const struct of_device_id pm8xxx_id_table[] = {
> -	{ .compatible = "qcom,pm8018", },
> -	{ .compatible = "qcom,pm8058", },
> -	{ .compatible = "qcom,pm8921", },
> +	{ .compatible = "qcom,pm8018", .data = &pm8xxx_data},
> +	{ .compatible = "qcom,pm8058", .data = &pm8xxx_data},
> +	{ .compatible = "qcom,pm8821", .data = &pm8821_data},
> +	{ .compatible = "qcom,pm8921", .data = &pm8xxx_data},
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, pm8xxx_id_table);
>  
>  static int pm8xxx_probe(struct platform_device *pdev)
>  {
> +	const struct pm_irq_data *data;
>  	struct regmap *regmap;
>  	int irq, rc;
>  	unsigned int val;
>  	u32 rev;
>  	struct pm_irq_chip *chip;
> -	unsigned int nirqs = PM8XXX_NR_IRQS;
> +
> +	data = of_device_get_match_data(&pdev->dev);
> +	if (!data) {
> +		dev_err(&pdev->dev, "No matching driver data found\n");
> +		return -EINVAL;
> +	}
>  
>  	irq = platform_get_irq(pdev, 0);
>  	if (irq < 0)
> @@ -354,25 +564,26 @@ static int pm8xxx_probe(struct platform_device *pdev)
>  	rev |= val << BITS_PER_BYTE;
>  
>  	chip = devm_kzalloc(&pdev->dev, sizeof(*chip) +
> -					sizeof(chip->config[0]) * nirqs,
> -					GFP_KERNEL);
> +			    sizeof(chip->config[0]) * data->num_irqs,
> +			    GFP_KERNEL);
>  	if (!chip)
>  		return -ENOMEM;
>  
>  	platform_set_drvdata(pdev, chip);
>  	chip->regmap = regmap;
> -	chip->num_irqs = nirqs;
> +	chip->num_irqs = data->num_irqs;
>  	chip->num_blocks = DIV_ROUND_UP(chip->num_irqs, 8);
>  	chip->num_masters = DIV_ROUND_UP(chip->num_blocks, 8);
>  	spin_lock_init(&chip->pm_irq_lock);
>  
> -	chip->irqdomain = irq_domain_add_linear(pdev->dev.of_node, nirqs,
> -						&pm8xxx_irq_domain_ops,
> +	chip->irqdomain = irq_domain_add_linear(pdev->dev.of_node,
> +						data->num_irqs,
> +						data->irq_domain_ops,
>  						chip);
>  	if (!chip->irqdomain)
>  		return -ENODEV;
>  
> -	irq_set_chained_handler_and_data(irq, pm8xxx_irq_handler, chip);
> +	irq_set_chained_handler_and_data(irq, data->irq_handler, chip);
>  	irq_set_irq_wake(irq, 1);
>  
>  	rc = of_platform_populate(pdev->dev.of_node, NULL, NULL, &pdev->dev);

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
