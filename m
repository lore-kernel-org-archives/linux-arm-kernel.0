From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 25 Mar 2013 18:08:14 +0800
Subject: [PATCH 1/8] pinctrl: sirf: convert to linear irq domain
In-Reply-To: <201303250933.16921.arnd@arndb.de>
References: <1363779679-16880-1-git-send-email-arnd@arndb.de>
 <1363779679-16880-2-git-send-email-arnd@arndb.de>
 <CAGsJ_4wR8UaSZ6NVANw3CTj+w6=41oxJRkffaJhOh4HBW8e3zg@mail.gmail.com>
 <201303250933.16921.arnd@arndb.de>
Message-ID: <CAGsJ_4y74yphbxerqWsF8Xs_5cH5BxPOy3djF5jqY0oRAiW6ng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/3/25, Arnd Bergmann <arnd@arndb.de>:
> On Monday 25 March 2013, Barry Song wrote:
>> > @@ -1770,9 +1767,8 @@ static int sirfsoc_gpio_probe(struct device_node
>> > *np)
>> >                         goto out;
>> >                 }
>> >
>> > -               bank->domain = irq_domain_add_legacy(np,
>> > SIRFSOC_GPIO_BANK_SIZE,
>> > -                       SIRFSOC_GPIO_IRQ_START + i *
>> > SIRFSOC_GPIO_BANK_SIZE, 0,
>> > -                       &sirfsoc_gpio_irq_simple_ops, bank);
>> > +               bank->domain = irq_domain_add_linear(np,
>> > SIRFSOC_GPIO_BANK_SIZE,
>> > +
>> > &sirfsoc_gpio_irq_simple_ops, bank);
>>
>> this line breaks the gpio/irq mapping and gpio irq_domain:
>>
>>        printk("%s gpio_to_irq: %d %d %d\n", __func__,
>>                gpio_to_irq(0), gpio_to_irq(32), gpio_to_irq(65));
>>
>> result:
>> sdhci_sirf_probe gpio_to_irq: 0 0 0
>>
>> for the old codes, it works:
>> sdhci_sirf_probe gpio_to_irq: 128 160 193
>
> Does it work if you add the hunk below?
>
> I think the problem is that with irq_domain_add_linear, we don't create
> a mapping for all the interrupts right away.
>
> 	Arnd
>
> diff --git a/drivers/pinctrl/pinctrl-sirf.c
> b/drivers/pinctrl/pinctrl-sirf.c
> index d02498b..5f031ca 100644
> --- a/drivers/pinctrl/pinctrl-sirf.c
> +++ b/drivers/pinctrl/pinctrl-sirf.c
> @@ -1347,7 +1347,7 @@ static inline int sirfsoc_gpio_to_irq(struct gpio_chip
> *chip, unsigned offset)
>  	struct sirfsoc_gpio_bank *bank = container_of(to_of_mm_gpio_chip(chip),
>  		struct sirfsoc_gpio_bank, chip);
>
> -	return irq_find_mapping(bank->domain, offset);
> +	return irq_create_mapping(bank->domain, offset);

yes. this one works now. the only problem is
drivers/irqchip/irq-sirfsoc.c  still fails by irq_domain_add_linear().
the old irq_domain_add_legacy() works for
drivers/irqchip/irq-sirfsoc.c.

-barry
