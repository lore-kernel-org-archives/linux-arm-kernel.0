From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Wed, 9 Jul 2014 15:14:15 +0100
Subject: [Xen-devel] [PATCH v2 0/3] xen/arm: fix
 "xen_add_mach_to_phys_entry: cannot add" problem
In-Reply-To: <20140709134754.GA21837@laptop.dumpdata.com>
References: <alpine.DEB.2.02.1407081552200.27641@kaball.uk.xensource.com>
 <20140708160547.GA9519@laptop.dumpdata.com>
 <alpine.DEB.2.02.1407091126060.27641@kaball.uk.xensource.com>
 <20140709134754.GA21837@laptop.dumpdata.com>
Message-ID: <alpine.DEB.2.02.1407091508370.29039@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 9 Jul 2014, Konrad Rzeszutek Wilk wrote:
> On Wed, Jul 09, 2014 at 11:30:49AM +0100, Stefano Stabellini wrote:
> > On Tue, 8 Jul 2014, Konrad Rzeszutek Wilk wrote:
> > > On Tue, Jul 08, 2014 at 04:40:46PM +0100, Stefano Stabellini wrote:
> > > > Hi all,
> > > > Xen support in Linux for ARM and ARM64 suffers from lack of support for
> > > > multiple mfn to pfn mappings: whenever a frontend grants the same page
> > > > multiple times to the backend, the mfn to pfn accounting in
> > > > arch/arm/xen/p2m.c fails. The issue has become critical since v3.15,
> > > > when xen-netfront/xen-netback switched from grant copies to grant
> > > > mappings, therefore causing the issue to happen much more often.
> > > > 
> > > > Fixing the mfn to pfn accounting in p2m.c is difficult and expensive,
> > > > therefore we are looking for alternative solutions. One idea is avoiding
> > > > mfn to pfn conversions altogether. The only code path that needs them is
> > > > swiotlb-xen:unmap_page (and single_for_cpu and single_for_device).
> > > 
> > > I seem to have lost track of that patch? Or is it in now in the kernel?
> > > 
> > > Could you include the git commit id or URL for it in the cover letter please?
> > 
> > I take that you are asking the id of the commit that introduced the
> > function calls that need mfn to pfn conversions in swiotlb-xen, right?
> 
> Earlier you said: "avoiding mfn to pfn conversions. The only code path
> that needs them is .." So I suspected (it seems wrongly) that there was
> some SWIOTLB patch that would do this and I had missed it.
> 
> But it seems that this soo fresh you hadn't yet posted the SWIOTLB changes
> to use this new API - so I hadn't missed them :-)

I think you didn't notice them because they don't do anything at all on
x86 :-)

If you give a look at swiotlb-xen, you'll find that xen_bus_to_phys is
called in xen_unmap_single and xen_swiotlb_sync_single. The returned
physical address is passed to xen_dma_unmap_page and
xen_dma_sync_single_for_cpu.

xen_dma_unmap_page and xen_dma_sync_single_for_cpu have an empty
implementation on x86 (see arch/x86/include/asm/xen/page-coherent.h)
but on ARM they perform important cache maintenance operations.

These are the only place where we need mfn to pfn conversions.


> > The commit that introduced them is:
> > 
> > commit 6cf054636261ca5c88f3c2984058d51f927b8a2e
> > Author: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> > Date:   Fri Oct 25 10:33:25 2013 +0000
> > 
> >     swiotlb-xen: use xen_dma_map/unmap_page, xen_dma_sync_single_for_cpu/device
> >      
> > xen_dma_unmap_page on x86 doesn't do anything but on ARM performs
> > important cache invalidate operations for non-dma-coherent devices.
> > 
> > 
> > 
> > > Thanks
> > > > 
> > > > To avoid mfn to pfn conversions we rely on a second p2m mapping done by
> > > > Xen (a separate patch series will be sent for Xen). In Linux we use it
> > > > to perform the cache maintenance operations without mfns conversions.
> > > > 
> > > > 
> > > > Changes in v2:
> > > > - introduce XENFEAT_grant_map_11;
> > > > - remeber the ptep corresponding to scratch pages so that we don't need
> > > > to calculate it again every time;
> > > > - do not acutally unmap the page on xen_mm32_unmap;
> > > > - properly account preempt_enable/disable;
> > > > - do not check for mfn in xen_add_phys_to_mach_entry.
> > > > 
> > > > 
> > > > Stefano Stabellini (3):
> > > >       xen/arm: introduce XENFEAT_grant_map_11
> > > >       xen/arm: reimplement xen_dma_unmap_page & friends
> > > >       xen/arm: remove mach_to_phys rbtree
> > > > 
> > > >  arch/arm/include/asm/xen/page-coherent.h |   25 ++--
> > > >  arch/arm/include/asm/xen/page.h          |    9 --
> > > >  arch/arm/xen/Makefile                    |    2 +-
> > > >  arch/arm/xen/enlighten.c                 |    6 +
> > > >  arch/arm/xen/mm32.c                      |  202 ++++++++++++++++++++++++++++++
> > > >  arch/arm/xen/p2m.c                       |   66 +---------
> > > >  include/xen/interface/features.h         |    3 +
> > > >  7 files changed, 220 insertions(+), 93 deletions(-)
> > > >  create mode 100644 arch/arm/xen/mm32.c
> > > > 
> > > > _______________________________________________
> > > > Xen-devel mailing list
> > > > Xen-devel at lists.xen.org
> > > > http://lists.xen.org/xen-devel
> > > 
> 
