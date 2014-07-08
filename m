From: david.vrabel@citrix.com (David Vrabel)
Date: Tue, 8 Jul 2014 11:50:23 +0100
Subject: [Xen-devel] [RFC PATCH 0/2] xen/arm: fix
 "xen_add_mach_to_phys_entry: cannot add" problem
In-Reply-To: <alpine.DEB.2.02.1407072007470.27641@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1407072007470.27641@kaball.uk.xensource.com>
Message-ID: <53BBCCEF.1080704@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/07/14 21:24, Stefano Stabellini wrote:
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
> Xen, see the attached patch. In Linux we use it to perform the cache
> maintenance operations without mfns conversions.

This will only work with PIPT caches (or certain types of VIPT that also
have alias detection).  Do all the CPUs that Xen runs on have these type
of cache?

David
