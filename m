From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 16 Jul 2015 16:48:20 +0900
Subject: [PATCH v3] gpio: UniPhier: add driver for UniPhier GPIO controller
In-Reply-To: <CACRpkdbBfidn_otxzSV-8HMv2AuD-htUbcRHZ8n9CHAUO=TB9w@mail.gmail.com>
References: <1436841787-7734-1-git-send-email-yamada.masahiro@socionext.com>
 <CACRpkdYaAMw5U3pctf96j0QpY2Qf+e=LX740F0okCmVU6pXkhA@mail.gmail.com>
 <CAK7LNAQ+_ynWT944fPZsHCzMBLtfNu5AnppzaOxNgPSBTvj_tw@mail.gmail.com>
 <CACRpkdZK41P-1JQsL6RiywqFEUj6=g5xJMKy86wDdp6BxLJNzQ@mail.gmail.com>
 <CAK7LNASd9z99RBmUgLVEM1WuLNSzGFM8qzrHwDf58tgGDy2SAw@mail.gmail.com>
 <CACRpkdbBfidn_otxzSV-8HMv2AuD-htUbcRHZ8n9CHAUO=TB9w@mail.gmail.com>
Message-ID: <CAK7LNAQH+Ge61+MJo2rLmjCBJRnYviT3LyCo0nrOPRQL+RtK2g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

2015-07-16 16:42 GMT+09:00 Linus Walleij <linus.walleij@linaro.org>:
> On Thu, Jul 16, 2015 at 9:35 AM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>> 2015-07-16 16:07 GMT+09:00 Linus Walleij <linus.walleij@linaro.org>:
>
>>>> ngpio == 248 for some SoCs,
>>>> and ngpio == 136 for some, etc.
>>>
>>> That is the wrong way to handle different SoC. That should be handled
>>> by different compatible strings, and then you select the number of GPIOs
>>> for the version corresponding to that compatibe string.
>>>
>>>>>> +static const struct of_device_id uniphier_gpio_match[] = {
>>>>>> +       { .compatible = "socionext,uniphier-gpio" },
>>>>>> +       { /* sentinel */ }
>>>>>> +};
>>>
>>> i.e. you should use the .data field of of_device_id to carry variant-specific
>>> information.
>>
>>
>> Currently, I want to use this driver on 7 SoCs
>>
>> PH1-sLD3:    ngpio == 136
>> PH1-LD4 :    ngpio == 136
>> PH1-Pro4:    ngpio == 248
>> PH1-sLD8:    ngpio == 136
>> PH1-Pro5:    ngpio == 248
>> ProXstream2: ngpio == 232
>> PH1-LD6b:    ngpio == 232
>>
>> So, should I describe the OF match table like this?
>>
>> static const struct of_device_id uniphier_gpio_match[] = {
>>        { .compatible = "socionext,ph1-sld3-gpio"       .data = (void *)136 },
>>        { .compatible = "socionext,ph1-ld4-gpio"        .data = (void *)136 },
>>        { .compatible = "socionext,ph1-pro4-gpio"       .data = (void *)248 },
>>        { .compatible = "socionext,ph1-sld8-gpio"       .data = (void *)136 },
>>        { .compatible = "socionext,ph1-pro5-gpio"       .data = (void *)248 },
>>        { .compatible = "socionext,proxstream2-gpio",   .data = (void *)232 },
>>        { .compatible = "socionext,ph1-ld6b-gpio",      .data = (void *)232 },
>>        { /* sentinel */ }
>> };
>
> Yes.
>
>> One disadvantage for this way is that
>> I need to touch the driver file every time I add a new SoC support.
>
> That is appropriate since it is a new hardware. This is the same as
> the fact that we touch the kernel to add new USB IDs and PCI IDs
> every time a new hardware comes out for x86, we should know
> what hardware we are toying with.
>
> Since you seem to have a pin controller in parallel anyways I see
> it as natural to do this at the same time as you do that anyways.
>

OK, I will do it in v4.







-- 
Best Regards
Masahiro Yamada
