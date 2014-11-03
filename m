From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 3 Nov 2014 14:25:43 +0100
Subject: [PATCH v3 04/19] arm/arm64: KVM: wrap 64 bit MMIO accesses with
 two 32 bit ones
In-Reply-To: <1414776414-13426-5-git-send-email-andre.przywara@arm.com>
References: <1414776414-13426-1-git-send-email-andre.przywara@arm.com>
 <1414776414-13426-5-git-send-email-andre.przywara@arm.com>
Message-ID: <20141103132543.GE16132@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 31, 2014 at 05:26:39PM +0000, Andre Przywara wrote:
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
> index 704be48..0cbdde9 100644
> --- a/virt/kvm/arm/vgic.c
> +++ b/virt/kvm/arm/vgic.c
> @@ -1033,6 +1033,48 @@ static bool vgic_validate_access(const struct vgic_dist *dist,
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
> +	 * Any access bigger than 4 bytes (that we currently handle in KVM)
> +	 * is actually 8 bytes long, caused by a 64-bit access
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
> +
> +	return ret;
> +}

Please think about the endianness issues here.

Thanks,
-Christoffer
