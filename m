From: julien.grall@citrix.com (Julien Grall)
Date: Wed, 5 Aug 2015 17:06:14 +0100
Subject: [Xen-devel] [PATCH v2 02/20] xen: Introduce a function to split
 a Linux page into Xen page
In-Reply-To: <55C230C9.7060506@citrix.com>
References: <1436474552-31789-1-git-send-email-julien.grall@citrix.com>
 <1436474552-31789-3-git-send-email-julien.grall@citrix.com>
 <55B205FB.5080209@citrix.com> <55B20B56.7020605@citrix.com>
 <55B20F1F.60902@citrix.com> <55C21DF3.2090201@citrix.com>
 <55C230C9.7060506@citrix.com>
Message-ID: <55C23476.8020104@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/08/15 16:50, David Vrabel wrote:
>>>>> Also perhaps make it
>>>>>
>>>>> int xen_for_each_gfn(struct page *page,
>>>>>                      xen_gfn_fn_t fn, void *data);
>>>>
>>>> gfn standing for Guest Frame Number right?
>>>
>>> Yes.  This suggestion is just changing the name to make it more obvious
>>> what it does.
>>
>> Thinking more about this suggestion. The callback (fn) is getting a 4K
>> PFN in parameter and not a GFN.
> 
> I would like only APIs that deal with 64 KiB PFNs and 4 KiB GFNs.  I
> think having a 4 KiB "PFN" is confusing.

I agree with that. Note that helpers splitting Linux page in 4K chunk
such as gnttab_for_each_grant (see patch #3) and this one may still have
the concept of 4K "PFN" for internal purpose.

> Can you rework this xen_for_each_gfn() to pass GFNs to fn, instead?

I will do.

> 
>> This is because the balloon code seems to require having a 4K PFN in
>> hand in few places. For instance XENMEM_populate_physmap and
>> HYPERVISOR_update_va_mapping.
> 
> Ug. For an auto-xlate guest frame-list needs GFNs, for a PV guest
> XENMEM_populate_physmap does want PFNs (so it can fill in the M2P).
> 
> Perhaps in increase_reservation:
> 
> if (auto-xlate)
>    frame_list[i] = page_to_gfn(page);
>    /* Or whatever per-GFN loop you need. */
> else
>    frame_list[i] = page_to_pfn(page);
> 
> update_va_mapping takes VAs (e.g, __va(pfn << PAGE_SHIFT) could be
> page_to_virt(page).

I though about a similar approach but I wanted to keep the code generic,
i.e support the splitting even for non auto-translated guest. Hence the
implementation xen_apply_to_page.

Anyway, I will see to do what you suggest.

> Sorry for being so picky here, but the inconsistency of terminology and
> API misuse is already confusing and I don't want to see it get worse.

No worry, I'm happy to rework this code to be able to drop the 4K PFN
concept.

Regards,

-- 
Julien Grall
