From: julien.grall@citrix.com (Julien Grall)
Date: Fri, 24 Jul 2015 14:03:14 +0100
Subject: [Xen-devel] [PATCH v2 01/20] xen: Add Xen specific page definition
In-Reply-To: <55B214C5.3020501@citrix.com>
References: <1436474552-31789-1-git-send-email-julien.grall@citrix.com>
 <1436474552-31789-2-git-send-email-julien.grall@citrix.com>
 <55B20540.3020000@citrix.com> <55B207C6.4020300@citrix.com>
 <55B209D9.1080602@citrix.com> <55B20ABE.7000609@citrix.com>
 <55B214C5.3020501@citrix.com>
Message-ID: <55B23792.5090802@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/07/15 11:34, David Vrabel wrote:
> On 24/07/15 10:51, Julien Grall wrote:
>> On 24/07/15 10:48, David Vrabel wrote:
>>> On 24/07/15 10:39, Julien Grall wrote:
>>>> Hi David,
>>>>
>>>> On 24/07/15 10:28, David Vrabel wrote:
>>>>> On 09/07/15 21:42, Julien Grall wrote:
>>>>>> The Xen hypercall interface is always using 4K page granularity on ARM
>>>>>> and x86 architecture.
>>>>>>
>>>>>> With the incoming support of 64K page granularity for ARM64 guest, it
>>>>>> won't be possible to re-use the Linux page definition in Xen drivers.
>>>>>>
>>>>>> Introduce Xen page definition helpers based on the Linux page
>>>>>> definition. They have exactly the same name but prefixed with
>>>>>> XEN_/xen_ prefix.
>>>>>>
>>>>>> Also modify page_to_pfn to use new Xen page definition.
>>>>>>
>>>>>> Signed-off-by: Julien Grall <julien.grall@citrix.com>
>>>>>> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>>>>>> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
>>>>>> Cc: David Vrabel <david.vrabel@citrix.com>
>>>>>> ---
>>>>>>     I'm wondering if we should drop page_to_pfn has the macro will likely
>>>>>>     misuse when Linux is using 64KB page granularity.
>>>>>
>>>>> I think we want xen_gfn_to_page() and xen_page_to_gfn() and Xen
>>>>> front/back drivers never deal with PFNs only GFNs.
>>>>
>>>> What is xen_gfn_to_page and xen_page_to_gfn? Neither Linux, nor my
>>>> series have them.
>>>
>>> I suggesting that you introduce these.
>>
>> It's still not clear to me what you are suggesting here... Do you
>> suggest to rename xen_pfn_to_page and xen_page_to_pfn by xen_gfn_to_page
>> and xen_page_to_gfn?
> 
> Effectively, yes but it would be better to think that:
> 
> PFNs index guest-sized pages (which may be 64 KiB).
> 
> GFNs index Xen-sized pages (which is always 4 KiB).

If I'm understanding correctly you mean:

#define xen_page_to_gfn(page)	\
((page_to_pfn(page) << PAGE_SHIFT) >> XEN_PAGE_SHIFT))

static page_to_mfn(struct page *page)
{
	return pfn_to_mfn(xen_page_to_gfn(page));
}

Although in some place you are suggesting to use:

xen_page_to_gfn(virt_to_page(info->intf)) (see patch #11) where it
suggests to rename page_to_mfn in xen_page_to_gfn.

I think it would make more sense to use the latter one. We would also
need to name to describe a PFN (pseudo-physical frame number based on
xen/include/xen/mm.h) but with 4K granularity and not the Linux granularity.

It's useful to have it in some place in order to iter on the 4K pfn (see
gnttab_foreach_grant and xen_apply_to_page). Maybe xpfn for Xen
pseudo-physical frame number?

I will preprend some patches into this serie to rename the function with
their correct naming.

I have in mind pfn_to_mfn which should be name into pfn_to_gfn given the
usage. Similarly, this function is mis-used on ARM because the function
may return an MFN where we expect a GFN.

Regards,

-- 
Julien Grall
