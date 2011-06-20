From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 20 Jun 2011 20:02:40 +0100
Subject: [PATCH] USB: ehci: use packed, aligned(4) instead of removing
	the packed attribute
In-Reply-To: <201106201858.45624.arnd@arndb.de>
References: <Pine.LNX.4.44L0.1106201240240.2113-100000@iolanthe.rowland.org>
	<201106201858.45624.arnd@arndb.de>
Message-ID: <20110620190240.GJ26089@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 20, 2011 at 06:58:45PM +0200, Arnd Bergmann wrote:
> A recent change in gcc changed the default behaviour when compiling the
> ehci driver on ARM, but the behaviour was already nondeterministic
> because the definition of the readl/writel macros on ARM relies on
> unspecified behaviour (cast to pointer with larger aligment).

It's unspecified behaviour period.  If you pass a pointer to readl/writel
which is not word aligned, what you get back is anyones guess.

Unaligned load/stores to devices are 'unpredictable' on ARM, and are
probably unpredictable on any other sane arch (unless you can predict
how the load is going to be issued on the bus, how the peripheral is
going to respond, and how the bus activity is going to be assembled
into a word.)

So, to issue a readl against an u16 pointer is unpredictable not only
due to the C language, but also from the sanity point of view.

> We are also going to change the ARM implementation to always do 32 bit
> accesses in readl/writel, but the patch that went into the ehci driver
> was correct nonetheless.

Not without someone doing a comparitively large amount of work to analyze
the effect of any change there and make sure that it doesn't have a
negative impact to drivers.
