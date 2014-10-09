From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 9 Oct 2014 15:10:08 +0200
Subject: [PATCH 2/6] arm/arm64: KVM: fix potential NULL dereference in
 user_mem_abort()
In-Reply-To: <543687FD.2020504@arm.com>
References: <1410990981-665-1-git-send-email-ard.biesheuvel@linaro.org>
 <1410990981-665-3-git-send-email-ard.biesheuvel@linaro.org>
 <543687FD.2020504@arm.com>
Message-ID: <CAKv+Gu91GFy=K=_oe6iSF9jG0_VwOw3T8=vX0S4vN8Ah4=s8MQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9 October 2014 15:05, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 17/09/14 22:56, Ard Biesheuvel wrote:
>> Handle the potential NULL return value of find_vma_intersection()
>> before dereferencing it.
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>>  arch/arm/kvm/mmu.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
>> index 152e0f896e63..c093e95ff7ef 100644
>> --- a/arch/arm/kvm/mmu.c
>> +++ b/arch/arm/kvm/mmu.c
>> @@ -776,7 +776,11 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>>       /* Let's check if we will get back a huge page backed by hugetlbfs */
>>       down_read(&current->mm->mmap_sem);
>>       vma = find_vma_intersection(current->mm, hva, hva + 1);
>> -     if (is_vm_hugetlb_page(vma)) {
>> +     if (unlikely(!vma)) {
>> +             kvm_err("Failed to find VMA for hva 0x%lx\n", hva);
>> +             up_read(&current->mm->mmap_sem);
>> +             return -EFAULT;
>> +     } else if (is_vm_hugetlb_page(vma)) {
>
> I'm not overly fond of this "else if" construct. The !vma case is final,
> so what's after cannot be reached.
>

I don't have a strong preference either way. I can respin but perhaps
Christoffer can fix it up when applying?

>>               hugetlb = true;
>>               gfn = (fault_ipa & PMD_MASK) >> PAGE_SHIFT;
>>       } else {
>>
>
> Despite the above nit:
>
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
>

Thanks.
