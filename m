From: richard.genoud@gmail.com (Richard Genoud)
Date: Mon, 17 Nov 2014 10:26:17 +0100
Subject: [PATCH] gpio: mxs: implement get_direction callback
In-Reply-To: <54693A51.5080907@elproma.com.pl>
References: <1416004026-9667-1-git-send-email-j.uzycki@elproma.com.pl>
 <20141114232601.GW27002@pengutronix.de> <5467A980.5090204@elproma.com.pl>
 <20141116214239.GX27002@pengutronix.de> <54693A51.5080907@elproma.com.pl>
Message-ID: <CACQ1gAjpXnnUPOj3paMGeB=NeQWR_7p6k8WPdxS9YzLakphBhw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-11-17 0:59 GMT+01:00 Janusz U?ycki <j.uzycki@elproma.com.pl>:
>
> W dniu 2014-11-16 o 22:42, Uwe Kleine-K?nig pisze:
>>
>> Hello Janusz,
>>
>>
>> On Fri, Nov 14, 2014 at 11:27:06PM +0100, Janusz Uzycki wrote:
>>>>>
>>>>> Function gpiod_get_direction() of gpiolib calls get_direction()
>>>>> callback. If chip doesn't implement it EINVAL error is returned.
>>>>> The function doesn't use for returned value shadowed FLAG_IS_OUT
>>>>> bit of gpio_desc.flags field so the callback is required.
>>>>
>>>> This sounds like a bugfix but "required" is wrong as AFAIR this call is
>>>> optional and hardly used. Or did that change? The only drawback is that
>>>> the debug output for (by Linux) uninitialized gpios is wrong.
>>>
>>> Yes, the callback is optional but gpiod_get_direction() doesn't work
>>> without it.
>>> gpiod_get_direction() doesn't seem optional,
>>> Documentation/gpio/consumer.txt:
>>> "A driver can also query the current direction of a GPIO:
>>>           int gpiod_get_direction(const struct gpio_desc *desc)
>>> This function will return either GPIOF_DIR_IN or GPIOF_DIR_OUT.
>>> Be aware that there is no default direction for GPIOs. Therefore,
>>> **using a GPIO
>>> without setting its direction first is illegal and will result in
>>> undefined
>>> behavior!**"
>>> There is nothing about EINVAL error. It happens despite direction was
>>> set before. The reason is undefined get_direction callback.
>>
>> I still think you must not rely on gpiod_get_direction working. Some
>> controllers might not be able to provide this info and if you know that
>> the direction was set before, there is no need to ask the framework.
>> (Although I admit it might be comfortable at times.)
>>
>>> The commit f9e42397d79b6e810437ba1130b0b4b594f5e56c
>>> ("serial: mxs-auart: add interrupts for modem control lines")
>>> is based on Richard's commit ab5e4e4108ca5d8326cb6b4b3a21b096a002f68f
>>> ("tty/serial: at91: add interrupts for modem control lines").
>>> Both patches use the condition:
>>> "if (gpiod && (gpiod_get_direction(gpiod) == GPIOF_DIR_IN))"
>>
>> This is broken. Actually you want to loop only over the functions in
>> mctrl_gpios_desc that are inputs (i.e. CTS, DSR, DCD and RNG) and don't
>> depend on the hardware state and/or a working gpiod_get_direction.
>>
>> For that another mctrl_ helper function would be nice that does the
>> required request_irqs for a given struct mctrl_gpios pointer. That would
>> be more valuable than adding the same boilerplate to another driver.
>> Also note that there is nothing special required in the irq handler in
>> this case, just passing your struct uart_port is enough. That also has
>> the nice side effect that not the complete driver's logic to dissect the
>> irq reason is needed and so probably all drivers using that mctrl_gpio
>> stuff could be simplified.
>>
>> [...]
>>
>>
>>> at91 had defined get_direction() callback, mxs platform not.
>>> The condition helps to find gpio-inputs to set them as interrupts.
>>>
>>> Likely gpiod_get_direction() was used because
>>> drivers/tty/serial/serial_mctrl_gpio.c
>>> has no function to read back "dir_out" from mctrl_gpios_desc table.
>>>
>>> There were the ways to fix it:
>>> a) add to serial_mctrl_gpio.c function to read the "dir_out" and use
>>> it instead of
>>>      gpiod_get_direction()
>>> if gpiod_get_direction() still used in the condition:
>>> b) modify gpiod_get_direction() implementation in gpiolib.c:
>>>      if get_direction() callback is not defined use shadow flag
>>> (FLAG_IS_OUT)
>>
>> That would be broken.
>>
>>> c) modify drivers/gpio/gpio-generic.c:
>>>     bgpio_init() could assign to get_direction default callback
>>>     if BGPIOF_UNREADABLE_REG_DIR is not set
>>
>> Not sure this would be correct. I pass the question to Linus.
>>
>>> d) implement get_direction callback in gpio-mxs.c
>>
>> My suggestion isn't included in your list and IMHO is the best.
>>
>>> Solution d) was selected because it is safe for other drivers.
>>
>> That's a poor argument. Sure, implementing a generic solution that is
>> used on several platforms is not "safe" as you probably cannot test them
>> all. But the result is better: More generic code, more people using it
>> and so find the bugs in it.
>>
>>> Although a) and b)
>>> are also nice the patch doesn't modify neither serial_mctrl_gpio.c and
>>> atmel_serial.c nor gpiolib.c. It focuses on mxs platform as needed for
>>> the commit "serial: mxs-auart: add interrupts for modem control lines".
>>
>> I wouldn't call a) nice because in the presence of my suggested solution
>> there is no need for a driver to use this function. b) is broken and so
>> cannot be nice.
>
>
> Thanks Uwe. I fully agree with you.
> a) was just a starter to your suggestion. My options were too conservative -
> I just
> wanted to avoid tests on hardware I don't have.
> I don't understand why gpiod_get_direction() always requires the callback
> and b) would be broken (I'm not so familiar with gpiolib) but I don't need
> it now.
>
> So, it looks we can drop the gpio-mxs patch, yes?
> And, I or Richard should submit a patch for
> mctrl_gpio/atmel_serial/mxs-auart
> to introduce the irq helper, yes?
You're welcome to do it !
At the time the mctrl_helpers were introduced, there was only one user
(atmel_serial), so the line between specific code and factorizable
code was not so clear.
But clearly, the more we factorize, the better !

> You wrote passing uart_port is enough. Argument "name" for request_irq() can
> be
> recovered from dev_name(dev) or dev_driver_string(dev)  where dev =
> port_uart->dev.
And, honestly, I'm not sure dev_name(dev) is a good name.
Having something like dev_name(dev)_port_id_CTS may be better.

> But irqhandler and mctrl_gpios must be passed to mctrl_gpio_request_irqs()
> helper.
> The gpio_irq table could be hidden and moved into struct mctrl_gpios. Then
> a second helper function is required: mctrl_gpio_free_irqs().
> gpio_irq table initialized in mctrl_gpio_request_irqs().
>
> So finally the prototypes would be:
> int mctrl_gpio_request_irqs(struct mctrl_gpios*, struct uart_port*,
> irqhandler_t);
> void mctrl_gpio_free_irqs(struct mctrl_gpios*);
>
> Richard, what do you think about?
Seems ok !

Richard.
