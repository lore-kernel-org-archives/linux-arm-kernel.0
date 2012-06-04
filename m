From: cavokz@gmail.com (Domenico Andreoli)
Date: Tue, 5 Jun 2012 01:34:11 +0200
Subject: [RFC 1/6] From: Domenico Andreoli <domenico.andreoli@linux.com>
 ARM: Inject the Earlycon drivers into the decompressor
In-Reply-To: <20120604084746.GA8262@n2100.arm.linux.org.uk>
References: <20120530224043.240221676@gmail.com>
 <20120530224043.582229064@gmail.com>
 <20120604084746.GA8262@n2100.arm.linux.org.uk>
Message-ID: <20120604233411.GA30600@glitch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 04, 2012 at 09:47:46AM +0100, Russell King - ARM Linux wrote:
> On Thu, May 31, 2012 at 12:40:44AM +0200, Domenico Andreoli wrote:
> > This linker voodoo clones the Earlycon drivers from the kernel into
> > the decompressor, selecting everything in the designated ELF sections
> > (.text.earlycon.info and .init.earlycon.info).
> 
> No, the debug stuff in the main kernel and the decompressor stuff can
> (and is in some cases) different.  There's a reason we have the two
> implementations separate.

Not to mention the discomfort to discover another debug i/o in head.S
used for a totally different purpose which, incidentally, includes the
same debug-macro.S of the main kernel early console.

I realized that something was wrong as soon as the code to parse earlyprintk
started to work, effectively enabling also the main kernel early console,
something I didn't truly want.

So yes, I got the point, they have different use cases and effectively cannot
use right the same bianry code. This is not the intent of the patch though.

The usage of the section cloning is not to keep and later reuse the
Earlycon built in the main kernel image. It's only to let that (source)
code live in a single place and not being replicated in those many haders.

Probably a similar result could be achieved shipping Earlycon as ordinary
library to the decompressor but it would loose the initial idea of fiddling
with the sections, which is where everything started from ;)

Plus some more Makefile paperwork to build the library for the decompressor,
which would pick all and only the wanted drivers (platform specific, common,
etc...) sticking the usual list somewhere/somehow in an old fashioned way
(yes, boring).

> Moreover, these two things operate in two different address spaces; the
> debug stuff in the kernel has to cope with the MMU being either on or
> off, and use the kernel v:p mappings when the MMU is on.  The decompressor
> on the other hand has a 1:1 v:p mapping when the MMU is on - so it
> would not be able to tell the difference if you just cloned the exact
> same code.

I think all this is not applicable to Earlycon because it is to be used
only by the the decompressor in whichever configuration the MMU is in
that instant.

It must be clear to the earlycon driver that nothing fancy should be done
there.  So if something is going to be broken because wrongs assumptions
are done on the MMU status, yes... sorry, you should be fiddling with a
couple of registers or a buffer and live with the base address you received
and stop there.

> One example of this would be RiscPC, where the decompressor writes to
> the framebuffer, but the debug stuff writes to the serial port.

Yes, clear. I never wanted to make this impossible.

> The preference is for the decompressor to write to the normal user visible
> interface when possible, and the debug stuff to a serial port.

So earlyprintk= is the wrong one, actually the decompressor/Earlycon should
use the same console= used by the kernel. How to map a console=ttyAMA0 to
to an amba-pl011 on board A and amba-pl010 on board B?


Now, putting aside this code (which I would be very happy could somehow end in
the kernel) which I made for fun, is this "Decompressing Linux..." so worthy?

BTW there is a similar (possibly critical) problem with arch_decomp_setup(),
often used to initialize the watchdog. We need to build many of them and
select the right one using the machid (or DT, how?) at boot. Would you
consider a patch approaching the problem in in the same fashion?

thanks,
Domenico
