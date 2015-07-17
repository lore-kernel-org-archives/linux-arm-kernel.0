From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sat, 18 Jul 2015 00:15:40 +0200
Subject: [PATCH v2 05/10] KVM: arm/arm64: vgic: Relax vgic_can_sample_irq
 for edge IRQs
In-Reply-To: <1436378202-20224-6-git-send-email-marc.zyngier@arm.com>
References: <1436378202-20224-1-git-send-email-marc.zyngier@arm.com>
 <1436378202-20224-6-git-send-email-marc.zyngier@arm.com>
Message-ID: <20150717221540.GK14024@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 08, 2015 at 06:56:37PM +0100, Marc Zyngier wrote:
> We only set the irq_queued flag for level interrupts, meaning
> that "!vgic_irq_is_queued(vcpu, irq)" is a good enough predicate
> for all interrupts.
> 
> This will allow us to inject edge HW interrupts, for which the
> state ACTIVE+PENDING is not allowed.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  virt/kvm/arm/vgic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
> index bc40137..5bd1695 100644
> --- a/virt/kvm/arm/vgic.c
> +++ b/virt/kvm/arm/vgic.c
> @@ -375,7 +375,7 @@ void vgic_cpu_irq_clear(struct kvm_vcpu *vcpu, int irq)
>  
>  static bool vgic_can_sample_irq(struct kvm_vcpu *vcpu, int irq)
>  {
> -	return vgic_irq_is_edge(vcpu, irq) || !vgic_irq_is_queued(vcpu, irq);
> +	return !vgic_irq_is_queued(vcpu, irq);
>  }
>  
>  /**
> -- 
> 2.1.4
> 
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
