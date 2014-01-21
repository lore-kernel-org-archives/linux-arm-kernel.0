From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 21 Jan 2014 10:26:29 +0100
Subject: More GPIO madness on iMX6 - and the crappy ARM port of Linux
In-Reply-To: <CAAVeFuJhYv_vKqgyyaw7LOzRvErjf4u=5jJCvpoEgA0ZsMj-1Q@mail.gmail.com>
References: <20140117184731.GE15937@n2100.arm.linux.org.uk>
 <52D98712.3070103@wwwdotorg.org>
 <20140117202405.GF15937@n2100.arm.linux.org.uk>
 <52D995C4.80104@wwwdotorg.org>
 <20140117205346.GH15937@n2100.arm.linux.org.uk>
 <CACRpkdaRQRD85-0wUmip=j1SHzti6Nb69JEUXznYTkrxGvky=A@mail.gmail.com>
 <CAAVeFuJhYv_vKqgyyaw7LOzRvErjf4u=5jJCvpoEgA0ZsMj-1Q@mail.gmail.com>
Message-ID: <CACRpkdZ-V=caNsR=WsMM1ZV+toydLpFD5ridszwRxz1ay-9RHw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 21, 2014 at 3:55 AM, Alexandre Courbot <gnurou@gmail.com> wrote:
> On Sat, Jan 18, 2014 at 7:43 AM, Linus Walleij <linus.walleij@linaro.org> wrote:

>> 1. Today this OPEN_DRAIN flag is not even passed down to
>> the driver so how could it say anything about it :-( it's a pure gpiolib
>> internal flag. We don't know if the hardware can actually even
>> do open drain, we just assume it can.
>>
>> What it should really do - in the best of worlds - is to check if
>> it can cross-reference the GPIO line to a pin in the pin control
>> subsystem, and if that is possible, then ask the pin if it
>> is supporting open drain and set it. It currently has no such
>> cross-calls, it is just assumed that the configuration is consistent,
>> and the actual pin is set up as open drain. But it would make
>> sense to add more cross-calls here, since GPIO is accepting
>> these flags (OPEN_DRAIN/OPEN_SOURCE).
>
> This would definitely work in the case of pinctrl-backed GPIOs, but
> would not cover all GPIO chips. If we want to cover all cases we
> should give drivers a way to way to report or enforce this capability,
> and make the pinctrl cross-reference one of its implementations where
> it can be done.

It can never be done in all cases, since in some cases the
open drain config is just a property of the line and not controlled
by software at all, and the datasheet just says this line is open
drain.

But we should cover the cases where we deal with pure
SW-controlled configs as far as possible.

>> Alexandre: do you have plans for how to handle a dynamic
>> consumer passing flags to its gpio request in the gpiod API?
>
> Do you mean like passing OPEN_DRAIN or OPEN_SOURCE flags to
> gpiod_get(), similarly to what is done for e.g. gpio_request_one()?

Yes...

> In the case of the gpiod API I would rather see these flags defined in
> the GPIO mapping if possible. For platform data it is already possible
> to specify open drain/open source, for DT this is trivial to add.

I figured so much. But we have a consumer in i2c-core.c doing
this for a valid reason.

> ACPI
> would be more of a problem here, but I'm not sure whether the problem
> is relevant for ACPI GPIOs.

ACPI has an open drain/source flag for some GPIO lines IIRC.

> 1) GPIO drivers' request() function get an extra flags argument that
> is passed by the GPIO core with the flags of the mapping. There we can
> define all the range of properties that gpio_request_one() supported.
> The driver's request() will fail it if cannot satisfy these
> properties. That's where the pinctrl cross-reference would take place.

I think this doesn't need to go all the way down into the driver
actually. We can call to pinctrl in the gpiolib core and
keep the gpiochip API simple. The GPIO driver doesn't even need
to know this.

> 2) All properties accepted by gpio_request_one() can also be passed
> through GPIO mappings. That is, probably platform_data and DT. I don't
> know if we ever get to use open drain GPIOs provided by ACPI, if we do
> then this might be a problem.

I think we need that.

>> Like:
>>
>> bool gpiod_input_always_valid(const struct gpio_desc *desc);
>>
>> And leave it up to the core to look at flags, driver characteristics
>> etc and determine whether the input can be trusted?
>
> I am personally a little bit scared by the number of exported
> functions in the GPIO framework. It is a pretty large number for
> something that is supposed to be simple, so I'd like to avoid adding
> more. :)

I objected already when the OPEN_DRAIN et al were added,
but to no avail...

> How about the following:
>
> 1) GPIOs configured as output without the open drain or open source
> flag either return -EINVAL on gpiod_get_value(), or a cached value
> tracked by gpiolib for consistency (probably the latter).

Make sense.

> 2) GPIOs configured as open drain or open source report the actual
> value read on the pin, like i2c-core needs. This requires that, for
> each GPIO that can be set open drain or open source,
> gpiod_input_always_valid() == true.

Yeah, but as seen from the I2C core, the algorithm there needs
to know if the input is always valid or not, and take different
execution paths depending on that. :-/

Yours,
Linus Walleij
