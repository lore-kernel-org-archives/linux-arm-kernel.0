From: ryan@bluewatersys.com (Ryan Mallon)
Date: Fri, 18 Jun 2010 09:47:59 +1200
Subject: gpiolib and sleeping gpios
Message-ID: <4C1A980F.8080908@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Currently implementors of gpiolib must provide implementations for
gpio_get_value, gpio_set_value and gpio_cansleep. Most of the
implementations just #define these to the double underscore prefixed
versions in drivers/gpio/gpiolib.c. A few implementations have a simple
wrapper function which provides a fast path for the SoC gpios, and calls
gpiolib for the any additional gpios, such as those added by an io expander.

Although gpio_chips know whether or not they may sleep, gpios which can
sleep need to call gpio_[set/get]_value_cansleep. The only difference
between __gpio_(set/get)_value and gpio_(set/get)_value_cansleep is that
the cansleep versions calls might_sleep_if. Most drivers call
gpio_(get/set)_value, rather than the cansleep variants. I haven't done
a full audit of all of the drivers (which is a reasonably involved
task), but I would hazard a guess that some of these could be replaced
by the cansleep versions.

Would it not be simpler to combine the calls and have something like this:

void __gpio_get_value(unsigned gpio, int value)
{
	struct gpio_chip *chip;

	chip = gpio_to_chip(gpio);
	might_sleep_if(extra_checks && chip->can_sleep);
	chip->set(chip, gpio - chip->base, value);
}

Then all drivers can just call gpio_(set/get)_value and any attempts to
use sleeping gpios from an non-sleeping context will be caught by the
might_sleep_if check. Is there something I am missing about this?

I can prepare a patch which combines the non-sleeping and sleeping
variants, but I wanted to check that I'm not missing something
fundamental first.

Thanks,
~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
