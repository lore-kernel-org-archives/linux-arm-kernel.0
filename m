From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Wed, 5 Aug 2015 10:49:15 +0100
Subject: [PATCH v2 2/8] xen: Make clear that swiotlb and biomerge are
 dealing with DMA address
In-Reply-To: <1438711972-18752-3-git-send-email-julien.grall@citrix.com>
References: <1438711972-18752-1-git-send-email-julien.grall@citrix.com>
 <1438711972-18752-3-git-send-email-julien.grall@citrix.com>
Message-ID: <alpine.DEB.2.02.1508051041060.11337@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 4 Aug 2015, Julien Grall wrote:
> The swiotlb is required when programming a DMA address on ARM when a
> device is not protected by an IOMMU.
> 
> In this case, the DMA address should always be equal to the machine address.
> For DOM0 memory, Xen ensure it by have an identity mapping between the
> guest address and host address. However, when mapping a foreign grant
> reference, the 1:1 model doesn't work.
> 
> For ARM guest, most of the callers of pfn_to_mfn expects to get a GFN
> (Guest Frame Number), i.e a PFN (Page Frame Number) from the Linux point
> of view given that all ARM guest are auto-translated.
> 
> Even though the name pfn_to_mfn is misleading, we need to ensure that
> those caller get a GFN and not by mistake a MFN. In pratical, I haven't
> seen error related to this but we should fix it for the sake of
> correctness.
> 
> In order to fix the implementation of pfn_to_mfn on ARM in a follow-up
> patch, we have to introduce new helpers to return the DMA from a PFN and
> the invert.
> 
> On x86, the new helpers will be an alias of pfn_to_mfn and mfn_to_pfn.
> 
> The helpers will be used in swiotlb and xen_biovec_phys_mergeable.
> 
> This is necessary in the latter because we have to ensure that the
> biovec code will not try to merge a biovec using foreign page and
> another using Linux memory.
> 
> Lastly, the helper mfn_to_local_pfn has been renamed to dnf_to_local_pfn
                                                          ^ please update


> given that the only usage was in swiotlb.
> 
> Signed-off-by: Julien Grall <julien.grall@citrix.com>
> Cc: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: David Vrabel <david.vrabel@citrix.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: x86 at kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> 
> ---
>     Changes in v2:
>         - Use bfn (Bus Frame Number) rather than dfn to match the
>         proposed terminology for pv-iommu hypercall.
> ---
>  arch/arm/include/asm/xen/page.h | 23 +++++++++++++++++++++--
>  arch/arm/xen/mm.c               |  4 ++--
>  arch/x86/include/asm/xen/page.h |  8 ++++++--
>  drivers/xen/biomerge.c          |  6 +++---
>  drivers/xen/swiotlb-xen.c       | 16 ++++++++--------
>  5 files changed, 40 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/arm/include/asm/xen/page.h b/arch/arm/include/asm/xen/page.h
> index 98b1084..bc5e77c 100644
> --- a/arch/arm/include/asm/xen/page.h
> +++ b/arch/arm/include/asm/xen/page.h
> @@ -52,7 +52,26 @@ static inline unsigned long mfn_to_pfn(unsigned long mfn)
>  	return mfn;
>  }
>  
> -#define mfn_to_local_pfn(mfn) mfn_to_pfn(mfn)
> +/* Pseudo-physical <-> BUS conversion */
> +static inline unsigned long pfn_to_bfn(unsigned long pfn)
> +{
> +	unsigned long mfn;
> +
> +	if (phys_to_mach.rb_node != NULL) {
> +		mfn = __pfn_to_mfn(pfn);
> +		if (mfn != INVALID_P2M_ENTRY)
> +			return mfn;
> +	}
> +
> +	return pfn;
> +}
> +
> +static inline unsigned long bfn_to_pfn(unsigned long bfn)
> +{
> +	return bfn;
> +}
> +
> +#define bfn_to_local_pfn(bfn)	bfn_to_pfn(bfn)
>  
>  /* VIRT <-> MACHINE conversion */
>  #define virt_to_mfn(v)		(pfn_to_mfn(virt_to_pfn(v)))
> @@ -96,7 +115,7 @@ static inline bool set_phys_to_machine(unsigned long pfn, unsigned long mfn)
>  
>  bool xen_arch_need_swiotlb(struct device *dev,
>  			   unsigned long pfn,
> -			   unsigned long mfn);
> +			   unsigned long dfn);
>  unsigned long xen_get_swiotlb_free_pages(unsigned int order);

You missed a bunch of dfn->bfn renamings.

Aside from those and the commit message error:

Reviewed-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>


