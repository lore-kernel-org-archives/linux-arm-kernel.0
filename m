From: richard.genoud@gmail.com (Richard Genoud)
Date: Thu, 27 Feb 2014 09:43:28 +0100
Subject: [PATCH v4 1/5] tty/serial: Add GPIOLIB helpers for controlling
 modem lines
In-Reply-To: <1393432624.955150590@f282.i.mail.ru>
References: <1393431588-25977-1-git-send-email-richard.genoud@gmail.com>
 <1393431588-25977-2-git-send-email-richard.genoud@gmail.com>
 <1393432624.955150590@f282.i.mail.ru>
Message-ID: <CACQ1gAhF805ZjPGenb7UWi6z4jMF+p2bW8Z63DfMtNuyB5BLkg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-02-26 17:37 GMT+01:00 Alexander Shiyan <shc_work@mail.ru>:
> Hello Richard.
>
> ?????, 26 ??????? 2014, 17:19 +01:00 ?? Richard Genoud <richard.genoud@gmail.com>:
>> This patch add some helpers to control modem lines (CTS/RTS/DSR...) via
>> GPIO.
>> This will be useful for many boards which have a serial controller that
>> only handle CTS/RTS pins (or even just RX/TX).
>>
>> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
>
> Better, but I found few bugs... :)
> ...
>> +Modem control lines via GPIO
>> +----------------------------
>> +
>> +Some helpers are provided in order to set/get modem control lines via GPIO.
>> +
>> +mctrl_gpio_init(dev, idx):
>
> I think we should indicate variable types used in these functions.
In the whole file, the variable type are not indicated. So, for
consistency, I think it's better like that.

 ...
>> +void mctrl_gpio_set(struct mctrl_gpios *gpios, unsigned int mctrl)
>> +{
>> +     enum mctrl_gpio_idx i;
>> +
>> +     if (IS_ERR_OR_NULL(gpios))
>> +             return;
>
> No. IS_ERR_OR_NULL() is not valid here. This is allocated by kzalloc(),
> so you should check valid pointer only, ie (!gpios).
> Same in other places.
You're right !

>
>> +             if (err) {
>> +                     dev_err(dev, "Unable to set direction for %s GPIO",
>> +                             mctrl_gpios_desc[i].name);
>> +                     devm_gpiod_put(dev, gpios->gpio[i]);
>> +                     gpios->gpio[i] = NULL;
>> +             }
>> +     }
>
> Let's use dev_dbg().
Why dbg ? I agree that _err may be a bit strong, we could use
dev_warn() instead.
But as it really should not happen, I'm a bit reluctant to set it as debug.
Or have you something else in mind ?

> Thanks.
> ---

Thanks for reviewing !
