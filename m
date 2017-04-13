From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 13 Apr 2017 23:10:55 +0100
Subject: [PATCH] ARM: dma-mapping: add check for coherent DMA memory
 without struct page
In-Reply-To: <20170413214756.21265-1-shuahkh@osg.samsung.com>
References: <20170413214756.21265-1-shuahkh@osg.samsung.com>
Message-ID: <20170413221055.GE17774@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 13, 2017 at 03:47:56PM -0600, Shuah Khan wrote:
> When coherent DMA memory without struct page is shared, importer
> fails to find the page and runs into kernel page fault when it
> tries to dmabuf_ops_attach/map_sg/map_page the invalid page found
> in the sg_table.
> 
> Add a new dma_check_dev_coherent() interface to check if memory is
> from the device coherent area. There is no way to tell where the
> memory returned by dma_alloc_attrs() came from.
> 
> arm_dma_get_sgtable() checks for invalid pages, however this check
> could pass even for memory obtained the coherent allocator. Add an
> additional check to call dma_check_dev_coherent() to confirm that it
> is indeed the coherent DMA memory and fail the sgtable creation with
> -EINVAL.

Sorry, this doesn't make much sense to me.

pfn_valid(pfn) must *never* return true if 'pfn' does not have a struct
page associated with it.  If it returns true (so we allow
arm_dma_get_sgtable() to succeed) then we know we have a valid struct
page in the supplied scatterlist.

> Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
> ---
>  arch/arm/mm/dma-mapping.c   | 11 ++++++++---
>  drivers/base/dma-coherent.c | 25 +++++++++++++++++++++++++
>  include/linux/dma-mapping.h |  2 ++
>  3 files changed, 35 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index 475811f..27c7d9a 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -954,9 +954,14 @@ int arm_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
>  	struct page *page;
>  	int ret;
>  
> -	/* If the PFN is not valid, we do not have a struct page */
> -	if (!pfn_valid(pfn))
> -		return -ENXIO;
> +	/*
> +	 * If the PFN is not valid, we do not have a struct page
> +	 * As this check can pass even for memory obtained through
> +	 * the coherent allocator, do an additional check to determine
> +	 * if this is coherent DMA memory.
> +	 */
> +	if (!pfn_valid(pfn) && dma_check_dev_coherent(dev, handle, cpu_addr))
> +		return -EINVAL;

Right, so what this says is:

	if we do not haev a valid PFN
	_and_ if the memory is from the coherent section
	_then_ fail

Why the extra check?  Under what circunstances do we end up with memory
where the PFN is valid, but we do not have a valid struct page.  It
seems to me that such a scenario is a bug in pfn_valid() and not
something that should be worked around like this.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
