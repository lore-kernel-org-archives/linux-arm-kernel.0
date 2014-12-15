From: andre.przywara@arm.com (Andre Przywara)
Date: Mon, 15 Dec 2014 11:50:44 +0000
Subject: [PATCH v5 19/19] arm/arm64: KVM: allow userland to request a
 virtual GICv3
In-Reply-To: <20141213134502.GH16855@cbox>
References: <1418042274-3246-1-git-send-email-andre.przywara@arm.com>
 <1418042274-3246-20-git-send-email-andre.przywara@arm.com>
 <20141213134502.GH16855@cbox>
Message-ID: <548ECB14.8040408@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoffer,

On 13/12/14 13:45, Christoffer Dall wrote:
> On Mon, Dec 08, 2014 at 12:37:54PM +0000, Andre Przywara wrote:
>> With all of the GICv3 code in place now we allow userland to ask the
>> kernel for using a virtual GICv3 in the guest.
>> Also we provide the necessary support for guests setting the memory
>> addresses for the virtual distributor and redistributors.
>> This requires some userland code to make use of that feature and
>> explicitly ask for a virtual GICv3.
>>
>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>> ---
>> Changelog v4...v5:
>> - improving documentation text
>>
>> Changelog v3...v4:
>> - refine commit message
>> - add documentation of new GICv3 KVM device
>>
>>  Documentation/virtual/kvm/devices/arm-vgic.txt |   22 ++++++++++--
>>  arch/arm64/include/uapi/asm/kvm.h              |    7 ++++
>>  include/kvm/arm_vgic.h                         |    4 +--
>>  virt/kvm/arm/vgic-v3-emul.c                    |    3 ++
>>  virt/kvm/arm/vgic.c                            |   46 +++++++++++++++++-------
>>  5 files changed, 65 insertions(+), 17 deletions(-)
>>
>> diff --git a/Documentation/virtual/kvm/devices/arm-vgic.txt b/Documentation/virtual/kvm/devices/arm-vgic.txt
>> index df8b0c7..563463e 100644
>> --- a/Documentation/virtual/kvm/devices/arm-vgic.txt
>> +++ b/Documentation/virtual/kvm/devices/arm-vgic.txt
>> @@ -3,22 +3,38 @@ ARM Virtual Generic Interrupt Controller (VGIC)
>>  
>>  Device types supported:
>>    KVM_DEV_TYPE_ARM_VGIC_V2     ARM Generic Interrupt Controller v2.0
>> +  KVM_DEV_TYPE_ARM_VGIC_V3     ARM Generic Interrupt Controller v3.0
>>  
>>  Only one VGIC instance may be instantiated through either this API or the
>>  legacy KVM_CREATE_IRQCHIP api.  The created VGIC will act as the VM interrupt
>>  controller, requiring emulated user-space devices to inject interrupts to the
>>  VGIC instead of directly to CPUs.
>>  
>> +Creating a guest GICv3 device requires a host GICv3 as well.
>> +GICv3 implementations with hardware compatibility support allow a guest GICv2
>> +as well.
>> +
>>  Groups:
>>    KVM_DEV_ARM_VGIC_GRP_ADDR
>>    Attributes:
>>      KVM_VGIC_V2_ADDR_TYPE_DIST (rw, 64-bit)
>>        Base address in the guest physical address space of the GIC distributor
>> -      register mappings.
>> +      register mappings. Only valid for KVM_DEV_TYPE_ARM_VGIC_V2.
>>  
>>      KVM_VGIC_V2_ADDR_TYPE_CPU (rw, 64-bit)
>>        Base address in the guest physical address space of the GIC virtual cpu
>> -      interface register mappings.
>> +      interface register mappings. Only valid for KVM_DEV_TYPE_ARM_VGIC_V2.
>> +
>> +    KVM_VGIC_V3_ADDR_TYPE_DIST (rw, 64-bit)
>> +      Base address in the guest physical address space of the GICv3 distributor
>> +      register mappings. Only valid for KVM_DEV_TYPE_ARM_VGIC_V3.
>> +
> 
> Are there no alignment restrictions to worry about that we should
> document here?

I think so, but that is not GICv3 specific, but applies to the VGICv2
also, right? So shall I add a sentence like
"The base address needs to be aligned to a 64 KB page boundary."
for GICv3 and
"The base address needs to be aligned to a 4 KB page boundary."
for GICv2?
Shouldn't the 64K alignment actually apply for GICv2 on AArch64 also?
That would avoid some trouble in the future, wouldn't it?

Also I think we need to actually check for the 64K alignment for GICv3
(we only check for 4K atm).

Cheers,
Andre.
