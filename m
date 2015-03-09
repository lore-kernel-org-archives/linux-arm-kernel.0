From: alex.bennee@linaro.org (Alex =?utf-8?Q?Benn=C3=A9e?=)
Date: Mon, 09 Mar 2015 16:40:57 +0000
Subject: [PATCH v2 2/5] arm/arm64: KVM: Implement support for unqueueing
 active IRQs
In-Reply-To: <20150309144148.GD20559@cbox>
References: <1425302944-6276-1-git-send-email-alex.bennee@linaro.org>
 <1425302944-6276-3-git-send-email-alex.bennee@linaro.org>
 <20150309144148.GD20559@cbox>
Message-ID: <87oao2azty.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Christoffer Dall <christoffer.dall@linaro.org> writes:

> On Mon, Mar 02, 2015 at 01:29:01PM +0000, Alex Benn?e wrote:
>> From: Christoffer Dall <christoffer.dall@linaro.org>
>> 
>> Migrating active interrupts causes the active state to be lost
>> completely. This implements some additional bitmaps to track the active
>> state on the distributor and export this to user space.
>> 
>> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
>> Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>
>> 
>> ---
>> AJB:
>>    - fixed merge conflicts
>>    - moved additional shared bitmaps to be dynamically allocated
>>    - make irq_active_on_cpu dynamically allocated as well
>>    - in vgic_queue_irq don't queue pending if already active
>>    - in __kvm_vgic_flush_hwstate use pr_shared when checking SPIs
>>    - vgic: clear active on CPU bit
>>    - checkpatch, remove extraneous braces
>>    - checkpatch, remove debug, fix overflows
>>    - move register access fns to re-factored vgic-v2-emul.c
>> v2
>>    - doc: unqueue and update_state
>> 
>> diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
>> index 7c55dd5..7042251 100644
<snip>
> if you respin:                         the active state
> if you respin:     Mark the

OK

