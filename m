From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sat, 13 Sep 2014 13:15:45 +0200
Subject: [PATCH 1/2] ARM: kvm: define PAGE_S2_DEVICE as read-only by
 default
In-Reply-To: <bcbc1c52f9e1eeb24f0bd1956236f0a3@www.loen.fr>
References: <1410603462-28900-1-git-send-email-ard.biesheuvel@linaro.org>
 <bcbc1c52f9e1eeb24f0bd1956236f0a3@www.loen.fr>
Message-ID: <CAKv+Gu8J8o2=CS9tGVbkavHep6gNwSSegZ0fxqsVE2AVDVzdpA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 September 2014 12:41, Marc Zyngier <marc.zyngier@arm.com> wrote:
> Hi Ard,
>
> On 2014-09-13 11:17, Ard Biesheuvel wrote:
>>
>> Now that we support read-only memslots, we need to make sure that
>> pass-through device mappings are not mapped writable if the guest
>> has requested them to be read-only. The existing implementation
>> already honours this by calling kvm_set_s2pte_writable() on the new
>> pte in case of writable mappings, so all we need to do is define
>> the default pgprot_t value used for devices to be PTE_S2_RDONLY.
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>
>
> I feel very uncomfortable with this change. Why would we map a device RO? Is
> that only for completeness sake?
>

We would map a device RO so that QEMU (or whatever is managing KVM)
can emulate the writes. I don't have a clear cut use case, to be
honest, but setting up a writable mapping for a memslot that was
explicitly set up as read-only seems wrong in any case.

Note that the particular problem I was seeing was primarily caused by
kvm_is_mmio_pfn()'s false positive on the zero page, but it unveiled
this particular issue as well.

> Note that we also use PAGE_S2_DEVICE for things that are not mapped through
> a memslot, such as the GIC.
>

Yes, and I realize now that this breaks it.
My apologies: I have an additional patch locally that sets up MMIO
ranges in one go instead of faulting them in one page at a time as we
do now, and there the read-write case is handled correctly in
kvm_phys_addr_ioremap(). However, I thought it was better to send
these out separately first, but apparently not.

So if we can agree on whether or not MMIO backed mappings should be
read-write even if the memslot says no, I will follow up with a proper
series if there are still changes required.

-- 
Ard.


>
>> ---
>>  arch/arm/include/asm/pgtable.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/include/asm/pgtable.h
>> b/arch/arm/include/asm/pgtable.h
>> index 01baef07cd0c..92b2fbe18868 100644
>> --- a/arch/arm/include/asm/pgtable.h
>> +++ b/arch/arm/include/asm/pgtable.h
>> @@ -100,7 +100,7 @@ extern pgprot_t             pgprot_s2_device;
>>  #define PAGE_HYP               _MOD_PROT(pgprot_kernel, L_PTE_HYP)
>>  #define PAGE_HYP_DEVICE                _MOD_PROT(pgprot_hyp_device,
>> L_PTE_HYP)
>>  #define PAGE_S2                        _MOD_PROT(pgprot_s2,
>> L_PTE_S2_RDONLY)
>> -#define PAGE_S2_DEVICE         _MOD_PROT(pgprot_s2_device, L_PTE_S2_RDWR)
>> +#define PAGE_S2_DEVICE         _MOD_PROT(pgprot_s2_device,
>> L_PTE_S2_RDONLY)
>>
>>  #define __PAGE_NONE            __pgprot(_L_PTE_DEFAULT | L_PTE_RDONLY |
>> L_PTE_XN | L_PTE_NONE)
>>  #define __PAGE_SHARED          __pgprot(_L_PTE_DEFAULT | L_PTE_USER |
>> L_PTE_XN)
>
>
> --
> Fast, cheap, reliable. Pick two.
