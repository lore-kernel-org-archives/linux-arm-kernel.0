From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 1 Mar 2018 21:50:22 +0000
Subject: [PATCH] KVM: arm/arm64: drop pr_info() of IDMAP page
In-Reply-To: <86sh9j33j3.wl-marc.zyngier@arm.com>
References: <20180301191406.18083-1-ard.biesheuvel@linaro.org>
 <86sh9j33j3.wl-marc.zyngier@arm.com>
Message-ID: <CAKv+Gu90wnrXpGOrXXTjxfoWRDDdVzLfiseR6XpqtWdbWTmZow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 March 2018 at 21:10, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On Thu, 01 Mar 2018 19:14:06 +0000,
> Ard Biesheuvel wrote:
>>
>> The KVM IDMAP is a mapping of a statically allocated kernel structure,
>> and so printing its physical address leaks the physical placement of
>> the kernel when physical KASLR is in effect. Just remove it, nobody
>> except Marc needs this anyway.
>
> Bah, even I don't really need it anymore...
>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>> CC -stable?
>
> In this day and age, probably.
>
>>
>>  virt/kvm/arm/mmu.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
>> index ec62d1cccab7..c07f88cb6dcf 100644
>> --- a/virt/kvm/arm/mmu.c
>> +++ b/virt/kvm/arm/mmu.c
>> @@ -1810,7 +1810,6 @@ int kvm_mmu_init(void)
>>        */
>>       BUG_ON((hyp_idmap_start ^ (hyp_idmap_end - 1)) & PAGE_MASK);
>>
>> -     kvm_info("IDMAP page: %lx\n", hyp_idmap_start);
>>       kvm_info("HYP VA range: %lx:%lx\n",
>>                kern_hyp_va(PAGE_OFFSET), kern_hyp_va(~0UL));
>
> Instead of removing this particular line, how about turning all these
> kvm_info into kvm_debug (see [1])?
>

Yeah makes sense. Of the complete output

[    2.046066] kvm [1]: 8-bit VMID
[    2.046072] kvm [1]: IDMAP page: d20e35000
[    2.046077] kvm [1]: HYP VA range: 800000000000:ffffffffffff
[    2.046888] kvm [1]: vgic-v2 at 2c020000
[    2.046944] kvm [1]: GIC system register CPU interface enabled
[    2.047585] kvm [1]: vgic interrupt IRQ1
[    2.047603] kvm [1]: virtual timer IRQ4
[    2.048282] kvm [1]: Hyp mode initialized successfully

I think only the first and the last one are useful, and perhaps the
one about the sysreg interface?
