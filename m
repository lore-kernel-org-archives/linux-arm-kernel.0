From: julien.grall@citrix.com (Julien Grall)
Date: Thu, 16 Jul 2015 17:07:08 +0100
Subject: [PATCH v2 03/20] xen/grant: Introduce helpers to split a page
 into grant
In-Reply-To: <alpine.DEB.2.02.1507161526030.17378@kaball.uk.xensource.com>
References: <1436474552-31789-1-git-send-email-julien.grall@citrix.com>
 <1436474552-31789-4-git-send-email-julien.grall@citrix.com>
 <alpine.DEB.2.02.1507161526030.17378@kaball.uk.xensource.com>
Message-ID: <55A7D6AC.5060004@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefano,

On 16/07/2015 17:01, Stefano Stabellini wrote:
> On Thu, 9 Jul 2015, Julien Grall wrote:
>> Currently, a grant is always based on the Xen page granularity (i.e
>> 4KB). When Linux is using a different page granularity, a single page
>> will be split between multiple grants.
>>
>> The new helpers will be in charge to split the Linux page into grant and
>                                                                    ^
>                                                                    grants

Will fix it.

>> call a function given by the caller on each grant.
>>
>> In order to help some PV drivers, the callback is allowed to use less
>> data and must update the resulting length. This is useful for netback.
>>
>> Also provide and helper to count the number of grants within a given
>> contiguous region.
>>
>> Signed-off-by: Julien Grall <julien.grall@citrix.com>
>> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
>> Cc: David Vrabel <david.vrabel@citrix.com>
>> ---
>>      Changes in v2:
>>          - Patch added
>> ---
>>   drivers/xen/grant-table.c | 26 ++++++++++++++++++++++++++
>>   include/xen/grant_table.h | 41 +++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 67 insertions(+)
>>
>> diff --git a/drivers/xen/grant-table.c b/drivers/xen/grant-table.c
>> index 62f591f..3679293 100644
>> --- a/drivers/xen/grant-table.c
>> +++ b/drivers/xen/grant-table.c
>> @@ -296,6 +296,32 @@ int gnttab_end_foreign_access_ref(grant_ref_t ref, int readonly)
>>   }
>>   EXPORT_SYMBOL_GPL(gnttab_end_foreign_access_ref);
>>
>> +void gnttab_foreach_grant(struct page *page, unsigned int offset,
>> +			  unsigned int len, xen_grant_fn_t fn,
>> +			  void *data)
>> +{
>> +	unsigned int goffset;
>> +	unsigned int glen;
>> +	unsigned long pfn;
>
> I would s/pfn/xen_pfn/ inside this function for clarity

Ok.

>
>
>> +	len = min_t(unsigned int, PAGE_SIZE - offset, len);
>> +	goffset = offset & ~XEN_PAGE_MASK;
>
> I don't think we want to support cases where (offset & ~XEN_PAGE_MASK)
> != 0, we should just return error.

We have to support offset != 0. The buffer received by the PV drivers 
may start in the middle of the page and finish before the end of the page.

For instance blkfront is using biovec which contains 3 informations: the 
page, the offset in the page and the total length.

>
>> +	pfn = xen_page_to_pfn(page) + (offset >> XEN_PAGE_SHIFT);
>> +
>> +	while (len) {
>> +		glen = min_t(unsigned int, XEN_PAGE_SIZE - goffset, len);
>
> Similarly I don't think we want to support glen != XEN_PAGE_SIZE here

See my answer above.

>
>
>> +		fn(pfn_to_mfn(pfn), goffset, &glen, data);
>
> Allowing the callee to change glen makes the interface more complex and
> certainly doesn't match the gnttab_foreach_grant function name anymore.

Why? Each time the callback is called, there is a new grant allocated.

> If netback needs it, could it just do the work inside its own function?
> I would rather keep gnttab_foreach_grant simple and move the complexity
> there.

Moving the complexity in netback means adding a loop in the callback
which will do exactly the same as this loop.

That also means to use XEN_PAGE_SIZE & co which I'm trying to avoid in 
order to not confuse the developer. If they are hidden it likely mean 
less problem on 64KB when the developper is working on 4KB.

IHMO, the complexity is not so bad and will be more lisible than yet 
another loop.

[...]


>> +/* Helper to get to call fn only on the first "grant chunk" */
>> +static inline void gnttab_one_grant(struct page *page, unsigned int offset,
>> +				    unsigned len, xen_grant_fn_t fn,
>> +				    void *data)
>> +{
>> +	/* The first request is limited to the size of one grant */
>> +	len = min_t(unsigned int, XEN_PAGE_SIZE - (offset & ~XEN_PAGE_MASK),
>> +		    len);
>
> I would just BUG_ON(offset & ~XEN_PAGE_MASK) and simply len = XEN_PAGE_SIZE;

See my remark above.

>
>
>> +	gnttab_foreach_grant(page, offset, len, fn, data);
>> +}
>> +
>> +/* Get the number of grant in a specified region
>> + *
>> + * offset: Offset in the first page
>
> I would generalize this function and support offset > PAGE_SIZE. At that
> point you could rename offset to "start".

It's actually supported, maybe it's not clear enough.

Regards,

-- 
Julien Grall
