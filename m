From: konrad.wilk@oracle.com (Konrad Rzeszutek Wilk)
Date: Tue, 20 Nov 2018 09:49:18 -0500
Subject: [PATCH 1/2] swiotlb: Make DIRECT_MAPPING_ERROR viable
In-Reply-To: <e90da5fbab881c502ac3412fb05c44b26c99f73a.1542722463.git.robin.murphy@arm.com>
References: <cover.1542722463.git.robin.murphy@arm.com>
 <e90da5fbab881c502ac3412fb05c44b26c99f73a.1542722463.git.robin.murphy@arm.com>
Message-ID: <20181120144918.GH10917@char.us.oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 20, 2018 at 02:09:52PM +0000, Robin Murphy wrote:
> With the overflow buffer removed, we no longer have a unique address
> which is guaranteed not to be a valid DMA target to use as an error
> token. The DIRECT_MAPPING_ERROR value of 0 tries to at least represent
> an unlikely DMA target, but unfortunately there are already SWIOTLB
> users with DMA-able memory at physical address 0 which now gets falsely
> treated as a mapping failure and leads to all manner of misbehaviour.
> 
> The best we can do to mitigate that is flip DIRECT_MAPPING_ERROR to the
> commonly-used all-bits-set value, since the last single byte of memory
> is by far the least-likely-valid DMA target.

Are all the callers checking for DIRECT_MAPPING_ERROR or is it more of
a comparison (as in if (!ret)) ?


> 
> Fixes: dff8d6c1ed58 ("swiotlb: remove the overflow buffer")]
> Reported-by: John Stultz <john.stultz@linaro.org>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  include/linux/dma-direct.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
> index bd73e7a91410..9de9c7ab39d6 100644
> --- a/include/linux/dma-direct.h
> +++ b/include/linux/dma-direct.h
> @@ -5,7 +5,7 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/mem_encrypt.h>
>  
> -#define DIRECT_MAPPING_ERROR		0
> +#define DIRECT_MAPPING_ERROR		~(dma_addr_t)0
>  
>  #ifdef CONFIG_ARCH_HAS_PHYS_TO_DMA
>  #include <asm/dma-direct.h>
> -- 
> 2.19.1.dirty
> 
