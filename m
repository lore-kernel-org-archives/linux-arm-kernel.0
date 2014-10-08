From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 08 Oct 2014 17:13:28 +0200
Subject: [PATCH v1 1/3] gpio: Add APM X-Gene standby GPIO controller driver
In-Reply-To: <1412779948-28769-2-git-send-email-yvo@apm.com>
References: <1412779948-28769-1-git-send-email-yvo@apm.com>
 <1412779948-28769-2-git-send-email-yvo@apm.com>
Message-ID: <1843196.sbXNmZyoMx@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 08 October 2014 21:52:26 Y Vo wrote:
> +
> +#define GICD_SPI_BASE			0x78010000

You can't hardcode register locations. Please use the proper interfaces
to do whatever you want.

It's probably not ok to map any GIC registers into the GPIO driver,
it should operate as a nested irqchip.

> +
> +static int xgene_gpio_sb_get(struct gpio_chip *gc, u32 gpio)
> +{
> +	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
> +	struct xgene_gpio_sb *chip = to_xgene_gpio_sb(mm_gc);
> +	u32 data;
> +
> +	if (chip->irq[gpio]) {
> +		data = ioread32(chip->gic_regs + GICD_SPIR1);
> +	} else {
> +		data = ioread32(mm_gc->regs + MPA_GPIO_IN_ADDR);
> +	}
> +
> +	return (data &  GPIO_MASK(gpio)) ? 1 : 0;
> +}

This should not assume that a particular upstream irqchip is used,
and more importantly it should not touch its registers.

> +static int apm_gpio_sb_to_irq(struct gpio_chip *gc, u32 gpio)
> +{
> +	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
> +	struct xgene_gpio_sb *chip = to_xgene_gpio_sb(mm_gc);
> +
> +	if (chip->irq[gpio])
> +		return chip->irq[gpio];
> +
> +	return -ENXIO;
> +}
> +
> +static int gpio_sb_probe(struct platform_device *pdev)
> +{
> +	struct of_mm_gpio_chip *mm;
> +	struct xgene_gpio_sb *apm_gc;
> +	u32 ret, i;
> +	u32 default_pins[] = {0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D};

Why are these hardcoded? The "apm,xgene-gpio-sb" compatible string
seems very generic, but the list of pins here seems very specific
to a particular implementation.

> +	mm->gc.ngpio = XGENE_MAX_GPIO_DS;
> +	apm_gc->nirq = XGENE_MAX_GPIO_DS_IRQ;
> +
> +	apm_gc->gic_regs = ioremap(GICD_SPI_BASE, 16);
> +	if (!apm_gc->gic_regs)
> +		return -ENOMEM;
> +
> +	apm_gc->irq = devm_kzalloc(&pdev->dev, sizeof(u32) * XGENE_MAX_GPIO_DS,
> +				   GFP_KERNEL);
> +	if (!apm_gc->irq)
> +		return -ENOMEM;
> +	memset(apm_gc->irq, 0, sizeof(u32) * XGENE_MAX_GPIO_DS);

kzalloc implies memset.

> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	mm->regs = devm_ioremap_resource(&pdev->dev, res);
> +	if (!mm->regs)
> +		return PTR_ERR(mm->regs);
> +
> +	for (i = 0; i < apm_gc->nirq; i++) {
> +		apm_gc->irq[default_pins[i]] = platform_get_irq(pdev, i);
> +		xgene_gpio_set_bit(mm->regs + MPA_GPIO_SEL_LO,
> +				   default_pins[i] * 2, 1);
> +		xgene_gpio_set_bit(mm->regs + MPA_GPIO_INT_LVL, i, 1);
> +	}
> +	mm->gc.of_node = pdev->dev.of_node;
> +	ret = gpiochip_add(&mm->gc);
> +	if (ret)
> +		dev_err(&pdev->dev, "failed to register X-Gene GPIO Standby driver");
> +	else
> +		dev_info(&pdev->dev, "X-Gene GPIO Standby driver registered\n");
> +
> +	return ret;
> +}
> +
> +static int xgene_gpio_sb_probe(struct platform_device *pdev)
> +{
> +	return gpio_sb_probe(pdev);
> +}

This function is pointless, just call the real one instead.

	ARnd
