From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Mon, 10 Aug 2015 12:18:15 +0100
Subject: [PATCH v3 12/20] xen/balloon: Don't rely on the page granularity
 is the same for Xen and Linux
In-Reply-To: <1438966019-19322-13-git-send-email-julien.grall@citrix.com>
References: <1438966019-19322-1-git-send-email-julien.grall@citrix.com>
 <1438966019-19322-13-git-send-email-julien.grall@citrix.com>
Message-ID: <alpine.DEB.2.02.1508101207071.11337@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 7 Aug 2015, Julien Grall wrote:
> For ARM64 guests, Linux is able to support either 64K or 4K page
> granularity. Although, the hypercall interface is always based on 4K
> page granularity.
> 
> With 64K page granularity, a single page will be spread over multiple
> Xen frame.
> 
> To avoid splitting the page into 4K frame, take advantage of the
> extent_order field to directly allocate/free chunk of the Linux page
> size.
> 
> Note that PVMMU is only used for PV guest (which is x86) and the page
> granularity is always 4KB. Some BUILD_BUG_ON has been added to ensure
> that because the code has not been modified.
> 
> Signed-off-by: Julien Grall <julien.grall@citrix.com>

This is much better than the previous version. Good idea using the
extent_order field.

I only have a minor comment below.


> ---
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: David Vrabel <david.vrabel@citrix.com>
> Cc: Wei Liu <wei.liu2@citrix.com>
> 
>     Changes in v3:
>         - Fix errors reported by checkpatch.pl
>         - s/mfn/gfn/ based on the new naming
>         - Rather than splitting the page into 4KB chunk, use the
>         extent_order field to allocate directly a Linux page size. This
>         is avoid lots of code for no benefits.
> 
>     Changes in v2:
>         - Use xen_apply_to_page to split a page in 4K chunk
>         - It's not necessary to have a smaller frame list. Re-use
>         PAGE_SIZE
>         - Convert reserve_additional_memory to use XEN_... macro
> ---
>  drivers/xen/balloon.c | 47 ++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 36 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/xen/balloon.c b/drivers/xen/balloon.c
> index 9734649..c8739c8 100644
> --- a/drivers/xen/balloon.c
> +++ b/drivers/xen/balloon.c
> @@ -70,6 +70,9 @@
>  #include <xen/features.h>
>  #include <xen/page.h>
>  
> +/* Use one extent per PAGE_SIZE to avoid break down into multiple frame */
> +#define EXTENT_ORDER (fls(XEN_PFN_PER_PAGE) - 1)
> +
>  /*
>   * balloon_process() state:
>   *
> @@ -230,6 +233,11 @@ static enum bp_state reserve_additional_memory(long credit)
>  	nid = memory_add_physaddr_to_nid(hotplug_start_paddr);
>  
>  #ifdef CONFIG_XEN_HAVE_PVMMU
> +	/* We don't support PV MMU when Linux and Xen is using
> +	 * different page granularity.
> +	 */
> +	BUILD_BUG_ON(XEN_PAGE_SIZE != PAGE_SIZE);
> +
>          /*
>           * add_memory() will build page tables for the new memory so
>           * the p2m must contain invalid entries so the correct
> @@ -326,11 +334,11 @@ static enum bp_state reserve_additional_memory(long credit)
>  static enum bp_state increase_reservation(unsigned long nr_pages)
>  {
>  	int rc;
> -	unsigned long  pfn, i;
> +	unsigned long i;
>  	struct page   *page;
>  	struct xen_memory_reservation reservation = {
>  		.address_bits = 0,
> -		.extent_order = 0,
> +		.extent_order = EXTENT_ORDER,
>  		.domid        = DOMID_SELF
>  	};
>  
> @@ -352,7 +360,11 @@ static enum bp_state increase_reservation(unsigned long nr_pages)
>  			nr_pages = i;
>  			break;
>  		}
> -		frame_list[i] = page_to_pfn(page);
> +
> +		/* XENMEM_populate_physmap requires a PFN based on Xen
> +		 * granularity.
> +		 */
> +		frame_list[i] = xen_page_to_pfn(page);
>  		page = balloon_next_page(page);
>  	}
>  
> @@ -366,10 +378,15 @@ static enum bp_state increase_reservation(unsigned long nr_pages)
>  		page = balloon_retrieve(false);
>  		BUG_ON(page == NULL);
>  
> -		pfn = page_to_pfn(page);
> -
>  #ifdef CONFIG_XEN_HAVE_PVMMU
> +		/* We don't support PV MMU when Linux and Xen is using
> +		 * different page granularity.
> +		 */
> +		BUILD_BUG_ON(XEN_PAGE_SIZE != PAGE_SIZE);
> +
>  		if (!xen_feature(XENFEAT_auto_translated_physmap)) {
> +			unsigned long pfn = page_to_pfn(page);
> +
>  			set_phys_to_machine(pfn, frame_list[i]);
>  
>  			/* Link back into the page tables if not highmem. */
> @@ -396,14 +413,15 @@ static enum bp_state increase_reservation(unsigned long nr_pages)
>  static enum bp_state decrease_reservation(unsigned long nr_pages, gfp_t gfp)
>  {
>  	enum bp_state state = BP_DONE;
> -	unsigned long  pfn, i;
> +	unsigned long i;
>  	struct page   *page;
>  	int ret;
>  	struct xen_memory_reservation reservation = {
>  		.address_bits = 0,
> -		.extent_order = 0,
> +		.extent_order = EXTENT_ORDER,
>  		.domid        = DOMID_SELF
>  	};
> +	static struct page *pages[ARRAY_SIZE(frame_list)];

This array can be rather large: I would try to avoid it, see below.


>  #ifdef CONFIG_XEN_BALLOON_MEMORY_HOTPLUG
>  	if (balloon_stats.hotplug_pages) {
> @@ -426,7 +444,9 @@ static enum bp_state decrease_reservation(unsigned long nr_pages, gfp_t gfp)
>  		}
>  		scrub_page(page);
>  
> -		frame_list[i] = page_to_pfn(page);
> +		/* XENMEM_decrease_reservation requires a GFN */
> +		frame_list[i] = xen_page_to_gfn(page);
> +		pages[i] = page;
>  	}
>  
>  	/*
> @@ -440,12 +460,17 @@ static enum bp_state decrease_reservation(unsigned long nr_pages, gfp_t gfp)
>  
>  	/* Update direct mapping, invalidate P2M, and add to balloon. */
>  	for (i = 0; i < nr_pages; i++) {
> -		pfn = frame_list[i];
> -		frame_list[i] = pfn_to_gfn(pfn);
> -		page = pfn_to_page(pfn);
> +		page = pages[i];
>  
>  #ifdef CONFIG_XEN_HAVE_PVMMU
> +		/* We don't support PV MMU when Linux and Xen is using
> +		 * different page granularity.
> +		 */
> +		BUILD_BUG_ON(XEN_PAGE_SIZE != PAGE_SIZE);
> +
>  		if (!xen_feature(XENFEAT_auto_translated_physmap)) {
> +			unsigned long pfn = page_to_pfn(page);

I would simply and avoid introducing a new array:
    pfn = (frame_list[i] << XEN_PAGE_SHIFT) >> PAGE_SHIFT;
    page = pfn_to_page(pfn);
    
    
    
>  			if (!PageHighMem(page)) {
>  				ret = HYPERVISOR_update_va_mapping(
>  						(unsigned long)__va(pfn << PAGE_SHIFT),
> -- 
> 2.1.4
> 
