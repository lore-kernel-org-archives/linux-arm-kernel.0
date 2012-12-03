From: will.deacon@arm.com (Will Deacon)
Date: Mon, 3 Dec 2012 10:40:48 +0000
Subject: [PATCH v4 05/13] ARM: KVM: VGIC accept vcpu and dist base
 addresses from user space
In-Reply-To: <CANM98qJnobcpkPrro0rMhbONkVEwDE2X3=MK3b-koOT7mnWivA@mail.gmail.com>
References: <20121110154358.3061.16338.stgit@chazy-air>
 <20121110154451.3061.74235.stgit@chazy-air>
 <20121128131139.GG21671@mudshark.cambridge.arm.com>
 <CANM98qJnobcpkPrro0rMhbONkVEwDE2X3=MK3b-koOT7mnWivA@mail.gmail.com>
Message-ID: <20121203104048.GC18579@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 01, 2012 at 02:52:13AM +0000, Christoffer Dall wrote:
> On Wed, Nov 28, 2012 at 8:11 AM, Will Deacon <will.deacon@arm.com> wrote:
> > On Sat, Nov 10, 2012 at 03:44:51PM +0000, Christoffer Dall wrote:
> >> +             kvm->arch.vgic.vgic_dist_base = addr;
> >> +             break;
> >> +     case KVM_VGIC_V2_ADDR_TYPE_CPU:
> >> +             if (!IS_VGIC_ADDR_UNDEF(vgic->vgic_cpu_base))
> >> +                     return -EEXIST;
> >> +             if (addr + VGIC_CPU_SIZE < addr)
> >> +                     return -EINVAL;
> >> +             kvm->arch.vgic.vgic_cpu_base = addr;
> >> +             break;
> >> +     default:
> >> +             r = -ENODEV;
> >> +     }
> >> +
> >> +     if (vgic_ioaddr_overlap(kvm)) {
> >> +             kvm->arch.vgic.vgic_dist_base = VGIC_ADDR_UNDEF;
> >> +             kvm->arch.vgic.vgic_cpu_base = VGIC_ADDR_UNDEF;
> >> +             return -EINVAL;
> >
> > Perhaps we could put all the address checking in one place, so that the wrapping
> > round zero checks and the overlap checks can be in the same function?
> >
> 
> Like this (?):

Almost:

> diff --git a/Documentation/virtual/kvm/api.txt
> b/Documentation/virtual/kvm/api.txt
> index 7f057a2..0b6b95e 100644
> --- a/Documentation/virtual/kvm/api.txt
> +++ b/Documentation/virtual/kvm/api.txt
> @@ -2163,6 +2163,7 @@ Errors:
>    ENXIO:  Device not supported on current system
>    EEXIST: Address already set
>    E2BIG:  Address outside guest physical address space
> +  EBUSY:  Address overlaps with other device range
> 
>  struct kvm_device_address {
>  	__u64 id;
> diff --git a/arch/arm/kvm/vgic.c b/arch/arm/kvm/vgic.c
> index f697c14..660fe24 100644
> --- a/arch/arm/kvm/vgic.c
> +++ b/arch/arm/kvm/vgic.c
> @@ -1230,11 +1230,28 @@ static bool vgic_ioaddr_overlap(struct kvm *kvm)
>  	phys_addr_t cpu = kvm->arch.vgic.vgic_cpu_base;
> 
>  	if (IS_VGIC_ADDR_UNDEF(dist) || IS_VGIC_ADDR_UNDEF(cpu))
> -		return false;
> +		return 0;
>  	if ((dist <= cpu && dist + VGIC_DIST_SIZE > cpu) ||
>  	    (cpu <= dist && cpu + VGIC_CPU_SIZE > dist))
> -		return true;
> -	return false;
> +		return -EBUSY;
> +	return 0;
> +}
> +
> +static int vgic_ioaddr_assign(struct kvm *kvm, phys_addr_t *ioaddr,
> +			      phys_addr_t addr, phys_addr_t size)
> +{
> +	int ret;
> +
> +	if (!IS_VGIC_ADDR_UNDEF(*ioaddr))
> +		return -EEXIST;
> +	if (addr + size < addr)
> +		return -EINVAL;
> +
> +	ret = vgic_ioaddr_overlap(kvm);
> +	if (ret)
> +		return ret;
> +	*ioaddr = addr;
> +	return ret;
>  }
> 
>  int kvm_vgic_set_addr(struct kvm *kvm, unsigned long type, u64 addr)
> @@ -1251,29 +1268,21 @@ int kvm_vgic_set_addr(struct kvm *kvm,
> unsigned long type, u64 addr)
>  	mutex_lock(&kvm->lock);
>  	switch (type) {
>  	case KVM_VGIC_V2_ADDR_TYPE_DIST:
> -		if (!IS_VGIC_ADDR_UNDEF(vgic->vgic_dist_base))
> -			return -EEXIST;
> -		if (addr + VGIC_DIST_SIZE < addr)
> -			return -EINVAL;
> -		kvm->arch.vgic.vgic_dist_base = addr;
> +		r = vgic_ioaddr_assign(kvm, &vgic->vgic_dist_base,
> +				       addr, VGIC_DIST_SIZE);
>  		break;
>  	case KVM_VGIC_V2_ADDR_TYPE_CPU:
>  		if (!IS_VGIC_ADDR_UNDEF(vgic->vgic_cpu_base))
>  			return -EEXIST;
>  		if (addr + VGIC_CPU_SIZE < addr)
>  			return -EINVAL;
> -		kvm->arch.vgic.vgic_cpu_base = addr;
> +		r = vgic_ioaddr_assign(kvm, &vgic->vgic_cpu_base,
> +				       addr, VGIC_CPU_SIZE);

You've left the checking in here, so now everything is checked twice.

Also, you should probably touch bases with Marc as I'm under the impression
that both of you are looking at addressing my comments so it would be good
to avoid tripping over each other on this.

Will
