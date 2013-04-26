From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 26 Apr 2013 11:47:25 +0200
Subject: [PATCH V2] ARM: KVM: Allow host virtual timer irq number to be
 different from guest virtual timer irq number
In-Reply-To: <1366960910-27651-1-git-send-email-anup.patel@linaro.org>
References: <1366960910-27651-1-git-send-email-anup.patel@linaro.org>
Message-ID: <3b52361974a390cff0bb0bc26b4a3b54@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Anup,

On Fri, 26 Apr 2013 12:51:50 +0530, Anup Patel <anup.patel@linaro.org>
wrote:
> The arch_timer irq numbers (or PPI number) are implementation dependent
> so, the host virtual timer irq number can be different from guest
virtual
> timer irq number.
> 
> This patch ensures that host virtual timer irq number is read from DTB
and
> guest virtual timer irq is determined based on guest vcpu target type.

One word about communication first: Please keep me cc-ed on anything that
has to do with with vgic and timers. I'm the author of the code, I intend
to look after it, and this has some direct impact on the arm64 port. Thank
you.

> Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>

Who is the author of this patch? You or Pranavkumar? If it is you, then
your Signed-off line should be present. If not, then there should be a
"From:" line at the beginning of the commit message.

> ---
>  arch/arm/include/asm/kvm_host.h |    1 +
>  arch/arm/kvm/arch_timer.c       |   25 ++++++++++++++++++-------
>  arch/arm/kvm/guest.c            |   15 +++++++++++++++
>  3 files changed, 34 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/include/asm/kvm_host.h
> b/arch/arm/include/asm/kvm_host.h
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
> index 49a7516..521cdb9 100644
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
> @@ -65,10 +65,21 @@ static void kvm_timer_inject_irq(struct kvm_vcpu
*vcpu)
>  {
>  	struct arch_timer_cpu *timer = &vcpu->arch.timer_cpu;
>  
> +	/*
> +	 * The vcpu timer irq number cannont be determined in 
> +	 * kvm_timer_vcpu_init() because it is called much before
> +	 * kvm_vcpu_set_target(). To handle this, we determin
> +	 * vcpu timer irq number when we inject the vcpu timer irq
> +	 * first time. 
> +	 */
> +	if (!timer->irq) {
> +		timer->irq = kvm_target_timer_irq(vcpu);
> +	}

Please, not yet another of these. We already have kvm_vcpu_first_run_init
that collects all the "do this on first vcpu run" kind of thing.

>  	timer->cntv_ctl |= ARCH_TIMER_CTRL_IT_MASK;
>  	kvm_vgic_inject_irq(vcpu->kvm, vcpu->vcpu_id,
> -			    vcpu->arch.timer_cpu.irq->irq,
> -			    vcpu->arch.timer_cpu.irq->level);
> +			    timer->irq->irq,
> +			    timer->irq->level);
>  }
>  
>  static irqreturn_t kvm_arch_timer_handler(int irq, void *dev_id)
> @@ -163,12 +174,12 @@ void kvm_timer_vcpu_init(struct kvm_vcpu *vcpu)
>  	INIT_WORK(&timer->expired, kvm_timer_inject_irq_work);
>  	hrtimer_init(&timer->timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
>  	timer->timer.function = kvm_timer_expire;
> -	timer->irq = &timer_irq;
> +	timer->irq = NULL;
>  }

So with the above in mind, how about moving the call to
kvm_timer_vcpu_init into kvm_vcpu_first_run_init, and do the init once and
for all?

>  static void kvm_timer_init_interrupt(void *info)
>  {
> -	enable_percpu_irq(timer_irq.irq, 0);
> +	enable_percpu_irq(host_timer_irq.irq, 0);
>  }
>  
>  
> @@ -182,7 +193,7 @@ static int kvm_timer_cpu_notify(struct
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
> @@ -230,7 +241,7 @@ int kvm_timer_hyp_init(void)
>  		goto out;
>  	}
>  
> -	timer_irq.irq = ppi;
> +	host_timer_irq.irq = ppi;
>  
>  	err = register_cpu_notifier(&kvm_timer_cpu_nb);
>  	if (err) {
> diff --git a/arch/arm/kvm/guest.c b/arch/arm/kvm/guest.c
> index 152d036..d87b05d 100644
> --- a/arch/arm/kvm/guest.c
> +++ b/arch/arm/kvm/guest.c
> @@ -36,6 +36,11 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
>  	{ NULL }
>  };
>  
> +struct kvm_irq_level target_default_timer_irq = {
> +	.irq = 27,
> +	.level = 1,
> +};

Don't call it default, as it is A15 specific. Also make it static.

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
> +		return &target_default_timer_irq;
> +	default:
> +		return NULL;

And what do you do once you've returned NULL? Let the kernel crash?
Also, we now have a second path that tests the target (the first one is in
reset.c

Actually, scratch all the above, and move the irq assignment to reset.c.
It is probably the best place for it.

Thanks,

        M.
-- 
Fast, cheap, reliable. Pick two.
