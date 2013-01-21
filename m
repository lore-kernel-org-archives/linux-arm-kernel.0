From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 21 Jan 2013 11:04:08 +0100
Subject: [kvmarm] [PATCH v6 14/15] KVM: ARM: Power State Coordination
 Interface implementation
In-Reply-To: <CANM98q+z2tj72qFtjDF1ZpKMGs876=hRLpKTEwYKnpCMzdpErg@mail.gmail.com>
References: <20130116175716.29147.15348.stgit@ubuntu>
 <20130116175918.29147.318.stgit@ubuntu> <50F81EF4.4020507@arm.com>
 <CANM98q+z2tj72qFtjDF1ZpKMGs876=hRLpKTEwYKnpCMzdpErg@mail.gmail.com>
Message-ID: <75f43582106716efe7c8f1360e58732e@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 20 Jan 2013 18:35:51 -0500, Christoffer Dall
<c.dall@virtualopensystems.com> wrote:
> On Thu, Jan 17, 2013 at 10:55 AM, Marc Zyngier <marc.zyngier@arm.com>
> wrote:
>> On 16/01/13 17:59, Christoffer Dall wrote:
>>> From: Marc Zyngier <marc.zyngier@arm.com>
>>>
>>> Implement the PSCI specification (ARM DEN 0022A) to control
>>> virtual CPUs being "powered" on or off.
>>>
>>> PSCI/KVM is detected using the KVM_CAP_ARM_PSCI capability.
>>>
>>> A virtual CPU can now be initialized in a "powered off" state,
>>> using the KVM_ARM_VCPU_POWER_OFF feature flag.
>>>
>>> The guest can use either SMC or HVC to execute a PSCI function.
>>>
>>> Reviewed-by: Will Deacon <will.deacon@arm.com>
>>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>>> Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
>>
>> A few bits went wrong when you reworked this patch. See below.

[...]

>>> @@ -443,13 +445,17 @@ static int handle_hvc(struct kvm_vcpu *vcpu,
>>> struct kvm_run *run)
>>>       trace_kvm_hvc(*vcpu_pc(vcpu), *vcpu_reg(vcpu, 0),
>>>                     vcpu->arch.hsr & HSR_HVC_IMM_MASK);
>>>
>>> +     if (kvm_psci_call(vcpu))
>>> +             return 1;
>>> +
>>>       return 1;
>>
>> No undef injection if there is no PSCI match?

You haven't addressed this issue in you patch.

[...]

> Thanks, see this patch:
> 
> diff --git a/arch/arm/include/asm/kvm_host.h
> b/arch/arm/include/asm/kvm_host.h
> index 751aa86..d1736a5 100644
> --- a/arch/arm/include/asm/kvm_host.h
> +++ b/arch/arm/include/asm/kvm_host.h
> @@ -113,7 +113,7 @@ struct kvm_vcpu_arch {
>  	int last_pcpu;
>  	cpumask_t require_dcache_flush;
> 
> -	/* Don't run the guest: see copy_current_insn() */
> +	/* Don't run the guest on this vcpu */
>  	bool pause;
> 
>  	/* IO related fields */
> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
> index a67392a..2819575 100644
> --- a/arch/arm/kvm/arm.c
> +++ b/arch/arm/kvm/arm.c
> @@ -502,7 +502,7 @@ static int handle_hvc(struct kvm_vcpu *vcpu,
> struct kvm_run *run)
> 
>  static int handle_smc(struct kvm_vcpu *vcpu, struct kvm_run *run)
>  {
> -	if (!kvm_psci_call(vcpu))
> +	if (kvm_psci_call(vcpu))
>  		return 1;
> 
>  	kvm_inject_undefined(vcpu);
> @@ -667,6 +667,13 @@ static int kvm_vcpu_first_run_init(struct kvm_vcpu
> *vcpu)
>  	return 0;
>  }
> 
> +static void vcpu_pause(struct kvm_vcpu *vcpu)
> +{
> +	wait_queue_head_t *wq = kvm_arch_vcpu_wq(vcpu);
> +
> +	wait_event_interruptible(*wq, !vcpu->arch.pause);
> +}
> +
>  /**
>   * kvm_arch_vcpu_ioctl_run - the main VCPU run function to execute
guest
>   code
>   * @vcpu:	The VCPU pointer
> @@ -710,6 +717,9 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu,
> struct kvm_run *run)
> 
>  		update_vttbr(vcpu->kvm);
> 
> +		if (vcpu->arch.pause)
> +			vcpu_pause(vcpu);
> +
>  		kvm_vgic_flush_hwstate(vcpu);
>  		kvm_timer_flush_hwstate(vcpu);
> 
> @@ -737,13 +747,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu
> *vcpu, struct kvm_run *run)
>  		kvm_guest_enter();
>  		vcpu->mode = IN_GUEST_MODE;
> 
> -		smp_mb(); /* set mode before reading vcpu->arch.pause */
> -		if (unlikely(vcpu->arch.pause)) {
> -			/* This means ignore, try again. */
> -			ret = ARM_EXCEPTION_IRQ;
> -		} else {
> -			ret = kvm_call_hyp(__kvm_vcpu_run, vcpu);
> -		}
> +		ret = kvm_call_hyp(__kvm_vcpu_run, vcpu);
> 
>  		vcpu->mode = OUTSIDE_GUEST_MODE;
>  		vcpu->arch.last_pcpu = smp_processor_id();
> diff --git a/arch/arm/kvm/psci.c b/arch/arm/kvm/psci.c
> index 6be3687..d833604 100644
> --- a/arch/arm/kvm/psci.c
> +++ b/arch/arm/kvm/psci.c
> @@ -28,11 +28,7 @@
> 
>  static void kvm_psci_vcpu_off(struct kvm_vcpu *vcpu)
>  {
> -	wait_queue_head_t *wq = kvm_arch_vcpu_wq(vcpu);
> -
>  	vcpu->arch.pause = true;
> -
> -	wait_event_interruptible(*wq, !vcpu->arch.pause);
>  }
> 
>  static unsigned long kvm_psci_vcpu_on(struct kvm_vcpu *source_vcpu)

Assuming you fix the above, it looks OK to me.

        M.
-- 
Fast, cheap, reliable. Pick two.
