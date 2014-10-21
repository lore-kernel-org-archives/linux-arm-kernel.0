From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 21 Oct 2014 11:08:15 +0200
Subject: [PATCH v2 2/4] ARM: mediatek: Add Pinctrl/GPIO driver for mt8135.
In-Reply-To: <1412591741.19977.527.camel@mtksdaap41>
References: <1411443545-24951-1-git-send-email-srv_hongzhou.yang@mediatek.com>
 <1411443545-24951-3-git-send-email-srv_hongzhou.yang@mediatek.com>
 <CACRpkdYY7e0OQL1YTEASxJw7E0FPAyOrPi0g93A9aRbfss0Vpw@mail.gmail.com>
 <1412591741.19977.527.camel@mtksdaap41>
Message-ID: <CACRpkdZ7XiQHACQ2jhEGeTR6V7dJcX2jR40yPqLgLONnka9zVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 6, 2014 at 12:35 PM, Joe.C <yingjoe.chen@mediatek.com> wrote:
> On Thu, 2014-10-02 at 15:38 +0200, Linus Walleij wrote:
> (...)
>> > +static struct mt_desc_function *
>> > +mt_pctrl_desc_find_irq_by_name(struct mt_pinctrl *pctl,
>> > +                                        const char *pin_name)
>>
>> Why is it called *find_irq_by_name if it returns a
>> function? Seems more like find_function_from_pin_name
>> really.
>>
>> And I don't know if that is such a good idea.
>
> In 8135 & 6589, not every gpio pin support interrupt function. For those
> support interrupt, it will have a EINT function and use a different EINT
> offset number.
> In 8127, EINT support is merged into gpio function, but they still use a
> different EINT offset number.
(...)
> This function is used to find EINT function for the pin. Maybe we should
> name this mt_pctrl_desc_find_irq_function_from_name to make it more
> clear.

OK such translation is usually the work of the irqdomain. Is there
some reason why it is not used in this driver then?

>> > +                       for (j = 0; j < PINMUX_MAX_VAL; j++) {
>> > +                               if (func->irqnum != 255)
>>
>> So why does it end at 255? Seems pretty arbitrary.
>
> If a function support interrupt, we put its interrupt number in irqnum,
> otherwise it will be 255. Does it make it more clear if we use macro
> name MT_NO_EINT_SUPPORT?

Yes.

> We use a different interrupt number than gpio pin number. I think it
> more nature to use EINT interrupt number as the hw_number, so I think we
> can't use gpiochip_irqchip_add and we still need to provide our
> own .to_irq mapping function.

You should be able to use irqdomain to translate I think.

> While it might still be possible to generate group+function array based
> on datasheet, IMHO the structure will be more complicate and harder to
> prove the correctness.
>
> So we choose to use descriptor array + macros in device tree because it
> is quite simple to generate the pin descriptors and easier to notice if
> there's error in device tree pin groups description.

There is a parallel discussion on this, or two maybe.

The number of pin control bindings is exploding and I need to
push back.

Please help out defining generic pin control bindings for this
use case and we can move forward.

Yours,
Linus Walleij
