From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 13 Jan 2015 12:19:12 +0100
Subject: [PATCH RESEND] dma-mapping: tidy up dma_parms default handling
In-Reply-To: <ffdc5455d698d2525f2d126d0adabf9418fd76b1.1418990609.git.robin.murphy@arm.com>
References: <ffdc5455d698d2525f2d126d0adabf9418fd76b1.1418990609.git.robin.murphy@arm.com>
Message-ID: <54B4FF30.2030607@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 2015-01-09 17:56, Robin Murphy wrote:
> Many DMA controllers and other devices set max_segment_size to
> indicate their scatter-gather capability, but have no interest in
> segment_boundary_mask. However, the existence of a dma_parms structure
> precludes the use of any default value, leaving them as zeros (assuming
> a properly kzalloc'ed structure). If a well-behaved IOMMU (or SWIOTLB)
> then tries to respect this by ensuring a mapped segment does not cross
> a zero-byte boundary, hilarity ensues.
>
> Since zero is a nonsensical value for either parameter, treat it as an
> indicator for "default", as might be expected. In the process, clean up
> a bit by replacing the bare constants with slightly more meaningful
> macros and removing the superfluous "else" statements.
>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>

> ---
>
> Hi, various maintainers from Git logs ;)
>
> This one's a bit tricky to find a home for - I think technically it's
> probably an IOMMU patch, but then the long-underlying problem doesn't
> seem to have blown up anything until arm64, and my motivation is to
> make bits of Juno work, which seems to nudge it towards arm64/arm-soc
> territory. Could anyone suggest which tree is most appropriate?
>
> Thanks,
> Robin.
>
>   include/linux/dma-mapping.h | 17 ++++++++++-------
>   1 file changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index c3007cb..99ba736 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -141,7 +141,9 @@ static inline void arch_teardown_dma_ops(struct device *dev) { }
>   
>   static inline unsigned int dma_get_max_seg_size(struct device *dev)
>   {
> -	return dev->dma_parms ? dev->dma_parms->max_segment_size : 65536;
> +	if (dev->dma_parms && dev->dma_parms->max_segment_size)
> +		return dev->dma_parms->max_segment_size;
> +	return SZ_64K;
>   }
>   
>   static inline unsigned int dma_set_max_seg_size(struct device *dev,
> @@ -150,14 +152,15 @@ static inline unsigned int dma_set_max_seg_size(struct device *dev,
>   	if (dev->dma_parms) {
>   		dev->dma_parms->max_segment_size = size;
>   		return 0;
> -	} else
> -		return -EIO;
> +	}
> +	return -EIO;
>   }
>   
>   static inline unsigned long dma_get_seg_boundary(struct device *dev)
>   {
> -	return dev->dma_parms ?
> -		dev->dma_parms->segment_boundary_mask : 0xffffffff;
> +	if (dev->dma_parms && dev->dma_parms->segment_boundary_mask)
> +		return dev->dma_parms->segment_boundary_mask;
> +	return DMA_BIT_MASK(32);
>   }
>   
>   static inline int dma_set_seg_boundary(struct device *dev, unsigned long mask)
> @@ -165,8 +168,8 @@ static inline int dma_set_seg_boundary(struct device *dev, unsigned long mask)
>   	if (dev->dma_parms) {
>   		dev->dma_parms->segment_boundary_mask = mask;
>   		return 0;
> -	} else
> -		return -EIO;
> +	}
> +	return -EIO;
>   }
>   
>   #ifndef dma_max_pfn

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
