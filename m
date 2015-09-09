From: eric@anholt.net (Eric Anholt)
Date: Tue, 08 Sep 2015 18:48:07 -0700
Subject: [PATCH v5 0/6] bcm2835: auxiliar device support for spi
In-Reply-To: <1441359711-2800-1-git-send-email-kernel@martin.sperl.org>
References: <1441359711-2800-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <87h9n4weg8.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

kernel at martin.sperl.org writes:

> From: Martin Sperl <kernel@martin.sperl.org>
>
> The BCM2835 contains 3 auxiliar devices:
> * spi1
> * spi2
> * uart1
>
> All of those 3 devices are enabled/disabled via a shared register,
> which is set by default to be disabled.
>
> Access to this register needs to get serialized.
>
> So after several iterations of discussions with the following ideas:
> * syscon - device tree should describe HW not drivers to use -
>            'compatiblity = "brcm,bcm2835-aux-enable", "syscon";'
>            is not acceptable
> * regulator - it is not necessarily a regulator or a power gate
>               that is implemented in HW, so it is not valid to use
>               this framework
>
> The recommendation was made to create a new minimal API in soc
> just for access to this shared enable/disable register.
>
> This patch-series implements:
> * the bcm2835-auxiliar device enable/disable api in soc.
> * the bcm2835-auxiliar spi device driver
>
> The uart1 device driver (ns16550 based) is not implemented so far
> but would be using the same API.
>
> Both spi and uart drivers can run with shared interrupts,
> so there is no need for an interrupt-controller to get implemented.

I finally had a chance to sit down and look at what the hardware's doing
with the enable bit (also, I've read a whole lot more of the hardware
now, so I'm a lot faster at answering questions like this).  The enable
bits are a clock gate off of the VPU clock.

I knocked together the enable bits as a clock gate driver, since I'd
just written very similar code for the audio domain clock driver (and I
assume you are grumpy about how much time you've spent on this one
stupid register).  It's up at
https://github.com/anholt/linux/tree/bcm2835-clock-aux and I can submit
it if you like the result.  I've compile tested it only, but I'm hoping
you could just drop your aux SPI driver on top of it and have things
work.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150908/1bb7fdb0/attachment-0001.sig>
