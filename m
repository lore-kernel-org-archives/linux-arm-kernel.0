From: b29396@freescale.com (Dong Aisheng)
Date: Mon, 12 Nov 2012 16:56:51 +0800
Subject: [PATCH v4 05/13] ARM: KVM: VGIC accept vcpu and dist base
 addresses from user space
In-Reply-To: <20121110154451.3061.74235.stgit@chazy-air>
References: <20121110154358.3061.16338.stgit@chazy-air>
 <20121110154451.3061.74235.stgit@chazy-air>
Message-ID: <20121112085650.GB29502@b29396-Latitude-E6410>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 10, 2012 at 04:44:51PM +0100, Christoffer Dall wrote:
[...]
> +int kvm_vgic_set_addr(struct kvm *kvm, unsigned long type, u64 addr)
> +{
> +	int r = 0;
> +	struct vgic_dist *vgic = &kvm->arch.vgic;
> +
> +	if (addr & ~KVM_PHYS_MASK)
> +		return -E2BIG;
> +
> +	if (addr & ~PAGE_MASK)
> +		return -EINVAL;
> +
> +	mutex_lock(&kvm->lock);
> +	switch (type) {
> +	case KVM_VGIC_V2_ADDR_TYPE_DIST:
> +		if (!IS_VGIC_ADDR_UNDEF(vgic->vgic_dist_base))
> +			return -EEXIST;
> +		if (addr + VGIC_DIST_SIZE < addr)
> +			return -EINVAL;
> +		kvm->arch.vgic.vgic_dist_base = addr;
> +		break;
> +	case KVM_VGIC_V2_ADDR_TYPE_CPU:
> +		if (!IS_VGIC_ADDR_UNDEF(vgic->vgic_cpu_base))
> +			return -EEXIST;
> +		if (addr + VGIC_CPU_SIZE < addr)
> +			return -EINVAL;
> +		kvm->arch.vgic.vgic_cpu_base = addr;
> +		break;
> +	default:
> +		r = -ENODEV;
> +	}
> +
> +	if (vgic_ioaddr_overlap(kvm)) {
> +		kvm->arch.vgic.vgic_dist_base = VGIC_ADDR_UNDEF;
> +		kvm->arch.vgic.vgic_cpu_base = VGIC_ADDR_UNDEF;

Missing mutex_unlock?

> +		return -EINVAL;
> +	}
> +
> +	mutex_unlock(&kvm->lock);
> +	return r;
> +}
> 

Regards
Dong Aisheng
