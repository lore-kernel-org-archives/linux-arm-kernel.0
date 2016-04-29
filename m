From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 29 Apr 2016 10:53:19 +0200
Subject: [PATCH v2 6/9] pinctrl: Add IRQ support to STM32 gpios
In-Reply-To: <CALszF6CUFKAjzUpEh3pDtSDdJuFan1ON0Kcu_uKD_OX36kXOHQ@mail.gmail.com>
References: <1459436979-17275-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1459436979-17275-7-git-send-email-mcoquelin.stm32@gmail.com>
 <CACRpkdYLPWNQZgdFHVwLOZv+rS=bdERM9St5b0hVHTd_+ZJMKg@mail.gmail.com>
 <CALszF6CUFKAjzUpEh3pDtSDdJuFan1ON0Kcu_uKD_OX36kXOHQ@mail.gmail.com>
Message-ID: <CACRpkdZXz8-UnOd6ee48AWqDX2X9Hvux=+ZQ7qdg6a4KVoArww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 19, 2016 at 11:04 AM, Maxime Coquelin
<mcoquelin.stm32@gmail.com> wrote:
> 2016-04-08 11:43 GMT+02:00 Linus Walleij <linus.walleij@linaro.org>:
>> On Thu, Mar 31, 2016 at 5:09 PM, Maxime Coquelin
>> <mcoquelin.stm32@gmail.com> wrote:
>>
>>> +static int stm32_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
>>> +{
>>> +       struct stm32_pinctrl *pctl = dev_get_drvdata(chip->parent);
>>> +       struct stm32_gpio_bank *bank = gpiochip_get_data(chip);
>>> +       unsigned int irq;
>>> +
>>> +       regmap_field_write(pctl->irqmux[offset], bank->range.id);
>>
>> No. You must implement the irqchip and GPIO controllers to
>> be orthogonal, doing things like this creates a semantic that
>> assumes .to_irq() is always called before using the IRQ and
>> that is not guaranteed at all. A consumer may very well
>> use an interrupt right off the irqchip without this being called
>> first. All this function should do is translate a number. No
>> other semantics.
>>
>> This needs to be done from the irqchip (sorry).
>
> Actually, the register written here is not part of the irqchip.
> It is a system config register that is only used when using a GPIO as
> external interrupt.
> Its aim is to mux the GPIO bank on a line.

Then it should be done in .request() for the GPIO, not in
.to_irq().

It should *also* be done in the set-up path for the irqchip
side, if that line is used without any interaction with the
gpio side of things.

> For example on line 1, it can be muxed to select either gpioa1,
> gpiob1, gpioc1, ...
> How could I do it in the irqchip that has no gpio knowledge?

I don't understand this.

We are discussing an irqchip that is tightly coupled with
a gpiochip. Usually d->hwirq is the same as the GPIO offset
but that varies.

The point is that each IRQ that ever get used
has a 1-to-1 relationship to a certain GPIO line, and if that
relationship cannot be resolved from the irqchip side,
something is wrong. The irqchip needs to enable the
GPIO line it is backing to recieve interrupts without any
requirements that .to_irq() have been called first.

If to_irq() does something else than translate to an IRQ
something is wrong.

Yours,
Linus Walleij
