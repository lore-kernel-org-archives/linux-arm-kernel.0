From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 7 Nov 2016 11:35:27 +0000
Subject: [PATCH] ARM: avoid cache flushing in flush_dcache_page()
In-Reply-To: <1478514624-30910-1-git-send-email-rabin.vincent@axis.com>
References: <1478514624-30910-1-git-send-email-rabin.vincent@axis.com>
Message-ID: <20161107113525.GA28876@MBP.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 07, 2016 at 11:30:24AM +0100, Rabin Vincent wrote:
> diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
> index 3cced84..f1e6190 100644
> --- a/arch/arm/mm/flush.c
> +++ b/arch/arm/mm/flush.c
> @@ -327,6 +327,12 @@ void flush_dcache_page(struct page *page)
>  	if (page == ZERO_PAGE(0))
>  		return;
>  
> +	if (!cache_ops_need_broadcast() && cache_is_vipt_nonaliasing()) {
> +		if (test_bit(PG_dcache_clean, &page->flags))
> +			clear_bit(PG_dcache_clean, &page->flags);
> +		return;
> +	}
> +
>  	mapping = page_mapping(page);
>  
>  	if (!cache_ops_need_broadcast() &&

I'm ok with the logic in this patch but is there a way to combine the
two 'if' blocks together, just to keep the function shorter?

-- 
Catalin
