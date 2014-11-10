From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 10 Nov 2014 18:34:54 +0000
Subject: [PATCH v8 10/13] xen/arm/arm64: introduce xen_arch_need_swiotlb
In-Reply-To: <1415636045-24669-10-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1411101607130.22875@kaball.uk.xensource.com>
 <1415636045-24669-10-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <20141110183453.GG25609@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 10, 2014 at 04:14:02PM +0000, Stefano Stabellini wrote:
> --- a/arch/arm/include/asm/xen/page.h
> +++ b/arch/arm/include/asm/xen/page.h
> @@ -107,4 +107,8 @@ static inline bool set_phys_to_machine(unsigned long pfn, unsigned long mfn)
>  #define xen_remap(cookie, size) ioremap_cache((cookie), (size))
>  #define xen_unmap(cookie) iounmap((cookie))
>  
> +bool xen_arch_need_swiotlb(struct device *dev,
> +			   unsigned long pfn,
> +			   unsigned long mfn);
> +
>  #endif /* _ASM_ARM_XEN_PAGE_H */
> diff --git a/arch/arm/xen/mm.c b/arch/arm/xen/mm.c
> index 0e96023..1b087cd 100644
> --- a/arch/arm/xen/mm.c
> +++ b/arch/arm/xen/mm.c
> @@ -102,6 +102,13 @@ void __xen_dma_sync_single_for_device(struct device *hwdev,
>  	__xen_dma_page_cpu_to_dev(hwdev, handle, size, dir);
>  }
>  
> +bool xen_arch_need_swiotlb(struct device *dev,
> +			   unsigned long pfn,
> +			   unsigned long mfn)
> +{
> +	return ((pfn != mfn) && !is_device_dma_coherent(dev));
> +}

Why not a static inline? It doesn't look like a big function.

-- 
Catalin
