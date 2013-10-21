From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 21 Oct 2013 21:05:44 +0100
Subject: [Ksummit-2013-discuss] ARM topic: Is DT on ARM the solution,
 or is there something	better?
In-Reply-To: <52646AF9.3050309@roeck-us.net>
References: <52644A9E.3060007@wwwdotorg.org>
 <20131020231134.GR25034@n2100.arm.linux.org.uk>
 <52646AF9.3050309@roeck-us.net>
Message-ID: <52658918.1060708@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/21/2013 12:44 AM, Guenter Roeck wrote:
> On 10/20/2013 04:11 PM, Russell King - ARM Linux wrote:
>> On Sun, Oct 20, 2013 at 10:26:54PM +0100, Stephen Warren wrote:
>>> The only thing we've really moved out of the kernel is the exact IDs of
>>> which GPIOS, interrupts, I2C/SPI ports the devices are connected to; the
>>> simple stuff not the hard stuff. The code hasn't really been simplified
>>> by DT - if anything, it's more complicated since we now have to parse
>>> those values from DT rather than putting them into simple
>>> data-structures.
>>
>> Here's my random thoughts this evening on DT, orientated mostly on a
>> problem area I've been paying attention to recently.
>>
>> In some ways, DT has made things much harder.  I don't know whether
> 
> On the other side, DT has made some things much simpler.
> 
> Problem case: Chip A's interrupt pin is connected to gpio pin of chip B.
> Chip B's interrupt pin is connected to a gpio pin on chip C. Chip C's
> interrupt pin is connected to the interrupt controller. Chips B and C
> are multi-function FPGAs. Exact gpio pins used vary from board to board.
> 
> With DT, this relationship is easy to describe, and none of the chip
> drivers
> really needs to know what is connected to what. Without DT, it would be
> much more complex.

I thought that was very easy with board files. For every chip that gets
instantiated, you tell it which base IRQ ID to use. For every chip that
outputs a IRQ, you tell it which IRQ ID that signal is, simply by adding
the recipient chip's IRQ base and an offset. That seems very simple. If
you don't want to add the base/offset together, we could always have
invented some lookup table similar to what regulators had, and pinctrl
has now, which says for each (device name, IRQ name/number) output,
here's the (device name, IRQ name/number) of the associated input.
