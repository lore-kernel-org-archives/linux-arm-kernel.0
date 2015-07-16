From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 16 Jul 2015 16:05:12 +0100
Subject: [PATCH v2 04/20] xen/grant: Add helper
 gnttab_page_grant_foreign_access_ref
In-Reply-To: <1436474552-31789-5-git-send-email-julien.grall@citrix.com>
References: <1436474552-31789-1-git-send-email-julien.grall@citrix.com>
 <1436474552-31789-5-git-send-email-julien.grall@citrix.com>
Message-ID: <alpine.DEB.2.02.1507161603490.17378@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 9 Jul 2015, Julien Grall wrote:
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
> 
> Signed-off-by: Julien Grall <julien.grall@linaro.org>
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: David Vrabel <david.vrabel@citrix.com>
> ---
>     Changes in v2:
>         - Patch added
> ---
>  arch/x86/include/asm/xen/page.h | 2 +-
>  include/xen/grant_table.h       | 9 +++++++++
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/xen/page.h b/arch/x86/include/asm/xen/page.h
> index c44a5d5..fb2e037 100644
> --- a/arch/x86/include/asm/xen/page.h
> +++ b/arch/x86/include/asm/xen/page.h
> @@ -12,7 +12,7 @@
>  #include <asm/pgtable.h>
>  
>  #include <xen/interface/xen.h>
> -#include <xen/grant_table.h>
> +#include <xen/interface/grant_table.h>
>  #include <xen/features.h>
>  
>  /* Xen machine address */
> diff --git a/include/xen/grant_table.h b/include/xen/grant_table.h
> index 6f77378..6a1ef86 100644
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

I like this. I think it might make sense to call it
gnttab_page_grant_foreign_access_ref_one to make clear that it is only
granting the first 4K.

In the future we could introduce a new function, called
gnttab_page_grant_foreign_access_ref, that grants all 4K in the page.

In any case

Reviewed-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>

> +	gnttab_grant_foreign_access_ref(ref, domid, page_to_mfn(page),
> +					readonly);
> +}
> +
>  void gnttab_grant_foreign_transfer_ref(grant_ref_t, domid_t domid,
>  				       unsigned long pfn);
>  
> -- 
> 2.1.4
> 
