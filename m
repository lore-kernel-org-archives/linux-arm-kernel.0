From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 6 Nov 2013 10:16:45 +0100
Subject: [PATCH] ARM/serial: at91: switch atmel serial to use gpiolib
In-Reply-To: <20131105162828.GC28304@ns203013.ovh.net>
References: <1383654959-18112-1-git-send-email-linus.walleij@linaro.org>
 <20131105162828.GC28304@ns203013.ovh.net>
Message-ID: <CACRpkdY3uK56K2YPB2AjOQzjJxUmkpX0AR0kOpfPyckwv2nztQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 5, 2013 at 5:28 PM, Jean-Christophe PLAGNIOL-VILLARD
<plagnioj@jcrosoft.com> wrote:
> On 13:35 Tue 05 Nov     , Linus Walleij wrote:

>> +     /*
>> +      * AT91RM9200 Errata #39: RTS0 is not internally connected
>> +      * to PA21. We need to drive the pin as a GPIO.
>> +      */
>> +     if (gpio_is_valid(atmel_port->rts_gpio) &&
>> +         port->mapbase == AT91RM9200_BASE_US0) {

> not really a fon of this hack
>
> if we use a uart for rs485 we need to use a gpio for rts too

Hm it was completely unnecessary anyway, as I now specify
the RTS pin per UART instance, it will only be valid for
those setting it right.

>> +     /*
>> +      * In theory the GPIO pin controlling RTS could be zero and
>> +      * this would be an improper check, but we know that the only
>> +      * existing case is != 0 and it's nice to use the zero-initialized
>> +      * structs to indicate "no RTS GPIO" instead of open-coding some
>> +      * invalid value everywhere.
>> +      */
>> +     if (pdata->rts_gpio > 0) {

>         this can not work 0 is a valid gpio if you do this you need to update
>         ALL the bard filee too to set it as -EINVAL;

Isn't it the other way around? I did this exactly to avoid updating
all the boardfiles, as the rts_gpio == 0 for all those not
defining it. This is why I test for > 0.

Yours,
Linus Walleij
