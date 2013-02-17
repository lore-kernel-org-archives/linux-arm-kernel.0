From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Sun, 17 Feb 2013 17:42:28 +0800
Subject: [PATCH v8 04/12] pinctrl: verify whether gpio chip overlapps range
In-Reply-To: <CACRpkdYWSq2rqhLWcjGSKiUa2+ujChg64r1EWeRSJKhHvSy6uA@mail.gmail.com>
References: <1360602659-4774-1-git-send-email-haojian.zhuang@linaro.org>
 <1360602659-4774-5-git-send-email-haojian.zhuang@linaro.org>
 <CACRpkdaU2mWQa3qMmLKmxF5zxTq40zD30KyxdotagjjWUvopzg@mail.gmail.com>
 <CAD6h2NTSqMB8EQKdzZJHm3jN5eS=7TTejHNLQSNjWGSqqeS=dA@mail.gmail.com>
 <CACRpkdYWSq2rqhLWcjGSKiUa2+ujChg64r1EWeRSJKhHvSy6uA@mail.gmail.com>
Message-ID: <CAD6h2NQjSCNP86oOXO87fO=NCmQQj-BygV1Ro9+iBf0A1O4J-w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 February 2013 17:06, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Thu, Feb 14, 2013 at 6:01 PM, Haojian Zhuang
> <haojian.zhuang@linaro.org> wrote:
>> On 14 February 2013 23:23, Linus Walleij <linus.walleij@linaro.org> wrote:
>>> On Mon, Feb 11, 2013 at 6:10 PM, Haojian Zhuang
>>> <haojian.zhuang@linaro.org> wrote:
>>>
>>>>  /**
>>>> + * pinctrl_overlapped_gpio_range() - check if the GPIO chip of a certain GPIO
>>>> + * pin is overlapped with gpio range.
>>>> + * @gpio: gpio pin to check taken from the global GPIO pin space
>>>> + *
>>>> + * This function is complement of pinctrl_match_gpio_range(). If the return
>>>> + * value of pinctrl_match_gpio_range() is NULL, this function could be used
>>>> + * to check whether pinctrl device is ready or not. Maybe some GPIO pins
>>>> + * don't have back-end pinctrl interface.
>>>> + * If the return value is true, it means that pinctrl device is ready & the
>>>> + * certain GPIO pin doesn't have back-end pinctrl device. If the return value
>>>> + * is false, it means that pinctrl device may not be ready.
>>>> + */
>>>> +static bool pinctrl_overlapped_gpio_range(unsigned gpio)
>>>
>>> The name of this function confuses me, can we name it something
>>> like:
>>>
>>> pinctrl_gpio_is_in_some_chip_but_no_range()
>>>
>>> Which is actually what you test, right?
>>>
>> How about pinctrl_match_gpio_range_exclude_some_pins()?
>
> Actually I get ever more confused by this patch, I just don't understand
> it. :-(
>
> Something will need to be expanded on here or I will be unable to
> maintaine the code, sorry for being a slow learner...
>
> By the way:
> Nowaday the recommended practice is to register a GPIO chip,
> then add ranges using gpiochip_add_pin_range() in the non-DT
> case. Doesn't that create a race window when the above code will
> not behave as expected, e.g. between registration of the gpio
> chip, the pin controller and the ranges? I guess the code assumes
> that *all* initialization is complete?
>
> Yours,
> Linus Walleij

The implementation is a little tricky at here. Let me explain the case.

We have a back-end pinctrl-single device & pl061 gpio devices. So we
need to define gpio range in DT. But there's no related pinmux registers
on some special pins, like gpio159. Although we initialized pinctrl-single
driver, we still get failure from pinctrl_match_gpio_range() because
it doesn't exist in DT.

I implement it to double check for the failure case. If match_gpio_range()
return failure, we need to check whether the pinctrl device isn't ready or
the special pins like gpio159 don't exist in gpio range. So if the
pinctrl device
isn't ready, it return EPROBE_DEFERED. If the special pins doesn't exist
in gpio range, it's not the error case & return 0 (sucessful).

Regards
Haojian
