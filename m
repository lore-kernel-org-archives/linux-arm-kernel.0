From: lars@metafoo.de (Lars-Peter Clausen)
Date: Mon, 22 Apr 2013 08:11:10 +0200
Subject: [RFC/PATCH 1/4] arm64: Provide default implementation for
 dma_{alloc, free}_attrs
In-Reply-To: <1366607349-2992-1-git-send-email-dhobsong@igel.co.jp>
References: <1366607349-2992-1-git-send-email-dhobsong@igel.co.jp>
Message-ID: <5174D47E.3090301@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/22/2013 07:09 AM, Damian Hobson-Garcia wrote:
> Most architectures that define CONFIG_HAVE_DMA, have implementations for
> both dma_alloc_attrs() and dma_free_attrs().  All achitectures that do
> not define CONFIG_HAVE_DMA also have both of these definitions provided by
> dma-mapping-broken.h.
> 
> Add default implementations for these functions on arm64.
> 
> Signed-off-by: Damian Hobson-Garcia <dhobsong@igel.co.jp>
> ---
>  arch/arm64/include/asm/dma-mapping.h |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/dma-mapping.h b/arch/arm64/include/asm/dma-mapping.h
> index 9947768..65ab181 100644
> --- a/arch/arm64/include/asm/dma-mapping.h
> +++ b/arch/arm64/include/asm/dma-mapping.h
> @@ -81,6 +81,9 @@ static inline void dma_mark_clean(void *addr, size_t size)
>  {
>  }
>  
> +#define dma_alloc_attrs(d, s, h, f, a) dma_alloc_coherent(d, s, h, f)
> +#define dma_free_attrs(d, s, h, f, a) dma_free_coherent(d, s, h, f)
> +
>  static inline void *dma_alloc_coherent(struct device *dev, size_t size,
>  				       dma_addr_t *dma_handle, gfp_t flags)
>  {

The other way around would be better, properly implement
dma_{alloc,free}_attrs and implement dma_{alloc,free}_coherent on top of
the. E.g. you are supposed to pass the attrs parameter to ops->alloc and
ops->free instead of NULL. And it will also allow us to move
dma_{alloc,free}_coherent to asm-generic/dma-mapping-common.h eventually.

- Lars
