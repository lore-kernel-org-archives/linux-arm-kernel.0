From: opendmb@gmail.com (Doug Berger)
Date: Thu, 19 Oct 2017 11:39:16 -0700
Subject: [PATCH 7/7] gpio: brcmstb: implement suspend/resume/shutdown
In-Reply-To: <20171019090359.GB31645@kessel>
References: <20170930034057.15166-1-opendmb@gmail.com>
 <20170930034057.15166-8-opendmb@gmail.com> <20171019090359.GB31645@kessel>
Message-ID: <aa8a2900-22a5-5ec5-2afc-038fc42ea940@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/19/2017 02:03 AM, Gregory Fong wrote:
> Hi Doug,
> 
> Nice description of the problem with dealing with a pending disabled
> wake interrupt and the solution.  A few remarks:
> 
> On Fri, Sep 29, 2017 at 08:40:57PM -0700, Doug Berger wrote:
>> diff --git a/drivers/gpio/gpio-brcmstb.c b/drivers/gpio/gpio-brcmstb.c
>> index 752a46ce3589..c964ed71a68d 100644
>> --- a/drivers/gpio/gpio-brcmstb.c
>> +++ b/drivers/gpio/gpio-brcmstb.c
>> @@ -19,17 +19,29 @@
>>  #include <linux/irqdomain.h>
>>  #include <linux/irqchip/chained_irq.h>
>>  #include <linux/interrupt.h>
>> -#include <linux/reboot.h>
>> -
>> -#define GIO_BANK_SIZE           0x20
>> -#define GIO_ODEN(bank)          (((bank) * GIO_BANK_SIZE) + 0x00)
>> -#define GIO_DATA(bank)          (((bank) * GIO_BANK_SIZE) + 0x04)
>> -#define GIO_IODIR(bank)         (((bank) * GIO_BANK_SIZE) + 0x08)
>> -#define GIO_EC(bank)            (((bank) * GIO_BANK_SIZE) + 0x0c)
>> -#define GIO_EI(bank)            (((bank) * GIO_BANK_SIZE) + 0x10)
>> -#define GIO_MASK(bank)          (((bank) * GIO_BANK_SIZE) + 0x14)
>> -#define GIO_LEVEL(bank)         (((bank) * GIO_BANK_SIZE) + 0x18)
>> -#define GIO_STAT(bank)          (((bank) * GIO_BANK_SIZE) + 0x1c)
>> +
>> +enum gio_reg_index {
>> +	GIO_REG_ODEN = 0,
>> +	GIO_REG_DATA,
>> +	GIO_REG_IODIR,
>> +	GIO_REG_EC,
>> +	GIO_REG_EI,
>> +	GIO_REG_MASK,
>> +	GIO_REG_LEVEL,
>> +	GIO_REG_STAT,
>> +	GIO_REG_COUNT
> 
> Please change the name or add a comment to make it clear that this is
> not for an actual register.
> 

Will do.

>> +};
>> +
>> [snip]
>> @@ -37,6 +49,8 @@ struct brcmstb_gpio_bank {
>>  	struct gpio_chip gc;
>>  	struct brcmstb_gpio_priv *parent_priv;
>>  	u32 width;
>> +	u32 wake_active;
>> +	u32 regs[GIO_REG_STAT]; /* Don't save and restore GIO_REG_STAT */
> 
> Consider naming to make it clearer that this is for save/restore, not
> some kind of shadow reg implementation or anything like that.
> 

Will do.

>>  };
>>  
>>  struct brcmstb_gpio_priv {
>> @@ -49,7 +63,6 @@ struct brcmstb_gpio_priv {
>>  	int gpio_base;
>>  	int num_gpios;
>>  	int parent_wake_irq;
>> -	struct notifier_block reboot_notifier;
>>  };
>>  
>>  #define MAX_GPIO_PER_BANK       32
>> @@ -65,15 +78,22 @@ brcmstb_gpio_gc_to_priv(struct gpio_chip *gc)
>>  }
>>  
>>  static unsigned long
>> -brcmstb_gpio_get_active_irqs(struct brcmstb_gpio_bank *bank)
>> +__brcmstb_gpio_get_active_irqs(struct brcmstb_gpio_bank *bank)
>>  {
>>  	void __iomem *reg_base = bank->parent_priv->reg_base;
>> +
>> +	return bank->gc.read_reg(reg_base + GIO_STAT(bank->id)) &
>> +	       bank->gc.read_reg(reg_base + GIO_MASK(bank->id));
>> +}
>> +
>> +static unsigned long
>> +brcmstb_gpio_get_active_irqs(struct brcmstb_gpio_bank *bank)
>> +{
>>  	unsigned long status;
>>  	unsigned long flags;
>>  
>>  	spin_lock_irqsave(&bank->gc.bgpio_lock, flags);
>> -	status = bank->gc.read_reg(reg_base + GIO_STAT(bank->id)) &
>> -		 bank->gc.read_reg(reg_base + GIO_MASK(bank->id));
>> +	status = __brcmstb_gpio_get_active_irqs(bank);
>>  	spin_unlock_irqrestore(&bank->gc.bgpio_lock, flags);
>>  
>>  	return status;
>> @@ -209,11 +229,6 @@ static int brcmstb_gpio_priv_set_wake(struct brcmstb_gpio_priv *priv,
>>  {
>>  	int ret = 0;
>>  
>> -	/*
>> -	 * Only enable wake IRQ once for however many hwirqs can wake
>> -	 * since they all use the same wake IRQ.  Mask will be set
>> -	 * up appropriately thanks to IRQCHIP_MASK_ON_SUSPEND flag.
>> -	 */
>>  	if (enable)
>>  		ret = enable_irq_wake(priv->parent_wake_irq);
>>  	else
>> @@ -227,7 +242,17 @@ static int brcmstb_gpio_priv_set_wake(struct brcmstb_gpio_priv *priv,
>>  static int brcmstb_gpio_irq_set_wake(struct irq_data *d, unsigned int enable)
>>  {
>>  	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
>> -	struct brcmstb_gpio_priv *priv = brcmstb_gpio_gc_to_priv(gc);
>> +	struct brcmstb_gpio_bank *bank = gpiochip_get_data(gc);
>> +	struct brcmstb_gpio_priv *priv = bank->parent_priv;
>> +	u32 mask = BIT(brcmstb_gpio_hwirq_to_offset(d->hwirq, bank));
>> +
>> +	/* Do not do anything specific for now, suspend/resume callbacks will
>> +	 * configure the interrupt mask appropriately
>> +	 */
> 
> Please fix comment format (this is the network subsystem style).
> 

Thanks, force of habit ;).

>>
>> [snip] 
>> @@ -508,6 +511,99 @@ static int brcmstb_gpio_irq_setup(struct platform_device *pdev,
>> [...]
>> +static void brcmstb_gpio_shutdown(struct platform_device *pdev)
>> +{
>> +	/* Enable GPIO for S5 cold boot */
>> +	brcmstb_gpio_quiesce(&pdev->dev, 0);
> 
> nit: use false instead of 0 (it's a bool).
> 

Will do.

>> +}
>> +
>> +#ifdef CONFIG_PM_SLEEP
>> [snip]
>> +static int brcmstb_gpio_resume(struct device *dev)
>> +{
>> +	struct brcmstb_gpio_priv *priv = dev_get_drvdata(dev);
>> +	struct brcmstb_gpio_bank *bank;
>> +	u32 wake_mask = 0;
> 
> This isn't really being used as a mask, contrary to appearances.  It's
> just tracking whether any active IRQs were seen.  Please change to use a
> bool instead and adjust the name accordingly.
> 

I see your point, but I believe it is cleaner to use this to consolidate
the bit masks returned by each __brcmstb_gpio_get_active_irqs() call.
This allows a single test rather than a test per bank.

>> +
>> +	list_for_each_entry(bank, &priv->bank_list, node) {
>> +		wake_mask |= __brcmstb_gpio_get_active_irqs(bank);
>> +		brcmstb_gpio_bank_restore(priv, bank);
>> +	}
>> +
>> +	if (priv->parent_wake_irq && wake_mask)
>> +		pm_wakeup_event(dev, 0);
>> +
>> +	/* enable non-wake interrupt */
>> +	if (priv->parent_irq >= 0)
>> +		enable_irq(priv->parent_irq);
>> +
>> +	return 0;
>> +}
>> +
>> +#else
>> +#define brcmstb_gpio_suspend	NULL
>> +#define brcmstb_gpio_resume	NULL
>> +#endif /* CONFIG_PM_SLEEP */
>> +
>> +static const struct dev_pm_ops brcmstb_gpio_pm_ops = {
>> +	.suspend_noirq	= brcmstb_gpio_suspend,
>> +	.resume_noirq = brcmstb_gpio_resume,
>> +};
>> +
>>  static int brcmstb_gpio_probe(struct platform_device *pdev)
>>  {
>>  	struct device *dev = &pdev->dev;
>> @@ -517,7 +613,7 @@ static int brcmstb_gpio_probe(struct platform_device *pdev)
>>  	struct resource *res;
>>  	struct property *prop;
>>  	const __be32 *p;
>> -	u32 bank_width;
>> +	u32 bank_width, wake_mask = 0;
> 
> Same comment on wake_mask as for brcmstb_gpio_resume() above.
> 

Same response.

>>  	int num_banks = 0;
>>  	int err;
>>  	static int gpio_base;
>> @@ -617,6 +713,7 @@ static int brcmstb_gpio_probe(struct platform_device *pdev)
>>  		 * Mask all interrupts by default, since wakeup interrupts may
>>  		 * be retained from S5 cold boot
>>  		 */
>> +		wake_mask |= __brcmstb_gpio_get_active_irqs(bank);
>>  		gc->write_reg(reg_base + GIO_MASK(bank->id), 0);
>>  
>>  		err = gpiochip_add_data(gc, bank);
>> @@ -646,6 +743,9 @@ static int brcmstb_gpio_probe(struct platform_device *pdev)
>>  	dev_info(dev, "Registered %d banks (GPIO(s): %d-%d)\n",
>>  			num_banks, priv->gpio_base, gpio_base - 1);
>>  
>> +	if (priv->parent_wake_irq && wake_mask)
>> +		pm_wakeup_event(dev, 0);
> 
> Why is this called in probe?
> 

This allows proper wakeup accounting when waking from S5.

> Thanks,
> Gregory
> 

Thanks again for the review.  I will try to get a v2 out next week.
    Doug
