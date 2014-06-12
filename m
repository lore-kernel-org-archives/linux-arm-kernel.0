From: mina86@mina86.com (Michal Nazarewicz)
Date: Thu, 12 Jun 2014 12:19:54 +0200
Subject: [PATCH v2 05/10] DMA, CMA: support arbitrary bitmap granularity
In-Reply-To: <1402543307-29800-6-git-send-email-iamjoonsoo.kim@lge.com>
References: <1402543307-29800-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1402543307-29800-6-git-send-email-iamjoonsoo.kim@lge.com>
Message-ID: <xa1t61k6juph.fsf@mina86.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 12 2014, Joonsoo Kim <iamjoonsoo.kim@lge.com> wrote:
> ppc kvm's cma region management requires arbitrary bitmap granularity,
> since they want to reserve very large memory and manage this region
> with bitmap that one bit for several pages to reduce management overheads.
> So support arbitrary bitmap granularity for following generalization.
>
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Acked-by: Michal Nazarewicz <mina86@mina86.com>

> diff --git a/drivers/base/dma-contiguous.c b/drivers/base/dma-contiguous.c
> index bc4c171..9bc9340 100644
> --- a/drivers/base/dma-contiguous.c
> +++ b/drivers/base/dma-contiguous.c
> @@ -38,6 +38,7 @@ struct cma {
>  	unsigned long	base_pfn;
>  	unsigned long	count;

Have you considered replacing count with maxno?

>  	unsigned long	*bitmap;
> +	int order_per_bit; /* Order of pages represented by one bit */

I'd make it unsigned.

>  	struct mutex	lock;
>  };
>  
> +static void clear_cma_bitmap(struct cma *cma, unsigned long pfn, int
> count)

For consistency cma_clear_bitmap would make more sense I think.  On the
other hand, you're just moving stuff around so perhaps renaming the
function at this point is not worth it any more.

> +{
> +	unsigned long bitmapno, nr_bits;
> +
> +	bitmapno = (pfn - cma->base_pfn) >> cma->order_per_bit;
> +	nr_bits = cma_bitmap_pages_to_bits(cma, count);
> +
> +	mutex_lock(&cma->lock);
> +	bitmap_clear(cma->bitmap, bitmapno, nr_bits);
> +	mutex_unlock(&cma->lock);
> +}
> +
>  static int __init cma_activate_area(struct cma *cma)
>  {
> -	int bitmap_size = BITS_TO_LONGS(cma->count) * sizeof(long);
> +	int bitmap_maxno = cma_bitmap_maxno(cma);
> +	int bitmap_size = BITS_TO_LONGS(bitmap_maxno) * sizeof(long);
>  	unsigned long base_pfn = cma->base_pfn, pfn = base_pfn;
>  	unsigned i = cma->count >> pageblock_order;
>  	struct zone *zone;

bitmap_maxno is never used again, perhaps:

+	int bitmap_size = BITS_TO_LONGS(cma_bitmap_maxno(cma)) * sizeof(long);

instead? Up to you.

-- 
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=./ `o
..o | Computer Science,  Micha? ?mina86? Nazarewicz    (o o)
ooo +--<mpn@google.com>--<xmpp:mina86@jabber.org>--ooO--(_)--Ooo--
