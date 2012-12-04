From: dromede@gmail.com (=?UTF-8?B?TWFya28gS2F0acSH?=)
Date: Tue, 4 Dec 2012 23:19:08 +0100
Subject: [PATCH] backlight: corgi_lcd: Use gpio_set_value_cansleep() for
 akita machines to avoid WARN_ON trigger
In-Reply-To: <20121129173646.110887c3.akpm@linux-foundation.org>
References: <1354237577-4653-1-git-send-email-dromede@gmail.com>
 <20121129173646.110887c3.akpm@linux-foundation.org>
Message-ID: <CAHod+GdDuwbYryrDnBriLnTSiFf4R_WwzcdGoxi6NUe1eemTaA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 30, 2012 at 2:36 AM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Fri, 30 Nov 2012 02:06:17 +0100
> dromede at gmail.com wrote:
>
>> From: Marko Katic <dromede.gmail.com>
>>
>> Changing backlight intensity on an Akita (Sharp Zaurus C-1000)
>> will always trigger a WARN_ON:
>>
>> WARNING: at drivers/gpio/gpiolib.c:1672 __gpio_set_value+0x38/0xa4()
>>
>> ...
>>
>> Akita machines have backlight controls hooked to a gpio expander chip, max7310.
>> The driver that controls the max7310 sets the cansleep flag and the corgi_lcd
>> driver only uses plain gpio_set_value calls for changing backlight controls.
>> This triggers the WARN_ON on akita machines.
>>
>> Akita is the only exception in this case since other users of corgi_bl access
>> backlight gpio controls through a different gpio expander which does not set the cansleep flag.
>
> Let's be nice and specific, please.  You're referring to
> pca953x_gpio_set_value(), yes?  And it uses i2c transfers which can
> sleep?

Point taken, will change this in my v2 commit message.

>
>> Fix this by conditionally using gpio_set_value_cansleep() when changing backlight intensity on
>> akita machines.
>
> I don't get this.  There is no difference between
> gpio_set_value_cansleep() and __gpio_set_value() apart from the
> generation of debug warnings.  What's going on here?
>
>> index c781768..f33e26f 100644
>> --- a/drivers/video/backlight/corgi_lcd.c
>> +++ b/drivers/video/backlight/corgi_lcd.c
>> @@ -26,7 +26,7 @@
>>  #include <linux/spi/corgi_lcd.h>
>>  #include <linux/slab.h>
>>  #include <asm/mach/sharpsl_param.h>
>> -
>> +#include <asm/mach-types.h>
>>  #define POWER_IS_ON(pwr)     ((pwr) <= FB_BLANK_NORMAL)
>>
>>  /* Register Addresses */
>> @@ -408,11 +408,19 @@ static int corgi_bl_set_intensity(struct corgi_lcd *lcd, int intensity)
>>       /* Bit 5 via GPIO_BACKLIGHT_CONT */
>>       cont = !!(intensity & 0x20) ^ lcd->gpio_backlight_cont_inverted;
>>
>> -     if (gpio_is_valid(lcd->gpio_backlight_cont))
>> -             gpio_set_value(lcd->gpio_backlight_cont, cont);
>> +     if (gpio_is_valid(lcd->gpio_backlight_cont)) {
>> +             if (machine_is_akita())
>> +                     gpio_set_value_cansleep(lcd->gpio_backlight_cont, cont);
>> +             else
>> +                     gpio_set_value(lcd->gpio_backlight_cont, cont);
>> +     }
>
> See, here you could do
>
>         if (__gpio_cansleep(lcd->gpio_backlight_cont))
>                 gpio_set_value_cansleep(...);
>         else
>                 gpio_set_value(...);
>
> and solve the problem forever, without having to hackily add
> hardware-specific exceptions.
>
> But such a change simply demonstrates the silliness of
> this gpio_set_value_cansleep-vs-gpio_set_value thing.
>
> Confused.

There are 8 different models of Zaurus devices that use
this particular lcd panel. 7 of them access it's backlight gpio controls
through the same memory mapped gpio expander chip.
And here's the akita model, the only one that uses an i2c gpio
expander that can sleep.
Also, these are legacy devices and this is an obsolete lcd panel. It is
_very_ unlikely that there will be more devices in the kernel tree
that use this panel.
I also found plenty of examples of machine_is_* usage in the drivers/ tree.
These were the reasons why i used machine_is_akita to solve this problem.

On the other hand, i do agree that yours is a more elegant solution and i will
use it in my v2 patch.
