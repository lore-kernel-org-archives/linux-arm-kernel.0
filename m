From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Wed, 30 Jan 2013 00:13:28 +0800
Subject: [PATCH 03/10] gpio: pxa: avoid to use global irq base
In-Reply-To: <51065BFC.6000205@compulab.co.il>
References: <1358929554-32265-1-git-send-email-haojian.zhuang@linaro.org>
 <1358929554-32265-4-git-send-email-haojian.zhuang@linaro.org>
 <51065BFC.6000205@compulab.co.il>
Message-ID: <CAD6h2NSg6PBTT1Wwa7OJ1biRRB-uouQv3=0jhRXBfb80qen-wg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 January 2013 19:07, Igor Grinberg <grinberg@compulab.co.il> wrote:
> On 01/23/13 10:25, Haojian Zhuang wrote:
>> Avoid to use global irq_base in gpio-pxa driver. Define irq_base in each
>> pxa_gpio_chip instead. Then we can avoid to use macro PXA_GPIO_TO_IRQ() &
>> MMP_GPIO_TO_IRQ().
>>
>> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
>> ---
>>  arch/arm/mach-pxa/pxa25x.c |    2 +-
>>  arch/arm/mach-pxa/pxa27x.c |    2 +-
>>  drivers/gpio/gpio-pxa.c    |  142 ++++++++++++++++++++++----------------------
>>  include/linux/gpio-pxa.h   |    4 +-
>>  4 files changed, 77 insertions(+), 73 deletions(-)
>
> [...]
>
>> diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
>> index 8e66c6b..da6e7fd 100644
>> --- a/drivers/gpio/gpio-pxa.c
>> +++ b/drivers/gpio/gpio-pxa.c
>
> [...]
>
>> @@ -485,7 +452,7 @@ static int pxa_irq_domain_map(struct irq_domain *d, unsigned int irq,
>>       return 0;
>>  }
>>
>> -const struct irq_domain_ops pxa_irq_domain_ops = {
>> +static const struct irq_domain_ops pxa_irq_domain_ops = {
>>       .map    = pxa_irq_domain_map,
>>       .xlate  = irq_domain_xlate_twocell,
>>  };
>
> You should also move this out of CONFIG_OF as I don't think it is a dependency,
> and also otherwise you get the below...
>
>> @@ -529,14 +496,6 @@ static int pxa_gpio_probe_dt(struct platform_device *pdev)
>>       nr_gpios = nr_banks << 5;
>>       pxa_last_gpio = nr_gpios - 1;
>>
>> -     irq_base = irq_alloc_descs(-1, 0, nr_gpios, 0);
>> -     if (irq_base < 0) {
>> -             dev_err(&pdev->dev, "Failed to allocate IRQ numbers\n");
>> -             goto err;
>> -     }
>> -     domain = irq_domain_add_legacy(np, nr_gpios, irq_base, 0,
>> -                                    &pxa_irq_domain_ops, NULL);
>> -     pxa_gpio_of_node = np;
>>       return 0;
>>  err:
>>       iounmap(gpio_reg_base);
>> @@ -546,6 +505,56 @@ err:
>>  #define pxa_gpio_probe_dt(pdev)              (-1)
>>  #endif
>>
>> +static int pxa_init_gpio_chip(struct platform_device *pdev, int gpio_end,
>> +                           int (*set_wake)(unsigned int, unsigned int))
>> +{
>> +     int i, gpio, nbanks = gpio_to_bank(gpio_end) + 1;
>> +     struct pxa_gpio_chip *chips;
>> +
>> +     chips = devm_kzalloc(&pdev->dev, nbanks * sizeof(*chips), GFP_KERNEL);
>> +     if (chips == NULL) {
>> +             pr_err("%s: failed to allocate GPIO chips\n", __func__);
>> +             return -ENOMEM;
>> +     }
>> +
>> +     for (i = 0, gpio = 0; i < nbanks; i++, gpio += 32) {
>> +             struct gpio_chip *c = &chips[i].chip;
>> +
>> +             sprintf(chips[i].label, "gpio-%d", i);
>> +             chips[i].regbase = gpio_reg_base + BANK_OFF(i);
>> +             chips[i].set_wake = set_wake;
>> +
>> +             c->base  = gpio;
>> +             c->label = chips[i].label;
>> +
>> +             c->direction_input  = pxa_gpio_direction_input;
>> +             c->direction_output = pxa_gpio_direction_output;
>> +             c->get = pxa_gpio_get;
>> +             c->set = pxa_gpio_set;
>> +             c->to_irq = pxa_gpio_to_irq;
>> +#ifdef CONFIG_OF_GPIO
>> +             c->of_node = pxa_gpio_of_node;
>> +             c->of_xlate = pxa_gpio_of_xlate;
>> +             c->of_gpio_n_cells = 2;
>> +#endif
>> +
>> +             /* number of GPIOs on last bank may be less than 32 */
>> +             c->ngpio = (gpio + 31 > gpio_end) ? (gpio_end - gpio + 1) : 32;
>> +
>> +             chips[i].irq_base = irq_alloc_descs(-1, 0, c->ngpio, 0);
>> +             if (chips[i].irq_base < 0)
>> +                     return -EINVAL;
>> +             if (!irq_domain_add_legacy(pdev->dev.of_node, c->ngpio,
>> +                                        chips[i].irq_base, 0,
>> +                                        &pxa_irq_domain_ops, &chips[i]))
>
> if !CONFIG_OF, you get:
> drivers/gpio/gpio-pxa.c:479: error: 'pxa_irq_domain_ops' undeclared (first use in this function)
>
> Also, for !CONFIG_IRQ_DOMAIN, you get:
> drivers/gpio/gpio-pxa.c: In function 'pxa_init_gpio_chip':
> drivers/gpio/gpio-pxa.c:477: error: implicit declaration of function 'irq_domain_add_legacy'
>
> Should we select IRQ_DOMAIN for PXA?
> Will it work for other drivers?
>
We could use IRQ_DOMAIN. After all these patches are applied, there's
no CONFIG_IRQ_DOMAIN in pxa-gpio.c.
I tested the gpio driver on pxa910 (arch/mmp) w/wo CONFIG_OF. It works.

Thanks for your test. I'm sorry that I didn't do enough build test on
pxa. I'll fix all these issues.

>> +                     return -ENODEV;
>> +
>> +             gpiochip_add(c);
>> +     }
>> +     pxa_gpio_chips = chips;
>> +     return 0;
>> +}
>> +
>>  static int pxa_gpio_probe(struct platform_device *pdev)
>>  {
>>       struct pxa_gpio_chip *c;
>
> [...]
>
>
> --
> Regards,
> Igor.
