From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 26 Apr 2013 14:47:12 +0100
Subject: [PATCH V3] ARM: KVM: Allow host virtual timer irq number to be
 different from guest virtual timer irq number
In-Reply-To: <1366982847-11028-1-git-send-email-anup.patel@linaro.org>
References: <1366982847-11028-1-git-send-email-anup.patel@linaro.org>
Message-ID: <517A8560.6070005@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/04/13 14:27, Anup Patel wrote:
> The arch_timer irq numbers (or PPI number) are implementation dependent so, the host virtual timer irq number can be different from guest virtual timer irq number.
> 
> This patch ensures that host virtual timer irq number is read from DTB and guest virtual timer irq is determined based on guest vcpu target type.
> 
> Signed-off-by: Anup Patel <anup.patel@linaro.org>
> Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
> ---
>  arch/arm/include/asm/kvm_arch_timer.h |    7 +++++++
>  arch/arm/include/asm/kvm_host.h       |    1 +
>  arch/arm/kvm/arch_timer.c             |   32 +++++++++++++++++++++++++-------
>  arch/arm/kvm/guest.c                  |   15 +++++++++++++++
>  arch/arm/kvm/reset.c                  |    4 +++-
>  5 files changed, 51 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/include/asm/kvm_arch_timer.h b/arch/arm/include/asm/kvm_arch_timer.h
> index 68cb9e1..c5c135b 100644
> --- a/arch/arm/include/asm/kvm_arch_timer.h
> +++ b/arch/arm/include/asm/kvm_arch_timer.h
> @@ -61,6 +61,7 @@ struct arch_timer_cpu {
>  #ifdef CONFIG_KVM_ARM_TIMER
>  int kvm_timer_hyp_init(void);
>  int kvm_timer_init(struct kvm *kvm);
> +int kvm_timer_vcpu_reset(struct kvm_vcpu *vcpu);
>  void kvm_timer_vcpu_init(struct kvm_vcpu *vcpu);
>  void kvm_timer_flush_hwstate(struct kvm_vcpu *vcpu);
>  void kvm_timer_sync_hwstate(struct kvm_vcpu *vcpu);
> @@ -76,7 +77,13 @@ static inline int kvm_timer_init(struct kvm *kvm)
>  	return 0;
>  }
>  
> +static int kvm_timer_vcpu_reset(struct kvm_vcpu *vcpu)
> +{
> +	return 0;
> +}
> +
>  static inline void kvm_timer_vcpu_init(struct kvm_vcpu *vcpu) {}
> +
>  static inline void kvm_timer_flush_hwstate(struct kvm_vcpu *vcpu) {}
>  static inline void kvm_timer_sync_hwstate(struct kvm_vcpu *vcpu) {}
>  static inline void kvm_timer_vcpu_terminate(struct kvm_vcpu *vcpu) {}
> diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
> index 57cb786..cdc0551 100644
> --- a/arch/arm/include/asm/kvm_host.h
> +++ b/arch/arm/include/asm/kvm_host.h
> @@ -43,6 +43,7 @@
>  struct kvm_vcpu;
>  u32 *kvm_vcpu_reg(struct kvm_vcpu *vcpu, u8 reg_num, u32 mode);
>  int kvm_target_cpu(void);
> +struct kvm_irq_level *kvm_target_timer_irq(struct kvm_vcpu *vcpu);
>  int kvm_reset_vcpu(struct kvm_vcpu *vcpu);
>  void kvm_reset_coprocs(struct kvm_vcpu *vcpu);
>  
> diff --git a/arch/arm/kvm/arch_timer.c b/arch/arm/kvm/arch_timer.c
> index 49a7516..e558115 100644
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
> @@ -67,8 +67,8 @@ static void kvm_timer_inject_irq(struct kvm_vcpu *vcpu)
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
> @@ -156,6 +156,24 @@ void kvm_timer_sync_hwstate(struct kvm_vcpu *vcpu)
>  	timer_arm(timer, ns);
>  }
>  
> +int kvm_timer_vcpu_reset(struct kvm_vcpu *vcpu)

If you change this function to:
int kvm_timer_vcpu_reset(struct kvm_vcpu *vcpu, struct kvm_irq_level *irq)

...

