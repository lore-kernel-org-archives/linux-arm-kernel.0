From: h.feurstein@gmail.com (Hubert Feurstein)
Date: Fri, 13 Nov 2009 12:32:41 +0100
Subject: ARM: big performance waste in memcpy_{from,to}io
In-Reply-To: <ol1us6-035.ln1@chipmunk.wormnet.eu>
References: <200911121749.49676.h.feurstein@gmail.com>
	<ol1us6-035.ln1@chipmunk.wormnet.eu>
Message-ID: <200911131232.41716.h.feurstein@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 12. November 2009 19:44:40 schrieb Alexander Clouter:
> > Are there any drawbacks when using the good-and-fast "memcpy" ? On my
> > Micro9- board everything is running fine so far.
> 
> From the small bit of MTD work I have done, some NAND's (and I guess
> NOR's too) do *not* support 32bit wide read's.  For example, if I
> remember correctly, the NAND driver for orion will let you read 32bits
> but write only 8bits at a time.  Other platforms are only 8bit wide in
> both direction.  I guess the 'slow' memcpy version is used as
> *everything* supports 8bit reads....I *guess* :)
> 

The Spansion NOR Flashes (like S29GL...) have a 16bit wide data bus, by using 
two in parallel it looks like a 32bit-flash for the system. So 32bit reads 
from the flash works just fine. But in fact that is not the point at all. And 
it is not an issue of the mtd-driver, that's why I have posted this only to 
the arm-linux-mailinglist and not to the mtd-list.

The memcpy_{to,from}io-function don't has to care about the bus-width of the 
attached peripheral, because this is already handled correctly by the static 
memory controller of your arm-derivate (Of course this one has to be 
configured correctly to the peripherals bus width). In the rare case where you 
have to take care about that it is anyway a bad idea to use a memcpy_xxio-
function.

I've checked the implementations of some other architectures. And a lot of 
them already have optimized memcpy_{from,to}io functions:

	- alpha/io.c
	- parisc/lib/io.c
	- powerpc/kernel/io.c
	- avr32/include/asm/io.h
	- blackfin/include/asm/io.h
	- cris/include/asm/io.h
	- frv/include/asm/io.h
	- h8300/include/asm/io.h
	- m32r/include/asm/io.h
	- m68k, microblaze, mips, mn10300, ...

One architecture which also uses the simple and slow version is 'sh' (and 
maybe there are a few others).

Just want to ask the community if there is a really good reason why this 
bottle neck is still in the ARM kernel?

@Russell: What's your opinion on that?

best regards
Hubert
