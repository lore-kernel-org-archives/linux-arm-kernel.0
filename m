From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat, 27 Apr 2013 11:19:45 +0200
Subject: [PATCH] ARM: KVM: Allow host virt timer irq to be different from
 guest timer virt irq
In-Reply-To: <1367050086-2902-1-git-send-email-anup.patel@linaro.org>
References: <1367050086-2902-1-git-send-email-anup.patel@linaro.org>
Message-ID: <73b473edb8a9ea9a09f1df68345903d7@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 27 Apr 2013 13:38:06 +0530, Anup Patel <anup.patel@linaro.org>
wrote:
> The arch_timer irq numbers (or PPI numbers) are implementation dependent
> so, the host virtual timer irq number can be different from guest
virtual
> timer irq number.
> 
> This patch ensures that host virtual timer irq number is read from DTB
and
> guest virtual timer irq is determined based on vcpu target type.

Christoffer already commented on the width of your commit message.
It doesn't show here as my stupid email client reformats it aumatically,
but you may want to check in the archive:

https://lists.cs.columbia.edu/pipermail/kvmarm/2013-April/005616.html

Please make sure you insert newlines around position 70. Or use a half
decent editor.

> Signed-off-by: Anup Patel <anup.patel@linaro.org>
> Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
> ---
>  arch/arm/include/asm/kvm_arch_timer.h |    9 +++++++++
>  arch/arm/kvm/arch_timer.c             |   35
>  ++++++++++++++++++++++++++-------
>  arch/arm/kvm/reset.c                  |   11 ++++++++++-
>  3 files changed, 47 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/include/asm/kvm_arch_timer.h
> b/arch/arm/include/asm/kvm_arch_timer.h
> index 68cb9e1..51b0316 100644
> --- a/arch/arm/include/asm/kvm_arch_timer.h
> +++ b/arch/arm/include/asm/kvm_arch_timer.h
> @@ -61,6 +61,8 @@ struct arch_timer_cpu {
>  #ifdef CONFIG_KVM_ARM_TIMER
>  int kvm_timer_hyp_init(void);
>  int kvm_timer_init(struct kvm *kvm);
> +int kvm_timer_vcpu_reset(struct kvm_vcpu *vcpu, 
> +			 const struct kvm_irq_level *irq);
>  void kvm_timer_vcpu_init(struct kvm_vcpu *vcpu);
>  void kvm_timer_flush_hwstate(struct kvm_vcpu *vcpu);
>  void kvm_timer_sync_hwstate(struct kvm_vcpu *vcpu);
> @@ -76,7 +78,14 @@ static inline int kvm_timer_init(struct kvm *kvm)
>  	return 0;
>  }
>  
> +int kvm_timer_vcpu_reset(struct kvm_vcpu *vcpu, 
> +			 const struct kvm_irq_level *irq)

static inline, please. This is an include file...

