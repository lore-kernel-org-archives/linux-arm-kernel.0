From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 28 Nov 2018 17:47:29 +0000
Subject: [PATCH] ARM: dma-mapping: fix potential uninitialized return
In-Reply-To: <20181128173929.3050-1-nathanj439@gmail.com>
References: <20181128173929.3050-1-nathanj439@gmail.com>
Message-ID: <20181128174729.GK30658@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 28, 2018 at 12:39:29PM -0500, Nathan Jones wrote:
> If neither of the if() statements fire then the return value is
> uninitialized. In the worst case it returns 0 which means the caller
> will think the function succeeded.
> 
> Signed-off-by: Nathan Jones <nathanj439@gmail.com>

This needs a fixes tag, since this bug was introduced by:

commit 1655cf8829d82d367d8fdb5cb58e5885d7d2a391
Author: Vladimir Murzin <vladimir.murzin@arm.com>
Date:   Wed May 24 11:24:32 2017 +0100

    ARM: dma-mapping: Remove traces of NOMMU code

    DMA operations for NOMMU case have been just factored out into
    separate compilation unit, so don't keep dead code.

    Tested-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
    Tested-by: Andras Szemzo <sza@esh.hu>
    Tested-by: Alexandre TORGUE <alexandre.torgue@st.com>
    Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
    Acked-by: Arnd Bergmann <arnd@arndb.de>
    Acked-by: Russell King <rmk+kernel@armlinux.org.uk>
    Signed-off-by: Christoph Hellwig <hch@lst.de>

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
> -- 
> 2.19.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
