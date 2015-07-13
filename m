From: boris.ostrovsky@oracle.com (Boris Ostrovsky)
Date: Mon, 13 Jul 2015 16:13:24 -0400
Subject: [PATCH v2 19/20] xen/privcmd: Add support for Linux 64KB page
 granularity
In-Reply-To: <1436474552-31789-20-git-send-email-julien.grall@citrix.com>
References: <1436474552-31789-1-git-send-email-julien.grall@citrix.com>
 <1436474552-31789-20-git-send-email-julien.grall@citrix.com>
Message-ID: <55A41BE4.3080104@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/09/2015 04:42 PM, Julien Grall wrote:
> -
>   struct remap_data {
>   	xen_pfn_t *fgmfn; /* foreign domain's gmfn */
> +	xen_pfn_t *efgmfn; /* pointer to the end of the fgmfn array */

It might be better to keep size of fgmfn array instead.


>
> +static int unmap_gfn(struct page *page, unsigned long pfn, void *data)
> +{
> +	int *nr = data;
> +	struct xen_remove_from_physmap xrp;
> +
> +	/* The Linux Page may not have been fully mapped to Xen */
> +	if (!*nr)
> +		return 0;
> +
> +	xrp.domid = DOMID_SELF;
> +	xrp.gpfn = pfn;
> +	(void)HYPERVISOR_memory_op(XENMEM_remove_from_physmap, &xrp);
> +
> +	(*nr)--;
> +
> +	return 0;
> +}
> +
>   int xen_xlate_unmap_gfn_range(struct vm_area_struct *vma,
>   			      int nr, struct page **pages)
>   {
>   	int i;
> +	int nr_page = round_up(nr, XEN_PFN_PER_PAGE);
>   
> -	for (i = 0; i < nr; i++) {
> -		struct xen_remove_from_physmap xrp;
> -		unsigned long pfn;
> +	for (i = 0; i < nr_page; i++) {
> +		/* unmap_gfn guarantees ret == 0 */
> +		BUG_ON(xen_apply_to_page(pages[i], unmap_gfn, &nr));


TBH, I am not sure how useful xen_apply_to_page() routine is. In this 
patch especially, but also in others.

-boris
