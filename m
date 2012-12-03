From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 03 Dec 2012 10:33:11 +0000
Subject: [PATCH v4 08/14] KVM: ARM: World-switch implementation
In-Reply-To: <CANM98qJQBD3+iW0uCptXBgsPBuBBfuaT1FN3EivMywwD-oNi=Q@mail.gmail.com>
References: <20121110154203.2836.46686.stgit@chazy-air>
 <20121110154306.2836.93473.stgit@chazy-air>
 <20121119145758.GA3205@mudshark.cambridge.arm.com>
 <CANM98qJFFP=2ueyUpbN6x15XwtWXbgZjkMBaq2jVpqik4kT54Q@mail.gmail.com>
 <20121130151500.GC26289@mudshark.cambridge.arm.com>
 <CANM98q+TQZiXe3GLjcPpPVZz40emmizgnEmyZEju1ruKNR6EEQ@mail.gmail.com>
 <20121130171420.GC619@mudshark.cambridge.arm.com>
 <CANM98qJQBD3+iW0uCptXBgsPBuBBfuaT1FN3EivMywwD-oNi=Q@mail.gmail.com>
Message-ID: <50BC7FE7.6050006@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/11/12 18:49, Christoffer Dall wrote:
> On Fri, Nov 30, 2012 at 12:14 PM, Will Deacon <will.deacon@arm.com> wrote:
>> On Fri, Nov 30, 2012 at 04:47:40PM +0000, Christoffer Dall wrote:
>>> On Fri, Nov 30, 2012 at 10:15 AM, Will Deacon <will.deacon@arm.com> wrote:
>>>> At this point, VM1 is running and VM0:VCPU1 is running. VM0:VCPU0 is not
>>>> running because physical CPU0 is handling an interrupt. The problem is that
>>>> when VCPU0 *is* resumed, it will update the VMID of VM0 and could be
>>>> scheduled in parallel with VCPU1 but with a different VMID.
>>>>
>>>> How do you avoid this in the current code?
>>>>
>>> I don't. Nice catch. Please apply your interesting brain to the following fix:)
>>
>> I'm far too sober to look at your patch right now, but I'll think about it
>> over the weekend [I can't break it at a quick glance] :)
>>
>> In the meantime, can you think about whether the TLB operations need to run
>> on every CPU please?
>>
> they don't we can invalidate the TLB and the icache using the inner
> shareability domain. Here's a patch:
> 
> diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
> index ad1390f..df1b753 100644
> --- a/arch/arm/include/asm/kvm_host.h
> +++ b/arch/arm/include/asm/kvm_host.h
> @@ -146,6 +146,7 @@ struct kvm_one_reg;
>  int kvm_arm_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg);
>  int kvm_arm_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg);
>  u64 kvm_call_hyp(void *hypfn, ...);
> +void force_vm_exit(const cpumask_t *mask);
> 
>  #define KVM_ARCH_WANT_MMU_NOTIFIER
>  struct kvm;
> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
> index c4f631e..674592e 100644
> --- a/arch/arm/kvm/arm.c
> +++ b/arch/arm/kvm/arm.c
> @@ -405,9 +405,14 @@ int kvm_arch_vcpu_in_guest_mode(struct kvm_vcpu *v)
>  	return v->mode == IN_GUEST_MODE;
>  }
> 
> -static void reset_vm_context(void *info)
> +/* Just ensure a guest exit from a particular CPU */
> +static void exit_vm_noop(void *info)
>  {
> -	kvm_call_hyp(__kvm_flush_vm_context);
> +}
> +
> +void force_vm_exit(const cpumask_t *mask)
> +{
> +	smp_call_function_many(mask, exit_vm_noop, NULL, true);
>  }

Care to update the do_nothing() call in emulate.c to use this as well?

	M.
-- 
Jazz is not dead. It just smells funny...
