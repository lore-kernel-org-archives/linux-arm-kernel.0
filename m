From: will.deacon@arm.com (Will Deacon)
Date: Thu, 26 Jan 2017 12:52:49 +0000
Subject: [PATCH v2] arm64: dma-mapping: Fix dma_mapping_error() when
 bypassing SWIOTLB
In-Reply-To: <840027acb4750542003dff17b4a8902ba8972754.1485368348.git.robin.murphy@arm.com>
References: <20170124225200.a7qioswpxzh6agvd@raspberrypi-2.musicnaut.iki.fi>
 <840027acb4750542003dff17b4a8902ba8972754.1485368348.git.robin.murphy@arm.com>
Message-ID: <20170126125249.GG14167@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 25, 2017 at 06:31:31PM +0000, Robin Murphy wrote:
> When bypassing SWIOTLB on small-memory systems, we need to avoid calling
> into swiotlb_dma_mapping_error() in exactly the same way as we avoid
> swiotlb_dma_supported(), because the former also relies on SWIOTLB state
> being initialised.
> 
> Under the assumptions for which we skip SWIOTLB, dma_map_{single,page}()
> will only ever return the DMA-offset-adjusted physical address of the
> page passed in, thus we can report success unconditionally.
> 
> Fixes: b67a8b29df7e ("arm64: mm: only initialize swiotlb when necessary")
> CC: stable at vger.kernel.org
> CC: Jisheng Zhang <jszhang@marvell.com>
> Reported-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> v2: Get the return value the right way round this time... After some
>     careful reasoning it really is that simple.
> 
>  arch/arm64/mm/dma-mapping.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index e04082700bb1..1ffb7d5d299a 100644
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -352,6 +352,13 @@ static int __swiotlb_dma_supported(struct device *hwdev, u64 mask)
>  	return 1;
>  }
>  
> +static int __swiotlb_dma_mapping_error(struct device *hwdev, dma_addr_t addr)
> +{
> +	if (swiotlb)
> +		return swiotlb_dma_mapping_error(hwdev, addr);
> +	return 0;
> +}

I was about to apply this, but I'm really uncomfortable with the way that
we call into swiotlb without initialising it. For example, if somebody
passes swiotlb=noforce on the command line and all of our memory is
DMA-able, then we don't call swiotlb_init but we will leave the DMA ops
intact. On a dma_map_page, we then end up in swiotlb_map_page. If, for
some reason or another, dma_capable fails (perhaps the address is out of
range), then we call map_single which will return SWIOTLB_MAP_ERROR
and subsequently phys_to_dma(dev, io_tlb_overflow_buffer);, which is
exactly what swiotlb_dma_mapping_error checks for. Except it won't get the
chance, because our swiotlb variable is false.

I can see three ways to resolve this:

1. Revert the hack that skips SWIOTLB initialisation and pay the 64m price
   (but this is configurable on the cmdline).

2. Keep the hack, but instead of skipping initialisation altogether,
   automatically adjust the bounce buffer size to a single entry. This
   shouldn't ever get used, but will allow the error paths to work.

3. We bite the bullet and implement some non-swiotlb DMA ops for the case
   when SWIOTLB is not used.

Thoughts?

Will
