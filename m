From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Mon, 3 Sep 2018 11:14:13 +0100
Subject: [PATCH v4 20/20] kvm: arm64: Allow tuning the physical address
 size for VM
In-Reply-To: <20180830124054.GE4029@e113682-lin.lund.arm.com>
References: <1531905547-25478-1-git-send-email-suzuki.poulose@arm.com>
 <1531905547-25478-21-git-send-email-suzuki.poulose@arm.com>
 <20180830124054.GE4029@e113682-lin.lund.arm.com>
Message-ID: <849af220-8be2-9d4c-fb82-778348717f90@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoffer,

On 30/08/18 13:40, Christoffer Dall wrote:
> Hi Suzuki,
> 
> On Wed, Jul 18, 2018 at 10:19:03AM +0100, Suzuki K Poulose wrote:
>> Allow specifying the physical address size limit for a new
>> VM via the kvm_type argument for the KVM_CREATE_VM ioctl. This
>> allows us to finalise the stage2 page table as early as possible
>> and hence perform the right checks on the memory slots
>> without complication. The size is ecnoded as Log2(PA_Size) in
>> bits[7:0] of the type field. For backward compatibility the
>> value 0 is reserved and implies 40bits. Also, lift the limit
>> of the IPA to host limit and allow lower IPA sizes (e.g, 32).
>>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> Cc: Christoffer Dall <cdall@kernel.org>
>> Cc: Peter Maydel <peter.maydell@linaro.org>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Radim Kr?m?? <rkrcmar@redhat.com>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>> All,
>>
>> This is not the final API. We are still evaluating the possible
>> options to create a VM and then configure the VM before any
>> resources can be allocated (e.g, devices, vCPUs or memory).
>> See [0] for discussion:
>>
>> [0] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-July/587839.html
> 
> FWIW, I think encoding the size in the type isn't that bad, as it seems
> in the worst case we'll occupy 24 bits out of the 64-bit type argument
> at the time being (IPA+SVE), and that's several years into KVM/ARM's
> life time.

I had a discussion with Dave and it looks like we don't need special bits
in the VM type for SVE. We should be able to manage it per VCPU. So it is
just the IPA that needs it for now. Also, we could squeeze the IPA config
to 6bits if needed.

> 
> I'm sure we'll need a more sophisticated API some day, when we
> absolutely cannot easily use what we already have, but we can add that
> API at the time.

True.

> 
>> ---
>>   Documentation/virtual/kvm/api.txt       |  4 ++++
>>   arch/arm64/include/asm/stage2_pgtable.h | 20 --------------------
>>   arch/arm64/kvm/guest.c                  |  3 ---
>>   include/uapi/linux/kvm.h                |  9 +++++++++
>>   virt/kvm/arm/arm.c                      | 16 ++++++++++++----
>>   5 files changed, 25 insertions(+), 27 deletions(-)
>>

>> -/*
>> - * With all the supported VA_BITs and 40bit guest IPA, the following condition
>> - * is always true:
>> - *
>> - *       STAGE2_PGTABLE_LEVELS <= CONFIG_PGTABLE_LEVELS
>> - *
>> - * We base our stage-2 page table walker helpers on this assumption and
>> - * fall back to using the host version of the helper wherever possible.
>> - * i.e, if a particular level is not folded (e.g, PUD) at stage2, we fall back
>> - * to using the host version, since it is guaranteed it is not folded at host.
>> - *
>> - * If the condition breaks in the future, we can rearrange the host level
>> - * definitions and reuse them for stage2. Till then...
>> - */
>> -#if STAGE2_PGTABLE_LEVELS > CONFIG_PGTABLE_LEVELS
>> -#error "Unsupported combination of guest IPA and host VA_BITS."
>> -#endif
>> -
>> -
>>   /* stage2_pgdir_shift() is the size mapped by top-level stage2 entry for the VM */
>>   #define stage2_pgdir_shift(kvm)		pt_levels_pgdir_shift(kvm_stage2_levels(kvm))
>>   #define stage2_pgdir_size(kvm)		(1ULL << stage2_pgdir_shift(kvm))
>> diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
>> index 142e610..66fb20c 100644
>> --- a/arch/arm64/kvm/guest.c
>> +++ b/arch/arm64/kvm/guest.c
>> @@ -475,9 +475,6 @@ int kvm_arm_config_vm(struct kvm *kvm, u32 ipa_shift)
>>   	u64 parange;
>>   	u8 lvls = stage2_pgtable_levels(ipa_shift);
>>   
>> -	if (ipa_shift != KVM_PHYS_SHIFT)
>> -		return -EINVAL;
>> -
>>   	/*
>>   	 * Use a minimum 2 level page table to prevent splitting
>>   	 * host PMD huge pages at stage2.
>> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
>> index 9a40d82..625a11e 100644
>> --- a/include/uapi/linux/kvm.h
>> +++ b/include/uapi/linux/kvm.h
>> @@ -751,6 +751,15 @@ struct kvm_ppc_resize_hpt {
>>   #define KVM_S390_SIE_PAGE_OFFSET 1
>>   
>>   /*
>> + * On arm/arm64, machine type cane be used to request the physical
> 
> nit: s/cane/can/

Thanks for spotting, will fix it.


Thanks for the review.

Suzuki
