From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Mon, 14 Nov 2016 17:33:17 +0000
Subject: [PATCH 1/2] mfd: pm8921: add support to pm8821
In-Reply-To: <20161108190751.GO25787@tuxbot>
References: <1478622577-20699-1-git-send-email-srinivas.kandagatla@linaro.org>
 <20161108190751.GO25787@tuxbot>
Message-ID: <852fbb95-852e-0612-77a8-b0b072a68c51@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Bjorn for review comments.

On 08/11/16 19:07, Bjorn Andersson wrote:
> On Tue 08 Nov 08:29 PST 2016, Srinivas Kandagatla wrote:
>
>> This patch adds support to PM8821 PMIC and interrupt support.
>> PM8821 is companion device that supplements primary PMIC PM8921 IC.
>>
>
> Linus Walleij has a patch out for renaming a lot of things in this file,
> so we should probably make sure that lands and then rebase this ontop.
>
Yep, Will rebase on top of it.

>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>> Tested this patch for MPP and IRQ functionality on IFC6410 and SD600 EVAL
>> board with mpps PM8821 and PM8921.
>>
>>  .../devicetree/bindings/mfd/qcom-pm8xxx.txt        |   1 +
>>  drivers/mfd/pm8921-core.c                          | 368 +++++++++++++++++++--
>>  2 files changed, 340 insertions(+), 29 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/qcom-pm8xxx.txt b/Documentation/devicetree/bindings/mfd/qcom-pm8xxx.txt
>> index 37a088f..8f1b4ec 100644
>> --- a/Documentation/devicetree/bindings/mfd/qcom-pm8xxx.txt
>> +++ b/Documentation/devicetree/bindings/mfd/qcom-pm8xxx.txt
>> @@ -11,6 +11,7 @@ voltages and other various functionality to Qualcomm SoCs.
>>  	Definition: must be one of:
>>  		    "qcom,pm8058"
>>  		    "qcom,pm8921"
>> +		    "qcom,pm8821"
>>
>>  - #address-cells:
>>  	Usage: required
>> diff --git a/drivers/mfd/pm8921-core.c b/drivers/mfd/pm8921-core.c
>> index 0e3a2ea..28c2470 100644
>> --- a/drivers/mfd/pm8921-core.c
>> +++ b/drivers/mfd/pm8921-core.c
>> @@ -28,16 +28,26 @@
>>  #include <linux/mfd/core.h>
>>
>>  #define	SSBI_REG_ADDR_IRQ_BASE		0x1BB
>> -
>> -#define	SSBI_REG_ADDR_IRQ_ROOT		(SSBI_REG_ADDR_IRQ_BASE + 0)
>> -#define	SSBI_REG_ADDR_IRQ_M_STATUS1	(SSBI_REG_ADDR_IRQ_BASE + 1)
>> -#define	SSBI_REG_ADDR_IRQ_M_STATUS2	(SSBI_REG_ADDR_IRQ_BASE + 2)
>> -#define	SSBI_REG_ADDR_IRQ_M_STATUS3	(SSBI_REG_ADDR_IRQ_BASE + 3)
>> -#define	SSBI_REG_ADDR_IRQ_M_STATUS4	(SSBI_REG_ADDR_IRQ_BASE + 4)
>> -#define	SSBI_REG_ADDR_IRQ_BLK_SEL	(SSBI_REG_ADDR_IRQ_BASE + 5)
>> -#define	SSBI_REG_ADDR_IRQ_IT_STATUS	(SSBI_REG_ADDR_IRQ_BASE + 6)
>> -#define	SSBI_REG_ADDR_IRQ_CONFIG	(SSBI_REG_ADDR_IRQ_BASE + 7)
>> -#define	SSBI_REG_ADDR_IRQ_RT_STATUS	(SSBI_REG_ADDR_IRQ_BASE + 8)
>
> Keep these (per argumentation that follows), but try to name them
> appropriately.
>
Yes, I agree, I will address all the comments related to register 
defines in next version.
...
>
>>
>>  #define	PM_IRQF_LVL_SEL			0x01	/* level select */
>>  #define	PM_IRQF_MASK_FE			0x02	/* mask falling edge */
>> @@ -54,30 +64,41 @@
>>  #define REG_HWREV_2		0x0E8  /* PMIC4 revision 2 */
>>
>>  #define PM8921_NR_IRQS		256
>> +#define PM8821_NR_IRQS		112
>>
>>  struct pm_irq_chip {
>>  	struct regmap		*regmap;
>>  	spinlock_t		pm_irq_lock;
>>  	struct irq_domain	*irqdomain;
>> +	unsigned int		irq_reg_base;
>>  	unsigned int		num_irqs;
>>  	unsigned int		num_blocks;
>>  	unsigned int		num_masters;
>>  	u8			config[0];
>>  };
>>
>> +struct pm8xxx_data {
>> +	int num_irqs;
>> +	unsigned int		irq_reg_base;
>
> As far as I can see this is always SSBI_PM8821_REG_ADDR_IRQ_BASE in the
> 8821 functions and SSBI_REG_ADDR_IRQ_BASE in the pm8xxx functions. If
> you have disjunct code paths I think it's better to not obscure this
> with a variable.
>
> Try renaming the constants appropriately instead. This also has the
> benefit of reducing the size of the patch slightly.
>
Yep, will remove reg_base variable.

>>

...
>>
>> +static int pm8821_read_master_irq(const struct pm_irq_chip *chip,
>> +				  int m, unsigned int *master)
>> +{
>
> I think you should inline this, as you already have the calls unrolled
> in pm8821_irq_handler().

We can just call regmap_read directly from the caller function, and get 
rid of this function all together.
>
>> +	unsigned int base;
>> +
>> +	if (!m)
>> +		base = chip->irq_reg_base + SSBI_REG_ADDR_IRQ_MASTER0;
>> +	else
>> +		base = chip->irq_reg_base + SSBI_REG_ADDR_IRQ_MASTER1;
>> +
>> +	return regmap_read(chip->regmap, base, master);
>> +}
>> +
>> +static int pm8821_read_block_irq(struct pm_irq_chip *chip, int master,
>> +				 u8 block, unsigned int *bits)
>> +{
>> +	int rc;
>> +
>> +	unsigned int base;
>
> Odd empty line between rc and base. (And btw, sorting your local
> variables in descending length make things pretty).
Yep, will fix it in next version.

>
>> +
>> +	if (!master)
>> +		base = chip->irq_reg_base + SSBI_REG_ADDR_IRQ_MASTER0;
>> +	else
>> +		base = chip->irq_reg_base + SSBI_REG_ADDR_IRQ_MASTER1;
>> +
>> +	spin_lock(&chip->pm_irq_lock);
>
> The reason why this is done under a lock in the other case is because
> the status register is paged, so you shouldn't need it here.
>
Thanks for the info, will remove it.

> With this updated I think you can favorably inline this into
> pm8821_irq_block_handler().
>
>> +
>> +	rc = regmap_read(chip->regmap, base + block, bits);
>> +	if (rc)
>> +		pr_err("Failed Reading Status rc=%d\n", rc);
>> +
>> +	spin_unlock(&chip->pm_irq_lock);
>> +	return rc;
>> +}
>> +
>> +static int pm8821_irq_block_handler(struct pm_irq_chip *chip,
>> +				    int master_number, int block)
>> +{
>> +	int pmirq, irq, i, ret;
>> +	unsigned int bits;
>> +
>> +	ret = pm8821_read_block_irq(chip, master_number, block, &bits);
>> +	if (ret) {
>> +		pr_err("Failed reading %d block ret=%d", block, ret);
>> +		return ret;
>> +	}
>> +	if (!bits) {
>> +		pr_err("block bit set in master but no irqs: %d", block);
>> +		return 0;
>> +	}
>> +
>> +	/* Convert block offset to global block number */
>> +	block += (master_number * PM8821_BLOCKS_PER_MASTER) - 1;
>
> So this is block -= 1 for master 0 and block += 6 for master 1, is the
> latter correct?
>
Yes, both of them are correct.

for master 0 which has block numbers from 1-7 should translate to 0-6 in 
linear space.
for master 1 which has block numbers from 1-7 should translate to 7-13 
in linear space.

so for master0 it is -=1 and and for master1 it is +=6 seems correct.

>> +
>> +	/* Check IRQ bits */
>> +	for (i = 0; i < 8; i++) {
>> +		if (bits & BIT(i)) {
>> +			pmirq = block * 8 + i;
>> +			irq = irq_find_mapping(chip->irqdomain, pmirq);
>> +			generic_handle_irq(irq);
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int pm8821_irq_read_master(struct pm_irq_chip *chip,
>> +				int master_number, u8 master_val)
>
> This isn't so much a matter of "reading master X" as "handle master X".
>
Agreed, it would be more consistent with pm8xxx too.
> Also, you don't care about the return value, so no need to return one...
>
Yep will fix it.
>> +{
>> +	int ret = 0;
>> +	int block;
>> +
>> +	for (block = 1; block < 8; block++) {
>> +		if (master_val & BIT(block)) {
>> +			ret |= pm8821_irq_block_handler(chip,
>> +					master_number, block);
>> +		}
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static void pm8821_irq_handler(struct irq_desc *desc)
>> +{
>> +	struct pm_irq_chip *chip = irq_desc_get_handler_data(desc);
>> +	struct irq_chip *irq_chip = irq_desc_get_chip(desc);
>> +	int ret;
>> +	unsigned int master;
>> +
>> +	chained_irq_enter(irq_chip, desc);
>> +	/* check master 0 */
>> +	ret = pm8821_read_master_irq(chip, 0, &master);
>> +	if (ret) {
>> +		pr_err("Failed to re:Qad master 0 ret=%d\n", ret);
>> +		return;
>> +	}
>> +
>> +	if (master & ~PM8821_IRQ_MASTER1_SET)
>
> Rather than having a define for MASTER1_SET use BIT(0) here and write a
> comment like:
>
Yep, I will add some comments in this area.
> "bits 1 through 7 marks the first 7 blocks"
>
>> +		pm8821_irq_read_master(chip, 0, master);
>> +
>
> and then
>
> "bit 0 is set if second master contains any bits"
>
> Or just skip this optimization and check the two masters unconditionally
> in a loop.
>
>> +	/* check master 1 */
>> +	if (!(master & PM8821_IRQ_MASTER1_SET))
>> +		goto done;
>> +
>> +	ret = pm8821_read_master_irq(chip, 1, &master);
>> +	if (ret) {
>> +		pr_err("Failed to read master 1 ret=%d\n", ret);
>> +		return;
>> +	}
>> +
>> +	pm8821_irq_read_master(chip, 1, master);
>> +
>> +done:
>> +	chained_irq_exit(irq_chip, desc);
>> +}
>> +
>>  static void pm8xxx_irq_mask_ack(struct irq_data *d)
>>  {
>>  	struct pm_irq_chip *chip = irq_data_get_irq_chip_data(d);
>> @@ -254,13 +394,15 @@ static int pm8xxx_irq_get_irqchip_state(struct irq_data *d,
>>  	irq_bit = pmirq % 8;
>>
>>  	spin_lock(&chip->pm_irq_lock);
>> -	rc = regmap_write(chip->regmap, SSBI_REG_ADDR_IRQ_BLK_SEL, block);
>> +	rc = regmap_write(chip->regmap, chip->irq_reg_base +
>> +			  SSBI_REG_ADDR_IRQ_BLK_SEL, block);
>>  	if (rc) {
>>  		pr_err("Failed Selecting Block %d rc=%d\n", block, rc);
>>  		goto bail;
>>  	}
>>
>> -	rc = regmap_read(chip->regmap, SSBI_REG_ADDR_IRQ_RT_STATUS, &bits);
>> +	rc = regmap_read(chip->regmap, chip->irq_reg_base +
>> +			 SSBI_REG_ADDR_IRQ_RT_STATUS, &bits);
>>  	if (rc) {
>>  		pr_err("Failed Reading Status rc=%d\n", rc);
>>  		goto bail;
>> @@ -299,6 +441,151 @@ static const struct irq_domain_ops pm8xxx_irq_domain_ops = {
>>  	.map = pm8xxx_irq_domain_map,
>>  };
>>
>> +static void pm8821_irq_mask_ack(struct irq_data *d)
>> +{
>> +	struct pm_irq_chip *chip = irq_data_get_irq_chip_data(d);
>> +	unsigned int base, pmirq = irqd_to_hwirq(d);
>> +	u8 block, master;
>> +	int irq_bit, rc;
>> +
>> +	block = pmirq / 8;
>> +	master = block / PM8821_BLOCKS_PER_MASTER;
>> +	irq_bit = pmirq % 8;
>> +	block %= PM8821_BLOCKS_PER_MASTER;
>
> You can deobfuscate this somewhat by instead of testing for !master
> below you just do:
>
> if (block < PM8821_BLOCKS_PER_MASTER) {
> 	base =
> } else {
> 	base =
> 	block -= PM8821_BLOCKS_PER_MASTER;
> }
>
Done some cleanup in register defines which avoids this totally.
>> +
>> +	if (!master)
>> +		base = chip->irq_reg_base + SSBI_REG_ADDR_IRQ_MASTER0;
>> +	else
>> +		base = chip->irq_reg_base + SSBI_REG_ADDR_IRQ_MASTER1;
>> +
>> +	spin_lock(&chip->pm_irq_lock);
>
> The irqchip code grabs a lock on the irq_desc, so this can't race with
> unmask - and the regmap_update_bits() is internally protecting the
> read/write cycle.
>
> So you shouldn't need to lock around this section.
>
Yep.
>> +	rc = regmap_update_bits(chip->regmap,
>> +				base + PM8821_IRQ_MASK_REG_OFFSET + block,
>> +				BIT(irq_bit), BIT(irq_bit));
>> +
>> +	if (rc) {
>> +		pr_err("Failed to read/write mask IRQ:%d rc=%d\n", pmirq, rc);
>> +		goto fail;
>> +	}
>> +
>> +	rc = regmap_update_bits(chip->regmap,
>> +				base + PM8821_IRQ_CLEAR_OFFSET + block,
>> +				BIT(irq_bit), BIT(irq_bit));
>> +
>> +	if (rc) {
>> +		pr_err("Failed to read/write IT_CLEAR IRQ:%d rc=%d\n",
>> +								pmirq, rc);
>> +	}
>> +
>> +fail:
>> +	spin_unlock(&chip->pm_irq_lock);
>> +}
>> +
>> +static void pm8821_irq_unmask(struct irq_data *d)
>> +{
>> +	struct pm_irq_chip *chip = irq_data_get_irq_chip_data(d);
>> +	unsigned int base, pmirq = irqd_to_hwirq(d);
>> +	int irq_bit, rc;
>> +	u8 block, master;
>> +
>> +	block = pmirq / 8;
>> +	master = block / PM8821_BLOCKS_PER_MASTER;
>> +	irq_bit = pmirq % 8;
>> +	block %= PM8821_BLOCKS_PER_MASTER;
>
> As mask().
>
>> +
>> +	if (!master)
>> +		base = chip->irq_reg_base + SSBI_REG_ADDR_IRQ_MASTER0;
>> +	else
>> +		base = chip->irq_reg_base + SSBI_REG_ADDR_IRQ_MASTER1;
>> +
>> +	spin_lock(&chip->pm_irq_lock);
>
> As mask().
>
>> +
>> +	rc = regmap_update_bits(chip->regmap,
>> +				base + PM8821_IRQ_MASK_REG_OFFSET + block,
>> +				BIT(irq_bit), ~BIT(irq_bit));
>> +
>> +	if (rc)
>> +		pr_err("Failed to read/write unmask IRQ:%d rc=%d\n", pmirq, rc);
>> +
>> +	spin_unlock(&chip->pm_irq_lock);
>> +}
>> +
>> +static int pm8821_irq_set_type(struct irq_data *d, unsigned int flow_type)
>> +{
>> +
>> +	/*
>> +	 * PM8821 IRQ controller does not have explicit software support for
>> +	 * IRQ flow type.
>> +	 */
>
> Is returning "success" here the right thing to do? Shouldn't we just
> omit the function? Or did you perhaps hit some clients that wouldn't
> deal with that?
>
Will remove this totally.
>> +	return 0;
>> +}
>> +
>> +static int pm8821_irq_get_irqchip_state(struct irq_data *d,
>> +					enum irqchip_irq_state which,
>> +					bool *state)
>> +{
>> +	struct pm_irq_chip *chip = irq_data_get_irq_chip_data(d);
>> +	int pmirq, rc;
>> +	u8 block, irq_bit, master;
>> +	unsigned int bits;
>> +	unsigned int base;
>> +	unsigned long flags;
>> +
>> +	pmirq = irqd_to_hwirq(d);
>> +
>> +	block = pmirq / 8;
>> +	master = block / PM8821_BLOCKS_PER_MASTER;
>> +	irq_bit = pmirq % 8;
>> +	block %= PM8821_BLOCKS_PER_MASTER;
>> +
>
> Simplify as in mask().
taken care by new register defines.
>
>> +	if (!master)
>> +		base = chip->irq_reg_base + SSBI_REG_ADDR_IRQ_MASTER0;
>> +	else
>> +		base = chip->irq_reg_base + SSBI_REG_ADDR_IRQ_MASTER1;
>> +
>> +	spin_lock_irqsave(&chip->pm_irq_lock, flags);
>
> No need to lock here as we're just reading a single register.
>
yep done.

>> +
>> +	rc = regmap_read(chip->regmap,
>> +		base + PM8821_IRQ_RT_STATUS_OFFSET + block, &bits);
>> +	if (rc) {
>> +		pr_err("Failed Reading Status rc=%d\n", rc);
>> +		goto bail_out;
>> +	}
>> +
>> +	*state = !!(bits & BIT(irq_bit));
>> +
>> +bail_out:
>> +	spin_unlock_irqrestore(&chip->pm_irq_lock, flags);
>> +
>> +	return rc;
>> +}
>> +
>> +static struct irq_chip pm8821_irq_chip = {
>> +	.name		= "pm8821",
>> +	.irq_mask_ack	= pm8821_irq_mask_ack,
>> +	.irq_unmask	= pm8821_irq_unmask,
>> +	.irq_set_type	= pm8821_irq_set_type,
>> +	.irq_get_irqchip_state = pm8821_irq_get_irqchip_state,
>> +	.flags		= IRQCHIP_MASK_ON_SUSPEND | IRQCHIP_SKIP_SET_WAKE,
>> +};
>> +
>
> Regards,
> Bjorn
>
