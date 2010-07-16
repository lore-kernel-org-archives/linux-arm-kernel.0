From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 16 Jul 2010 10:20:18 +0100
Subject: [PATCH] Stop ARM boards crashing when CUPS is loaded - 2.6.35-rc5
In-Reply-To: <4C40218A.4090806@canonical.com>
References: <4C3C72C6.4000005@canonical.com>
	<20100715130214.4c9303b2.akpm@linux-foundation.org>
	<20100715200618.GA6773@n2100.arm.linux.org.uk>
	<4C40218A.4090806@canonical.com>
Message-ID: <20100716092018.GB16995@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 16, 2010 at 10:08:26AM +0100, Lee Jones wrote:
> On 15/07/10 21:06, Russell King - ARM Linux wrote:
> > Note that we have machines which have ISA parallel ports, so it's not
> > this simple.
> 
> Do they have ISA parallel ports, or do they just pretend to?

I have four machines here which have real ISA parallel ports - as in
an ISA multi-IO chip with the serial/parallel/ide ports at the standard
PC IO offsets.  Whether there are more or not, I couldn't say.

When platforms implement the PCI/ISA IO macros correctly (as these four
platforms do), then these drivers work with no modification.

The problem comes when determining what is a "correct" implementation
for some machines - particularly machines which have no PCI/ISA busses
but have PCMCIA support.  PCMCIA has its own ISA-like bus, which can
appear to be quite different from PCs - eg, each socket has its own
separate chunk of MMIO emulating the ISA IO accesses to the cards.

In this case, most platforms prefer to have the PCI/ISA IO macros just
dereference the address they're passed, and arrange for the PCMCIA
support to provide a base address relevant to the IO mapping which has
been established.

This leads to drivers which try the standard ISA IO addresses
dereferencing addresses within the first page, thereby causing a kernel
oops.

> > Why not just avoid selecting and building parport_pc on these machines?
> 
> > I mean, the Beagleboard doesn't have PCI nor ISA, so why is parport_pc
> > being built for production use?
> 
> I am happy to make a Kconfig change to disallow OMAP builds from building
> the parport_pc driver. Do you think this would be more sensible?

Making Kconfig changes to disallow drivers which don't work on certain
platforms will result in a massive expansion of dependencies.  I'm
not certain that this is the right solution.

The best solution is probably for the parport code to go through a
modernisation cycle like the serial code did, essentially using
platform devices to pass the base addresses.  This would make the
driver more portable, and eliminates this problem entirely (because
platforms which don't have parports won't register the platform device(s)
necessary for parport to even probe illegal addresses.)
