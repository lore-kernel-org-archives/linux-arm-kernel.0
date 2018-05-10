From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 10 May 2018 18:45:59 +0100
Subject: [RFC][PATCH] arm64: update iomem_resource.end
In-Reply-To: <1525906703-28481-1-git-send-email-nicoleotsuka@gmail.com>
References: <1525906703-28481-1-git-send-email-nicoleotsuka@gmail.com>
Message-ID: <cfb81f55-f917-431f-0afd-c97e7641a2f8@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/05/18 23:58, Nicolin Chen wrote:
> The iomem_resource.end is -1 by default and should be updated in
> arch-level code.
> 
> ARM64 so far hasn't updated it while core kernel code (mm/hmm.c)
> started to use iomem_resource.end for boundary check. So it'd be
> better to assign iomem_resource.end using a valid value, the end
> of physical address space for example because iomem_resource.end
> in theory should reflect that.
> 
> However, VA_BITS might be smaller than PA_BITS in ARM64. So using
> the end of physical address space doesn't make a lot of sense in
> this case, or could be even harmful since virtual address cannot
> reach that memory region.

Why? There's plenty of stuff in the physical address space that will 
only ever be accessed via ioremap/memremap. There's no reason you 
shouldn't be able to run a VA_BITS < 48 kernel on a Cavium ThunderX 
where *all* the I/O is in the top half of the PA space. We already 
constrain RAM in this very function to those regions which fit into the 
linear map, and if you're accessing anything other than RAM through the 
linear map you're probably doing something wrong.

Furthermore, the physical region covered by the linear map doesn't 
necessarily start@physical address 0 anyway - see PHYS_OFFSET.

Robin.

> Furthermore, the linear region size of
> ARM64 only has the half of Virtual Memory size -- "VA_BITS - 1".
> 
> So this patch updates the iomem_resource.end by using the end of
> physical address space or the end of linear mapping region when
> (VA_BITS - 1) is smaller than PA_BITS.
> 
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
>   arch/arm64/mm/init.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index f48b194..22015af 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -377,6 +377,12 @@ void __init arm64_memblock_init(void)
>   	BUILD_BUG_ON(linear_region_size != BIT(VA_BITS - 1));
>   
>   	/*
> +	 * Update iomem_resource.end based on size of physical address space,
> +	 * or linear region size when (VA_BITS - 1) is smaller than PA_BITS.
> +	 */
> +	iomem_resource.end = BIT(min(PHYS_MASK_SHIFT, VA_BITS - 1)) - 1;
> +
> +	/*
>   	 * Select a suitable value for the base of physical memory.
>   	 */
>   	memstart_addr = round_down(memblock_start_of_DRAM(),
> 
