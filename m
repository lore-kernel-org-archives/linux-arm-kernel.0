From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 20 Jun 2011 15:20:44 -0400 (EDT)
Subject: [PATCH] USB: ehci: use packed,
	aligned(4) instead of removing the packed attribute
In-Reply-To: <20110620190240.GJ26089@n2100.arm.linux.org.uk>
References: <Pine.LNX.4.44L0.1106201240240.2113-100000@iolanthe.rowland.org>
	<201106201858.45624.arnd@arndb.de>
	<20110620190240.GJ26089@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1106201515050.2142@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 20 Jun 2011, Russell King - ARM Linux wrote:

> On Mon, Jun 20, 2011 at 06:58:45PM +0200, Arnd Bergmann wrote:
> > A recent change in gcc changed the default behaviour when compiling the
> > ehci driver on ARM, but the behaviour was already nondeterministic
> > because the definition of the readl/writel macros on ARM relies on
> > unspecified behaviour (cast to pointer with larger aligment).
> 
> It's unspecified behaviour period.  If you pass a pointer to readl/writel
> which is not word aligned, what you get back is anyones guess.

The pointer _is_ aligned.  The problem is that it comes from the address 
of a structure member, which structure is marked __packed.

Older GCC would see the cast to unsigned int applied to that pointer 
within the ARM's readl()/writel() implementation and ignore that the 
source of the address is marked __packed, which __packed implies an 
alignment of 1.  REcent GCC versions would honnor the alignment of 1 and 
perform the unsigned int * access using byte sized loads/stores.


Nicolas
