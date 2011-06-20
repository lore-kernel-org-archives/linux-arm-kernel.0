From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 20 Jun 2011 15:29:44 -0400 (EDT)
Subject: [PATCH] USB: ehci: use packed,
	aligned(4) instead of removing the packed attribute
In-Reply-To: <20110620190240.GJ26089@n2100.arm.linux.org.uk>
References: <Pine.LNX.4.44L0.1106201240240.2113-100000@iolanthe.rowland.org>
	<201106201858.45624.arnd@arndb.de>
	<20110620190240.GJ26089@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1106201521250.2142@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 20 Jun 2011, Russell King - ARM Linux wrote:

> On Mon, Jun 20, 2011 at 06:58:45PM +0200, Arnd Bergmann wrote:
> > We are also going to change the ARM implementation to always do 32 bit
> > accesses in readl/writel, but the patch that went into the ehci driver
> > was correct nonetheless.
> 
> Not without someone doing a comparitively large amount of work to analyze
> the effect of any change there and make sure that it doesn't have a
> negative impact to drivers.

This thread prompted me to investigate a bit.  I have vague memories for 
the reasons why we decided to use plain C for the IO accessors as the 
inline assembly version didn't produce nearly the same code quality.  It 
seems that GCC improved quite a bit there, and from a quick 
investigation, it looks like comparable code is being generated with the 
C and the inline asm versions with a recent enough GCC.  This is 
certainly the case with the version causing issues with packed 
structures.


Nicolas
