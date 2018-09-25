From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue, 25 Sep 2018 12:10:20 +0100
Subject: [PATCH v5 16/18] kvm: arm64: Set a limit on the IPA size
In-Reply-To: <d915accb-966f-5c3d-f969-45512ebd8ca5@redhat.com>
References: <20180917104144.19188-1-suzuki.poulose@arm.com>
 <20180917104144.19188-17-suzuki.poulose@arm.com>
 <d915accb-966f-5c3d-f969-45512ebd8ca5@redhat.com>
Message-ID: <57b0954d-9510-e0fd-45be-4191e9d58f00@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/25/2018 10:59 AM, Auger Eric wrote:
> Hi Suzuki,
> 
> On 9/17/18 12:41 PM, Suzuki K Poulose wrote:
>> So far we have restricted the IPA size of the VM to the default
>> value (40bits). Now that we can manage the IPA size per VM and
>> support dynamic stage2 page tables, we can allow VMs to have
>> larger IPA. This patch introduces a the maximum IPA size
>> supported on the host.
> to be reworded
>   This is decided by the following factors :

Sure


>> diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
>> index 51ecf0f7c912..76972b19bdd7 100644
>> --- a/arch/arm64/kvm/reset.c
>> +++ b/arch/arm64/kvm/reset.c
>> @@ -34,6 +34,9 @@
>>   #include <asm/kvm_coproc.h>
>>   #include <asm/kvm_mmu.h>
>>   
>> +/* Maximum phys_shift supported for any VM on this host */
>> +static u32 kvm_ipa_limit;
>> +
>>   /*
>>    * ARMv8 Reset Values
>>    */
>> @@ -135,6 +138,46 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
>>   	return kvm_timer_vcpu_reset(vcpu);
>>   }
>>   
>> +void kvm_set_ipa_limit(void)
>> +{
>> +	unsigned int ipa_max, va_max, parange;
>> +
>> +	parange = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1) & 0x7;
>> +	ipa_max = id_aa64mmfr0_parange_to_phys_shift(parange);
>> +
>> +	/* Raise the limit to the default size for backward compatibility */
>> +	if (ipa_max < KVM_PHYS_SHIFT) {
>> +		WARN_ONCE(1,
>> +			  "PARange is %d bits, unsupported configuration!",
>> +			  ipa_max);
>> +		ipa_max = KVM_PHYS_SHIFT;
> I don't really get what does happen in this case. The CPU cannot handle
> PA up to ipa_max so can the VM run properly? In case it is a
> showstopper, kvm_set_ipa_limit should return an error, cascaded by
> init_common_resources. Otherwise the warning message may be reworded.

I think this was a warning added to warn against the older
Foundation model which had a 36bit PA size. So the VTCR was progammed
with a 36bit limit, while the KVM guest was allowed to create 40bit
IPA space, though it wouldn't fly well if someone tried to.

With this series, I think we may expose the real IPA_MAX (which could
be < 40bit) and warn the user if someone tried to create a VM with
40bit IPA (vm_type == 0) and let the call succeed (for the sake of ABI).

Marc, Christoffer, Eric

Thoughts ?

>> +	}
>> +
>> +	/* Clamp it to the PA size supported by the kernel */
>> +	ipa_max = (ipa_max > PHYS_MASK_SHIFT) ? PHYS_MASK_SHIFT : ipa_max;
>> +	/*
>> +	 * Since our stage2 table is dependent on the stage1 page table code,
>> +	 * we must always honor the following condition:
>> +	 *
>> +	 *  Number of levels in Stage1 >= Number of levels in Stage2.
>> +	 *
>> +	 * So clamp the ipa limit further down to limit the number of levels.
>> +	 * Since we can concatenate upto 16 tables at entry level, we could
>> +	 * go upto 4bits above the maximum VA addressible with the current
> addressable?

Sure

>> +	 * number of levels.
>> +	 */
>> +	va_max = PGDIR_SHIFT + PAGE_SHIFT - 3;
>> +	va_max += 4;
>> +
>> +	if (va_max < ipa_max) {
>> +		kvm_info("Limiting IPA limit to %dbytes due to host VA bits limitation\n",
>> +			 va_max);
>> +		ipa_max = va_max;
> you have a trace for this limitation but none for the comparison against
> PHYS_MASK_SHIFT.

May be I could add a message which only mentions what is the limiting
factor kernel VA vs kernel PA support

>> +	}
>> +
>> +	kvm_ipa_limit = ipa_max;
>> +}
>> +
>>   /*
>>    * Configure the VTCR_EL2 for this VM. The VTCR value is common
>>    * across all the physical CPUs on the system. We use system wide
>> diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
>> index 43e716bc3f08..631f9a3ad99a 100644
>> --- a/virt/kvm/arm/arm.c
>> +++ b/virt/kvm/arm/arm.c
>> @@ -1413,6 +1413,8 @@ static int init_common_resources(void)
>>   	kvm_vmid_bits = kvm_get_vmid_bits();
>>   	kvm_info("%d-bit VMID\n", kvm_vmid_bits);
>>   
>> +	kvm_set_ipa_limit();
> As we have a kvm_info for the supported vmid_bits, may be good to output
> the max IPA size supported by the host whatever the applied clamps?

Sure, will do that.

Thanks
Suzuki
