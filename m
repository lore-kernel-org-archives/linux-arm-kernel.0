From: opendmb@gmail.com (Doug Berger)
Date: Thu, 19 Oct 2017 11:25:46 -0700
Subject: [PATCH 6/7] gpio: brcmstb: consolidate interrupt domains
In-Reply-To: <20171019075743.GA31645@kessel>
References: <20170930034057.15166-1-opendmb@gmail.com>
 <20170930034057.15166-7-opendmb@gmail.com>
 <CADtm3G5v6_BHwanRYvCq1y-8Hdmn7gxX3zoVHx2c7cOFL-pj+Q@mail.gmail.com>
 <61cb2c09-8078-d3ed-907b-64aff4553650@gmail.com>
 <20171019075743.GA31645@kessel>
Message-ID: <342fb581-e265-dfd7-ff0c-a2aff1202640@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/19/2017 12:57 AM, Gregory Fong wrote:
> Hi Doug,
> 
> On Wed, Oct 04, 2017 at 02:24:37PM -0700, Doug Berger wrote:
>> On 10/03/2017 08:03 PM, Gregory Fong wrote:
>>> On Fri, Sep 29, 2017 at 8:40 PM, Doug Berger <opendmb@gmail.com> wrote:
>>>> The GPIOLIB IRQ chip helpers were very appealing, but badly broke
>>>> the 1:1 mapping between a GPIO controller's device_node and its
>>>> interrupt domain.
>>>
>>> Out of curiosity, what sort of problems have you seen from this?
>>>
>>
>> [snip]
>>
>> When another device-tree node references a GPIO device as its interrupt
>> parent, the irq_create_of_mapping() function looks for the irq domain of
>> the GPIO device and since all bank irq domains reference the same GPIO
>> device node it always resolves to the irq domain of the first bank
>> regardless of which bank the number of the GPIO should resolve. This
>> domain can only map hwirq numbers 0-31 so interrupts on GPIO above that
>> can't be mapped by the device-tree.
> 
> Thanks for clarifying.  This would be great information to include in
> the commit message.
>

Will do.

>>
>>>>
>>>> This commit consolidates the per bank irq domains to a version
>>>> where we have one larger interrupt domain per GPIO controller
>>>> instance spanning multiple GPIO banks.
>>>
>>> This works (and is reminiscent to my initially submitted
>>> implementation at [1]), but I think it might make sense to keep as-is
>>> (using the gpiolib irqchip helpers), and instead allocate an irqchip
>>> fwnode per bank and use to_of_node() to set it as the of_node for the
>>> gpiochip before calling gpiochip_irqchip_add().  OTOH, that capability
>>> might go away...
>>>
>>> Linus, can you comment on the FIXME in gpiochip_irqchip_add_key() that
>>> says "get rid of this and use gpiochip->parent->of_node everywhere"?
>>> It seems like it would still be beneficial to be able to override the
>>> associated node for a gpiochip, since that's what's used for the
>>> irqdomain, but if that's going away, obviously we don't want to start
>>> using that now.
>>>
>>
>> Yes, this is effectively a reversion to an earlier implementation. I
>> produced an implementation based on the generic irqchip libraries, but
>> that was stripped from this submission when I discovered that no support
>> exists within the generic irqchip libraries for removal of domain
>> generic chips and we wanted to preserve the module support of this driver.
> 
> Considering this is heavily based on my initial implementation (several
> functions are exactly the same), it'd be nice to have some small
> attribution in the commit message. :-)
> 

Yes, I suppose I should have said "a reversion to your earlier
implementation" above :).  I'd be happy to to add your Signed-of-by if
you would like, but you'll have to let me know which email address to
use (the one in the original downstream submission or this one).

>>
>> It is conceivable that the current GPIO device-tree nodes could be
>> broken down into separate devices per bank, but it is believed that this
>> would only confuse things for users of the device as the concept
>> diverges from the concept expressed in device documentation.
> 
> OK, that sounds like a worse alternative.  And since these are all
> actually using the same parent IRQ, it does make sense to keep them all
> in the same IRQ domain.
> 
> 
> On Fri, Sep 29, 2017 at 08:40:56PM -0700, Doug Berger wrote:
>> [snip]
>> diff --git a/drivers/gpio/gpio-brcmstb.c b/drivers/gpio/gpio-brcmstb.c
>> index e2fff559c1ca..752a46ce3589 100644
>> --- a/drivers/gpio/gpio-brcmstb.c
>> +++ b/drivers/gpio/gpio-brcmstb.c
>> [snip]
>> @@ -77,12 +79,18 @@ brcmstb_gpio_get_active_irqs(struct brcmstb_gpio_bank *bank)
>>  	return status;
>>  }
>>  
>> +static int brcmstb_gpio_hwirq_to_offset(irq_hw_number_t hwirq,
>> +					struct brcmstb_gpio_bank *bank)
>> +{
>> +	return hwirq - (bank->gc.base - bank->parent_priv->gpio_base);
>> +}
>> +
>>  static void brcmstb_gpio_set_imask(struct brcmstb_gpio_bank *bank,
>>  		unsigned int offset, bool enable)
>>  {
>>  	struct gpio_chip *gc = &bank->gc;
>>  	struct brcmstb_gpio_priv *priv = bank->parent_priv;
>> -	u32 mask = gc->pin2mask(gc, offset);
>> +	u32 mask = BIT(brcmstb_gpio_hwirq_to_offset(offset, bank));
> 
> Consider renaming "offset" to "hwirq".
> 

I could do that, but I was just using the existing argument so now you
are editing yourself ;).  I'll think about it.

