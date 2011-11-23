From: swarren@nvidia.com (Stephen Warren)
Date: Wed, 23 Nov 2011 11:10:03 -0800
Subject: [PATCH] arm: dma:  Drop GFP_COMP for DMA memory allocations
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF174080512F@HQMAIL01.nvidia.com>
References: <1320442539-7753-1-git-send-email-swarren@nvidia.com>
 <74CDBE0F657A3D45AFBB94109FB122FF174080512F@HQMAIL01.nvidia.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF174F08C785@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Warren wrote at Wednesday, November 09, 2011 11:04 AM:
> Stephen Warren wrote at Friday, November 04, 2011 3:36 PM:
> > dma_alloc_coherent wants to split pages after allocation in order to
> > reduce the memory footprint. This does not work well with GFP_COMP
> > pages, so drop this flag before allocation.
> >
> > This patch is ported from arch/avr32
> > (commit 3611553ef985ef7c5863c8a94641738addd04cff).
> >
> > Signed-off-by: Sumit Bhattacharya <sumitb@nvidia.com>
> > Tested-by: Varun Colbert <vcolbert@nvidia.com>
> > [swarren: s/HUGETLB_PAGE/HUGETLBFS/ in comment, minor comment cleanup]
> > Signed-off-by: Stephen Warren <swarren@nvidia.com>
> 
> Russell, does this look good to go in the patch system now?

ping?

> > ---
> >  arch/arm/mm/dma-mapping.c |    9 +++++++++
> >  1 files changed, 9 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> > index e4e7f6c..68d64b4 100644
> > --- a/arch/arm/mm/dma-mapping.c
> > +++ b/arch/arm/mm/dma-mapping.c
> > @@ -332,6 +332,15 @@ __dma_alloc(struct device *dev, size_t size, dma_addr_t *handle, gfp_t gfp,
> >  	struct page *page;
> >  	void *addr;
> >
> > +	/*
> > +	 * Following is a work-around (a.k.a. hack) to prevent pages
> > +	 * with __GFP_COMP being passed to split_page() which cannot
> > +	 * handle them.  The real problem is that this flag probably
> > +	 * should be 0 on ARM as it is not supported on this
> > +	 * platform; see CONFIG_HUGETLBFS.
> > +	 */
> > +	gfp &= ~(__GFP_COMP);
> > +
> >  	*handle = ~0;
> >  	size = PAGE_ALIGN(size);
> >
> > --
> > 1.7.0.4

-- 
nvpublic
