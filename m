From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sun, 14 Dec 2014 11:35:29 +0000
Subject: [PATCH v2 5/6] arm/arm64: KVM: Initialize the vgic on-demand when
 injecting IRQs
In-Reply-To: <1418469449-13277-6-git-send-email-christoffer.dall@linaro.org>
 (Christoffer Dall's message of "Sat, 13 Dec 2014 11:17:28 +0000")
References: <1418469449-13277-1-git-send-email-christoffer.dall@linaro.org>
 <1418469449-13277-6-git-send-email-christoffer.dall@linaro.org>
Message-ID: <86tx0y1n26.fsf@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 13 2014 at 11:17:28 AM, Christoffer Dall <christoffer.dall@linaro.org> wrote:
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
>  virt/kvm/arm/vgic.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
> index e1bef68..330445c 100644
> --- a/virt/kvm/arm/vgic.c
> +++ b/virt/kvm/arm/vgic.c
> @@ -1693,11 +1693,22 @@ out:
>  int kvm_vgic_inject_irq(struct kvm *kvm, int cpuid, unsigned int irq_num,
>  			bool level)
>  {
> -	if (likely(vgic_ready(kvm)) &&
> -	    vgic_update_irq_pending(kvm, cpuid, irq_num, level))
> +	int ret = 0;
> +
> +	if (unlikely(!vgic_initialized(kvm))) {
> +		mutex_lock(&kvm->lock);
> +		ret = vgic_init(kvm);
> +		mutex_unlock(&kvm->lock);
> +
> +		if (ret)
> +			goto out;
> +	}
> +
> +	if (vgic_update_irq_pending(kvm, cpuid, irq_num, level))
>  		vgic_kick_vcpus(kvm);
>  
> -	return 0;
> +out:
> +	return ret;
>  }
>  
>  static irqreturn_t vgic_maintenance_handler(int irq, void *data)

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny.
