From: ben-linux@fluff.org (Ben Dooks)
Date: Tue, 19 Oct 2010 00:04:24 +0100
Subject: [PATCH 2/2] ARM: S5PV310: Add external interrupt support
In-Reply-To: <1287378393-15699-3-git-send-email-jongsun.han@samsung.com>
References: <1287378393-15699-1-git-send-email-jongsun.han@samsung.com>
	<1287378393-15699-3-git-send-email-jongsun.han@samsung.com>
Message-ID: <4CBCD278.50301@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/10/10 06:06, Jongsun Han wrote:
> All external interrupts are transferred to GIC through interrupt combiner.
> 
> Signed-off-by: Jongsun Han <jongsun.han@samsung.com>
> Signed-off-by: Jongpill Lee <boyko.lee@samsung.com>
> ---
>  arch/arm/mach-s5pv310/Makefile   |    2 +-
>  arch/arm/mach-s5pv310/irq-eint.c |  228 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 229 insertions(+), 1 deletions(-)
>  create mode 100644 arch/arm/mach-s5pv310/irq-eint.c
> 
> diff --git a/arch/arm/mach-s5pv310/Makefile b/arch/arm/mach-s5pv310/Makefile
> index 97aba6d..6a8a1ef 100644
> --- a/arch/arm/mach-s5pv310/Makefile
> +++ b/arch/arm/mach-s5pv310/Makefile
> @@ -13,7 +13,7 @@ obj-				:=
>  # Core support for S5PV310 system
>  
>  obj-$(CONFIG_CPU_S5PV310)	+= cpu.o init.o clock.o irq-combiner.o
> -obj-$(CONFIG_CPU_S5PV310)	+= setup-i2c0.o time.o gpiolib.o
> +obj-$(CONFIG_CPU_S5PV310)	+= setup-i2c0.o time.o gpiolib.o irq-eint.o
>  obj-$(CONFIG_CPU_FREQ)		+= cpufreq.o
>  
>  obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
> diff --git a/arch/arm/mach-s5pv310/irq-eint.c b/arch/arm/mach-s5pv310/irq-eint.c

> +static unsigned int s5pv310_get_irq_nr(unsigned int number)
> +{
> +	u32 ret = 0;
> +
> +	switch (number) {
> +	case 0 ... 3:
> +		ret = (number + IRQ_EINT0);
> +		break;
> +	case 4 ... 7:
> +		ret = (number + (IRQ_EINT4 - 4));
> +		break;
> +	case 8 ... 15:
> +		ret = (number + (IRQ_EINT8 - 8));
> +		break;
> +	default:
> +		printk(KERN_ERR "number available : %d\n", number);
> +	}
> +
> +	return ret;
> +}

> +static inline void s5pv310_irq_eint_ack(unsigned int irq)
> +{
> +	spin_lock(&eint_lock);
> +	__raw_writel(eint_irq_to_bit(irq),
> +		     S5P_EINT_PEND(EINT_REG_NR(irq)));
> +	spin_unlock(&eint_lock);
> +}

do you really need a spinlock around a single write?

> +static void s5pv310_irq_eint_maskack(unsigned int irq)
> +{
> +	s5pv310_irq_eint_mask(irq);
> +	s5pv310_irq_eint_ack(irq);
> +}
> +
> +static int s5pv310_irq_eint_set_type(unsigned int irq, unsigned int type)
> +{
> +	int offs = EINT_OFFSET(irq);
> +	int shift;
> +	u32 ctrl, mask;
> +	u32 newvalue = 0;
> +
> +	switch (type) {
> +	case IRQ_TYPE_EDGE_RISING:
> +		newvalue = S5P_IRQ_TYPE_EDGE_RISING;
> +		break;
> +
> +	case IRQ_TYPE_EDGE_FALLING:
> +		newvalue = S5P_IRQ_TYPE_EDGE_FALLING;
> +		break;
> +
> +	case IRQ_TYPE_EDGE_BOTH:
> +		newvalue = S5P_IRQ_TYPE_EDGE_BOTH;
> +		break;
> +
> +	case IRQ_TYPE_LEVEL_LOW:
> +		newvalue = S5P_IRQ_TYPE_LEVEL_LOW;
> +		break;
> +
> +	case IRQ_TYPE_LEVEL_HIGH:
> +		newvalue = S5P_IRQ_TYPE_LEVEL_HIGH;
> +		break;
> +
> +	default:
> +		printk(KERN_ERR "No such irq type %d", type);
> +		return -EINVAL;
> +	}
> +
> +	shift = (offs & 0x7) * 4;
> +	mask = 0x7 << shift;
> +
> +	spin_lock(&eint_lock);
> +	ctrl = __raw_readl(S5P_EINT_CON(EINT_REG_NR(irq)));
> +	ctrl &= ~mask;
> +	ctrl |= newvalue << shift;
> +	__raw_writel(ctrl, S5P_EINT_CON(EINT_REG_NR(irq)));
> +	spin_unlock(&eint_lock);
> +
> +	if ((0 <= offs) && (offs < 8))

a switch on (offs >> 3) would have been more efficient.

> +		s3c_gpio_cfgpin(EINT_GPIO_0(offs & 0x7), EINT_MODE);
> +
> +	else if ((8 <= offs) && (offs < 16))
> +		s3c_gpio_cfgpin(EINT_GPIO_1(offs & 0x7), EINT_MODE);
> +
> +	else if ((16 <= offs) && (offs < 24))
> +		s3c_gpio_cfgpin(EINT_GPIO_2(offs & 0x7), EINT_MODE);
> +
> +	else if ((24 <= offs) && (offs < 32))
> +		s3c_gpio_cfgpin(EINT_GPIO_3(offs & 0x7), EINT_MODE);
> +
> +	else
> +		printk(KERN_ERR "No such irq number %d", offs);
> +
> +	return 0;
> +}


> +
> +static void s5pv310_irq_eint0_15(unsigned int irq, struct irq_desc *desc)
> +{
> +	u32 i;
> +	struct irq_chip *chip = get_irq_chip(irq);
> +
> +	chip->mask(irq);
> +
> +	if (chip->ack)
> +		chip->ack(irq);
> +
> +	for (i = 0 ; i <= 15 ; i++) {
> +		if (irq == s5pv310_get_irq_nr(i)) {
> +			generic_handle_irq(IRQ_EINT(i));
> +			break;
> +		}
> +	}
> +
> +	chip->unmask(irq);
> +}

I would say that keeping the information about the irq => IRQ_EINT
mapping around in the irq_desc information to save the time taken
to process the for() loop in the above function.

> +int __init s5pv310_init_irq_eint(void)
> +{
> +	int irq;
> +
> +	for (irq = 0 ; irq <= 31 ; irq++) {
> +		set_irq_chip(IRQ_EINT(irq), &s5pv310_irq_eint);
> +		set_irq_handler(IRQ_EINT(irq), handle_level_irq);
> +		set_irq_flags(IRQ_EINT(irq), IRQF_VALID);
> +	}
> +
> +	set_irq_chained_handler(IRQ_EINT16_31, s5pv310_irq_demux_eint16_31);
> +
> +	for (irq = 0 ; irq <= 15 ; irq++)
> +		set_irq_chained_handler(s5pv310_get_irq_nr(irq),
> +					s5pv310_irq_eint0_15);
> +
> +	return 0;
> +}
> +
> +arch_initcall(s5pv310_init_irq_eint);
