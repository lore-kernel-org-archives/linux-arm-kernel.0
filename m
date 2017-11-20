From: cdall@linaro.org (Christoffer Dall)
Date: Mon, 20 Nov 2017 15:52:00 +0100
Subject: [PATCH 2/7] KVM: arm/arm64: vgic: Preserve the revious read from
 the pending table
In-Reply-To: <20171116175821.26544-3-marc.zyngier@arm.com>
References: <20171116175821.26544-1-marc.zyngier@arm.com>
 <20171116175821.26544-3-marc.zyngier@arm.com>
Message-ID: <20171120145200.GK28855@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 16, 2017 at 05:58:16PM +0000, Marc Zyngier wrote:
> The current pending table parsing code assumes that we keep the
> previous read of the pending bits, but keep that variable in
> the current block, making sure it is discarded on each loop.
> 
> We end-up using whatever is on the stack. Who knows, it might
> just be the right thing...

ouch, again.

> 
> Fixes: 280771252c1ba ("KVM: arm64: vgic-v3: KVM_DEV_ARM_VGIC_SAVE_PENDING_TABLES")
> Cc: stable at vger.kernel.org # 4.12
> Reported-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>

> ---
>  virt/kvm/arm/vgic/vgic-v3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/virt/kvm/arm/vgic/vgic-v3.c b/virt/kvm/arm/vgic/vgic-v3.c
> index 2f05f732d3fd..f47e8481fa45 100644
> --- a/virt/kvm/arm/vgic/vgic-v3.c
> +++ b/virt/kvm/arm/vgic/vgic-v3.c
> @@ -327,13 +327,13 @@ int vgic_v3_save_pending_tables(struct kvm *kvm)
>  	int last_byte_offset = -1;
>  	struct vgic_irq *irq;
>  	int ret;
> +	u8 val;
>  
>  	list_for_each_entry(irq, &dist->lpi_list_head, lpi_list) {
>  		int byte_offset, bit_nr;
>  		struct kvm_vcpu *vcpu;
>  		gpa_t pendbase, ptr;
>  		bool stored;
> -		u8 val;
>  
>  		vcpu = irq->target_vcpu;
>  		if (!vcpu)
> -- 
> 2.14.2
> 
