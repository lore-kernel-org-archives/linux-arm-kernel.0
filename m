From: andre.przywara@arm.com (Andre Przywara)
Date: Mon, 10 Nov 2014 12:26:28 +0000
Subject: [PATCH v3 19/19] arm/arm64: KVM: allow userland to request a
 virtual GICv3
In-Reply-To: <20141107161546.GU16132@cbox>
References: <1414776414-13426-1-git-send-email-andre.przywara@arm.com>
 <1414776414-13426-20-git-send-email-andre.przywara@arm.com>
 <20141107161546.GU16132@cbox>
Message-ID: <5460AEF4.3030407@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hej Christoffer,

On 07/11/14 16:15, Christoffer Dall wrote:
> On Fri, Oct 31, 2014 at 05:26:54PM +0000, Andre Przywara wrote:
>> With everything in place we allow userland to request the kernel
>> using a virtual GICv3 in the guest, which finally lifts the 8 vCPU
>> limit for a guest.
> 
> You're actually not explicitly allowing this in this patch, you're
> implicitly allowing it because init would fail without the vgic
> distributor base address being set already.
> 
> Either re-arrange your patches or fix the commit message.

The latter ;-)

>> Also we provide the necessary support for guests setting the memory
>> addresses for the virtual distributor and redistributors.
>> This requires some userland code to make use of that feature and
>> explicitly ask for a virtual GICv3.
> 
> You need to add documentation for this new device type and the userspace
> ABI.

Will do.

