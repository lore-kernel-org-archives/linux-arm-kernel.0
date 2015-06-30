From: eric.auger@linaro.org (Eric Auger)
Date: Tue, 30 Jun 2015 16:02:30 +0200
Subject: [PATCH 4/7] KVM: arm/arm64: enable irqchip routing
In-Reply-To: <55929C0A.9020107@arm.com>
References: <1435592237-17924-1-git-send-email-eric.auger@linaro.org>
 <1435592237-17924-5-git-send-email-eric.auger@linaro.org>
 <55929C0A.9020107@arm.com>
Message-ID: <5592A176.1090502@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/30/2015 03:39 PM, Andre Przywara wrote:
> Hi Eric,
> 
> On 29/06/15 16:37, Eric Auger wrote:
>> This patch adds compilation and link against irqchip.
>>
>> On ARM, irqchip routing is not really useful since there is
>> a single irqchip. However main motivation behind using irqchip
>> code is to enable MSI routing code. With the support of in-kernel
>> GICv3 ITS emulation, it now seems to be a MUST HAVE requirement.
>>
>> Functions previously implemented in vgic.c and substitute
>> to more complex irqchip implementation are removed:
>>
>> - kvm_send_userspace_msi
>> - kvm_irq_map_chip_pin
>> - kvm_set_irq
>> - kvm_irq_map_gsi.
>>
>> They implemented a kernel default identity GSI routing. This is now
>> replaced by user-side provided routing.
>>
>> Routing standard hooks are now implemented in vgic:
>> - kvm_set_routing_entry
>> - kvm_set_irq
>> - kvm_set_msi
>>
>> Both HAVE_KVM_IRQCHIP and HAVE_KVM_IRQ_ROUTING are defined.
>> KVM_CAP_IRQ_ROUTING is advertised and KVM_SET_GSI_ROUTING is allowed.
>>
>> MSI routing is not yet allowed.
>>
>> Signed-off-by: Eric Auger <eric.auger@linaro.org>
>>
> ...
> 
>> diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
>> index 09b1f46..212a5ff 100644
>> --- a/virt/kvm/arm/vgic.c
>> +++ b/virt/kvm/arm/vgic.c
>> @@ -2220,47 +2220,67 @@ out_free_irq:
>>  	return ret;
>>  }
>>  
>> -int kvm_irq_map_gsi(struct kvm *kvm,
>> -		    struct kvm_kernel_irq_routing_entry *entries,
>> -		    int gsi)
>> +int vgic_irqfd_set_irq(struct kvm_kernel_irq_routing_entry *e,
>> +			struct kvm *kvm, int irq_source_id,
>> +			int level, bool line_status)
>>  {
>> -	return 0;
>> -}
>> -
>> -int kvm_irq_map_chip_pin(struct kvm *kvm, unsigned irqchip, unsigned pin)
>> -{
>> -	return pin;
>> -}
>> -
>> -int kvm_set_irq(struct kvm *kvm, int irq_source_id,
>> -		u32 irq, int level, bool line_status)
>> -{
>> -	unsigned int spi = irq + VGIC_NR_PRIVATE_IRQS;
>> +	unsigned int spi_id = e->irqchip.pin + VGIC_NR_PRIVATE_IRQS;
>>  
>> -	trace_kvm_set_irq(irq, level, irq_source_id);
>> +	trace_kvm_set_irq(spi_id, level, irq_source_id);
>>  
>>  	BUG_ON(!vgic_initialized(kvm));
>>  
>> -	if (spi > kvm->arch.vgic.nr_irqs)
>> +	if (spi_id > kvm->arch.vgic.nr_irqs)
>>  		return -EINVAL;
>> -	return kvm_vgic_inject_irq(kvm, 0, spi, level);
>> +	return kvm_vgic_inject_irq(kvm, 0, spi_id, level);
>>  
>>  }
>>  
>> -/* MSI not implemented yet */
>> +/**
>> + * Populates a kvm routing entry from a user routing entry
>> + * @e: kvm internal formatted entry
>> + * @ue: user api formatted entry
>> + * return 0 on success, -EINVAL on errors.
>> + */
>> +int kvm_set_routing_entry(struct kvm_kernel_irq_routing_entry *e,
>> +			  const struct kvm_irq_routing_entry *ue)
>> +{
>> +	int r = -EINVAL;
>> +
>> +	switch (ue->type) {
>> +	case KVM_IRQ_ROUTING_IRQCHIP:
>> +		e->set = vgic_irqfd_set_irq;
>> +		e->irqchip.irqchip = ue->u.irqchip.irqchip;
>> +		e->irqchip.pin = ue->u.irqchip.pin;
>> +		if ((e->irqchip.pin >= KVM_IRQCHIP_NUM_PINS) ||
>> +		    (e->irqchip.irqchip >= KVM_NR_IRQCHIPS))
>> +			goto out;
>> +		break;
>> +	default:
>> +		goto out;
>> +	}
>> +	r = 0;
>> +out:
>> +	return r;
>> +}
>> +
>>  int kvm_set_msi(struct kvm_kernel_irq_routing_entry *e,
>>  		struct kvm *kvm, int irq_source_id,
>>  		int level, bool line_status)
>>  {
>> -	return 0;
>> -}
>> +	struct kvm_msi msi;
>>  
>> -#ifdef CONFIG_HAVE_KVM_MSI
>> -int kvm_send_userspace_msi(struct kvm *kvm, struct kvm_msi *msi)
>> -{
>> -	if (kvm->arch.vgic.vm_ops.inject_msi)
>> -		return kvm->arch.vgic.vm_ops.inject_msi(kvm, msi);
>> -	else
>> -		return -ENODEV;
>> +	switch (e->type) {
>> +	case KVM_IRQ_ROUTING_EXTENDED_MSI:
>> +		msi.address_lo = e->ext_msi.address_lo;
>> +		msi.address_hi = e->ext_msi.address_hi;
>> +		msi.data = e->ext_msi.data;
>> +		msi.flags = e->ext_msi.devid;
> 
> You probably meant to write:
> +		msi.flags = KVM_MSI_VALID_DEVID;
> +		msi.devid = e->ext_msi.devid;
> 
> With this change I could get it (your patches on top of my v1.5) to work
> with my hacked kvmtool - at least with vhost=0. On to fixing irqfd now ...

Yes sure. Thanks for the catch!

I will correct in next respin

Thanks

Eric
> 
> Cheers,
> Andre.
> 
>> +		if (kvm->arch.vgic.vm_ops.inject_msi)
>> +			return kvm->arch.vgic.vm_ops.inject_msi(kvm, &msi);
>> +		else
>> +			return -ENODEV;
>> +	default:
>> +		return -EINVAL;
>> +	}
>>  }
>> -#endif
