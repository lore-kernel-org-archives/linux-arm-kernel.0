From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 20 Apr 2011 14:04:47 +0200
Subject: [PATCH 1/2] gpio: add pin biasing and drive mode to gpiolib
In-Reply-To: <3F5641E3-C443-4541-9FDA-24D215597C1F@niasdigital.com>
References: <1303076273-8093-1-git-send-email-linus.walleij@stericsson.com>
	<3F5641E3-C443-4541-9FDA-24D215597C1F@niasdigital.com>
Message-ID: <BANLkTim-wSoL1anfNsu0PQZJFj5q3ZMSEw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/4/18 Ben Nizette <bn@niasdigital.com>:
>
> On 18/04/2011, at 7:37 AM, Linus Walleij wrote:
>
>> From: Linus Walleij <linus.walleij@linaro.org>
>>
>> This adds two functions for struct gpio_chip chips to provide pin
>> bias and drive mode settings for individual pins. Implementers does
>> this a bit differently and usually there are a few possible modes you
>> can select, I'm providing a few common modes for biasing and driving
>> pins.
>>
>> Since we have no previous hacked-up arch-specific drivers for this
>> we can avoid any __override_functions and we just allow this to be
>> properly implemented using gpiolib. Further the function is made
>> non-mandatory, if it is not defined for the chip it will be silently
>> ignored.
>
> I don't like this much. ?Why does the driver ever need to do this? ?When
> should a driver even try this this given you can't guarantee any results
> and as such it's only ever a hint?

I don't get it. Who says the interface should be used by drivers?
It could just as well (and much more likely) be the board code.

> As far as I can see it would be
> much much better if you just replaced

>
> platform_device_register(...)
>
> with
>
> set_up_pins(...)
> platform_device_register(...)
>
> in board code (or add a device tree, erm, leaf or whatever).

Yes that is one of the use cases for this patch set.
We seem to be in 100% agreement :-)

> So in short - what's the use case? ?Which driver requires this?

You just gave the use case yourself.

The intent of the patch set it to generalize the GPIO drivers
so they can be pushed down into drivers/gpio/* where they
belong.

Since only the individual GPIO driver knows for example where
to find the memory-mapped I/O region it has to reside with
the GPIO driver(s).

Even if these pin-specific calls are only called from board
code the mechanism is still needed in order to move,
consolidate and abstract the GPIO code into the gpio
subsystem.

Yours,
Linus Walleij
