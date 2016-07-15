From: andre.przywara@arm.com (Andre Przywara)
Date: Fri, 15 Jul 2016 10:33:44 +0100
Subject: [PATCH v9 10/17] KVM: arm64: introduce new KVM ITS device
In-Reply-To: <57874F1E.3000202@arm.com>
References: <20160713015909.28793-1-andre.przywara@arm.com>
 <20160713015909.28793-11-andre.przywara@arm.com> <57874F1E.3000202@arm.com>
Message-ID: <68082207-2b52-e825-cfe3-cb97cbe94186@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 14/07/16 09:36, Marc Zyngier wrote:
> On 13/07/16 02:59, Andre Przywara wrote:

....

>> diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
>> index 06ad94d..393ad3a 100644
>> --- a/virt/kvm/arm/vgic/vgic-its.c
>> +++ b/virt/kvm/arm/vgic/vgic-its.c

...

>> +static int vgic_its_set_attr(struct kvm_device *dev,
>> +			     struct kvm_device_attr *attr)
>> +{
>> +	struct vgic_its *its = dev->private;
>> +	int ret;
>> +
>> +	switch (attr->group) {
>> +	case KVM_DEV_ARM_VGIC_GRP_ADDR: {
>> +		u64 __user *uaddr = (u64 __user *)(long)attr->addr;
>> +		unsigned long type = (unsigned long)attr->attr;
>> +		u64 addr;
>> +
>> +		if (type != KVM_VGIC_ITS_ADDR_TYPE)
>> +			return -ENODEV;
>> +
>> +		if (its->initialized)
>> +			return -EBUSY;
>> +
>> +		if (copy_from_user(&addr, uaddr, sizeof(addr)))
>> +			return -EFAULT;
>> +
>> +		ret = vgic_check_ioaddr(dev->kvm, &its->vgic_its_base,
>> +					addr, SZ_64K);
> 
> Shouldn't that be the ITS size (128kB)?

No, this is the alignment requirement. See here:

...

>> diff --git a/virt/kvm/arm/vgic/vgic-kvm-device.c b/virt/kvm/arm/vgic/vgic-kvm-device.c
>> index 2f24f13..1813f93 100644
>> --- a/virt/kvm/arm/vgic/vgic-kvm-device.c
>> +++ b/virt/kvm/arm/vgic/vgic-kvm-device.c
>> @@ -21,8 +21,8 @@
>>  
>>  /* common helpers */
>>  
>> -static int vgic_check_ioaddr(struct kvm *kvm, phys_addr_t *ioaddr,
>> -			     phys_addr_t addr, phys_addr_t alignment)
>> +int vgic_check_ioaddr(struct kvm *kvm, phys_addr_t *ioaddr,
>> +		      phys_addr_t addr, phys_addr_t alignment)
>>  {
>>  	if (addr & ~KVM_PHYS_MASK)
>>  		return -E2BIG;

Fixed the rest.

Cheers,
Andre.
