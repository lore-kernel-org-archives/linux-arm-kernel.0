From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Thu, 6 Nov 2014 01:33:24 +0400
Subject: [PATCH 02/15] GPIO: port LoCoMo gpio support from old driver
In-Reply-To: <CACRpkdb7v3LmOhbhQ9TPk1_bnLnpwizawW6RQvhQRLSjRewAaQ@mail.gmail.com>
References: <1414454528-24240-1-git-send-email-dbaryshkov@gmail.com>
 <1414454528-24240-3-git-send-email-dbaryshkov@gmail.com>
 <CACRpkdY7tRadod2vQfEytmw-ubaMAvr_=XTczD5bUMkqie0xkg@mail.gmail.com>
 <CALT56yOgMUA7o2dzfHph=S2zkDV4zERzMh4ishpPwpAx7Cqj6Q@mail.gmail.com>
 <CACRpkdb7v3LmOhbhQ9TPk1_bnLnpwizawW6RQvhQRLSjRewAaQ@mail.gmail.com>
Message-ID: <CALT56yO9f8wzaArnmfQSDzCM3S+2oT+62anH5kbFY3WdEt_HZg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-11-03 16:43 GMT+03:00 Linus Walleij <linus.walleij@linaro.org>:
> On Fri, Oct 31, 2014 at 10:39 AM, Dmitry Eremin-Solenikov
> <dbaryshkov@gmail.com> wrote:
>> 2014-10-31 10:48 GMT+03:00 Linus Walleij <linus.walleij@linaro.org>:
>>> On Tue, Oct 28, 2014 at 1:01 AM, Dmitry Eremin-Solenikov
>>> <dbaryshkov@gmail.com> wrote:
>>>
>>>> Add gpiolib driver for gpio pins placed on the LoCoMo GA.
>>>>
>>>> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
>>>
>>
>> [skipped]
>>
>>> (etc, everywhere this pattern occurs).
>>>> +static void locomo_gpio_set(struct gpio_chip *chip,
>>>> +               unsigned offset, int value)
>>>> +{
>>>> +       struct locomo_gpio *lg = container_of(chip, struct locomo_gpio, gpio);
>>>> +       unsigned long flags;
>>>> +
>>>> +       spin_lock_irqsave(&lg->lock, flags);
>>>> +
>>>> +       __locomo_gpio_set(chip, offset, value);
>>>> +
>>>> +       spin_unlock_irqrestore(&lg->lock, flags);
>>>
>>> If you actually always have to be getting and releasing a spin lock around
>>> the register writes, contemplate using regmap-mmio because that
>>> is part of what it does.
>>>
>>> But is this locking really necessary?
>>
>> I have a custom of doing such locking and never having to think about
>> somebody breaking into RMW cycles.
>>
>> Also isn't regmap an overkill here? Wouldn't regmap also do a lock/unlock
>> around each register read/write/RMW?
>
> Yes that's the point: if you use regmap mmio you get the RMW-locking
> for free, with the regmap implementation.


Just to be more concrete. Currently locomo_gpio_ack_irq() function uses
one lock and one unlock for doing 3 consecutive RMW I I convert locomo
to regmap, will that be 3 lock/unlock calls or still one? (Or maybe I'm
trying to be over-protective here and adding more lock/unlock cycles
won't matter that much?)

Next question: if I have to export regmap to several subdrivers, is it better
to have one big regmap or to have one-map-per-driver approach?

-- 
With best wishes
Dmitry
