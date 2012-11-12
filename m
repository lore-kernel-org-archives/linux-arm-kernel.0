From: b29396@freescale.com (Dong Aisheng)
Date: Mon, 12 Nov 2012 17:29:03 +0800
Subject: [PATCH v4 06/13] ARM: KVM: VGIC distributor handling
In-Reply-To: <20121110154458.3061.28629.stgit@chazy-air>
References: <20121110154358.3061.16338.stgit@chazy-air>
 <20121110154458.3061.28629.stgit@chazy-air>
Message-ID: <20121112092902.GC29502@b29396-Latitude-E6410>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 10, 2012 at 04:44:58PM +0100, Christoffer Dall wrote:
[...]
> @@ -141,7 +519,98 @@ struct mmio_range *find_matching_range(const struct mmio_range *ranges,
>   */
>  bool vgic_handle_mmio(struct kvm_vcpu *vcpu, struct kvm_run *run, struct kvm_exit_mmio *mmio)
>  {
> -	return KVM_EXIT_MMIO;
> +	const struct mmio_range *range;
> +	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
> +	unsigned long base = dist->vgic_dist_base;
> +	bool updated_state;
> +
> +	if (!irqchip_in_kernel(vcpu->kvm) ||
> +	    mmio->phys_addr < base ||
> +	    (mmio->phys_addr + mmio->len) > (base + dist->vgic_dist_size))
> +		return false;
> +
> +	range = find_matching_range(vgic_ranges, mmio, base);
> +	if (unlikely(!range || !range->handle_mmio)) {
> +		pr_warn("Unhandled access %d %08llx %d\n",
> +			mmio->is_write, mmio->phys_addr, mmio->len);
> +		return false;
> +	}
> +
> +	spin_lock(&vcpu->kvm->arch.vgic.lock);
> +	updated_state = range->handle_mmio(vcpu, mmio,mmio->phys_addr - range->base - base);
Missing space after ','.
Checkpatch may fail here.

Regards
Dong Aisheng
