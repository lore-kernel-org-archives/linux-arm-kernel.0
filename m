From: julien.grall@citrix.com (Julien Grall)
Date: Thu, 16 Jul 2015 16:52:59 +0200
Subject: [PATCH v2 01/20] xen: Add Xen specific page definition
In-Reply-To: <alpine.DEB.2.02.1507161515420.17378@kaball.uk.xensource.com>
References: <1436474552-31789-1-git-send-email-julien.grall@citrix.com>
 <1436474552-31789-2-git-send-email-julien.grall@citrix.com>
 <alpine.DEB.2.02.1507161515420.17378@kaball.uk.xensource.com>
Message-ID: <55A7C54B.5030603@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefano,

On 16/07/2015 16:19, Stefano Stabellini wrote:
>> diff --git a/include/xen/page.h b/include/xen/page.h
>> index c5ed20b..8ebd37b 100644
>> --- a/include/xen/page.h
>> +++ b/include/xen/page.h
>> @@ -1,11 +1,30 @@
>>   #ifndef _XEN_PAGE_H
>>   #define _XEN_PAGE_H
>>
>> +#include <asm/page.h>
>> +
>> +/* The hypercall interface supports only 4KB page */
>> +#define XEN_PAGE_SHIFT	12
>> +#define XEN_PAGE_SIZE	(_AC(1,UL) << XEN_PAGE_SHIFT)
>> +#define XEN_PAGE_MASK	(~(XEN_PAGE_SIZE-1))
>> +#define xen_offset_in_page(p)	((unsigned long)(p) & ~XEN_PAGE_MASK)
>> +#define xen_pfn_to_page(pfn)	\
>
> I think it would be clearer if you called the parameter "xen_pfn"
> instead of "pfn".

Good idea, I will do it in the next version.

>
>> +	((pfn_to_page(((unsigned long)(pfn) << XEN_PAGE_SHIFT) >> PAGE_SHIFT)))
>> +#define xen_page_to_pfn(page)	\
>> +	(((page_to_pfn(page)) << PAGE_SHIFT) >> XEN_PAGE_SHIFT)
>
>
> It would be nice to have a comment:
>
> /* assume PAGE_SIZE is a multiple of XEN_PAGE_SIZE */

Ok. FWIW, there is already a BUILD_BUG_ON the privcmd driver to check 
this assumption (see patch #19).

I could move the BUILD_BUG_ON in page.h. Maybe inside xen_page_to_pfn?

>
>
>> +#define XEN_PFN_PER_PAGE	(PAGE_SIZE / XEN_PAGE_SIZE)
>> +
>> +#define XEN_PFN_DOWN(x)	((x) >> XEN_PAGE_SHIFT)
>> +#define XEN_PFN_UP(x)	(((x) + XEN_PAGE_SIZE-1) >> XEN_PAGE_SHIFT)
>> +#define XEN_PFN_PHYS(x)	((phys_addr_t)(x) << XEN_PAGE_SHIFT)
>> +
>>   #include <asm/xen/page.h>
>>
>> +/* Return the MFN associated to the first 4KB of the page */
>>   static inline unsigned long page_to_mfn(struct page *page)
>>   {
>> -	return pfn_to_mfn(page_to_pfn(page));
>> +	return pfn_to_mfn(xen_page_to_pfn(page));
>>   }
>>
>>   struct xen_memory_region {
>
>
> Aside from the two minor suggestions:
>
> Reviewed-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>

Thank you,

-- 
Julien Grall
