From: mine260309@gmail.com (Lei YU)
Date: Wed, 9 May 2018 11:18:27 +0800
Subject: [PATCH] hwmon: (aspeed-pwm-tacho) Use 24MHz clock
In-Reply-To: <8a801894-4293-d2e8-4673-3d9ff5c2a5bb@roeck-us.net>
References: <1525772367-20627-1-git-send-email-mine260309@gmail.com>
 <8a801894-4293-d2e8-4673-3d9ff5c2a5bb@roeck-us.net>
Message-ID: <CAARXrtmO=wsPK6bfO0E7fvAkqEJUV1kQSYK1gWXkUhmKytq42A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 8, 2018 at 9:51 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> No mixed C/C++ comments in hwmon drivers.
>
>>         aspeed_set_clock_source(priv->regmap, 0);
>> +       priv->clk_freq = 24000000;
>>
>
>
> Are you saying that clk_get_rate() is wrong ? Anyway, if the DT is bad, it
> should be fixed.
Nope, clk_get_rate() is OK.
The reason I make this change is because the PWM supports two types of clock
source, the 24MHz or the clock from memory controller.
If the DT uses 24MHz clock, this code is OK.
But if the DT configs this pwm to use mclk (memory controller clk), this piece
of code becomes wrong, because the code
`aspeed_set_clock_source(priv->regmap, 0)` configs the device to use the 24MHz
clock.
So no matter what DT configs the clk, this driver *always* uses 24MHz clock.

That's why I want to make this change.

> I am not a friend of hacking drivers to fix up bad DTs, and much less so
> without explanation.
> Plus, how do we know that the next chip supported by the driver doesn't have
> a 32MHz clock ?
This driver currently supports ast2400 and ast2500, and they both use 24MHz
clock.
In case future device uses a different clock, we can update this code, right?

> Really, please fix the DT.
Sure, I will send patch to config the clock to use fixed 24MHz clock as well.

>
> Guenter
>
>>         aspeed_create_type(priv);
>>
>
>
