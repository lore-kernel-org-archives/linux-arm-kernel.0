From: lars@metafoo.de (Lars-Peter Clausen)
Date: Thu, 24 Jun 2010 12:31:13 +0200
Subject: [RFC PATCH] Rework gpio cansleep (was Re: gpiolib and
	sleepinggpios)
In-Reply-To: <alpine.DEB.2.00.1006241101240.11148@wnav-qrfxgbc>
References: <70E876B0EA86DD4BAF101844BC814DFE08E0855B97@Cloud.RL.local>
	<alpine.DEB.2.00.1006241101240.11148@wnav-qrfxgbc>
Message-ID: <4C2333F1.6050102@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jani Nikula wrote:
>
> On Thu, 24 Jun 2010, ext Jon Povey wrote:
>
>> Ryan Mallon wrote:
>>
>>> If we strip my patch back to just introducing gpio_request_cansleep,
>>> which would be used in any driver where all of the calls are
>>> gpio_(set/get)_cansleep, and make gpio_request only allow
>>> non-sleeping gpios then incorrect use of gpios would be caught at
>>> request time and returned to the caller as an error.
>>
>> It seems like a good idea to catch these at request time. There is
>> support in the API for this already (gpio_cansleep), but driver
>> writers are not steered towards checking and thinking in these ways
>> by the current API or documentation. Perhaps a documentation change
>> with some cut and paste boilerplate would be enough, but I think some
>> API enforcement/encouragement would be helpful.
>>
>> I think this agrees with you, Ryan:
>>
>> gpio_request_cansleep would be the same as current gpio_request
>> gpio_request changes to error if this is a sleepy gpio.
>>
>> Imagine a situation where GPIOs are being assigned and passed around
>> between drivers in some dynamic way, or some way unpredictable to the
>> driver writer. In development only non-sleeping GPIOs have been seen
>> and everything is fine. One day someone feeds it a GPIO on an I2C
>> expander and the driver crashes. If gpio_request had this built-in
>> check the driver could gracefuly fail to load instead with an
>> appropriate error message.
>
> Hi -
>
> There's no need to imagine such situations. It's not at all uncommon
> to request GPIOs in board files, and pass the already requested GPIO
> numbers to drivers. Replacing gpio_request() with
> gpio_request_cansleep() (or gpio_request_atomic() as suggested in
> another mail) in the board files does *nothing* to help such drivers
> use the correct gpio get/set calls. The driver will need to know what
> it's doing, in what contexts. Some drivers might not work with
> "sleepy" GPIOs, and that's fine - they can check using gpio_cansleep()
> and fail gracefully.
Is there a reason, why a gpio is requested in the board file and not in
the driver? I would have considered that the later is far more common.

Sure, drivers which do not request the gpios themselves would have to
call gpio_cansleep, but for those which request the gpios themselves it
would help to reduce code clutter to have a gpio_request_atomic. The
only argument speaking against adding such a helper function would be
that drivers accessing gpios in contexts where they can not sleep are
far to rare to bother.

- Lars
