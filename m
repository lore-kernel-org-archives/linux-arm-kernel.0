From: ryan@bluewatersys.com (Ryan Mallon)
Date: Thu, 10 Dec 2009 12:40:37 +1300
Subject: GPIO support for HTC Dream
In-Reply-To: <4B1ECEEE.3000209@bluewatersys.com>
References: <20091208102842.GH12264@elf.ucw.cz>	<4B1EB57D.6070408@bluewatersys.com>	<20091208214658.GC4164@elf.ucw.cz>
	<4B1ECEEE.3000209@bluewatersys.com>
Message-ID: <4B203575.6050407@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ryan Mallon wrote:
> Pavel Machek wrote:
>> Add GPIO support for HTC Dream.
>>
>> Signed-off-by: Pavel Machek <pavel@ucw.cz>
>>
>> +int register_gpio_chip(struct gpio_chip *new_gpio_chip)
>> +{

...

> 
> This is still really screwy. Why are you creating your own version of
> struct gpio_chip in addition to the one in include/asm-generic/gpio.h
> (which you also appear to include in some places). It makes the code
> extremely confusing. Other architectures use wrapper structures. Can you
> have something like this instead:
> 
> 	struct dream_gpio_chip {
> 		struct gpio_chip chip;
> 
> 		/* Dream specific bits */
> 	};
> 
> The name of this function also needs to be changed to something less
> generic since it is being exported globally.
> 
> I also think this function is doing way to much work for what it is.
> Does it really need to be this complicated?

Further to this, I think it is worth doing the work to make this gpiolib
now. Most of the other ARM chips now support gpiolib, so it would seem a
bit of a step backwards to start adding new chips which don't. I think
that adding the gpiolib support will also cleanup the mess that is
register_gpio_chip, since this is all already handled by the gpiolib core.

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
