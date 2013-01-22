From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 22 Jan 2013 10:10:21 +0100
Subject: [PATCH v7 08/15] gpio: pl061: bind pinctrl by gpio request
In-Reply-To: <CAD6h2NQm+VoUv9tDSoHv3Xs8RtuCt5A+_DCBx6bh-d3WP3PK=w@mail.gmail.com>
References: <1358494279-16503-1-git-send-email-haojian.zhuang@linaro.org>
 <1358494279-16503-9-git-send-email-haojian.zhuang@linaro.org>
 <CACRpkdZo6mVSaHBr6PJt8QCkiKp-Vs7mWup8n=4zyacRwf8V3g@mail.gmail.com>
 <CAD6h2NQm+VoUv9tDSoHv3Xs8RtuCt5A+_DCBx6bh-d3WP3PK=w@mail.gmail.com>
Message-ID: <CACRpkdbgRY9CcdRAVVaVAq57hF1cTf7LMOqneNwcz+VtpFDcUg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 21, 2013 at 4:45 PM, Haojian Zhuang
<haojian.zhuang@linaro.org> wrote:

>> > +       pinctrl_request_gpio(gpio);
>>
>> Handling of error code?
>>
>> (Maybe I should add a __must_check on this function.)
>>
> My case is a little special. I don't want to check return value because some
> gpio pins don't have pinmux registers in Hisilicon SoC.
> So pinctrl_request_gpio() will always return error for these special pins in
> Hisilicon SoC.
>
> If we must check the return value, maybe we need append a dummy pinctrl driver
> for those special gpio pins. How do you think about it? Of course, I
> need to evaluate
> whether it's possible to implement.

Hm. A dummy pinctrl back-end is not very elegant.

It's better if the GPIO driver (gpio-pl061) keep track of the ranges that
are connected to the pinctrl.

If the ranges are encoded in the device tree (as I guess you want to do
in this case) then the GPIO driver need to check these ranges to see if
it uses a pinctrl backend. Magic behind-the-scenes is very hard to
understand for people reading this code later.

What about this:

In gpiolib.c, function gpiochip_add_pin_range(), we save a copy of
each range in &chip->pin_ranges.

Add a function to gpiolib.c to check if a certain gpio is in the range
of the current chip.

Then use that:

if (gpio_in_pinrange(gpio))
    pinctrl_request_gpio(gpio);

Yours,
Linus Walleij
