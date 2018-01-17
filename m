From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Wed, 17 Jan 2018 18:07:02 +0200
Subject: [RFC PATCH 1/2] pinctrl: add consumer variant for gpio request
In-Reply-To: <20180117145458.GO2989@rfolt0960.corp.atmel.com>
References: <20180115162233.6205-1-ludovic.desroches@microchip.com>
 <20180115162233.6205-2-ludovic.desroches@microchip.com>
 <CAHp75VdGp1_hwK7rUq4u_gKpypdV7LYhV4+kQoVb_u7D+a6pwA@mail.gmail.com>
 <20180116090109.GL2989@rfolt0960.corp.atmel.com>
 <CAHp75Vd9qrp_gjMcZAHQrg8BsG5zQC6jZrkseo222=Xepce+ew@mail.gmail.com>
 <20180117145458.GO2989@rfolt0960.corp.atmel.com>
Message-ID: <CAHp75Ve=ar=FRVA7GE5nJkJnuPztz2nXzvV=-SppC3c4JxOswQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 17, 2018 at 4:54 PM, Ludovic Desroches
<ludovic.desroches@microchip.com> wrote:
> On Tue, Jan 16, 2018 at 04:33:29PM +0200, Andy Shevchenko wrote:

>> First of all, the main architectural issue with current pin control
>> design is so called "states". It's quite artificial entity which is
>> not represented by hardware per se.
>>
>> Instead we better to provide an API to pin configuration and pin
>> muxing: I would like to switch to *this* pin function with *this* pin
>> configuration.

> gpio_request_enable() allows to switch to the GPIO pin function.

...as a particular case of "set this pin to this function".

> To clarify the situation, from my point of view there are two issues:
>
> - Several pin controllers didn't enabled the strict mode when they were
>   introduced. Nowadays, enabling it will break several DTs. Maybe a DT
>   property to enable/disable strict mode could do the trick: we remove
>   pinctrl nodes (so pinmux + pinconf) for pins which will be requested
>   by gpiod_request() and we set the strict property to true.

OK.

> - But... The GPIO pin configuration is missing.

Here you mixed up the things. Either we are talking about GPIO
configuration (direction, enabling/disabling I/O buffers), or we are
talking about pin configuration (bias, drive strength, slew rate,
debounce, etc.).

>  Some configuration features
>   have been added, we can continue to add new ones but I am not sure
>   it's the best solution.

See below.

>  At the moment, we rely on a single cell to
>   manage the configuration. It may not be enough and each time a new pin
>   configuration will appear, it will have to be added both to the gpiolib
>   and pinconf.

>> Second, the pin control and GPIOs are orthogonal as your hardware
>> confirms. The propagating pin configuration or muxing via GPIO API
>> looks to me a wrong direction.
>>
>
> I agree but it seems we have started to follow this path.

Which is still wrong and nothing prevents us to just stop here and
consider better way.

The issue is how we historically represent pins inside kernel and how
hardware evolves at the same time.

Looking from now retrospectively I can state the following:
- each GPIO controller *might* have (few) capabilities of pin configuration
- pin control may not necessary have GPIO function of the pin

Design is now GPIO oriented while it should be pin oriented.

So, instead of littering GPIO API, would we consider to redesign a bit
from the above point of view?

(Read ahead: to be backward compatible and be more friendly for simple
GPIO IPs it would make sense to leave some of the basic pin properties
to be controlled from GPIO API, otherwise forget completely about GPIO
driver, and think of pin control driver for new complex IPs)

[pin]: might have attached set of functions, set of [electrical] properties.
It might be re-configured run time in terms of function and configuration.
It might have none, one, or more owners (this is already an OS abstraction)

Thus, the core function is pin request, while GPIO request is just a
particular case.
Owner of the pin is defined independently on what function or
configuration is chosen.

Therefore, we will have something like this (permissions):
- none (no one can do anything, except acquiring an ownership == requesting pin)
- exclusive (only one user allowed to cover all properties of the pin)
- shared (several owners can do modify all or selected properties)
- shared for all (anyone can do anything, perhaps we don't need this)

>> To the point of the specific issue you are trying to solve.  I would
>> rather agree with Maxime:
>>
>> "Something like "if the configuration is a gpio, and my pinctrl driver
>> is also a gpio controller, and that gpiod_request is being called on
>> that pin, hand over the reference"

> Sorry, what do you see behind "hand over the reference"?

This is similar to what I called before as "shared" ownership. To be
precise, transformation "exclusive" to "shared".

>> Just in case of architectural review imagine a below case. We have two
>> UART devices which share same pins, and at the same time their pins
>> can be switched to GPIO function. So, use cases and questions:
>> - allow potential driver to switch between UARTs at run time
>> - allow UART driver to switch mode between no flow control (2 wire
>> mode) and HW flow (4 wire mode), though not specifically at run time
>> - allow GPIO function for some pins at run time to support OOB wake
>> up, for example, when UART is a console
>>
>
> I have the feeling that 1 and 2 are achievable with pinctrl states. 3 may be
> also acheviable excepting if the pin is part of a pinctrl state.

Please, no artificial states here. It brings more issues than solves.
Deterministic is:
- pin electrical properties
- current (active) function
- current (active) owner(s)

Whatever currently means "states" they are defined per owner basis.

>> More caveats:
>> - switching and reconfiguring pins at run time is a bad idea for the
>> start (only some exceptions can be applied, see above) because of
>> electrical properties of the devices and potential damage to the
>> hardware
>> - switching to GPIO is allowed at run time for the purpose of OOB wake source
>> - after switching to GPIO and freeing it the pin configuration (and
>> perhaps muxing) would return back to previous (before GPIO) settings
>> (this would be helpful to case described above: OOB wake up)
>>
>
> I share another case which is the one motivating me to do these patches.
>
> I am writing a driver for a new device which uses several lines. The lines used
> depends on the firmware loaded so there is no reason to reserve all the
> lines and so the pins corresponding to these lines.

Reserve how? In DT?

> The pins will be requested as GPIOs because the pin controller in this specific
> case is bypassed. I mean, if the device uses a line, it will take the ownership
> even if it is muxed to a function. I want to prevent this.

Yes, valid point.

> Before using the line, I'll request the pin as a GPIO. If an error occurs (this
> is why I need to enable the strict mode), it means the pin is already muxed and
> we are going to break the device which uses it.

Correct, or any other function.

What we need is pin_request_function() API and pin_set_config(). GPIO
is kinda legacy (in terns of configuring and controlling pins).

So, consider my idea above about ownership. It would give you less
pain how to proceed with pins. In DT or ACPI we may supply a property
to tell OS how ownership has to be handled:
strict (or "exclusive", one owner for pin properties), "shared", or
"none" (not requested, first come, first served)

Yes, pin function might need a special type of owners to do power
management, for example, but in above scheme it would be just a
subtype of "shared" (okay, "strict" in that way also would "shared"
but only for PM core).

-- 
With Best Regards,
Andy Shevchenko
