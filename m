From: will.deacon@arm.com (Will Deacon)
Date: Tue, 22 Apr 2014 11:02:01 +0100
Subject: [RFC][PATCH] arm64: Add atomic pool for dma mapping
In-Reply-To: <1397764941-1351-1-git-send-email-lauraa@codeaurora.org>
References: <1397764941-1351-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <20140422100201.GB7484@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laura,

On Thu, Apr 17, 2014 at 09:02:21PM +0100, Laura Abbott wrote:
> Neither CMA nor noncoherent allocations support atomic allocations.
> Add a dedicated atomic pool to support this.
> 
> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
> ---
>  arch/arm64/mm/dma-mapping.c | 186 +++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 184 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index 0ba347e..c67a3ff 100644
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -38,6 +38,110 @@ static pgprot_t __get_dma_pgprot(struct dma_attrs *attrs, pgprot_t prot,
>  	return prot;
>  }
>  
> +#define DEFAULT_DMA_COHERENT_POOL_SIZE  SZ_256K
> +
> +struct dma_pool {
> +	size_t size;
> +	spinlock_t lock;
> +	void *coherent_vaddr;
> +	void *noncoherent_vaddr;
> +	unsigned long *bitmap;
> +	unsigned long nr_pages;
> +	struct page **pages;
> +};
> +
> +static struct dma_pool atomic_pool = {
> +	.size = DEFAULT_DMA_COHERENT_POOL_SIZE,
> +};
> +
> +static int __init early_coherent_pool(char *p)
> +{
> +	atomic_pool.size = memparse(p, &p);
> +	return 0;
> +}
> +early_param("coherent_pool", early_coherent_pool);

What happened to the device-tree bindings we discussed in Edinburgh with
Grant and Ben? This looks like a good opportunity to make use of those,
rather than use the command-line as we do for arch/arm.

Will
