From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 21 Oct 2013 15:03:56 +0100
Subject: [RFC PATCH 4/5] arm/arm64: KVM: vgic: handle out-of-range MMIO
 accesses
In-Reply-To: <1380888978-27725-5-git-send-email-marc.zyngier@arm.com>
References: <1380888978-27725-1-git-send-email-marc.zyngier@arm.com>
 <1380888978-27725-5-git-send-email-marc.zyngier@arm.com>
Message-ID: <20131021140356.GH39411@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 04, 2013 at 01:16:17PM +0100, Marc Zyngier wrote:
> Now that we can (almost) dynamically size the number of interrupts,
> we're facing an interesting issue:
> 
> We have to evaluate at runtime whether or not an access hits a valid
> register, based on the sizing of this particular instance of the
> distributor. Furthermore, the GIC spec says that accessing a reserved
> register is RAZ/WI.

So this was a problem before anything relating to dynamic sizing of the
gic, right?

> 
> For this, add a new field to our range structure, indicating the number
> of bits a single interrupts uses. That allows us to find out whether or
> not the access is in range.

Hmmm, I don't think this is really what this is doing: this is
addressing the registers for unimplemented interrupts, which is
described per register in the GIC specs, and should therefore reasonably
be handled within the accessor functions individually instead of a
global validate function.  I feel the current approach makes the code
slightly harder to read to avoid replicating some very trivial logic,
but I don't feel strongly about this.

However, we still need to add the reserved register regions (e.g.
offsets 0x00C-0x01C and friends).

> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  include/kvm/arm_vgic.h |  3 ++-
>  virt/kvm/arm/vgic.c    | 56 ++++++++++++++++++++++++++++++++++++++++----------
>  2 files changed, 47 insertions(+), 12 deletions(-)
> 
> diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
> index 4d4ab2e..a57757d 100644
> --- a/include/kvm/arm_vgic.h
> +++ b/include/kvm/arm_vgic.h
> @@ -31,6 +31,7 @@
>  #define VGIC_NR_PPIS		16
>  #define VGIC_NR_PRIVATE_IRQS	(VGIC_NR_SGIS + VGIC_NR_PPIS)
>  #define VGIC_MAX_LRS		(1 << 6)
> +#define VGIC_MAX_IRQS		1024
>  
>  /* Sanity checks... */
>  #if (KVM_MAX_VCPUS > 8)
> @@ -41,7 +42,7 @@
>  #error "VGIC_NR_IRQS must be a multiple of 32"
>  #endif
>  
> -#if (VGIC_NR_IRQS > 1024)
> +#if (VGIC_NR_IRQS > VGIC_MAX_IRQS)
>  #error "VGIC_NR_IRQS must be <= 1024"
>  #endif
>  
> diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
> index 259b9dd..c9d706b 100644
> --- a/virt/kvm/arm/vgic.c
> +++ b/virt/kvm/arm/vgic.c
> @@ -636,6 +636,7 @@ static bool handle_mmio_sgi_reg(struct kvm_vcpu *vcpu,
>  struct mmio_range {
>  	phys_addr_t base;
>  	unsigned long len;
> +	int bits_per_irq;
>  	bool (*handle_mmio)(struct kvm_vcpu *vcpu, struct kvm_exit_mmio *mmio,
>  			    phys_addr_t offset);
>  };
> @@ -644,56 +645,67 @@ static const struct mmio_range vgic_ranges[] = {
>  	{
>  		.base		= GIC_DIST_CTRL,
>  		.len		= 12,
> +		.bits_per_irq	= 0,
>  		.handle_mmio	= handle_mmio_misc,
>  	},
>  	{
>  		.base		= GIC_DIST_IGROUP,
> -		.len		= VGIC_NR_IRQS / 8,
> +		.len		= VGIC_MAX_IRQS / 8,
> +		.bits_per_irq	= 1,
>  		.handle_mmio	= handle_mmio_raz_wi,
>  	},
>  	{
>  		.base		= GIC_DIST_ENABLE_SET,
> -		.len		= VGIC_NR_IRQS / 8,
> +		.len		= VGIC_MAX_IRQS / 8,
> +		.bits_per_irq	= 1,
>  		.handle_mmio	= handle_mmio_set_enable_reg,
>  	},
>  	{
>  		.base		= GIC_DIST_ENABLE_CLEAR,
> -		.len		= VGIC_NR_IRQS / 8,
> +		.len		= VGIC_MAX_IRQS / 8,
> +		.bits_per_irq	= 1,
>  		.handle_mmio	= handle_mmio_clear_enable_reg,
>  	},
>  	{
>  		.base		= GIC_DIST_PENDING_SET,
> -		.len		= VGIC_NR_IRQS / 8,
> +		.len		= VGIC_MAX_IRQS / 8,
> +		.bits_per_irq	= 1,
>  		.handle_mmio	= handle_mmio_set_pending_reg,
>  	},
>  	{
>  		.base		= GIC_DIST_PENDING_CLEAR,
> -		.len		= VGIC_NR_IRQS / 8,
> +		.len		= VGIC_MAX_IRQS / 8,
> +		.bits_per_irq	= 1,
>  		.handle_mmio	= handle_mmio_clear_pending_reg,
>  	},
>  	{
>  		.base		= GIC_DIST_ACTIVE_SET,
> -		.len		= VGIC_NR_IRQS / 8,
> +		.len		= VGIC_MAX_IRQS / 8,
> +		.bits_per_irq	= 1,
>  		.handle_mmio	= handle_mmio_raz_wi,
>  	},
>  	{
>  		.base		= GIC_DIST_ACTIVE_CLEAR,
> -		.len		= VGIC_NR_IRQS / 8,
> +		.len		= VGIC_MAX_IRQS / 8,
> +		.bits_per_irq	= 1,
>  		.handle_mmio	= handle_mmio_raz_wi,
>  	},
>  	{
>  		.base		= GIC_DIST_PRI,
> -		.len		= VGIC_NR_IRQS,
> +		.len		= VGIC_MAX_IRQS,
> +		.bits_per_irq	= 8,
>  		.handle_mmio	= handle_mmio_priority_reg,
>  	},
>  	{
>  		.base		= GIC_DIST_TARGET,
> -		.len		= VGIC_NR_IRQS,
> +		.len		= VGIC_MAX_IRQS,
> +		.bits_per_irq	= 8,
>  		.handle_mmio	= handle_mmio_target_reg,
>  	},
>  	{
>  		.base		= GIC_DIST_CONFIG,
> -		.len		= VGIC_NR_IRQS / 4,
> +		.len		= VGIC_MAX_IRQS / 4,
> +		.bits_per_irq	= 2,
>  		.handle_mmio	= handle_mmio_cfg_reg,
>  	},
>  	{
> @@ -722,6 +734,22 @@ struct mmio_range *find_matching_range(const struct mmio_range *ranges,
>  	return NULL;
>  }
>  
> +static bool vgic_validate_access(const struct vgic_dist *dist,
> +				 const struct mmio_range *range,
> +				 unsigned long offset)
> +{
> +	int irq;
> +
> +	if (!range->bits_per_irq)
> +		return true;	/* Not an irq-based access */
> +
> +	irq = offset * 8 / range->bits_per_irq;
> +	if (irq >= dist->nr_irqs)
> +		return false;
> +
> +	return true;
> +}
> +
>  /**
>   * vgic_handle_mmio - handle an in-kernel MMIO access
>   * @vcpu:	pointer to the vcpu performing the access
> @@ -760,7 +788,13 @@ bool vgic_handle_mmio(struct kvm_vcpu *vcpu, struct kvm_run *run,
>  
>  	spin_lock(&vcpu->kvm->arch.vgic.lock);
>  	offset = mmio->phys_addr - range->base - base;
> -	updated_state = range->handle_mmio(vcpu, mmio, offset);
> +	if (vgic_validate_access(dist, range, offset)) {
> +		updated_state = range->handle_mmio(vcpu, mmio, offset);
> +	} else {
> +		vgic_reg_access(mmio, NULL, offset,
> +				ACCESS_READ_RAZ | ACCESS_WRITE_IGNORED);
> +		updated_state = false;
> +	}
>  	spin_unlock(&vcpu->kvm->arch.vgic.lock);
>  	kvm_prepare_mmio(run, mmio);
>  	kvm_handle_mmio_return(vcpu, run);
> -- 
> 1.8.2.3
> 
> 

-- 
Christoffer
