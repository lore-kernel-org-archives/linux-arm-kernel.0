From: julien.grall@citrix.com (Julien Grall)
Date: Thu, 18 Jun 2015 18:05:59 +0100
Subject: [Xen-devel] [RFC 22/23] xen/privcmd: Add support for Linux 64KB
 page granularity
In-Reply-To: <555B5933.9040405@citrix.com>
References: <1431622863-28575-1-git-send-email-julien.grall@citrix.com>
 <1431622863-28575-23-git-send-email-julien.grall@citrix.com>
 <555B5933.9040405@citrix.com>
Message-ID: <5582FA77.5030306@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

On 19/05/15 16:39, David Vrabel wrote:
> On 14/05/15 18:01, Julien Grall wrote:
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
> [...]
>> --- a/drivers/xen/xlate_mmu.c
>> +++ b/drivers/xen/xlate_mmu.c
>> @@ -63,6 +63,7 @@ static int map_foreign_page(unsigned long lpfn, unsigned long fgmfn,
>>  
>>  struct remap_data {
>>  	xen_pfn_t *fgmfn; /* foreign domain's gmfn */
>> +	xen_pfn_t *egmfn; /* end foreign domain's gmfn */
> 
> I don't know what you mean by "end foreign domain".

I meant the last gmfn to map. This is because the Linux page may not be
fully mapped.

>>  	pgprot_t prot;
>>  	domid_t  domid;
>>  	struct vm_area_struct *vma;
>> @@ -78,17 +79,23 @@ static int remap_pte_fn(pte_t *ptep, pgtable_t token, unsigned long addr,
>>  {
>>  	struct remap_data *info = data;
>>  	struct page *page = info->pages[info->index++];
>> -	unsigned long pfn = page_to_pfn(page);
>> -	pte_t pte = pte_mkspecial(pfn_pte(pfn, info->prot));
>> +	unsigned long pfn = xen_page_to_pfn(page);
>> +	pte_t pte = pte_mkspecial(pfn_pte(page_to_pfn(page), info->prot));
>>  	int rc;
>> -
>> -	rc = map_foreign_page(pfn, *info->fgmfn, info->domid);
>> -	*info->err_ptr++ = rc;
>> -	if (!rc) {
>> -		set_pte_at(info->vma->vm_mm, addr, ptep, pte);
>> -		info->mapped++;
>> +	uint32_t i;
>> +
>> +	for (i = 0; i < XEN_PFN_PER_PAGE; i++) {
>> +		if (info->fgmfn == info->egmfn)
>> +			break;
>> +
>> +		rc = map_foreign_page(pfn++, *info->fgmfn, info->domid);
>> +		*info->err_ptr++ = rc;
>> +		if (!rc) {
>> +			set_pte_at(info->vma->vm_mm, addr, ptep, pte);
>> +			info->mapped++;
>> +		}
>> +		info->fgmfn++;
> 
> This doesn't make any sense to me.  Don't you need to gather the foreign
> GFNs into batches of PAGE_SIZE / XEN_PAGE_SIZE and map these all at once
> into a 64 KiB page?  I don't see how you can have a set_pte_at() for
> each foreign GFN.

I will see to rework this code. I've noticed few others error in the
privcmd code too.

Regards,

-- 
Julien Grall