> +{
> +	return 0;
> +}
> +
>  static inline void kvm_timer_vcpu_init(struct kvm_vcpu *vcpu) {}
> +
>  static inline void kvm_timer_flush_hwstate(struct kvm_vcpu *vcpu) {}
>  static inline void kvm_timer_sync_hwstate(struct kvm_vcpu *vcpu) {}
>  static inline void kvm_timer_vcpu_terminate(struct kvm_vcpu *vcpu) {}
> diff --git a/arch/arm/kvm/arch_timer.c b/arch/arm/kvm/arch_timer.c
> index 49a7516..c07b63c 100644
> --- a/arch/arm/kvm/arch_timer.c
> +++ b/arch/arm/kvm/arch_timer.c
> @@ -30,7 +30,7 @@
>  
>  static struct timecounter *timecounter;
>  static struct workqueue_struct *wqueue;
> -static struct kvm_irq_level timer_irq = {
> +static struct kvm_irq_level host_timer_irq = {
>  	.level	= 1,
>  };
>  
> @@ -67,8 +67,8 @@ static void kvm_timer_inject_irq(struct kvm_vcpu
*vcpu)
>  
>  	timer->cntv_ctl |= ARCH_TIMER_CTRL_IT_MASK;
>  	kvm_vgic_inject_irq(vcpu->kvm, vcpu->vcpu_id,
> -			    vcpu->arch.timer_cpu.irq->irq,
> -			    vcpu->arch.timer_cpu.irq->level);
> +			    timer->irq->irq,
> +			    timer->irq->level);
>  }
>  
>  static irqreturn_t kvm_arch_timer_handler(int irq, void *dev_id)
> @@ -156,6 +156,27 @@ void kvm_timer_sync_hwstate(struct kvm_vcpu *vcpu)
>  	timer_arm(timer, ns);
>  }
>  
> +int kvm_timer_vcpu_reset(struct kvm_vcpu *vcpu, 
> +			 const struct kvm_irq_level *irq)
> +{
> +	struct arch_timer_cpu *timer = &vcpu->arch.timer_cpu;
> +
> +	/*
> +	 * The vcpu timer irq number cannot be determined in 
> +	 * kvm_timer_vcpu_init() because it is called much before
> +	 * kvm_vcpu_set_target(). To handle this, we determine
> +	 * vcpu timer irq number when the vcpu is resetted.
> +	 */
> +	timer->irq = irq;
> +
> +	/*
> +	 * Make sure timer is disarmed.
> +	 */
> +	timer_disarm(timer);

What is that for? Timer has not been started yet, for the lack of an IRQ.
Actually, the vcpu has never ran. Why would you need to disarm it?

> +	return 0;

If this function has no failure case, it can return void.

> +}
> +
>  void kvm_timer_vcpu_init(struct kvm_vcpu *vcpu)
>  {
>  	struct arch_timer_cpu *timer = &vcpu->arch.timer_cpu;
> @@ -163,12 +184,12 @@ void kvm_timer_vcpu_init(struct kvm_vcpu *vcpu)
>  	INIT_WORK(&timer->expired, kvm_timer_inject_irq_work);
>  	hrtimer_init(&timer->timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
>  	timer->timer.function = kvm_timer_expire;
> -	timer->irq = &timer_irq;
> +	timer->irq = NULL;

How useful is that? The vcpu has been kzalloc-ed anyway. Is there any case
where this makes sense?

>  }
>  
>  static void kvm_timer_init_interrupt(void *info)
>  {
> -	enable_percpu_irq(timer_irq.irq, 0);
> +	enable_percpu_irq(host_timer_irq.irq, 0);
>  }
>  
>  
> @@ -182,7 +203,7 @@ static int kvm_timer_cpu_notify(struct
notifier_block
> *self,
>  		break;
>  	case CPU_DYING:
>  	case CPU_DYING_FROZEN:
> -		disable_percpu_irq(timer_irq.irq);
> +		disable_percpu_irq(host_timer_irq.irq);
>  		break;
>  	}
>  
> @@ -230,7 +251,7 @@ int kvm_timer_hyp_init(void)
>  		goto out;
>  	}
>  
> -	timer_irq.irq = ppi;
> +	host_timer_irq.irq = ppi;
>  
>  	err = register_cpu_notifier(&kvm_timer_cpu_nb);
>  	if (err) {
> diff --git a/arch/arm/kvm/reset.c b/arch/arm/kvm/reset.c
> index b80256b..148397e 100644
> --- a/arch/arm/kvm/reset.c
> +++ b/arch/arm/kvm/reset.c
> @@ -26,6 +26,7 @@
>  #include <asm/cputype.h>
>  #include <asm/kvm_arm.h>
>  #include <asm/kvm_coproc.h>
> +#include <asm/kvm_arch_timer.h>
>  
> 
/******************************************************************************
>   * Cortex-A15 Reset Values
> @@ -37,6 +38,11 @@ static struct kvm_regs a15_regs_reset = {
>  	.usr_regs.ARM_cpsr = SVC_MODE | PSR_A_BIT | PSR_I_BIT | PSR_F_BIT,
>  };
>  
> +static struct kvm_irq_level a15_timer_irq = {

Please make this static const.

> +	.irq = 27,
> +	.level = 1,
> +};
> +
>  
> 
/*******************************************************************************
>   * Exported reset function
> @@ -52,6 +58,7 @@ static struct kvm_regs a15_regs_reset = {
>  int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
>  {
>  	struct kvm_regs *cpu_reset;
> +	const struct kvm_irq_level *cpu_irq;
>  
>  	switch (vcpu->arch.target) {
>  	case KVM_ARM_TARGET_CORTEX_A15:
> @@ -59,6 +66,7 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
>  			return -EINVAL;
>  		cpu_reset = &a15_regs_reset;
>  		vcpu->arch.midr = read_cpuid_id();
> +		cpu_irq = &a15_timer_irq;
>  		break;
>  	default:
>  		return -ENODEV;
> @@ -70,5 +78,6 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
>  	/* Reset CP15 registers */
>  	kvm_reset_coprocs(vcpu);
>  
> -	return 0;
> +	/* Reset arch_timer context */
> +	return kvm_timer_vcpu_reset(vcpu, cpu_irq);
>  }

Some of the above comments also apply to the arm64 you sent.

Thanks,

        M.
-- 
Fast, cheap, reliable. Pick two.
