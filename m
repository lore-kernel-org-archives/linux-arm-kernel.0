From: joro@8bytes.org (Joerg Roedel)
Date: Tue, 15 Dec 2015 11:35:24 +0100
Subject: [for-4.4-rc6 PATCH] scatterlist: fix sg_phys() masking
In-Reply-To: <20151214231739.10377.11843.stgit@dwillia2-desk3.jf.intel.com>
References: <20151214231739.10377.11843.stgit@dwillia2-desk3.jf.intel.com>
Message-ID: <20151215103524.GH18805@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 14, 2015 at 03:17:39PM -0800, Dan Williams wrote:
> commit db0fa0cb0157 "scatterlist: use sg_phys()" did replacements of the
> form:
> 
>     phys_addr_t phys = page_to_phys(sg_page(s));
>     phys_addr_t phys = sg_phys(s) & PAGE_MASK;
> 
> However, this breaks platforms where sizeof(phys_addr_t) >
> sizeof(unsigned long).  Since PAGE_MASK is an unsigned long this
> inadvertently masks the high bits returned by sg_phys().  Convert to
> PHYSICAL_PAGE_MASK in these cases which will do the proper sign
> extension.
> 
> As caught by the kbuild robot, a generic fallback definition of
> PHYSICAL_PAGE_MASK is needed for several archs.

It is getting late in the cycle already, isn't it better to revert
db0fa0cb0157 for now and queue a fixed version for the next round? Then
you can also replace all the 'sg_phys() & MASK' parts by a new sg helper
which just returns the page-aligned physical address.
This would not only be cleaner than your original patch but also leaves
just one place where you need to fix things if necessary.


	Joerg
