From: rjui@broadcom.com (Ray Jui)
Date: Fri, 5 Dec 2014 18:14:39 -0800
Subject: [PATCH 2/5] gpio: Cygnus: add GPIO driver
In-Reply-To: <1417829282.31745.3.camel@perches.com>
References: <Ray Jui <rjui@broadcom.com>	
 <1417826408-1600-1-git-send-email-rjui@broadcom.com>	
 <1417826408-1600-3-git-send-email-rjui@broadcom.com>
 <1417829282.31745.3.camel@perches.com>
Message-ID: <5482668F.1040907@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for your review, Joe:

On 12/5/2014 5:28 PM, Joe Perches wrote:
> On Fri, 2014-12-05 at 16:40 -0800, Ray Jui wrote:
>> This GPIO driver supports all 3 GPIO controllers in the Broadcom Cygnus
>> SoC. The 3 GPIO controllers are 1) the ASIU GPIO controller
>> ("brcm,cygnus-asiu-gpio"), 2) the chipCommonG GPIO controller
>> ("brcm,cygnus-ccm-gpio"), and 3) the ALWAYS-ON GPIO controller
>> ("brcm,cygnus-crmu-gpio")
>
> trivia:
>
>> diff --git a/drivers/gpio/gpio-bcm-cygnus.c b/drivers/gpio/gpio-bcm-cygnus.c
>
>> +static inline struct bcm_cygnus_gpio *to_bcm_cygnus_gpio(
>> +		struct gpio_chip *gc)
>> +{
>> +	return container_of(gc, struct bcm_cygnus_gpio, gc);
>> +}
>
> Probably all of these inlines can just be static.
>
> The compiler does a pretty good job these days
> of inlining where appropriate.

Okay I can remove all inlines.

>
>
>> +static void bcm_cygnus_gpio_irq_handler(unsigned int irq,
>> +		struct irq_desc *desc)
>> +{
>> +	struct bcm_cygnus_gpio *cygnus_gpio;
>> +	struct irq_chip *chip = irq_desc_get_chip(desc);
>> +	int i, bit;
>> +
>> +	chained_irq_enter(chip, desc);
>> +
>> +	cygnus_gpio = irq_get_handler_data(irq);
>> +
>> +	/* go through the entire GPIO banks and handle all interrupts */
>> +	for (i = 0; i < cygnus_gpio->num_banks; i++) {
>> +		unsigned long val = readl(cygnus_gpio->base +
>> +				(i * GPIO_BANK_SIZE) +
>> +				CYGNUS_GPIO_INT_MSTAT_OFFSET);
>> +		if (val) {
>
> This if (val) and indentation isn't really necessary
>

Note for_each_set_bit in this case iterates 32 times searching for bits 
that are set. By having the if (val) check here, it can potentially save 
some of such processing in the ISR. I agree with you that it introduces 
one extra indent here but I think it's required.

>> +			for_each_set_bit(bit, &val, 32) {
>
> for_each_set_bit will effectively do the if above.
>
> 32 bit only code?
> otherwise isn't this endian unsafe?
>

Will change 'unsigned long val' to 'u32 val'.

>> +				unsigned pin = NGPIOS_PER_BANK * i + bit;
>> +				int child_irq =	bcm_cygnus_gpio_to_irq(
>> +						&cygnus_gpio->gc, pin);
>> +
>> +				/*
>> +				 * Clear the interrupt before invoking the
>> +				 * handler, so we do not leave any window
>> +				 */
>> +				writel(1 << bit,
>> +					cygnus_gpio->base +
>> +					(i * GPIO_BANK_SIZE) +
>> +					CYGNUS_GPIO_INT_CLR_OFFSET);
>> +
>> +				generic_handle_irq(child_irq);
>> +			}
>> +
>> +		}
>> +	}
>> +
>> +	chained_irq_exit(chip, desc);
>> +}
>> +
>> +static void bcm_cygnus_gpio_irq_ack(struct irq_data *d)
>> +{
>> +	struct bcm_cygnus_gpio *cygnus_gpio = irq_data_get_irq_chip_data(d);
>> +	unsigned gpio = d->hwirq;
>> +	unsigned int offset, shift;
>> +	u32 val;
>> +
>> +	offset = __gpio_reg_offset(cygnus_gpio, gpio) +
>> +		CYGNUS_GPIO_INT_CLR_OFFSET;
>> +	shift = __gpio_bitpos(cygnus_gpio, gpio);
>> +
>> +	val = 1 << shift;
>> +	writel(val, cygnus_gpio->base + offset);
>> +
>> +	dev_dbg(cygnus_gpio->dev, "gpio:%u offset:0x%04x shift:%u\n", gpio,
>> +			offset, shift);
>> +}
>
>> +static struct irq_chip bcm_cygnus_gpio_irq_chip = {
>> +	.name = "bcm-cygnus-gpio",
>> +	.irq_ack = bcm_cygnus_gpio_irq_ack,
>> +	.irq_mask = bcm_cygnus_gpio_irq_mask,
>> +	.irq_unmask = bcm_cygnus_gpio_irq_unmask,
>> +	.irq_set_type = bcm_cygnus_gpio_irq_set_type,
>> +};
>
> const?
>


Sure, will add const to bcm_cygnus_gpio_irq_chip

>> +static struct irq_domain_ops bcm_cygnus_irq_ops = {
>> +	.map = bcm_cygnus_gpio_irq_map,
>> +	.unmap = bcm_cygnus_gpio_irq_unmap,
>> +	.xlate = irq_domain_xlate_twocell,
>> +};
>
> const here too?
>

Yes, will make bcm_cygnus_irq_ops const.

>> +#ifdef CONFIG_OF_GPIO
>> +static void bcm_cygnus_gpio_set_pull(struct bcm_cygnus_gpio *cygnus_gpio,
>> +		unsigned gpio, enum gpio_pull pull)
>> +{
>> +	unsigned int offset, shift;
>> +	u32 val, up;
>
> 	bool up; ?
>

Okay I'll change the name from 'up' to 'pullup' to make it more readable.

>> +	unsigned long flags;
>> +
>> +	switch (pull) {
>> +	case GPIO_PULL_NONE:
>> +		return;
>> +	case GPIO_PULL_UP:
>> +		up = 1;
>> +		break;
>> +	case GPIO_PULL_DOWN:
>> +		up = 0;
>> +		break;
>> +	case GPIO_PULL_INVALID:
>> +	default:
>> +		return;
>> +	}
>
> Maybe more sensible to group GPIO_PULL_NONE with GPIO_PULL_INVALID
>
>

Good suggestion, will do the following:

case GPIO_PULL_NONE:
case GPIO_PULL_INVALID:
default:
        return;

>> +static int bcm_cygnus_gpio_probe(struct platform_device *pdev)
>> +{
> []
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	if (!res) {
>> +		dev_err(&pdev->dev, "unable to get I/O resource");
>
> missing newline
>
>

Right, will fix it with dev_err(&pdev->dev, "unable to get I/O resource\n");
