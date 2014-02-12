From: richard.genoud@gmail.com (Richard Genoud)
Date: Wed, 12 Feb 2014 09:33:57 +0100
Subject: [PATCH v2 1/4] tty/serial: Add GPIOLIB helpers for controlling
 modem lines
In-Reply-To: <1392142986.607813065@f171.i.mail.ru>
References: <1392140715-15295-1-git-send-email-richard.genoud@gmail.com>
 <1392140715-15295-2-git-send-email-richard.genoud@gmail.com>
 <1392142986.607813065@f171.i.mail.ru>
Message-ID: <CACQ1gAjM7n3Zs_XapmMuS83A+X_yde5+iJ9F28SCfOCGA7Bdmg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-02-11 19:23 GMT+01:00 Alexander Shiyan <shc_work@mail.ru>:
> Hello.
Hi !
>
> ???????, 11 ??????? 2014, 18:45 +01:00 ?? Richard Genoud <richard.genoud@gmail.com>:
>> This patch add some helpers to control modem lines (CTS/RTS/DSR...) via
>> GPIO.
>> This will be useful for many boards which have a serial controller that
>> only handle CTS/RTS pins (or even just RX/TX).
>>
>> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
>> ---
>
> OK, a few comments below.
>
> ...
>> +config SERIAL_MCTRL_GPIO
>> +     def_bool y
>> +     depends on GPIOLIB
>
> I suggest to move GPIOLIB dependency to serial_mctrl_gpio.h header, so
> unit can be used with or without GPIOLIB, so Kconfig will look something like this:
>
> config SERIAL_MCTRL_GPIO
>   tristate
>
> Then, you can select this option for particular UART:
> config SERIAL_ATMEL
>   ...
>   select SERIAL_MCTRL_GPIO
Yes, you're right, it seems better like that.

> ...
>> +++ b/drivers/tty/serial/serial_mctrl_gpio.c
> ...
>> +static const char *mctrl_gpio_of_names[UART_GPIO_MAX] = {
>> +     "cts", "dsr", "dcd", "ri", "rts", "dtr"
>> +};
>
> Make a combined array. This will use cycles for set/get operations.
>
> static struct {
>   const char *name;
>   unsigned int mctrl;
> } mctrl_gpios[] = {
>   { "cts", TIOCM_CTS, },
>   ...
> };
yes, good idea !

> ...
>> +int mctrl_gpio_init(struct device *dev, struct mctrl_gpios *gpios)
>> +{
>
> I'm not sure whether to make a non-DT support at all ...
I don't understand what you mean.
You would like another _init() function for non-DT board ?
Well, I thought that non DT board could handle their GPIO init (like I
did in atmel_serial.c for platform_data based boards), but still use
the mctrl_gpio_{get,set} functions.


>> +     enum mctrl_gpio_idx i;
>> +     int err = 0;
>> +     int ret = 0;
>> +
>> +     for (i = UART_GPIO_MIN; i < UART_GPIO_MAX; i++) {
>> +             gpios->gpio[i] = gpiod_get(dev, mctrl_gpio_of_names[i]);
>
> What a reason to using gpiod_xxx() ?
> Why we cannot use standart devm_gpio_request/get/set etc. ?
Ah ! I missed devm_gpiod_get()
I'll use it.

>
> In addition, I recommend create this patch as separate,
> because it will most likely still be comments later.
Well, I'd rather not separate this patch from at least "patch 4/4
tty/serial: at91: use mctrl_gpio helpers"
because if the patch 4/4 is merged before this one, the compilation
will fail, and git bisecting will be a pain.
Or there's another solution ?

> Thanks.

Thanks !
