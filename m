From: v1ne2go@gmail.com (Denis Schneider)
Date: Wed, 9 Jul 2014 16:31:58 +0200
Subject: [PATCH v2 0/3] xen/arm: fix "xen_add_mach_to_phys_entry: cannot
 add" problem
In-Reply-To: <alpine.DEB.2.02.1407081552200.27641@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1407081552200.27641@kaball.uk.xensource.com>
Message-ID: <CAE8M+o+c7y9mK531V4NbR4E4bggR3zHzSSJkV7z_ioBYx8NtcA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-07-08 17:40 GMT+02:00 Stefano Stabellini
<stefano.stabellini@eu.citrix.com>:
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

Tested-by: Denis Schneider <v1ne2go@gmail.com>

Stress-tested with network I/O, disk I/O for hours without any problem. Thanks.
