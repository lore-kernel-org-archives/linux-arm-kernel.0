From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Fri, 22 Feb 2013 09:34:11 +0800
Subject: [PATCH v3 10/12] gpio: pxa: add irq base in platform data
In-Reply-To: <CACRpkdbgJdmcTm86UTWsMw2yPv005=1c8AmAxfmDSrEoSWk-bg@mail.gmail.com>
References: <1361164358-5845-1-git-send-email-haojian.zhuang@linaro.org>
 <1361164358-5845-11-git-send-email-haojian.zhuang@linaro.org>
 <CACRpkdbgJdmcTm86UTWsMw2yPv005=1c8AmAxfmDSrEoSWk-bg@mail.gmail.com>
Message-ID: <CAD6h2NSoUeEmPujuFZcnET7RAaQK9sE6HK1pROfrHnmSNfS65Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 February 2013 03:12, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Mon, Feb 18, 2013 at 6:12 AM, Haojian Zhuang
> <haojian.zhuang@linaro.org> wrote:
>
>> Macro PXA_GPIO_TO_IRQ() & MMP_GPIO_TO_IRQ() is used in machine driver
>> without DT. Although we're allocating irq descriptions dynamically,
>> it may break machine drivers without DT. Append pdata->irq_base.
>> If irq_base is valid, allocate irq descriptions from irq_base.
>>
>> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
> (...)
>> -               chips[i].irq_base = irq_alloc_descs(-1, 0, gc->ngpio, 0);
>> +               if (pdata->irq_base)
>> +                       irq_base = pdata->irq_base + gpio;
>> +               else
>> +                       irq_base = -1;
>> +               chips[i].irq_base = irq_alloc_descs(irq_base, 0, gc->ngpio, 0);
>>                 if (chips[i].irq_base < 0)
>>                         return -EINVAL;
>>                 if (!irq_domain_add_legacy(pdev->dev.of_node, gc->ngpio,
>
> In this case, when you want to pass a base IRQ, use
> irq_domain_add_simple().
>
> The descriptor allocation will still be unnecessary.
>
> Yours,
> Linus Walleij

Yes, thank you. Let me clean the irq usage after this patch series.

Regards
Haojian
