From: andre.przywara@arm.com (Andre Przywara)
Date: Mon, 05 Jan 2015 17:58:25 +0000
Subject: [PATCH v5 18/19] arm/arm64: KVM: enable kernel side of GICv3
 emulation
In-Reply-To: <20141213134237.GG16855@cbox>
References: <1418042274-3246-1-git-send-email-andre.przywara@arm.com>
 <1418042274-3246-19-git-send-email-andre.przywara@arm.com>
 <20141213134237.GG16855@cbox>
Message-ID: <54AAD0C1.4010105@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoffer,

On 13/12/14 13:42, Christoffer Dall wrote:
> On Mon, Dec 08, 2014 at 12:37:53PM +0000, Andre Przywara wrote:
>> With all the necessary GICv3 emulation code in place, we can now
>> connect the code to the GICv3 backend in the kernel.
>> The LR register handling is different depending on the emulated GIC
>> model, so provide different implementations for each.
>> Also allow non-v2-compatible GICv3 implementations (which don't
>> provide MMIO regions for the virtual CPU interface in the DT), but
>> restrict those hosts to support GICv3 guests only.
>>
>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>> ---
>> Changelog v4...v5:
>> - minor whitespace and comments fixes
>>
>> Changelog v3...v4:
>> - handle differences between GICv2-on-v3 and GICv3-on-v3 in existing functions
>> - remove init_*_emul() functions
>> - remove max_vcpus setting (done in earlier patches now)
>> - adapt to new vgic_v<n>_init_emulation behaviour
>>
>>  virt/kvm/arm/vgic-v3.c |   84 ++++++++++++++++++++++++++++++++----------------
>>  virt/kvm/arm/vgic.c    |    5 +++
>>  2 files changed, 61 insertions(+), 28 deletions(-)
>>
>> diff --git a/virt/kvm/arm/vgic-v3.c b/virt/kvm/arm/vgic-v3.c
>> index 5249048..88e2ed8 100644
>> --- a/virt/kvm/arm/vgic-v3.c
>> +++ b/virt/kvm/arm/vgic-v3.c
>> @@ -34,6 +34,7 @@
>>  #define GICH_LR_VIRTUALID		(0x3ffUL << 0)
>>  #define GICH_LR_PHYSID_CPUID_SHIFT	(10)
>>  #define GICH_LR_PHYSID_CPUID		(7UL << GICH_LR_PHYSID_CPUID_SHIFT)
>> +#define ICH_LR_VIRTUALID_MASK		(BIT_ULL(32) - 1)
>>  
>>  /*
>>   * LRs are stored in reverse order in memory. make sure we index them
>> @@ -48,12 +49,17 @@ static struct vgic_lr vgic_v3_get_lr(const struct kvm_vcpu *vcpu, int lr)
>>  	struct vgic_lr lr_desc;
>>  	u64 val = vcpu->arch.vgic_cpu.vgic_v3.vgic_lr[LR_INDEX(lr)];
>>  
>> -	lr_desc.irq	= val & GICH_LR_VIRTUALID;
>> -	if (lr_desc.irq <= 15)
>> -		lr_desc.source	= (val >> GICH_LR_PHYSID_CPUID_SHIFT) & 0x7;
>> +	if (vcpu->kvm->arch.vgic.vgic_model == KVM_DEV_TYPE_ARM_VGIC_V3)
>> +		lr_desc.irq = val & ICH_LR_VIRTUALID_MASK;
>>  	else
>> -		lr_desc.source = 0;
>> -	lr_desc.state	= 0;
>> +		lr_desc.irq = val & GICH_LR_VIRTUALID;
>> +
>> +	lr_desc.source = 0;
>> +	if (lr_desc.irq <= 15 &&
>> +	    vcpu->kvm->arch.vgic.vgic_model == KVM_DEV_TYPE_ARM_VGIC_V2)
>> +		lr_desc.source = (val >> GICH_LR_PHYSID_CPUID_SHIFT) & 0x7;
>> +
>> +	lr_desc.state = 0;
>>  
>>  	if (val & ICH_LR_PENDING_BIT)
>>  		lr_desc.state |= LR_STATE_PENDING;
>> @@ -68,8 +74,20 @@ static struct vgic_lr vgic_v3_get_lr(const struct kvm_vcpu *vcpu, int lr)
>>  static void vgic_v3_set_lr(struct kvm_vcpu *vcpu, int lr,
>>  			   struct vgic_lr lr_desc)
>>  {
>> -	u64 lr_val = (((u32)lr_desc.source << GICH_LR_PHYSID_CPUID_SHIFT) |
>> -		      lr_desc.irq);
>> +	u64 lr_val;
>> +
>> +	lr_val = lr_desc.irq;
>> +
>> +	/*
>> +	 * Currently all guest IRQs are Group1, as Group0 would result
>> +	 * in a FIQ in the guest, which it wouldn't expect.
>> +	 * Eventually we want to make this configurable, so we may revisit
>> +	 * this in the future.
>> +	 */
>> +	if (vcpu->kvm->arch.vgic.vgic_model == KVM_DEV_TYPE_ARM_VGIC_V3)
>> +		lr_val |= ICH_LR_GROUP;
>> +	else
>> +		lr_val |= (u32)lr_desc.source << GICH_LR_PHYSID_CPUID_SHIFT;
>>  
>>  	if (lr_desc.state & LR_STATE_PENDING)
>>  		lr_val |= ICH_LR_PENDING_BIT;
>> @@ -154,7 +172,15 @@ static void vgic_v3_enable(struct kvm_vcpu *vcpu)
>>  	 */
>>  	vgic_v3->vgic_vmcr = 0;
>>  
>> -	vgic_v3->vgic_sre = 0;
>> +	/*
>> +	 * If we are emulating a GICv3, we do it in an non-GICv2-compatible
>> +	 * way, so we force SRE to 1 to demonstrate this to the guest.
>> +	 * This goes with the spec allowing the value to be RAO/WI.
>> +	 */
>> +	if (vcpu->kvm->arch.vgic.vgic_model == KVM_DEV_TYPE_ARM_VGIC_V3)
>> +		vgic_v3->vgic_sre = ICC_SRE_EL1_SRE;
>> +	else
>> +		vgic_v3->vgic_sre = 0;
>>  
>>  	/* Get the show on the road... */
>>  	vgic_v3->vgic_hcr = ICH_HCR_EN;
>> @@ -215,28 +241,30 @@ int vgic_v3_probe(struct device_node *vgic_node,
>>  
>>  	gicv_idx += 3; /* Also skip GICD, GICC, GICH */
>>  	if (of_address_to_resource(vgic_node, gicv_idx, &vcpu_res)) {
>> -		kvm_err("Cannot obtain GICV region\n");
>> -		ret = -ENXIO;
>> -		goto out;
>> -	}
>> -
>> -	if (!PAGE_ALIGNED(vcpu_res.start)) {
>> -		kvm_err("GICV physical address 0x%llx not page aligned\n",
>> -			(unsigned long long)vcpu_res.start);
>> -		ret = -ENXIO;
>> -		goto out;
>> -	}
>> -
>> -	if (!PAGE_ALIGNED(resource_size(&vcpu_res))) {
>> -		kvm_err("GICV size 0x%llx not a multiple of page size 0x%lx\n",
>> -			(unsigned long long)resource_size(&vcpu_res),
>> -			PAGE_SIZE);
>> -		ret = -ENXIO;
>> -		goto out;
>> +		kvm_info("GICv3: GICv2 emulation not available\n");
>> +		vgic->vcpu_base = 0;
>> +	} else {
>> +		if (!PAGE_ALIGNED(vcpu_res.start)) {
>> +			kvm_err("GICV physical address 0x%llx not page aligned\n",
>> +				(unsigned long long)vcpu_res.start);
>> +			ret = -ENXIO;
>> +			goto out;
>> +		}
>> +
>> +		if (!PAGE_ALIGNED(resource_size(&vcpu_res))) {
>> +			kvm_err("GICV size 0x%llx not a multiple of page size 0x%lx\n",
>> +				(unsigned long long)resource_size(&vcpu_res),
>> +				PAGE_SIZE);
>> +			ret = -ENXIO;
>> +			goto out;
>> +		}
> 
> I still think this is wrong. Why whouldn't a user create be able to
> create a virtual GICv3 with the system register interface just because
> the GICv2 addresss are not aligned correctly?
> 
> Unless someone has a good technical argument for why something is likely
> to break, we should aim for supporting as many platforms as possible, so
> please change the error outs here to warnings and proceed with
> registering the v3 ops.

OK, I changed this as suggested.

I had some trouble with rebasing and testing on top of v3.19-rc, so v6
couldn't hit the list still last year. But expect it there anytime soon.

Happy New Year!
Andre.
