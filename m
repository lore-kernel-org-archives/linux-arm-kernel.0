From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Fri, 17 Jul 2015 15:03:39 +0100
Subject: [PATCH v2 12/20] xen/balloon: Don't rely on the page granularity
 is the same for Xen and Linux
In-Reply-To: <1436474552-31789-13-git-send-email-julien.grall@citrix.com>
References: <1436474552-31789-1-git-send-email-julien.grall@citrix.com>
 <1436474552-31789-13-git-send-email-julien.grall@citrix.com>
Message-ID: <alpine.DEB.2.02.1507161819200.17378@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 9 Jul 2015, Julien Grall wrote:
> For ARM64 guests, Linux is able to support either 64K or 4K page
> granularity. Although, the hypercall interface is always based on 4K
> page granularity.
> 
> With 64K page granuliarty, a single page will be spread over multiple
> Xen frame.
> 
> When a driver request/free a balloon page, the balloon driver will have
> to split the Linux page in 4K chunk before asking Xen to add/remove the
> frame from the guest.
> 
> Note that this can work on any page granularity assuming it's a multiple
> of 4K.
> 
> Signed-off-by: Julien Grall <julien.grall@citrix.com>
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: David Vrabel <david.vrabel@citrix.com>
> Cc: Wei Liu <wei.liu2@citrix.com>
> ---
>     Changes in v2:
>         - Use xen_apply_to_page to split a page in 4K chunk
>         - It's not necessary to have a smaller frame list. Re-use
>         PAGE_SIZE
>         - Convert reserve_additional_memory to use XEN_... macro
> ---
>  drivers/xen/balloon.c | 147 +++++++++++++++++++++++++++++++++++---------------
>  1 file changed, 105 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/xen/balloon.c b/drivers/xen/balloon.c
> index fd93369..19a72b1 100644
> --- a/drivers/xen/balloon.c
> +++ b/drivers/xen/balloon.c
> @@ -230,6 +230,7 @@ static enum bp_state reserve_additional_memory(long credit)
>  	nid = memory_add_physaddr_to_nid(hotplug_start_paddr);
>  
>  #ifdef CONFIG_XEN_HAVE_PVMMU
> +	/* TODO */

I think you need to be more verbose than that: TODO what?


