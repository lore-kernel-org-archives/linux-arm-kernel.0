From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 15 Oct 2014 09:25:56 -0700
Subject: [PATCH v2 03/15] arm/arm64: KVM: refactor vgic_handle_mmio()
 function
In-Reply-To: <1408626416-11326-4-git-send-email-andre.przywara@arm.com>
References: <1408626416-11326-1-git-send-email-andre.przywara@arm.com>
 <1408626416-11326-4-git-send-email-andre.przywara@arm.com>
Message-ID: <20141015162556.GD14272@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 21, 2014 at 02:06:44PM +0100, Andre Przywara wrote:
> Currently we only need to deal with one MMIO region for the GIC
> emulation, but we soon need to extend this. Refactor the existing
> code to allow easier addition of different ranges without code
> duplication.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  virt/kvm/arm/vgic.c |   72 ++++++++++++++++++++++++++++++++++++---------------
>  1 file changed, 51 insertions(+), 21 deletions(-)
> 
> diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
> index bba8692..3b6f78d 100644
> --- a/virt/kvm/arm/vgic.c
> +++ b/virt/kvm/arm/vgic.c
> @@ -925,37 +925,28 @@ static bool vgic_validate_access(const struct vgic_dist *dist,
>  	return true;
>  }
>  
> -/**
> - * vgic_handle_mmio - handle an in-kernel MMIO access
> +/*
> + * vgic_handle_mmio_range - handle an in-kernel MMIO access
>   * @vcpu:	pointer to the vcpu performing the access
>   * @run:	pointer to the kvm_run structure
>   * @mmio:	pointer to the data describing the access
> + * @ranges:	pointer to the register defining structure
> + * @mmio_base:	base address for this mapping
>   *
> - * returns true if the MMIO access has been performed in kernel space,
> - * and false if it needs to be emulated in user space.
> + * returns true if the MMIO access could be performed
>   */
> -bool vgic_handle_mmio(struct kvm_vcpu *vcpu, struct kvm_run *run,
> -		      struct kvm_exit_mmio *mmio)
> +static bool vgic_handle_mmio_range(struct kvm_vcpu *vcpu, struct kvm_run *run,
> +			    struct kvm_exit_mmio *mmio,
> +			    const struct mmio_range *ranges,
> +			    unsigned long mmio_base)

now when we're chopping this up and about to add more logic based on
our struct mmio_range, I think we should really consider getting rid of
that comment abou the kvm_bus_io_*() API or actually use that API.

>  {
>  	const struct mmio_range *range;
>  	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
> -	unsigned long base = dist->vgic_dist_base;
>  	bool updated_state;
>  	unsigned long offset;
>  
> -	if (!irqchip_in_kernel(vcpu->kvm) ||
> -	    mmio->phys_addr < base ||
> -	    (mmio->phys_addr + mmio->len) > (base + KVM_VGIC_V2_DIST_SIZE))
> -		return false;
> -
> -	/* We don't support ldrd / strd or ldm / stm to the emulated vgic */
> -	if (mmio->len > 4) {
> -		kvm_inject_dabt(vcpu, mmio->phys_addr);
> -		return true;
> -	}
> -
> -	offset = mmio->phys_addr - base;
> -	range = find_matching_range(vgic_dist_ranges, mmio, offset);
> +	offset = mmio->phys_addr - mmio_base;
> +	range = find_matching_range(ranges, mmio, offset);
>  	if (unlikely(!range || !range->handle_mmio)) {
>  		pr_warn("Unhandled access %d %08llx %d\n",
>  			mmio->is_write, mmio->phys_addr, mmio->len);
> @@ -963,7 +954,7 @@ bool vgic_handle_mmio(struct kvm_vcpu *vcpu, struct kvm_run *run,
>  	}
>  
>  	spin_lock(&vcpu->kvm->arch.vgic.lock);
> -	offset = mmio->phys_addr - range->base - base;
> +	offset -= range->base;
>  	if (vgic_validate_access(dist, range, offset)) {
>  		updated_state = range->handle_mmio(vcpu, mmio, offset);
>  	} else {
> @@ -981,6 +972,45 @@ bool vgic_handle_mmio(struct kvm_vcpu *vcpu, struct kvm_run *run,
>  	return true;
>  }
>  
> +#define IS_IN_RANGE(addr, alen, base, len) \
> +	(((addr) >= (base)) && (((addr) + (alen)) < ((base) + (len))))

that should be <= ((base) + (len)) right?

that's a lot of parenthesis, how about creating a static inline instead?

you could also rename alen to access_len

> +
> +static bool vgic_v2_handle_mmio(struct kvm_vcpu *vcpu, struct kvm_run *run,
> +				struct kvm_exit_mmio *mmio)
> +{
> +	unsigned long base = vcpu->kvm->arch.vgic.vgic_dist_base;
> +
> +	if (!IS_IN_RANGE(mmio->phys_addr, mmio->len, base,
> +			 KVM_VGIC_V2_DIST_SIZE))
> +		return false;
> +
> +	/* GICv2 does not support accesses wider than 32 bits */
> +	if (mmio->len > 4) {
> +		kvm_inject_dabt(vcpu, mmio->phys_addr);
> +		return true;
> +	}
> +
> +	return vgic_handle_mmio_range(vcpu, run, mmio, vgic_dist_ranges, base);
> +}
> +
> +/**
> + * vgic_handle_mmio - handle an in-kernel MMIO access for the GIC emulation
> + * @vcpu:      pointer to the vcpu performing the access
> + * @run:       pointer to the kvm_run structure
> + * @mmio:      pointer to the data describing the access
> + *
> + * returns true if the MMIO access has been performed in kernel space,
> + * and false if it needs to be emulated in user space.
> + */
> +bool vgic_handle_mmio(struct kvm_vcpu *vcpu, struct kvm_run *run,
> +		      struct kvm_exit_mmio *mmio)
> +{
> +	if (!irqchip_in_kernel(vcpu->kvm))
> +		return false;
> +
> +	return vgic_v2_handle_mmio(vcpu, run, mmio);
> +}
> +
>  static u8 *vgic_get_sgi_sources(struct vgic_dist *dist, int vcpu_id, int sgi)
>  {
>  	return dist->irq_sgi_sources + vcpu_id * VGIC_NR_SGIS + sgi;
> -- 
> 1.7.9.5
> 

Thanks,
-Christoffer
