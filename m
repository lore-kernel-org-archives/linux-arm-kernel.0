From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 11 May 2016 10:34:48 +0200
Subject: [PATCH v5 08/17] gpio: port LoCoMo gpio support from old driver
In-Reply-To: <20150614152710.GG7557@n2100.arm.linux.org.uk>
References: <1433797008-6246-1-git-send-email-dbaryshkov@gmail.com>
 <1433797008-6246-9-git-send-email-dbaryshkov@gmail.com>
 <20150614152710.GG7557@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdYsf+wEy0juA1ZnpmY8O+aDTt7YketSD-AesBjZmVmzeA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 14, 2015 at 5:27 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> [Dmitry]

>> +     regmap_write(lg->regmap, LOCOMO_GPO, 0x00);
>> +     regmap_write(lg->regmap, LOCOMO_GPE, 0x00);
>> +     regmap_write(lg->regmap, LOCOMO_GPD, 0x00);
>> +     regmap_write(lg->regmap, LOCOMO_GIE, 0x00);
>
> Do we really want to initialise all outputs like this?  It suffers from
> the problem I mention above - it sets all outputs to zero, then sets
> them as inputs, which can lead to glitching.  What if (eg) the LCD was
> left enabled?  This would mean you're not going through the proper
> power-down sequence for the LCD (for example).

This looks dangerous indeed, why did I miss that before.

Is it possible to just leave these registers as-is, or, in case
you want to know at all times their actual states, implement
the .get_direction() callback? They the kernel can explore
the direction and value of the lines.

> TBH, I think GPIO needs to have a way to claim output GPIOs _without_
> programming their current state for situations like this.  That seems
> to have been an oversight in the model for a while now - it's impossible
> to claim GPIO outputs without setting their initial value,

It is possible in the new descriptor API, you can claim a GPIO
for a device with (see <linux/gpio/consumer.h>

enum gpiod_flags {
        GPIOD_ASIS      = 0,
(...)

I understand it may be a bit thick to ask to migrate the whole
SA1100 codebase to GPIO descriptors though, I don't know how
many machines and drivers that would affect.

I'd consider a patch retrofitting this into the old
API if it would see some real use case.

Yours,
Linus Walleij