>          /*
>           * add_memory() will build page tables for the new memory so
>           * the p2m must contain invalid entries so the correct
> @@ -242,8 +243,8 @@ static enum bp_state reserve_additional_memory(long credit)
>  	if (!xen_feature(XENFEAT_auto_translated_physmap)) {
>  		unsigned long pfn, i;
>  
> -		pfn = PFN_DOWN(hotplug_start_paddr);
> -		for (i = 0; i < balloon_hotplug; i++) {
> +		pfn = XEN_PFN_DOWN(hotplug_start_paddr);
> +		for (i = 0; i < (balloon_hotplug * XEN_PFN_PER_PAGE); i++) {
>  			if (!set_phys_to_machine(pfn + i, INVALID_P2M_ENTRY)) {
>  				pr_warn("set_phys_to_machine() failed, no memory added\n");
>  				return BP_ECANCELED;
> @@ -323,10 +324,72 @@ static enum bp_state reserve_additional_memory(long credit)
>  }
>  #endif /* CONFIG_XEN_BALLOON_MEMORY_HOTPLUG */
>  
> +static int set_frame(struct page *page, unsigned long pfn, void *data)
> +{
> +	unsigned long *index = data;
> +
> +	frame_list[(*index)++] = pfn;
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_XEN_HAVE_PVMMU
> +static int pvmmu_update_mapping(struct page *page, unsigned long pfn,
> +				void *data)
> +{
> +	unsigned long *index = data;
> +	xen_pfn_t frame = frame_list[*index];
> +
> +	set_phys_to_machine(pfn, frame);
> +	/* Link back into the page tables if not highmem. */
> +	if (!PageHighMem(page)) {
> +		int ret;
> +		ret = HYPERVISOR_update_va_mapping(
> +				(unsigned long)__va(pfn << XEN_PAGE_SHIFT),
> +				mfn_pte(frame, PAGE_KERNEL),
> +				0);
> +		BUG_ON(ret);
> +	}
> +
> +	(*index)++;
> +
> +	return 0;
> +}
> +#endif
> +
> +static int balloon_remove_mapping(struct page *page, unsigned long pfn,
> +				  void *data)
> +{
> +	unsigned long *index = data;
> +
> +	/* We expect the frame_list to contain the same pfn */
> +	BUG_ON(pfn != frame_list[*index]);
> +
> +	frame_list[*index] = pfn_to_mfn(pfn);
> +
> +#ifdef CONFIG_XEN_HAVE_PVMMU
> +	if (!xen_feature(XENFEAT_auto_translated_physmap)) {
> +		if (!PageHighMem(page)) {
> +			int ret;
> +
> +			ret = HYPERVISOR_update_va_mapping(
> +					(unsigned long)__va(pfn << XEN_PAGE_SHIFT),
> +					__pte_ma(0), 0);
> +			BUG_ON(ret);
> +		}
> +		__set_phys_to_machine(pfn, INVALID_P2M_ENTRY);
> +	}
> +#endif
> +
> +	(*index)++;
> +
> +	return 0;
> +}
> +
>  static enum bp_state increase_reservation(unsigned long nr_pages)
>  {
>  	int rc;
> -	unsigned long  pfn, i;
> +	unsigned long i, frame_idx;
>  	struct page   *page;
>  	struct xen_memory_reservation reservation = {
>  		.address_bits = 0,
> @@ -343,44 +406,43 @@ static enum bp_state increase_reservation(unsigned long nr_pages)
>  	}
>  #endif
>  
> -	if (nr_pages > ARRAY_SIZE(frame_list))
> -		nr_pages = ARRAY_SIZE(frame_list);
> +	if (nr_pages > (ARRAY_SIZE(frame_list) / XEN_PFN_PER_PAGE))
> +		nr_pages = ARRAY_SIZE(frame_list) / XEN_PFN_PER_PAGE;
>  
> +	frame_idx = 0;
>  	page = list_first_entry_or_null(&ballooned_pages, struct page, lru);
>  	for (i = 0; i < nr_pages; i++) {
>  		if (!page) {
>  			nr_pages = i;
>  			break;
>  		}
> -		frame_list[i] = page_to_pfn(page);
> +
> +		rc = xen_apply_to_page(page, set_frame, &frame_idx);
> +
>  		page = balloon_next_page(page);
>  	}
>  
>  	set_xen_guest_handle(reservation.extent_start, frame_list);
> -	reservation.nr_extents = nr_pages;
> +	reservation.nr_extents = nr_pages * XEN_PFN_PER_PAGE;
>  	rc = HYPERVISOR_memory_op(XENMEM_populate_physmap, &reservation);
>  	if (rc <= 0)
>  		return BP_EAGAIN;
>  
> -	for (i = 0; i < rc; i++) {
> +	/* rc is equal to the number of Xen page populated */
> +	nr_pages = rc / XEN_PFN_PER_PAGE;

Here we are purposedly ignoring any spares (rc % XEN_PFN_PER_PAGE).
Instead of leaking them, maybe we should givem them back to Xen since we
cannot use them?



> +	for (i = 0; i < nr_pages; i++) {
>  		page = balloon_retrieve(false);
>  		BUG_ON(page == NULL);
>  
> -		pfn = page_to_pfn(page);
> -
>  #ifdef CONFIG_XEN_HAVE_PVMMU
> +		frame_idx = 0;

Shouldn't this be before the beginning of the loop above?


>  		if (!xen_feature(XENFEAT_auto_translated_physmap)) {
> -			set_phys_to_machine(pfn, frame_list[i]);
> -
> -			/* Link back into the page tables if not highmem. */
> -			if (!PageHighMem(page)) {
> -				int ret;
> -				ret = HYPERVISOR_update_va_mapping(
> -						(unsigned long)__va(pfn << PAGE_SHIFT),
> -						mfn_pte(frame_list[i], PAGE_KERNEL),
> -						0);
> -				BUG_ON(ret);
> -			}
> +			int ret;
> +
> +			ret = xen_apply_to_page(page, pvmmu_update_mapping,
> +						&frame_idx);
> +			BUG_ON(ret);
>  		}
>  #endif
>  
> @@ -388,7 +450,7 @@ static enum bp_state increase_reservation(unsigned long nr_pages)
>  		__free_reserved_page(page);
>  	}
>  
> -	balloon_stats.current_pages += rc;
> +	balloon_stats.current_pages += nr_pages;
>
>  	return BP_DONE;
>  }
> @@ -396,7 +458,7 @@ static enum bp_state increase_reservation(unsigned long nr_pages)
>  static enum bp_state decrease_reservation(unsigned long nr_pages, gfp_t gfp)
>  {
>  	enum bp_state state = BP_DONE;
> -	unsigned long  pfn, i;
> +	unsigned long  pfn, i, frame_idx, nr_frames;
>  	struct page   *page;
>  	int ret;
>  	struct xen_memory_reservation reservation = {
> @@ -414,9 +476,10 @@ static enum bp_state decrease_reservation(unsigned long nr_pages, gfp_t gfp)
>  	}
>  #endif
>  
> -	if (nr_pages > ARRAY_SIZE(frame_list))
> -		nr_pages = ARRAY_SIZE(frame_list);
> +	if (nr_pages > (ARRAY_SIZE(frame_list) / XEN_PFN_PER_PAGE))
> +		nr_pages = ARRAY_SIZE(frame_list) / XEN_PFN_PER_PAGE;
>  
> +	frame_idx = 0;
>  	for (i = 0; i < nr_pages; i++) {
>  		page = alloc_page(gfp);
>  		if (page == NULL) {
> @@ -426,9 +489,12 @@ static enum bp_state decrease_reservation(unsigned long nr_pages, gfp_t gfp)
>  		}
>  		scrub_page(page);
>  
> -		frame_list[i] = page_to_pfn(page);
> +		ret = xen_apply_to_page(page, set_frame, &frame_idx);
> +		BUG_ON(ret);
>  	}
>  
> +	nr_frames = nr_pages * XEN_PFN_PER_PAGE;
> +
>  	/*
>  	 * Ensure that ballooned highmem pages don't have kmaps.
>  	 *
> @@ -439,22 +505,19 @@ static enum bp_state decrease_reservation(unsigned long nr_pages, gfp_t gfp)
>  	kmap_flush_unused();
>  
>  	/* Update direct mapping, invalidate P2M, and add to balloon. */
> +	frame_idx = 0;
>  	for (i = 0; i < nr_pages; i++) {
> -		pfn = frame_list[i];
> -		frame_list[i] = pfn_to_mfn(pfn);
> -		page = pfn_to_page(pfn);
> +		/*
> +		 * The Xen PFN for a given Linux Page are contiguous in
> +		 * frame_list
> +		 */
> +		pfn = frame_list[frame_idx];
> +		page = xen_pfn_to_page(pfn);
>  
> -#ifdef CONFIG_XEN_HAVE_PVMMU
> -		if (!xen_feature(XENFEAT_auto_translated_physmap)) {
> -			if (!PageHighMem(page)) {
> -				ret = HYPERVISOR_update_va_mapping(
> -						(unsigned long)__va(pfn << PAGE_SHIFT),
> -						__pte_ma(0), 0);
> -				BUG_ON(ret);
> -			}
> -			__set_phys_to_machine(pfn, INVALID_P2M_ENTRY);
> -		}
> -#endif
> +
> +		ret = xen_apply_to_page(page, balloon_remove_mapping,
> +					&frame_idx);
> +		BUG_ON(ret);
>  
>  		balloon_append(page);
>  	}
> @@ -462,9 +525,9 @@ static enum bp_state decrease_reservation(unsigned long nr_pages, gfp_t gfp)
>  	flush_tlb_all();
>  
>  	set_xen_guest_handle(reservation.extent_start, frame_list);
> -	reservation.nr_extents   = nr_pages;
> +	reservation.nr_extents   = nr_frames;
>  	ret = HYPERVISOR_memory_op(XENMEM_decrease_reservation, &reservation);
> -	BUG_ON(ret != nr_pages);
> +	BUG_ON(ret != nr_frames);
>  
>  	balloon_stats.current_pages -= nr_pages;
>  
> -- 
> 2.1.4
> 
