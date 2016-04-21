From: eric.auger@linaro.org (Eric Auger)
Date: Thu, 21 Apr 2016 19:09:32 +0200
Subject: [PATCH 3/7] KVM: arm/arm64: directly pass virtual IRQ number on
 kvm_vgic_map_is_active()
In-Reply-To: <1460729047-6346-4-git-send-email-andre.przywara@arm.com>
References: <1460729047-6346-1-git-send-email-andre.przywara@arm.com>
 <1460729047-6346-4-git-send-email-andre.przywara@arm.com>
Message-ID: <5719094C.4080101@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andre,
On 04/15/2016 04:04 PM, Andre Przywara wrote:
> For getting the active state of a mapped IRQ, we actually only need
> the virtual IRQ number, not the pointer to the mapping entry.
> Pass the virtual IRQ number from the arch timer to the VGIC directly.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  include/kvm/arm_vgic.h    | 2 +-
>  virt/kvm/arm/arch_timer.c | 2 +-
>  virt/kvm/arm/vgic.c       | 6 +++---
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
> index c4574da..5a34adc 100644
> --- a/include/kvm/arm_vgic.h
> +++ b/include/kvm/arm_vgic.h
> @@ -347,7 +347,7 @@ int kvm_vgic_vcpu_pending_irq(struct kvm_vcpu *vcpu);
>  struct irq_phys_map *kvm_vgic_map_phys_irq(struct kvm_vcpu *vcpu,
>  					   int virt_irq, int irq);
>  int kvm_vgic_unmap_phys_irq(struct kvm_vcpu *vcpu, struct irq_phys_map *map);
> -bool kvm_vgic_map_is_active(struct kvm_vcpu *vcpu, struct irq_phys_map *map);
> +bool kvm_vgic_map_is_active(struct kvm_vcpu *vcpu, unsigned int virt_irq);
>  
>  #define irqchip_in_kernel(k)	(!!((k)->arch.vgic.in_kernel))
>  #define vgic_initialized(k)	(!!((k)->arch.vgic.nr_cpus))
> diff --git a/virt/kvm/arm/arch_timer.c b/virt/kvm/arm/arch_timer.c
> index eb56f1e..793465b 100644
> --- a/virt/kvm/arm/arch_timer.c
> +++ b/virt/kvm/arm/arch_timer.c
> @@ -246,7 +246,7 @@ void kvm_timer_flush_hwstate(struct kvm_vcpu *vcpu)
>  	* to ensure that hardware interrupts from the timer triggers a guest
>  	* exit.
>  	*/
> -	if (timer->irq.level || kvm_vgic_map_is_active(vcpu, timer->map))
> +	if (timer->irq.level || kvm_vgic_map_is_active(vcpu, timer->map->virt_irq))
>  		phys_active = true;
>  	else
>  		phys_active = false;
nit:
phys_active =
	(timer->irq.level ||
		kvm_vgic_map_is_active(vcpu, timer->map->virt_irq)); ?

checkpatch warning:

#40: FILE: virt/kvm/arm/arch_timer.c:278:
+	if (timer->irq.level || kvm_vgic_map_is_active(vcpu,
timer->map->virt_irq))

Besides
Reviewed-by: Eric Auger <eric.auger@linaro.org>

Cheers

Eric
> diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
> index 9937d41..6911327 100644
> --- a/virt/kvm/arm/vgic.c
> +++ b/virt/kvm/arm/vgic.c
> @@ -1103,18 +1103,18 @@ static bool dist_active_irq(struct kvm_vcpu *vcpu)
>  	return test_bit(vcpu->vcpu_id, dist->irq_active_on_cpu);
>  }
>  
> -bool kvm_vgic_map_is_active(struct kvm_vcpu *vcpu, struct irq_phys_map *map)
> +bool kvm_vgic_map_is_active(struct kvm_vcpu *vcpu, unsigned int virt_irq)
>  {
>  	int i;
>  
>  	for (i = 0; i < vcpu->arch.vgic_cpu.nr_lr; i++) {
>  		struct vgic_lr vlr = vgic_get_lr(vcpu, i);
>  
> -		if (vlr.irq == map->virt_irq && vlr.state & LR_STATE_ACTIVE)
> +		if (vlr.irq == virt_irq && vlr.state & LR_STATE_ACTIVE)
>  			return true;
>  	}
>  
> -	return vgic_irq_is_active(vcpu, map->virt_irq);
> +	return vgic_irq_is_active(vcpu, virt_irq);
>  }
>  
>  /*
> 
