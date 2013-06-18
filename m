From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 18 Jun 2013 12:21:33 -0700
Subject: [PATCH] ARM: KVM: vgic: simplify vgic_get_target_reg
In-Reply-To: <1371550209-8123-1-git-send-email-marc.zyngier@arm.com>
References: <1371550209-8123-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20130618192133.GA6213@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 18, 2013 at 11:10:09AM +0100, Marc Zyngier wrote:
> vgic_get_target_reg is quite complicated, for no good reason.
> Actually, it is fairly easy to write it in a much more efficient
> way by using the target CPU array instead of the bitmap.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm/kvm/vgic.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/kvm/vgic.c b/arch/arm/kvm/vgic.c
> index 17c5ac7..a2d478a 100644
> --- a/arch/arm/kvm/vgic.c
> +++ b/arch/arm/kvm/vgic.c
> @@ -432,19 +432,13 @@ static bool handle_mmio_priority_reg(struct kvm_vcpu *vcpu,
>  static u32 vgic_get_target_reg(struct kvm *kvm, int irq)
>  {
>  	struct vgic_dist *dist = &kvm->arch.vgic;
> -	struct kvm_vcpu *vcpu;
> -	int i, c;
> -	unsigned long *bmap;
> +	int i;
>  	u32 val = 0;
>  
>  	irq -= VGIC_NR_PRIVATE_IRQS;
>  
> -	kvm_for_each_vcpu(c, vcpu, kvm) {
> -		bmap = vgic_bitmap_get_shared_map(&dist->irq_spi_target[c]);
> -		for (i = 0; i < GICD_IRQS_PER_ITARGETSR; i++)
> -			if (test_bit(irq + i, bmap))
> -				val |= 1 << (c + i * 8);
> -	}
> +	for (i = 0; i < GICD_IRQS_PER_ITARGETSR; i++)
> +		val |= 1 << (dist->irq_spi_cpu[irq + i] + i * 8);
>  
>  	return val;
>  }
> -- 
> 1.8.2.3
> 
ack
