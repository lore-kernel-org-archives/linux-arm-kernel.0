From: gdavis@mvista.com (George G. Davis)
Date: Fri, 30 Apr 2010 18:30:34 -0400
Subject: [RFC] Prohibit ioremap() on kernel managed RAM
In-Reply-To: <20100430181940.GC1639@n2100.arm.linux.org.uk>
References: <20100423144058.GA11637@ZenIV.linux.org.uk>
	<20100430163356.GV2619@mvista.com>
	<20100430181940.GC1639@n2100.arm.linux.org.uk>
Message-ID: <20100430223034.GW2619@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Apr 30, 2010 at 07:19:40PM +0100, Russell King - ARM Linux wrote:
> On Fri, Apr 30, 2010 at 12:33:56PM -0400, George G. Davis wrote:
> > Hi,
> > 
> > On Fri, Apr 23, 2010 at 03:40:58PM +0100, Russell King wrote:
> > > > Above change is necessary but what an alternative approach is for this. 
> > > > There are many use case where ioremap* is needed.
> > > 
> > > This is a very difficult issue to answer; the only way we can safely
> > > remap RAM with different attributes is if we disable the existing
> > > mappings - but since we create those with 1MB sections, that's far
> > > from easy to achieve.
> > > 
> > > I think a viable safe solution is to set aside some RAM at boot (which
> > > the kernel doesn't manage at all) and then use ioremap on that; that
> > > approach will still work with this patch in place.
> > 
> > So cases such as the omapfb driver which use reserve_bootmem() (in
> > arch/arm/plat-omap/fb.c) and then later use ioremap_wc() to remap
> > reserved memory (in drivers/video/omap2/omapfb/omapfb-main.c)
> > will no longer work with this change.
> 
> Correct; and there's two reasons why they'll break in the near future.
> The first is down to ioremap not wanting to allow remapping of already
> existing memory.
> 
> The second is that when we switch to using LMB instead of bootmem, this
> makes the use of reserve_bootmem() a problem in fb.c.
> 
> There's really one option for this - in the machine's fixup handler, you
> can walk the meminfo array and kick out some memory from that.  This will
> prevent the kernel mapping that memory and make pfn_valid() fail for that
> memory range.  Another advantage of this is that it won't break when we
> switch to LMB.

I guess another option is to pass mem= on the cmdline to leave memory
free for ioremap'ing as needed.  Yuck.  : )

Thanks!

--
Regards,
George
