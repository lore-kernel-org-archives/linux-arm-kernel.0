From: andre.przywara@arm.com (Andre Przywara)
Date: Wed, 18 May 2016 15:06:10 +0100
Subject: [PATCH v4 46/56] KVM: arm/arm64: vgic-new: Add userland access to
 VGIC dist registers
In-Reply-To: <20160518135724.GO3827@cbox>
References: <1463392481-26583-1-git-send-email-andre.przywara@arm.com>
 <1463392481-26583-47-git-send-email-andre.przywara@arm.com>
 <20160518135724.GO3827@cbox>
Message-ID: <573C76D2.3050906@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 18/05/16 14:57, Christoffer Dall wrote:
> On Mon, May 16, 2016 at 10:53:34AM +0100, Andre Przywara wrote:
>> Userland may want to save and restore the state of the in-kernel VGIC,
>> so we provide the code which takes a userland request and translate
>> that into calls to our MMIO framework.
>>
>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>> ---
>>  virt/kvm/arm/vgic/vgic-kvm-device.c | 50 ++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 49 insertions(+), 1 deletion(-)
>>
>> diff --git a/virt/kvm/arm/vgic/vgic-kvm-device.c b/virt/kvm/arm/vgic/vgic-kvm-device.c
>> index 78621283..c3ec453 100644
>> --- a/virt/kvm/arm/vgic/vgic-kvm-device.c
>> +++ b/virt/kvm/arm/vgic/vgic-kvm-device.c
>> @@ -238,7 +238,55 @@ static int vgic_attr_regs_access(struct kvm_device *dev,
>>  				 struct kvm_device_attr *attr,
>>  				 u32 *reg, bool is_write)
>>  {
>> -	return -ENXIO;
>> +	gpa_t addr;
>> +	int cpuid, ret, c;
>> +	struct kvm_vcpu *vcpu, *tmp_vcpu;
>> +
>> +	cpuid = (attr->attr & KVM_DEV_ARM_VGIC_CPUID_MASK) >>
>> +		 KVM_DEV_ARM_VGIC_CPUID_SHIFT;
>> +	vcpu = kvm_get_vcpu(dev->kvm, cpuid);
>> +	addr = attr->attr & KVM_DEV_ARM_VGIC_OFFSET_MASK;
>> +
>> +	mutex_lock(&dev->kvm->lock);
>> +
>> +	ret = vgic_init(dev->kvm);
>> +	if (ret)
>> +		goto out;
>> +
>> +	if (cpuid >= atomic_read(&dev->kvm->online_vcpus)) {
>> +		ret = -EINVAL;
>> +		goto out;
>> +	}
>> +
>> +	/*
>> +	 * Ensure that no other VCPU is running by checking the vcpu->cpu
>> +	 * field.  If no other VPCUs are running we can safely access the VGIC
>> +	 * state, because even if another VPU is run after this point, that
>> +	 * VCPU will not touch the vgic state, because it will block on
>> +	 * getting the vgic->lock in kvm_vgic_sync_hwstate().
>> +	 */
> 
> We still have a problem here.  Want me to write a patch?

Aargh, this somehow got lost in my pile of "comments to address", sorry!
Short answer: yes, please.
Last thing I did was following your suggestion from last time about
refactoring the check from kvm_vgic_create(): I think this doesn't help,
because it's only a check and we return -EBUSY or so instead of actually
enforcing VCPUs to exit. So if you could try to use your fancy new
make-the-guest-exit feature here?

Cheers,
Andre.

> -Christoffer
> 
>> +	kvm_for_each_vcpu(c, tmp_vcpu, dev->kvm) {
>> +		if (unlikely(tmp_vcpu->cpu != -1)) {
>> +			ret = -EBUSY;
>> +			goto out;
>> +		}
>> +	}
>> +
>> +	switch (attr->group) {
>> +	case KVM_DEV_ARM_VGIC_GRP_CPU_REGS:
>> +		ret = -EINVAL;
>> +		break;
>> +	case KVM_DEV_ARM_VGIC_GRP_DIST_REGS:
>> +		ret = vgic_v2_dist_uaccess(vcpu, is_write, addr, reg);
>> +		break;
>> +	default:
>> +		ret = -EINVAL;
>> +		break;
>> +	}
>> +
>> +out:
>> +	mutex_unlock(&dev->kvm->lock);
>> +	return ret;
>>  }
>>  
>>  /* V2 ops */
>> -- 
>> 2.8.2
>>
> 
