From: bn@niasdigital.com (Ben Nizette)
Date: Thu, 21 Apr 2011 09:24:32 +1000
Subject: [PATCH 1/2] gpio: add pin biasing and drive mode to gpiolib
In-Reply-To: <BANLkTim-wSoL1anfNsu0PQZJFj5q3ZMSEw@mail.gmail.com>
References: <1303076273-8093-1-git-send-email-linus.walleij@stericsson.com>
	<3F5641E3-C443-4541-9FDA-24D215597C1F@niasdigital.com>
	<BANLkTim-wSoL1anfNsu0PQZJFj5q3ZMSEw@mail.gmail.com>
Message-ID: <D92E9D96-17D3-482D-803C-3D32FACF9AF7@niasdigital.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 20/04/2011, at 10:04 PM, Linus Walleij wrote:

> 2011/4/18 Ben Nizette <bn@niasdigital.com>:
>> 
>> On 18/04/2011, at 7:37 AM, Linus Walleij wrote:
>> 
>>> From: Linus Walleij <linus.walleij@linaro.org>
>>> 
>>> This adds two functions for struct gpio_chip chips to provide pin
>>> bias and drive mode settings for individual pins. Implementers does
>>> this a bit differently and usually there are a few possible modes you
>>> can select, I'm providing a few common modes for biasing and driving
>>> pins.
>>> 
>>> Since we have no previous hacked-up arch-specific drivers for this
>>> we can avoid any __override_functions and we just allow this to be
>>> properly implemented using gpiolib. Further the function is made
>>> non-mandatory, if it is not defined for the chip it will be silently
>>> ignored.
>> 
>> I don't like this much.  Why does the driver ever need to do this?  When
>> should a driver even try this this given you can't guarantee any results
>> and as such it's only ever a hint?
> 
> I don't get it. Who says the interface should be used by drivers?
> It could just as well (and much more likely) be the board code.

If the board code and the gpio code are both platform-specific then I didn't
see the point in this patch set when pure platform-only calls would do.  I
assumed then that the only people that would benefit from this API would be
those who didn't have access to the platform-specific one, i.e. the gpio
consuming drivers.

Turns out this isn't always the case, eg when the GPIO is off-SoC.  In that
case then it's certainly nicest to have an API like yours to deal with it.

In short, don't worry, I'm already more-or-less converted to the need for this
kind of API, it's just the form of it that I think should change a bit (as
discussed elsewhere in thread).

Thanks!
	--Ben.


> 
>> As far as I can see it would be
>> much much better if you just replaced
> 
>> 
>> platform_device_register(...)
>> 
>> with
>> 
>> set_up_pins(...)
>> platform_device_register(...)
>> 
>> in board code (or add a device tree, erm, leaf or whatever).
> 
> Yes that is one of the use cases for this patch set.
> We seem to be in 100% agreement :-)
> 
>> So in short - what's the use case?  Which driver requires this?
> 
> You just gave the use case yourself.
> 
> The intent of the patch set it to generalize the GPIO drivers
> so they can be pushed down into drivers/gpio/* where they
> belong.
> 
> Since only the individual GPIO driver knows for example where
> to find the memory-mapped I/O region it has to reside with
> the GPIO driver(s).
> 
> Even if these pin-specific calls are only called from board
> code the mechanism is still needed in order to move,
> consolidate and abstract the GPIO code into the gpio
> subsystem.
> 
> Yours,
> Linus Walleij
