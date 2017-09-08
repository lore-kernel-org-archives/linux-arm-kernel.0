From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 8 Sep 2017 14:32:37 +0100
Subject: [PATCH v3 4/5] KVM: arm/arm64: Support VGIC dist pend/active
 changes for mapped IRQs
In-Reply-To: <d51a40df-92f9-eeff-0d16-ea12fd451dea@redhat.com>
References: <20170906122612.18050-1-cdall@linaro.org>
 <20170906122612.18050-5-cdall@linaro.org>
 <d51a40df-92f9-eeff-0d16-ea12fd451dea@redhat.com>
Message-ID: <2e1352d7-fb64-907d-7726-4d53d7af5768@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/09/17 14:04, Auger Eric wrote:
> Hi Christoffer,
> 
> On 06/09/2017 14:26, Christoffer Dall wrote:
>> For mapped IRQs (with the HW bit set in the LR) we have to follow some
>> rules of the architecture.  One of these rules is that VM must not be
>> allowed to deactivate a virtual interrupt with the HW bit set unless the
>> physical interrupt is also active.
>>
>> This works fine when injecting mapped interrupts, because we leave it up
>> to the injector to either set EOImode==1 or manually set the active
>> state of the physical interrupt.
>>
>> However, the guest can set virtual interrupt to be pending or active by
>> writing to the virtual distributor, which could lead to deactivating a
>> virtual interrupt with the HW bit set without the physical interrupt
>> being active.
>>
>> We could set the physical interrupt to active whenever we are about to
>> enter the VM with a HW interrupt either pending or active, but that
>> would be really slow, especially on GICv2.  So we take the long way
>> around and do the hard work when needed, which is expected to be
>> extremely rare.
>>
>> When the VM sets the pending state for a HW interrupt on the virtual
>> distributor we set the active state on the physical distributor, because
>> the virtual interrupt can become active and then the guest can
>> deactivate it.
>>
>> When the VM clears the pending state we also clear it on the physical
>> side, because the injector might otherwise raise the interrupt.
>>
>> Signed-off-by: Christoffer Dall <cdall@linaro.org>
>> ---
>>  virt/kvm/arm/vgic/vgic-mmio.c | 33 +++++++++++++++++++++++++++++++++
>>  virt/kvm/arm/vgic/vgic.c      |  7 +++++++
>>  virt/kvm/arm/vgic/vgic.h      |  1 +
>>  3 files changed, 41 insertions(+)
>>
>> diff --git a/virt/kvm/arm/vgic/vgic-mmio.c b/virt/kvm/arm/vgic/vgic-mmio.c
>> index c1e4bdd..00003ae 100644
>> --- a/virt/kvm/arm/vgic/vgic-mmio.c
>> +++ b/virt/kvm/arm/vgic/vgic-mmio.c
>> @@ -131,6 +131,9 @@ void vgic_mmio_write_spending(struct kvm_vcpu *vcpu,
>>  		struct vgic_irq *irq = vgic_get_irq(vcpu->kvm, vcpu, intid + i);
>>  
>>  		spin_lock(&irq->irq_lock);
>> +		if (irq->hw)
>> +			vgic_irq_set_phys_active(irq, true);
>> +
>>  		irq->pending_latch = true;
>>  
>>  		vgic_queue_irq_unlock(vcpu->kvm, irq);
>> @@ -149,6 +152,20 @@ void vgic_mmio_write_cpending(struct kvm_vcpu *vcpu,
>>  		struct vgic_irq *irq = vgic_get_irq(vcpu->kvm, vcpu, intid + i);
>>  
>>  		spin_lock(&irq->irq_lock);
>> +		/*
>> +		 * We don't want the guest to effectively mask the physical
>> +		 * interrupt by doing a write to SPENDR followed by a write to
>> +		 * CPENDR for HW interrupts, so we clear the active state on
>> +		 * the physical side here.  This may lead to taking an
>> +		 * additional interrupt on the host, but that should not be a
>> +		 * problem as the worst that can happen is an additional vgic
>> +		 * injection.  We also clear the pending state to maintain
>> +		 * proper semantics for edge HW interrupts.
>> +		 */
>> +		if (irq->hw) {
>> +			vgic_irq_set_phys_pending(irq, false);
>> +			vgic_irq_set_phys_active(irq, false);
> I fail in understanding why the active state is reset here. Can you
> provide an example?


If we're clearing the pending state on the virtual side, we need to be
able to let an incoming physical interrupt fire so that it can be made
pending again. We may have to check that the virtual active state is
clear though.

> If the physical dist has an active state can't the virtual IRQ be in
> active state, in which case you may later on deactivate a phys IRQ which
> is not active?


Well, I think we must be able to handle both cases:

- CPENDR write:
	clear physical pending
	if (virtual active clear)
		clear physical active

- CACTIVER write:
	clear physical active

Does this work for you?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