>>
>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>> ---
>>  arch/arm64/include/uapi/asm/kvm.h |    7 ++++++
>>  include/kvm/arm_vgic.h            |    4 ++--
>>  virt/kvm/arm/vgic-v3-emul.c       |    3 +++
>>  virt/kvm/arm/vgic.c               |   46 ++++++++++++++++++++++++++-----------
>>  4 files changed, 45 insertions(+), 15 deletions(-)
>>
>> diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
>> index 8e38878..2ed873a 100644
>> --- a/arch/arm64/include/uapi/asm/kvm.h
>> +++ b/arch/arm64/include/uapi/asm/kvm.h
>> @@ -78,6 +78,13 @@ struct kvm_regs {
>>  #define KVM_VGIC_V2_DIST_SIZE		0x1000
>>  #define KVM_VGIC_V2_CPU_SIZE		0x2000
>>  
>> +/* Supported VGICv3 address types  */
>> +#define KVM_VGIC_V3_ADDR_TYPE_DIST	2
>> +#define KVM_VGIC_V3_ADDR_TYPE_REDIST	3
>> +
>> +#define KVM_VGIC_V3_DIST_SIZE		SZ_64K
>> +#define KVM_VGIC_V3_REDIST_SIZE		(2 * SZ_64K)
>> +
>>  #define KVM_ARM_VCPU_POWER_OFF		0 /* CPU is started in OFF state */
>>  #define KVM_ARM_VCPU_EL1_32BIT		1 /* CPU running a 32bit VM */
>>  #define KVM_ARM_VCPU_PSCI_0_2		2 /* CPU uses PSCI v0.2 */
>> diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
>> index c303083..e2e432c 100644
>> --- a/include/kvm/arm_vgic.h
>> +++ b/include/kvm/arm_vgic.h
>> @@ -35,8 +35,8 @@
>>  #define VGIC_MAX_IRQS		1024
>>  
>>  /* Sanity checks... */
>> -#if (KVM_MAX_VCPUS > 8)
>> -#error	Invalid number of CPU interfaces
>> +#if (KVM_MAX_VCPUS > 255)
>> +#error Too many KVM VCPUs, the VGIC only supports up to 255 VCPUs for now
> 
> what happens now if you add more vcpus after having created a GICv2 with
> 8 vcpus?

On adding a VCPU we check the number of allowed VCPUs for this
particular guest (see arch/arm/kvm/arm.c:kvm_arch_vcpu_create() in patch
09/19). On creating a virtual GICv2 we set the limit to 8, so any
KVM_VCPU_CREATE afterwards will fail.

But indeed I found other issues in this sequence of VCPU/VGIC init,
which dissolved "magically" by the rework around (or actually the drop
of) init_emul() and friends.

Thanks,
Andre.

>>  #endif
>>  
>>  #if (VGIC_NR_IRQS_LEGACY & 31)
>> diff --git a/virt/kvm/arm/vgic-v3-emul.c b/virt/kvm/arm/vgic-v3-emul.c
>> index bcb5374..ba6b0b5 100644
>> --- a/virt/kvm/arm/vgic-v3-emul.c
>> +++ b/virt/kvm/arm/vgic-v3-emul.c
>> @@ -870,6 +870,9 @@ static int vgic_v3_has_attr(struct kvm_device *dev,
>>  		case KVM_VGIC_V2_ADDR_TYPE_DIST:
>>  		case KVM_VGIC_V2_ADDR_TYPE_CPU:
>>  			return -ENXIO;
>> +		case KVM_VGIC_V3_ADDR_TYPE_DIST:
>> +		case KVM_VGIC_V3_ADDR_TYPE_REDIST:
>> +			return 0;
>>  		}
>>  		break;
>>  	case KVM_DEV_ARM_VGIC_GRP_DIST_REGS:
>> diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
>> index 16d7c9d..a5abef1 100644
>> --- a/virt/kvm/arm/vgic.c
>> +++ b/virt/kvm/arm/vgic.c
>> @@ -1647,7 +1647,7 @@ static int vgic_ioaddr_assign(struct kvm *kvm, phys_addr_t *ioaddr,
>>  /**
>>   * kvm_vgic_addr - set or get vgic VM base addresses
>>   * @kvm:   pointer to the vm struct
>> - * @type:  the VGIC addr type, one of KVM_VGIC_V2_ADDR_TYPE_XXX
>> + * @type:  the VGIC addr type, one of KVM_VGIC_V[23]_ADDR_TYPE_XXX
>>   * @addr:  pointer to address value
>>   * @write: if true set the address in the VM address space, if false read the
>>   *          address
>> @@ -1661,29 +1661,49 @@ int kvm_vgic_addr(struct kvm *kvm, unsigned long type, u64 *addr, bool write)
>>  {
>>  	int r = 0;
>>  	struct vgic_dist *vgic = &kvm->arch.vgic;
>> +	int type_needed;
>> +	phys_addr_t *addr_ptr, block_size;
>>  
>>  	mutex_lock(&kvm->lock);
>>  	switch (type) {
>>  	case KVM_VGIC_V2_ADDR_TYPE_DIST:
>> -		if (write) {
>> -			r = vgic_ioaddr_assign(kvm, &vgic->vgic_dist_base,
>> -					       *addr, KVM_VGIC_V2_DIST_SIZE);
>> -		} else {
>> -			*addr = vgic->vgic_dist_base;
>> -		}
>> +		type_needed = KVM_DEV_TYPE_ARM_VGIC_V2;
>> +		addr_ptr = &vgic->vgic_dist_base;
>> +		block_size = KVM_VGIC_V2_DIST_SIZE;
>>  		break;
>>  	case KVM_VGIC_V2_ADDR_TYPE_CPU:
>> -		if (write) {
>> -			r = vgic_ioaddr_assign(kvm, &vgic->vgic_cpu_base,
>> -					       *addr, KVM_VGIC_V2_CPU_SIZE);
>> -		} else {
>> -			*addr = vgic->vgic_cpu_base;
>> -		}
>> +		type_needed = KVM_DEV_TYPE_ARM_VGIC_V2;
>> +		addr_ptr = &vgic->vgic_cpu_base;
>> +		block_size = KVM_VGIC_V2_CPU_SIZE;
>>  		break;
>> +#ifdef CONFIG_ARM_GIC_V3
>> +	case KVM_VGIC_V3_ADDR_TYPE_DIST:
>> +		type_needed = KVM_DEV_TYPE_ARM_VGIC_V3;
>> +		addr_ptr = &vgic->vgic_dist_base;
>> +		block_size = KVM_VGIC_V3_DIST_SIZE;
>> +		break;
>> +	case KVM_VGIC_V3_ADDR_TYPE_REDIST:
>> +		type_needed = KVM_DEV_TYPE_ARM_VGIC_V3;
>> +		addr_ptr = &vgic->vgic_redist_base;
>> +		block_size = KVM_VGIC_V3_REDIST_SIZE;
>> +		break;
>> +#endif
>>  	default:
>>  		r = -ENODEV;
>> +		goto out;
>> +	}
>> +
>> +	if (vgic->vgic_model != type_needed) {
>> +		r = -ENODEV;
>> +		goto out;
>>  	}
>>  
>> +	if (write)
>> +		r = vgic_ioaddr_assign(kvm, addr_ptr, *addr, block_size);
>> +	else
>> +		*addr = *addr_ptr;
>> +
>> +out:
>>  	mutex_unlock(&kvm->lock);
>>  	return r;
>>  }
>> -- 
>> 1.7.9.5
>>
> 
> Otherwise looks good to me.
> 
> Thanks,
> -Christoffer
> 
