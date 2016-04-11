From: andre.przywara@arm.com (Andre Przywara)
Date: Mon, 11 Apr 2016 12:23:25 +0100
Subject: [RFC PATCH 14/45] KVM: arm/arm64: vgic-new: Add CTLR, TYPER and
 IIDR handlers
In-Reply-To: <20160331092727.GT4126@cbox>
References: <1458871508-17279-1-git-send-email-andre.przywara@arm.com>
 <1458871508-17279-15-git-send-email-andre.przywara@arm.com>
 <20160331092727.GT4126@cbox>
Message-ID: <570B892D.7070308@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31/03/16 10:27, Christoffer Dall wrote:
> On Fri, Mar 25, 2016 at 02:04:37AM +0000, Andre Przywara wrote:
>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>> ---
>>  virt/kvm/arm/vgic/vgic.h      |  3 +++
>>  virt/kvm/arm/vgic/vgic_mmio.c | 49 ++++++++++++++++++++++++++++++++++++++++++-
>>  2 files changed, 51 insertions(+), 1 deletion(-)
>>
>> diff --git a/virt/kvm/arm/vgic/vgic.h b/virt/kvm/arm/vgic/vgic.h
>> index a462e2b..57aea8f 100644
>> --- a/virt/kvm/arm/vgic/vgic.h
>> +++ b/virt/kvm/arm/vgic/vgic.h
>> @@ -16,6 +16,9 @@
>>  #ifndef __KVM_ARM_VGIC_NEW_H__
>>  #define __KVM_ARM_VGIC_NEW_H__
>>  
>> +#define PRODUCT_ID_KVM		0x4b	/* ASCII code K */
>> +#define IMPLEMENTER_ARM		0x43b
>> +
>>  struct vgic_irq *vgic_get_irq(struct kvm *kvm, struct kvm_vcpu *vcpu,
>>  			      u32 intid);
>>  bool vgic_queue_irq(struct kvm *kvm, struct vgic_irq *irq);
>> diff --git a/virt/kvm/arm/vgic/vgic_mmio.c b/virt/kvm/arm/vgic/vgic_mmio.c
>> index e1fd17f..e62366e 100644
>> --- a/virt/kvm/arm/vgic/vgic_mmio.c
>> +++ b/virt/kvm/arm/vgic/vgic_mmio.c
>> @@ -82,9 +82,56 @@ static int vgic_mmio_write_nyi(struct kvm_vcpu *vcpu,
>>  	return 0;
>>  }
>>  
>> +static int vgic_mmio_read_v2_misc(struct kvm_vcpu *vcpu,
>> +				  struct kvm_io_device *this,
>> +				  gpa_t addr, int len, void *val)
>> +{
>> +	struct vgic_io_device *iodev = container_of(this,
>> +						    struct vgic_io_device, dev);
>> +	u32 value;
>> +
>> +	switch ((addr - iodev->base_addr) & ~3) {
>> +	case 0x0:
>> +		value = vcpu->kvm->arch.vgic.enabled ? GICD_ENABLE : 0;
>> +		break;
>> +	case 0x4:
>> +		value = vcpu->kvm->arch.vgic.nr_spis + VGIC_NR_PRIVATE_IRQS;
>> +		value = (value >> 5) - 1;
>> +		value |= (atomic_read(&vcpu->kvm->online_vcpus) - 1) << 5;
>> +		break;
>> +	case 0x8:
>> +		value = (PRODUCT_ID_KVM << 24) | (IMPLEMENTER_ARM << 0);
>> +		break;
>> +	default:
>> +		return 0;
>> +	}
>> +
>> +	write_mask32(value, addr & 3, len, val);
>> +	return 0;
>> +}
>> +
>> +static int vgic_mmio_write_v2_misc(struct kvm_vcpu *vcpu,
>> +				   struct kvm_io_device *this,
>> +				   gpa_t addr, int len, const void *val)
>> +{
>> +	struct vgic_io_device *iodev = container_of(this,
>> +						    struct vgic_io_device, dev);
>> +	/*
>> +	 * GICD_TYPER and GICD_IIDR are read-only, the upper three bytes of
>> +	 * GICD_CTLR are reserved.
>> +	 */
>> +	if (addr - iodev->base_addr >= 1)
>> +		return 0;
>> +
>> +	vcpu->kvm->arch.vgic.enabled = (*(u32 *)val) ? true : false;
>> +	/* TODO: is there anything to trigger at this point? */
> 
> I guess we should actually check if the vgic is enabled in PATH 11, and
> we should kick all VCPUs (or at least those with something pending) if
> we went from disabled to enabled?
> 
> We should probably also check this in the sync function...
> 
> Or do we enforce this enabled bool somewhere else that I missed?

Good point, I guess in the moment we just rely upon the VGIC being
enabled very early and never getting disabled.
So I will introduce checks in kvm_vgic_vcpu_pending_irq and the flush
function (which is called before entering the guest, I guess this is
what you meant with the "sync function"?), also kick all (?) VCPUs here
in case we enable the GIC.

Cheers,
Andre.

Note: just added comments about the direction of flushing/syncing since
I always forget which is which ;-)

>> +
>> +	return 0;
>> +}
>> +
>>  struct vgic_register_region vgic_v2_dist_registers[] = {
>>  	REGISTER_DESC_WITH_LENGTH(GIC_DIST_CTRL,
>> -		vgic_mmio_read_nyi, vgic_mmio_write_nyi, 12),
>> +		vgic_mmio_read_v2_misc, vgic_mmio_write_v2_misc, 12),
>>  	REGISTER_DESC_WITH_BITS_PER_IRQ(GIC_DIST_IGROUP,
>>  		vgic_mmio_read_raz, vgic_mmio_write_wi, 1),
>>  	REGISTER_DESC_WITH_BITS_PER_IRQ(GIC_DIST_ENABLE_SET,
>> -- 
>> 2.7.3
>>
> 
