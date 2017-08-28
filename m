From: cdall@linaro.org (Christoffer Dall)
Date: Mon, 28 Aug 2017 20:18:32 +0200
Subject: [PATCH v3 47/59] KVM: arm/arm64: GICv4: Propagate property
 updates to VLPIs
In-Reply-To: <20170731172637.29355-48-marc.zyngier@arm.com>
References: <20170731172637.29355-1-marc.zyngier@arm.com>
 <20170731172637.29355-48-marc.zyngier@arm.com>
Message-ID: <20170828181832.GH24649@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 31, 2017 at 06:26:25PM +0100, Marc Zyngier wrote:
> Upon updating a property, we propagate it all the way to the physical
> ITS, and ask for an INV command to be executed there.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Christoffer Dall <cdall@linaro.org>

> ---
>  virt/kvm/arm/vgic/vgic-its.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
> index 65cc77fde609..9e46081e5f15 100644
> --- a/virt/kvm/arm/vgic/vgic-its.c
> +++ b/virt/kvm/arm/vgic/vgic-its.c
> @@ -297,6 +297,9 @@ static int update_lpi_config(struct kvm *kvm, struct vgic_irq *irq,
>  		spin_unlock(&irq->irq_lock);
>  	}
>  
> +	if (irq->hw)
> +		return its_prop_update_vlpi(irq->host_irq, prop, true);
> +
>  	return 0;
>  }
>  
> -- 
> 2.11.0
> 