<snip>
>>  
>> @@ -1030,39 +1113,49 @@ static void __kvm_vgic_flush_hwstate(struct kvm_vcpu *vcpu)
>>  {
>>  	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
>>  	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
>> +	unsigned long *pa_percpu, *pa_shared;
>>  	int i, vcpu_id;
>>  	int overflow = 0;
>> +	int nr_shared = vgic_nr_shared_irqs(dist);
>>  
>>  	vcpu_id = vcpu->vcpu_id;
>>  
>> +	pa_percpu = vcpu->arch.vgic_cpu.pend_act_percpu;
>> +	pa_shared = vcpu->arch.vgic_cpu.pend_act_shared;
>> +
>> +	bitmap_or(pa_percpu, vgic_cpu->pending_percpu, vgic_cpu->active_percpu,
>> +		  VGIC_NR_PRIVATE_IRQS);
>> +	bitmap_or(pa_shared, vgic_cpu->pending_shared, vgic_cpu->active_shared,
>> +		  nr_shared);
>>  	/*
>>  	 * We may not have any pending interrupt, or the interrupts
>>  	 * may have been serviced from another vcpu. In all cases,
>>  	 * move along.
>>  	 */
>> -	if (!kvm_vgic_vcpu_pending_irq(vcpu)) {
>> -		pr_debug("CPU%d has no pending interrupt\n", vcpu_id);
>> +	if (!kvm_vgic_vcpu_pending_irq(vcpu) && !kvm_vgic_vcpu_active_irq(vcpu))
>>  		goto epilog;
>> -	}
>>  
>>  	/* SGIs */
>> -	for_each_set_bit(i, vgic_cpu->pending_percpu, VGIC_NR_SGIS) {
>> +	for_each_set_bit(i, pa_percpu, VGIC_NR_SGIS) {
>>  		if (!queue_sgi(vcpu, i))
>>  			overflow = 1;
>>  	}
>>  
>>  	/* PPIs */
>> -	for_each_set_bit_from(i, vgic_cpu->pending_percpu, VGIC_NR_PRIVATE_IRQS) {
>> +	for_each_set_bit_from(i, pa_percpu, VGIC_NR_PRIVATE_IRQS) {
>>  		if (!vgic_queue_hwirq(vcpu, i))
>>  			overflow = 1;
>>  	}
>>  
>>  	/* SPIs */
>> -	for_each_set_bit(i, vgic_cpu->pending_shared, vgic_nr_shared_irqs(dist)) {
>> +	for_each_set_bit(i, pa_shared, nr_shared) {
>>  		if (!vgic_queue_hwirq(vcpu, i + VGIC_NR_PRIVATE_IRQS))
>>  			overflow = 1;
>>  	}
>
> meh, these changes will now produce a quite strange result if one
> bisects at this specific patch, since we will be setting pending
> interrupts to active....  I thought it was more clear as one patch
> containing the changes to vgic_queue_... imho.

I split the re-factor off by Marc's request but your right it becomes a
little weird. Now the horror of dealing with the merge conflicts is done
I could split the next patch and add it before this one:

* add a common vgic_queue_irq_to_lr fn (just deal with pending)
* Implement support for unqueuing active IRQs (expand vgic_queue_irq_to_lr)

>
> Thoughts?
>
>>  
>> +
>> +
>> +
>>  epilog:
>>  	if (overflow) {
>>  		vgic_enable_underflow(vcpu);
>> @@ -1209,6 +1302,17 @@ int kvm_vgic_vcpu_pending_irq(struct kvm_vcpu *vcpu)
>>  	return test_bit(vcpu->vcpu_id, dist->irq_pending_on_cpu);
>>  }
>>  
>> +int kvm_vgic_vcpu_active_irq(struct kvm_vcpu *vcpu)
>> +{
>> +	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
>> +
>> +	if (!irqchip_in_kernel(vcpu->kvm))
>> +		return 0;
>> +
>> +	return test_bit(vcpu->vcpu_id, dist->irq_active_on_cpu);
>> +}
>> +
>> +
>>  void vgic_kick_vcpus(struct kvm *kvm)
>>  {
>>  	struct kvm_vcpu *vcpu;
>> @@ -1381,8 +1485,12 @@ void kvm_vgic_vcpu_destroy(struct kvm_vcpu *vcpu)
>>  	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
>>  
>>  	kfree(vgic_cpu->pending_shared);
>> +	kfree(vgic_cpu->active_shared);
>> +	kfree(vgic_cpu->pend_act_shared);
>>  	kfree(vgic_cpu->vgic_irq_lr_map);
>>  	vgic_cpu->pending_shared = NULL;
>> +	vgic_cpu->active_shared = NULL;
>> +	vgic_cpu->pend_act_shared = NULL;
>>  	vgic_cpu->vgic_irq_lr_map = NULL;
>>  }
>>  
>> @@ -1392,9 +1500,14 @@ static int vgic_vcpu_init_maps(struct kvm_vcpu *vcpu, int nr_irqs)
>>  
>>  	int sz = (nr_irqs - VGIC_NR_PRIVATE_IRQS) / 8;
>>  	vgic_cpu->pending_shared = kzalloc(sz, GFP_KERNEL);
>> +	vgic_cpu->active_shared = kzalloc(sz, GFP_KERNEL);
>> +	vgic_cpu->pend_act_shared = kzalloc(sz, GFP_KERNEL);
>>  	vgic_cpu->vgic_irq_lr_map = kmalloc(nr_irqs, GFP_KERNEL);
>>  
>> -	if (!vgic_cpu->pending_shared || !vgic_cpu->vgic_irq_lr_map) {
>> +	if (!vgic_cpu->pending_shared
>> +		|| !vgic_cpu->active_shared
>> +		|| !vgic_cpu->pend_act_shared
>> +		|| !vgic_cpu->vgic_irq_lr_map) {
>>  		kvm_vgic_vcpu_destroy(vcpu);
>>  		return -ENOMEM;
>>  	}
>> @@ -1447,10 +1560,12 @@ void kvm_vgic_destroy(struct kvm *kvm)
>>  	kfree(dist->irq_spi_mpidr);
>>  	kfree(dist->irq_spi_target);
>>  	kfree(dist->irq_pending_on_cpu);
>> +	kfree(dist->irq_active_on_cpu);
>>  	dist->irq_sgi_sources = NULL;
>>  	dist->irq_spi_cpu = NULL;
>>  	dist->irq_spi_target = NULL;
>>  	dist->irq_pending_on_cpu = NULL;
>> +	dist->irq_active_on_cpu = NULL;
>>  	dist->nr_cpus = 0;
>>  }
>>  
>> @@ -1486,6 +1601,7 @@ int vgic_init(struct kvm *kvm)
>>  	ret |= vgic_init_bitmap(&dist->irq_pending, nr_cpus, nr_irqs);
>>  	ret |= vgic_init_bitmap(&dist->irq_soft_pend, nr_cpus, nr_irqs);
>>  	ret |= vgic_init_bitmap(&dist->irq_queued, nr_cpus, nr_irqs);
>> +	ret |= vgic_init_bitmap(&dist->irq_active, nr_cpus, nr_irqs);
>>  	ret |= vgic_init_bitmap(&dist->irq_cfg, nr_cpus, nr_irqs);
>>  	ret |= vgic_init_bytemap(&dist->irq_priority, nr_cpus, nr_irqs);
>>  
>> @@ -1498,10 +1614,13 @@ int vgic_init(struct kvm *kvm)
>>  				       GFP_KERNEL);
>>  	dist->irq_pending_on_cpu = kzalloc(BITS_TO_LONGS(nr_cpus) * sizeof(long),
>>  					   GFP_KERNEL);
>> +	dist->irq_active_on_cpu = kzalloc(BITS_TO_LONGS(nr_cpus) * sizeof(long),
>> +					   GFP_KERNEL);
>>  	if (!dist->irq_sgi_sources ||
>>  	    !dist->irq_spi_cpu ||
>>  	    !dist->irq_spi_target ||
>> -	    !dist->irq_pending_on_cpu) {
>> +	    !dist->irq_pending_on_cpu ||
>> +	    !dist->irq_active_on_cpu) {
>>  		ret = -ENOMEM;
>>  		goto out;
>>  	}
>> diff --git a/virt/kvm/arm/vgic.h b/virt/kvm/arm/vgic.h
>> index 1e83bdf..1e5a381 100644
>> --- a/virt/kvm/arm/vgic.h
>> +++ b/virt/kvm/arm/vgic.h
>> @@ -107,6 +107,14 @@ bool vgic_handle_set_pending_reg(struct kvm *kvm, struct kvm_exit_mmio *mmio,
>>  bool vgic_handle_clear_pending_reg(struct kvm *kvm, struct kvm_exit_mmio *mmio,
>>  				   phys_addr_t offset, int vcpu_id);
>>  
>> +bool vgic_handle_set_active_reg(struct kvm *kvm,
>> +				struct kvm_exit_mmio *mmio,
>> +				phys_addr_t offset, int vcpu_id);
>> +
>> +bool vgic_handle_clear_active_reg(struct kvm *kvm,
>> +				  struct kvm_exit_mmio *mmio,
>> +				  phys_addr_t offset, int vcpu_id);
>> +
>>  bool vgic_handle_cfg_reg(u32 *reg, struct kvm_exit_mmio *mmio,
>>  			 phys_addr_t offset);
>>  
>> -- 
>> 2.3.0
>> 

-- 
Alex Benn?e
