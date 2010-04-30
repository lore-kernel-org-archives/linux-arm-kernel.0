From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 30 Apr 2010 17:38:31 +0100
Subject: [RFC] Prohibit ioremap() on kernel managed RAM
In-Reply-To: <20100430163356.GV2619@mvista.com>
References: <20100423144058.GA11637@ZenIV.linux.org.uk>
	<20100430163356.GV2619@mvista.com>
Message-ID: <1272645511.22683.1.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-04-30 at 17:33 +0100, George G. Davis wrote:
> Hi,
> 
> On Fri, Apr 23, 2010 at 03:40:58PM +0100, Russell King wrote:
> > > Above change is necessary but what an alternative approach is for this.
> > > There are many use case where ioremap* is needed.
> >
> > This is a very difficult issue to answer; the only way we can safely
> > remap RAM with different attributes is if we disable the existing
> > mappings - but since we create those with 1MB sections, that's far
> > from easy to achieve.
> >
> > I think a viable safe solution is to set aside some RAM at boot (which
> > the kernel doesn't manage at all) and then use ioremap on that; that
> > approach will still work with this patch in place.
> 
> So cases such as the omapfb driver which use reserve_bootmem() (in
> arch/arm/plat-omap/fb.c) and then later use ioremap_wc() to remap
> reserved memory (in drivers/video/omap2/omapfb/omapfb-main.c)
> will no longer work with this change.

Another solution would be to allow the unmapping of sections from the
kernel linear mapping. I think x86 does this already for the AGP
aperture.

-- 
Catalin
