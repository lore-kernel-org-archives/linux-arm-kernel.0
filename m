From: anup@brainfault.org (Anup Patel)
Date: Wed, 14 Aug 2013 20:05:32 +0530
Subject: [PATCH] ARM64: KVM: Fix coherent_icache_guest_page() for host
 with external L3-cache.
In-Reply-To: <520B92DB.5070708@arm.com>
References: <1376480832-18705-1-git-send-email-pranavkumar@linaro.org>
 <520B92DB.5070708@arm.com>
Message-ID: <CAAhSdy2NPaCWPc-TJ8AVhwmDUT+eWXOGbF2Dm+v781pYTQBhCg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 14, 2013 at 7:53 PM, Sudeep KarkadaNagesha
<Sudeep.KarkadaNagesha@arm.com> wrote:
> On 14/08/13 12:47, Pranavkumar Sawargaonkar wrote:
>> Systems with large external L3-cache (few MBs), might have dirty
>> content belonging to the guest page in L3-cache. To tackle this,
>> we need to flush such dirty content from d-cache so that guest
>> will see correct contents of guest page when guest MMU is disabled.
>>
>> The patch fixes coherent_icache_guest_page() for external L3-cache.
>>
>
> I don't understand KVM but the commit message caught my attention.
>
> You are referring to clean the external/outer L3 cache but using
> internal cache maintenance APIs. You should be using outer_cache APIs if
> you really intend to do outer cache maintenance ?
> Is the external/outer L3 cache not unified ?
>
> Or did you mean to flush d-cache to the point of coherency(external L3
> in your case)? If so it's not clear from the commit log.

Yes, we mean to flush d-cache to the point of coherency (which in our
case is external L3-cache).

The patch description is more in-terms of KVM virtualization but, we
can certainly add more details.

>
> Regards,
> Sudeep
>
>> Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
>> Signed-off-by: Anup Patel <anup.patel@linaro.org>
>> ---
>>  arch/arm64/include/asm/kvm_mmu.h |    2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
>> index efe609c..5129038 100644
>> --- a/arch/arm64/include/asm/kvm_mmu.h
>> +++ b/arch/arm64/include/asm/kvm_mmu.h
>> @@ -123,6 +123,8 @@ static inline void coherent_icache_guest_page(struct kvm *kvm, gfn_t gfn)
>>       if (!icache_is_aliasing()) {            /* PIPT */
>>               unsigned long hva = gfn_to_hva(kvm, gfn);
>>               flush_icache_range(hva, hva + PAGE_SIZE);
>> +             /* Flush d-cache for systems with external caches. */
>> +             __flush_dcache_area((void *) hva, PAGE_SIZE);
>>       } else if (!icache_is_aivivt()) {       /* non ASID-tagged VIVT */
>>               /* any kind of VIPT cache */
>>               __flush_icache_all();
>>
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Regards,
Anup
