From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Thu, 29 Nov 2018 09:50:59 +0000
Subject: [PATCH v2] ARM: dma-mapping: fix potential uninitialized return
In-Reply-To: <20181128185910.5778-1-nathanj439@gmail.com>
References: <20181128173929.3050-1-nathanj439@gmail.com>
 <20181128185910.5778-1-nathanj439@gmail.com>
Message-ID: <401b58b2-fb17-dc83-f898-c10cafdc5413@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/28/18 6:59 PM, Nathan Jones wrote:
> If neither of the if() statements fire then the return value is
> uninitialized. In the worst case it returns 0 which means the caller
> will think the function succeeded.

"ret" is updated indirectly via:

        if (dma_mmap_from_dev_coherent(dev, vma, cpu_addr, size, &ret))
                return ret;

I assume that it was found with static analyzer or like this, in such case
please, provide output produced by the tool.

> 
> Fixes: 1655cf8829d8 ("ARM: dma-mapping: Remove traces of NOMMU code")

I'll leave it up to Russell.

Cheers
Vladimir

> Signed-off-by: Nathan Jones <nathanj439@gmail.com>
> ---
>  arch/arm/mm/dma-mapping.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index 661fe48ab78d..78de138aa66d 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -829,7 +829,7 @@ static int __arm_dma_mmap(struct device *dev, struct vm_area_struct *vma,
>  		 void *cpu_addr, dma_addr_t dma_addr, size_t size,
>  		 unsigned long attrs)
>  {
> -	int ret;
> +	int ret = -ENXIO;
>  	unsigned long nr_vma_pages = vma_pages(vma);
>  	unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
>  	unsigned long pfn = dma_to_pfn(dev, dma_addr);
> 
