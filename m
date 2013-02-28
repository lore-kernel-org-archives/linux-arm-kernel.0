From: b-cousson@ti.com (Benoit Cousson)
Date: Thu, 28 Feb 2013 14:04:32 +0100
Subject: [PATCH 3/5] gpio/omap: Add DT support to GPIO driver
In-Reply-To: <CACRpkdabXa8tXNeGRPntvY9cx4XWCa7XaEXHmVREeWN-x793ZA@mail.gmail.com>
References: <1329321854-24490-1-git-send-email-b-cousson@ti.com>
 <1329321854-24490-4-git-send-email-b-cousson@ti.com>
 <CACRpkdabXa8tXNeGRPntvY9cx4XWCa7XaEXHmVREeWN-x793ZA@mail.gmail.com>
Message-ID: <512F55E0.8050501@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ Jon who was brave enough to take over the OMAP GPIO  driver
+ New email address for Kevin since he is no longer at TI :-(.
- Tarun that left TI but I don't have his new email

Hi Linus,

On 02/28/2013 12:41 AM, Linus Walleij wrote:
> On Wed, Feb 15, 2012 at 5:04 PM, Benoit Cousson <b-cousson@ti.com> wrote:

Gosh! That's pretty old stuff :-)

>> @@ -52,7 +55,8 @@ struct gpio_bank {
>>         struct list_head node;
>>         void __iomem *base;
>>         u16 irq;
>> -       u16 virtual_irq_start;
>> +       int irq_base;
>> +       struct irq_domain *domain;
> 
> This seems wrong. IRQ domains are used to avoid keeping track of
> irq base offsets. I would even say it's the whole point of irq domains.

Well at that time, it was not the only point. We were trying to boot
with DT, and for that irq_domain was mandatory. At the very same time,
Grant was cleaning and consolidating the whole irq_domain
infrastructure, and thus most of the following API were not really
stabilized or even available.

So, this idea was to avoid any regression while allowing DT boot... And
obviously a lot of stuff happened since that good old time.

>> @@ -669,7 +673,7 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
>>                 if (!isr)
>>                         break;
>>
>> -               gpio_irq = bank->virtual_irq_start;
>> +               gpio_irqkhilman at ti.com = bank->irq_base;
>>                 for (; isr != 0; isr >>= 1, gpio_irq++) {
>>                         gpio_index = GPIO_INDEX(bank, irq_to_gpio(gpio_irq));
>>
> 
> Use irq_find_mapping(irqdomain, hwirq) in this function.
> 
> 
>> @@ -915,7 +919,7 @@ static int gpio_2irq(struct gpio_chip *chip, unsigned offset)
>>         struct gpio_bank *bank;
>>
>>         bank = container_of(chip, struct gpio_bank, chip);
>> -       return bank->virtual_irq_start + offset;
>> +       return bank->irq_base + offset;
> 
> Use irq_create_mapping() in this function.
> 
>> +       bank->irq_base = irq_alloc_descs(-1, 0, bank->width, 0);
>> +       if (bank->irq_base < 0) {
>> +               dev_err(dev, "Couldn't allocate IRQ numbers\n");
>> +               return -ENODEV;
>> +       }
>> +
>> +       bank->domain = irq_domain_add_legacy(node, bank->width, bank->irq_base,
>> +                                            0, &irq_domain_simple_ops, NULL);
> 
> Use irq_domain_add_simple() and the descs will be allocated for
> you as part of the domain creation, when using a pre-fixed base.

Funny, that API was removed while I was writing this patch, and is now
back in town...

> If you fix this I suspect the device tree discussion also will fix
> itself :-)

Mmm, I hope it is the case, but I'm not sure it will be that easy :-)

Thanks,
Benoit
