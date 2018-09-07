From: aryabinin@virtuozzo.com (Andrey Ryabinin)
Date: Fri, 7 Sep 2018 19:06:42 +0300
Subject: [PATCH v6 16/18] khwasan, mm, arm64: tag non slab memory
 allocated via pagealloc
In-Reply-To: <db103bdc2109396af0c6007f1669ebbbb63b872b.1535462971.git.andreyknvl@google.com>
References: <cover.1535462971.git.andreyknvl@google.com>
 <db103bdc2109396af0c6007f1669ebbbb63b872b.1535462971.git.andreyknvl@google.com>
Message-ID: <3f2dee71-1615-4a34-d611-3ccaf407551e@virtuozzo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/29/2018 02:35 PM, Andrey Konovalov wrote:

>  void kasan_poison_slab(struct page *page)
>  {
> +	unsigned long i;
> +
> +	if (IS_ENABLED(CONFIG_SLAB))
> +		page->s_mem = reset_tag(page->s_mem);

Why reinitialize here, instead of single initialization in alloc_slabmgmt()?


> +	for (i = 0; i < (1 << compound_order(page)); i++)
> +		page_kasan_tag_reset(page + i);
>  	kasan_poison_shadow(page_address(page),
>  			PAGE_SIZE << compound_order(page),
>  			KASAN_KMALLOC_REDZONE);
