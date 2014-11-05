From: mina86@mina86.com (Michal Nazarewicz)
Date: Wed, 05 Nov 2014 22:58:37 +0100
Subject: [PATCH 2/2] mm: cma: Align to physical address,
 not CMA region position
In-Reply-To: <1415218078-10078-2-git-send-email-gregory.0xf0@gmail.com>
References: <1415218078-10078-1-git-send-email-gregory.0xf0@gmail.com>
 <1415218078-10078-2-git-send-email-gregory.0xf0@gmail.com>
Message-ID: <xa1tvbmtwbqq.fsf@mina86.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 05 2014, Gregory Fong wrote:
> The alignment in cma_alloc() was done w.r.t. the bitmap.  This is a
> problem when, for example:
>
> - a device requires 16M (order 12) alignment
> - the CMA region is not 16 M aligned
>
> In such a case, can result with the CMA region starting at, say,
> 0x2f800000 but any allocation you make from there will be aligned from
> there.  Requesting an allocation of 32 M with 16 M alignment will
> result in an allocation from 0x2f800000 to 0x31800000, which doesn't
> work very well if your strange device requires 16M alignment.
>
> Change to use bitmap_find_next_zero_area_off() to account for the
> difference in alignment at reserve-time and alloc-time.
>
> Cc: Michal Nazarewicz <mina86@mina86.com>

Acked-by: Michal Nazarewicz <mina86@mina86.com>

> Signed-off-by: Gregory Fong <gregory.0xf0@gmail.com>
> ---
>  mm/cma.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/mm/cma.c b/mm/cma.c
> index fde706e..0813599 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -63,6 +63,17 @@ static unsigned long cma_bitmap_aligned_mask(struct cma *cma, int align_order)
>  	return (1UL << (align_order - cma->order_per_bit)) - 1;
>  }
>  
> +static unsigned long cma_bitmap_aligned_offset(struct cma *cma, int align_order)
> +{
> +	unsigned int alignment;
> +
> +	if (align_order <= cma->order_per_bit)
> +		return 0;
> +	alignment = 1UL << (align_order - cma->order_per_bit);
> +	return ALIGN(cma->base_pfn, alignment) -
> +		(cma->base_pfn >> cma->order_per_bit);
> +}
> +
>  static unsigned long cma_bitmap_maxno(struct cma *cma)
>  {
>  	return cma->count >> cma->order_per_bit;
> @@ -328,7 +339,7 @@ err:
>   */
>  struct page *cma_alloc(struct cma *cma, int count, unsigned int align)
>  {
> -	unsigned long mask, pfn, start = 0;
> +	unsigned long mask, offset, pfn, start = 0;
>  	unsigned long bitmap_maxno, bitmap_no, bitmap_count;
>  	struct page *page = NULL;
>  	int ret;
> @@ -343,13 +354,15 @@ struct page *cma_alloc(struct cma *cma, int count, unsigned int align)
>  		return NULL;
>  
>  	mask = cma_bitmap_aligned_mask(cma, align);
> +	offset = cma_bitmap_aligned_offset(cma, align);
>  	bitmap_maxno = cma_bitmap_maxno(cma);
>  	bitmap_count = cma_bitmap_pages_to_bits(cma, count);
>  
>  	for (;;) {
>  		mutex_lock(&cma->lock);
> -		bitmap_no = bitmap_find_next_zero_area(cma->bitmap,
> -				bitmap_maxno, start, bitmap_count, mask);
> +		bitmap_no = bitmap_find_next_zero_area_off(cma->bitmap,
> +				bitmap_maxno, start, bitmap_count, mask,
> +				offset);
>  		if (bitmap_no >= bitmap_maxno) {
>  			mutex_unlock(&cma->lock);
>  			break;
> -- 
> 1.9.1
>

-- 
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=./ `o
..o | Computer Science,  Micha? ?mina86? Nazarewicz    (o o)
ooo +--<mpn@google.com>--<xmpp:mina86@jabber.org>--ooO--(_)--Ooo--
