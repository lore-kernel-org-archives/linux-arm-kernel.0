From: andre.przywara@arm.com (Andre Przywara)
Date: Sat, 11 Jul 2015 00:15:52 +0100
Subject: [PATCH v2 4/7] KVM: arm/arm64: enable irqchip routing
In-Reply-To: <1436430137-24205-5-git-send-email-eric.auger@linaro.org>
References: <1436430137-24205-1-git-send-email-eric.auger@linaro.org>
 <1436430137-24205-5-git-send-email-eric.auger@linaro.org>
Message-ID: <55A05228.4030203@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

On 09/07/15 09:22, Eric Auger wrote:
> This patch adds compilation and link against irqchip.
> 
> On ARM, irqchip routing is not really useful since there is
> a single irqchip. However main motivation behind using irqchip
> code is to enable MSI routing code. With the support of in-kernel
> GICv3 ITS emulation, it now seems to be a MUST HAVE requirement.
> 

....

> diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
> index 3630971..6c6c25e 100644
> --- a/virt/kvm/arm/vgic.c
> +++ b/virt/kvm/arm/vgic.c
> @@ -2215,44 +2215,65 @@ out_free_irq:
>  	return ret;
>  }
>  
> -int kvm_irq_map_gsi(struct kvm *kvm,
> -		    struct kvm_kernel_irq_routing_entry *entries,
> -		    int gsi)
> +int vgic_irqfd_set_irq(struct kvm_kernel_irq_routing_entry *e,
> +			struct kvm *kvm, int irq_source_id,
> +			int level, bool line_status)
>  {
> -	return 0;
> -}
> -
> -int kvm_irq_map_chip_pin(struct kvm *kvm, unsigned irqchip, unsigned pin)
> -{
> -	return pin;
> -}
> -
> -int kvm_set_irq(struct kvm *kvm, int irq_source_id,
> -		u32 irq, int level, bool line_status)
> -{
> -	unsigned int spi = irq + VGIC_NR_PRIVATE_IRQS;
> +	unsigned int spi_id = e->irqchip.pin + VGIC_NR_PRIVATE_IRQS;
>  
> -	trace_kvm_set_irq(irq, level, irq_source_id);
> +	trace_kvm_set_irq(spi_id, level, irq_source_id);
>  
>  	BUG_ON(!vgic_initialized(kvm));
>  
> -	return kvm_vgic_inject_irq(kvm, 0, spi, level);
> +	if (spi_id > min(kvm->arch.vgic.nr_irqs, 1020))
> +		return -EINVAL;
> +	return kvm_vgic_inject_irq(kvm, 0, spi_id, level);
> +}
> +
> +/**
> + * Populates a kvm routing entry from a user routing entry
> + * @e: kvm internal formatted entry
> + * @ue: user api formatted entry
> + * return 0 on success, -EINVAL on errors.
> + */
> +int kvm_set_routing_entry(struct kvm_kernel_irq_routing_entry *e,
> +			  const struct kvm_irq_routing_entry *ue)
> +{
> +	int r = -EINVAL;
> +
> +	switch (ue->type) {
> +	case KVM_IRQ_ROUTING_IRQCHIP:
> +		e->set = vgic_irqfd_set_irq;
> +		e->irqchip.irqchip = ue->u.irqchip.irqchip;
> +		e->irqchip.pin = ue->u.irqchip.pin;
> +		if ((e->irqchip.pin >= KVM_IRQCHIP_NUM_PINS) ||
> +		    (e->irqchip.irqchip >= KVM_NR_IRQCHIPS))
> +			goto out;
> +		break;
> +	default:
> +		goto out;
> +	}
> +	r = 0;
> +out:
> +	return r;
>  }
>  
> -/* MSI not implemented yet */
>  int kvm_set_msi(struct kvm_kernel_irq_routing_entry *e,
>  		struct kvm *kvm, int irq_source_id,
>  		int level, bool line_status)
>  {
> -	return 0;
> -}
> +	struct kvm_msi msi;
> +
> +	msi.address_lo = e->msi.address_lo;
> +	msi.address_hi = e->msi.address_hi;
> +	msi.data = e->msi.data;
> +	if (e->type == KVM_IRQ_ROUTING_EXTENDED_MSI) {
> +		msi.devid = e->devid;
> +		msi.flags = KVM_MSI_VALID_DEVID;
> +	}

Can't we make the assignment unconditional?
The GICv2m MSI code does not care about the devid and the ITS code
requires it.
This simplifies quite something in the following patches.
(This refers to the idea of not using the extended type in the kernel).

>  
> -#ifdef CONFIG_HAVE_KVM_MSI
> -int kvm_send_userspace_msi(struct kvm *kvm, struct kvm_msi *msi)
> -{
>  	if (kvm->arch.vgic.vm_ops.inject_msi)
> -		return kvm->arch.vgic.vm_ops.inject_msi(kvm, msi);
> +		return kvm->arch.vgic.vm_ops.inject_msi(kvm, &msi);
>  	else
>  		return -ENODEV;
>  }
> -#endif
> diff --git a/virt/kvm/irqchip.c b/virt/kvm/irqchip.c
> index e678f8a..f26cadd 100644
> --- a/virt/kvm/irqchip.c
> +++ b/virt/kvm/irqchip.c
> @@ -29,7 +29,9 @@
>  #include <linux/srcu.h>
>  #include <linux/export.h>
>  #include <trace/events/kvm.h>
> +#if !defined(CONFIG_ARM) && !defined(CONFIG_ARM64)
>  #include "irq.h"
> +#endif

To what irq.h is that referring to? And why is ARM not allowed to
include that?

Cheers,
Andre.

>  
>  struct kvm_irq_routing_table {
>  	int chip[KVM_NR_IRQCHIPS][KVM_IRQCHIP_NUM_PINS];
> 
