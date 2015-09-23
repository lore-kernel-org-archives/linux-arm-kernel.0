From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 23 Sep 2015 10:51:52 +0100
Subject: [PATCH] arm: dma-mapping: add cast to DMA_ERROR_CODE
In-Reply-To: <56027310.3010603@gmail.com>
References: <1439653971-867-1-git-send-email-dirk.behme@gmail.com>
 <56027310.3010603@gmail.com>
Message-ID: <20150923095152.GK21084@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 23, 2015 at 11:38:24AM +0200, Dirk Behme wrote:
> On 15.08.2015 17:52, Dirk Behme wrote:
> >Fix the compiler warning
> >
> >./arch/arm/include/asm/dma-mapping.h: In function ?dma_mapping_error?:
> >./arch/arm/include/asm/dma-mapping.h:176:18: warning: comparison between signed and unsigned integer expressions [-Wsign-compare]
> >   return dma_addr == DMA_ERROR_CODE;
> >                   ^
> >
> >we get building the kernel with W=1.
> >
> >This is done the same way we have already in the arm64 version.
> >
> >Signed-off-by: Dirk Behme <dirk.behme@gmail.com>
> >---
> >  arch/arm/include/asm/dma-mapping.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
> >index b52101d..68e41e8 100644
> >--- a/arch/arm/include/asm/dma-mapping.h
> >+++ b/arch/arm/include/asm/dma-mapping.h
> >@@ -14,7 +14,7 @@
> >  #include <xen/xen.h>
> >  #include <asm/xen/hypervisor.h>
> >
> >-#define DMA_ERROR_CODE	(~0)
> >+#define DMA_ERROR_CODE	(~(dma_addr_t)0)
> >  extern struct dma_map_ops arm_dma_ops;
> >  extern struct dma_map_ops arm_coherent_dma_ops;
> 
> 
> I've put this as 8420/1 into the patch system:
> 
> http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=8420/1
> 
> Any comments on this?

The reason your patch didn't get applied is because of:

commit 96231b2686b53f71838a335bdc404cb5285d1a01
Author: Marek Szyprowski <m.szyprowski@samsung.com>
Date:   Tue Aug 18 09:14:15 2015 +0100

    ARM: 8419/1: dma-mapping: harmonize definition of DMA_ERROR_CODE

    All architectures except arm that define DMA_ERROR_CODE are casting it
    to (dma_addr_t) - as it is always compared to dma_addr_t in arm as well
    this could be harmonized.

    Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
    Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
    Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

which does exactly the same thing as your patch, and first appeared
in June.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
