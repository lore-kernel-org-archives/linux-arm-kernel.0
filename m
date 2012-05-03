From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 3 May 2012 16:27:44 +0000
Subject: Making ARM multiplatform kernels DT-only?
In-Reply-To: <20120503141853.GC897@n2100.arm.linux.org.uk>
References: <201205031350.35476.arnd@arndb.de>
 <20120503141853.GC897@n2100.arm.linux.org.uk>
Message-ID: <201205031627.44889.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 03 May 2012, Russell King - ARM Linux wrote:
> On Thu, May 03, 2012 at 01:50:35PM +0000, Arnd Bergmann wrote:
> > My feeling is that we should just mandate DT booting for multiplatform
> > kernels, because it significantly reduces the combinatorial space
> > at compile time, avoids a lot of legacy board files that we cannot
> > test anyway, reduces the total kernel size and gives an incentive
> > for people to move forward to DT with their existing boards.
> 
> On this point, I strongly object, especially as I'm one who uses the
> existing non-DT multiplatform support extensively.  It's really not
> a problem for what you're trying to achieve.

Just to clarify the terminology, when I said "multiplatform", I did
not mean enabling more than one board file inside a given mach-*
directory but instead enabling multiple mach-* directories that
are currently mutually exclusive, i.e. the future stuff you replied
to in the other mail, not what everyone is doing today, and this
would not stop anything from working that works today.

> I think what you're proposing is a totally artificial restriction.
> There's no problem with a kernel supporting DT and non-DT together.
> We've proven that many many times.  I prove it every night that my
> build and boot system runs - the OMAP LDP boots a multiplatform kernel
> just fine without DT.

Of course it's an artificial restriction, if it was a technical necessity,
I would not have needed to ask ;-) IMHO however it's a helpful restriction.
My current count of board files is 393 and if you consider that we won't
build v6+ and v4/v5 together and that some of them will probably not
be multiplatform capable for a long time, we probably end up with about
half of them in a given kernel, which is still a lot and I would not
expect distributors to make a good decision about which ones of these
are important to enable and which ones are not. If we restrict the
Kconfig space to just the ones that are DT-enabled, we can be reasonably
sure that these have been recently tested on actual hardware by someone
who cares about them, and we get only a fraction of the user visible
options, roughly one per soc generation.

One counterargument that just occurred to me is build coverage, and it
would be nice to have "make allyesconfig" actually build everything
together as far as possible. We could get a bit closer to that if
we allow those platforms that have no DT support to just provide a
Kconfig option for multiplatform kernels that enables everything, e.g.
when you build an ARMv4/ARMv5 kernel, you can enable all sa1100
based boards together using one option, but when you build an sa1100
kernel, you keep picking them individually.

	Arnd
