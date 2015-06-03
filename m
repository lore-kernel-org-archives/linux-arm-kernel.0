From: mike.looijmans@topic.nl (Mike Looijmans)
Date: Wed, 3 Jun 2015 09:52:09 +0200
Subject: [PATCH v3] arm/mm/dma-mapping.c: Add arm_coherent_dma_mmap
In-Reply-To: <1431003257-7794-1-git-send-email-mike.looijmans@topic.nl>
References: <1431003257-7794-1-git-send-email-mike.looijmans@topic.nl>
Message-ID: <556EB229.1060409@topic.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

?Ping!

Just curious, any further feedback or comment after Arnd Bergmann's ack?

It fixes a bug that took quite some time to discover and analyze, we should 
save other people going through that same trouble.

On 07-05-15 14:54, Mike Looijmans wrote:
> When dma-coherent transfers are enabled, the mmap call must
> not change the pg_prot flags in the vma struct.
>
> Split the arm_dma_mmap into a common and specific parts,
> and add a "arm_coherent_dma_mmap" implementation that does
> not alter the page protection flags.
>
> Tested on a topic-miami board (Zynq) using the ACP port
> to transfer data between FPGA and CPU using the Dyplo
> framework. Without this patch, byte-wise access to mmapped
> coherent DMA memory was about 20x slower because of the
> memory being marked as non-cacheable, and transfer speeds
> would not exceed 240MB/s.
>
> After this patch, the mapped memory is cacheable and the
> transfer speed is again 600MB/s (limited by the FPGA) when
> the data is in the L2 cache, while data integrity is being
> maintained.
>
> The patch has no effect on non-coherent DMA.
>
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> ---
> v2: Mistakenly sent the wrong patch which included a devicetree file, removed it from the patch.
> v3: Rebased on current linux master because the patch was made on 3.19 and did not apply cleanly.
>
>   arch/arm/mm/dma-mapping.c | 32 +++++++++++++++++++++++++-------
>   1 file changed, 25 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index 09c5fe3..d6f5256 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -148,11 +148,14 @@ static void *arm_coherent_dma_alloc(struct device *dev, size_t size,
>   	dma_addr_t *handle, gfp_t gfp, struct dma_attrs *attrs);
>   static void arm_coherent_dma_free(struct device *dev, size_t size, void *cpu_addr,
>   				  dma_addr_t handle, struct dma_attrs *attrs);
> +static int arm_coherent_dma_mmap(struct device *dev, struct vm_area_struct *vma,
> +		 void *cpu_addr, dma_addr_t dma_addr, size_t size,
> +		 struct dma_attrs *attrs);
>
>   struct dma_map_ops arm_coherent_dma_ops = {
>   	.alloc			= arm_coherent_dma_alloc,
>   	.free			= arm_coherent_dma_free,
> -	.mmap			= arm_dma_mmap,
> +	.mmap			= arm_coherent_dma_mmap,
>   	.get_sgtable		= arm_dma_get_sgtable,
>   	.map_page		= arm_coherent_dma_map_page,
>   	.map_sg			= arm_dma_map_sg,
> @@ -690,10 +693,7 @@ static void *arm_coherent_dma_alloc(struct device *dev, size_t size,
>   			   attrs, __builtin_return_address(0));
>   }
>
> -/*
> - * Create userspace mapping for the DMA-coherent memory.
> - */
> -int arm_dma_mmap(struct device *dev, struct vm_area_struct *vma,
> +static int __arm_dma_mmap(struct device *dev, struct vm_area_struct *vma,
>   		 void *cpu_addr, dma_addr_t dma_addr, size_t size,
>   		 struct dma_attrs *attrs)
>   {
> @@ -704,8 +704,6 @@ int arm_dma_mmap(struct device *dev, struct vm_area_struct *vma,
>   	unsigned long pfn = dma_to_pfn(dev, dma_addr);
>   	unsigned long off = vma->vm_pgoff;
>
> -	vma->vm_page_prot = __get_dma_pgprot(attrs, vma->vm_page_prot);
> -
>   	if (dma_mmap_from_coherent(dev, vma, cpu_addr, size, &ret))
>   		return ret;
>
> @@ -721,6 +719,26 @@ int arm_dma_mmap(struct device *dev, struct vm_area_struct *vma,
>   }
>
>   /*
> + * Create userspace mapping for the DMA-coherent memory.
> + */
> +static int arm_coherent_dma_mmap(struct device *dev, struct vm_area_struct *vma,
> +		 void *cpu_addr, dma_addr_t dma_addr, size_t size,
> +		 struct dma_attrs *attrs)
> +{
> +	return __arm_dma_mmap(dev, vma, cpu_addr, dma_addr, size, attrs);
> +}
> +
> +int arm_dma_mmap(struct device *dev, struct vm_area_struct *vma,
> +		 void *cpu_addr, dma_addr_t dma_addr, size_t size,
> +		 struct dma_attrs *attrs)
> +{
> +#ifdef CONFIG_MMU
> +	vma->vm_page_prot = __get_dma_pgprot(attrs, vma->vm_page_prot);
> +#endif	/* CONFIG_MMU */
> +	return __arm_dma_mmap(dev, vma, cpu_addr, dma_addr, size, attrs);
> +}
> +
> +/*
>    * Free a buffer as defined by the above mapping.
>    */
>   static void __arm_dma_free(struct device *dev, size_t size, void *cpu_addr,
>



Kind regards,

Mike Looijmans
System Expert

TOPIC Embedded Products
Eindhovenseweg 32-C, NL-5683 KH Best
Postbus 440, NL-5680 AK Best
Telefoon: +31 (0) 499 33 69 79
Telefax: +31 (0) 499 33 69 70
E-mail: mike.looijmans at topicproducts.com
Website: www.topicproducts.com

Please consider the environment before printing this e-mail