>  #endif /* _ASM_ARM_XEN_PAGE_H */
> diff --git a/arch/arm/xen/mm.c b/arch/arm/xen/mm.c
> index 03e75fe..12bde72 100644
> --- a/arch/arm/xen/mm.c
> +++ b/arch/arm/xen/mm.c
> @@ -139,9 +139,9 @@ void __xen_dma_sync_single_for_device(struct device *hwdev,
>  
>  bool xen_arch_need_swiotlb(struct device *dev,
>  			   unsigned long pfn,
> -			   unsigned long mfn)
> +			   unsigned long dfn)
>  {
> -	return (!hypercall_cflush && (pfn != mfn) && !is_device_dma_coherent(dev));
> +	return (!hypercall_cflush && (pfn != dfn) && !is_device_dma_coherent(dev));
>  }
>  
>  int xen_create_contiguous_region(phys_addr_t pstart, unsigned int order,
> diff --git a/arch/x86/include/asm/xen/page.h b/arch/x86/include/asm/xen/page.h
> index c44a5d5..8ba04b8 100644
> --- a/arch/x86/include/asm/xen/page.h
> +++ b/arch/x86/include/asm/xen/page.h
> @@ -178,6 +178,10 @@ static inline xpaddr_t machine_to_phys(xmaddr_t machine)
>  	return XPADDR(PFN_PHYS(mfn_to_pfn(PFN_DOWN(machine.maddr))) | offset);
>  }
>  
> +/* Pseudo-physical <-> Bus conversion */
> +#define pfn_to_bfn(pfn)		pfn_to_mfn(pfn)
> +#define bfn_to_pfn(bfn)		mfn_to_pfn(bfn)
> +
>  /*
>   * We detect special mappings in one of two ways:
>   *  1. If the MFN is an I/O page then Xen will set the m2p entry
> @@ -198,7 +202,7 @@ static inline xpaddr_t machine_to_phys(xmaddr_t machine)
>   *      require. In all the cases we care about, the FOREIGN_FRAME bit is
>   *      masked (e.g., pfn_to_mfn()) so behaviour there is correct.
>   */
> -static inline unsigned long mfn_to_local_pfn(unsigned long mfn)
> +static inline unsigned long bfn_to_local_pfn(unsigned long mfn)
>  {
>  	unsigned long pfn;
>  
> @@ -264,7 +268,7 @@ void make_lowmem_page_readwrite(void *vaddr);
>  
>  static inline bool xen_arch_need_swiotlb(struct device *dev,
>  					 unsigned long pfn,
> -					 unsigned long mfn)
> +					 unsigned long bfn)
>  {
>  	return false;
>  }
> diff --git a/drivers/xen/biomerge.c b/drivers/xen/biomerge.c
> index 0edb91c..8ae2fc90 100644
> --- a/drivers/xen/biomerge.c
> +++ b/drivers/xen/biomerge.c
> @@ -6,10 +6,10 @@
>  bool xen_biovec_phys_mergeable(const struct bio_vec *vec1,
>  			       const struct bio_vec *vec2)
>  {
> -	unsigned long mfn1 = pfn_to_mfn(page_to_pfn(vec1->bv_page));
> -	unsigned long mfn2 = pfn_to_mfn(page_to_pfn(vec2->bv_page));
> +	unsigned long bfn1 = pfn_to_bfn(page_to_pfn(vec1->bv_page));
> +	unsigned long bfn2 = pfn_to_bfn(page_to_pfn(vec2->bv_page));
>  
>  	return __BIOVEC_PHYS_MERGEABLE(vec1, vec2) &&
> -		((mfn1 == mfn2) || ((mfn1+1) == mfn2));
> +		((bfn1 == bfn2) || ((bfn1+1) == bfn2));
>  }
>  EXPORT_SYMBOL(xen_biovec_phys_mergeable);
> diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
> index 4c54932..d757a3e 100644
> --- a/drivers/xen/swiotlb-xen.c
> +++ b/drivers/xen/swiotlb-xen.c
> @@ -82,8 +82,8 @@ static u64 start_dma_addr;
>   */
>  static inline dma_addr_t xen_phys_to_bus(phys_addr_t paddr)
>  {
> -	unsigned long mfn = pfn_to_mfn(PFN_DOWN(paddr));
> -	dma_addr_t dma = (dma_addr_t)mfn << PAGE_SHIFT;
> +	unsigned long bfn = pfn_to_bfn(PFN_DOWN(paddr));
> +	dma_addr_t dma = (dma_addr_t)bfn << PAGE_SHIFT;
>  
>  	dma |= paddr & ~PAGE_MASK;
>  
> @@ -92,7 +92,7 @@ static inline dma_addr_t xen_phys_to_bus(phys_addr_t paddr)
>  
>  static inline phys_addr_t xen_bus_to_phys(dma_addr_t baddr)
>  {
> -	unsigned long pfn = mfn_to_pfn(PFN_DOWN(baddr));
> +	unsigned long pfn = bfn_to_pfn(PFN_DOWN(baddr));
>  	dma_addr_t dma = (dma_addr_t)pfn << PAGE_SHIFT;
>  	phys_addr_t paddr = dma;
>  
> @@ -110,15 +110,15 @@ static int check_pages_physically_contiguous(unsigned long pfn,
>  					     unsigned int offset,
>  					     size_t length)
>  {
> -	unsigned long next_mfn;
> +	unsigned long next_bfn;
>  	int i;
>  	int nr_pages;
>  
> -	next_mfn = pfn_to_mfn(pfn);
> +	next_bfn = pfn_to_bfn(pfn);
>  	nr_pages = (offset + length + PAGE_SIZE-1) >> PAGE_SHIFT;
>  
>  	for (i = 1; i < nr_pages; i++) {
> -		if (pfn_to_mfn(++pfn) != ++next_mfn)
> +		if (pfn_to_bfn(++pfn) != ++next_bfn)
>  			return 0;
>  	}
>  	return 1;
> @@ -138,8 +138,8 @@ static inline int range_straddles_page_boundary(phys_addr_t p, size_t size)
>  
>  static int is_xen_swiotlb_buffer(dma_addr_t dma_addr)
>  {
> -	unsigned long mfn = PFN_DOWN(dma_addr);
> -	unsigned long pfn = mfn_to_local_pfn(mfn);
> +	unsigned long bfn = PFN_DOWN(dma_addr);
> +	unsigned long pfn = bfn_to_local_pfn(bfn);
>  	phys_addr_t paddr;
>  
>  	/* If the address is outside our domain, it CAN
> -- 
> 2.1.4
> 