> +{
> +	struct arch_timer_cpu *timer = &vcpu->arch.timer_cpu;
> +
> +	/*
> +	 * The vcpu timer irq number cannot be determined in 
> +	 * kvm_timer_vcpu_init() because it is called much before
> +	 * kvm_vcpu_set_target(). To handle this, we determine
> +	 * vcpu timer irq number when the vcpu is resetted.
> +	 */
> +	timer->irq = kvm_target_timer_irq(vcpu);
> +	if (!timer->irq) {
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +
>  void kvm_timer_vcpu_init(struct kvm_vcpu *vcpu)
>  {
>  	struct arch_timer_cpu *timer = &vcpu->arch.timer_cpu;
> @@ -163,12 +181,12 @@ void kvm_timer_vcpu_init(struct kvm_vcpu *vcpu)
>  	INIT_WORK(&timer->expired, kvm_timer_inject_irq_work);
>  	hrtimer_init(&timer->timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
>  	timer->timer.function = kvm_timer_expire;
> -	timer->irq = &timer_irq;
> +	timer->irq = NULL;
>  }
>  
>  static void kvm_timer_init_interrupt(void *info)
>  {
> -	enable_percpu_irq(timer_irq.irq, 0);
> +	enable_percpu_irq(host_timer_irq.irq, 0);
>  }
>  
>  
> @@ -182,7 +200,7 @@ static int kvm_timer_cpu_notify(struct notifier_block *self,
>  		break;
>  	case CPU_DYING:
>  	case CPU_DYING_FROZEN:
> -		disable_percpu_irq(timer_irq.irq);
> +		disable_percpu_irq(host_timer_irq.irq);
>  		break;
>  	}
>  
> @@ -230,7 +248,7 @@ int kvm_timer_hyp_init(void)
>  		goto out;
>  	}
>  
> -	timer_irq.irq = ppi;
> +	host_timer_irq.irq = ppi;
>  
>  	err = register_cpu_notifier(&kvm_timer_cpu_nb);
>  	if (err) {
> diff --git a/arch/arm/kvm/guest.c b/arch/arm/kvm/guest.c
> index 152d036..6fbc988 100644
> --- a/arch/arm/kvm/guest.c
> +++ b/arch/arm/kvm/guest.c
> @@ -36,6 +36,11 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
>  	{ NULL }
>  };
>  
> +static struct kvm_irq_level target_cortex_a15_timer_irq = {
> +	.irq = 27,
> +	.level = 1,
> +};

... Move this to reset.c ...

>  int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
>  {
>  	return 0;
> @@ -197,6 +202,16 @@ int __attribute_const__ kvm_target_cpu(void)
>  	}
>  }
>  
> +struct kvm_irq_level *kvm_target_timer_irq(struct kvm_vcpu *vcpu)
> +{
> +	switch (vcpu->arch.target) {
> +	case KVM_ARM_TARGET_CORTEX_A15:
> +		return &target_cortex_a15_timer_irq;
> +	default:
> +		return NULL;
> +	};
> +}

... drop this ...

>  int kvm_vcpu_set_target(struct kvm_vcpu *vcpu,
>  			const struct kvm_vcpu_init *init)
>  {
> diff --git a/arch/arm/kvm/reset.c b/arch/arm/kvm/reset.c
> index b80256b..655e567 100644
> --- a/arch/arm/kvm/reset.c
> +++ b/arch/arm/kvm/reset.c
> @@ -26,6 +26,7 @@
>  #include <asm/cputype.h>
>  #include <asm/kvm_arm.h>
>  #include <asm/kvm_coproc.h>
> +#include <asm/kvm_arch_timer.h>
>  
>  /******************************************************************************
>   * Cortex-A15 Reset Values
> @@ -70,5 +71,6 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu)

...

In	case KVM_ARM_TARGET_CORTEX_A15:
[...]
	timer_irq = &target_cortex_a15_timer_irq;

...

>  	/* Reset CP15 registers */
>  	kvm_reset_coprocs(vcpu);
>  
> -	return 0;
> +	/* Reset arch_timer context */
> +	return kvm_timer_vcpu_reset(vcpu);

... and call kvm_timer_vcpu_reset(vcpu, timer_irq)

it would look much better.

	M.
-- 
Jazz is not dead. It just smells funny...
