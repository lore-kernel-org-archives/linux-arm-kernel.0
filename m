From: david.vrabel@citrix.com (David Vrabel)
Date: Fri, 24 Jul 2015 10:35:44 +0100
Subject: [Xen-devel] [PATCH v2 04/20] xen/grant: Add helper
 gnttab_page_grant_foreign_access_ref
In-Reply-To: <1436474552-31789-5-git-send-email-julien.grall@citrix.com>
References: <1436474552-31789-1-git-send-email-julien.grall@citrix.com>
 <1436474552-31789-5-git-send-email-julien.grall@citrix.com>
Message-ID: <55B206F0.3060108@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/07/15 21:42, Julien Grall wrote:
> Many PV drivers contain the idiom:
> 
> pfn = page_to_mfn(...) /* Or similar */
> gnttab_grant_foreign_access_ref
> 
> Replace it by a new helper. Note that when Linux is using a different
> page granularity than Xen, the helper only gives access to the first 4KB
> grant.
> 
> This is useful where drivers are allocating a full Linux page for each
> grant.
> 
> Also include xen/interface/grant_table.h rather than xen/grant_table.h in
> asm/page.h for x86 to fix a compilation issue [1]. Only the former is
> useful in order to get the structure definition.
> 
> [1] Interpendency between asm/page.h and xen/grant_table.h which result
> to page_mfn not being defined when necessary.
[...]
> --- a/include/xen/grant_table.h
> +++ b/include/xen/grant_table.h
> @@ -131,6 +131,15 @@ void gnttab_cancel_free_callback(struct gnttab_free_callback *callback);
>  void gnttab_grant_foreign_access_ref(grant_ref_t ref, domid_t domid,
>  				     unsigned long frame, int readonly);
>  
> +/* Give access to the first 4K of the page */
> +static inline void gnttab_page_grant_foreign_access_ref(
> +	grant_ref_t ref, domid_t domid,
> +	struct page *page, int readonly)
> +{
> +	gnttab_grant_foreign_access_ref(ref, domid, page_to_mfn(page),

Obviously this would use the new xen_page_to_gfn() macro here.

Otherwise,

Reviewed-by: David Vrabel <david.vrabel@citrix.com>

David
