From: mina86@mina86.com (Michal Nazarewicz)
Date: Thu, 23 Oct 2014 18:55:20 +0200
Subject: [PATCH 2/4] mm: cma: Always consider a 0 base address reservation
 as dynamic
In-Reply-To: <1414074828-4488-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1414074828-4488-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1414074828-4488-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <xa1tk33qlo93.fsf@mina86.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 23 2014, Laurent Pinchart wrote:
> The fixed parameter to cma_declare_contiguous() tells the function
> whether the given base address must be honoured or should be considered
> as a hint only. The API considers a zero base address as meaning any
> base address, which must never be considered as a fixed value.
>
> Part of the implementation correctly checks both fixed and base != 0,
> but two locations check the fixed value only. Set fixed to false when
> base is 0 to fix that and simplify the code.
>
> Signed-off-by: Laurent Pinchart
> <laurent.pinchart+renesas@ideasonboard.com>

Acked-by: Michal Nazarewicz <mina86@mina86.com>

And like before, this should also probably also go to stable.

> ---
>  mm/cma.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/mm/cma.c b/mm/cma.c
> index 16c6650..6b14346 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -239,6 +239,9 @@ int __init cma_declare_contiguous(phys_addr_t base,
>  	size = ALIGN(size, alignment);
>  	limit &= ~(alignment - 1);
>  
> +	if (!base)
> +		fixed = false;
> +
>  	/* size should be aligned with order_per_bit */
>  	if (!IS_ALIGNED(size >> PAGE_SHIFT, 1 << order_per_bit))
>  		return -EINVAL;
> @@ -262,7 +265,7 @@ int __init cma_declare_contiguous(phys_addr_t base,
>  	}
>  
>  	/* Reserve memory */
> -	if (base && fixed) {
> +	if (fixed) {
>  		if (memblock_is_region_reserved(base, size) ||
>  		    memblock_reserve(base, size) < 0) {
>  			ret = -EBUSY;
> -- 
> 2.0.4
>

-- 
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=./ `o
..o | Computer Science,  Micha? ?mina86? Nazarewicz    (o o)
ooo +--<mpn@google.com>--<xmpp:mina86@jabber.org>--ooO--(_)--Ooo--
