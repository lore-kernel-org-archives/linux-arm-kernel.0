From: julien.grall@citrix.com (Julien Grall)
Date: Fri, 17 Jul 2015 13:50:30 +0100
Subject: [Xen-devel] [PATCH v2 19/20] xen/privcmd: Add support for Linux
 64KB page granularity
In-Reply-To: <alpine.DEB.2.02.1507161707300.17378@kaball.uk.xensource.com>
References: <1436474552-31789-1-git-send-email-julien.grall@citrix.com>
 <1436474552-31789-20-git-send-email-julien.grall@citrix.com>
 <alpine.DEB.2.02.1507161707300.17378@kaball.uk.xensource.com>
Message-ID: <55A8FA16.3000900@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefano,

On 16/07/15 18:12, Stefano Stabellini wrote:
> On Thu, 9 Jul 2015, Julien Grall wrote:
>> The hypercall interface (as well as the toolstack) is always using 4KB
>> page granularity. When the toolstack is asking for mapping a series of
>> guest PFN in a batch, it expects to have the page map contiguously in
>> its virtual memory.
>>
>> When Linux is using 64KB page granularity, the privcmd driver will have
>> to map multiple Xen PFN in a single Linux page.
>>
>> Note that this solution works on page granularity which is a multiple of
>> 4KB.
>>
>> Signed-off-by: Julien Grall <julien.grall@citrix.com>
>> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
>> Cc: David Vrabel <david.vrabel@citrix.com>
>> ---
>> Changes in v2:
>>     - Use xen_apply_to_page
>> ---
>>  drivers/xen/privcmd.c   |   8 +--
>>  drivers/xen/xlate_mmu.c | 127 +++++++++++++++++++++++++++++++++---------------
>>  2 files changed, 92 insertions(+), 43 deletions(-)
>>
>> diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
>> index 5a29616..e8714b4 100644
>> --- a/drivers/xen/privcmd.c
>> +++ b/drivers/xen/privcmd.c
>> @@ -446,7 +446,7 @@ static long privcmd_ioctl_mmap_batch(void __user *udata, int version)
>>  		return -EINVAL;
>>  	}
>>  
>> -	nr_pages = m.num;
>> +	nr_pages = DIV_ROUND_UP_ULL(m.num, PAGE_SIZE / XEN_PAGE_SIZE);
>>  	if ((m.num <= 0) || (nr_pages > (LONG_MAX >> PAGE_SHIFT)))
>>  		return -EINVAL;
> 
> DIV_ROUND_UP is enough, neither arguments are unsigned long long

I'm not sure why I use DIV_ROUND_UP_ULL here... I will switch to
DIV_ROUND_UP in the next version.

