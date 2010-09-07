From: ryan@bluewatersys.com (Ryan Mallon)
Date: Wed, 08 Sep 2010 07:30:38 +1200
Subject: [PATCH] pio: add arch specific gpio_is_valid() function
In-Reply-To: <AANLkTinq98+ryOOKx1o1o21x9VnHz3nRCHh=5Wwixn4o@mail.gmail.com>
References: <4C85BEFD.402@bluewatersys.com>	<569801.35222.qm@web180310.mail.gq1.yahoo.com>
	<AANLkTinq98+ryOOKx1o1o21x9VnHz3nRCHh=5Wwixn4o@mail.gmail.com>
Message-ID: <4C8692DE.1020202@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

avictor.za at gmail.com wrote:
> hi,
> 
>> NAK still.  You're trying to abuse gpio_is_valid(),
>> which I see no need to support.
>>
>> In terms of GPIO framework architecture, zero is
>> the first GPIO in all cases, and is always
>> a valid GPIO number, even if it's not
>> requestable/swritable/readable on a given board.
>>
>> Whether it's usable on a given platform depends
>> on whether a GPIO controller is registered which
>> claims numbers 0..N ... (assuming gpiolib in use).
> 
> How should the following be done in a driver then?
> 
>    if (gpio_is_valid(device->output_pin)) {
>          if (gpio_request(device->output_pin, "driverX") != 0)
>              goto error_handling;
> 
>          /* continue with gpio setup */
>     }
>     else {
>         /* there is no vcc_pin, so don't do any gpio setup */

Adding:

	 device->output_pin = -EINVAL;

Will force the gpio to be invalid here, so that subsequent uses of
gpio_is_valid will behave as expected in the case where
device->output_pin >= 0, but doesn't map to a useable gpio.

>     }
> 
>     ....
> 
>    if (gpio_is_valid(device->output_pin)) {
>        /* set value high */
>    }

~Ryan
