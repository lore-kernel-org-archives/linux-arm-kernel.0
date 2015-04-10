From: andre.przywara@arm.com (Andre Przywara)
Date: Fri, 10 Apr 2015 17:52:05 +0100
Subject: [PATCH] KVM: arm/arm64: check IRQ number on userland injection
In-Reply-To: <5527EC52.4050500@codeaurora.org>
References: <1428679079-16499-1-git-send-email-andre.przywara@arm.com>
 <5527EC52.4050500@codeaurora.org>
Message-ID: <5527FFB5.9020103@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christopher,

On 10/04/15 16:29, Christopher Covington wrote:
> Hi Andre,
> 
> On 04/10/2015 11:17 AM, Andre Przywara wrote:
>> When userland injects a SPI via the KVM_IRQ_LINE ioctl we currently
>> only check it against a fixed limit, which historically is set
>> to 127. With the new dynamic IRQ allocation the effective limit may
>> actually be smaller (64).
>> So when now a malicious or buggy userland injects a SPI in that
>> range, we spill over on our VGIC bitmaps and bytemaps memory.
>> I could trigger a host kernel NULL pointer dereference with current
>> mainline by injecting some bogus IRQ number from a hacked kvmtool:
> 
>> --- a/arch/arm/include/uapi/asm/kvm.h
>> +++ b/arch/arm/include/uapi/asm/kvm.h
>> @@ -195,7 +195,11 @@ struct kvm_arch_memory_slot {
>>  #define KVM_ARM_IRQ_CPU_IRQ		0
>>  #define KVM_ARM_IRQ_CPU_FIQ		1
>>  
>> -/* Highest supported SPI, from VGIC_NR_IRQS */
>> +/*
>> + * This used to hold the highest supported SPI, but it is now obsolete
>> + * and only here to provide source code level compatibility with older
>> + * userland. The highest SPI number can be set via KVM_DEV_ARM_VGIC_GRP_NR_IRQS.
>> + */
>>  #define KVM_ARM_IRQ_GIC_MAX		127
> 
> If that's the case should it maybe only defined when __KERNEL__ is not defined?

Mmmh, I am not sure it's really worth the hassle. Actually it seems like
that neither kvmtool nor QEMU use this definition, so it's more or less
orphaned by now. I am confident we can avoid it sneaking in in the
kernel again.

Cheers,
Andre.
