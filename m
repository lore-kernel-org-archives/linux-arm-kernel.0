From: julien.grall@citrix.com (Julien Grall)
Date: Fri, 24 Jul 2015 11:20:57 +0100
Subject: [Xen-devel] [PATCH v2 02/20] xen: Introduce a function to split
 a Linux page into Xen page
In-Reply-To: <55B20F1F.60902@citrix.com>
References: <1436474552-31789-1-git-send-email-julien.grall@citrix.com>
 <1436474552-31789-3-git-send-email-julien.grall@citrix.com>
 <55B205FB.5080209@citrix.com> <55B20B56.7020605@citrix.com>
 <55B20F1F.60902@citrix.com>
Message-ID: <55B21189.8030901@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/07/15 11:10, David Vrabel wrote:
> On 24/07/15 10:54, Julien Grall wrote:
>> On 24/07/15 10:31, David Vrabel wrote:
>>> On 09/07/15 21:42, Julien Grall wrote:
>>>> The Xen interface is always using 4KB page. This means that a Linux page
>>>> may be split across multiple Xen page when the page granularity is not
>>>> the same.
>>>>
>>>> This helper will break down a Linux page into 4KB chunk and call the
>>>> helper on each of them.
>>> [...]
>>>> --- a/include/xen/page.h
>>>> +++ b/include/xen/page.h
>>>> @@ -39,4 +39,24 @@ struct xen_memory_region xen_extra_mem[XEN_EXTRA_MEM_MAX_REGIONS];
>>>>  
>>>>  extern unsigned long xen_released_pages;
>>>>  
>>>> +typedef int (*xen_pfn_fn_t)(struct page *page, unsigned long pfn, void *data);
>>>> +
>>>> +/* Break down the page in 4KB granularity and call fn foreach xen pfn */
>>>> +static inline int xen_apply_to_page(struct page *page, xen_pfn_fn_t fn,
>>>> +				    void *data)
>>>
>>> I think this should be outlined (unless you have measurements that
>>> support making it inlined).
>>
>> I don't have any performance measurements. Although, when Linux is using
>> 4KB page granularity, the loop in this helper will be dropped by the
>> helper. The code would look like:
>>
>> unsigned long pfn = xen_page_to_pfn(page);
>>
>> ret = fn(page, fn, data);
>> if (ret)
>>   return ret;
>>
>> The compiler could even inline the callback (fn). So it drops 2
>> functions call.
> 
> Ok, keep it inlined.
> 
>>> Also perhaps make it
>>>
>>> int xen_for_each_gfn(struct page *page,
>>>                      xen_gfn_fn_t fn, void *data);
>>
>> gfn standing for Guest Frame Number right?
> 
> Yes.  This suggestion is just changing the name to make it more obvious
> what it does.

I will change the name.

Regards,

-- 
Julien Grall
