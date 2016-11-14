From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Mon, 14 Nov 2016 10:56:21 -0800
Subject: [PATCH v2 1/2] mfd: pm8xxx: add support to pm8821
In-Reply-To: <1479145933-9849-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1479145933-9849-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <20161114185621.GC27931@tuxbot>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 14 Nov 09:52 PST 2016, Srinivas Kandagatla wrote:

> This patch adds support to PM8821 PMIC and interrupt support.
> PM8821 is companion device that supplements primary PMIC PM8921 IC.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
> Changes from v1:
> 	- Removed unnessary locking spotted by Bjorn
> 	- updated register naming to reflect PM8821
> 	- lot of cleanups suggested by Bjorn
> 	- rebased on top of Linus Walleij's pm8xxx namespace
> 	 cleanup patch. 

Looks good, just some minor style nits below.

> 
>  .../devicetree/bindings/mfd/qcom-pm8xxx.txt        |   1 +
>  drivers/mfd/qcom-pm8xxx.c                          | 247 ++++++++++++++++++++-
>  2 files changed, 238 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/qcom-pm8xxx.txt b/Documentation/devicetree/bindings/mfd/qcom-pm8xxx.txt
> index 37a088f..8f1b4ec 100644
> --- a/Documentation/devicetree/bindings/mfd/qcom-pm8xxx.txt
> +++ b/Documentation/devicetree/bindings/mfd/qcom-pm8xxx.txt
> @@ -11,6 +11,7 @@ voltages and other various functionality to Qualcomm SoCs.
>  	Definition: must be one of:
>  		    "qcom,pm8058"
>  		    "qcom,pm8921"
> +		    "qcom,pm8821"

8 < 9, so move it one step up please.

>  
>  - #address-cells:
>  	Usage: required
> diff --git a/drivers/mfd/qcom-pm8xxx.c b/drivers/mfd/qcom-pm8xxx.c
[..]
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

I like how this cleaned up the rest of the implementation.

[..]

> +static void pm8821_irq_block_handler(struct pm_irq_chip *chip,
> +				     int master, int block)
> +{
> +	int pmirq, irq, i, ret;
> +	unsigned int bits;
> +
> +	ret = regmap_read(chip->regmap,
> +			  PM8821_SSBI_ADDR_IRQ_ROOT(master, block), &bits);
> +	if (ret) {
> +		pr_err("Failed reading %d block ret=%d", block, ret);

"Reading block %d failed ret=%d"

> +		return;
> +	}
> +	if (!bits) {
> +		pr_err("block bit set in master but no irqs: %d", block);

This seems more like a debug thing, either showing missbehaving hardware
or something odd in the driver. I think you should drop the print or
make it pr_debug().

> +		return;
> +	}

I would prefer that you just drop the entire if statement, it's just an
corner case optimization with a info print.

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
> +

Empty line

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
> +

Empty line

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
> +		pr_err("Failed to re:Qad master 0 ret=%d\n", ret);
                                      ^
				      |
			  I see you're using vim :)

> +		return;
> +	}
> +
> +	 /* bits 1 through 7 marks the first 7 blocks in master 0*/

Indentation

> +	if (master & GENMASK(7, 1))
> +		pm8821_irq_master_handler(chip, 0, master);
> +
> +	 /* bit 0 marks if master 1 contains any bits */

Dito

> +	if (!(master & BIT(0)))
> +		goto done;
> +
> +	ret = regmap_read(chip->regmap,
> +			  PM8821_SSBI_REG_ADDR_IRQ_MASTER1, &master);
> +	if (ret) {
> +		pr_err("Failed to read master 1 ret=%d\n", ret);
> +		return;

"goto done;" so that we pass chained_irq_exit()

> +	}
> +
> +	pm8821_irq_master_handler(chip, 1, master);
> +
> +done:
> +	chained_irq_exit(irq_chip, desc);
> +}
> +

[..]

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
> +

Empty line

> +	if (rc) {
> +		pr_err("Failed to read/write mask IRQ:%d rc=%d\n", pmirq, rc);

"Failed to mask IRQ %d rc=%d\n"

> +		return;
> +	}
> +
> +	rc = regmap_update_bits(chip->regmap,
> +				PM8821_SSBI_ADDR_IRQ_CLEAR(master, block),
> +				BIT(irq_bit), BIT(irq_bit));
> +

Empty line

> +	if (rc) {
> +		pr_err("Failed to read/write IT_CLEAR IRQ:%d rc=%d\n",
> +								pmirq, rc);

"Failed to clear IRQ %d rc=%d\n"

> +	}
> +

Empty line

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
> +

Empty line

> +	if (rc)
> +		pr_err("Failed to read/write unmask IRQ:%d rc=%d\n", pmirq, rc);

"Failed to unmask IRQ %d rc=%d\n"

> +

Empty line

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
> +		pr_err("Failed Reading Status rc=%d\n", rc);

Odd capitalization, I suggest that you match it to the other functions
by:

"Reading status of IRQ %d failed rc=%d\n" 

> +		return rc;
> +	}
> +
> +	*state = !!(bits & BIT(irq_bit));
> +
> +	return rc;
> +}
> +

[..]

>  
>  static int pm8xxx_probe(struct platform_device *pdev)
>  {
> +	const struct of_device_id *match;
> +	const struct pm_irq_data *data;
>  	struct regmap *regmap;
>  	int irq, rc;
>  	unsigned int val;
>  	u32 rev;
>  	struct pm_irq_chip *chip;
> -	unsigned int nirqs = PM8XXX_NR_IRQS;
> +
> +	match = of_match_node(pm8xxx_id_table, pdev->dev.of_node);
> +	if (!match) {
> +		dev_err(&pdev->dev, "No matching driver data found\n");
> +		return -EINVAL;
> +	}
> +
> +	data = match->data;

data = of_device_get_match_data(&pdev->dev); (from of_device.h)

Regards,
Bjorn
