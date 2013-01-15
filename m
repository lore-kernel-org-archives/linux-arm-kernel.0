From: stigge@antcom.de (Roland Stigge)
Date: Tue, 15 Jan 2013 14:30:55 +0100
Subject: [PATCH RESEND 6/6 v13] gpio: Add block gpio to several gpio
 drivers
In-Reply-To: <50F5573D.4060007@atmel.com>
References: <1358250716-21986-1-git-send-email-stigge@antcom.de>
 <1358250716-21986-7-git-send-email-stigge@antcom.de>
 <50F5573D.4060007@atmel.com>
Message-ID: <50F55A0F.6010303@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/15/2013 02:18 PM, Nicolas Ferre wrote:
>> --- linux-2.6.orig/drivers/pinctrl/pinctrl-at91.c
>> +++ linux-2.6/drivers/pinctrl/pinctrl-at91.c
>> @@ -49,6 +49,7 @@ struct at91_gpio_chip {
>>       struct clk        *clock;        /* associated clock */
>>       struct irq_domain    *domain;    /* associated irq domain */
>>       struct at91_pinctrl_mux_ops *ops;    /* ops */
>> +    unsigned long        mask_cache;    /* cached mask for block gpio */
>>   };
>>
>>   #define to_at91_gpio_chip(c) container_of(c, struct at91_gpio_chip,
>> chip)
>> @@ -1125,6 +1126,32 @@ static void at91_gpio_set(struct gpio_ch
>>       writel_relaxed(mask, pio + (val ? PIO_SODR : PIO_CODR));
>>   }
>>
>> +static unsigned long at91_gpio_get_block(struct gpio_chip *chip,
>> +                     unsigned long mask)
>> +{
>> +    struct at91_gpio_chip *at91_gpio = to_at91_gpio_chip(chip);
>> +    void __iomem *pio = at91_gpio->regbase;
>> +    u32 pdsr;
>> +
>> +    pdsr = __raw_readl(pio + PIO_PDSR);
> 
> Maybe you should use readl_relaxed() here as it is used in the
> at91_gpio_[get|set]() functions.

Thanks for the note! Seem to have missed this when forward porting in
pinctrl-at91.c was due.

Will include the respective change in a subsequent update.

Roland
