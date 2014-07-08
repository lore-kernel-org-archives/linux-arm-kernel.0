From: konrad.wilk@oracle.com (Konrad Rzeszutek Wilk)
Date: Tue, 8 Jul 2014 12:05:47 -0400
Subject: [Xen-devel] [PATCH v2 0/3] xen/arm: fix
 "xen_add_mach_to_phys_entry: cannot add" problem
In-Reply-To: <alpine.DEB.2.02.1407081552200.27641@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1407081552200.27641@kaball.uk.xensource.com>
Message-ID: <20140708160547.GA9519@laptop.dumpdata.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 08, 2014 at 04:40:46PM +0100, Stefano Stabellini wrote:
> Hi all,
> Xen support in Linux for ARM and ARM64 suffers from lack of support for
> multiple mfn to pfn mappings: whenever a frontend grants the same page
> multiple times to the backend, the mfn to pfn accounting in
> arch/arm/xen/p2m.c fails. The issue has become critical since v3.15,
> when xen-netfront/xen-netback switched from grant copies to grant
> mappings, therefore causing the issue to happen much more often.
> 
> Fixing the mfn to pfn accounting in p2m.c is difficult and expensive,
> therefore we are looking for alternative solutions. One idea is avoiding
> mfn to pfn conversions altogether. The only code path that needs them is
> swiotlb-xen:unmap_page (and single_for_cpu and single_for_device).

I seem to have lost track of that patch? Or is it in now in the kernel?

Could you include the git commit id or URL for it in the cover letter please?

Thanks
> 
> To avoid mfn to pfn conversions we rely on a second p2m mapping done by
> Xen (a separate patch series will be sent for Xen). In Linux we use it
> to perform the cache maintenance operations without mfns conversions.
> 
> 
> Changes in v2:
> - introduce XENFEAT_grant_map_11;
> - remeber the ptep corresponding to scratch pages so that we don't need
> to calculate it again every time;
> - do not acutally unmap the page on xen_mm32_unmap;
> - properly account preempt_enable/disable;
> - do not check for mfn in xen_add_phys_to_mach_entry.
> 
> 
> Stefano Stabellini (3):
>       xen/arm: introduce XENFEAT_grant_map_11
>       xen/arm: reimplement xen_dma_unmap_page & friends
>       xen/arm: remove mach_to_phys rbtree
> 
>  arch/arm/include/asm/xen/page-coherent.h |   25 ++--
>  arch/arm/include/asm/xen/page.h          |    9 --
>  arch/arm/xen/Makefile                    |    2 +-
>  arch/arm/xen/enlighten.c                 |    6 +
>  arch/arm/xen/mm32.c                      |  202 ++++++++++++++++++++++++++++++
>  arch/arm/xen/p2m.c                       |   66 +---------
>  include/xen/interface/features.h         |    3 +
>  7 files changed, 220 insertions(+), 93 deletions(-)
>  create mode 100644 arch/arm/xen/mm32.c
> 
> _______________________________________________
> Xen-devel mailing list
> Xen-devel at lists.xen.org
> http://lists.xen.org/xen-devel
