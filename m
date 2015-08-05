From: david.vrabel@citrix.com (David Vrabel)
Date: Wed, 5 Aug 2015 16:50:33 +0100
Subject: [Xen-devel] [PATCH v2 02/20] xen: Introduce a function to split
 a Linux page into Xen page
In-Reply-To: <55C21DF3.2090201@citrix.com>
References: <1436474552-31789-1-git-send-email-julien.grall@citrix.com>
 <1436474552-31789-3-git-send-email-julien.grall@citrix.com>
 <55B205FB.5080209@citrix.com> <55B20B56.7020605@citrix.com>
 <55B20F1F.60902@citrix.com> <55C21DF3.2090201@citrix.com>
Message-ID: <55C230C9.7060506@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/08/15 15:30, Julien Grall wrote:
> Hi David,
> 
> On 24/07/15 11:10, David Vrabel wrote:
>> On 24/07/15 10:54, Julien Grall wrote:
>>> On 24/07/15 10:31, David Vrabel wrote:
>>>> On 09/07/15 21:42, Julien Grall wrote:
>>>>> The Xen interface is always using 4KB page. This means that a Linux page
>>>>> may be split across multiple Xen page when the page granularity is not
>>>>> the same.
>>>>>
>>>>> This helper will break down a Linux page into 4KB chunk and call the
>>>>> helper on each of them.
>>>> [...]
>>>>> --- a/include/xen/page.h
>>>>> +++ b/include/xen/page.h
>>>>> @@ -39,4 +39,24 @@ struct xen_memory_region xen_extra_mem[XEN_EXTRA_MEM_MAX_REGIONS];
>>>>>  
>>>>>  extern unsigned long xen_released_pages;
>>>>>  
>>>>> +typedef int (*xen_pfn_fn_t)(struct page *page, unsigned long pfn, void *data);
>>>>> +
>>>>> +/* Break down the page in 4KB granularity and call fn foreach xen pfn */
>>>>> +static inline int xen_apply_to_page(struct page *page, xen_pfn_fn_t fn,
>>>>> +				    void *data)
>>>>
>>>> I think this should be outlined (unless you have measurements that
>>>> support making it inlined).
>>>
>>> I don't have any performance measurements. Although, when Linux is using
>>> 4KB page granularity, the loop in this helper will be dropped by the
>>> helper. The code would look like:
>>>
>>> unsigned long pfn = xen_page_to_pfn(page);
>>>
>>> ret = fn(page, fn, data);
>>> if (ret)
>>>   return ret;
>>>
>>> The compiler could even inline the callback (fn). So it drops 2
>>> functions call.
>>
>> Ok, keep it inlined.
>>
>>>> Also perhaps make it
>>>>
>>>> int xen_for_each_gfn(struct page *page,
>>>>                      xen_gfn_fn_t fn, void *data);
>>>
>>> gfn standing for Guest Frame Number right?
>>
>> Yes.  This suggestion is just changing the name to make it more obvious
>> what it does.
> 
> Thinking more about this suggestion. The callback (fn) is getting a 4K
> PFN in parameter and not a GFN.

I would like only APIs that deal with 64 KiB PFNs and 4 KiB GFNs.  I
think having a 4 KiB "PFN" is confusing.

Can you rework this xen_for_each_gfn() to pass GFNs to fn, instead?

> This is because the balloon code seems to require having a 4K PFN in
> hand in few places. For instance XENMEM_populate_physmap and
> HYPERVISOR_update_va_mapping.

Ug. For an auto-xlate guest frame-list needs GFNs, for a PV guest
XENMEM_populate_physmap does want PFNs (so it can fill in the M2P).

Perhaps in increase_reservation:

if (auto-xlate)
   frame_list[i] = page_to_gfn(page);
   /* Or whatever per-GFN loop you need. */
else
   frame_list[i] = page_to_pfn(page);

update_va_mapping takes VAs (e.g, __va(pfn << PAGE_SHIFT) could be
page_to_virt(page).

Sorry for being so picky here, but the inconsistency of terminology and
API misuse is already confusing and I don't want to see it get worse.

David

> 
> Although, I'm not sure to understand the difference between GMFN, and
> GPFN in the hypercall doc.
> 
> Regards,
> 