>>  	u32 imask;
>>  	unsigned long flags;
>>  
>> @@ -96,6 +104,17 @@ static void brcmstb_gpio_set_imask(struct brcmstb_gpio_bank *bank,
>>  	spin_unlock_irqrestore(&gc->bgpio_lock, flags);
>>  }
>>  
>> +static int brcmstb_gpio_to_irq(struct gpio_chip *gc, unsigned gc_offset)
>> +{
>> +	struct brcmstb_gpio_priv *priv = brcmstb_gpio_gc_to_priv(gc);
>> +	/* gc_offset is relative to this gpio_chip; want real offset */
>> +	int offset = gc_offset + (gc->base - priv->gpio_base);
> 
> Consider renaming "gc_offset" to "offset" and "offset" to "hwirq" to
> keep things consistent.
> 

Sounds better.  I'll consider that too.

>> +
>> +	if (offset >= priv->num_gpios)
>> +		return -ENXIO;
>> +	return irq_create_mapping(priv->irq_domain, offset);
>> +}
>> +
>>  
>> [snip]
>>
>> @@ -226,18 +245,19 @@ static irqreturn_t brcmstb_gpio_wake_irq_handler(int irq, void *data)
>>  static void brcmstb_gpio_irq_bank_handler(struct brcmstb_gpio_bank *bank)
>>  {
>>  	struct brcmstb_gpio_priv *priv = bank->parent_priv;
>> -	struct irq_domain *irq_domain = bank->gc.irqdomain;
>> +	struct irq_domain *domain = priv->irq_domain;
>> +	int hwbase = bank->gc.base - priv->gpio_base;
>>  	unsigned long status;
>> +	unsigned int irq;
>>  
>>  	while ((status = brcmstb_gpio_get_active_irqs(bank))) {
>> -		int bit;
>> -
>> -		for_each_set_bit(bit, &status, 32) {
>> -			if (bit >= bank->width)
>> +		for_each_set_bit(irq, &status, 32) {
>> +			if (irq >= bank->width)
>>  				dev_warn(&priv->pdev->dev,
>>  					 "IRQ for invalid GPIO (bank=%d, offset=%d)\n",
>> -					 bank->id, bit);
>> -			generic_handle_irq(irq_find_mapping(irq_domain, bit));
>> +					 bank->id, irq);
>> +			irq = irq_linear_revmap(domain, irq + hwbase);
>> +			generic_handle_irq(irq);
> 
> I'm not a fan of the change to use "irq" to mean several different
> things in this function.  How about this instead?
> 
> static void brcmstb_gpio_irq_bank_handler(struct brcmstb_gpio_bank *bank)
> {
> 	struct brcmstb_gpio_priv *priv = bank->parent_priv;
> 	struct irq_domain *domain = priv->irq_domain;
> 	int hwbase = bank->gc.base - priv->gpio_base;
> 	unsigned long status;
> 
> 	while ((status = brcmstb_gpio_get_active_irqs(bank))) {
> 		int offset;
> 
> 		for_each_set_bit(offset, &status, 32) {
> 			if (offset >= bank->width)
>  				dev_warn(&priv->pdev->dev,
>  					 "IRQ for invalid GPIO (bank=%d, offset=%d)\n",
> 					 bank->id, offset);
> 			generic_handle_irq(irq_linear_revmap(domain, offset + hwbase));
> 
> 

That is more or less where I started, but the "ugliness" began creeping
in with the need to wrap that last line at 80 characters. It seemed
silly to declare two separate ints for transitory purposes just to make
the naming clearer, but I'll revisit it too.

>>  		}
>>  	}
>>  }
>> [snip] 
>>
> 
> The rest looks good.
> 
> Thanks,
> Gregory
> 

Thanks for taking the time and the thoughtful feedback,
    Doug
