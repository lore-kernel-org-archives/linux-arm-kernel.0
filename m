From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 22 Feb 2012 20:06:17 +0000
Subject: AMBA devices behing a PCI bridge
In-Reply-To: <20120222191339.GA28388@mail.gnudd.com>
References: <20120222191339.GA28388@mail.gnudd.com>
Message-ID: <20120222200617.GD7041@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 22, 2012 at 08:13:39PM +0100, Alessandro Rubini wrote:
> * CONFIG_ARM_AMBA: maybe it's high time to rename it to CONFIG_AMBA (
> or CONFIG_PRIMECELL) like we have CONFIG_PCI, CONFIG_USB and a zillion
> others? (I expect both the new and old config names to be accepted
> for a while, to allow out-of-tree code to sync gracefully)

It has 'ARM' in it to signify the manufacturer who holes the base
specification for the bus.  Rather than just have 'AMBA' which could
get confusing if someone decides to call something they have 'AMBA'
too.

The only change I'd suggest is CONFIG_ARM_PRIMECELL because it's really
about primecells, not about AMBA peripherals.  Primecells are a sub-class
of AMBA peripherals.

> * <asm/sizes.h>: most of the amba world uses this header. Maybe it should
> be turned into <linux/sizes.h>, since it has nothing arch-specific in it?
> (you may remember I removed the inclusion from amba/bus.c, but that's
> not enough as most amba code uses the header anyways).

It's already asm-generic/sizes.h, and I'd suggest just moving that to
linux/sizes.h and be done about it.

> * Not all archs use the clk API. Currently I copied over the empty
> definitions found in arch/m68k/platform/coldfire/clk.c into
> arch/x86/platform/sta2x11/clk.c . Maybe we should offer weak empty
> definition for those functions? Or should the clk world be ported to x86
> and other architectures? (the latter I can't do by myself, I'm sorry).

Well, there's an effort to provide a unified clk API, which has been in
progress for a couple of years.  It's getting closer, so it may not be
too long before this problem is solved.

But yes, the clk API is fundamental to these drivers because of their
portability - that's precisely why the clk API was provided, so that
these exact drivers did not have to end up with a forever growing pile
of platform specific junk being ifdef'd into them (and that's exactly
what would've happened as every platform supplies different clock rates
and has different ways to control their clocks.)

So yes, the answer is to provide the clk API rather than trying to
bugger the drivers to work without it.  I'd suggest waiting for the
unified clk API to be merged first though, otherwise there'll be
yet another implementation in need of conversion effort.
