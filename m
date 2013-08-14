From: maz@misterjones.org (Marc Zyngier)
Date: Wed, 14 Aug 2013 16:34:22 +0100
Subject: [PATCH] ARM64: KVM: Fix =?UTF-8?Q?coherent=5Ficache=5Fguest?=
 =?UTF-8?Q?=5Fpage=28=29=20for=20host=20with=20external=20L=33-cache=2E?=
In-Reply-To: <38A6DD0E-5639-43BB-8318-32D59923E309@suse.de>
References: <1376480832-18705-1-git-send-email-pranavkumar@linaro.org>
 <f8917fe8409b1fae634c7de45e34d4a7@www.loen.fr>
 <CAAhSdy2TctgKk7m48S7jUCMr2dkDoeyT-r=-SMX+_Ce-sUimYA@mail.gmail.com>
 <38A6DD0E-5639-43BB-8318-32D59923E309@suse.de>
Message-ID: <19553bad1c8427526f6e9a87d605ade3@www.loen.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013-08-14 16:06, Alexander Graf wrote:
> On 14.08.2013, at 16:22, Anup Patel wrote:
>
>> On Wed, Aug 14, 2013 at 5:34 PM, Marc Zyngier <marc.zyngier@arm.com> 
>> wrote:
>>> Hi Pranav,
>>>
>>> On 2013-08-14 12:47, Pranavkumar Sawargaonkar wrote:
>>>> Systems with large external L3-cache (few MBs), might have dirty
>>>> content belonging to the guest page in L3-cache. To tackle this,
>>>> we need to flush such dirty content from d-cache so that guest
>>>> will see correct contents of guest page when guest MMU is 
>>>> disabled.
>>>>
>>>> The patch fixes coherent_icache_guest_page() for external 
>>>> L3-cache.
>>>>
>>>> Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
>>>> Signed-off-by: Anup Patel <anup.patel@linaro.org>
>>>> ---
>>>> arch/arm64/include/asm/kvm_mmu.h |    2 ++
>>>> 1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/include/asm/kvm_mmu.h
>>>> b/arch/arm64/include/asm/kvm_mmu.h
>>>> index efe609c..5129038 100644
>>>> --- a/arch/arm64/include/asm/kvm_mmu.h
>>>> +++ b/arch/arm64/include/asm/kvm_mmu.h
>>>> @@ -123,6 +123,8 @@ static inline void
>>>> coherent_icache_guest_page(struct kvm *kvm, gfn_t gfn)
>>>>      if (!icache_is_aliasing()) {            /* PIPT */
>>>>              unsigned long hva = gfn_to_hva(kvm, gfn);
>>>>              flush_icache_range(hva, hva + PAGE_SIZE);
>>>> +             /* Flush d-cache for systems with external caches. 
>>>> */
>>>> +             __flush_dcache_area((void *) hva, PAGE_SIZE);
>>>>      } else if (!icache_is_aivivt()) {       /* non ASID-tagged 
>>>> VIVT */
>>>>              /* any kind of VIPT cache */
>>>>              __flush_icache_all();
>>>
>>> [adding Will to the discussion as we talked about this in the past]
>>>
>>> That's definitely an issue, but I'm not sure the fix is to hit the 
>>> data
>>> cache on each page mapping. It looks overkill.
>>>
>>> Wouldn't it be enough to let userspace do the cache cleaning? 
>>> kvmtools
>>> knows which bits of the guest memory have been touched, and can do 
>>> a "DC
>>> DVAC" on this region.
>>
>> It seems a bit unnatural to have cache cleaning is user-space. I am 
>> sure
>> other architectures don't have such cache cleaning in user-space for 
>> KVM.
>
> Not sure I understand at which point you really need to make things
> coherent here. When you assign a new ASID because there could be 
> stale
> cache entries left from an old ASID run? Can't you just flush all
> caches when you overrun your ASID allocator?

First, a bit of terminology:
- ASIDs are used for userspace. KVM doesn't deal with those.
- VMIDs are used for VMs. That's what KVM deals with.

The issue here is that when the MMU is disabled, the access goes 
straight to RAM, bypassing the caches altogether (OK not completely 
true, but for the sake of the argument, that's close enough).

When userspace loads the kernel into memory, the kernel is not flushed 
to RAM, and may sit in the L3 cache if the cache is big enough. You 
end-up executing garbage... My proposed fix is to let kvmtool do the 
flushing, as we have userspace cache management operations for this 
exact purpose.

>>
>>>
>>> The alternative is do it in the kernel before running any vcpu - 
>>> but
>>> that's not very nice either (have to clean the whole of the guest
>>> memory, which makes a full dcache clean more appealing).
>>
>> Actually, cleaning full d-cache by set/way upon first run of VCPU 
>> was
>> our second option but current approach seemed very simple hence
>> we went for this.
>>
>> If more people vote for full d-cache clean upon first run of VCPU 
>> then
>> we should revise this patch.
>
> Is there any difference in performance between the 2 approaches?

dcache clean on each and every page being mapped in stage-2, versus a 
one-time penalty. Should be significant indeed.

But again, I'd like to see figures. What is the impact of each of the 3 
methods for various memory and cache sizes?

         M.
-- 
Who you jivin' with that Cosmik Debris?
