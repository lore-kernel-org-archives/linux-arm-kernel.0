From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 29 Apr 2011 14:53:34 +0100
Subject: [PATCHv3] ARM:boot:device tree: Allow the device tree binary
	to be appended to zImage
In-Reply-To: <alpine.LFD.2.00.1104290909310.24613@xanadu.home>
References: <20110413140030.GE12665@atomide.com>
	<20110420054746.GA31127@S2100-06.ap.freescale.net>
	<20110420073445.GB31127@S2100-06.ap.freescale.net>
	<20110421080238.GE13688@atomide.com>
	<20110421124618.GA15060@atomide.com>
	<20110427142306.GI3755@atomide.com>
	<alpine.LFD.2.00.1104271036520.24613@xanadu.home>
	<20110427144335.GK3755@atomide.com>
	<20110429102623.GX3755@atomide.com>
	<alpine.LFD.2.00.1104290909310.24613@xanadu.home>
Message-ID: <20110429135334.GR5126@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 29, 2011 at 09:16:39AM -0400, Nicolas Pitre wrote:
> On Fri, 29 Apr 2011, Tony Lindgren wrote:
> 
> > If the compressed image is smaller than BSS, then we end up
> > having DT data in the BSS area. In this case the compressed
> > image is about 2.3 MB for LZMA.
> > 
> > The uncompress code does not know about the kernel BSS,
> > and does not necessarily relocate anything depending on the
> > compressed image load address.
> > 
> > So in which code do we want to relocate the DT data?
> > 
> > We could do it based on estimated BSS size in uncompress code,
> > or based on the real BSS size in __mmap_switched before BSS
> > gets reset.
> 
> Estimations for that kind of thing is always bound to create problems 
> some day.
> 
> The DT data should probably be moved out of the way from 
> arch/arm/kernel/head.S before the .bss is cleared, and even before 
> enabling the MMU, like in __vet_atags.

Err, no.  Moving stuff around becomes quite expensive when the cache is
not on.  It's far better to work out where to place it first time around
so its not in the way.

Remember that there is a section of the community which cares deeply about
boot time and has already put quite some resources into sorting that out.
CELF springs to mind.
