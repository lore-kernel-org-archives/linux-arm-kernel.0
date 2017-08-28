From: cdall@linaro.org (Christoffer Dall)
Date: Mon, 28 Aug 2017 20:18:46 +0200
Subject: [PATCH v3 50/59] KVM: arm/arm64: GICv4: Use pending_last as a
 scheduling hint
In-Reply-To: <20170731172637.29355-51-marc.zyngier@arm.com>
References: <20170731172637.29355-1-marc.zyngier@arm.com>
 <20170731172637.29355-51-marc.zyngier@arm.com>
Message-ID: <20170828181846.GK24649@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 31, 2017 at 06:26:28PM +0100, Marc Zyngier wrote:
> When a vPE exits, the pending_last flag is set when there are
> pending VLPIs stored in the pending table. Similarily, we set
> this flag when a doorbell interrupt fires, as it indicates the
> same condition.
> 
> Let's update kvm_vgic_vcpu_pending_irq() to account for that
> flag as well, making a vcpu runnable when set.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  virt/kvm/arm/vgic/vgic.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/virt/kvm/arm/vgic/vgic.c b/virt/kvm/arm/vgic/vgic.c
> index a96e566905d2..dfac894f6f03 100644
> --- a/virt/kvm/arm/vgic/vgic.c
> +++ b/virt/kvm/arm/vgic/vgic.c
> @@ -781,6 +781,9 @@ int kvm_vgic_vcpu_pending_irq(struct kvm_vcpu *vcpu)
>  	if (!vcpu->kvm->arch.vgic.enabled)
>  		return false;
>  
> +	if (vcpu->arch.vgic_cpu.vgic_v3.its_vpe.pending_last)
> +		return true;
> +
>  	spin_lock(&vgic_cpu->ap_list_lock);
>  
>  	list_for_each_entry(irq, &vgic_cpu->ap_list_head, ap_list) {
> -- 
> 2.11.0
> 

Acked-by: Christoffer Dall <cdall@linaro.org>
