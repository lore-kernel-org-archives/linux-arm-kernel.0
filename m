From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Mon, 18 Feb 2013 20:10:10 +0800
Subject: [PATCH v3 11/12] gpio: pxa: discard irq base in pxa_gpio_chip
In-Reply-To: <5121FDFC.2010107@compulab.co.il>
References: <1361164358-5845-1-git-send-email-haojian.zhuang@linaro.org>
 <1361164358-5845-12-git-send-email-haojian.zhuang@linaro.org>
 <5121FDFC.2010107@compulab.co.il>
Message-ID: <CAD6h2NT+Qq-uD9ctXWj9LK0pZFb6NsoA0-ZT611DthhMYy4NKg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 February 2013 18:10, Igor Grinberg <grinberg@compulab.co.il> wrote:
> On 02/18/13 07:12, Haojian Zhuang wrote:
>> Discard irq_base in struct pxa_gpio_chip. Use irq_domain instead.
>>
>> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
>> ---
>>  drivers/gpio/gpio-pxa.c |   91 +++++++++++++++++++++++------------------------
>>  1 file changed, 44 insertions(+), 47 deletions(-)
>
> [...]
>
>>
>> diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
>> index 35cdb23..d45cb57 100644
>> --- a/drivers/gpio/gpio-pxa.c
>> +++ b/drivers/gpio/gpio-pxa.c
>> @@ -66,8 +66,8 @@ int pxa_last_gpio;
>>
>>  struct pxa_gpio_chip {
>>       struct gpio_chip chip;
>> +     struct irq_domain *domain;
>>       void __iomem    *regbase;
>> -     unsigned int    irq_base;
>>       bool            inverted;
>>       bool            gafr;
>>       char label[10];
>> @@ -147,17 +147,7 @@ static int pxa_gpio_to_irq(struct gpio_chip *gc, unsigned offset)
>>       struct pxa_gpio_chip *chip = NULL;
>>
>>       chip = container_of(gc, struct pxa_gpio_chip, chip);
>> -     return chip->irq_base + offset;
>> -}
>> -
>> -int pxa_irq_to_gpio(struct irq_data *d)
>> -{
>> -     struct pxa_gpio_chip *chip;
>> -     int gpio;
>> -
>> -     chip = (struct pxa_gpio_chip *)d->domain->host_data;
>> -     gpio = d->irq - chip->irq_base + chip->chip.base;
>> -     return gpio;
>> +     return irq_create_mapping(chip->domain, offset);
>>  }
>
> You remove the pxa_irq_to_gpio() function here, but we still have:
> $ grep -nr pxa_irq_to_gpio *
> arch/arm/mach-pxa/pxa27x.c:368: int gpio = pxa_irq_to_gpio(d);
> arch/arm/mach-pxa/pxa25x.c:292: int gpio = pxa_irq_to_gpio(d);
> include/linux/gpio-pxa.h:16:extern int pxa_irq_to_gpio(struct irq_data *d);
>
> And this in turn breaks the compilation for example with error:
> arch/arm/mach-pxa/built-in.o: In function `pxa27x_set_wake':
> em-x270.c:(.text+0x1298): undefined reference to `pxa_irq_to_gpio'
> make[1]: *** [vmlinux] Error 1
> make: *** [sub-make] Error 2
>
>
> --
> Regards,
> Igor.

Thank you.

Please drop this patch (11/12) for your test. Whatever it's DT or non-DT mode,
gpio driver should work without this patch.

Regards
Haojian
