From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 9 Jan 2017 12:59:26 +0100
Subject: [RFC 2/8] KVM: arm/arm64: Decouple kvm timer functions from
 virtual timer
In-Reply-To: <1482772326-29110-3-git-send-email-jintack@cs.columbia.edu>
References: <1482772326-29110-1-git-send-email-jintack@cs.columbia.edu>
 <1482772326-29110-3-git-send-email-jintack@cs.columbia.edu>
Message-ID: <20170109115926.GC4348@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 26, 2016 at 12:12:00PM -0500, Jintack Lim wrote:
> Now that we have a separate structure for timer context, make functions
> general so that they can work on any timer context, not just the virtual
> timer context.  This does not change the virtual timer functionality.
> 
> Signed-off-by: Jintack Lim <jintack@cs.columbia.edu>
> ---
>  arch/arm/kvm/arm.c           |  2 +-
>  include/kvm/arm_arch_timer.h |  3 +-
>  virt/kvm/arm/arch_timer.c    | 65 +++++++++++++++++++++++++-------------------
>  3 files changed, 40 insertions(+), 30 deletions(-)
> 
> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
> index 19b5f5c..37d1623 100644
> --- a/arch/arm/kvm/arm.c
> +++ b/arch/arm/kvm/arm.c
> @@ -295,7 +295,7 @@ void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
>  
>  int kvm_cpu_has_pending_timer(struct kvm_vcpu *vcpu)
>  {
> -	return kvm_timer_should_fire(vcpu);
> +	return kvm_timer_should_fire(vcpu, vcpu_vtimer(vcpu));
>  }
>  
>  void kvm_arch_vcpu_blocking(struct kvm_vcpu *vcpu)
> diff --git a/include/kvm/arm_arch_timer.h b/include/kvm/arm_arch_timer.h
> index 7dabe56..cf84145 100644
> --- a/include/kvm/arm_arch_timer.h
> +++ b/include/kvm/arm_arch_timer.h
> @@ -69,7 +69,8 @@ int kvm_timer_vcpu_reset(struct kvm_vcpu *vcpu,
>  u64 kvm_arm_timer_get_reg(struct kvm_vcpu *, u64 regid);
>  int kvm_arm_timer_set_reg(struct kvm_vcpu *, u64 regid, u64 value);
>  
> -bool kvm_timer_should_fire(struct kvm_vcpu *vcpu);
> +bool kvm_timer_should_fire(struct kvm_vcpu *vcpu,
> +			   struct arch_timer_context *timer_ctx);
>  void kvm_timer_schedule(struct kvm_vcpu *vcpu);
>  void kvm_timer_unschedule(struct kvm_vcpu *vcpu);
>  
> diff --git a/virt/kvm/arm/arch_timer.c b/virt/kvm/arm/arch_timer.c
> index 30a64df..3bd6063 100644
> --- a/virt/kvm/arm/arch_timer.c
> +++ b/virt/kvm/arm/arch_timer.c
> @@ -91,7 +91,7 @@ static void kvm_timer_inject_irq_work(struct work_struct *work)
>  	vcpu = container_of(work, struct kvm_vcpu, arch.timer_cpu.expired);
>  	vcpu->arch.timer_cpu.armed = false;
>  
> -	WARN_ON(!kvm_timer_should_fire(vcpu));
> +	WARN_ON(!kvm_timer_should_fire(vcpu, vcpu_vtimer(vcpu)));
>  
>  	/*
>  	 * If the vcpu is blocked we want to wake it up so that it will see
> @@ -100,12 +100,22 @@ static void kvm_timer_inject_irq_work(struct work_struct *work)
>  	kvm_vcpu_kick(vcpu);
>  }
>  
> -static u64 kvm_timer_compute_delta(struct kvm_vcpu *vcpu)
> +static u64 kvm_timer_cntvoff(struct kvm_vcpu *vcpu,
> +			     struct arch_timer_context *timer_ctx)
> +{
> +	if (timer_ctx == vcpu_vtimer(vcpu))
> +		return vcpu->kvm->arch.timer.cntvoff;
> +
> +	return 0;
> +}
> +
> +static u64 kvm_timer_compute_delta(struct kvm_vcpu *vcpu,
> +				   struct arch_timer_context *timer_ctx)
>  {
>  	cycle_t cval, now;
>  
> -	cval = vcpu_vtimer(vcpu)->cnt_cval;
> -	now = kvm_phys_timer_read() - vcpu->kvm->arch.timer.cntvoff;
> +	cval = timer_ctx->cnt_cval;
> +	now = kvm_phys_timer_read() - kvm_timer_cntvoff(vcpu, timer_ctx);
>  
>  	if (now < cval) {
>  		u64 ns;
> @@ -134,7 +144,7 @@ static enum hrtimer_restart kvm_timer_expire(struct hrtimer *hrt)
>  	 * PoV (NTP on the host may have forced it to expire
>  	 * early). If we should have slept longer, restart it.
>  	 */
> -	ns = kvm_timer_compute_delta(vcpu);
> +	ns = kvm_timer_compute_delta(vcpu, vcpu_vtimer(vcpu));
>  	if (unlikely(ns)) {
>  		hrtimer_forward_now(hrt, ns_to_ktime(ns));
>  		return HRTIMER_RESTART;
> @@ -144,42 +154,40 @@ static enum hrtimer_restart kvm_timer_expire(struct hrtimer *hrt)
>  	return HRTIMER_NORESTART;
>  }
>  
> -static bool kvm_timer_irq_can_fire(struct kvm_vcpu *vcpu)
> +static bool kvm_timer_irq_can_fire(struct arch_timer_context *timer_ctx)
>  {
> -	struct arch_timer_context *vtimer = vcpu_vtimer(vcpu);
> -
> -	return !(vtimer->cnt_ctl & ARCH_TIMER_CTRL_IT_MASK) &&
> -		(vtimer->cnt_ctl & ARCH_TIMER_CTRL_ENABLE);
> +	return !(timer_ctx->cnt_ctl & ARCH_TIMER_CTRL_IT_MASK) &&
> +		(timer_ctx->cnt_ctl & ARCH_TIMER_CTRL_ENABLE);
>  }
>  
> -bool kvm_timer_should_fire(struct kvm_vcpu *vcpu)
> +bool kvm_timer_should_fire(struct kvm_vcpu *vcpu,
> +			   struct arch_timer_context *timer_ctx)
>  {
> -	struct arch_timer_context *vtimer = vcpu_vtimer(vcpu);
>  	cycle_t cval, now;
>  
> -	if (!kvm_timer_irq_can_fire(vcpu))
> +	if (!kvm_timer_irq_can_fire(timer_ctx))
>  		return false;
>  
> -	cval = vtimer->cnt_cval;
> -	now = kvm_phys_timer_read() - vcpu->kvm->arch.timer.cntvoff;
> +	cval = timer_ctx->cnt_cval;
> +	now = kvm_phys_timer_read() - kvm_timer_cntvoff(vcpu, timer_ctx);
>  

I'm wondering if we should move the cntvoff field to the
arch_timer_context struct so that all these functions can just take
the timer_ctx pointer without a vcpu pointer?

(That would pave the way for ever doing adjustments of the cntvoff on a
per-CPU basis if that should ever make sense, which it maybe won't but
still...)

The challenge would be to ensure that the cntvoff stays in sync between
all the contexts when being modified from userspace and during init.

Thoughts?

Thanks,
-Christoffer
