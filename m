From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 21 Jun 2013 11:29:22 +0200
Subject: SCU registers mapping for CA9/CA5 cores
In-Reply-To: <20130621081356.GU2718@n2100.arm.linux.org.uk>
References: <CADApbei3QOCQRmo_oYZ_XiUVupq+4uUs7WNe6f7k_OG0LHB3=w@mail.gmail.com>
 <20130621081356.GU2718@n2100.arm.linux.org.uk>
Message-ID: <201306211129.22625.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 21 June 2013, Russell King - ARM Linux wrote:
> On Fri, Jun 21, 2013 at 02:11:31PM +0800, Chao Xie wrote:
> > hi, Russell
> > When i sbumited the patch for pxa988 which is CA9, Arnd gave me some
> > suggestions of SCU mapping.
> > I used static mapping in the platform file for SCU registers mapping,
> > but Arnd think there should be a more general way to do it, and others
> > can benefit from it. I agree with him.
> > 
> > The following is his question for you when reply to my patch.
> > "Russell, do you think using a fixmap page for the SCU makes sense?
> > I'm looking for a method to consolidate the various methods of
> > doing early mappings of the SCU for device tree based platforms.
> > Where do you think that should be implemented?"
> > 
> > So can you give your idea and suggestion? Thanks.
> 
> With our current fixmap region, we have 224 pages available, currently
> all dedicated to kmap.  kmap uses 16 pages per CPU at the moment, which
> we hope is enough (it's only checked when CONFIG_DEBUG_HIGHMEM is set.)
> 
> Assuming four CPUs, that makes it 64 pages, but then we have big.LITTLE
> with potentially 8 (I guess they map as separate smp_processor_id()'s)
> which makes that 128.  128 is over half of the available fixmap.
> 
> If we ever saw 16 CPUs, we'd need to find a new home for fixmap.  If we
> needed to increase KM_TYPE_NR beyond 28, we'd be in the same situation.
> 
> We do have the 0xffff1000 - 0xffff4000 range which is currently unused.
> We could put the SCU at 0xffff1000 for a single page.  IOW, not a fixmap
> page.

I think we need to separate the specific discussion on the SCU page
from the question about how to use fixmap. Putting the SCU at 0xffff1000
sounds reasonable to me, so let's do that.

On the matter of fixmap, I'm missing what the requirement is to have
fixmap be a single section. Right now as you say, we have a bit under
half of the fixmap unused in the worst-case (8 CPU) scenario, so we
could put other things in the remaining space. If we get to 16 CPUs
(which I think is specified already but not implemented anywhere so
far) or beyond, we need to grow fixmap, but then there would be
free space again.

I think we could actually move everything between VMALLOC_END and
ffff0000 /into/ a larger fixmap. This would be a substantial change,
but it would give us more vmalloc space for most configurations
and more flexibility with what else we could put into fixmap.

Something like:

enum fixed_addresses {
#ifdef CONFIG_HIGHMEM
	FIX_KMAP_BEGIN,
	FIX_KMAP_END = FIX_KMAP_BEGIN + (KM_TYPE_NR*NR_CPUS)-1,
#endif
#ifdef CONFIG_CPU_XSCALE
	XSCALE_CLEAN_BEGIN,
	XSCALE_CLEAN_END = XSCALE_CLEAN_START + 15,
#endif
#ifdef CONFIG_HAVE_TCM
	ITCM_BEGIN,
	ITCM_END = ITCM_SIZE / PAGE_SIZE - 1,
	DTCM_BEGIN,
	DTCM_END = DTCM_SIZE / PAGE_SIZE - 1,
#endif
#ifdef CONFIG_PCI
	PCI_IO_BEGIN,
	PCI_IO_END = PCI_IO_BEGIN + SZ_1M / PAGE_SIZE -1,
#endif
	__end_of_fixed_addresses,
};

Obviously we'd have to be careful to change all references to the
current well-known addresses to use the fixmap infrastructure
intead.

Any opinion on this? I haven't found any downsides yet, other than
having to do the work. I suppose we could even move the DEBUG_LL
mapping in there, but that would require some more rework.

	Arnd
