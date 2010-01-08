From: sameo@linux.intel.com (Samuel Ortiz)
Date: Fri, 8 Jan 2010 01:01:27 +0100
Subject: [PATCH 1/4] mfd: enable max8925
In-Reply-To: <771cded00912210445v67175632i876b7909de8afae3@mail.gmail.com>
References: <771cded00912210445v67175632i876b7909de8afae3@mail.gmail.com>
Message-ID: <20100108000126.GE11239@sortiz.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Haojian,

On Mon, Dec 21, 2009 at 07:45:27AM -0500, Haojian Zhuang wrote:
> From 567add422a0d2214e037c3ed1b424b21776dfe34 Mon Sep 17 00:00:00 2001
> From: Haojian Zhuang <haojian.zhuang@marvell.com>
> Date: Thu, 17 Dec 2009 12:30:16 -0500
> Subject: [PATCH] mfd: enable max8925
> 
> Max8925 is a Power Management IC from Maxim Semiconductor.
> 
> Do basic support on accessing MAX8925.
The patch looks quite good to me. I have some minor comments/suggestions
though:

> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index f3b277b..2809869 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -44,6 +44,8 @@ endif
>  obj-$(CONFIG_UCB1400_CORE)	+= ucb1400_core.o
> 
>  obj-$(CONFIG_PMIC_DA903X)	+= da903x.o
> +max8925-objs			:= max8925-core.o max8925-i2c.o
> +obj-$(CONFIG_MFD_MAX8925)	+= max8925.o
No big deal, but it could just be:
obj-$(CONFIG_MFD_MAX8925)    += max8925-core.o max8925-i2c.o

> +static int __get_irq_offset(struct max8925_chip *chip, int irq, int mode,
> +			    int *offset, int *bit)
> +{
> +	if (!offset || !bit)
> +		return -EINVAL;
> +
> +	switch (chip->chip_id) {
> +	case MAX8925_GPM:
> +		*bit = irq % 8;
> +		if (irq < 16) {
> +			*offset = (mode) ? MAX8925_CHG_IRQ1_MASK
> +				: MAX8925_CHG_IRQ1;
> +			if (irq >= 8)
> +				(*offset)++;
> +		} else {
> +			*offset = (mode) ? MAX8925_ON_OFF_IRQ1_MASK
> +				: MAX8925_ON_OFF_IRQ1;
> +			if (irq >= 24)
> +				(*offset)++;
> +		}
> +		break;
To make the code more understandable, could we have some definitions for those
8, 16 and 24 ?

> +static irqreturn_t max8925_irq_thread(int irq, void *data)
> +{
> +	DECLARE_BITMAP(irq_status, MAX8925_NUM_IRQ);
> +	struct max8925_chip *chip = data;
> +	unsigned char status_buf[INT_STATUS_NUM << 1];
> +	int i, ret;
> +
> +	irq_status[0] = 0;
> +
> +	/* all these interrupt status registers are read-only */
> +	switch (chip->chip_id) {
> +	case MAX8925_GPM:
> +		ret = max8925_bulk_read(chip->i2c, MAX8925_CHG_IRQ1,
> +					4, status_buf);
> +		if (ret < 0)
> +			goto out;
> +		ret = max8925_bulk_read(chip->i2c, MAX8925_ON_OFF_IRQ1,
> +					4, &status_buf[4]);
> +		if (ret < 0)
> +			goto out;
> +		/* clear masked interrupt status */
> +		status_buf[0] &= (~status_buf[2] & CHG_IRQ1_MASK);
> +		irq_status[0] |= status_buf[0];
> +		status_buf[1] &= (~status_buf[3] & CHG_IRQ2_MASK);
> +		irq_status[0] |= (status_buf[1] << 8);
> +		status_buf[4] &= (~status_buf[6] & ON_OFF_IRQ1_MASK);
> +		irq_status[0] |= (status_buf[4] << 16);
> +		status_buf[5] &= (~status_buf[7] & ON_OFF_IRQ2_MASK);
> +		irq_status[0] |= (status_buf[5] << 24);
> +		break;
> +	case MAX8925_ADC:
> +		ret = max8925_bulk_read(chip->i2c, MAX8925_TSC_IRQ,
> +					2, status_buf);
> +		if (ret < 0)
> +			goto out;
> +		/* clear masked interrupt status */
> +		status_buf[0] &= (~status_buf[1] & TSC_IRQ_MASK);
> +		irq_status[0] |= status_buf[0];
> +		break;
> +	default:
> +		goto out;
> +	}
> +
> +	while (!bitmap_empty(irq_status, MAX8925_NUM_IRQ)) {
> +		i = find_first_bit(irq_status, MAX8925_NUM_IRQ);
> +		clear_bit(i, irq_status);
You could use for_each_bit() here.

> +static int __devinit device_gpm_init(struct max8925_chip *chip,
> +				      struct i2c_client *i2c,
> +				      struct max8925_platform_data *pdata)
> +{
> +	int ret;
> +
> +	/* mask all IRQs */
> +	ret = max8925_set_bits(i2c, MAX8925_CHG_IRQ1_MASK, 0x7, 0x7);
> +	if (ret < 0)
> +		goto out;
> +	ret = max8925_set_bits(i2c, MAX8925_CHG_IRQ2_MASK, 0xff, 0xff);
> +	if (ret < 0)
> +		goto out;
> +	ret = max8925_set_bits(i2c, MAX8925_ON_OFF_IRQ1_MASK, 0xff, 0xff);
> +	if (ret < 0)
> +		goto out;
> +	ret = max8925_set_bits(i2c, MAX8925_ON_OFF_IRQ2_MASK, 0x3, 0x3);
> +	if (ret < 0)
> +		goto out;
> +
> +	memcpy(chip->name, "GPM", 3);
Why not chip->name being a const char* and then chip->name = "GPM"; here ?
Either way, you really want it to be null terminated, which is not the case
here.


> +static int __devinit device_adc_init(struct max8925_chip *chip,
> +				     struct i2c_client *i2c,
> +				     struct max8925_platform_data *pdata)
> +{
> +	int ret;
> +
> +	/* mask all IRQs */
> +	ret = max8925_set_bits(i2c, MAX8925_TSC_IRQ_MASK, 3, 3);
> +
> +	memcpy(chip->name, "ADC", 3);
Same here.

The rest of the patch looks fine, as does the whole patchset.

Thanks for your work.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