> 
>> @@ -494,7 +494,7 @@ static long privcmd_ioctl_mmap_batch(void __user *udata, int version)
>>  			goto out_unlock;
>>  		}
>>  		if (xen_feature(XENFEAT_auto_translated_physmap)) {
>> -			ret = alloc_empty_pages(vma, m.num);
>> +			ret = alloc_empty_pages(vma, nr_pages);
>>  			if (ret < 0)
>>  				goto out_unlock;
>>  		} else
>> @@ -518,6 +518,7 @@ static long privcmd_ioctl_mmap_batch(void __user *udata, int version)
>>  	state.global_error  = 0;
>>  	state.version       = version;
>>  
>> +	BUILD_BUG_ON(((PAGE_SIZE / sizeof(xen_pfn_t)) % XEN_PFN_PER_PAGE) != 0);
>>  	/* mmap_batch_fn guarantees ret == 0 */
>>  	BUG_ON(traverse_pages_block(m.num, sizeof(xen_pfn_t),
>>  				    &pagelist, mmap_batch_fn, &state));
>> @@ -582,12 +583,13 @@ static void privcmd_close(struct vm_area_struct *vma)
>>  {
>>  	struct page **pages = vma->vm_private_data;
>>  	int numpgs = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
>> +	int nr_pfn = (vma->vm_end - vma->vm_start) >> XEN_PAGE_SHIFT;
>>  	int rc;
>>  
>>  	if (!xen_feature(XENFEAT_auto_translated_physmap) || !numpgs || !pages)
>>  		return;
>>  
>> -	rc = xen_unmap_domain_mfn_range(vma, numpgs, pages);
>> +	rc = xen_unmap_domain_mfn_range(vma, nr_pfn, pages);
>>  	if (rc == 0)
>>  		free_xenballooned_pages(numpgs, pages);
> 
> If you intend to pass the number of xen pages as nr argument to
> xen_unmap_domain_mfn_range, then I think that the changes to
> xen_xlate_unmap_gfn_range below are wrong.

Hmmm... right. I will fix it.

> 
> 
>>  	else
>> diff --git a/drivers/xen/xlate_mmu.c b/drivers/xen/xlate_mmu.c
>> index 58a5389..1fac17c 100644
>> --- a/drivers/xen/xlate_mmu.c
>> +++ b/drivers/xen/xlate_mmu.c
>> @@ -38,31 +38,9 @@
>>  #include <xen/interface/xen.h>
>>  #include <xen/interface/memory.h>
>>  
>> -/* map fgmfn of domid to lpfn in the current domain */
>> -static int map_foreign_page(unsigned long lpfn, unsigned long fgmfn,
>> -			    unsigned int domid)
>> -{
>> -	int rc;
>> -	struct xen_add_to_physmap_range xatp = {
>> -		.domid = DOMID_SELF,
>> -		.foreign_domid = domid,
>> -		.size = 1,
>> -		.space = XENMAPSPACE_gmfn_foreign,
>> -	};
>> -	xen_ulong_t idx = fgmfn;
>> -	xen_pfn_t gpfn = lpfn;
>> -	int err = 0;
>> -
>> -	set_xen_guest_handle(xatp.idxs, &idx);
>> -	set_xen_guest_handle(xatp.gpfns, &gpfn);
>> -	set_xen_guest_handle(xatp.errs, &err);
>> -
>> -	rc = HYPERVISOR_memory_op(XENMEM_add_to_physmap_range, &xatp);
>> -	return rc < 0 ? rc : err;
>> -}
>> -
>>  struct remap_data {
>>  	xen_pfn_t *fgmfn; /* foreign domain's gmfn */
>> +	xen_pfn_t *efgmfn; /* pointer to the end of the fgmfn array */
>>  	pgprot_t prot;
>>  	domid_t  domid;
>>  	struct vm_area_struct *vma;
>> @@ -71,24 +49,75 @@ struct remap_data {
>>  	struct xen_remap_mfn_info *info;
>>  	int *err_ptr;
>>  	int mapped;
>> +
>> +	/* Hypercall parameters */
>> +	int h_errs[XEN_PFN_PER_PAGE];
>> +	xen_ulong_t h_idxs[XEN_PFN_PER_PAGE];
>> +	xen_pfn_t h_gpfns[XEN_PFN_PER_PAGE];
> 
> I don't think you should be adding these fields to struct remap_data:
> struct remap_data is used to pass multi pages arguments from
> xen_xlate_remap_gfn_array to remap_pte_fn.
> 
> I think you need to introduce a different struct to pass per linux page
> arguments from remap_pte_fn to setup_hparams.

I didn't want to introduce a new structure in order to avoid allocating
it on the stack every time remap_pte_fn is called.

Maybe it is an optimization for nothing?

[...]

>> +	/* info->err_ptr expect to have one error status per Xen PFN */
>> +	for (i = 0; i < info->h_iter; i++) {
>> +		int err = (rc < 0) ? rc : info->h_errs[i];
>> +
>> +		*(info->err_ptr++) = err;
>> +		if (!err)
>> +			info->mapped++;
>>  	}
>> -	info->fgmfn++;
>> +
>> +	/*
>> +	 * Note: The hypercall will return 0 in most of the case if even if
>                                          ^ in most cases

Will fix it.

>> +	 * all the fgmfn are not mapped. We still have to update the pte
>        ^ not all the fgmfn are mapped.
> 
>> +	 * as the userspace may decide to continue.
>> +	 */
>> +	if (!rc)
>> +		set_pte_at(info->vma->vm_mm, addr, ptep, pte);
>>  
>>  	return 0;
>>  }
>> @@ -102,13 +131,14 @@ int xen_xlate_remap_gfn_array(struct vm_area_struct *vma,
>>  {
>>  	int err;
>>  	struct remap_data data;
>> -	unsigned long range = nr << PAGE_SHIFT;
>> +	unsigned long range = round_up(nr, XEN_PFN_PER_PAGE) << XEN_PAGE_SHIFT;
> 
> If would just BUG_ON(nr % XEN_PFN_PER_PAGE) and avoid the round_up;

As discussed IRL, the toolstack can request to map only 1 Xen page. So
the BUG_ON would always be hit.

Anyway, as you suggested IRL, I will replace the round_up by
DIV_ROUND_UP in the next version.

>>  	data.prot  = prot;
>>  	data.domid = domid;
>>  	data.vma   = vma;
>> @@ -123,21 +153,38 @@ int xen_xlate_remap_gfn_array(struct vm_area_struct *vma,
>>  }
>>  EXPORT_SYMBOL_GPL(xen_xlate_remap_gfn_array);
>>  
>> +static int unmap_gfn(struct page *page, unsigned long pfn, void *data)
>> +{
>> +	int *nr = data;
>> +	struct xen_remove_from_physmap xrp;
>> +
>> +	/* The Linux Page may not have been fully mapped to Xen */
>> +	if (!*nr)
>> +		return 0;
>> +
>> +	xrp.domid = DOMID_SELF;
>> +	xrp.gpfn = pfn;
>> +	(void)HYPERVISOR_memory_op(XENMEM_remove_from_physmap, &xrp);
>> +
>> +	(*nr)--;
> 
> I don't understand why you are passing nr as private argument. I would
> just call XENMEM_remove_from_physmap unconditionally here. Am I missing
> something? After all XENMEM_remove_from_physmap is just unmapping
> at 4K granularity, right?

Yes, but you may ask to only remove 1 4KB page. When 64KB is inuse that
would mean to call the hypervisor 16 times for only 1 useful remove.

This is because, the hypervisor doesn't provide an hypercall to remove a
list of PFN which is very infortunate.

Although, as discussed IIRC I can see to provide a new function
xen_apply_to_page_range which will handle the counter internally.

> 
> 
>> +	return 0;
>> +}
>> +
>>  int xen_xlate_unmap_gfn_range(struct vm_area_struct *vma,
>>  			      int nr, struct page **pages)
>>  {
>>  	int i;
>> +	int nr_page = round_up(nr, XEN_PFN_PER_PAGE);
> 
> If nr is the number of xen pages, then this should be:
> 
>     int nr_pages = DIV_ROUND_UP(nr, XEN_PFN_PER_PAGE);

Correct, I will fix it.

>> -	for (i = 0; i < nr; i++) {
>> -		struct xen_remove_from_physmap xrp;
>> -		unsigned long pfn;
>> +	for (i = 0; i < nr_page; i++) {
>> +		/* unmap_gfn guarantees ret == 0 */
>> +		BUG_ON(xen_apply_to_page(pages[i], unmap_gfn, &nr));
>> +	}
>>  
>> -		pfn = page_to_pfn(pages[i]);
>> +	/* We should have consume every xen page */
>                         ^ consumed

I will fix it.

Regards,

-- 
Julien Grall
