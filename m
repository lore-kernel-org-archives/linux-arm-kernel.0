From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 17 Mar 2016 18:01:23 +0100
Subject: [PATCH] arm64: dma-mapping: fix dma_to_phys API for IOMMU
 attached devices
In-Reply-To: <56EADD0C.4040201@codeaurora.org>
References: <1458229833-4886-1-git-send-email-okaya@codeaurora.org>
 <3165610.Gdh8F6ejPI@wuerfel> <56EADD0C.4040201@codeaurora.org>
Message-ID: <17085043.8Me19Fq1r8@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 17 March 2016 12:36:28 Sinan Kaya wrote:
> 
> The first solution that comes to my mind is to implement a weak function in
> swiotlb.c with these contents
> 
> dma_addr_t __weak swio_phys_to_dma(struct device *dev, phys_addr_t paddr)
> {
>         return paddr;
> }
> 
>  
> phys_addr_t __weak  swio_dma_to_phys(struct device *dev, dma_addr_t daddr)
> {
>         return daddr;
> }
> 
> then clean up all the duplicates in dma-mapping.h for all ARCHs that have
> identical code. 
> 
> For others move the implementation to some source file.
> 
> 

Sounds ok to me, but I'd prefer using a macro instead of a __weak symbol:

#ifndef swiotlb_phys_to_dma
static inline dma_addr_t swiotlb_phys_to_dma(struct device *dev, phys_addr_t paddr)
{
         return paddr;
}
#endif

and then let the architectures that override it provide a self-referencing
macro:

#define swiotlb_phys_to_dma swiotlb_phys_to_dma

Also note swiotlb instead of swio, to match the existing naming.

	Arnd
