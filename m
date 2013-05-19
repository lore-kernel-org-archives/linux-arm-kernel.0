From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 19 May 2013 12:25:52 +0100
Subject: [RFC 0/8] rmk's Dove DRM/TDA19988 Cubox driver
In-Reply-To: <20130517133345.7c1368f5@armhf>
References: <20130516192510.GV18614@n2100.arm.linux.org.uk>
 <20130517133345.7c1368f5@armhf>
Message-ID: <20130519112552.GR18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 17, 2013 at 01:33:45PM +0200, Jean-Francois Moine wrote:
> I quickly compared your dove drm driver and ours (Sebastian and me):
> 
> - CMA helper
> 
>   You don't use DRM_KMS_CMA_HELPER and DRM_GEM_CMA_HELPER which would
>   simplify some code.

Looking at the CMA helper code in DRM, it makes some fundamental errors:

1. It assumes the returned DMA address is a physical address.  This
   is not necessarily the case (there are a number of ARM platforms
   where this is most definitely not true.)  So:

        cma_obj->vaddr = dma_alloc_writecombine(drm->dev, size,
                        &cma_obj->paddr, GFP_KERNEL | __GFP_NOWARN);
...
        ret = remap_pfn_range(vma, vma->vm_start, cma_obj->paddr >> PAGE_SHIFT,
                        vma->vm_end - vma->vm_start, vma->vm_page_prot);

   is extremely broken.

2. If you use the CMA helper, then all your GEM objects must be CMA
   objects.  You can't combine different types of objects (eg, SHM-backed
   objects) with CMA objects.  This will be a massive performance
   regression with GPUs which can handle scatter-gathered SHM objects
   such as the Vivante GPU on the Armada 510.

So, for me, the last point especially is a very strong argument not to
use the DRM CMA helper.  Yes, I could switch to using the DMA coherent/
writecombine allocation API and thus make use of CMA, and that's
something I will be looking at.
