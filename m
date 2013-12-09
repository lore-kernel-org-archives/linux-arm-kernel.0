From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 09 Dec 2013 15:47:32 +0000
Subject: [PATCH v3 5/9] KVM: arm-vgic: Make vgic mmio functions more
 generic
In-Reply-To: <1384662620-13795-6-git-send-email-christoffer.dall@linaro.org>
References: <1384662620-13795-1-git-send-email-christoffer.dall@linaro.org>
 <1384662620-13795-6-git-send-email-christoffer.dall@linaro.org>
Message-ID: <6ef0bad85308f31b06275464f7d7f289@www.loen.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013-11-17 04:30, Christoffer Dall wrote:
> Rename the vgic_ranges array to vgic_dist_ranges to be more specific 
> and
> to prepare for handling CPU interface register access as well (for
> save/restore of VGIC state).
>
> Pass offset from distributor or interface MMIO base to
> find_matching_range function instead of the physical address of the
> access in the VM memory map.  This allows other callers unaware of 
> the
> VM specifics, but with generic VGIC knowledge to reuse the function.
>
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

> ---
>  virt/kvm/arm/vgic.c |   12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
> index edca754..9b9fa20 100644
> --- a/virt/kvm/arm/vgic.c
> +++ b/virt/kvm/arm/vgic.c
> @@ -602,7 +602,7 @@ struct mmio_range {
>  			    phys_addr_t offset);
>  };
>
> -static const struct mmio_range vgic_ranges[] = {
> +static const struct mmio_range vgic_dist_ranges[] = {
>  	{
>  		.base		= GIC_DIST_CTRL,
>  		.len		= 12,
> @@ -669,14 +669,13 @@ static const struct mmio_range vgic_ranges[] = 
> {
>  static const
>  struct mmio_range *find_matching_range(const struct mmio_range 
> *ranges,
>  				       struct kvm_exit_mmio *mmio,
> -				       phys_addr_t base)
> +				       phys_addr_t offset)
>  {
>  	const struct mmio_range *r = ranges;
> -	phys_addr_t addr = mmio->phys_addr - base;
>
>  	while (r->len) {
> -		if (addr >= r->base &&
> -		    (addr + mmio->len) <= (r->base + r->len))
> +		if (offset >= r->base &&
> +		    (offset + mmio->len) <= (r->base + r->len))
>  			return r;
>  		r++;
>  	}
> @@ -713,7 +712,8 @@ bool vgic_handle_mmio(struct kvm_vcpu *vcpu,
> struct kvm_run *run,
>  		return true;
>  	}
>
> -	range = find_matching_range(vgic_ranges, mmio, base);
> +	offset = mmio->phys_addr - base;
> +	range = find_matching_range(vgic_dist_ranges, mmio, offset);
>  	if (unlikely(!range || !range->handle_mmio)) {
>  		pr_warn("Unhandled access %d %08llx %d\n",
>  			mmio->is_write, mmio->phys_addr, mmio->len);

-- 
Fast, cheap, reliable. Pick two.
