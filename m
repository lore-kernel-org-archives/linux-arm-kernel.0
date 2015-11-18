From: zhaoshenglong@huawei.com (Shannon Zhao)
Date: Wed, 18 Nov 2015 12:32:44 +0800
Subject: [Xen-devel] [PATCH 02/13] xen/grant-table: Move
 xlated_setup_gnttab_pages to common place
In-Reply-To: <564B4F80.2020402@citrix.com>
References: <1447754231-7772-1-git-send-email-shannon.zhao@linaro.org>
 <1447754231-7772-3-git-send-email-shannon.zhao@linaro.org>
 <564B4F80.2020402@citrix.com>
Message-ID: <564BFF6C.3070208@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/11/18 0:02, David Vrabel wrote:
> On 17/11/15 09:57, shannon.zhao at linaro.org wrote:
>> From: Shannon Zhao <shannon.zhao@linaro.org>
>>
>> Move xlated_setup_gnttab_pages to common place, so it can be reused by
>> ARM to setup grant table when booting with ACPI.
> [...]
>> --- a/drivers/xen/grant-table.c
>> +++ b/drivers/xen/grant-table.c
>> @@ -664,6 +664,55 @@ int gnttab_setup_auto_xlat_frames(phys_addr_t addr)
>>  }
>>  EXPORT_SYMBOL_GPL(gnttab_setup_auto_xlat_frames);
>>  
>> +int __init xlated_setup_gnttab_pages(void)
>> +{
>> +	struct page **pages;
>> +	xen_pfn_t *pfns;
>> +	void *vaddr;
>> +	int rc;
>> +	unsigned int i;
>> +	unsigned long nr_grant_frames = gnttab_max_grant_frames();
>> +
>> +	BUG_ON(nr_grant_frames == 0);
>> +	pages = kcalloc(nr_grant_frames, sizeof(pages[0]), GFP_KERNEL);
>> +	if (!pages)
>> +		return -ENOMEM;
>> +
>> +	pfns = kcalloc(nr_grant_frames, sizeof(pfns[0]), GFP_KERNEL);
>> +	if (!pfns) {
>> +		kfree(pages);
>> +		return -ENOMEM;
>> +	}
>> +	rc = alloc_xenballooned_pages(nr_grant_frames, pages, 0 /* lowmem */);
>> +	if (rc) {
>> +		pr_warn("%s Couldn't balloon alloc %ld pfns rc:%d\n", __func__,
>> +			nr_grant_frames, rc);
>> +		kfree(pages);
>> +		kfree(pfns);
>> +		return rc;
>> +	}
>> +	for (i = 0; i < nr_grant_frames; i++)
>> +		pfns[i] = page_to_pfn(pages[i]);
>> +
>> +	vaddr = vmap(pages, nr_grant_frames, 0, PAGE_KERNEL);
>> +	if (!vaddr) {
>> +		pr_warn("%s Couldn't map %ld pfns rc:%d\n", __func__,
>> +			nr_grant_frames, rc);
>> +		free_xenballooned_pages(nr_grant_frames, pages);
>> +		kfree(pages);
>> +		kfree(pfns);
>> +		return -ENOMEM;
>> +	}
>> +	kfree(pages);
> 
> Can you move most of this function into drivers/xen/xlate_mmu.c in a
> function like:
> 
> /**
>  * xen_xlate_map_ballooned_pages - map a new set of ballooned pages
>  * count: number of GFNs.
>  * pages: returns the array of (now) ballooned pages.
>  * gfns: returns the array of corresponding GFNs.
>  * virt: returns the virtual address of the mapped region.
>  *
>  * This allocate a set of ballooned pages and maps them into the
>  * kernel's address space.
>  */
> void *xen_xlate_map_ballooned_pages(
>     unsigned int count,
>     struct page **pages,
>     xen_pfn_t **gfns);
> 
Sure, but the parameter "pages" is not necessary I think, since the
pages has been freed in the function and it doesn't need in
xen_auto_xlat_grant_frames either. Right?

Thanks,
-- 
Shannon
