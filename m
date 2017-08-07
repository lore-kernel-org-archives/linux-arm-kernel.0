From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 7 Aug 2017 22:50:50 +0900
Subject: [PATCH] gpio: uniphier: add UniPhier GPIO controller driver
In-Reply-To: <CACRpkdZWxjwDnVy5f2rLAWs=+T=5SnwyU8dz1FW1eg8dk8JN_Q@mail.gmail.com>
References: <1501758371-25316-1-git-send-email-yamada.masahiro@socionext.com>
 <CACRpkdZWxjwDnVy5f2rLAWs=+T=5SnwyU8dz1FW1eg8dk8JN_Q@mail.gmail.com>
Message-ID: <CAK7LNAT4FvsX2-hYrKYmrftEZZb_RZOrfZoKWvR8hopt9jT8-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,


2017-08-07 21:42 GMT+09:00 Linus Walleij <linus.walleij@linaro.org>:
> On Thu, Aug 3, 2017 at 1:06 PM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>
>> This GPIO controller device is used on UniPhier SoCs.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> (...)
>> +static const u32 uniphier_gpio_irq_parent_hwirqs[] = {
>> +       80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95,
>> +       186, 187, 188, 189, 190, 249, 250, 251,
>> +};
> (..)
>> +               /* parent is UniPhier AIDET */
>> +               parent_fwspec.fwnode = domain->parent->fwnode;
>> +               parent_fwspec.param_count = 2;
>> +               parent_fwspec.param[0] = uniphier_gpio_irq_parent_hwirqs[hwirq];
>> +               parent_fwspec.param[1] = type;
>> +
>> +               ret = irq_domain_alloc_irqs_parent(domain, virq, 1,
>> +                                                  &parent_fwspec);
>
> This is not right.
>
> That parent IRQ needs to come from the device tree, not from a static array
> like this, and it is definately to use hierarchical irqdomain.
>
> Please look at similar drivers merged recently for inspiration:
> gpio/gpio-xgene-sb.c
> pinctrl/stm32/pinctrl-stm32.c
>

I was waiting for such a comment!


I was actually tackling to specify IRQ-mapping
with "interrupts" property.

Adding "interrupts" property in DT causes
of_pupulate_default_populate() to assign virtual IRQ numbers
before driver probing.  So it does not work well with IRQ domain hierarchy.


I send a question:
https://lkml.org/lkml/2017/7/6/758

But, I did not get any answer.

So, I thought the only solution is to specify the IRQ-remapping
somehow in the driver.





For gpio/gpio-xgene-sb.c, the driver code seems suspicious.


As you see xgene_gpio_sb_probe(),
it uses the first entry of "interrupts" for just getting the ->parent_irq_base.
The assigned virtual IRQs will not be used.


      ret = platform_get_irq(pdev, 0);
      if (ret > 0) {
              priv->parent_irq_base = irq_get_irq_data(ret)->hwirq;
              parent_domain = irq_get_irq_data(ret)->domain;
      }



Then, xgene_gpio_sb_domain_alloc() allocates different virtual IRQs
expecting a particular binding between the parent.

    parent_fwspec.fwnode = domain->parent->fwnode;
    if (is_of_node(parent_fwspec.fwnode)) {
            parent_fwspec.param_count = 3;
            parent_fwspec.param[0] = 0;/* SPI */
            /* Skip SGIs and PPIs*/
            parent_fwspec.param[1] = hwirq + priv->parent_irq_base - 32;
            parent_fwspec.param[2] = fwspec->param[1];
    } else if (is_fwnode_irqchip(parent_fwspec.fwnode)) {
            parent_fwspec.param_count = 2;
            parent_fwspec.param[0] = hwirq + priv->parent_irq_base;
            parent_fwspec.param[1] = fwspec->param[1];
    } else
            return -EINVAL;



It uses ->parent_irq_base derived from DT,
but other parts are really hard-coded.



For pinctrl/stm32/pinctrl-stm32.c,
I do not see "interrupts", so it just straight maps the irq numbers.





-- 
Best Regards
Masahiro Yamada
