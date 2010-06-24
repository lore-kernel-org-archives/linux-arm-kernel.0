From: ext-jani.1.nikula@nokia.com (Jani Nikula)
Date: Thu, 24 Jun 2010 11:29:42 +0300 (EEST)
Subject: [RFC PATCH] Rework gpio cansleep (was Re: gpiolib and
	sleepinggpios)
In-Reply-To: <70E876B0EA86DD4BAF101844BC814DFE08E0855B97@Cloud.RL.local>
References: <70E876B0EA86DD4BAF101844BC814DFE08E0855B97@Cloud.RL.local>
Message-ID: <alpine.DEB.2.00.1006241101240.11148@wnav-qrfxgbc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Thu, 24 Jun 2010, ext Jon Povey wrote:

> Ryan Mallon wrote:
>
>> If we strip my patch back to just introducing gpio_request_cansleep, 
>> which would be used in any driver where all of the calls are 
>> gpio_(set/get)_cansleep, and make gpio_request only allow non-sleeping 
>> gpios then incorrect use of gpios would be caught at request time and 
>> returned to the caller as an error.
>
> It seems like a good idea to catch these at request time. There is 
> support in the API for this already (gpio_cansleep), but driver writers 
> are not steered towards checking and thinking in these ways by the 
> current API or documentation. Perhaps a documentation change with some 
> cut and paste boilerplate would be enough, but I think some API 
> enforcement/encouragement would be helpful.
>
> I think this agrees with you, Ryan:
>
> gpio_request_cansleep would be the same as current gpio_request
> gpio_request changes to error if this is a sleepy gpio.
>
> Imagine a situation where GPIOs are being assigned and passed around 
> between drivers in some dynamic way, or some way unpredictable to the 
> driver writer. In development only non-sleeping GPIOs have been seen and 
> everything is fine. One day someone feeds it a GPIO on an I2C expander 
> and the driver crashes. If gpio_request had this built-in check the 
> driver could gracefuly fail to load instead with an appropriate error 
> message.

Hi -

There's no need to imagine such situations. It's not at all uncommon to 
request GPIOs in board files, and pass the already requested GPIO numbers 
to drivers. Replacing gpio_request() with gpio_request_cansleep() (or 
gpio_request_atomic() as suggested in another mail) in the board files 
does *nothing* to help such drivers use the correct gpio get/set calls. 
The driver will need to know what it's doing, in what contexts. Some 
drivers might not work with "sleepy" GPIOs, and that's fine - they can 
check using gpio_cansleep() and fail gracefully.

I'd just improve the documentation of the various calls and have gpiolib.c 
emit more warnings about incorrect use.


BR,
Jani.
