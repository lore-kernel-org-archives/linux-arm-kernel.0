From: maz@misterjones.org (Marc Zyngier)
Date: Sun, 14 Sep 2014 10:09:17 +0100
Subject: [PATCH 1/2] ARM: kvm: define =?UTF-8?Q?PAGE=5FS=32=5FDEVICE?=
 =?UTF-8?Q?=20as=20read-only=20by=20default?=
In-Reply-To: <CAKv+Gu93FkRWXd96gKdN+OCrUgjF0sXWL4ohishVWAO-XeR9Ww@mail.gmail.com>
References: <1410603462-28900-1-git-send-email-ard.biesheuvel@linaro.org>
 <bcbc1c52f9e1eeb24f0bd1956236f0a3@www.loen.fr>
 <CAKv+Gu8J8o2=CS9tGVbkavHep6gNwSSegZ0fxqsVE2AVDVzdpA@mail.gmail.com>
 <20140913170638.GA3348@lvm>
 <CAKv+Gu93FkRWXd96gKdN+OCrUgjF0sXWL4ohishVWAO-XeR9Ww@mail.gmail.com>
Message-ID: <fdc415c79e617d4e9102acc12a4c0d65@www.loen.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014-09-14 05:49, Ard Biesheuvel wrote:
> On 13 September 2014 19:06, Christoffer Dall
> <christoffer.dall@linaro.org> wrote:
>> On Sat, Sep 13, 2014 at 01:15:45PM +0200, Ard Biesheuvel wrote:
>>> On 13 September 2014 12:41, Marc Zyngier <marc.zyngier@arm.com> 
>>> wrote:
>>> > Hi Ard,
>>> >
>>> > On 2014-09-13 11:17, Ard Biesheuvel wrote:
>>> >>
>>> >> Now that we support read-only memslots, we need to make sure 
>>> that
>>> >> pass-through device mappings are not mapped writable if the 
>>> guest
>>> >> has requested them to be read-only. The existing implementation
>>> >> already honours this by calling kvm_set_s2pte_writable() on the 
>>> new
>>> >> pte in case of writable mappings, so all we need to do is define
>>> >> the default pgprot_t value used for devices to be PTE_S2_RDONLY.
>>> >>
>>> >> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>> >
>>> >
>>> > I feel very uncomfortable with this change. Why would we map a 
>>> device RO? Is
>>> > that only for completeness sake?
>>> >
>>>
>>> We would map a device RO so that QEMU (or whatever is managing KVM)
>>> can emulate the writes. I don't have a clear cut use case, to be
>>> honest, but setting up a writable mapping for a memslot that was
>>> explicitly set up as read-only seems wrong in any case.
>>
>> Agreed, if it doesn't ever make sense to do so, then we should 
>> return an
>> error to user space if userspace attempts such a configuration.  The
>> current code is just weird.
>>
>>>
>>> Note that the particular problem I was seeing was primarily caused 
>>> by
>>> kvm_is_mmio_pfn()'s false positive on the zero page, but it 
>>> unveiled
>>> this particular issue as well.
>>>
>>> > Note that we also use PAGE_S2_DEVICE for things that are not 
>>> mapped through
>>> > a memslot, such as the GIC.
>>> >
>>>
>>> Yes, and I realize now that this breaks it.
>>> My apologies: I have an additional patch locally that sets up MMIO
>>> ranges in one go instead of faulting them in one page at a time as 
>>> we
>>> do now, and there the read-write case is handled correctly in
>>> kvm_phys_addr_ioremap(). However, I thought it was better to send
>>> these out separately first, but apparently not.
>>
>> I think it is better to change this separately, and then add the 
>> ioremap
>> stuff.  However, you need to change all places that call 
>> PAGE_S2_DEVICE
>> and expect a RDWR memory region, this happens to be only
>> kvm_phys_addr_ioremap() for now.
>>
>>>
>>> So if we can agree on whether or not MMIO backed mappings should be
>>> read-write even if the memslot says no, I will follow up with a 
>>> proper
>>> series if there are still changes required.
>>>
>>
>> I guess it could be theoretically useful to have read-only device 
>> memory
>> regions, and I can't think of why it would violate the architecture.
>>
>
> We have to handle it either way. But after reading D4.5.3 (Table
> D4-40) of the ARM ARM, I am wondering why we needed patch 
> b88657674d39
> "ARM: KVM: user_mem_abort: support stage 2 MMIO page mapping" in the
> first place, and we could just revert that patch and everything would
> work as expected. (In short, D4.5.3 says that MT_DEVICE trumps
> MT_NORMAL, so if the stage 1 translation is MT_DEVICE, it doesn't
> matter what memtype the S2 translation specifies)

We've been there before:
https://lists.cs.columbia.edu/pipermail/kvmarm/2013-May/004420.html

>> That said, I don't have any more clear use cases in mind, and we
>> definitely shouldn't just silently ignore the read-only flag from 
>> user
>> space and make the region writeable.  If we don't want to allow this
>> behavior, we can return an error in kvm_arch_create_memslot(), which
>> will cause the KVM_CREATE_USER_MEMORY_REGION ioctl to return 
>> -ENOMEM.
>>
>
> Well, I am not sure how easy it is to find out beforehand (i.e., at
> ioctl time) what the nature of the backing is, and you have to deal
> with hva_to_pfn() potentially returning a VM_PFNMAP pfn or
> PageReserved pages anyway.
> So just mapping everything as MT_NORMAL actually seems like the 
> sanest
> thing to do, so imo we should revert the patch. The only other
> question I had is whether it would be better to map a MMIO region in
> one go, but we can discuss that separately.

Aside from the MT_NORMAL thing, the only saving we'd get by dynamically 
maping MMIO regions would be the page tables. Not very useful in my 
opinion.

Thanks,

         M.
-- 
Who you jivin' with that Cosmik Debris?
