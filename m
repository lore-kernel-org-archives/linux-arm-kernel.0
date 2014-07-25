From: list-09_linux_arm@tqsc.de (Markus Niebel)
Date: Fri, 25 Jul 2014 14:52:05 +0200
Subject: [[RFC PATCH]] gpio: gpio-mxc: make sure gpio is input when request
 IRQ
In-Reply-To: <CACRpkdarH_-2uW55C5bAUxM1ESgSb6tJAWc4UqEoWr8uc_kQRQ@mail.gmail.com>
References: <1405518664-31313-1-git-send-email-list-09_linux_arm@tqsc.de>	<20140722062803.GA21229@dragon>	<53CE107A.1000000@tqsc.de>	<20140722074257.GC21229@dragon>	<CACRpkdYxOv+k2Sazm83sA=LwKUv5yMzag44A=Ez8pNQHRO3V6A@mail.gmail.com>	<53D0C008.70305@tqsc.de>
 <CACRpkdarH_-2uW55C5bAUxM1ESgSb6tJAWc4UqEoWr8uc_kQRQ@mail.gmail.com>
Message-ID: <53D252F5.2060601@tqsc.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 25.07.2014 13:38, wrote Linus Walleij:
> On Thu, Jul 24, 2014 at 10:12 AM, Markus Niebel
> <list-09_linux_arm@tqsc.de> wrote:
>> Am 23.07.2014 18:14, wrote Linus Walleij:
> 
>>> So always prepare the hardware and make it ready for action in respective
>>> callbacks from the GPIO and irqchip APIs. Do not rely on gpiod_to_irq() having
>>> been called first.
>>>
>>
>> So a gpio driver is responsible to read status of gpio lines and flag any gpio line
>> currently configured as out (base on the information read from hardware registers)
>> on driver probe time - correct?
> 
> I don't think anyone reads that information explicitly to set up
> these flags.
> 
> Drivers just leave the pins in their power-on maiden state without
> trying to figure out how they're set-up. But as you say, if you call
> gpiod_get_direction() on them, the flag gets set up indeed.
> 
> So usually these flags are set by code, calling
> gpiod_[get/set]_direction().
> Then they do get flagged as outputs or inputs.
> 
>> If yes is the driver allowed to call
>> gpiod_get_direction() to have the FLAG_IS_OUT set in the gpiolib layer?
> 
> I don't know if it'd be a good idea to loop over all gpios in a new
> irqchip and fetch the direction just to get the flags right, so far
> we haven't done that and I don't know what the usecase would be.
> 

I've came to a situation where it would have been helpful to know - bootloader
configured a pin as output and linux tried to configure the pin as IRQ input.
*YES I KNOW THIS IS NOT CORRECT* but it took some time to see, what happened.

> If we need that we should do it in gpiolib for all drivers don't you
> think?

A pragmatic / lean solution would be to deny the IRQ configuration when
seeing the pin configured as output in hardware and print out an error
on the gpio driver level.

> 
> But then we need a rationale for doing it, other than it's nice :-)
> It is already called on-the-fly by debugfs when a user needs that
> info.

See above, I think an error on a misconfigured system would be enough.
Maybe the documentation for gpio drivers should have a hint for driver
implementors.

So first step would be to convert the driver to the irqchip helper and then
add calls to gpiod_[un]lock_as_irq at the right places.

Will try to do that after my holiday.

> 
> Yours,
> Linus Walleij
> 
Yours,

Markus Niebel
