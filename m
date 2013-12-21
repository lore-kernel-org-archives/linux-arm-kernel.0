From: maz@misterjones.org (Marc Zyngier)
Date: Sat, 21 Dec 2013 11:00:48 +0000
Subject: [PATCH v5 08/10] KVM: arm-vgic: Support unqueueing of LRs to the
 dist
In-Reply-To: <1387258201-8738-9-git-send-email-christoffer.dall@linaro.org>
References: <1387258201-8738-1-git-send-email-christoffer.dall@linaro.org>
 <1387258201-8738-9-git-send-email-christoffer.dall@linaro.org>
Message-ID: <aa91f263653df8268c80a41bb7c7d4a1@www.loen.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013-12-17 05:29, Christoffer Dall wrote:
> To properly access the VGIC state from user space it is very 
> unpractical
> to have to loop through all the LRs in all register access functions.
> Instead, support moving all pending state from LRs to the 
> distributor,
> but leave active state LRs alone.
>
> Note that to accurately present the active and pending state to VCPUs
> reading these distributor registers from a live VM, we would have to
> stop all other VPUs than the calling VCPU and ask each CPU to unqueue
> their LR state onto the distributor and add fields to track active 
> state
> on the distributor side as well.  We don't have any users of such
> functionality yet and there are other inaccuracies of the GIC 
> emulation,
> so don't provide accurate synchronized access to this state just yet.
> However, when the time comes, having this function should help.
>
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

> ---
>  virt/kvm/arm/vgic.c | 88
> ++++++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 83 insertions(+), 5 deletions(-)
>
> Changelog[v5]:
>  - Reworked vgic_unqueue_irqs slightly again to also consider the
>    ACTIVE+PENDING case.
>
> Changelog[v4]:
>  - Reworked vgic_unqueue_irqs to explicitly check for the active bit 
> and
>    to not use __test_and_clear_bit.
>
> Changelog[v3]:
>  - New patch in series
>
> diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
> index 88599b5..d08ba28 100644
> --- a/virt/kvm/arm/vgic.c
> +++ b/virt/kvm/arm/vgic.c
> @@ -589,6 +589,80 @@ static bool handle_mmio_sgi_reg(struct kvm_vcpu 
> *vcpu,
>  	return false;
>  }
>
> +#define LR_CPUID(lr)	\
> +	(((lr) & GICH_LR_PHYSID_CPUID) >> GICH_LR_PHYSID_CPUID_SHIFT)
> +#define LR_IRQID(lr)	\
> +	((lr) & GICH_LR_VIRTUALID)
> +
> +static void vgic_retire_lr(int lr_nr, int irq, struct vgic_cpu 
> *vgic_cpu)
> +{
> +	clear_bit(lr_nr, vgic_cpu->lr_used);
> +	vgic_cpu->vgic_lr[lr_nr] &= ~GICH_LR_STATE;
> +	vgic_cpu->vgic_irq_lr_map[irq] = LR_EMPTY;
> +}
> +
> +/**
> + * vgic_unqueue_irqs - move pending IRQs from LRs to the distributor
> + * @vgic_cpu: Pointer to the vgic_cpu struct holding the LRs
> + *
> + * Move any pending IRQs that have already been assigned to LRs back 
> to the
> + * emulated distributor state so that the complete emulated state
> can be read
> + * from the main emulation structures without investigating the LRs.
> + *
> + * Note that IRQs in the active state in the LRs get their pending
> state moved
> + * to the distributor but the active state stays in the LRs, because
> we don't
> + * track the active state on the distributor side.
> + */
> +static void vgic_unqueue_irqs(struct kvm_vcpu *vcpu)
> +{
> +	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
> +	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
> +	int vcpu_id = vcpu->vcpu_id;
> +	int i, irq, source_cpu;
> +	u32 *lr;
> +
> +	for_each_set_bit(i, vgic_cpu->lr_used, vgic_cpu->nr_lr) {
> +		lr = &vgic_cpu->vgic_lr[i];
> +		irq = LR_IRQID(*lr);
> +		source_cpu = LR_CPUID(*lr);
> +
> +		/*
> +		 * There are three options for the state bits:
> +		 *
> +		 * 01: pending
> +		 * 10: active
> +		 * 11: pending and active
> +		 *
> +		 * If the LR holds only an active interrupt (not pending) then
> +		 * just leave it alone.
> +		 */
> +		if ((*lr & GICH_LR_STATE) == GICH_LR_ACTIVE_BIT)
> +			continue;
> +
> +		/*
> +		 * Reestablish the pending state on the distributor and the
> +		 * CPU interface.  It may have already been pending, but that
> +		 * is fine, then we are only setting a few bits that were
> +		 * already set.
> +		 */
> +		vgic_dist_irq_set(vcpu, irq);
> +		if (irq < VGIC_NR_SGIS)
> +			dist->irq_sgi_sources[vcpu_id][irq] |= 1 << source_cpu;
> +		*lr &= ~GICH_LR_PENDING_BIT;
> +
> +		/*
> +		 * If there's no state left on the LR (it could still be
> +		 * active), then the LR does not hold any useful info and can
> +		 * be marked as free for other use.
> +		 */
> +		if (!(*lr & GICH_LR_STATE))
> +			vgic_retire_lr(i, irq, vgic_cpu);
> +
> +		/* Finally update the VGIC state. */
> +		vgic_update_state(vcpu->kvm);
> +	}
> +}
> +
>  static bool handle_mmio_sgi_clear(struct kvm_vcpu *vcpu,
>  				  struct kvm_exit_mmio *mmio,
>  				  phys_addr_t offset)
> @@ -848,8 +922,6 @@ static void vgic_update_state(struct kvm *kvm)
>  	}
>  }
>
> -#define LR_CPUID(lr)	\
> -	(((lr) & GICH_LR_PHYSID_CPUID) >> GICH_LR_PHYSID_CPUID_SHIFT)
>  #define MK_LR_PEND(src, irq)	\
>  	(GICH_LR_PENDING_BIT | ((src) << GICH_LR_PHYSID_CPUID_SHIFT) | 
> (irq))
>
> @@ -871,9 +943,7 @@ static void vgic_retire_disabled_irqs(struct
> kvm_vcpu *vcpu)
>  		int irq = vgic_cpu->vgic_lr[lr] & GICH_LR_VIRTUALID;
>
>  		if (!vgic_irq_is_enabled(vcpu, irq)) {
> -			vgic_cpu->vgic_irq_lr_map[irq] = LR_EMPTY;
> -			clear_bit(lr, vgic_cpu->lr_used);
> -			vgic_cpu->vgic_lr[lr] &= ~GICH_LR_STATE;
> +			vgic_retire_lr(lr, irq, vgic_cpu);
>  			if (vgic_irq_is_active(vcpu, irq))
>  				vgic_irq_clear_active(vcpu, irq);
>  		}
> @@ -1675,6 +1745,14 @@ static int vgic_attr_regs_access(struct
> kvm_device *dev,
>  		}
>  	}
>
> +	/*
> +	 * Move all pending IRQs from the LRs on all VCPUs so the pending
> +	 * state can be properly represented in the register state 
> accessible
> +	 * through this API.
> +	 */
> +	kvm_for_each_vcpu(c, tmp_vcpu, dev->kvm)
> +		vgic_unqueue_irqs(tmp_vcpu);
> +
>  	offset -= r->base;
>  	r->handle_mmio(vcpu, &mmio, offset);

-- 
Who you jivin' with that Cosmik Debris?
