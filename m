From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 04 May 2010 16:29:57 +0100
Subject: [RFC] Prohibit ioremap() on kernel managed RAM
In-Reply-To: <20100503155900.GA26552@mvista.com>
References: <20100423144058.GA11637@ZenIV.linux.org.uk>
	<20100430163356.GV2619@mvista.com>
	<1272645511.22683.1.camel@e102109-lin.cambridge.arm.com>
	<20100503155900.GA26552@mvista.com>
Message-ID: <1272986997.15948.11.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-05-03 at 16:59 +0100, George G. Davis wrote:
> On Fri, Apr 30, 2010 at 05:38:31PM +0100, Catalin Marinas wrote:
> > On Fri, 2010-04-30 at 17:33 +0100, George G. Davis wrote:
> > > Hi,
> > >
> > > On Fri, Apr 23, 2010 at 03:40:58PM +0100, Russell King wrote:
> > > > > Above change is necessary but what an alternative approach is for this.
> > > > > There are many use case where ioremap* is needed.
> > > >
> > > > This is a very difficult issue to answer; the only way we can safely
> > > > remap RAM with different attributes is if we disable the existing
> > > > mappings - but since we create those with 1MB sections, that's far
> > > > from easy to achieve.
> > > >
> > > > I think a viable safe solution is to set aside some RAM at boot (which
> > > > the kernel doesn't manage at all) and then use ioremap on that; that
> > > > approach will still work with this patch in place.
> > >
> > > So cases such as the omapfb driver which use reserve_bootmem() (in
> > > arch/arm/plat-omap/fb.c) and then later use ioremap_wc() to remap
> > > reserved memory (in drivers/video/omap2/omapfb/omapfb-main.c)
> > > will no longer work with this change.
> >
> > Another solution would be to allow the unmapping of sections from the
> > kernel linear mapping. I think x86 does this already for the AGP
> > aperture.
> 
> I've yet to grok that code but have been curious about how this is done
> for x86 graphics.  : )

I don't know exactly but I've got reports in the past that kmemleak was
trying to scan the AGP aperture on x86 and it wasn't actually mapped,
though it was allocated via alloc_bootmem().

Another option I noticed on x86 is the use of functions like
io_mapping_create_wc() which call iomap_create_wc() and
io_reserve_memtype(). The latter calls kernel_map_sync_memtype() which
seems to change the attributes of the kernel linear mapping for the
given physical address.

-- 
Catalin
