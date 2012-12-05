From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 5 Dec 2012 11:16:06 +0000
Subject: [PATCH v4 12/13] ARM: KVM: vgic: reduce the number of vcpu kick
In-Reply-To: <20121110154539.3061.82553.stgit@chazy-air>
References: <20121110154358.3061.16338.stgit@chazy-air>
 <20121110154539.3061.82553.stgit@chazy-air>
Message-ID: <20121205111606.GM14363@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For the sake of public education, let me rewrite this patch a bit to
illustrate why atomic_t's are bad, and then people can review this
instead.

Every change I've made here is functionally equivalent to the behaviour
of the atomic type; I have not added any new bugs here that aren't
present in the original code.

It is my hope that through education like this, people will see that
atomic types have no magic properties, and their use does not make
code automatically race free and correct; in fact, the inappropriate
use of atomic types is pure obfuscation and causes confusion.

On Sat, Nov 10, 2012 at 04:45:39PM +0100, Christoffer Dall wrote:
> diff --git a/arch/arm/include/asm/kvm_vgic.h b/arch/arm/include/asm/kvm_vgic.h
> index a8e7a93..7d2662c 100644
> --- a/arch/arm/include/asm/kvm_vgic.h
> +++ b/arch/arm/include/asm/kvm_vgic.h
> @@ -215,6 +215,9 @@ struct vgic_cpu {
>  	u32		vgic_elrsr[2];	/* Saved only */
>  	u32		vgic_apr;
>  	u32		vgic_lr[64];	/* A15 has only 4... */
> +
> +	/* Number of level-triggered interrupt in progress */
> +	atomic_t	irq_active_count;

+	int		irq_active_count;

>  #endif
>  };
>  
> @@ -254,6 +257,8 @@ bool vgic_handle_mmio(struct kvm_vcpu *vcpu, struct kvm_run *run,
>  
>  #define irqchip_in_kernel(k)	(!!((k)->arch.vgic.vctrl_base))
>  #define vgic_initialized(k)	((k)->arch.vgic.ready)
> +#define vgic_active_irq(v)	(atomic_read(&(v)->arch.vgic_cpu.irq_active_count) == 0)
> +

+#define vgic_active_irq(v)	((v)->arch.vgic_cpu.irq_active_count)

>  #else
>  static inline int kvm_vgic_hyp_init(void)
>  {
> @@ -305,6 +310,11 @@ static inline bool vgic_initialized(struct kvm *kvm)
>  {
>  	return true;
>  }
> +
> +static inline int vgic_active_irq(struct kvm_vcpu *vcpu)
> +{
> +	return 0;
> +}
>  #endif
>  
>  #endif
> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
> index a633d9d..1716f12 100644
> --- a/arch/arm/kvm/arm.c
> +++ b/arch/arm/kvm/arm.c
> @@ -94,7 +94,15 @@ int kvm_arch_hardware_enable(void *garbage)
>  
>  int kvm_arch_vcpu_should_kick(struct kvm_vcpu *vcpu)
>  {
> -	return kvm_vcpu_exiting_guest_mode(vcpu) == IN_GUEST_MODE;
> +	if (kvm_vcpu_exiting_guest_mode(vcpu) == IN_GUEST_MODE) {
> +		if (vgic_active_irq(vcpu) &&
> +		    cmpxchg(&vcpu->mode, EXITING_GUEST_MODE, IN_GUEST_MODE) == EXITING_GUEST_MODE)
> +			return 0;

So with the above change to the macro, this becomes:
+		if (vcpu->arch.vgic_cpu.irq_active_count &&
+		    cmpxchg(&vcpu->mode, EXITING_GUEST_MODE, IN_GUEST_MODE) == EXITING_GUEST_MODE)

> +
> +		return 1;
> +	}
> +
> +	return 0;
>  }
>  
>  void kvm_arch_hardware_disable(void *garbage)
> diff --git a/arch/arm/kvm/vgic.c b/arch/arm/kvm/vgic.c
> index 415ddb8..146de1d 100644
> --- a/arch/arm/kvm/vgic.c
> +++ b/arch/arm/kvm/vgic.c
> @@ -705,8 +705,10 @@ static bool vgic_queue_irq(struct kvm_vcpu *vcpu, u8 sgi_source_id, int irq)
>  		kvm_debug("LR%d piggyback for IRQ%d %x\n", lr, irq, vgic_cpu->vgic_lr[lr]);
>  		BUG_ON(!test_bit(lr, vgic_cpu->lr_used));
>  		vgic_cpu->vgic_lr[lr] |= VGIC_LR_PENDING_BIT;
> -		if (is_level)
> +		if (is_level) {
>  			vgic_cpu->vgic_lr[lr] |= VGIC_LR_EOI;
> +			atomic_inc(&vgic_cpu->irq_active_count);

+			spin_lock_irqsave(&atomic_lock, flags);
+			vgic_cpu->irq_active_count++;
+			spin_unlock_irqrestore(&atomic_lock, flags);

> +		}
>  		return true;
>  	}
>  
> @@ -718,8 +720,10 @@ static bool vgic_queue_irq(struct kvm_vcpu *vcpu, u8 sgi_source_id, int irq)
>  
>  	kvm_debug("LR%d allocated for IRQ%d %x\n", lr, irq, sgi_source_id);
>  	vgic_cpu->vgic_lr[lr] = MK_LR_PEND(sgi_source_id, irq);
> -	if (is_level)
> +	if (is_level) {
>  		vgic_cpu->vgic_lr[lr] |= VGIC_LR_EOI;
> +		atomic_inc(&vgic_cpu->irq_active_count);

+		spin_lock_irqsave(&atomic_lock, flags);
+		vgic_cpu->irq_active_count++;
+		spin_unlock_irqrestore(&atomic_lock, flags);

> +	}
>  
>  	vgic_cpu->vgic_irq_lr_map[irq] = lr;
>  	clear_bit(lr, (unsigned long *)vgic_cpu->vgic_elrsr);
> @@ -1011,6 +1015,8 @@ static irqreturn_t vgic_maintenance_handler(int irq, void *data)
>  
>  			vgic_bitmap_set_irq_val(&dist->irq_active,
>  						vcpu->vcpu_id, irq, 0);
> +			atomic_dec(&vgic_cpu->irq_active_count);

+			spin_lock_irqsave(&atomic_lock, flags);
+			vgic_cpu->irq_active_count--;
+			spin_unlock_irqrestore(&atomic_lock, flags);

> +			smp_mb();
>  			vgic_cpu->vgic_lr[lr] &= ~VGIC_LR_EOI;
>  			writel_relaxed(vgic_cpu->vgic_lr[lr],
>  				       dist->vctrl_base + GICH_LR0 + (lr << 2));
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
