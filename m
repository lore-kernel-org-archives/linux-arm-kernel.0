From: richard.genoud@gmail.com (Richard Genoud)
Date: Tue, 4 Mar 2014 12:37:59 +0100
Subject: [PATCH v5 1/3] tty/serial: Add GPIOLIB helpers for controlling
 modem lines
In-Reply-To: <1393846030.273217958@f113.i.mail.ru>
References: <1393845120-6340-1-git-send-email-richard.genoud@gmail.com>
 <1393845120-6340-2-git-send-email-richard.genoud@gmail.com>
 <1393846030.273217958@f113.i.mail.ru>
Message-ID: <CACQ1gAgURezr+Oqd6mX4D4K_C1LtmVh4a2fOnie0Xfj9sfYjQQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-03-03 12:27 GMT+01:00 Alexander Shiyan <shc_work@mail.ru>:
> Hello.
>
> ???????????,  3 ????? 2014, 12:11 +01:00 ?? Richard Genoud <noreply.rgenoud@gmail.com>:
>> This patch add some helpers to control modem lines (CTS/RTS/DSR...) via
>> GPIO.
>> This will be useful for many boards which have a serial controller that
>> only handle CTS/RTS pins (or even just RX/TX).
>>
>> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
> ...
>> +struct mctrl_gpios *mctrl_gpio_init(struct device *dev, unsigned int idx)
>> +{
>> +     struct mctrl_gpios *gpios;
>> +     enum mctrl_gpio_idx i;
>> +     int err;
>> +
>> +     gpios = devm_kzalloc(dev, sizeof(*gpios), GFP_KERNEL);
>> +     if (!gpios)
>> +             goto out;
>
> if (!gpios)
>   return ERR_PTR(-ENOMEM);
I think we are looping here...
If I returns a ERR_PTR(-ENOMEM), I'll have to change back all tests
from if (!gpios) to if (IS_ERR_OR_NULL(gpios))
So, I'll just return NULL here, and change the test in atmel_serial.c
(that was wrong anyway, as you pointed out)

>
>> +     for (i = 0; i < UART_GPIO_MAX; i++) {
>> +             gpios->gpio[i] = devm_gpiod_get_index(dev,
>> +                                                   mctrl_gpios_desc[i].name,
>> +                                                   idx);
>> +
>> +             /*
>> +              * The GPIOs are maybe not all filled,
>> +              * this is not an error.
>> +              */
>> +             if (IS_ERR_OR_NULL(gpios->gpio[i]))
>> +                     continue;
>> +
>> +             if (mctrl_gpios_desc[i].dir_out)
>> +                     err = gpiod_direction_output(gpios->gpio[i], 0);
>> +             else
>> +                     err = gpiod_direction_input(gpios->gpio[i]);
>> +             if (err) {
>> +                     dev_warn(dev, "Unable to set direction for %s GPIO",
>> +                              mctrl_gpios_desc[i].name);
>> +                     devm_gpiod_put(dev, gpios->gpio[i]);
>> +                     gpios->gpio[i] = NULL;
>> +             }
>> +     }
>> +
>> +out:
>> +     return gpios;
>> +}
>> +EXPORT_SYMBOL_GPL(mctrl_gpio_init);
>> +
>> +void mctrl_gpio_free(struct device *dev, struct mctrl_gpios *gpios)
>> +{
>> +     enum mctrl_gpio_idx i;
>> +
>> +     if (!gpios)
>> +             return;
>> +
>> +     for (i = 0; i < UART_GPIO_MAX; i++)
>> +             if (!IS_ERR_OR_NULL(gpios->gpio[i])) {
>> +                     devm_gpiod_put(dev, gpios->gpio[i]);
>> +                     gpios->gpio[i] = NULL;
>
> No need to NULL this variable. Instead, you should NULL
> "gpios" entirely at the end of this function.
that's right, setting to NULL here is now useless.

>> +             }
>> +     devm_kfree(dev, gpios);
>
> gpios = NULL;
> So this will indicate that its no more valid.
well, this won't help...
to do that, we'll have to pass a struct mctrl_gpios** instead of a
struct mctrl_gpios *

>> +}
> ...
>
> Thanks.
> ---

thanks !
