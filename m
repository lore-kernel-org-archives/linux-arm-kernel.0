From: highguy@gmail.com (Stijn Devriendt)
Date: Mon, 28 Jan 2013 12:30:29 +0100
Subject: [PATCH 1/6 v14] gpio: Add a block GPIO API to gpiolib
In-Reply-To: <51053268.2000002@antcom.de>
References: <1358856404-8975-1-git-send-email-stigge@antcom.de>
 <1358856404-8975-2-git-send-email-stigge@antcom.de>
 <CAOY=C6ERX=2HdvmtAW-__947_-P8r=Lvp88KzZDQdf4kAuRB5Q@mail.gmail.com>
 <51053268.2000002@antcom.de>
Message-ID: <CAOY=C6GReEpO7ukOS8WiQgdFFAreaYK1YrZ8HQrQ9dGMFObAdQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 27, 2013 at 2:58 PM, Roland Stigge <stigge@antcom.de> wrote:
> On 27/01/13 14:19, Stijn Devriendt wrote:
>>> +Block GPIO
>>> +----------
>>> +
>>> +The above described interface concentrates on handling single GPIOs.  However,
>>> +in applications where it is critical to set several GPIOs at once, this
>>> +interface doesn't work well, e.g. bit-banging protocols via grouped GPIO lines.
>>> +Consider a GPIO controller that is connected via a slow I2C line. When
>>> +switching two or more GPIOs one after another, there can be considerable time
>>> +between those events. This is solved by an interface called Block GPIO:
>>> +
>>> +struct gpio_block *gpio_block_create(unsigned int *gpios, size_t size,
>>> +                                    const char *name);
>>> +
>>> +This creates a new block of GPIOs as a list of GPIO numbers with the specified
>>> +size which are accessible via the returned struct gpio_block and the accessor
>>> +functions described below. Please note that you need to request the GPIOs
>>> +separately via gpio_request(). Similarly, the direction of the used GPIOs need
>>> +to be set by the user before using the block.
>>
>> Is there anything holding you back from letting gpio_block_create() do
>> the request
>> for all the pins?
>
> It's analoguous to plain GPIOs: They exist, but are not requested (by
> whom?) by default.
>

This is one of the warts of the GPIO API, if you ask me (and probably
others too).
Using a resource without allocating it first is just asking for
trouble. It's one of those
things pinctl was designed to solve... I've been thinking about
spending spare time
sending out patches converting all implicit requests and then removing
the implicit
request, but spare time is limited...

Regards,
Stijn

>> Also, wouldn't it make sense to have a gpio_block_direction_input()
>> and _output()
>> variant? On the other hand, for things like I2C and SPI emulation,
>> some pins will
>> naturally be always output (like clock lines) while other could be
>> switched between
>> in and output (like the i2c data line).
>
> Right. Current implementation emphasizes on switching, not direction or
> other convenience functions, which could be added, nevertheless.
>
> Roland
