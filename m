From: hpa@zytor.com (H. Peter Anvin)
Date: Tue, 14 Jun 2011 21:30:47 -0700
Subject: [RFC,PATCH] Cleanup PC parallel port Kconfig
In-Reply-To: <201106142333.16203.arnd@arndb.de>
References: <20110614190850.GA13526@linux-mips.org>
	<4DF7C3CA.9050902@zytor.com> <201106142333.16203.arnd@arndb.de>
Message-ID: <4DF83577.6040903@zytor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/14/2011 02:33 PM, Arnd Bergmann wrote:
>>
>> Why on earth restrict it like that?  It's just a device driver, like
>> more or less any other device driver...
> 
> I'd say any other classic ISA/PC driver, including floppy, gameport or
> serial-8250. One problem with these is that we never fully worked out
> the dependencies for these, which we probably should. CONFIG_ISA
> generally means ISA add-on cards, but that might not be enabled for
> platforms that have a pc-parport but no ISA slots.
> 

OK, serial-8250 is clearly just plain wrong, since the 8250 series UARTs
are ubiquitous across just about every platform.

Floppy is special (in the short bus sense), since it is closely tied to
ISA DMA.  Conditionalizing this on ISA DMA makes total sense.

Parallel port is an intermediate case... Centronics parallel ports
predate the PC ecosystem by quite a bit, and the particular arrangement
of ports became popular with the PC and spread to other platforms, but
the particular variant of it known as ECP (as opposed to EPP) is ISA DMA
specific.

> On the other hand, you have embedded platforms that currently build support
> for parport-pc but define the inb/outb macros to plain pointer dereferences
> (otherwise you can't build the 8250 driver). Loading parport-pc on those
> machines typically results in derefencing user memory in the best case.
>
> What I'd love to see is a configuration option for "arch has working
> PC-style inb/outb instructions", so we can build a kernel without them but
> still get MMIO based drivers for PCI-less platforms.

Now, isn't that was iowrite/ioread was designed for?

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
