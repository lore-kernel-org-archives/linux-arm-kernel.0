From: will.deacon@arm.com (Will Deacon)
Date: Mon, 21 May 2018 19:47:17 +0100
Subject: [PATCH] iommu/io-pgtable-arm: Make allocations NUMA-aware
In-Reply-To: <b745ecc2acd6aad20b5c3776ecd58022a9019c91.1526926225.git.robin.murphy@arm.com>
References: <b745ecc2acd6aad20b5c3776ecd58022a9019c91.1526926225.git.robin.murphy@arm.com>
Message-ID: <20180521184717.GA24025@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 21, 2018 at 07:12:40PM +0100, Robin Murphy wrote:
> We would generally expect pagetables to be read by the IOMMU more than
> written by the CPU, so in NUMA systems it would be preferable to avoid
> the IOMMU making cross-node pagetable walks if possible. We already have
> a handle on the IOMMU device for the sake of coherency management, so
> it's trivial to grab the appropriate NUMA node when allocating new
> pagetable pages.
> 
> Note that we drop the semantics of alloc_pages_exact(), but that's fine
> since they have never been necessary: the only time we're allocating
> more than one page is for stage 2 top-level concatenation, but since
> that is based on the number of IPA bits, the size is always some exact
> power of two anyway.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/io-pgtable-arm.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index 39c2a056da21..e80ca386c5b4 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -231,12 +231,16 @@ static void *__arm_lpae_alloc_pages(size_t size, gfp_t gfp,
>  				    struct io_pgtable_cfg *cfg)
>  {
>  	struct device *dev = cfg->iommu_dev;
> +	int order = get_order(size);
> +	struct page *p;
>  	dma_addr_t dma;
> -	void *pages = alloc_pages_exact(size, gfp | __GFP_ZERO);
> +	void *pages;
>  
> -	if (!pages)
> +	p = alloc_pages_node(dev_to_node(dev), gfp | __GFP_ZERO, order);
> +	if (!p)
>  		return NULL;
>  
> +	pages = page_address(p);

Might be worth checking/masking out __GFP_HIGHMEM if we see it, since we
could theoretically run into trouble if we got back a highmem mapping here
and we're losing the check in __get_free_pages afaict.

Other than than, looks good:

Acked-by: Will Deacon <will.deacon@arm.com>

Will
