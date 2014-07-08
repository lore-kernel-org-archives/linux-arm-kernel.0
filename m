From: julien.grall@linaro.org (Julien Grall)
Date: Tue, 08 Jul 2014 10:37:35 +0100
Subject: [Xen-devel] [RFC PATCH 0/2] xen/arm: fix
 "xen_add_mach_to_phys_entry: cannot add" problem
In-Reply-To: <alpine.DEB.2.02.1407072007470.27641@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1407072007470.27641@kaball.uk.xensource.com>
Message-ID: <53BBBBDF.4090309@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/07/14 21:24, Stefano Stabellini wrote:
> Hi all,

Hi Stefano,

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

I tried this series on midway with a FreeBSD guest. I got those errors 
in DOM0 log:

xen_add_phys_to_mach_entry: cannot add pfn=0x002d99330003cdc7 -> 
mfn=0x00000001002d9933: pfn=0x002d99330003e3ea -> mfn=0x00000001002d9933 
already exists
xen_add_phys_to_mach_entry: cannot add pfn=0x002d99330003d47a -> 
mfn=0x00000001002d9933: pfn=0x002d99330003e3ea -> mfn=0x00000001002d9933 
already exists

It looks like you forgot to modify xen_add_phys_to_mach_entry.

Regards,

-- 
Julien Grall
