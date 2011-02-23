From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 23 Feb 2011 19:15:07 +0900
Subject: [PATCH 2/5] ARM: Samsung: cleanup S5P gpio interrupt code
In-Reply-To: <1297927527-1338-3-git-send-email-m.szyprowski@samsung.com>
References: <1297927527-1338-1-git-send-email-m.szyprowski@samsung.com>
	<1297927527-1338-3-git-send-email-m.szyprowski@samsung.com>
Message-ID: <01f201cbd342$8e6001f0$ab2005d0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marek Szyprowski wrote:
> 
> This patch performs a global cleanup in s5p gpio interrupt support code.
> The code is prepared for upcoming support for gpio interrupts on S5PC210
> platform, which has 2 gpio banks (regions) instead of one (like on
> S5PC110 and S5PC100).
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/plat-s5p/irq-gpioint.c |  106
+++++++++++++++++--------------------
> --
>  1 files changed, 46 insertions(+), 60 deletions(-)
> 
> diff --git a/arch/arm/plat-s5p/irq-gpioint.c b/arch/arm/plat-s5p/irq-
> gpioint.c
> index 3b6bf89..af10328 100644
> --- a/arch/arm/plat-s5p/irq-gpioint.c
> +++ b/arch/arm/plat-s5p/irq-gpioint.c
> @@ -22,77 +22,64 @@
>  #include <plat/gpio-core.h>
>  #include <plat/gpio-cfg.h>
> 
> -#define S5P_GPIOREG(x)			(S5P_VA_GPIO + (x))
> +#define GPIO_BASE(chip)		(((unsigned long)(chip)->base) &
> ~(SZ_4K - 1))
> 

Need SZ_4K here instead of 0xFFFFF000?

> -#define GPIOINT_CON_OFFSET		0x700
> -#define GPIOINT_MASK_OFFSET		0x900
> -#define GPIOINT_PEND_OFFSET		0xA00
> +#define CON_OFFSET		0x700
> +#define MASK_OFFSET		0x900
> +#define PEND_OFFSET		0xA00

I don't know why need to change above definitions...

> +#define REG_OFFSET(x)		((x) << 2)
> 
Actually, this is used instead of "group << 2" in this file.
So how about "GPIOINT_REG_OFFSET(x)" like others?

