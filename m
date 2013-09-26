From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 26 Sep 2013 11:47:28 +0100
Subject: [PATCH 8/8] KVM: arm-vgic: Support CPU interface reg access
In-Reply-To: <20130925211150.GH32311@cbox>
References: <1377285606-15692-1-git-send-email-christoffer.dall@linaro.org>
 <1377285606-15692-9-git-send-email-christoffer.dall@linaro.org>
 <05BF567A-DD8A-4226-A51F-0D661F4D7EB2@suse.de> <20130925211150.GH32311@cbox>
Message-ID: <524410C0.6020201@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/09/13 22:30, Christoffer Dall wrote:
> On Sun, Aug 25, 2013 at 04:24:20PM +0100, Alexander Graf wrote:
>>
>> On 23.08.2013, at 20:20, Christoffer Dall wrote:
>>
>>> Implement support for the CPU interface register access driven by MMIO
>>> address offsets from the CPU interface base address.  Useful for user
>>> space to support save/restore of the VGIC state.
>>>
>>> This commit adds support only for the same logic as the current VGIC
>>> support, and no more.  For example, the active priority registers are
>>> handled as RAZ/WI, just like setting priorities on the emulated
>>> distributor.
>>>
>>> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
>>> ---
>>> virt/kvm/arm/vgic.c |   66 +++++++++++++++++++++++++++++++++++++++++++++++----
>>> 1 file changed, 62 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
>>> index d44b5a1..257dbae 100644
>>> --- a/virt/kvm/arm/vgic.c
>>> +++ b/virt/kvm/arm/vgic.c
>>> @@ -1684,9 +1684,67 @@ int kvm_vgic_addr(struct kvm *kvm, unsigned long type, u64 *addr, bool write)
>>> static bool handle_cpu_mmio_misc(struct kvm_vcpu *vcpu,
>>> 				 struct kvm_exit_mmio *mmio, phys_addr_t offset)
>>> {
>>> -	return true;
>>> +	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
>>> +	u32 reg, mask = 0, shift = 0;
>>> +	bool updated = false;
>>> +
>>> +	switch (offset & ~0x3) {
>>> +	case GIC_CPU_CTRL:
>>> +		mask = GICH_VMCR_CTRL_MASK;
>>> +		shift = GICH_VMCR_CTRL_SHIFT;
>>> +		break;
>>> +	case GIC_CPU_PRIMASK:
>>> +		mask = GICH_VMCR_PRIMASK_MASK;
>>> +		shift = GICH_VMCR_PRIMASK_SHIFT;
>>> +		break;
>>> +	case GIC_CPU_BINPOINT:
>>> +		mask = GICH_VMCR_BINPOINT_MASK;
>>> +		shift = GICH_VMCR_BINPOINT_SHIFT;
>>> +		break;
>>> +	case GIC_CPU_ALIAS_BINPOINT:
>>> +		mask = GICH_VMCR_ALIAS_BINPOINT_MASK;
>>> +		shift = GICH_VMCR_ALIAS_BINPOINT_SHIFT;
>>> +		break;
>>> +	}
>>> +
>>> +	if (!mmio->is_write) {
>>> +		reg = (vgic_cpu->vgic_vmcr & mask) >> shift;
>>> +		memcpy(mmio->data, &reg, sizeof(reg));
>>> +	} else {
>>> +		memcpy(&reg, mmio->data, sizeof(reg));
>>> +		reg = (reg << shift) & mask;
>>> +		if (reg != (vgic_cpu->vgic_vmcr & mask))
>>> +			updated = true;
>>> +		vgic_cpu->vgic_vmcr &= ~mask;
>>> +		vgic_cpu->vgic_vmcr |= reg;
>>> +	}
>>> +	return updated;
>>> +}
>>> +
>>> +static bool handle_mmio_abpr(struct kvm_vcpu *vcpu,
>>> +			     struct kvm_exit_mmio *mmio, phys_addr_t offset)
>>> +{
>>> +	return handle_cpu_mmio_misc(vcpu, mmio, GIC_CPU_ALIAS_BINPOINT);
>>> +}
>>> +
>>> +static bool handle_cpu_mmio_ident(struct kvm_vcpu *vcpu,
>>> +				  struct kvm_exit_mmio *mmio,
>>> +				  phys_addr_t offset)
>>> +{
>>> +	u32 reg;
>>> +
>>> +	if (mmio->is_write)
>>> +		return false;
>>> +
>>> +	reg = 0x0002043B;
>>
>> This wants a comment and probably also a #define :).
>>
> 
> Marc, where does the 0x4b0 product id code come from for the distributor
> IIDR?

0x4B is the ASCII value for 'K', and the whole thing is intended to read
as KVM/ARM. Call that a feeble attempt at an Easter Egg.

I'd very much refrain from pretending we emulate an existing GICv2
implementation, as the damned thing is behaving very differently from
the hardware.

	M.
-- 
Jazz is not dead. It just smells funny...
