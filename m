From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Fri, 27 Nov 2015 12:04:22 +0000
Subject: [PATCH v3 47/62] arm/p2m: Add helper functions to map memory
 regions
In-Reply-To: <1447753261-7552-48-git-send-email-shannon.zhao@linaro.org>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-48-git-send-email-shannon.zhao@linaro.org>
Message-ID: <alpine.DEB.2.02.1511271203460.8984@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Nov 2015, shannon.zhao at linaro.org wrote:
> From: Parth Dixit <parth.dixit@linaro.org>
> 
> Create a helper function for mapping with cached attributes.
> 
> Signed-off-by: Parth Dixit <parth.dixit@linaro.org>
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>

You might be able to use the existing guest_physmap_add_entry and
guest_physmap_remove_page for your purposes.


>  xen/arch/arm/p2m.c        | 26 ++++++++++++++++++++++++++
>  xen/include/asm-arm/p2m.h | 10 ++++++++++
>  2 files changed, 36 insertions(+)
> 
> diff --git a/xen/arch/arm/p2m.c b/xen/arch/arm/p2m.c
> index e396c40..7a108d8 100644
> --- a/xen/arch/arm/p2m.c
> +++ b/xen/arch/arm/p2m.c
> @@ -1140,6 +1140,32 @@ int p2m_populate_ram(struct domain *d,
>                               d->arch.p2m.default_access);
>  }
>  
> +int map_regions(struct domain *d,
> +                     unsigned long start_gfn,
> +                     unsigned long nr,
> +                     unsigned long mfn)
> +{
> +    return apply_p2m_changes(d, INSERT,
> +                             pfn_to_paddr(start_gfn),
> +                             pfn_to_paddr(start_gfn + nr),
> +                             pfn_to_paddr(mfn),
> +                             MATTR_MEM, 0, p2m_mmio_direct,
> +                             d->arch.p2m.default_access);
> +}
> +
> +int unmap_regions(struct domain *d,
> +                       unsigned long start_gfn,
> +                       unsigned long nr,
> +                       unsigned long mfn)
> +{
> +    return apply_p2m_changes(d, REMOVE,
> +                             pfn_to_paddr(start_gfn),
> +                             pfn_to_paddr(start_gfn + nr),
> +                             pfn_to_paddr(mfn),
> +                             MATTR_MEM, 0, p2m_invalid,
> +                             d->arch.p2m.default_access);
> +}
> +
>  int map_mmio_regions(struct domain *d,
>                       unsigned long start_gfn,
>                       unsigned long nr,
> diff --git a/xen/include/asm-arm/p2m.h b/xen/include/asm-arm/p2m.h
> index 08bdce3..b6215f9 100644
> --- a/xen/include/asm-arm/p2m.h
> +++ b/xen/include/asm-arm/p2m.h
> @@ -158,6 +158,16 @@ int p2m_cache_flush(struct domain *d, xen_pfn_t start_mfn, xen_pfn_t end_mfn);
>  /* Setup p2m RAM mapping for domain d from start-end. */
>  int p2m_populate_ram(struct domain *d, paddr_t start, paddr_t end);
>  
> +int map_regions(struct domain *d,
> +                    unsigned long start_gfn,
> +                    unsigned long nr_mfns,
> +                    unsigned long mfn);
> +
> +int unmap_regions(struct domain *d,
> +                    unsigned long start_gfn,
> +                    unsigned long nr_mfns,
> +                    unsigned long mfn);
> +
>  int guest_physmap_add_entry(struct domain *d,
>                              unsigned long gfn,
>                              unsigned long mfn,
> -- 
> 2.1.0
> 
