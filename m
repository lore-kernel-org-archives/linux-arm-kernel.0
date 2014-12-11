From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 11 Dec 2014 18:35:40 +0000
Subject: [PATCH 5/5] arm/arm64: KVM: Initialize the vgic on-demand when
 injecting IRQs
In-Reply-To: <1418139844-27892-6-git-send-email-christoffer.dall@linaro.org>
References: <1418139844-27892-1-git-send-email-christoffer.dall@linaro.org>
 <1418139844-27892-6-git-send-email-christoffer.dall@linaro.org>
Message-ID: <5489E3FC.2000304@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/12/14 15:44, Christoffer Dall wrote:
> Userspace assumes that it can wire up IRQ injections after having
> created all VCPUs and after having created the VGIC, but potentially
> before starting the first VCPU.  This can currently lead to lost IRQs
> because the state of that IRQ injection is not stored anywhere and we
> don't return an error to userspace.
> 
> We haven't seen this problem manifest itself yet, presumably because
> guests reset the devices on boot, but this could cause issues with
> migration and other non-standard startup configurations.
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> ---
>  virt/kvm/arm/vgic.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
> index c98cc6b..feef015 100644
> --- a/virt/kvm/arm/vgic.c
> +++ b/virt/kvm/arm/vgic.c
> @@ -1693,8 +1693,13 @@ out:
>  int kvm_vgic_inject_irq(struct kvm *kvm, int cpuid, unsigned int irq_num,
>  			bool level)
>  {
> -	if (likely(vgic_ready(kvm)) &&
> -	    vgic_update_irq_pending(kvm, cpuid, irq_num, level))
> +	if (unlikely(!vgic_initialized(kvm))) {
> +		mutex_lock(&kvm->lock);
> +		vgic_init(kvm);

What if this fails?

> +		mutex_unlock(&kvm->lock);
> +	}
> +
> +	if (vgic_update_irq_pending(kvm, cpuid, irq_num, level))
>  		vgic_kick_vcpus(kvm);
>  
>  	return 0;
> 

	M.
-- 
Jazz is not dead. It just smells funny...
