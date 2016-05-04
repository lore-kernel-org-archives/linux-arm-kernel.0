From: andre.przywara@arm.com (Andre Przywara)
Date: Wed, 4 May 2016 11:37:51 +0100
Subject: [PATCH v2 06/54] KVM: arm/arm64: arch_timer: Remove irq_phys_map
In-Reply-To: <572783E2.30204@linaro.org>
References: <1461861973-26464-1-git-send-email-andre.przywara@arm.com>
 <1461861973-26464-7-git-send-email-andre.przywara@arm.com>
 <572783E2.30204@linaro.org>
Message-ID: <5729D0FF.1030604@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

On 02/05/16 17:44, Eric Auger wrote:
> On 04/28/2016 06:45 PM, Andre Przywara wrote:
>> Now that the interface between the arch timer and the VGIC does not
>> require passing the irq_phys_map entry pointer anymore, let's remove
>> it from the virtual arch timer and use the virtual IRQ number instead
>> directly.
>> The remaining pointer returned by kvm_vgic_map_phys_irq() will be
>> removed in the following patch.
>>
>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>> ---
>> Changelog v1 .. v2:
>> - remove extra virt_irq member from struct, instead use irq.irq directly
>>
>>  include/kvm/arm_arch_timer.h |  3 ---
>>  virt/kvm/arm/arch_timer.c    | 11 +++++------
>>  2 files changed, 5 insertions(+), 9 deletions(-)
>>
>> diff --git a/include/kvm/arm_arch_timer.h b/include/kvm/arm_arch_timer.h
>> index b651aed..a47b7de 100644
>> --- a/include/kvm/arm_arch_timer.h
>> +++ b/include/kvm/arm_arch_timer.h
>> @@ -53,9 +53,6 @@ struct arch_timer_cpu {
>>  	/* Timer IRQ */
>>  	struct kvm_irq_level		irq;
>>  
>> -	/* VGIC mapping */
>> -	struct irq_phys_map		*map;
>> -
>>  	/* Active IRQ state caching */
>>  	bool				active_cleared_last;
>>  };
>> diff --git a/virt/kvm/arm/arch_timer.c b/virt/kvm/arm/arch_timer.c
>> index b470632..3a74b17 100644
>> --- a/virt/kvm/arm/arch_timer.c
>> +++ b/virt/kvm/arm/arch_timer.c
>> @@ -175,10 +175,10 @@ static void kvm_timer_update_irq(struct kvm_vcpu *vcpu, bool new_level)
>>  
>>  	timer->active_cleared_last = false;
>>  	timer->irq.level = new_level;
>> -	trace_kvm_timer_update_irq(vcpu->vcpu_id, timer->map->virt_irq,
>> +	trace_kvm_timer_update_irq(vcpu->vcpu_id, timer->irq.irq,
>>  				   timer->irq.level);
>>  	ret = kvm_vgic_inject_mapped_irq(vcpu->kvm, vcpu->vcpu_id,
>> -					 timer->map->virt_irq,
>> +					 timer->irq.irq,
>>  					 timer->irq.level);
>>  	WARN_ON(ret);
>>  }
>> @@ -276,7 +276,7 @@ void kvm_timer_flush_hwstate(struct kvm_vcpu *vcpu)
>>  	* exit.
>>  	*/
>>  	phys_active = timer->irq.level ||
>> -			kvm_vgic_map_is_active(vcpu, timer->map->virt_irq);
>> +			kvm_vgic_map_is_active(vcpu, timer->irq.irq);
>>  
>>  	/*
>>  	 * We want to avoid hitting the (re)distributor as much as
>> @@ -378,7 +378,6 @@ int kvm_timer_vcpu_reset(struct kvm_vcpu *vcpu,
>>  	if (WARN_ON(IS_ERR(map)))
>>  		return PTR_ERR(map);
>>  
>> -	timer->map = map;
>>  	return 0;
>>  }
>>  
>> @@ -521,8 +520,8 @@ void kvm_timer_vcpu_terminate(struct kvm_vcpu *vcpu)
>>  	struct arch_timer_cpu *timer = &vcpu->arch.timer_cpu;
>>  
>>  	timer_disarm(timer);
>> -	if (timer->map)
>> -		kvm_vgic_unmap_phys_irq(vcpu, timer->map->virt_irq);
>> +	if (timer->irq.irq)
>> +		kvm_vgic_unmap_phys_irq(vcpu, timer->irq.irq);
> thought you agreed to always unmap. Is it an oversight or did you change
> your mind?

I wasn't sure about it. So for the old VGIC implementation having an
illegal IRQ number seems to be fine (just nothing will be found in the
map search), but on the new VGIC it will trigger a BUG_ON, so I was
wondering if we should play safe here and also mimic the current code,
which does this safety check for some reason.

But looking at the (current) callers again, it looks like there is
always "27" passed in here anyways, so I guess we are safe to remove it.

So if no-one intervenes, I will remove the check.

Cheers,
Andre.

> Besides Reviewed-by: Eric Auger <eric.auger@linaro.org>
> 
> Cheers
> 
> Eric
>>  }
>>  
>>  void kvm_timer_enable(struct kvm *kvm)
>>
> 
