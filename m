From: labbott@redhat.com (Laura Abbott)
Date: Mon, 24 Apr 2017 16:59:58 -0700
Subject: [PATCH 4/5] Hot-remove implementation for arm64
In-Reply-To: <20170421100500.GB20029@samekh>
References: <cover.1491920513.git.ar@linux.vnet.ibm.com>
 <897973dd5d3fc91c70aba4b44350099a61c3a12c.1491920513.git.ar@linux.vnet.ibm.com>
 <20170411171210.GD32267@leverpostej> <20170414140158.GA17950@samekh>
 <20170418182125.GL17866@leverpostej>
 <CAKv+Gu9YYoFmFwpVgrOvD+eMHAKPmG_zgTz5f7JMT6iGqgLHGw@mail.gmail.com>
 <535ba380-56e8-db3d-25c5-14d51e48105f@redhat.com>
 <20170421100500.GB20029@samekh>
Message-ID: <3a5afc84-b920-e164-c05a-2c6a3e05bf84@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/21/2017 03:05 AM, Andrea Reale wrote:
> Hi all,
> 
> thanks for taking the time to comment. Replies in-line.
> 
> On Wed, Apr 19, 2017 at 08:53:13AM -0700, Laura Abbott wrote:
>> On 04/18/2017 11:48 AM, Ard Biesheuvel wrote:
>>> On 18 April 2017 at 19:21, Mark Rutland <mark.rutland@arm.com> wrote:
>>>> On Fri, Apr 14, 2017 at 03:01:58PM +0100, Andrea Reale wrote:
> 
> [...]
> 
>>>>
>>>> From a quick scan, I see that it's necessary to use pgtable_page_ctor()
>>>> for pages that will be used for userspace page tables, but it's not
>>>> clear to me if it's ever necessary for pages used for kernel page
>>>> tables.
>>>>
>>>> If it is, we appear to have a bug on arm64.
>>>>
>>>> Laura, Ard, thoughts?
>>>>
>>>
>>> The generic apply_to_page_range() will expect the PTE lock to be
>>> initialized for page table pages that are not part of init_mm. For
>>> arm64, that is precisely efi_mm as far as I am aware. For EFI, the
>>> locking is unnecessary but does no harm (the permissions are set once
>>> via apply_to_page_range() at boot), so I added this call when adding
>>> support for strict permissions in EFI rt services mappings.
>>>
>>> So I think it is appropriate for create_pgd_mapping() to be in charge
>>> of calling the ctor(). We simply have no destroy_pgd_mapping()
>>> counterpart that would be the place for the dtor() call, given that we
>>> never take down EFI rt services mappi >
>>> Whether it makes sense or not to lock/unlock in apply_to_page_range()
>>> is something I did not spend any brain cycles on at the time.
>>>
>>
>> Agreed there shouldn't be a problem right now. I do think the locking is
>> appropriate in apply_to_page_range given what other functions also get
>> locked.
>>
>> I really wish this were less asymmetrical though since it get hard
>> to reason about. It looks like hotplug_paging will call the ctor,
>> so is there an issue with calling hot-remove on memory that was once
>> hot-added or is that not a concern?
>>
>> Thanks,
>> Laura
> 
> I think the confusion comes from the fact that, in hotplug_paging, we are
> passing pgd_pgtable_alloc as the page allocator for __create_pgd_mapping,
> which always calls the ctor.
> 
> If I got things right (but, please, correct me if I am wrong), we don't
> need to get the pte_lock that the ctor gets since - in hotplug - we are
> adding to init_mm.
> 
> Moreover, I am just realizing that calling the dtor while hot-removing
> might create problems when removing memory that *was not* previously
> hotplugged, as we are calling a dtor on something that was never
> ctor'ed. Is that what you were hinting at, Laura?
> 
> Thanks and best regards,
> Andrea
> 

Yes, that was what I was thinking.

Thanks,
Laura
