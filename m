From: alex.bennee@linaro.org (Alex =?utf-8?Q?Benn=C3=A9e?=)
Date: Mon, 02 Mar 2015 14:20:33 +0000
Subject: [PATCH 3/4] arm/arm64: KVM: Fix migration race in the arch timer
In-Reply-To: <54F4297A.40905@arm.com>
References: <1424878582-26397-1-git-send-email-alex.bennee@linaro.org>
 <1424878582-26397-4-git-send-email-alex.bennee@linaro.org>
 <20150228133003.29d59e96@arm.com> <87twy36avw.fsf@linaro.org>
 <54F4297A.40905@arm.com>
Message-ID: <87a8zv32ha.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Marc Zyngier <marc.zyngier@arm.com> writes:

> On 02/03/15 08:50, Alex Benn?e wrote:
>> 
>> Marc Zyngier <marc.zyngier@arm.com> writes:
>> 
>>> On Wed, 25 Feb 2015 15:36:21 +0000
>>> Alex Benn?e <alex.bennee@linaro.org> wrote:
>>>
>>> Alex, Christoffer,
>>>
>> <snip>
>>>
>>> So the first half of the patch looks perfectly OK to me...
>>>
>>>> diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
>>>> index af6a521..3b4ded2 100644
>>>> --- a/virt/kvm/arm/vgic.c
>>>> +++ b/virt/kvm/arm/vgic.c
>>>> @@ -263,6 +263,13 @@ static int vgic_irq_is_queued(struct kvm_vcpu
>>>> *vcpu, int irq) return vgic_bitmap_get_irq_val(&dist->irq_queued,
>>>> vcpu->vcpu_id, irq); }
>>>>  
>>>> +static int vgic_irq_is_active(struct kvm_vcpu *vcpu, int irq)
>>>> +{
>>>> +	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
>>>> +
>>>> +	return vgic_bitmap_get_irq_val(&dist->irq_active,
>>>> vcpu->vcpu_id, irq); +}
>>>> +
>>>>  static void vgic_irq_set_queued(struct kvm_vcpu *vcpu, int irq)
>>>>  {
>>>>  	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
>>>> @@ -285,6 +292,13 @@ static void vgic_irq_set_active(struct kvm_vcpu
>>>> *vcpu, int irq) vgic_bitmap_set_irq_val(&dist->irq_active,
>>>> vcpu->vcpu_id, irq, 1); }
>>>>  
>>>> +static void vgic_irq_clear_active(struct kvm_vcpu *vcpu, int irq)
>>>> +{
>>>> +	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
>>>> +
>>>> +	vgic_bitmap_set_irq_val(&dist->irq_active, vcpu->vcpu_id,
>>>> irq, 0); +}
>>>> +
>>>>  static int vgic_dist_irq_get_level(struct kvm_vcpu *vcpu, int irq)
>>>>  {
>>>>  	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
>>>> @@ -634,16 +648,12 @@ bool vgic_handle_cfg_reg(u32 *reg, struct
>>>> kvm_exit_mmio *mmio, }
>>>>  
>>>>  /**
>>>> - * vgic_unqueue_irqs - move pending IRQs from LRs to the distributor
>>>> + * vgic_unqueue_irqs - move pending/active IRQs from LRs to the
>>>> distributor
>>>>   * @vgic_cpu: Pointer to the vgic_cpu struct holding the LRs
>>>>   *
>>>> - * Move any pending IRQs that have already been assigned to LRs back
>>>> to the
>>>> + * Move any IRQs that have already been assigned to LRs back to the
>>>>   * emulated distributor state so that the complete emulated state
>>>> can be read
>>>>   * from the main emulation structures without investigating the LRs.
>>>> - *
>>>> - * Note that IRQs in the active state in the LRs get their pending
>>>> state moved
>>>> - * to the distributor but the active state stays in the LRs, because
>>>> we don't
>>>> - * track the active state on the distributor side.
>>>>   */
>>>>  void vgic_unqueue_irqs(struct kvm_vcpu *vcpu)
>>>>  {
>>>> @@ -919,7 +929,7 @@ static int compute_pending_for_cpu(struct
>>>> kvm_vcpu *vcpu) 
>>>>  /*
>>>>   * Update the interrupt state and determine which CPUs have pending
>>>> - * interrupts. Must be called with distributor lock held.
>>>> + * or active interrupts. Must be called with distributor lock held.
>>>>   */
>>>>  void vgic_update_state(struct kvm *kvm)
>>>>  {
>>>> @@ -1036,6 +1046,25 @@ static void vgic_retire_disabled_irqs(struct
>>>> kvm_vcpu *vcpu) }
>>>>  }
>>>>  
>>>> +static void vgic_queue_irq_to_lr(struct kvm_vcpu *vcpu, int irq,
>>>> +				 int lr_nr, struct vgic_lr vlr)
>>>> +{
>>>> +	if (vgic_irq_is_active(vcpu, irq)) {
>>>> +		vlr.state |= LR_STATE_ACTIVE;
>>>> +		kvm_debug("Set active, clear distributor: 0x%x\n",
>>>> vlr.state);
>>>> +		vgic_irq_clear_active(vcpu, irq);
>>>> +		vgic_update_state(vcpu->kvm);
>>>> +	} else if (vgic_dist_irq_is_pending(vcpu, irq)) {
>>>> +		vlr.state |= LR_STATE_PENDING;
>>>> +		kvm_debug("Set pending: 0x%x\n", vlr.state);
>>>> +	}
>>>> +
>>>> +	if (!vgic_irq_is_edge(vcpu, irq))
>>>> +		vlr.state |= LR_EOI_INT;
>>>> +
>>>> +	vgic_set_lr(vcpu, lr_nr, vlr);
>>>> +}
>>>> +
>>>>  /*
>>>>   * Queue an interrupt to a CPU virtual interface. Return true on
>>>> success,
>>>>   * or false if it wasn't possible to queue it.
>>>> @@ -1063,8 +1092,7 @@ bool vgic_queue_irq(struct kvm_vcpu *vcpu, u8
>>>> sgi_source_id, int irq) if (vlr.source == sgi_source_id) {
>>>>  			kvm_debug("LR%d piggyback for IRQ%d\n", lr,
>>>> vlr.irq); BUG_ON(!test_bit(lr, vgic_cpu->lr_used));
>>>> -			vlr.state |= LR_STATE_PENDING;
>>>> -			vgic_set_lr(vcpu, lr, vlr);
>>>> +			vgic_queue_irq_to_lr(vcpu, irq, lr, vlr);
>>>>  			return true;
>>>>  		}
>>>>  	}
>>>> @@ -1081,11 +1109,8 @@ bool vgic_queue_irq(struct kvm_vcpu *vcpu, u8
>>>> sgi_source_id, int irq) 
>>>>  	vlr.irq = irq;
>>>>  	vlr.source = sgi_source_id;
>>>> -	vlr.state = LR_STATE_PENDING;
>>>> -	if (!vgic_irq_is_edge(vcpu, irq))
>>>> -		vlr.state |= LR_EOI_INT;
>>>> -
>>>> -	vgic_set_lr(vcpu, lr, vlr);
>>>> +	vlr.state = 0;
>>>> +	vgic_queue_irq_to_lr(vcpu, irq, lr, vlr);
>>>>  
>>>>  	return true;
>>>>  }
>>>
>>>
>>> ... but this whole vgic rework seems rather out of place, and I can't
>>> really see its connection with the timer. Isn't it logically part of the
>>> previous patch?
>> 
>> Probably - I was going to re-factor that code with the original patch
>> but it was on the todo list once we had it working. Christoffer than
>> cleaned it up when he fixed the race hence it being here.
>> 
>> Would you like it as a separate patch (between 2 and 3) or just rolled
>> into the previous patch?
>
> In general, I prefer smaller patches (keeps the few brain cells left
> from overheating), so if these changes make sense on their own, please
> post them as a separate patch.

Done, new series re-sent.

>
> Thanks,
>
> 	M.

-- 
Alex Benn?e
