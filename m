From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 16 Apr 2015 17:33:21 +0200
Subject: [PATCH v2] dmaengine: xgene-dma: Fix sparse wannings and
 coccinelle warnings
In-Reply-To: <1429197631-15070-1-git-send-email-rsahu@apm.com>
References: <1429197631-15070-1-git-send-email-rsahu@apm.com>
Message-ID: <2380730.12OTUPVkl5@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 16 April 2015 20:50:30 Rameshwar Prasad Sahu wrote:
> v2 changes:
> 	* Code cleanup
> 	* Changed way of setting DMA descriptors for big-endian
> 
> This patch fixes compilation sparse warnings like incorrect type in assignment
> (different base types), cast to restricted __le64, symbol
> '__UNIQUE_ID_author__COUNTER__' has multiple initializers etc and
> coccinelle warnings (No need to set .owner here. The core will do it.)
> 
> This patch is based on slave-dma / for-linus branch.
> (commit: 9f2fd0dfa594d857fbdaeda523ff7a46f16567f5 [26/28]
> 	dmaengine: Add support for APM X-Gene SoC DMA engine driver)
> 
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Signed-off-by: Rameshwar Prasad Sahu <rsahu@apm.com>

Much better!

> -static void xgene_dma_set_src_buffer(void *ext8, size_t *len,
> +static void xgene_dma_set_src_buffer(__le64 *ext8, size_t *len,
>  				     dma_addr_t *paddr)
>  {
>  	size_t nbytes = (*len < XGENE_DMA_MAX_BYTE_CNT) ?
>  			*len : XGENE_DMA_MAX_BYTE_CNT;
> 
> -	XGENE_DMA_DESC_BUFADDR_SET(ext8, *paddr);
> -	XGENE_DMA_DESC_BUFLEN_SET(ext8, xgene_dma_encode_len(nbytes));
> +	*ext8 |= cpu_to_le64(*paddr);
> +	*ext8 |= cpu_to_le64((u64)xgene_dma_encode_len(nbytes) <<
> +			     XGENE_DMA_DESC_BUFLEN_POS);
>  	*len -= nbytes;
>  	*paddr += nbytes;
>  }

Just as a minor enhancement you could change xgene_dma_encode_len()
to already return a u64 type with the shift applied.

> -static void xgene_dma_invalidate_buffer(void *ext8)
> +static void xgene_dma_invalidate_buffer(__le64 *ext8)
>  {
> -	XGENE_DMA_DESC_BUFLEN_SET(ext8, XGENE_DMA_INVALID_LEN_CODE);
> +	*ext8 |= cpu_to_le64((u64)XGENE_DMA_INVALID_LEN_CODE <<
> +			     XGENE_DMA_DESC_BUFLEN_POS);
>  }

Same here, if you define XGENE_DMA_INVALID_LEN_CODE as

#define XGENE_DMA_INVALID_LEN_CODE	0x7800000000000000ul

it directly matches what one would find in the data sheet, and
also simplifies this function.

	Arnd
