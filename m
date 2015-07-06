From: andre.przywara@arm.com (Andre Przywara)
Date: Mon, 6 Jul 2015 17:46:37 +0100
Subject: [PATCH 12/13] KVM: arm64: implement MSI injection in ITS emulation
In-Reply-To: <5579C8AA.8010903@linaro.org>
References: <1432893209-27313-1-git-send-email-andre.przywara@arm.com>
 <1432893209-27313-13-git-send-email-andre.przywara@arm.com>
 <5579C8AA.8010903@linaro.org>
Message-ID: <559AB0ED.1090405@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

....

>> diff --git a/virt/kvm/arm/its-emul.c b/virt/kvm/arm/its-emul.c
>> index 574cf05..35e886c 100644
>> --- a/virt/kvm/arm/its-emul.c
>> +++ b/virt/kvm/arm/its-emul.c
>> @@ -340,6 +340,55 @@ static bool handle_mmio_gits_idregs(struct kvm_vcpu *vcpu,
>>  }
>>  
>>  /*
>> + * Translates an incoming MSI request into the redistributor (=VCPU) and
>> + * the associated LPI number. Sets the LPI pending bit and also marks the
>> + * VCPU as having a pending interrupt.
>> + */
>> +int vits_inject_msi(struct kvm *kvm, struct kvm_msi *msi)
>> +{
>> +	struct vgic_dist *dist = &kvm->arch.vgic;
>> +	struct vgic_its *its = &dist->its;
>> +	struct its_itte *itte;
>> +	int cpuid;
>> +	bool inject = false;
>> +	int ret = 0;
>> +
>> +	if (!vgic_has_its(kvm))
>> +		return -ENODEV;
>> +
>> +	if (!(msi->flags & KVM_MSI_VALID_DEVID))
>> +		return -EINVAL;
>> +
>> +	spin_lock(&its->lock);
>> +
>> +	if (!its->enabled || !dist->lpis_enabled) {
>> +		ret = -EAGAIN;
>> +		goto out_unlock;
>> +	}
>> +
>> +	itte = find_itte(kvm, msi->devid, msi->data);
>> +	/* Triggering an unmapped IRQ gets silently dropped. */
>> +	if (!itte || !itte->collection)
>> +		goto out_unlock;
>> +
>> +	cpuid = itte->collection->target_addr;
>> +	set_bit(cpuid, itte->pending);
> so now the internal state is different from the pending state in ext
> memory. I don't really understand where the ext mem is used?

This is expected, as the ITS is allowed to cache the state. In a
hardware ITS implementation the external memory is used to provide
actual storage for the ITS, something we do not need for the emulation,
as we have cheaper (host) memory for that.
The only thing we have to model though is that the guest may use the
external storage to take a snapshot of the current state, but it may
only do so after having flushed the ITS "cache", which means we
synchronize our internal data structures to that "external" memory.

>> +	inject = itte->enabled;
>> +
>> +out_unlock:
>> +	spin_unlock(&its->lock);
>> +
>> +	if (inject) {
>> +		spin_lock(&dist->lock);
>> +		set_bit(cpuid, dist->irq_pending_on_cpu);
> isn't it atomic op?

It is, but that's not what the lock protects. It's there to avoid
stepping on someone else's toes, who might deal with the ITS data
structures at the same time and would not expect a value to change in
the middle (think about code iterating over dist->irq_pending_on_cpu).

Cheers,
Andre.
