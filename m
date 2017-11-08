From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 8 Nov 2017 11:40:38 +0000
Subject: [PATCH v5 11/26] KVM: arm/arm64: GICv4: Handle INT command
 applied to a VLPI
In-Reply-To: <6e12eac9-7b75-2c2c-0c79-d17a3c0d65eb@redhat.com>
References: <20171027142855.21584-1-marc.zyngier@arm.com>
 <20171027142855.21584-12-marc.zyngier@arm.com>
 <6e12eac9-7b75-2c2c-0c79-d17a3c0d65eb@redhat.com>
Message-ID: <26647099-f16c-f4ef-6902-ebbfb7a40a3a@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/11/17 20:15, Auger Eric wrote:
> Hi Marc,
> 
> On 27/10/2017 16:28, Marc Zyngier wrote:
>> If the guest issues an INT command targetting a VLPI, let's
>> call into the irq_set_irqchip_state() helper to make it pending
>> on the physical side.
>>
>> This works just as well if userspace decides to inject an interrupt
>> using the normal userspace API...
> There is also another path:
> KVM_SIGNAL_MSI ioctl / kvm_send_userspace_msi / kvm_set_msi /
> vgic_its_inject_msi / vgic_its_trigger_msi

Isn't this path covered by this very patch?

> I wonder whether we shouldn't prevent the userspace from messing up with
> the host irq pending state?

What do we gain from that limitation? Here, we're just making sure
things will work correctly, and we're not preventing userspace from
doing something silly (the guest will only see spurious interrupts anyway).

Thanks,

	M.

> Thanks
> 
> Eric
>>
>> Acked-by: Christoffer Dall <cdall@linaro.org>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  virt/kvm/arm/vgic/vgic-its.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
>> index 89768d2b6a91..b2a678d131d0 100644
>> --- a/virt/kvm/arm/vgic/vgic-its.c
>> +++ b/virt/kvm/arm/vgic/vgic-its.c
>> @@ -578,6 +578,10 @@ static int vgic_its_trigger_msi(struct kvm *kvm, struct vgic_its *its,
>>  	if (err)
>>  		return err;
>>  
>> +	if (irq->hw)
>> +		return irq_set_irqchip_state(irq->host_irq,
>> +					     IRQCHIP_STATE_PENDING, true);
>> +
>>  	spin_lock(&irq->irq_lock);
>>  	irq->pending_latch = true;
>>  	vgic_queue_irq_unlock(kvm, irq);
>>


-- 
Jazz is not dead. It just smells funny...
