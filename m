From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 21 Jul 2015 19:02:25 +0100
Subject: [PATCH v2 03/10] KVM: arm/arm64: vgic: Convert struct vgic_lr
 to use bitfields
In-Reply-To: <20150717221534.GJ14024@cbox>
References: <1436378202-20224-1-git-send-email-marc.zyngier@arm.com>
 <1436378202-20224-4-git-send-email-marc.zyngier@arm.com>
 <20150717221534.GJ14024@cbox>
Message-ID: <55AE8931.7020806@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/07/15 23:15, Christoffer Dall wrote:
> On Wed, Jul 08, 2015 at 06:56:35PM +0100, Marc Zyngier wrote:
>> As we're about to cram more information in the vgic_lr structure
>> (HW interrupt number and additional state information), we switch
>> to a layout similar to the HW's:
>>
>> - use bitfields to save space (we don't need more than 10 bits
>>   to represent the irq numbers)
>> - source CPU and HW interrupt can share the same field, as
>>   a SGI doesn't have a physical line.
>>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> Reviewed-by: Alex Benn?e <alex.bennee@linaro.org>
>> ---
>>  include/kvm/arm_vgic.h | 10 +++++++---
>>  1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
>> index 133ea00..4f9fa1d 100644
>> --- a/include/kvm/arm_vgic.h
>> +++ b/include/kvm/arm_vgic.h
>> @@ -95,11 +95,15 @@ enum vgic_type {
>>  #define LR_STATE_ACTIVE		(1 << 1)
>>  #define LR_STATE_MASK		(3 << 0)
>>  #define LR_EOI_INT		(1 << 2)
>> +#define LR_HW			(1 << 3)
>>  
>>  struct vgic_lr {
>> -	u16	irq;
>> -	u8	source;
>> -	u8	state;
>> +	unsigned irq:10;
>> +	union {
>> +		unsigned hwirq:10;
>> +		unsigned source:8;
> 
> why 8?  why not 3?

Because I can't count :-).

>> +	};
>> +	unsigned state:4;
>>  };
>>  
>>  struct vgic_vmcr {
>> -- 
>> 2.1.4
>>
> 
> otherwise:
> 
> Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
> 

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
