From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 11 Dec 2012 16:46:08 +0000
Subject: [RFC v1 01/16] lib: devres: don't enclose pcim_*() functions
 in CONFIG_HAS_IOPORT
In-Reply-To: <20121211173013.0ceea196@skate>
References: <1354917879-32073-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201212111043.50627.arnd@arndb.de> <20121211170338.4859ddf0@skate>
 <201212111615.03262.arnd@arndb.de> <20121211173013.0ceea196@skate>
Message-ID: <20121211164608.GT14363@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 11, 2012 at 05:30:13PM +0100, Thomas Petazzoni wrote:
> arch/arm/mm/iomap.c is unconditionally compiled in all ARM kernels. And
> in this file, ioport_map() and ioport_unmap() are implement as soon as
> __io is defined. And basically, in arch/arm/include/asm/io.h, __io is
> defined for all platforms

That's an unfortunate side-effect of the single-zImage effort.

>, except maybe on some platforms having their
> own mach/io.h file, but those are quite limited in number (ebsa110, rpc,
> at91, s3c24xx, pxa, omap1, footbridge and ixp4xx). So if __io is
> defined, says on VEXPRESS, why does it "select NO_IOPORT" ? Essentially
> all ARM platforms should select HAVE_IOPORT, except the few ones that
> don't define __io. Correct?

No they damned well should not; it actively _breaks_ at least some of the
platforms you list above.

This whole area is a massive can of worms caused by people over the
years just not understanding what an x86 IO port is and how to deal
with it.  It's very simple.  The IO port space is for ISA/PCMCIA and
PCI IO port regions.  It is nothing more than that.

It's there because when you have a PCI peripheral in your system, you
need to set it up, and the address space used for IO ports is entirely
separate from that used for the rest of the memory mapped IO.  You
can't mix the IO ports amongst the MMIO ports - because most host PCI
bridges will only let you map into MMIO space one region of PCI IO
space.

The ISA case is a little harder to see, but believe me when I say that
in the early days of Linux, we used talk to all ISA chips on platforms
without ISA buses using the inb/outb/etc macros and it turned into one
hell of a disgusting mess.  Now these platforms all use the regular
readb/writeb acros and ioremap() for their accesses which has resulted
in much cleaner solutions - the result of that is these platforms no
longer need the "ISA IO space" region, so providing ISA IO space support
is additional unnecessary work for them.

Plus, if you _have_ IO space support, you must have some MMIO region for
them to target - doing what many platforms have done to date and targetted
ISA IO address 0 at virtual address 0 is just not on because as soon as
you build a device driver which probes ISA addresses into your kernel,
you will oops.  Moreover, userspace can open /dev/ioport and ask the
kernel to access IO port addresses that way too.  Having IO space support
enabled when the platform does not support it is a liability and an
additional unnecessary security problem.
