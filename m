From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 28 Nov 2012 13:09:37 +0000
Subject: [PATCH v4 03/13] ARM: KVM: Initial VGIC infrastructure support
In-Reply-To: <20121128124955.GE21671@mudshark.cambridge.arm.com>
References: <20121110154358.3061.16338.stgit@chazy-air>
 <20121110154437.3061.76180.stgit@chazy-air>
 <20121128124955.GE21671@mudshark.cambridge.arm.com>
Message-ID: <50B60D11.7000904@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/11/12 12:49, Will Deacon wrote:
> On Sat, Nov 10, 2012 at 03:44:37PM +0000, Christoffer Dall wrote:
>> From: Marc Zyngier <marc.zyngier@arm.com>
>>
>> Wire the basic framework code for VGIC support. Nothing to enable
>> yet.
> 
> Again, not sure how useful this patch is. Might as well merge it with code
> that actually does something. Couple of comments inline anyway...
>  
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
>> ---
>>  arch/arm/include/asm/kvm_host.h |    7 ++++
>>  arch/arm/include/asm/kvm_vgic.h |   70 +++++++++++++++++++++++++++++++++++++++
>>  arch/arm/kvm/arm.c              |   21 +++++++++++-
>>  arch/arm/kvm/interrupts.S       |    4 ++
>>  arch/arm/kvm/mmio.c             |    3 ++
>>  virt/kvm/kvm_main.c             |    5 ++-
>>  6 files changed, 107 insertions(+), 3 deletions(-)
>>  create mode 100644 arch/arm/include/asm/kvm_vgic.h
> 
> [...]
> 
>> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
>> index 60b119a..426828a 100644
>> --- a/arch/arm/kvm/arm.c
>> +++ b/arch/arm/kvm/arm.c
>> @@ -183,6 +183,9 @@ int kvm_dev_ioctl_check_extension(long ext)
>>  {
>>  	int r;
>>  	switch (ext) {
>> +#ifdef CONFIG_KVM_ARM_VGIC
>> +	case KVM_CAP_IRQCHIP:
>> +#endif
>>  	case KVM_CAP_USER_MEMORY:
>>  	case KVM_CAP_DESTROY_MEMORY_REGION_WORKS:
>>  	case KVM_CAP_ONE_REG:
>> @@ -304,6 +307,10 @@ int kvm_arch_vcpu_init(struct kvm_vcpu *vcpu)
>>  {
>>  	/* Force users to call KVM_ARM_VCPU_INIT */
>>  	vcpu->arch.target = -1;
>> +
>> +	/* Set up VGIC */
>> +	kvm_vgic_vcpu_init(vcpu);
>> +
>>  	return 0;
>>  }
>>  
>> @@ -363,7 +370,7 @@ int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
>>   */
>>  int kvm_arch_vcpu_runnable(struct kvm_vcpu *v)
>>  {
>> -	return !!v->arch.irq_lines;
>> +	return !!v->arch.irq_lines || kvm_vgic_vcpu_pending_irq(v);
>>  }
> 
> So interrupt injection without the in-kernel GIC updates irq_lines, but the
> in-kernel GIC has its own separate data structures? Why can't the in-kernel GIC
> just use irq_lines instead of irq_pending_on_cpu?

They serve very different purposes:
- irq_lines directly controls the IRQ and FIQ lines (it is or-ed into
the HCR register before entering the guest)
- irq_pending_on_cpu deals with the CPU interface, and only that. Plus,
it is a kernel only thing. What triggers the interrupt on the guest is
the presence of list registers with a pending state.

You signal interrupts one way or the other.

> 
>>  
>>  int kvm_arch_vcpu_in_guest_mode(struct kvm_vcpu *v)
>> @@ -633,6 +640,8 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
>>  
>>  		update_vttbr(vcpu->kvm);
>>  
>> +		kvm_vgic_sync_to_cpu(vcpu);
>> +
>>  		local_irq_disable();
>>  
>>  		/*
>> @@ -645,6 +654,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
>>  
>>  		if (ret <= 0 || need_new_vmid_gen(vcpu->kvm)) {
>>  			local_irq_enable();
>> +			kvm_vgic_sync_from_cpu(vcpu);
>>  			continue;
>>  		}
> 
> For VFP, we use different terminology (sync and flush). I don't think they're
> any clearer than what you have, but the consistency would be nice.

Which one maps to which?

> Given that both these functions are run with interrupts enabled, why doesn't
> the second require a lock for updating dist->irq_pending_on_cpu? I notice
> there's a random smp_mb() over there...

Updating *only* irq_pending_on_cpu doesn't require the lock (set_bit()
should be safe, and I think the smp_mb() is a leftover of some debugging
hack). kvm_vgic_to_cpu() does a lot more (it picks interrupt from the
distributor, hence requires the lock to be taken).

>>  
>> @@ -683,6 +693,8 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
>>  		 * Back from guest
>>  		 *************************************************************/
>>  
>> +		kvm_vgic_sync_from_cpu(vcpu);
> 
> Likewise.
> 
>>  		ret = handle_exit(vcpu, run, ret);
>>  	}
>>  
>> @@ -965,6 +977,13 @@ static int init_hyp_mode(void)
>>  		}
>>  	}
>>  
>> +	/*
>> +	 * Init HYP view of VGIC
>> +	 */
>> +	err = kvm_vgic_hyp_init();
>> +	if (err)
>> +		goto out_free_mappings;
>> +
>>  	return 0;
>>  out_free_vfp:
>>  	free_percpu(kvm_host_vfp_state);
> 
> [...]
> 
>> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
>> index 2fb7319..665af96 100644
>> --- a/virt/kvm/kvm_main.c
>> +++ b/virt/kvm/kvm_main.c
>> @@ -1880,12 +1880,13 @@ static long kvm_vcpu_ioctl(struct file *filp,
>>  	if (vcpu->kvm->mm != current->mm)
>>  		return -EIO;
>>  
>> -#if defined(CONFIG_S390) || defined(CONFIG_PPC)
>> +#if defined(CONFIG_S390) || defined(CONFIG_PPC) || defined(CONFIG_ARM)
>>  	/*
>>  	 * Special cases: vcpu ioctls that are asynchronous to vcpu execution,
>>  	 * so vcpu_load() would break it.
>>  	 */
>> -	if (ioctl == KVM_S390_INTERRUPT || ioctl == KVM_INTERRUPT)
>> +	if (ioctl == KVM_S390_INTERRUPT || ioctl == KVM_INTERRUPT ||
>> +	    ioctl == KVM_IRQ_LINE)
>>  		return kvm_arch_vcpu_ioctl(filp, ioctl, arg);
>>  #endif
> 
> Separate patch?

Probably, yes.

	M.
-- 
Jazz is not dead. It just smells funny...
