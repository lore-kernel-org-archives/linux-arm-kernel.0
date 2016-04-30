From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 30 Apr 2016 13:32:19 +0200
Subject: [PATCH v2 6/9] pinctrl: Add IRQ support to STM32 gpios
In-Reply-To: <CALszF6D1nPJ8NVghWo27y1KABwN7-QQfjPTmgY2pgdY_8jjkTQ@mail.gmail.com>
References: <1459436979-17275-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1459436979-17275-7-git-send-email-mcoquelin.stm32@gmail.com>
 <CACRpkdYLPWNQZgdFHVwLOZv+rS=bdERM9St5b0hVHTd_+ZJMKg@mail.gmail.com>
 <CALszF6CUFKAjzUpEh3pDtSDdJuFan1ON0Kcu_uKD_OX36kXOHQ@mail.gmail.com>
 <CACRpkdZXz8-UnOd6ee48AWqDX2X9Hvux=+ZQ7qdg6a4KVoArww@mail.gmail.com>
 <CALszF6D1nPJ8NVghWo27y1KABwN7-QQfjPTmgY2pgdY_8jjkTQ@mail.gmail.com>
Message-ID: <CACRpkdbW133h_HNXhszzk2MdtMyrX5WBC_5GnqD5wrmo=yT27A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 29, 2016 at 1:19 PM, Maxime Coquelin
<mcoquelin.stm32@gmail.com> wrote:
> 2016-04-29 10:53 GMT+02:00 Linus Walleij <linus.walleij@linaro.org>:
>> On Tue, Apr 19, 2016 at 11:04 AM, Maxime Coquelin
>> <mcoquelin.stm32@gmail.com> wrote:
>>> 2016-04-08 11:43 GMT+02:00 Linus Walleij <linus.walleij@linaro.org>:
>>>> On Thu, Mar 31, 2016 at 5:09 PM, Maxime Coquelin
>>>> <mcoquelin.stm32@gmail.com> wrote:
>>>>
>>>>> +static int stm32_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
>>>>> +{
>>>>> +       struct stm32_pinctrl *pctl = dev_get_drvdata(chip->parent);
>>>>> +       struct stm32_gpio_bank *bank = gpiochip_get_data(chip);
>>>>> +       unsigned int irq;
>>>>> +
>>>>> +       regmap_field_write(pctl->irqmux[offset], bank->range.id);
>>>>
>>>> No. You must implement the irqchip and GPIO controllers to
>>>> be orthogonal, doing things like this creates a semantic that
>>>> assumes .to_irq() is always called before using the IRQ and
>>>> that is not guaranteed at all. A consumer may very well
>>>> use an interrupt right off the irqchip without this being called
>>>> first. All this function should do is translate a number. No
>>>> other semantics.
>>>>
>>>> This needs to be done from the irqchip (sorry).
>>>
>>> Actually, the register written here is not part of the irqchip.
>>> It is a system config register that is only used when using a GPIO as
>>> external interrupt.
>>> Its aim is to mux the GPIO bank on a line.
>>
>> Then it should be done in .request() for the GPIO, not in
>> .to_irq().
>
> Problem is that at request time, we don't know whether the GPIO is to
> be used as an interrupt or not.

Well the fact that .to_irq() is called does not mean that you know
it will be used as an interrupt either. Sorry. It is just a translation
function, not an allocation function.

> I think I may have not been clear enough in the HW architecture description.
> Indeed, I used the term "mux", but should instead use the term "selector".
>
> The idea is that between the GPIO controllers and the EXTI controller,
> there is one selector for each line number, to select the controller used as
> interrupt source.
>
> For example, there is a selector on line 0 to select between gpioa0, gpiob0,
> gpioc0,.., gpiok0, which one is connected to exti0.
>
> It means there is a HW restriction that makes impossible to use both GPIOA0
> or GPIOB0 as interrupts at the same time.
>
> It looks like this: http://pastebin.com/raw/cs2WiNKZ
> You can directly check section 12.2.5 of the stm32f429 reference manual:
> http://www2.st.com/resource/en/reference_manual/dm00031020.pdf

Nice ASCII art, include that into the commit message :)

> For example, we can imagine a board where gpioa0 is used SD's card detect,
> and gpiob0 used to control a led.
>
> If we set the mux at request time, gpiob0 request may overwrite the mux
> configuration set by gpioa0, whereas it is not used as interrupt.
>
> That is the reason why I did it in .to_irq().

Well now I am even *more* convinced that this should not happen in
.to_irq(). .to_irq() should not do *anything*.

This needs to happen as part of the irqchip setting up the actual
interrupt.

And it seems the problem is that this driver does *not* define its
own irqchip, but it *should*.

What you want to do is implement an hierarchical irqdomain in your
irqchip, which is what other drivers of this type are doing, see:
drivers/gpio/gpio-xgene-sb.c
irq_domain_create_hierarchy() is your friend.

>> It should *also* be done in the set-up path for the irqchip
>> side, if that line is used without any interaction with the
>> gpio side of things.
>
> Actually, a line is either used by a GPIO, (exclusive) or another purpose.
> In the case of a GPIO line, I think we should always go through the gpio.

This is a textbook example of a hierarchichal irq domain I think.

>> The point is that each IRQ that ever get used
>> has a 1-to-1 relationship to a certain GPIO line, and if that
>> relationship cannot be resolved from the irqchip side,
>> something is wrong. The irqchip needs to enable the
>> GPIO line it is backing to recieve interrupts without any
>> requirements that .to_irq() have been called first.
>
> Actually, this is not a 1:1 relationship, as for example, exti0 can be connected
> to either gpioa0, or gpiob0,..., or gpiok0.

That is what hierarchical irqdomain is for.

You should expose an irqchip from the gpio driver, that give you
unique irq translations for *all* GPIO lines.

Then, at runtime, if the hierarchical irqdomain cannot map
(i.e. mux) the interrupt onto one of the available lines,
you will get an error.

Yours,
Linus Walleij
