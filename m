From: cdall@linaro.org (Christoffer Dall)
Date: Wed, 22 Feb 2017 14:16:29 +0100
Subject: [RFC 30/55] KVM: arm/arm64: Inject irqs to the guest hypervisor
In-Reply-To: <1483943091-1364-31-git-send-email-jintack@cs.columbia.edu>
References: <1483943091-1364-1-git-send-email-jintack@cs.columbia.edu>
 <1483943091-1364-31-git-send-email-jintack@cs.columbia.edu>
Message-ID: <20170222131629.GQ26976@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 09, 2017 at 01:24:26AM -0500, Jintack Lim wrote:
> If we have a pending IRQ for the guest and the guest expects IRQs
> to be handled in its virtual EL2 mode (the virtual IMO bit is set)
> and it is not already running in virtual EL2 mode, then we have to
> emulate an IRQ exception.
> 
> Signed-off-by: Jintack Lim <jintack@cs.columbia.edu>
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> ---
>  virt/kvm/arm/vgic/vgic.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/virt/kvm/arm/vgic/vgic.c b/virt/kvm/arm/vgic/vgic.c
> index 6440b56..4a98654 100644
> --- a/virt/kvm/arm/vgic/vgic.c
> +++ b/virt/kvm/arm/vgic/vgic.c
> @@ -17,6 +17,7 @@
>  #include <linux/kvm.h>
>  #include <linux/kvm_host.h>
>  #include <linux/list_sort.h>
> +#include <asm/kvm_emulate.h>
>  
>  #include "vgic.h"
>  
> @@ -652,6 +653,28 @@ static void vgic_flush_lr_state(struct kvm_vcpu *vcpu)
>  	/* Nuke remaining LRs */
>  	for ( ; count < kvm_vgic_global_state.nr_lr; count++)
>  		vgic_clear_lr(vcpu, count);
> +
> +	/*
> +	 * If we have any pending IRQ for the guest and the guest expects IRQs
> +	 * to be handled in its virtual EL2 mode (the virtual IMO bit is set)
> +	 * and it is not already running in virtual EL2 mode, then we have to
> +	 * emulate an IRQ exception to virtual IRQ. Note that a pending IRQ
> +	 * means an irq of which state is pending but not active.
> +	 */
> +	if (vcpu_el2_imo_is_set(vcpu) && !vcpu_mode_el2(vcpu)) {

Is this correct?

Shouldn't you also inject this to virtual EL2 even when virtual EL2 is
already running as long as the PSTATE.I bit is clear?

> +		bool pending = false;
> +
> +		list_for_each_entry(irq, &vgic_cpu->ap_list_head, ap_list) {

You need to take a lock when iterating over this list.

> +			spin_lock(&irq->irq_lock);
> +			pending = irq->pending && irq->enabled && !irq->active;
> +			spin_unlock(&irq->irq_lock);
> +
> +			if (pending) {
> +				kvm_inject_nested_irq(vcpu);
> +				break;
> +			}
> +		}

I would prefer to see this check that loops over the AP list as a
separate function that you call, like vgic_vcpu_has_pending_irq.

> +	}
>  }
>  
>  /* Sync back the hardware VGIC state into our emulation after a guest's run. */
> -- 
> 1.9.1
> 
> 

Thanks,
-Christoffer
