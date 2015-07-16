From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 16 Jul 2015 16:01:11 +0100
Subject: [PATCH v2 03/20] xen/grant: Introduce helpers to split a page
 into grant
In-Reply-To: <1436474552-31789-4-git-send-email-julien.grall@citrix.com>
References: <1436474552-31789-1-git-send-email-julien.grall@citrix.com>
 <1436474552-31789-4-git-send-email-julien.grall@citrix.com>
Message-ID: <alpine.DEB.2.02.1507161526030.17378@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 9 Jul 2015, Julien Grall wrote:
> Currently, a grant is always based on the Xen page granularity (i.e
> 4KB). When Linux is using a different page granularity, a single page
> will be split between multiple grants.
> 
> The new helpers will be in charge to split the Linux page into grant and
                                                                  ^
                                                                  grants

> call a function given by the caller on each grant.
> 
> In order to help some PV drivers, the callback is allowed to use less
> data and must update the resulting length. This is useful for netback.
> 
> Also provide and helper to count the number of grants within a given
> contiguous region.
> 
> Signed-off-by: Julien Grall <julien.grall@citrix.com>
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: David Vrabel <david.vrabel@citrix.com>
> ---
>     Changes in v2:
>         - Patch added
> ---
>  drivers/xen/grant-table.c | 26 ++++++++++++++++++++++++++
>  include/xen/grant_table.h | 41 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 67 insertions(+)
> 
> diff --git a/drivers/xen/grant-table.c b/drivers/xen/grant-table.c
> index 62f591f..3679293 100644
> --- a/drivers/xen/grant-table.c
> +++ b/drivers/xen/grant-table.c
> @@ -296,6 +296,32 @@ int gnttab_end_foreign_access_ref(grant_ref_t ref, int readonly)
>  }
>  EXPORT_SYMBOL_GPL(gnttab_end_foreign_access_ref);
>  
> +void gnttab_foreach_grant(struct page *page, unsigned int offset,
> +			  unsigned int len, xen_grant_fn_t fn,
> +			  void *data)
> +{
> +	unsigned int goffset;
> +	unsigned int glen;
> +	unsigned long pfn;

I would s/pfn/xen_pfn/ inside this function for clarity


> +	len = min_t(unsigned int, PAGE_SIZE - offset, len);
> +	goffset = offset & ~XEN_PAGE_MASK;

I don't think we want to support cases where (offset & ~XEN_PAGE_MASK)
!= 0, we should just return error.


> +	pfn = xen_page_to_pfn(page) + (offset >> XEN_PAGE_SHIFT);
> +
> +	while (len) {
> +		glen = min_t(unsigned int, XEN_PAGE_SIZE - goffset, len);

Similarly I don't think we want to support glen != XEN_PAGE_SIZE here


> +		fn(pfn_to_mfn(pfn), goffset, &glen, data);

Allowing the callee to change glen makes the interface more complex and
certainly doesn't match the gnttab_foreach_grant function name anymore.

If netback needs it, could it just do the work inside its own function?
I would rather keep gnttab_foreach_grant simple and move the complexity
there.


> +		goffset += glen;
> +		if (goffset == XEN_PAGE_SIZE) {
> +			goffset = 0;
> +			pfn++;
> +		}

With the assumptions above you can simplify this


> +		len -= glen;
> +	}
> +}
> +
>  struct deferred_entry {
>  	struct list_head list;
>  	grant_ref_t ref;
> diff --git a/include/xen/grant_table.h b/include/xen/grant_table.h
> index 4478f4b..6f77378 100644
> --- a/include/xen/grant_table.h
> +++ b/include/xen/grant_table.h
> @@ -45,8 +45,10 @@
>  #include <asm/xen/hypervisor.h>
>  
>  #include <xen/features.h>
> +#include <xen/page.h>
>  #include <linux/mm_types.h>
>  #include <linux/page-flags.h>
> +#include <linux/kernel.h>
>  
>  #define GNTTAB_RESERVED_XENSTORE 1
>  
> @@ -224,4 +226,43 @@ static inline struct xen_page_foreign *xen_page_foreign(struct page *page)
>  #endif
>  }
>  
> +/* Split Linux page in chunk of the size of the grant and call fn
> + *
> + * Parameters of fn:
> + *	mfn: machine frame number based on grant granularity
> + *	offset: offset in the grant
> + *	len: length of the data in the grant. If fn decides to use less data,
> + *	it must update len.
> + *	data: internal information
> + */
> +typedef void (*xen_grant_fn_t)(unsigned long mfn, unsigned int offset,
> +			       unsigned int *len, void *data);
> +
> +void gnttab_foreach_grant(struct page *page, unsigned int offset,
> +			  unsigned int len, xen_grant_fn_t fn,
> +			  void *data);
> +
> +/* Helper to get to call fn only on the first "grant chunk" */
> +static inline void gnttab_one_grant(struct page *page, unsigned int offset,
> +				    unsigned len, xen_grant_fn_t fn,
> +				    void *data)
> +{
> +	/* The first request is limited to the size of one grant */
> +	len = min_t(unsigned int, XEN_PAGE_SIZE - (offset & ~XEN_PAGE_MASK),
> +		    len);

I would just BUG_ON(offset & ~XEN_PAGE_MASK) and simply len = XEN_PAGE_SIZE;


> +	gnttab_foreach_grant(page, offset, len, fn, data);
> +}
> +
> +/* Get the number of grant in a specified region
> + *
> + * offset: Offset in the first page

I would generalize this function and support offset > PAGE_SIZE. At that
point you could rename offset to "start".


> + * len: total lenght of data (can cross multiple page)
> + */
> +static inline unsigned int gnttab_count_grant(unsigned int offset,
> +					      unsigned int len)
> +{
> +	return (XEN_PFN_UP((offset & ~XEN_PAGE_MASK) + len));
> +}
> +
>  #endif /* __ASM_GNTTAB_H__ */
