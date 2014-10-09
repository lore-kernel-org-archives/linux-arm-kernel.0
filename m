From: david.vrabel@citrix.com (David Vrabel)
Date: Thu, 9 Oct 2014 12:00:23 +0100
Subject: [Xen-devel] [PATCH v3 2/2] xen/arm: introduce GNTTABOP_cache_flush
In-Reply-To: <1412773496-15364-2-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1410081400520.17038@kaball.uk.xensource.com>
 <1412773496-15364-2-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <54366AC7.2080106@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/10/14 14:04, Stefano Stabellini wrote:
> Introduce support for new hypercall GNTTABOP_cache_flush.
> Use it to perform cache flashing on pages used for dma when necessary.

This still think all these additional hypercalls in the hot path are
going to limit performance but on the understanding that this is only
used for non-coherent devices and a lack of anything better:

Reviewed-by: David Vrabel <david.vrabel@citrix.com>

With one comment below.

> --- a/arch/arm/xen/mm32.c
> +++ b/arch/arm/xen/mm32.c
> @@ -4,6 +4,9 @@
>  #include <linux/highmem.h>
>  
>  #include <xen/features.h>
> +#include <xen/interface/grant_table.h>
> +
> +#include <asm/xen/hypercall.h>
>  
>  
>  /* functions called by SWIOTLB */
> @@ -22,16 +25,32 @@ static void dma_cache_maint(dma_addr_t handle, unsigned long offset,
>  		size_t len = left;
>  		void *vaddr;
>  	
> +		if (len + offset > PAGE_SIZE)
> +			len = PAGE_SIZE - offset;

Since this looks like it would result in failing the clean/invalidate
the trailing part of the buffer, I think this needs a comment explaining
why this is safe.  i.e., buffers in highmem or foreign pages cannot
cross page boundaries.

David
