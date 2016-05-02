From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Mon, 2 May 2016 10:32:14 +0200
Subject: [PATCH v2 6/9] pinctrl: Add IRQ support to STM32 gpios
In-Reply-To: <CACRpkdbW133h_HNXhszzk2MdtMyrX5WBC_5GnqD5wrmo=yT27A@mail.gmail.com>
References: <1459436979-17275-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1459436979-17275-7-git-send-email-mcoquelin.stm32@gmail.com>
 <CACRpkdYLPWNQZgdFHVwLOZv+rS=bdERM9St5b0hVHTd_+ZJMKg@mail.gmail.com>
 <CALszF6CUFKAjzUpEh3pDtSDdJuFan1ON0Kcu_uKD_OX36kXOHQ@mail.gmail.com>
 <CACRpkdZXz8-UnOd6ee48AWqDX2X9Hvux=+ZQ7qdg6a4KVoArww@mail.gmail.com>
 <CALszF6D1nPJ8NVghWo27y1KABwN7-QQfjPTmgY2pgdY_8jjkTQ@mail.gmail.com>
 <CACRpkdbW133h_HNXhszzk2MdtMyrX5WBC_5GnqD5wrmo=yT27A@mail.gmail.com>
Message-ID: <CALszF6C7_9pZt-xywczinNFDppmwWmJjwrjVGyx6VL08yJFxgA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-04-30 13:32 GMT+02:00 Linus Walleij <linus.walleij@linaro.org>:
> On Fri, Apr 29, 2016 at 1:19 PM, Maxime Coquelin
> <mcoquelin.stm32@gmail.com> wrote:
>> It looks like this: http://pastebin.com/raw/cs2WiNKZ
>> You can directly check section 12.2.5 of the stm32f429 reference manual:
>> http://www2.st.com/resource/en/reference_manual/dm00031020.pdf
>
> Nice ASCII art, include that into the commit message :)

I will! :)

>
>> For example, we can imagine a board where gpioa0 is used SD's card detect,
>> and gpiob0 used to control a led.
>>
>> If we set the mux at request time, gpiob0 request may overwrite the mux
>> configuration set by gpioa0, whereas it is not used as interrupt.
>>
>> That is the reason why I did it in .to_irq().
>
> Well now I am even *more* convinced that this should not happen in
> .to_irq(). .to_irq() should not do *anything*.
>
> This needs to happen as part of the irqchip setting up the actual
> interrupt.
>
> And it seems the problem is that this driver does *not* define its
> own irqchip, but it *should*.
>
> What you want to do is implement an hierarchical irqdomain in your
> irqchip, which is what other drivers of this type are doing, see:
> drivers/gpio/gpio-xgene-sb.c
> irq_domain_create_hierarchy() is your friend.
>
>>> It should *also* be done in the set-up path for the irqchip
>>> side, if that line is used without any interaction with the
>>> gpio side of things.
>>
>> Actually, a line is either used by a GPIO, (exclusive) or another purpose.
>> In the case of a GPIO line, I think we should always go through the gpio.
>
> This is a textbook example of a hierarchichal irq domain I think.
>
>>> The point is that each IRQ that ever get used
>>> has a 1-to-1 relationship to a certain GPIO line, and if that
>>> relationship cannot be resolved from the irqchip side,
>>> something is wrong. The irqchip needs to enable the
>>> GPIO line it is backing to recieve interrupts without any
>>> requirements that .to_irq() have been called first.
>>
>> Actually, this is not a 1:1 relationship, as for example, exti0 can be connected
>> to either gpioa0, or gpiob0,..., or gpiok0.
>
> That is what hierarchical irqdomain is for.
>
> You should expose an irqchip from the gpio driver, that give you
> unique irq translations for *all* GPIO lines.
>
> Then, at runtime, if the hierarchical irqdomain cannot map
> (i.e. mux) the interrupt onto one of the available lines,
> you will get an error.

Thanks a lot for this valuable feedback.
I will have a look at hierachical irq domains, and hope to come back this week
with an implementation.

Regards,
Maxime
