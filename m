From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 2 Aug 2016 11:18:03 +0100
Subject: [PATCH 41/55] KVM: arm64: vgic-its: Implement MSI injection in
 ITS emulation
In-Reply-To: <20160801182006.GB32244@cbox>
References: <1469208552-4155-1-git-send-email-marc.zyngier@arm.com>
 <1469208552-4155-42-git-send-email-marc.zyngier@arm.com>
 <20160801182006.GB32244@cbox>
Message-ID: <57A0735B.7060403@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/08/16 19:20, Christoffer Dall wrote:
> On Fri, Jul 22, 2016 at 06:28:58PM +0100, Marc Zyngier wrote:
>> From: Andre Przywara <andre.przywara@arm.com>
>>
>> When userland wants to inject an MSI into the guest, it uses the
>> KVM_SIGNAL_MSI ioctl, which carries the doorbell address along with
>> the payload and the device ID.
>> With the help of the KVM IO bus framework we learn the corresponding
>> ITS from the doorbell address. We then use our wrapper functions to
>> iterate the linked lists and find the proper Interrupt Translation Table
>> Entry (ITTE) and thus the corresponding struct vgic_irq to finally set
>> the pending bit.
>> We also provide the handler for the ITS "INT" command, which allows a
>> guest to trigger an MSI via the ITS command queue. Since this one knows
>> about the right ITS already, we directly call the MMIO handler function
>> without using the kvm_io_bus framework.
>>
>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>> Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
>> Tested-by: Eric Auger <eric.auger@redhat.com>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  virt/kvm/arm/vgic/vgic-its.c | 77 ++++++++++++++++++++++++++++++++++++++++++++
>>  virt/kvm/arm/vgic/vgic.h     |  6 ++++
>>  2 files changed, 83 insertions(+)
>>
>> diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
>> index 1408c88..d8e8f14 100644
>> --- a/virt/kvm/arm/vgic/vgic-its.c
>> +++ b/virt/kvm/arm/vgic/vgic-its.c
>> @@ -437,6 +437,65 @@ static unsigned long vgic_mmio_read_its_idregs(struct kvm *kvm,
>>  	return 0;
>>  }
>>  
>> +/*
>> + * Find the target VCPU and the LPI number for a given devid/eventid pair
>> + * and make this IRQ pending, possibly injecting it.
>> + * Must be called with the its_lock mutex held.
>> + */
>> +static void vgic_its_trigger_msi(struct kvm *kvm, struct vgic_its *its,
>> +				 u32 devid, u32 eventid)
>> +{
>> +	struct its_itte *itte;
>> +
>> +	if (!its->enabled)
>> +		return;
>> +
>> +	itte = find_itte(its, devid, eventid);
>> +	/* Triggering an unmapped IRQ gets silently dropped. */
>> +	if (itte && its_is_collection_mapped(itte->collection)) {
>> +		struct kvm_vcpu *vcpu;
>> +
>> +		vcpu = kvm_get_vcpu(kvm, itte->collection->target_addr);
>> +		if (vcpu && vcpu->arch.vgic_cpu.lpis_enabled) {
>> +			spin_lock(&itte->irq->irq_lock);
>> +			itte->irq->pending = true;
>> +			vgic_queue_irq_unlock(kvm, itte->irq);
>> +		}
>> +	}
>> +}
>> +
>> +/*
>> + * Queries the KVM IO bus framework to get the ITS pointer from the given
>> + * doorbell address.
>> + * We then call vgic_its_trigger_msi() with the decoded data.
>> + */
>> +int vgic_its_inject_msi(struct kvm *kvm, struct kvm_msi *msi)
>> +{
>> +	u64 address;
>> +	struct kvm_io_device *kvm_io_dev;
>> +	struct vgic_io_device *iodev;
>> +
>> +	if (!vgic_has_its(kvm))
>> +		return -ENODEV;
>> +
>> +	if (!(msi->flags & KVM_MSI_VALID_DEVID))
>> +		return -EINVAL;
>> +
>> +	address = (u64)msi->address_hi << 32 | msi->address_lo;
>> +
>> +	kvm_io_dev = kvm_io_bus_get_dev(kvm, KVM_MMIO_BUS, address);
>> +	if (!kvm_io_dev)
>> +		return -ENODEV;
>> +
>> +	iodev = container_of(kvm_io_dev, struct vgic_io_device, dev);
>> +
>> +	mutex_lock(&iodev->its->its_lock);
>> +	vgic_its_trigger_msi(kvm, iodev->its, msi->devid, msi->data);
>> +	mutex_unlock(&iodev->its->its_lock);
>> +
>> +	return 0;
> 
> According to KVM_SIGNAL_MSI this means that the guest blocked the MSI.
> Is this the intention, or is the return value translated somewhere
> higher in the call stack?

I'm afraid it is not, and this is definitely a bug. Andre, can you
please address this one urgently, as this has a direct impact on the
userspace API?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
