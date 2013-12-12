From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 12 Dec 2013 15:38:42 +0100
Subject: [PATCH 2/3] pinctrl: at91: initialize config parameter to 0
In-Reply-To: <52A57E55.40808@atmel.com>
References: <1386421734-10240-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1386421734-10240-2-git-send-email-alexandre.belloni@free-electrons.com>
 <52A57E55.40808@atmel.com>
Message-ID: <CACRpkdZCqgfokNzmG-Jmrf3k-a5XFUg=e0c6kCY1DcnBJnfJtA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 9, 2013 at 9:24 AM, Nicolas Ferre <nicolas.ferre@atmel.com> wrote:

>> -       dev_dbg(info->dev, "%s:%d, pin_id=%d, config=0x%lx", __func__,
>> __LINE__, pin_id, *config);
>> +       *config = 0;
>> +       dev_dbg(info->dev, "%s:%d, pin_id=%d", __func__, __LINE__,
>> pin_id);
>>         pio = pin_to_controller(info, pin_to_bank(pin_id));
>>         pin = pin_id % MAX_NB_GPIO_PER_BANK;
>
>
> Beyond this patch, I must say that I am puzzled by this function.
>
> What I read from the prototype documentation and what I see in different
> implementations is different...


Yeah, we need to fix this mess.

> Linus, can we have a review of this function because it seems not in line
> with what is used for u300 (but on the other hand looks like the what is
> returned by pinctrl-exynos5440.c driver for example).

It is supposed to read out one config at the time, if and only if used
with the generic pin config.

Typically:

enum pin_config_param param = (enum pin_config_param) *config;

switch (param) {
    case PIN_CONFIG_BIAS_HIGH_IMPEDANCE:
            *config = 0;
            if (biasmode)
                    return 0;
            else
                    return -EINVAL;
            break;
(...)

return -ENOTSUPP;

However AT91 is *not* using generic pin config, so the semantics of
this call is driver-dependent. In your case the implementation get all
the configs at once, which is an efficient shortcut if you don't need
to be general and enumerat all possible configs.

> What would be the consequences if we change this function's behavior: I mean
> use of -EINVAL for pin configuration "available but disabled" as said in
> include/linux/pinctrl/pinconf.h?

That code will propagate back ... I guess you'd have to test it :-/

Yours,
Linus Walleij
