From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Wed, 6 Nov 2013 16:19:36 +0000
Subject: [PATCH] arm,arm64: Conditionalize bio_vec usage
In-Reply-To: <1383743117-4138-1-git-send-email-treding@nvidia.com>
References: <1383743117-4138-1-git-send-email-treding@nvidia.com>
Message-ID: <alpine.DEB.2.02.1311061618250.26077@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 6 Nov 2013, Thierry Reding wrote:
> Commit 3d1975b57097 (arm,arm64: do not always merge bio_vec if we are
> running on Xen) unconditionally added code using the bio_vec typedefs
> which causes build errors on configurations where CONFIG_BLOCK is
> disabled.
> 
> Add #ifdef CONFIG_BLOCK protection to fix this.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Thierry, thank you for the patch.
However I was thinking of declaring struct bio_vec instead, see:

http://marc.info/?l=linux-kernel&m=138374169030300&w=2



>  arch/arm/include/asm/io.h   | 2 ++
>  arch/arm64/include/asm/io.h | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
> index c45effc..68ef696 100644
> --- a/arch/arm/include/asm/io.h
> +++ b/arch/arm/include/asm/io.h
> @@ -367,6 +367,7 @@ struct pci_dev;
>  
>  extern void pci_iounmap(struct pci_dev *dev, void __iomem *addr);
>  
> +#ifdef CONFIG_BLOCK
>  /*
>   * can the hardware map this into one segment or not, given no other
>   * constraints.
> @@ -379,6 +380,7 @@ extern bool xen_biovec_phys_mergeable(const struct bio_vec *vec1,
>  #define BIOVEC_PHYS_MERGEABLE(vec1, vec2)				\
>  	(__BIOVEC_PHYS_MERGEABLE(vec1, vec2) &&				\
>  	 (!xen_domain() || xen_biovec_phys_mergeable(vec1, vec2)))
> +#endif
>  
>  #ifdef CONFIG_MMU
>  #define ARCH_HAS_VALID_PHYS_ADDR_RANGE
> diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
> index 5a482fc..940dbe2 100644
> --- a/arch/arm64/include/asm/io.h
> +++ b/arch/arm64/include/asm/io.h
> @@ -266,11 +266,13 @@ extern int devmem_is_allowed(unsigned long pfn);
>   */
>  #define xlate_dev_kmem_ptr(p)	p
>  
> +#ifdef CONFIG_BLOCK
>  extern bool xen_biovec_phys_mergeable(const struct bio_vec *vec1,
>  				      const struct bio_vec *vec2);
>  #define BIOVEC_PHYS_MERGEABLE(vec1, vec2)				\
>  	(__BIOVEC_PHYS_MERGEABLE(vec1, vec2) &&				\
>  	 (!xen_domain() || xen_biovec_phys_mergeable(vec1, vec2)))
> +#endif
>  
>  #endif	/* __KERNEL__ */
>  #endif	/* __ASM_IO_H */
> -- 
> 1.8.4
> 
