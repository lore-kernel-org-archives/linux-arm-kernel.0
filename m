From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 3 Dec 2015 12:09:25 +0000
Subject: [PATCH v3 09/10] PM / Hibernate: Publish pages restored in-place
 to arch code
In-Reply-To: <1448559168-8363-10-git-send-email-james.morse@arm.com>
References: <1448559168-8363-1-git-send-email-james.morse@arm.com>
 <1448559168-8363-10-git-send-email-james.morse@arm.com>
Message-ID: <20151203120925.GA2220@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 26, 2015 at 05:32:47PM +0000, James Morse wrote:

[...]

> @@ -2427,25 +2434,31 @@ static void *get_buffer(struct memory_bitmap *bm, struct chain_allocator *ca)
>  	if (PageHighMem(page))
>  		return get_highmem_page_buffer(page, ca);

I know it is not a problem for arm64, but you should export the
"restored" highmem pages list too because arch code may need to use
it for the same reasons this patch was implemented.

> -	if (swsusp_page_is_forbidden(page) && swsusp_page_is_free(page))
> -		/* We have allocated the "original" page frame and we can
> -		 * use it directly to store the loaded page.
> -		 */
> -		return page_address(page);
> -
> -	/* The "original" page frame has not been allocated and we have to
> -	 * use a "safe" page frame to store the loaded page.
> -	 */
>  	pbe = chain_alloc(ca, sizeof(struct pbe));
>  	if (!pbe) {
>  		swsusp_free();
>  		return ERR_PTR(-ENOMEM);
>  	}
> -	pbe->orig_address = page_address(page);
> -	pbe->address = safe_pages_list;
> -	safe_pages_list = safe_pages_list->next;
> -	pbe->next = restore_pblist;
> -	restore_pblist = pbe;
> +
> +	if (swsusp_page_is_forbidden(page) && swsusp_page_is_free(page)) {
> +		/* We have allocated the "original" page frame and we can
> +		 * use it directly to store the loaded page.
> +		 */
> +		pbe->orig_address = NULL;
> +		pbe->address = page_address(page);
> +		pbe->next = restored_inplace_pblist;
> +		restored_inplace_pblist = pbe;
> +	} else {
> +		/* The "original" page frame has not been allocated and we
> +		 * have to use a "safe" page frame to store the loaded page.
> +		 */
> +		pbe->orig_address = page_address(page);
> +		pbe->address = safe_pages_list;
> +		safe_pages_list = safe_pages_list->next;
> +		pbe->next = restore_pblist;
> +		restore_pblist = pbe;
> +	}

This makes sense to me, more so given that the pbe data is already
pre-allocated regardless in prepare_image() (ie it should not change
the current behaviour apart from calling chain_alloc() for every page we
are restoring), you are just adding a pointer to stash that information,
hence, if it is ok for Pavel and Rafael I think this patch can be considered
for merging.

Feedback appreciated.

Thanks,
Lorenzo

> +
>  	return pbe->address;
>  }
>  
> @@ -2513,6 +2526,7 @@ int snapshot_write_next(struct snapshot_handle *handle)
>  			chain_init(&ca, GFP_ATOMIC, PG_SAFE);
>  			memory_bm_position_reset(&orig_bm);
>  			restore_pblist = NULL;
> +			restored_inplace_pblist = NULL;
>  			handle->buffer = get_buffer(&orig_bm, &ca);
>  			handle->sync_read = 0;
>  			if (IS_ERR(handle->buffer))
> -- 
> 2.6.2
> 
