From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 16 Jul 2015 15:23:13 +0100
Subject: [PATCH v2 02/20] xen: Introduce a function to split a Linux page
 into Xen page
In-Reply-To: <1436474552-31789-3-git-send-email-julien.grall@citrix.com>
References: <1436474552-31789-1-git-send-email-julien.grall@citrix.com>
 <1436474552-31789-3-git-send-email-julien.grall@citrix.com>
Message-ID: <alpine.DEB.2.02.1507161520330.17378@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 9 Jul 2015, Julien Grall wrote:
> The Xen interface is always using 4KB page. This means that a Linux page
> may be split across multiple Xen page when the page granularity is not
> the same.
> 
> This helper will break down a Linux page into 4KB chunk and call the
> helper on each of them.
> 
> Signed-off-by: Julien Grall <julien.grall@citrix.com>
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: David Vrabel <david.vrabel@citrix.com>
> ---
>     Changes in v2:
>         - Patch added
> ---
>  include/xen/page.h | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/include/xen/page.h b/include/xen/page.h
> index 8ebd37b..b1f7722 100644
> --- a/include/xen/page.h
> +++ b/include/xen/page.h
> @@ -39,4 +39,24 @@ struct xen_memory_region xen_extra_mem[XEN_EXTRA_MEM_MAX_REGIONS];
>  
>  extern unsigned long xen_released_pages;
>  
> +typedef int (*xen_pfn_fn_t)(struct page *page, unsigned long pfn, void *data);
> +/* Break down the page in 4KB granularity and call fn foreach xen pfn */
> +static inline int xen_apply_to_page(struct page *page, xen_pfn_fn_t fn,
> +				    void *data)
> +{
> +	unsigned long pfn = xen_page_to_pfn(page);
> +	int i;
> +	int ret;

please initialize ret to 0


> +	for (i = 0; i < XEN_PFN_PER_PAGE; i++, pfn++) {
> +		ret = fn(page, pfn, data);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return ret;
> +}
> +
> +
>  #endif	/* _XEN_PAGE_H */


Reviewed-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
