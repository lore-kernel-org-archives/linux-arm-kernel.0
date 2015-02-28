From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat, 28 Feb 2015 13:30:03 +0000
Subject: [PATCH 3/4] arm/arm64: KVM: Fix migration race in the arch timer
In-Reply-To: <1424878582-26397-4-git-send-email-alex.bennee@linaro.org>
References: <1424878582-26397-1-git-send-email-alex.bennee@linaro.org>
 <1424878582-26397-4-git-send-email-alex.bennee@linaro.org>
Message-ID: <20150228133003.29d59e96@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 25 Feb 2015 15:36:21 +0000
Alex Benn?e <alex.bennee@linaro.org> wrote:

Alex, Christoffer,

> From: Christoffer Dall <christoffer.dall@linaro.org>
> 
> When a VCPU is no longer running, we currently check to see if it has
> a timer scheduled in the future, and if it does, we schedule a host
> hrtimer to notify is in case the timer expires while the VCPU is still
> not running.  When the hrtimer fires, we mask the guest's timer and
> inject the timer IRQ (still relying on the guest unmasking the time
> when it receives the IRQ).
> 
> This is all good and fine, but when migration a VM
> (checkpoint/restore) this introduces a race.  It is unlikely, but
> possible, for the following sequence of events to happen:
> 
>  1. Userspace stops the VM
>  2. Hrtimer for VCPU is scheduled
>  3. Userspace checkpoints the VGIC state (no pending timer interrupts)
>  4. The hrtimer fires, schedules work in a workqueue
>  5. Workqueue function runs, masks the timer and injects timer
> interrupt 6. Userspace checkpoints the timer state (timer masked)
> 
> At restore time, you end up with a masked timer without any timer
> interrupts and your guest halts never receiving timer interrupts.
> 
> Fix this by only kicking the VCPU in the workqueue function, and
> sample the expired state of the timer when entering the guest again
> and inject the interrupt and mask the timer only then.
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>
> 
> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
> index 8531536..f7fd76e 100644
> --- a/arch/arm/kvm/arm.c
> +++ b/arch/arm/kvm/arm.c
> @@ -269,7 +269,7 @@ void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
>  
>  int kvm_cpu_has_pending_timer(struct kvm_vcpu *vcpu)
>  {
> -	return 0;
> +	return kvm_timer_should_fire(vcpu);
>  }
>  
>  int kvm_arch_vcpu_init(struct kvm_vcpu *vcpu)
> diff --git a/include/kvm/arm_arch_timer.h
> b/include/kvm/arm_arch_timer.h index b3f45a5..98cc9f4 100644
> --- a/include/kvm/arm_arch_timer.h
> +++ b/include/kvm/arm_arch_timer.h
> @@ -72,6 +72,8 @@ void kvm_timer_vcpu_terminate(struct kvm_vcpu
> *vcpu); u64 kvm_arm_timer_get_reg(struct kvm_vcpu *, u64 regid);
>  int kvm_arm_timer_set_reg(struct kvm_vcpu *, u64 regid, u64 value);
>  
> +bool kvm_timer_should_fire(struct kvm_vcpu *vcpu);
> +
>  #else
>  static inline int kvm_timer_hyp_init(void)
>  {
> @@ -96,6 +98,11 @@ static inline u64 kvm_arm_timer_get_reg(struct
> kvm_vcpu *vcpu, u64 regid) {
>  	return 0;
>  }
> +
> +static inline bool kvm_timer_should_fire(struct kvm_vcpu *vcpu)
> +{
> +	return false;
> +}
>  #endif
>  
>  #endif
> diff --git a/virt/kvm/arm/arch_timer.c b/virt/kvm/arm/arch_timer.c
> index 6e54f35..98c95f2 100644
> --- a/virt/kvm/arm/arch_timer.c
> +++ b/virt/kvm/arm/arch_timer.c
> @@ -85,13 +85,22 @@ static irqreturn_t kvm_arch_timer_handler(int
> irq, void *dev_id) return IRQ_HANDLED;
>  }
>  
> +/*
> + * Work function for handling the backup timer that we schedule when
> a vcpu is
> + * no longer running, but had a timer programmed to fire in the
> future.
> + */
>  static void kvm_timer_inject_irq_work(struct work_struct *work)
>  {
>  	struct kvm_vcpu *vcpu;
>  
>  	vcpu = container_of(work, struct kvm_vcpu,
> arch.timer_cpu.expired); vcpu->arch.timer_cpu.armed = false;
> -	kvm_timer_inject_irq(vcpu);
> +
> +	/*
> +	 * If the vcpu is blocked we want to wake it up so that it
> will see
> +	 * the timer has expired when entering the guest.
> +	 */
> +	kvm_vcpu_kick(vcpu);
>  }
>  
>  static enum hrtimer_restart kvm_timer_expire(struct hrtimer *hrt)
> @@ -102,6 +111,21 @@ static enum hrtimer_restart
> kvm_timer_expire(struct hrtimer *hrt) return HRTIMER_NORESTART;
>  }
>  
> +bool kvm_timer_should_fire(struct kvm_vcpu *vcpu)
> +{
> +	struct arch_timer_cpu *timer = &vcpu->arch.timer_cpu;
> +	cycle_t cval, now;
> +
> +	if ((timer->cntv_ctl & ARCH_TIMER_CTRL_IT_MASK) ||
> +		!(timer->cntv_ctl & ARCH_TIMER_CTRL_ENABLE))
> +		return false;
> +
> +	cval = timer->cntv_cval;
> +	now = kvm_phys_timer_read() - vcpu->kvm->arch.timer.cntvoff;
> +
> +	return cval <= now;
> +}
> +
>  /**
>   * kvm_timer_flush_hwstate - prepare to move the virt timer to the
> cpu
>   * @vcpu: The vcpu pointer
> @@ -119,6 +143,13 @@ void kvm_timer_flush_hwstate(struct kvm_vcpu
> *vcpu)
>  	 * populate the CPU timer again.
>  	 */
>  	timer_disarm(timer);
> +
> +	/*
> +	 * If the timer expired while we were not scheduled, now is
> the time
> +	 * to inject it.
> +	 */
> +	if (kvm_timer_should_fire(vcpu))
> +		kvm_timer_inject_irq(vcpu);
>  }
>  
>  /**
> @@ -134,16 +165,9 @@ void kvm_timer_sync_hwstate(struct kvm_vcpu
> *vcpu) cycle_t cval, now;
>  	u64 ns;
>  
> -	if ((timer->cntv_ctl & ARCH_TIMER_CTRL_IT_MASK) ||
> -		!(timer->cntv_ctl & ARCH_TIMER_CTRL_ENABLE))
> -		return;
> -
> -	cval = timer->cntv_cval;
> -	now = kvm_phys_timer_read() - vcpu->kvm->arch.timer.cntvoff;
> -
>  	BUG_ON(timer_is_armed(timer));
>  
> -	if (cval <= now) {
> +	if (kvm_timer_should_fire(vcpu)) {
>  		/*
>  		 * Timer has already expired while we were not
>  		 * looking. Inject the interrupt and carry on.
> @@ -152,6 +176,9 @@ void kvm_timer_sync_hwstate(struct kvm_vcpu *vcpu)
>  		return;
>  	}
>  
> +	cval = timer->cntv_cval;
> +	now = kvm_phys_timer_read() - vcpu->kvm->arch.timer.cntvoff;
> +
>  	ns = cyclecounter_cyc2ns(timecounter->cc, cval - now,
> timecounter->mask, &timecounter->frac);
>  	timer_arm(timer, ns);

So the first half of the patch looks perfectly OK to me...

> diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
> index af6a521..3b4ded2 100644
> --- a/virt/kvm/arm/vgic.c
> +++ b/virt/kvm/arm/vgic.c
> @@ -263,6 +263,13 @@ static int vgic_irq_is_queued(struct kvm_vcpu
> *vcpu, int irq) return vgic_bitmap_get_irq_val(&dist->irq_queued,
> vcpu->vcpu_id, irq); }
>  
> +static int vgic_irq_is_active(struct kvm_vcpu *vcpu, int irq)
> +{
> +	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
> +
> +	return vgic_bitmap_get_irq_val(&dist->irq_active,
> vcpu->vcpu_id, irq); +}
> +
>  static void vgic_irq_set_queued(struct kvm_vcpu *vcpu, int irq)
>  {
>  	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
> @@ -285,6 +292,13 @@ static void vgic_irq_set_active(struct kvm_vcpu
> *vcpu, int irq) vgic_bitmap_set_irq_val(&dist->irq_active,
> vcpu->vcpu_id, irq, 1); }
>  
> +static void vgic_irq_clear_active(struct kvm_vcpu *vcpu, int irq)
> +{
> +	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
> +
> +	vgic_bitmap_set_irq_val(&dist->irq_active, vcpu->vcpu_id,
> irq, 0); +}
> +
>  static int vgic_dist_irq_get_level(struct kvm_vcpu *vcpu, int irq)
>  {
>  	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
> @@ -634,16 +648,12 @@ bool vgic_handle_cfg_reg(u32 *reg, struct
> kvm_exit_mmio *mmio, }
>  
>  /**
> - * vgic_unqueue_irqs - move pending IRQs from LRs to the distributor
> + * vgic_unqueue_irqs - move pending/active IRQs from LRs to the
> distributor
>   * @vgic_cpu: Pointer to the vgic_cpu struct holding the LRs
>   *
> - * Move any pending IRQs that have already been assigned to LRs back
> to the
> + * Move any IRQs that have already been assigned to LRs back to the
>   * emulated distributor state so that the complete emulated state
> can be read
>   * from the main emulation structures without investigating the LRs.
> - *
> - * Note that IRQs in the active state in the LRs get their pending
> state moved
> - * to the distributor but the active state stays in the LRs, because
> we don't
> - * track the active state on the distributor side.
>   */
>  void vgic_unqueue_irqs(struct kvm_vcpu *vcpu)
>  {
> @@ -919,7 +929,7 @@ static int compute_pending_for_cpu(struct
> kvm_vcpu *vcpu) 
>  /*
>   * Update the interrupt state and determine which CPUs have pending
> - * interrupts. Must be called with distributor lock held.
> + * or active interrupts. Must be called with distributor lock held.
>   */
>  void vgic_update_state(struct kvm *kvm)
>  {
> @@ -1036,6 +1046,25 @@ static void vgic_retire_disabled_irqs(struct
> kvm_vcpu *vcpu) }
>  }
>  
> +static void vgic_queue_irq_to_lr(struct kvm_vcpu *vcpu, int irq,
> +				 int lr_nr, struct vgic_lr vlr)
> +{
> +	if (vgic_irq_is_active(vcpu, irq)) {
> +		vlr.state |= LR_STATE_ACTIVE;
> +		kvm_debug("Set active, clear distributor: 0x%x\n",
> vlr.state);
> +		vgic_irq_clear_active(vcpu, irq);
> +		vgic_update_state(vcpu->kvm);
> +	} else if (vgic_dist_irq_is_pending(vcpu, irq)) {
> +		vlr.state |= LR_STATE_PENDING;
> +		kvm_debug("Set pending: 0x%x\n", vlr.state);
> +	}
> +
> +	if (!vgic_irq_is_edge(vcpu, irq))
> +		vlr.state |= LR_EOI_INT;
> +
> +	vgic_set_lr(vcpu, lr_nr, vlr);
> +}
> +
>  /*
>   * Queue an interrupt to a CPU virtual interface. Return true on
> success,
>   * or false if it wasn't possible to queue it.
> @@ -1063,8 +1092,7 @@ bool vgic_queue_irq(struct kvm_vcpu *vcpu, u8
> sgi_source_id, int irq) if (vlr.source == sgi_source_id) {
>  			kvm_debug("LR%d piggyback for IRQ%d\n", lr,
> vlr.irq); BUG_ON(!test_bit(lr, vgic_cpu->lr_used));
> -			vlr.state |= LR_STATE_PENDING;
> -			vgic_set_lr(vcpu, lr, vlr);
> +			vgic_queue_irq_to_lr(vcpu, irq, lr, vlr);
>  			return true;
>  		}
>  	}
> @@ -1081,11 +1109,8 @@ bool vgic_queue_irq(struct kvm_vcpu *vcpu, u8
> sgi_source_id, int irq) 
>  	vlr.irq = irq;
>  	vlr.source = sgi_source_id;
> -	vlr.state = LR_STATE_PENDING;
> -	if (!vgic_irq_is_edge(vcpu, irq))
> -		vlr.state |= LR_EOI_INT;
> -
> -	vgic_set_lr(vcpu, lr, vlr);
> +	vlr.state = 0;
> +	vgic_queue_irq_to_lr(vcpu, irq, lr, vlr);
>  
>  	return true;
>  }


... but this whole vgic rework seems rather out of place, and I can't
really see its connection with the timer. Isn't it logically part of the
previous patch?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
