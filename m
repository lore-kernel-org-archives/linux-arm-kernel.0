From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Fri, 15 Feb 2013 01:10:30 +0800
Subject: [PATCH v8 03/12] gpio: pl061: allocate irq dynamically
In-Reply-To: <CACRpkdaaiVzg2F2R51TTL4=nt_VDWf0bFaJF2SzysdT8FouJAQ@mail.gmail.com>
References: <1360602659-4774-1-git-send-email-haojian.zhuang@linaro.org>
 <1360602659-4774-4-git-send-email-haojian.zhuang@linaro.org>
 <CACRpkdaaiVzg2F2R51TTL4=nt_VDWf0bFaJF2SzysdT8FouJAQ@mail.gmail.com>
Message-ID: <CAD6h2NTVCLR2oQEoHyWVt9rzXtbUuYaYfqaC1K8GmwRGW_AFSg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 February 2013 22:04, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Mon, Feb 11, 2013 at 6:10 PM, Haojian Zhuang
> <haojian.zhuang@linaro.org> wrote:
>
> We don't convert drivers to irqdomain without actually *using*
> the irqdomain. I don't know where this pattern comes from,
> but I'm suspicious about patch sets that just focus on enabling
> DT functionality without considering irqdomain stuff as a concept
> of its own.
>
> The biggest problem with this patch is what is missing from it:
>
> - irq_base shall be *deleted* from struct pl061_gpio
> - instead a struct irqdomain  * shall be stored for offsetting IRQs
> - everywhere chip->irq_base is referenced, use irq_find_mapping()
> - In pl061_to_irq, irq_create_mapping() shall be used, so it will
>   allocate a descriptor even if we're using the driver with
>   SPARSE_IRQ and a linear domain.
>
> Look at e.g. gpio-langwell.c for guidance.
>
>> +       chip->irq_base = irq_alloc_descs(chip->irq_base, 0, PL061_GPIO_NR, 0);
>> +       if (chip->irq_base < 0)
>> +               return chip->irq_base;
>> +       if (!irq_domain_add_legacy(adev->dev.of_node, PL061_GPIO_NR,
>> +                                  chip->irq_base, 0, &pl061_domain_ops, chip))
>>                 return -ENODEV;
>
> Instead of the above, please use:
>
> chip->irqdomain = irq_domain_add_simple(adev->dev.of_node,
>                                          PL061_GPIO_NR,
>                                          chip->irq_base,
>                                          &pl061_domain_ops,
>                                          chip);
>
> Notice that I don't throw the domain away after creation either...
>
> This call will allocate descriptors for you as long as the
> irq_base > 0, which it should be, since 0 is NO_IRQ.
>
> It make things easier the day you start using a purely
> dynamic approach.
>
> Yours,
> Linus Walleij

Thank you. I'll update it.

Regards
Haojian
