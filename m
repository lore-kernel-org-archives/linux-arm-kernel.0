From: ynorov@caviumnetworks.com (Yury Norov)
Date: Tue, 5 Dec 2017 18:24:46 +0300
Subject: [PATCH v6 7/8] KVM: arm/arm64: Provide a get_input_level for the
 arch timer
In-Reply-To: <20171204200506.3224-8-cdall@kernel.org>
References: <20171204200506.3224-1-cdall@kernel.org>
 <20171204200506.3224-8-cdall@kernel.org>
Message-ID: <20171205152446.rcmkowdnuhkqbrdb@yury-thinkpad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 04, 2017 at 09:05:05PM +0100, Christoffer Dall wrote:
> From: Christoffer Dall <christoffer.dall@linaro.org>
> 
> The VGIC can now support the life-cycle of mapped level-triggered
> interrupts, and we no longer have to read back the timer state on every
> exit from the VM if we had an asserted timer interrupt signal, because
> the VGIC already knows if we hit the unlikely case where the guest
> disables the timer without ACKing the virtual timer interrupt.
> 
> This means we rework a bit of the code to factor out the functionality
> to snapshot the timer state from vtimer_save_state(), and we can reuse
> this functionality in the sync path when we have an irqchip in
> userspace, and also to support our implementation of the
> get_input_level() function for the timer.
> 
> This change also means that we can no longer rely on the timer's view of
> the interrupt line to set the active state, because we no longer
> maintain this state for mapped interrupts when exiting from the guest.
> Instead, we only set the active state if the virtual interrupt is
> active, and otherwise we simply let the timer fire again and raise the
> virtual interrupt from the ISR.
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> ---
>  include/kvm/arm_arch_timer.h |  2 ++
>  virt/kvm/arm/arch_timer.c    | 75 +++++++++++++++++++++-----------------------
>  2 files changed, 38 insertions(+), 39 deletions(-)
> 
> diff --git a/include/kvm/arm_arch_timer.h b/include/kvm/arm_arch_timer.h
> index 01ee473517e2..f57f795d704c 100644
> --- a/include/kvm/arm_arch_timer.h
> +++ b/include/kvm/arm_arch_timer.h
> @@ -90,6 +90,8 @@ void kvm_timer_vcpu_put(struct kvm_vcpu *vcpu);
>  
>  void kvm_timer_init_vhe(void);
>  
> +bool kvm_arch_timer_get_input_level(int vintid);
> +
>  #define vcpu_vtimer(v)	(&(v)->arch.timer_cpu.vtimer)
>  #define vcpu_ptimer(v)	(&(v)->arch.timer_cpu.ptimer)
>  

[...]

> +bool kvm_arch_timer_get_input_level(int vintid)
> +{
> +	struct kvm_vcpu *vcpu = kvm_arm_get_running_vcpu();
> +	struct arch_timer_context *timer;
> +
> +	if (vintid == vcpu_vtimer(vcpu)->irq.irq)
> +		timer = vcpu_vtimer(vcpu);
> +	else
> +		BUG(); /* We only map the vtimer so far */
> +
> +	if (timer->loaded)
> +		__timer_snapshot_state(timer);
> +
> +	return kvm_timer_should_fire(timer);
> +}

I think it worth to reword to highlight your intention about BUG,
and save 1 call to vcpu_vtimer()

bool kvm_arch_timer_get_input_level(int vintid)
{
	struct kvm_vcpu *vcpu = kvm_arm_get_running_vcpu();
	struct arch_timer_context *timer = vcpu_vtimer(vcpu);

        /* We only map the vtimer so far */
	BUG_ON(vintid != timer->irq.irq)

	if (timer->loaded)
		__timer_snapshot_state(timer);

	return kvm_timer_should_fire(timer);
}

>  int kvm_timer_enable(struct kvm_vcpu *vcpu)
>  {
>  	struct arch_timer_cpu *timer = &vcpu->arch.timer_cpu;
> @@ -841,7 +838,7 @@ int kvm_timer_enable(struct kvm_vcpu *vcpu)
>  	}
>  
>  	ret = kvm_vgic_map_phys_irq(vcpu, host_vtimer_irq, vtimer->irq.irq,
> -				    NULL);
> +				    kvm_arch_timer_get_input_level);
>  	if (ret)
>  		return ret;
>  
> -- 
> 2.14.2
