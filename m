From: agraf@suse.de (Alexander Graf)
Date: Thu, 26 Sep 2013 00:37:03 +0200
Subject: [PATCH 8/8] KVM: arm-vgic: Support CPU interface reg access
In-Reply-To: <20130925211150.GH32311@cbox>
References: <1377285606-15692-1-git-send-email-christoffer.dall@linaro.org>
 <1377285606-15692-9-git-send-email-christoffer.dall@linaro.org>
 <05BF567A-DD8A-4226-A51F-0D661F4D7EB2@suse.de> <20130925211150.GH32311@cbox>
Message-ID: <BD74C365-718A-4946-AC27-21BADEF6F0DC@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 25.09.2013, at 23:30, Christoffer Dall wrote:

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
> 
> Would this be satisfying?
> 
> 
> diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
> index 5214424..558be38 100644
> --- a/virt/kvm/arm/vgic.c
> +++ b/virt/kvm/arm/vgic.c
> @@ -71,6 +71,9 @@
> #define VGIC_ADDR_UNDEF		(-1)
> #define IS_VGIC_ADDR_UNDEF(_x)  ((_x) == VGIC_ADDR_UNDEF)
> 
> +#define GIC_PRODUCT_ID		0x4b0

This is a specific GIC version. PL390 for example is 0x3b0:

  http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0416b/Beiggeba.html

That should be reflected in the #define. If it means "GICv2" then it should be GICV2_PRODUCT_ID for example.

> +#define ARM_JEP106_IMPLEMENTER	0x43b

I think naming this JEP106_IMPLEMENTER_ARM makes it more obvious that we're talking about the implementer code for ARM. Or maybe just only IMPLEMENTER_ARM.

> +
> /* Physical address of vgic virtual cpu interface */
> static phys_addr_t vgic_vcpu_base;
> 
> @@ -331,7 +334,7 @@ static bool handle_mmio_misc(struct kvm_vcpu *vcpu,
> 		break;
> 
> 	case 8:			/* IIDR */
> -		reg = 0x4B00043B;
> +		reg = (GIC_PRODUCT_ID << 20) | ARM_JEP106_IMPLEMENTER;
> 		vgic_reg_access(mmio, &reg, word_offset,
> 				ACCESS_READ_VALUE | ACCESS_WRITE_IGNORED);
> 		break;
> @@ -1734,7 +1737,7 @@ static bool handle_cpu_mmio_ident(struct kvm_vcpu *vcpu,
> 	if (mmio->is_write)
> 		return false;
> 
> -	reg = 0x0002043B;
> +	reg = (GIC_PRODUCT_ID << 20) | (0x2 << 16) | ARM_JEP106_IMPLEMENTER;

What is the 0x2 here?


Alex

> 	mmio_data_write(mmio, ~0, reg);
> 	return false;
> }
> 
> Thanks,
> -Christoffer
