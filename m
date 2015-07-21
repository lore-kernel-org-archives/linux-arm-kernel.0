From: roger.pau@citrix.com (=?UTF-8?B?Um9nZXIgUGF1IE1vbm7DqQ==?=)
Date: Tue, 21 Jul 2015 12:30:02 +0200
Subject: [PATCH v2 07/20] block/xen-blkfront: split get_grant in 2
In-Reply-To: <1436474552-31789-8-git-send-email-julien.grall@citrix.com>
References: <1436474552-31789-1-git-send-email-julien.grall@citrix.com>
 <1436474552-31789-8-git-send-email-julien.grall@citrix.com>
Message-ID: <55AE1F2A.6010300@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

El 09/07/15 a les 22.42, Julien Grall ha escrit:
> Prepare the code to support 64KB page granularity. The first
> implementation will use a full Linux page per indirect and persistent
> grant. When non-persistent grant is used, each page of a bio request
> may be split in multiple grant.
> 
> Furthermore, the field page of the grant structure is only used to copy
> data from persistent grant or indirect grant. Avoid to set it for other
> use case as it will have no meaning given the page will be split in
> multiple grant.
> 
> Provide 2 functions, to setup indirect grant, the other for bio page.
> 
> Signed-off-by: Julien Grall <julien.grall@citrix.com>
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Cc: Roger Pau Monn? <roger.pau@citrix.com>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: David Vrabel <david.vrabel@citrix.com>
> ---
>     Changes in v2:
>         - Patch added
> ---
>  drivers/block/xen-blkfront.c | 85 ++++++++++++++++++++++++++++++--------------
>  1 file changed, 59 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
> index 7b81d23..95fd067 100644
> --- a/drivers/block/xen-blkfront.c
> +++ b/drivers/block/xen-blkfront.c
> @@ -242,34 +242,77 @@ out_of_memory:
>  	return -ENOMEM;
>  }
>  
> -static struct grant *get_grant(grant_ref_t *gref_head,
> -			       struct page *page,
> -                               struct blkfront_info *info)
> +static struct grant *get_free_grant(struct blkfront_info *info)
>  {
>  	struct grant *gnt_list_entry;
> -	unsigned long buffer_mfn;
>  
>  	BUG_ON(list_empty(&info->grants));
>  	gnt_list_entry = list_first_entry(&info->grants, struct grant,
> -	                                  node);
> +					  node);

Stray change?

>  	list_del(&gnt_list_entry->node);
>  
> -	if (gnt_list_entry->gref != GRANT_INVALID_REF) {
> +	if (gnt_list_entry->gref != GRANT_INVALID_REF)
>  		info->persistent_gnts_c--;
> +
> +	return gnt_list_entry;
> +}
> +
> +static void grant_foreign_access(const struct grant *gnt_list_entry,
> +				 const struct blkfront_info *info)

Given that this is just a wrapper I would make it an inline function, or
even consider removing it and just call
gnttab_page_grant_foreign_access_ref directly.

> +{
> +	gnttab_page_grant_foreign_access_ref(gnt_list_entry->gref,
> +					     info->xbdev->otherend_id,
> +					     gnt_list_entry->page,
> +					     0);
> +}
> +
> +static struct grant *get_grant(grant_ref_t *gref_head,
> +			       unsigned long mfn,
> +			       struct blkfront_info *info)

Indentation.

> +{
> +	struct grant *gnt_list_entry = get_free_grant(info);
> +
> +	if (gnt_list_entry->gref != GRANT_INVALID_REF)
>  		return gnt_list_entry;
> +
> +	/* Assign a gref to this page */
> +	gnt_list_entry->gref = gnttab_claim_grant_reference(gref_head);
> +	BUG_ON(gnt_list_entry->gref == -ENOSPC);
> +	if (info->feature_persistent)
> +		grant_foreign_access(gnt_list_entry, info);
> +	else {
> +		/* Grant access to the MFN passed by the caller */
> +		gnttab_grant_foreign_access_ref(gnt_list_entry->gref,
> +			                        info->xbdev->otherend_id,
> +				                mfn, 0);
>  	}
>  
> +	return gnt_list_entry;
> +}
> +
> +static struct grant *get_indirect_grant(grant_ref_t *gref_head,
> +					struct blkfront_info *info)

Indentation.

Roger.
