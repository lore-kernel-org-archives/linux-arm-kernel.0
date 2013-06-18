From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 18 Jun 2013 09:06:27 -0700
Subject: [PATCH] ARM: KVM: vgic: fix GICD_ICFGRn access
In-Reply-To: <1371550168-8036-1-git-send-email-marc.zyngier@arm.com>
References: <1371550168-8036-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20130618160627.GG3332@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 18, 2013 at 11:09:28AM +0100, Marc Zyngier wrote:
> All the code in handle_mmio_cfg_reg() assumes the offset has
> been shifted right to accomodate for the 2:1 bit compression,
> but this is only done when getting the register addess.

I personally think this is a funky assumption.  The offset is called
offset, because it's the offset, not a "compressed index" value, so I'd
prefer to fix the comparison values instead.

If not, put a comment and explain the assumption, because it's not
obvious.

> 
> Shift the offset early so the code works mostly unchanged.
> 
> Reported-by: Zhaobo (Bob, ERC) <zhaobo@huawei.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm/kvm/vgic.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/kvm/vgic.c b/arch/arm/kvm/vgic.c
> index a2d478a..902789f 100644
> --- a/arch/arm/kvm/vgic.c
> +++ b/arch/arm/kvm/vgic.c
> @@ -541,8 +541,12 @@ static bool handle_mmio_cfg_reg(struct kvm_vcpu *vcpu,
>  				struct kvm_exit_mmio *mmio, phys_addr_t offset)
>  {
>  	u32 val;
> -	u32 *reg = vgic_bitmap_get_reg(&vcpu->kvm->arch.vgic.irq_cfg,
> -				       vcpu->vcpu_id, offset >> 1);
> +	u32 *reg;
> +
> +	offset >>= 1;
> +	reg = vgic_bitmap_get_reg(&vcpu->kvm->arch.vgic.irq_cfg,
> +				  vcpu->vcpu_id, offset);
> +
>  	if (offset & 2)
>  		val = *reg >> 16;
>  	else
> -- 
> 1.8.2.3
> 
> 
> 
> _______________________________________________
> kvmarm mailing list
> kvmarm at lists.cs.columbia.edu
> https://lists.cs.columbia.edu/cucslists/listinfo/kvmarm
