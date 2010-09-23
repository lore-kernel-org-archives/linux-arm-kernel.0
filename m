From: ben-linux@fluff.org (Ben Dooks)
Date: Fri, 24 Sep 2010 00:45:32 +0100
Subject: Regarding hw irq to Linux irq mapping on ARM
In-Reply-To: <AANLkTik8tGUwbch4OLShac8AqMu5+A9XgOk4uAZsYjxs@mail.gmail.com>
References: <AANLkTi=6nCJnfLB1uc0uLGOvOm0CX_R=j-8GQWTzmmep@mail.gmail.com>	<AANLkTimp7+BLNBwZyBiPS0JgB_mno+gp8+mK=VdOd3+_@mail.gmail.com>	<alpine.LFD.2.00.1009212342580.2416@localhost6.localdomain6>	<AANLkTinrfJkK85v2epOY95YWaVyMBcxSF2xakHqsM7vh@mail.gmail.com>	<1285133481.30449.170.camel@pasglop>
	<AANLkTik8tGUwbch4OLShac8AqMu5+A9XgOk4uAZsYjxs@mail.gmail.com>
Message-ID: <4C9BE69C.9070609@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/09/10 09:59, Eric Miao wrote:
> On Wed, Sep 22, 2010 at 1:31 PM, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
>> On Wed, 2010-09-22 at 00:08 -0300, Grant Likely wrote:
>>>> Add all the I2C, SPI based irq extenders to that list. They seem to
>>>> pop up all over the place in rapid speed even in x86. We are happy
>>>> citizens of the embedded horror^Wuniverse now.
>>>
>>> *shudder*
>>>
>>> What's the irq handling latency on those?  Glad I haven't had to deal
>>> with any of them yet.

Some new i2c busses can be in the MHz region, so not so slouchy.

>> And i2c in many cases want to be called from sleep'able context... might
>> be a good idea to restrict some of these to threaded interrupts. A whole
>> different discussion I suppose.

The i2c case, it is generally the code decoding the interrupt that needs
to do this, and is part of the i2c specific driver, and is written as
some form of thread or work-queue.

> 
> My problem is that ARM has only one IRQ line, and normally connected to
> a SoC specific IRQ controller, the mapping of the controller status bits
> into the linux IRQ number is currently handled in an assembly macro for
> performance consideration. This can be changed to using a function pointer
> for when mutliple SoCs are compiled [1].
> 
> All the other IRQs are actually chained to these first level IRQ numbers,
> so the other question is how these can be properly mapped. Currently, most
> ARM platforms handle this in board level. Taking an example of I2C GPIO
> expander pca953x.c, there is a 'irq_base' field in its platform data, this
> value could be different from board to board, and the board setup code has
> the responsibility to get it right. Other devices having a resource can be
> passed the correct IRQ number in its resource array.

Well, this is generally because it was (and maybe still is) to
dynamically get an interrupt number. It would be really useful
to update the IRQ system to allow dynamic interrupt addition.

There are times when it would be useful to have a usb driver
detect a plugin, allocate an interrupt and then register that
with some other part of the system, as one exapmple.
