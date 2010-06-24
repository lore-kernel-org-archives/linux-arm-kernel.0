From: lars@metafoo.de (Lars-Peter Clausen)
Date: Thu, 24 Jun 2010 10:20:35 +0200
Subject: [RFC PATCH] Rework gpio cansleep (was Re: gpiolib and
	sleepinggpios)
In-Reply-To: <70E876B0EA86DD4BAF101844BC814DFE08E0855B97@Cloud.RL.local>
References: <70E876B0EA86DD4BAF101844BC814DFE08E0855B97@Cloud.RL.local>
Message-ID: <4C231553.3030001@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jon Povey wrote:
> Ryan Mallon wrote:
>
>   
>> If we strip my patch back to just introducing gpio_request_cansleep,
>> which would be used in any driver where all of the calls are
>> gpio_(set/get)_cansleep, and make gpio_request only allow non-sleeping
>> gpios then incorrect use of gpios would be caught at request time and
>> returned to the caller as an error.
>>     
>
> It seems like a good idea to catch these at request time. There is support in the API for this already (gpio_cansleep), but driver writers are not steered towards checking and thinking in these ways by the current API or documentation. Perhaps a documentation change with some cut and paste boilerplate would be enough, but I think some API enforcement/encouragement would be helpful.
>
> I think this agrees with you, Ryan:
>
> gpio_request_cansleep would be the same as current gpio_request
> gpio_request changes to error if this is a sleepy gpio.
>
> Imagine a situation where GPIOs are being assigned and passed around between drivers in some dynamic way, or some way unpredictable to the driver writer. In development only non-sleeping GPIOs have been seen and everything is fine. One day someone feeds it a GPIO on an I2C expander and the driver crashes.
> If gpio_request had this built-in check the driver could gracefuly fail to load instead with an appropriate error message.
>
>
>   
Hi

Given that that most users will only access the gpios in context where
sleeping is possible it would make more sense to add a special case for
those who use it in contexts where sleeping is not possible.
This wouldn't change the semantics of the current API and furthermore it
is possible to implement it as a small helper function on top of the
current API.

Something like:
int gpio_request_atomic(unsigned gpio, const char *label)
{
    if (gpio_cansleep(gpio))
       return -EINVAL;
    return gpio_request(gpio, label);
}


- Lars