>  static struct s3c_gpio_chip *irq_chips[S5P_GPIOINT_GROUP_MAXNR];
> 
> -static int s5p_gpioint_get_group(struct irq_data *data)
> -{
> -	struct gpio_chip *chip = irq_data_get_irq_data(data);
> -	struct s3c_gpio_chip *s3c_chip = container_of(chip,
> -			struct s3c_gpio_chip, chip);
> -	int group;
> -
> -	for (group = 0; group < S5P_GPIOINT_GROUP_MAXNR; group++)
> -		if (s3c_chip == irq_chips[group])
> -			break;
> -
> -	return group;
> -}
> -
>  static int s5p_gpioint_get_offset(struct irq_data *data)
>  {
> -	struct gpio_chip *chip = irq_data_get_irq_data(data);
> -	struct s3c_gpio_chip *s3c_chip = container_of(chip,
> -			struct s3c_gpio_chip, chip);
> -
> -	return data->irq - s3c_chip->irq_base;
> +	struct s3c_gpio_chip *chip = irq_data_get_irq_data(data);
> +	return data->irq - chip->irq_base;
>  }
> 
>  static void s5p_gpioint_ack(struct irq_data *data)
>  {
> +	struct s3c_gpio_chip *chip = irq_data_get_irq_data(data);
>  	int group, offset, pend_offset;
>  	unsigned int value;
> 
> -	group = s5p_gpioint_get_group(data);
> +	group = chip->group;
>  	offset = s5p_gpioint_get_offset(data);
> -	pend_offset = group << 2;
> +	pend_offset = REG_OFFSET(group);
> 
> -	value = __raw_readl(S5P_GPIOREG(GPIOINT_PEND_OFFSET) + pend_offset);
> -	value |= 1 << offset;
> -	__raw_writel(value, S5P_GPIOREG(GPIOINT_PEND_OFFSET) + pend_offset);
> +	value = __raw_readl(GPIO_BASE(chip) + PEND_OFFSET + pend_offset);
> +	value |= BIT(offset);

No need inclusion <linux/bitops.h>?

> +	__raw_writel(value, GPIO_BASE(chip) + PEND_OFFSET + pend_offset);
>  }
> 
>  static void s5p_gpioint_mask(struct irq_data *data)
>  {
> +	struct s3c_gpio_chip *chip = irq_data_get_irq_data(data);
>  	int group, offset, mask_offset;
>  	unsigned int value;
> 
> -	group = s5p_gpioint_get_group(data);
> +	group = chip->group;
>  	offset = s5p_gpioint_get_offset(data);
> -	mask_offset = group << 2;
> +	mask_offset = REG_OFFSET(group);
> 
> -	value = __raw_readl(S5P_GPIOREG(GPIOINT_MASK_OFFSET) + mask_offset);
> -	value |= 1 << offset;
> -	__raw_writel(value, S5P_GPIOREG(GPIOINT_MASK_OFFSET) + mask_offset);
> +	value = __raw_readl(GPIO_BASE(chip) + MASK_OFFSET + mask_offset);
> +	value |= BIT(offset);
> +	__raw_writel(value, GPIO_BASE(chip) + MASK_OFFSET + mask_offset);
>  }
> 
>  static void s5p_gpioint_unmask(struct irq_data *data)
>  {
> +	struct s3c_gpio_chip *chip = irq_data_get_irq_data(data);
>  	int group, offset, mask_offset;
>  	unsigned int value;
> 
> -	group = s5p_gpioint_get_group(data);
> +	group = chip->group;
>  	offset = s5p_gpioint_get_offset(data);
> -	mask_offset = group << 2;
> +	mask_offset = REG_OFFSET(group);
> 
> -	value = __raw_readl(S5P_GPIOREG(GPIOINT_MASK_OFFSET) + mask_offset);
> -	value &= ~(1 << offset);
> -	__raw_writel(value, S5P_GPIOREG(GPIOINT_MASK_OFFSET) + mask_offset);
> +	value = __raw_readl(GPIO_BASE(chip) + MASK_OFFSET + mask_offset);
> +	value &= ~BIT(offset);
> +	__raw_writel(value, GPIO_BASE(chip) + MASK_OFFSET + mask_offset);
>  }
> 
>  static void s5p_gpioint_mask_ack(struct irq_data *data)
> @@ -103,12 +90,13 @@ static void s5p_gpioint_mask_ack(struct irq_data
*data)
> 
>  static int s5p_gpioint_set_type(struct irq_data *data, unsigned int type)
>  {
> +	struct s3c_gpio_chip *chip = irq_data_get_irq_data(data);
>  	int group, offset, con_offset;
>  	unsigned int value;
> 
> -	group = s5p_gpioint_get_group(data);
> +	group = chip->group;
>  	offset = s5p_gpioint_get_offset(data);
> -	con_offset = group << 2;
> +	con_offset = REG_OFFSET(group);
> 
>  	switch (type) {
>  	case IRQ_TYPE_EDGE_RISING:
> @@ -132,15 +120,15 @@ static int s5p_gpioint_set_type(struct irq_data
*data,
> unsigned int type)
>  		return -EINVAL;
>  	}
> 
> -	value = __raw_readl(S5P_GPIOREG(GPIOINT_CON_OFFSET) + con_offset);
> +	value = __raw_readl(GPIO_BASE(chip) + CON_OFFSET + con_offset);
>  	value &= ~(0x7 << (offset * 0x4));
>  	value |= (type << (offset * 0x4));
> -	__raw_writel(value, S5P_GPIOREG(GPIOINT_CON_OFFSET) + con_offset);
> +	__raw_writel(value, GPIO_BASE(chip) + CON_OFFSET + con_offset);
> 
>  	return 0;
>  }
> 
> -struct irq_chip s5p_gpioint = {
> +static struct irq_chip s5p_gpioint = {
>  	.name		= "s5p_gpioint",
>  	.irq_ack	= s5p_gpioint_ack,
>  	.irq_mask	= s5p_gpioint_mask,
> @@ -151,30 +139,28 @@ struct irq_chip s5p_gpioint = {
> 
>  static void s5p_gpioint_handler(unsigned int irq, struct irq_desc *desc)
>  {
> -	int group, offset, pend_offset, mask_offset;
> -	int real_irq;
> +	int group, pend_offset, mask_offset;
>  	unsigned int pend, mask;
> 
>  	for (group = 0; group < S5P_GPIOINT_GROUP_MAXNR; group++) {
> -		pend_offset = group << 2;
> -		pend = __raw_readl(S5P_GPIOREG(GPIOINT_PEND_OFFSET) +
> -				pend_offset);
> +		struct s3c_gpio_chip *chip = irq_chips[group];
> +		if (!chip)
> +			continue;
> +
> +		pend_offset = REG_OFFSET(group);
> +		pend = __raw_readl(GPIO_BASE(chip) + PEND_OFFSET +
> pend_offset);
>  		if (!pend)
>  			continue;
> 
> -		mask_offset = group << 2;
> -		mask = __raw_readl(S5P_GPIOREG(GPIOINT_MASK_OFFSET) +
> -				mask_offset);
> +		mask_offset = REG_OFFSET(group);
> +		mask = __raw_readl(GPIO_BASE(chip) + MASK_OFFSET +
> mask_offset);
>  		pend &= ~mask;
> 
> -		for (offset = 0; offset < 8; offset++) {
> -			if (pend & (1 << offset)) {
> -				struct s3c_gpio_chip *chip =
irq_chips[group];
> -				if (chip) {
> -					real_irq = chip->irq_base + offset;
> -					generic_handle_irq(real_irq);
> -				}
> -			}
> +		while (pend) {
> +			int offset = fls(pend) - 1;

__ffs?

And hmm...do we really need while loop here?

> +			int real_irq = chip->irq_base + offset;
> +			generic_handle_irq(real_irq);
> +			pend &= ~BIT(offset);
>  		}
>  	}
>  }
> @@ -202,7 +188,7 @@ static __init int s5p_gpioint_add(struct s3c_gpio_chip
> *chip)
>  	for (i = 0; i < chip->chip.ngpio; i++) {
>  		irq = chip->irq_base + i;
>  		set_irq_chip(irq, &s5p_gpioint);
> -		set_irq_data(irq, &chip->chip);
> +		set_irq_data(irq, chip);

?

>  		set_irq_handler(irq, handle_level_irq);
>  		set_irq_flags(irq, IRQF_VALID);
>  	}
> --


Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
