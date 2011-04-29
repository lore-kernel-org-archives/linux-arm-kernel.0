From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 29 Apr 2011 20:29:50 +0200
Subject: [Linaro-mm-sig] [RFC] ARM DMA mapping TODO, v1
In-Reply-To: <20110429093209.1926c732@jbarnes-desktop>
References: <201104212129.17013.arnd@arndb.de>
	<20110429075958.GV17290@n2100.arm.linux.org.uk>
	<20110429093209.1926c732@jbarnes-desktop>
Message-ID: <201104292029.50680.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 29 April 2011 18:32:09 Jesse Barnes wrote:
> On Fri, 29 Apr 2011 08:59:58 +0100
> Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> 
> > On Fri, Apr 29, 2011 at 07:50:12AM +0200, Thomas Hellstrom wrote:
> > > However, we should be able to construct a completely generic api around  
> > > these operations, and for architectures that don't support them we need  
> > > to determine
> > >
> > > a)  Whether we want to support them anyway (IIRC the problem with PPC is  
> > > that the linear kernel map has huge tlb entries that are very  
> > > inefficient to break up?)
> > 
> > That same issue applies to ARM too - you'd need to stop the entire
> > machine, rewrite all processes page tables, flush tlbs, and only
> > then restart.  Otherwise there's the possibility of ending up with
> > conflicting types of TLB entries, and I'm not sure what the effect
> > of having two matching TLB entries for the same address would be.
> 
> Right, I don't think anyone wants to see this sort of thing happen with
> any frequency.  So either a large, uncached region can be set up a boot
> time for allocations, or infrequent, large requests and conversions can
> be made on demand, with memory being freed back to the main, coherent
> pool under pressure.

I'd like to first have an official confirmation from the CPU designers
if there is actually a problem with mapping a single page both cacheable
and noncacheable. Based on what Catalin said, it's probably allowed and
the current spec is just being more paranoid than it needs to be. Also,
KyongHo Cho said that it might only be relevant for pages that are mapped
executable.

If that is the case, we can probably work around this by turning the entire
linear mapping (except for the kernel binary) into nonexecutable mode,
if we don't do that already.
This is desirable for security purposes anyway.

	Arnd
