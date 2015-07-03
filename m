From: eric.auger@linaro.org (Eric Auger)
Date: Fri, 03 Jul 2015 07:34:07 +0200
Subject: [PATCH 7/7] KVM: arm: implement kvm_set_msi by gsi direct mapping
In-Reply-To: <5595706C.9010108@arm.com>
References: <1435592237-17924-1-git-send-email-eric.auger@linaro.org>
 <1435592237-17924-8-git-send-email-eric.auger@linaro.org>
 <5595706C.9010108@arm.com>
Message-ID: <55961ECF.4090208@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andre,
On 07/02/2015 07:10 PM, Andre Przywara wrote:
> Hi Eric,
> 
> On 29/06/15 16:37, Eric Auger wrote:
>> If the ITS modality is not available, let's simply support MSI
>> injection by transforming the MSI.data into an SPI ID.
>>
>> This becomes possible to use KVM_SIGNAL_MSI ioctl for arm too.
>>
>> Signed-off-by: Eric Auger <eric.auger@linaro.org>
>> ---
>>  arch/arm/kvm/Kconfig | 1 +
>>  virt/kvm/arm/vgic.c  | 5 +++++
>>  2 files changed, 6 insertions(+)
>>
>> diff --git a/arch/arm/kvm/Kconfig b/arch/arm/kvm/Kconfig
>> index 151e710..0f58baf 100644
>> --- a/arch/arm/kvm/Kconfig
>> +++ b/arch/arm/kvm/Kconfig
>> @@ -31,6 +31,7 @@ config KVM
>>  	select KVM_VFIO
>>  	select HAVE_KVM_EVENTFD
>>  	select HAVE_KVM_IRQFD
>> +	select HAVE_KVM_MSI
>>  	select HAVE_KVM_IRQCHIP
>>  	select HAVE_KVM_IRQ_ROUTING
>>  	depends on ARM_VIRT_EXT && ARM_LPAE && ARM_ARCH_TIMER
>> diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
>> index 0b4c48c..b3c10dc 100644
>> --- a/virt/kvm/arm/vgic.c
>> +++ b/virt/kvm/arm/vgic.c
>> @@ -2314,6 +2314,11 @@ int kvm_set_msi(struct kvm_kernel_irq_routing_entry *e,
>>  			return kvm->arch.vgic.vm_ops.inject_msi(kvm, &msi);
>>  		else
>>  			return -ENODEV;
>> +	case KVM_IRQ_ROUTING_MSI:
>> +		if (kvm->arch.vgic.vm_ops.inject_msi)
>> +			return -EINVAL;
>> +		else
>> +			return kvm_vgic_inject_irq(kvm, 0, e->msi.data, level);
> 
> If you add:
> 
> static int vgic_v2m_inject_msi(struct kvm *kvm, struct kvm_msi *msi)
> {
> 	return kvm_vgic_inject_irq(kvm, 0, msi->data, 1);
> }
> 
> to vgic-v2-emul.c and wire it up accordingly, you can simplify the above
> kvm_set_msi, getting rid of all those extra case handling.
> This also helps merging KVM_IRQ_ROUTING_MSI and the extended case.
> 
> I have hacked this up and it seems to work for me.

OK thanks I will respin either today or on monday.

Best Regards

Eric
> 
> Cheers,
> Andre.
> 
