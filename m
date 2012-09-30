From: highguy@gmail.com (Stijn Devriendt)
Date: Sun, 30 Sep 2012 17:11:01 +0200
Subject: [PATCH RFC 1/2] gpio: Add a block GPIO API to gpiolib
In-Reply-To: <5068204F.6090606@antcom.de>
References: <1348780923-27428-1-git-send-email-stigge@antcom.de>
 <20120928024744.GV17667@game.jcrosoft.org>
 <50654E57.3080201@antcom.de>
 <20120928075145.GW17667@game.jcrosoft.org>
 <50656522.1050900@antcom.de>
 <20120928090848.GX17667@game.jcrosoft.org>
 <20120928102822.GY17667@game.jcrosoft.org>
 <50658AD0.1050501@antcom.de>
 <20120928160105.GA17667@game.jcrosoft.org>
 <5065ED4F.5070700@antcom.de>
 <20120929195754.GC17667@game.jcrosoft.org>
 <5068204F.6090606@antcom.de>
Message-ID: <CAOY=C6ERUegNVbVST-OB0ztRYZJGD5g9-HTnASn7E3OaLfxXAA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 30, 2012 at 12:34 PM, Roland Stigge <stigge@antcom.de> wrote:
> On 29/09/12 21:57, Jean-Christophe PLAGNIOL-VILLARD wrote:
>>> Problem here is that it's only an intermediate format since hardware
>>> often needs special preparation of the data.
>>>
>>> But will evaluate what makes most sense.
>> the key point here is to avoid to manipualte data each time we call
>> gpio_block_set
>>
>> hardware specific will have to be handle at driver level
>
> Understand, thanks! I'm just trying to prevent overly complex API because:
>
> * In our discussed scheme, the driver still needs to convert the data bits
The u32 mask scheme fits simple-gpio drivers (1 register for input/output,
1 for direction, e.g. mpc8xxx driver) pretty well. Consider that to get
true synchronous output behavior of multiple pins, this is probably the only
option anyway.
For the cavium octeon driver (which doesn't seem to be upstream yet; sports
a single register for readout, per-pin write register) you can only emulate
group behavior by looping over the mask, without synchronous behavior.

> * In practice, the block gpio API is especially useful for use on single
> gpio_chips (only there, a real simultaneous i/o is possible anyway)
> * Wouldn't introduce this kind of optimization in lack of measurable
> improvement
> * The actual i/o data bits still need handling, generating a bit CPU
> load anyway.

I believe it's not worth it to try and save some tens of CPU cycles, considering
that GPIO pins might be on some slower bus anyway. Even then, simple-gpio
drivers have 0 added overhead, because they can use the mask
straight away. That means all processing is done in gpiolib's code and
is limited
to a loop of 32 iterations at most...

For drivers where performance really is critical, you could probably precompute
the needed values:
sclmask = gpio_group_precompute(MY_I2C_SCL)
sdamask = gpio_group_precompute(MY_I2C_SDA)
gpio_group_set_direct(sclmask | sdamask)

Regards,
Stijn
