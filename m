From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 13 Oct 2011 17:42:26 +0200
Subject: [PATCH v4 8/8] ARM: pxa: move macros into gpio-pxa.c
In-Reply-To: <1318478825-17187-9-git-send-email-haojian.zhuang@marvell.com>
References: <1318478825-17187-1-git-send-email-haojian.zhuang@marvell.com>
	<1318478825-17187-9-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <201110131742.26870.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 13 October 2011, Haojian Zhuang wrote:
> Move macro like PXA_GPLR(). Use pxa_gpio_bank_read()/pxa_gpio_bank_write()
> instead. And append pxa_gpio_pin_get()/ pxa_gpio_pin_set() /
> pxa_gpio_pin_clear() for operation on single GPIO pin.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>

Thanks, reading the patch I understand much more about the background of
how things are done in the gpio-pxa driver, but it also raises a few
more points:

> @@ -90,7 +91,8 @@ static int corgi_should_wakeup(unsigned int resume_on_alarm)
>  {
>  	int is_resume = 0;
>  
> -	dev_dbg(sharpsl_pm.dev, "PXA_GPLR0 = %x,%x\n", PXA_GPLR(0), PEDR);
> +	dev_dbg(sharpsl_pm.dev, "PXA_GPLR0 = %x,%x\n",
> +		pxa_gpio_bank_read(PXA_GPLR, 0), PEDR);
>  
>  	if ((PEDR & PXA_GPIO_bit(CORGI_GPIO_AC_IN))) {
>  		if (sharpsl_pm.machinfo->read_devdata(SHARPSL_STATUS_ACIN)) {
> @@ -124,15 +126,18 @@ static int corgi_should_wakeup(unsigned int resume_on_alarm)
>  
>  static unsigned long corgi_charger_wakeup(void)
>  {
> -	return ~PXA_GPLR(CORGI_GPIO_AC_IN) & ( PXA_GPIO_bit(CORGI_GPIO_AC_IN)
> -		| PXA_GPIO_bit(CORGI_GPIO_KEY_INT) | PXA_GPIO_bit(CORGI_GPIO_WAKEUP) );
> +	unsigned long ret;
> +	ret = pxa_gpio_pin_get(PXA_GPLR, CORGI_GPIO_AC_IN)
> +		| pxa_gpio_pin_get(PXA_GPLR, CORGI_GPIO_KEY_INT)
> +		| pxa_gpio_pin_get(PXA_GPLR, CORGI_GPIO_WAKEUP);
> +	return !ret;
>  }

Having code like this in the platform code suggests that there is still
something wrong: it would be much better if the platform could rely on
the generic GPIO API functions and not directly call functions from the
device driver. However, fixing this could become a larger effort and
the cleanups you do are definitely moving in the right direction,
so I'd say this can be left for another time. Maybe you could add a
FIXME comment here as a reminder.

>  	switch (gpio_type) {
>  	case PXA25X_GPIO:
>  	case PXA26X_GPIO:
>  	case PXA27X_GPIO:
> -		af = (PXA_GAFR(gpio) >> ((gpio & 0xf) * 2)) & 0x3;
> -		dir = PXA_GPDR(gpio) & PXA_GPIO_bit(gpio);
> +		bank = pxa_gpio_to_bank(gpio);
> +		data = readl_relaxed(pxa_gpio_regbase + PXA_GAFR
> +			+ PXA_BANK_OFF(bank));
> +		af = (data >> ((gpio & 0xf) * 2)) & 0x3;
> +		data = readl_relaxed(pxa_gpio_regbase + PXA_GPDR
> +			+ PXA_BANK_OFF(bank));
> +		dir = pxa_gpio_pin_get(PXA_GPDR, gpio);

This looks much safer than before. I would have used the pxa_gpio_bank_read
function here to encapsulate the address computation, but that is just a
matter of personal preference, not of correctness.

> @@ -169,12 +206,12 @@ static int pxa_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
>  
>  	spin_lock_irqsave(&gpio_lock, flags);
>  
> -	value = __raw_readl(base + GPDR_OFFSET);
> +	value = __raw_readl(base + PXA_GPDR);
>  	if (__gpio_is_inverted(chip->base + offset))
>  		value |= mask;
>  	else
>  		value &= ~mask;
> -	__raw_writel(value, base + GPDR_OFFSET);
> +	__raw_writel(value, base + PXA_GPDR);
>  
>  	spin_unlock_irqrestore(&gpio_lock, flags);
>  	return 0;

It would be better to convert all MMIO accesses to
readl_relaxed/writel_relaxed here. There is no strice need to do that
yet, but since you are touching these lines anyway, just use the
preferred interface. Same for all the other locations.

Note that according to the definition of the __raw MMIO accessors, the
acess is allowed to leaks outside of the spinlock, although that does
not currently happen on ARM AFAIK.

> +enum pxa_gpios {
> +	PXA_GPLR = 0x00,	/* GPIO Pin Level Registers */
> +	PXA_GPDR = 0x0C,	/* GPIO Pin Direction Registers */
> +	PXA_GPSR = 0x18,	/* GPIO Pin Output Set Registers */
> +	PXA_GPCR = 0x24,	/* GPIO Pin Output Clear Registers */
> +	PXA_GRER = 0x30,	/* GPIO Rising Edge Detect Registers */
> +	PXA_GFER = 0x3C,	/* GPIO Falling Edge Detect Registers */
> +	PXA_GEDR = 0x48,	/* GPIO Edge Detect Status Registers */
> +	PXA_GAFR = 0x54,	/* GPIO Alternate Function Select Registers */
> +	PXA_ED_MASK = 0x9C,	/* GPIO edge detection for AP side */
> +};
>  
>  /* NOTE: some PXAs have fewer on-chip GPIOs (like PXA255, with 85).
>   * Those cases currently cause holes in the GPIO number space, the
> @@ -75,8 +44,17 @@ extern struct pxa_gpio_regs pxa_gpio_regs;
>   */
>  extern int pxa_last_gpio;
>  
> -typedef int (*set_wake_t)(struct irq_data *d, unsigned int on);
> -
>  extern int pxa_irq_to_gpio(int irq);
>  
> +extern unsigned int pxa_gpio_pin_get(enum pxa_gpios reg, unsigned int gpio);
> +
> +extern void pxa_gpio_pin_set(enum pxa_gpios reg, unsigned int gpio);
> +
> +extern void pxa_gpio_pin_clear(enum pxa_gpios reg, unsigned int gpio);
> +
> +extern unsigned int pxa_gpio_bank_read(enum pxa_gpios reg, unsigned int bank);
> +
> +extern void pxa_gpio_bank_write(enum pxa_gpios reg, unsigned int value,
> +				unsigned int bank);

Unfortunately, it seems that you still need to keep the header file around
because of the way it's used by the platform code. Again, I would suggest
adding a comment in the header explaining that this is not actually the
desired situation.

	Arnd
