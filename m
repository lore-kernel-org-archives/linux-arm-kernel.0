From: tony@atomide.com (Tony Lindgren)
Date: Wed, 4 May 2011 00:23:17 -0700
Subject: [PATCHv3] ARM:boot:device tree: Allow the device tree binary
	to be appended to zImage
In-Reply-To: <alpine.LFD.2.00.1104291509540.24613@xanadu.home>
References: <20110420073445.GB31127@S2100-06.ap.freescale.net>
	<20110421080238.GE13688@atomide.com>
	<20110421124618.GA15060@atomide.com>
	<20110427142306.GI3755@atomide.com>
	<alpine.LFD.2.00.1104271036520.24613@xanadu.home>
	<20110427144335.GK3755@atomide.com>
	<20110429102623.GX3755@atomide.com>
	<alpine.LFD.2.00.1104290909310.24613@xanadu.home>
	<20110429135334.GR5126@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1104291509540.24613@xanadu.home>
Message-ID: <20110504072317.GU2092@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nicolas Pitre <nico@fluxnic.net> [110429 12:11]:
> On Fri, 29 Apr 2011, Russell King - ARM Linux wrote:
> 
> > On Fri, Apr 29, 2011 at 09:16:39AM -0400, Nicolas Pitre wrote:
> > > On Fri, 29 Apr 2011, Tony Lindgren wrote:
> > > 
> > > > If the compressed image is smaller than BSS, then we end up
> > > > having DT data in the BSS area. In this case the compressed
> > > > image is about 2.3 MB for LZMA.
> > > > 
> > > > The uncompress code does not know about the kernel BSS,
> > > > and does not necessarily relocate anything depending on the
> > > > compressed image load address.
> > > > 
> > > > So in which code do we want to relocate the DT data?
> > > > 
> > > > We could do it based on estimated BSS size in uncompress code,
> > > > or based on the real BSS size in __mmap_switched before BSS
> > > > gets reset.
> > > 
> > > Estimations for that kind of thing is always bound to create problems 
> > > some day.
> > > 
> > > The DT data should probably be moved out of the way from 
> > > arch/arm/kernel/head.S before the .bss is cleared, and even before 
> > > enabling the MMU, like in __vet_atags.
> > 
> > Err, no.  Moving stuff around becomes quite expensive when the cache is
> > not on.  It's far better to work out where to place it first time around
> > so its not in the way.
> 
> I don't think the DT data is that huge, but that's a point in favor of 
> doing it in the zImage code.  We'll just need to feed the total size of 
> the uncompressed kernel .bss section to zImage when compiling it.

One more thing to consider though.. I don't think we want to copy the
DT data twice. It's not big right now, but could get large if we pass
all the clocks in it.

So this should be probably fixed in the original patch.. John got
any thoughts on that?

Regards,

Tony
