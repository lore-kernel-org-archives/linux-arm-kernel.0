From: mina86@mina86.com (Michal Nazarewicz)
Date: Thu, 23 Oct 2014 18:53:36 +0200
Subject: [PATCH 1/4] mm: cma: Don't crash on allocation if CMA area can't
 be activated
In-Reply-To: <1414074828-4488-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1414074828-4488-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1414074828-4488-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <xa1tmw8mlobz.fsf@mina86.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 23 2014, Laurent Pinchart wrote:
> If activation of the CMA area fails its mutex won't be initialized,
> leading to an oops at allocation time when trying to lock the mutex. Fix
> this by failing allocation if the area hasn't been successfully actived,
> and detect that condition by moving the CMA bitmap allocation after page
> block reservation completion.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Cc: <stable@vger.kernel.org>  # v3.17
Acked-by: Michal Nazarewicz <mina86@mina86.com>

As a matter of fact, this is present in kernels earlier than 3.17 but in
the 3.17 the code has been moved from drivers/base/dma-contiguous.c to
mm/cma.c so this might require separate stable patch.  I can track this
and prepare a patch if you want.

> ---
>  mm/cma.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
>
> diff --git a/mm/cma.c b/mm/cma.c
> index 963bc4a..16c6650 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -93,11 +93,6 @@ static int __init cma_activate_area(struct cma *cma)
>  	unsigned i = cma->count >> pageblock_order;
>  	struct zone *zone;
>  
> -	cma->bitmap = kzalloc(bitmap_size, GFP_KERNEL);
> -
> -	if (!cma->bitmap)
> -		return -ENOMEM;
> -
>  	WARN_ON_ONCE(!pfn_valid(pfn));
>  	zone = page_zone(pfn_to_page(pfn));
>  
> @@ -114,17 +109,17 @@ static int __init cma_activate_area(struct cma *cma)
>  			 * to be in the same zone.
>  			 */
>  			if (page_zone(pfn_to_page(pfn)) != zone)
> -				goto err;
> +				return -EINVAL;
>  		}
>  		init_cma_reserved_pageblock(pfn_to_page(base_pfn));
>  	} while (--i);
>  
> +	cma->bitmap = kzalloc(bitmap_size, GFP_KERNEL);
> +	if (!cma->bitmap)
> +		return -ENOMEM;
> +
>  	mutex_init(&cma->lock);
>  	return 0;
> -
> -err:
> -	kfree(cma->bitmap);
> -	return -EINVAL;
>  }
>  
>  static int __init cma_init_reserved_areas(void)
> @@ -313,7 +308,7 @@ struct page *cma_alloc(struct cma *cma, int count, unsigned int align)
>  	struct page *page = NULL;
>  	int ret;
>  
> -	if (!cma || !cma->count)
> +	if (!cma || !cma->count || !cma->bitmap)
>  		return NULL;
>  
>  	pr_debug("%s(cma %p, count %d, align %d)\n", __func__, (void *)cma,
> -- 
> 2.0.4
>

-- 
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=./ `o
..o | Computer Science,  Micha? ?mina86? Nazarewicz    (o o)
ooo +--<mpn@google.com>--<xmpp:mina86@jabber.org>--ooO--(_)--Ooo--
