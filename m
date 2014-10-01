From: will.deacon@arm.com (Will Deacon)
Date: Wed, 1 Oct 2014 11:13:23 +0100
Subject: [PATCH] arm64: Use and error-check DMA_ERROR_CODE
In-Reply-To: <1412108121-19262-1-git-send-email-seanpaul@chromium.org>
References: <1412108121-19262-1-git-send-email-seanpaul@chromium.org>
Message-ID: <20141001101323.GB2587@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sean,

On Tue, Sep 30, 2014 at 09:15:21PM +0100, Sean Paul wrote:
> This patch replaces the static assignment of ~0 to dma_handle with
> DMA_ERROR_CODE to be consistent with other platforms.
> 
> In addition to that, it also adds a check for DMA_ERROR_CODE before
> calling __dma_free_coherent with an invalid dma_handle.
> 
> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> ---
>  arch/arm64/mm/dma-mapping.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index 4164c5a..69fd2c4 100644
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -125,7 +125,7 @@ static void *__dma_alloc_noncoherent(struct device *dev, size_t size,
>  no_map:
>  	__dma_free_coherent(dev, size, ptr, *dma_handle, attrs);
>  no_mem:
> -	*dma_handle = ~0;
> +	*dma_handle = DMA_ERROR_CODE;
>  	return NULL;
>  }
>  
> @@ -136,7 +136,9 @@ static void __dma_free_noncoherent(struct device *dev, size_t size,
>  	void *swiotlb_addr = phys_to_virt(dma_to_phys(dev, dma_handle));
>  
>  	vunmap(vaddr);
> -	__dma_free_coherent(dev, size, swiotlb_addr, dma_handle, attrs);
> +
> +	if (dma_handle != DMA_ERROR_CODE)
> +		__dma_free_coherent(dev, size, swiotlb_addr, dma_handle, attrs);

Is it legal to try and free a DMA buffer after a failed allocation? If so, I
think we need something similar for arch/arm/.

Will
