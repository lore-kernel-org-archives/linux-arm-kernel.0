From: andre.przywara@arm.com (Andre Przywara)
Date: Thu, 18 Jun 2015 15:22:08 +0100
Subject: [PATCH 13/13] KVM: arm64: enable ITS emulation as a virtual MSI
 controller
In-Reply-To: <558284B4.104@linaro.org>
References: <1432893209-27313-1-git-send-email-andre.przywara@arm.com>
 <1432893209-27313-14-git-send-email-andre.przywara@arm.com>
 <558284B4.104@linaro.org>
Message-ID: <5582D410.60708@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

On 06/18/2015 09:43 AM, Eric Auger wrote:
> On 05/29/2015 11:53 AM, Andre Przywara wrote:
>> If userspace has provided a base address for the ITS register frame,
>> we enable the bits that advertise LPIs in the GICv3.
>> When the guest has enabled LPIs and the ITS, we enable the emulation
>> part by initializing the ITS data structures and trapping on ITS
>> register frame accesses by the guest.
>> Also we enable the KVM_SIGNAL_MSI feature to allow userland to inject
>> MSIs into the guest. Not having enabled the ITS emulation will lead
>> to a -ENODEV when trying to inject a MSI.
>>

....

>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>> diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
>> index 9f7b05f..09b1f46 100644
>> --- a/virt/kvm/arm/vgic.c
>> +++ b/virt/kvm/arm/vgic.c
>> @@ -2254,3 +2254,13 @@ int kvm_set_msi(struct kvm_kernel_irq_routing_entry *e,
>>  {
>>  	return 0;
>>  }
>> +
>> +#ifdef CONFIG_HAVE_KVM_MSI
> I don't think the if#def is requested since the entry is already
> prevented in kvm_main.c in, case KVM_SIGNAL_MSI.

But that fails compilation on ARM (which uses this file as well),
because we have a dummy fail function in the header if
CONFIG_HAVE_KVM_MSI is not defined.
So you get: error: redefinition of 'kvm_send_userspace_msi'

Cheers,
Andre.

>> +int kvm_send_userspace_msi(struct kvm *kvm, struct kvm_msi *msi)
>> +{
>> +	if (kvm->arch.vgic.vm_ops.inject_msi)
>> +		return kvm->arch.vgic.vm_ops.inject_msi(kvm, msi);
>> +	else
>> +		return -ENODEV;
>> +}
>> +#endif
>>
> 
