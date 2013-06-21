From: rizhao@nvidia.com (Richard Zhao)
Date: Fri, 21 Jun 2013 12:52:40 +0800
Subject: [PATCH] ARM: dma: Drop __GFP_COMP for iommu dma memory allocations
In-Reply-To: <20130620.173511.831032817734076793.hdoyu@nvidia.com>
References: <1371731460-15316-1-git-send-email-rizhao@nvidia.com>
 <51C2FDE0.4060206@cogentembedded.com>
 <CANg6MZg3A7-oXfdUSarQ8n0PRsS0_BLjqfQ914KUoSzDDtShFg@mail.gmail.com>
 <20130620.173511.831032817734076793.hdoyu@nvidia.com>
Message-ID: <20130621045240.GH17331@rizhao-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 20, 2013 at 10:35:11PM +0800, Hiroshi Doyu wrote:
> Richard Zhao <linuxzsc@gmail.com> wrote @ Thu, 20 Jun 2013 15:40:50 +0200:
> 
> > >> +       /*
> > >> +        * Following is a work-around (a.k.a. hack) to prevent pages
> > >> +        * with __GFP_COMP being passed to split_page() which cannot
> > >> +        * handle them.  The real problem is that this flag probably
> > >> +        * should be 0 on ARM as it is not supported on this
> > >> +        * platform; see CONFIG_HUGETLBFS.
> > >> +        */
> > >> +       gfp &= ~(__GFP_COMP);
> > >
> > >
> > >    Hm, what exactly is the sense you meant in using ()?
> > 
> > It's copy/paste from elsewhere in this file. At least it's consistent? :)
> 
> I almost sent the exact same one, actually it was under internal reivew;)
Ah, sorry I didn't search internal mails but only arm mail list for related
fix, since I thought it's not specific to tegra. Why not give it a
Reviewed-by or Tested-by?
> 
> This patch is similar but is the iommu version of:
Exactly.

Thanks
Richard
> 
> 
> commit ea2e7057c0234cfb8b09467d8f137760d371fc72
> Author: Sumit Bhattacharya <sumitb@nvidia.com>
> Date:   Thu Nov 24 00:47:12 2011 +0100
> 
>     ARM: 7172/1: dma: Drop GFP_COMP for DMA memory allocations
>     
>     dma_alloc_coherent wants to split pages after allocation in order to
>     reduce the memory footprint. This does not work well with GFP_COMP
>     pages, so drop this flag before allocation.
>     
>     This patch is ported from arch/avr32
>     (commit 3611553ef985ef7c5863c8a94641738addd04cff).
>     
>     [swarren: s/HUGETLB_PAGE/HUGETLBFS/ in comment, minor comment cleanup]
>     
>     Signed-off-by: Sumit Bhattacharya <sumitb@nvidia.com>
>     Tested-by: Varun Colbert <vcolbert@nvidia.com>
>     Signed-off-by: Stephen Warren <swarren@nvidia.com>
>     Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index ab58456..1aa664a 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -332,6 +332,15 @@ __dma_alloc(struct device *dev, size_t size, dma_addr_t *handle, gfp_t gfp,
>         struct page *page;
>         void *addr;
>  
> +       /*
> +        * Following is a work-around (a.k.a. hack) to prevent pages
> +        * with __GFP_COMP being passed to split_page() which cannot
> +        * handle them.  The real problem is that this flag probably
> +        * should be 0 on ARM as it is not supported on this
> +        * platform; see CONFIG_HUGETLBFS.
> +        */
> +       gfp &= ~(__GFP_COMP);
> +
>         *handle = ~0;
>         size = PAGE_ALIGN(size);
