From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 6 Jan 2014 15:53:50 +0000
Subject: [PATCH v2 3/7] mfd: pm8921: Migrate to irqdomains
In-Reply-To: <1387831563-13535-4-git-send-email-sboyd@codeaurora.org>
References: <1387831563-13535-1-git-send-email-sboyd@codeaurora.org>
 <1387831563-13535-4-git-send-email-sboyd@codeaurora.org>
Message-ID: <20140106155350.GI30156@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Convert this driver to use irqdomains so that the PMIC's child
> devices can be converted to devicetree.
> 
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  drivers/mfd/pm8921-core.c         | 184 ++++++++++++++------------------------
>  include/linux/mfd/pm8xxx/irq.h    |  36 --------
>  include/linux/mfd/pm8xxx/pm8921.h |  30 -------
>  3 files changed, 65 insertions(+), 185 deletions(-)
>  delete mode 100644 include/linux/mfd/pm8xxx/irq.h
>  delete mode 100644 include/linux/mfd/pm8xxx/pm8921.h
> 

<snip>

> @@ -56,8 +56,7 @@
>  struct pm_irq_chip {
>  	struct device		*dev;
>  	spinlock_t		pm_irq_lock;
> -	unsigned int		devirq;
> -	unsigned int		irq_base;
> +	struct irq_domain	*domain;

It's probably best to explicitly specify 'irqdomain' here in order to
eliminate any possibility of ambiguity.

>  	unsigned int		num_irqs;
>  	unsigned int		num_blocks;
>  	unsigned int		num_masters;
> @@ -138,7 +137,7 @@ static int pm8xxx_irq_block_handler(struct pm_irq_chip *chip, int block)
>  	for (i = 0; i < 8; i++) {
>  		if (bits & (1 << i)) {
>  			pmirq = block * 8 + i;
> -			irq = pmirq + chip->irq_base;
> +			irq = irq_find_mapping(chip->domain, pmirq);

Going by this patch only, it appears you're calling irq_find_mapping()
before you've called irq_create_mapping(). This won't work, so unless
you've called the latter in a previous patch, you should ensure that
you do so.

>  			generic_handle_irq(irq);
>  		}
>  	}
> @@ -197,12 +196,11 @@ static void pm8xxx_irq_handler(unsigned int irq, struct irq_desc *desc)
>  static void pm8xxx_irq_mask_ack(struct irq_data *d)
>  {
>  	struct pm_irq_chip *chip = irq_data_get_irq_chip_data(d);
> -	unsigned int pmirq = d->irq - chip->irq_base;
> -	int	master, irq_bit;
> +	unsigned int pmirq = irqd_to_hwirq(d);

Why don't you call it hwirq instead of pmirq?

> +	int	irq_bit;
>  	u8	block, config;
>  
>  	block = pmirq / 8;

Ah, I guess you're keeping the original naming convention.

> -	master = block / 8;

What was the point in this anyway? Was it completely superfluous?

<snip>

> +static int pm8xxx_irq_init(struct platform_device *pdev, unsigned int irq)
> +{
> +	struct pm_irq_chip  *chip;
> +	unsigned int nirqs = 256;

No magic numbers please.

> +	chip = devm_kzalloc(&pdev->dev, sizeof(*chip) + sizeof(u8) * nirqs,
> +			    GFP_KERNEL);

What does the sizeof(u8) add here?

<snip>

> +	return of_platform_populate(pdev->dev.of_node, NULL, NULL, &pdev->dev);
> +}

Can't you use the MFD core instead?

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
