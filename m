From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 7 Oct 2017 13:07:50 +0200
Subject: [PATCH 1/2] [v5] pinctrl: qcom: disable GPIO groups with no pins
In-Reply-To: <9f28c9dd-6277-6c75-1186-a834e15c5346@codeaurora.org>
References: <1504798409-32041-1-git-send-email-timur@codeaurora.org>
 <1504798409-32041-2-git-send-email-timur@codeaurora.org>
 <20171002174414.GL1165@minitux>
 <9f28c9dd-6277-6c75-1186-a834e15c5346@codeaurora.org>
Message-ID: <CACRpkdYYp5TSM1QV-f+FmbwzY_ittgW-4MuXiZ9NW694GoMwKQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 2, 2017 at 10:47 PM, Timur Tabi <timur@codeaurora.org> wrote:
> On 10/02/2017 12:44 PM, Bjorn Andersson wrote:
>>>
>>> +       /*
>>> +        * If irq_need_valid_mask is true, then gpiochip_add_data() will
>>> +        * initialize irq_valid_mask to all 1s.  We need to clear all the
>>> +        * GPIOs that are unavailable, and we need to find each block
>>> +        * of consecutive available GPIOs are add them as pin ranges.
>>> +        */
>>> +       if (chip->irq_need_valid_mask) {
>>> +               for (i = 0; i < ngpio; i++)
>>> +                       if (!groups[i].npins)
>>> +                               clear_bit(i, pctrl->chip.irq_valid_mask);
>>> +
>>> +               while ((count = msm_gpio_get_next_range(pctrl, &start)))
>>> {
>>> +                       ret = gpiochip_add_pin_range(&pctrl->chip,
>>> +
>>> dev_name(pctrl->dev),
>>> +                                                    start, start,
>>> count);
>>> +                       if (ret)
>>> +                               break;
>>> +                       start += count;
>>
>> I do not fancy the idea of specifying a bitmap of valid irq pins and
>> then having the driver register the pin-ranges in-between.
>
> But that's exactly what abx500_gpio_probe() in pinctrl-abx500.c does. Here's
> even a reference to holes in the GPIO space:

This driver is not a good example of what is desireable.

I am sorry that the kernel contains a lot of bad examples. These
are historical artifacts, they cannot be used as an argument to write
code in the same style.

>> If we provide
>>
>> a bitmap of validity to the core it should support using this for the
>> pins as well. (Which I believe is what Linus answered in the discussion
>> following patch 0/2)
>
> So you want to change "gpio_chip" to add an "available" callback?  And every
> time gpiolib wants to call a gpio_chip callback, it should call ->available
> first?  Like this:
>
> if (chip->available && chip->available())
>         status = chip->direction_input(chip, gpio_chip_hwgpio(desc));

I mean that you add
unsigned long *line_valid_mask;
to struct gpio_chip using the same type of logic
as .irq_valid_mask. The mask should be optional.

Then the operation gpiod_get[_index]() will FAIL if the
line is not valid.

There is no need to check on every operation, there should
be no way to get a handle on the pin any other way.

All new code should be using descriptors at this point so we
only need to design for that case.

Yours,
Linus Walleij
