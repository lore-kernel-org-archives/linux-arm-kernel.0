From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 1 Sep 2017 00:36:27 +0900
Subject: [PATCH v3] gpio: uniphier: add UniPhier GPIO controller driver
In-Reply-To: <CACRpkdYG3BFhhpouwAkQN+x0YpC5EhsVhTkqyuNdRd26Ne-r9A@mail.gmail.com>
References: <1503418601-9728-1-git-send-email-yamada.masahiro@socionext.com>
 <CACRpkdYG3BFhhpouwAkQN+x0YpC5EhsVhTkqyuNdRd26Ne-r9A@mail.gmail.com>
Message-ID: <CAK7LNAQz_mGUo71-FvchPrp_B6+A+74t=LDaZdGE7Bzxpeh9Mg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,


2017-08-31 22:41 GMT+09:00 Linus Walleij <linus.walleij@linaro.org>:
> On Tue, Aug 22, 2017 at 6:16 PM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>
>> This GPIO controller device is used on UniPhier SoCs.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> ---
>>
>> Changes in v3:
>>   - Add .irq_set_affinity() hook
>>   - Use irq_domain_create_hierarchy() instead of legacy
>>     irq_domain_add_hierarchy().
>
> This is getting better and better.
>
>> +static const u32 uniphier_gpio_irq_parent_hwirqs[] = {
>> +       48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63,
>> +       154, 155, 156, 157, 158, 217, 218, 219,
>> +};
>
> This array which is used when allocating the hierarchical domain
> looks like configuration data. Why is it not in the device tree?


The same comment as in v1.

There is no systematic way to map hwirqs to the parent
for irqdomain hierarchy:
https://lkml.org/lkml/2017/7/6/758



If you see irqchip drivers using domain hierarchy,
many drivers hard-code

    parent_fwspec.param_count = 3;

without parsing #interrupt-cells property of the parent.

It is hard-coded configuration data, isn't it?



The array of parent hwirqs is more or less SoC specific data.


This is just a matter of taste, but
if you like, I can move the array to the SoC data associated
with compatible.


.ngpio is already associated with compatible,
so adding more data would not hurt...


static const u32 uniphier_pxs2_gpio_irqs[] = {
        48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63,
        154, 155, 156, 157, 158, 217, 218, 219,
};

static const struct uniphier_gpio_socdata uniphier_pxs2_gpio_data = {
        .ngpio = 232,
        .irqs = uniphier_pxs2_gpio_irqs,
        .nirqs = ARRAY_SIZE(uniphier_pxs2_gpio_irqs),
};





-- 
Best Regards
Masahiro Yamada
