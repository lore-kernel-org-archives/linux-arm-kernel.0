From: stigge@antcom.de (Roland Stigge)
Date: Thu, 24 Jan 2013 13:19:51 +0100
Subject: [PATCH 6/6 v14] gpio: Add block gpio to several gpio drivers
In-Reply-To: <CAOY=C6H5xETt5UNXUfRkGW9q+bj0y2R3sXNvW87XXvQcYoL_-g@mail.gmail.com>
References: <1358856404-8975-1-git-send-email-stigge@antcom.de>
 <1358856404-8975-7-git-send-email-stigge@antcom.de>
 <CAOY=C6H5xETt5UNXUfRkGW9q+bj0y2R3sXNvW87XXvQcYoL_-g@mail.gmail.com>
Message-ID: <510126E7.5090802@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/24/2013 01:02 PM, Stijn Devriendt wrote:
>> +static void lpc32xx_gpio_set_block_p3(struct gpio_chip *chip,
>> +                                     unsigned long mask,
>> +                                     unsigned long values)
>> +{
>> +       struct lpc32xx_gpio_chip *group = to_lpc32xx_gpio(chip);
>> +       u32 set_bits = values & mask;
>> +       u32 clr_bits = ~values & mask;
>> +
>> +       /* States of GPIO 0-5 start at bit 25 */
>> +       set_bits <<= 25;
>> +       clr_bits <<= 25;
>> +
>> +       /* Note: On LPC32xx, GPOs can only be set at once or cleared at once,
>> +        *       but not set and cleared at once
>> +        */
>> +       if (set_bits)
>> +               __raw_writel(set_bits, group->gpio_grp->outp_set);
>> +       if (clr_bits)
>> +               __raw_writel(clr_bits, group->gpio_grp->outp_clr);
>> +}
>> +
> 
> In my patch, I go out of the way of this kind of thing for a simple reason:
> You may generate incorrect timing by doing this.

You are right, certain things like synchronous on+off is not really
possible.

However, the above at least supports switching on simulaneously, and
switching off simultaneously, which is an improvement in certain cases
(and this certain hardware part doesn't support more). Maybe this
certain driver behaviour can be documented even better than just in the
driver source.

If there is consensus that everything else in the patch set is settled,
and we just don't want to support behaviour like the above - well, we
can still drop it.

Thanks for the note,

Roland
