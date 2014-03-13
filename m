From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 13 Mar 2014 17:52:31 +0000
Subject: [PATCH 2/2] arm64: Support DMA_ATTR_WRITE_COMBINE
In-Reply-To: <1394732716-11507-2-git-send-email-lauraa@codeaurora.org>
References: <1394732716-11507-2-git-send-email-lauraa@codeaurora.org>
Message-ID: <20140313175231.GO30339@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 13, 2014 at 05:45:16PM +0000, Laura Abbott wrote:
> DMA_ATTR_WRITE_COMBINE is currently ignored. Set the pgprot
> appropriately for non coherent opperations.
> 
> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
> ---
>  Potential addition on top of the coherent work as well. Writecombine
>  and dmacoherent seem to be the same at the moment but it might be
>  good practice to have the two be separate?
> 
>  arch/arm64/mm/dma-mapping.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index 9a639bf..d2c0027 100644
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -29,6 +29,15 @@
>  struct dma_map_ops *dma_ops;
>  EXPORT_SYMBOL(dma_ops);
>  
> +
> +static inline pgprot_t __get_dma_pgprot(struct dma_attrs *attrs, pgprot_t prot)
> +{
> +	prot = dma_get_attr(DMA_ATTR_WRITE_COMBINE, attrs) ?
> +			    pgprot_writecombine(prot) :
> +			    pgprot_dmacoherent(prot);
> +	return prot;
> +}

pgprot_writecombine and pgprot_dmacoherent are the same on arm64 (and
ARMv6/v7). So when the DMA is coherent on an SoC, we need to leave the
prot unchanged if !DMA_ATTR_WRITE_COMBINE.

-- 
Catalin
