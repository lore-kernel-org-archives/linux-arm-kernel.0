From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 15 Oct 2014 09:26:15 -0700
Subject: [PATCH v2 04/15] arm/arm64: KVM: wrap 64 bit MMIO accesses with
 two 32 bit ones
In-Reply-To: <1408626416-11326-5-git-send-email-andre.przywara@arm.com>
References: <1408626416-11326-1-git-send-email-andre.przywara@arm.com>
 <1408626416-11326-5-git-send-email-andre.przywara@arm.com>
Message-ID: <20141015162615.GE14272@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 21, 2014 at 02:06:45PM +0100, Andre Przywara wrote:
> Some GICv3 registers can and will be accessed as 64 bit registers.
> Currently the register handling code can only deal with 32 bit
> accesses, so we do two consecutive calls to cover this.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  virt/kvm/arm/vgic.c |   48 +++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 45 insertions(+), 3 deletions(-)
> 
> diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
> index 3b6f78d..bef9aa0 100644
> --- a/virt/kvm/arm/vgic.c
> +++ b/virt/kvm/arm/vgic.c
> @@ -926,6 +926,48 @@ static bool vgic_validate_access(const struct vgic_dist *dist,
>  }
>  
>  /*
> + * Call the respective handler function for the given range.
> + * We split up any 64 bit accesses into two consecutive 32 bit
> + * handler calls and merge the result afterwards.
> + */
> +static bool call_range_handler(struct kvm_vcpu *vcpu,
> +			       struct kvm_exit_mmio *mmio,
> +			       unsigned long offset,
> +			       const struct mmio_range *range)
> +{
> +	u32 *data32 = (void *)mmio->data;
> +	struct kvm_exit_mmio mmio32;
> +	bool ret;
> +
> +	if (likely(mmio->len <= 4))
> +		return range->handle_mmio(vcpu, mmio, offset);
> +
> +	/*
> +	 * We assume that any access greater than 4 bytes is actually

Is this an assumption or something that will always hold true at this
point in the code?  If the former, which situations could it not hold
and what would happen?  If the latter, we should just state that.

> +	 * 8 bytes long, caused by a 64-bit access
> +	 */
> +
> +	mmio32.len = 4;
> +	mmio32.is_write = mmio->is_write;
> +
> +	mmio32.phys_addr = mmio->phys_addr + 4;
> +	if (mmio->is_write)
> +		*(u32 *)mmio32.data = data32[1];
> +	ret = range->handle_mmio(vcpu, &mmio32, offset + 4);
> +	if (!mmio->is_write)
> +		data32[1] = *(u32 *)mmio32.data;
> +
> +	mmio32.phys_addr = mmio->phys_addr;
> +	if (mmio->is_write)
> +		*(u32 *)mmio32.data = data32[0];
> +	ret |= range->handle_mmio(vcpu, &mmio32, offset);
> +	if (!mmio->is_write)
> +		data32[0] = *(u32 *)mmio32.data;

won't this break on a BE system?

> +
> +	return ret;
> +}
> +
> +/*
>   * vgic_handle_mmio_range - handle an in-kernel MMIO access
>   * @vcpu:	pointer to the vcpu performing the access
>   * @run:	pointer to the kvm_run structure
> @@ -956,10 +998,10 @@ static bool vgic_handle_mmio_range(struct kvm_vcpu *vcpu, struct kvm_run *run,
>  	spin_lock(&vcpu->kvm->arch.vgic.lock);
>  	offset -= range->base;
>  	if (vgic_validate_access(dist, range, offset)) {
> -		updated_state = range->handle_mmio(vcpu, mmio, offset);
> +		updated_state = call_range_handler(vcpu, mmio, offset, range);
>  	} else {
> -		vgic_reg_access(mmio, NULL, offset,
> -				ACCESS_READ_RAZ | ACCESS_WRITE_IGNORED);
> +		if (!mmio->is_write)
> +			memset(mmio->data, 0, mmio->len);
>  		updated_state = false;
>  	}
>  	spin_unlock(&vcpu->kvm->arch.vgic.lock);
> -- 
> 1.7.9.5
> 

Thanks,
-Christoffer
