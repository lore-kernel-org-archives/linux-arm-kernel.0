From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Fri, 6 Jul 2018 14:49:30 +0100
Subject: [PATCH v3 15/20] kvm: arm/arm64: Allow tuning the physical
 address size for VM
In-Reply-To: <12d1832a-1a13-7dd4-662b-addf58400789@arm.com>
References: <1530270944-11351-1-git-send-email-suzuki.poulose@arm.com>
 <1530270944-11351-16-git-send-email-suzuki.poulose@arm.com>
 <20180704155104.GN4828@arm.com>
 <12d1832a-1a13-7dd4-662b-addf58400789@arm.com>
Message-ID: <fe9f5aa5-b283-07e0-5f0e-e97d96b780e7@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/07/18 23:03, Suzuki K Poulose wrote:
> On 07/04/2018 04:51 PM, Will Deacon wrote:
>> Hi Suzuki,
>>
>> On Fri, Jun 29, 2018 at 12:15:35PM +0100, Suzuki K Poulose wrote:
>>> Allow specifying the physical address size for a new VM via
>>> the kvm_type argument for KVM_CREATE_VM ioctl. This allows
>>> us to finalise the stage2 page table format as early as possible
>>> and hence perform the right checks on the memory slots without
>>> complication. The size is encoded as Log2(PA_Size) in the bits[7:0]
>>> of the type field and can encode more information in the future if
>>> required. The IPA size is still capped at 40bits.
>>>
>>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>>> Cc: Christoffer Dall <cdall@kernel.org>
>>> Cc: Peter Maydel <peter.maydell@linaro.org>
>>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>>> Cc: Radim Kr?m?? <rkrcmar@redhat.com>
>>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>>> ---
>>> ? arch/arm/include/asm/kvm_mmu.h?? |? 2 ++
>>> ? arch/arm64/include/asm/kvm_arm.h | 10 +++-------
>>> ? arch/arm64/include/asm/kvm_mmu.h |? 2 ++
>>> ? include/uapi/linux/kvm.h???????? | 10 ++++++++++
>>> ? virt/kvm/arm/arm.c?????????????? | 24 ++++++++++++++++++++++--
>>> ? 5 files changed, 39 insertions(+), 9 deletions(-)
>>
>> [...]
>>
>>> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
>>> index 4df9bb6..fa4cab0 100644
>>> --- a/include/uapi/linux/kvm.h
>>> +++ b/include/uapi/linux/kvm.h
>>> @@ -751,6 +751,16 @@ struct kvm_ppc_resize_hpt {
>>> ? #define KVM_S390_SIE_PAGE_OFFSET 1
>>> ? /*
>>> + * On arm/arm64, machine type can be used to request the physical
>>> + * address size for the VM. Bits [7-0] have been reserved for the
>>> + * PA size shift (i.e, log2(PA_Size)). For backward compatibility,
>>> + * value 0 implies the default IPA size, which is 40bits.
>>> + */
>>> +#define KVM_VM_TYPE_ARM_PHYS_SHIFT_MASK??? 0xff
>>> +#define KVM_VM_TYPE_ARM_PHYS_SHIFT(x)??????? \
>>> +??? ((x) & KVM_VM_TYPE_ARM_PHYS_SHIFT_MASK)
>>
>> This seems like you're allocating quite a lot of bits in a non-extensible
>> interface to a fairly esoteric parameter. Would it be better to add another
>> ioctl, or condense the number of sizes you support instead?
> 
> As I explained in the other thread, we need the size as soon as the VM
> is created. The major challenge is keeping the backward compatibility by
> mapping 0 to 40bits. I will give it a thought.

Here is one option. We could re-use the {V}TCR_ELx.{I}PS field format, which
occupies 3 bits and has the following definitions. (ID_AA64MMFR0_EL1:PARange
also has the field definitions, except that the field is 4bits wide, but
only 3bits are used)

000 32 bits, 4GB.
001 36 bits, 64GB.
010 40 bits, 1TB.
011 42 bits, 4TB.
100 44 bits, 16TB.
101 48 bits, 256TB.
110 52 bits, 4PB

But we need to map 0 => 40bits IPA to make our ABI backward compatible. So
we could use the additional one bit to indicate that IPA size is requested
in the 3 bits.

i.e,

machine_type:

Bit [2:0]	- Requested IPA size. Values follow VTCR_EL2.PS format.

Bit [3]		- 1 => IPA Size bits (Bits[2:0]) requested.
		0 => Not requested

The only minor down side is restricting to the predefined values above,
which is not a real issue for a VM.

Thoughts ?

Suzuki
