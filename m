From: anup@brainfault.org (Anup Patel)
Date: Wed, 14 Aug 2013 21:06:46 +0530
Subject: [PATCH] ARM64: KVM: Fix coherent_icache_guest_page() for host
 with external L3-cache.
In-Reply-To: <5d2d3ae495c27873661c5c2fbdcc19b6@www.loen.fr>
References: <1376480832-18705-1-git-send-email-pranavkumar@linaro.org>
 <f8917fe8409b1fae634c7de45e34d4a7@www.loen.fr>
 <CAAhSdy2TctgKk7m48S7jUCMr2dkDoeyT-r=-SMX+_Ce-sUimYA@mail.gmail.com>
 <5d2d3ae495c27873661c5c2fbdcc19b6@www.loen.fr>
Message-ID: <CAAhSdy0Z5Vf6_N2yxxfEk-r+WKLDULSY4ieLg1BoSm+2AciqcA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 14, 2013 at 8:53 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 2013-08-14 15:22, Anup Patel wrote:
>>
>> On Wed, Aug 14, 2013 at 5:34 PM, Marc Zyngier <marc.zyngier@arm.com>
>> wrote:
>>>
>>> Hi Pranav,
>>>
>>> On 2013-08-14 12:47, Pranavkumar Sawargaonkar wrote:
>>>>
>>>> Systems with large external L3-cache (few MBs), might have dirty
>>>> content belonging to the guest page in L3-cache. To tackle this,
>>>> we need to flush such dirty content from d-cache so that guest
>>>> will see correct contents of guest page when guest MMU is disabled.
>>>>
>>>> The patch fixes coherent_icache_guest_page() for external L3-cache.
>>>>
>>>> Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
>>>> Signed-off-by: Anup Patel <anup.patel@linaro.org>
>>>> ---
>>>>  arch/arm64/include/asm/kvm_mmu.h |    2 ++
>>>>  1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/include/asm/kvm_mmu.h
>>>> b/arch/arm64/include/asm/kvm_mmu.h
>>>> index efe609c..5129038 100644
>>>> --- a/arch/arm64/include/asm/kvm_mmu.h
>>>> +++ b/arch/arm64/include/asm/kvm_mmu.h
>>>> @@ -123,6 +123,8 @@ static inline void
>>>> coherent_icache_guest_page(struct kvm *kvm, gfn_t gfn)
>>>>       if (!icache_is_aliasing()) {            /* PIPT */
>>>>               unsigned long hva = gfn_to_hva(kvm, gfn);
>>>>               flush_icache_range(hva, hva + PAGE_SIZE);
>>>> +             /* Flush d-cache for systems with external caches. */
>>>> +             __flush_dcache_area((void *) hva, PAGE_SIZE);
>>>>       } else if (!icache_is_aivivt()) {       /* non ASID-tagged VIVT */
>>>>               /* any kind of VIPT cache */
>>>>               __flush_icache_all();
>>>
>>>
>>> [adding Will to the discussion as we talked about this in the past]
>>>
>>> That's definitely an issue, but I'm not sure the fix is to hit the data
>>> cache on each page mapping. It looks overkill.
>>>
>>> Wouldn't it be enough to let userspace do the cache cleaning? kvmtools
>>> knows which bits of the guest memory have been touched, and can do a "DC
>>> DVAC" on this region.
>>
>>
>> It seems a bit unnatural to have cache cleaning is user-space. I am sure
>> other architectures don't have such cache cleaning in user-space for KVM.
>
>
> Well, we have it on AArch64. Why would we blindly nuke the whole cache if we
> can do the right thing, efficiently, on the right range?

Flushing from user-space would be better only if target virtual address
range is small. If user-space loads several images at different locations
or large large images in guest RAM then flushing entire d-cache by
set/way would be more efficient.

>
>
>>> The alternative is do it in the kernel before running any vcpu - but
>>> that's not very nice either (have to clean the whole of the guest
>>> memory, which makes a full dcache clean more appealing).
>>
>>
>> Actually, cleaning full d-cache by set/way upon first run of VCPU was
>> our second option but current approach seemed very simple hence
>> we went for this.
>>
>> If more people vote for full d-cache clean upon first run of VCPU then
>> we should revise this patch.
>
>
> That sounds a lot better than randomly flushing the dcache for no good
> reason. Most of the time, your MMU will be ON, and only the initial
> text/data loaded from userspace is at risk.
>
> But the userspace version sounds definitely better, and I'd like you to
> evaluate it before going the kernel way.

Considering the penalty, I like the approach of flushing d-cache by
set/way upon first run of VCPU because its just one time penalty.

>
> Thanks,
>
>
>         M.
> --
> Fast, cheap, reliable. Pick two.

--Anup
