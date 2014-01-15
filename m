From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 15 Jan 2014 16:21:12 +0800
Subject: [linux-sunxi] [PATCH] pinctrl: sunxi: Honor GPIO output initial
 vaules
In-Reply-To: <000001cf1189$fc0f8120$f42e8360$@gmail.com>
References: <1389711021-16430-1-git-send-email-wens@csie.org>
 <000001cf1189$fc0f8120$f42e8360$@gmail.com>
Message-ID: <CAGb2v64hs1B=5Ss40AD6K=GTOiYqJrG_vCOxrPzWmjjVgFGvXg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jan 15, 2014 at 8:37 AM, Ma Haijun <mahaijuns@gmail.com> wrote:
> Hi,
>
> I think it is better to set the output value first to avoid glitch.

If I understand the user manual correctly, setting the output value
before changing the pin to output function first will have no effect.

And it is not possible to set the function and the value at the same
time, as they are in different registers.


Cheers,
ChenYu

> Regards,
>
> Ma
>
>> -----Original Message-----
>> From: linux-sunxi at googlegroups.com [mailto:linux-sunxi at googlegroups.com]
>> On Behalf Of Chen-Yu Tsai
>> Sent: Tuesday, January 14, 2014 10:50 PM
>> To: Maxime Ripard
>> Cc: Chen-Yu Tsai; linux-arm-kernel; linux-sunxi; Linus Walleij
>> Subject: [linux-sunxi] [PATCH] pinctrl: sunxi: Honor GPIO output initial
> vaules
>>
>> Some GPIO users, such as fixed-regulator, request GPIO output with initial
>> value of 1. This was ignored by sunxi driver.
>>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>> ---
>>  drivers/pinctrl/pinctrl-sunxi.c | 17 +++++++++++------
>>  1 file changed, 11 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/pinctrl/pinctrl-sunxi.c
> b/drivers/pinctrl/pinctrl-sunxi.c index
>> 119d2dd..fc72d10 100644
>> --- a/drivers/pinctrl/pinctrl-sunxi.c
>> +++ b/drivers/pinctrl/pinctrl-sunxi.c
>> @@ -469,12 +469,6 @@ static int sunxi_pinctrl_gpio_get(struct gpio_chip
>> *chip, unsigned offset)
>>       return val;
>>  }
>>
>> -static int sunxi_pinctrl_gpio_direction_output(struct gpio_chip *chip,
>> -                                     unsigned offset, int value)
>> -{
>> -     return pinctrl_gpio_direction_output(chip->base + offset);
>> -}
>> -
>>  static void sunxi_pinctrl_gpio_set(struct gpio_chip *chip,
>>                               unsigned offset, int value)
>>  {
>> @@ -498,6 +492,17 @@ static void sunxi_pinctrl_gpio_set(struct gpio_chip
>> *chip,
>>       spin_unlock_irqrestore(&pctl->lock, flags);  }
>>
>> +static int sunxi_pinctrl_gpio_direction_output(struct gpio_chip *chip,
>> +                                     unsigned offset, int value)
>> +{
>> +     int ret = pinctrl_gpio_direction_output(chip->base + offset);
>> +
>> +     if (ret == 0)
>> +             sunxi_pinctrl_gpio_set(chip, offset, value);
>> +
>> +     return ret;
>> +}
>> +
>>  static int sunxi_pinctrl_gpio_of_xlate(struct gpio_chip *gc,
>>                               const struct of_phandle_args *gpiospec,
>>                               u32 *flags)
>> --
>> 1.8.5.2
>>
