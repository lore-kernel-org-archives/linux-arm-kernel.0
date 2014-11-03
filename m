From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 3 Nov 2014 21:06:00 +0100
Subject: [PATCH v3 09/19] arm/arm64: KVM: make the maximum number of
 vCPUs a per-VM value
In-Reply-To: <1414776414-13426-10-git-send-email-andre.przywara@arm.com>
References: <1414776414-13426-1-git-send-email-andre.przywara@arm.com>
 <1414776414-13426-10-git-send-email-andre.przywara@arm.com>
Message-ID: <20141103200600.GL16132@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 31, 2014 at 05:26:44PM +0000, Andre Przywara wrote:
> Currently the maximum number of vCPUs supported is a global value
> limited by the used GIC model. GICv3 will lift this limit, but we
> still need to observe it for guests using GICv2.
> So the maximum number of vCPUs is per-VM value, depending on the
> GIC model the guest uses.
> Store and check the value in struct kvm_arch, but keep it down to
> 8 for now.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  arch/arm/include/asm/kvm_host.h   |    1 +
>  arch/arm/kvm/arm.c                |    6 ++++++
>  arch/arm64/include/asm/kvm_host.h |    3 +++
>  virt/kvm/arm/vgic-v2.c            |    7 +++++++
>  virt/kvm/arm/vgic-v3.c            |    8 ++++++++
>  5 files changed, 25 insertions(+)
> 
> diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
> index b443dfe..7969e6e 100644
> --- a/arch/arm/include/asm/kvm_host.h
> +++ b/arch/arm/include/asm/kvm_host.h
> @@ -68,6 +68,7 @@ struct kvm_arch {
>  
>  	/* Interrupt controller */
>  	struct vgic_dist	vgic;
> +	int max_vcpus;
>  };
>  
>  #define KVM_NR_MEM_OBJS     40
> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
> index 60c7997..ac0aa7f 100644
> --- a/arch/arm/kvm/arm.c
> +++ b/arch/arm/kvm/arm.c
> @@ -131,6 +131,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
>  
>  	/* Mark the initial VMID generation invalid */
>  	kvm->arch.vmid_gen = 0;
> +	kvm->arch.max_vcpus = CONFIG_KVM_ARM_MAX_VCPUS;
>  
>  	return ret;
>  out_free_stage2_pgd:
> @@ -213,6 +214,11 @@ struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm, unsigned int id)
>  	int err;
>  	struct kvm_vcpu *vcpu;
>  
> +	if (id >= kvm->arch.max_vcpus) {
> +		err = -EINVAL;
> +		goto out;
> +	}
> +
>  	vcpu = kmem_cache_zalloc(kvm_vcpu_cache, GFP_KERNEL);
>  	if (!vcpu) {
>  		err = -ENOMEM;
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 286bb61..f9e130d 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -59,6 +59,9 @@ struct kvm_arch {
>  	/* VTTBR value associated with above pgd and vmid */
>  	u64    vttbr;
>  
> +	/* The maximum number of vCPUs depends on the used GIC model */
> +	int max_vcpus;
> +
>  	/* Interrupt controller */
>  	struct vgic_dist	vgic;
>  
> diff --git a/virt/kvm/arm/vgic-v2.c b/virt/kvm/arm/vgic-v2.c
> index 417ecaa..c92ac33 100644
> --- a/virt/kvm/arm/vgic-v2.c
> +++ b/virt/kvm/arm/vgic-v2.c
> @@ -159,11 +159,18 @@ static struct vgic_params vgic_v2_params;
>  static bool vgic_v2_init_emul(struct kvm *kvm, int type)
>  {
>  	struct vgic_vm_ops *vm_ops = &kvm->arch.vgic.vm_ops;
> +	int nr_vcpus;
>  
>  	switch (type) {
>  	case KVM_DEV_TYPE_ARM_VGIC_V2:
> +		nr_vcpus = atomic_read(&kvm->online_vcpus);
> +		if (nr_vcpus > 8) {
> +			pr_warn_ratelimited("VGICv2 only supports up to 8 vCPUs\n");
> +			return false;
> +		}
>  		vm_ops->get_lr = vgic_v2_get_lr;
>  		vm_ops->set_lr = vgic_v2_set_lr;
> +		kvm->arch.max_vcpus = 8;
>  		return true;
>  	}
>  
> diff --git a/virt/kvm/arm/vgic-v3.c b/virt/kvm/arm/vgic-v3.c
> index 6825c71..fc4d628 100644
> --- a/virt/kvm/arm/vgic-v3.c
> +++ b/virt/kvm/arm/vgic-v3.c
> @@ -171,11 +171,19 @@ static const struct vgic_ops vgic_v3_ops = {
>  static bool vgic_v3_init_emul_compat(struct kvm *kvm, int type)
>  {
>  	struct vgic_vm_ops *vm_ops = &kvm->arch.vgic.vm_ops;
> +	int nr_vcpus;
>  
>  	switch (type) {
>  	case KVM_DEV_TYPE_ARM_VGIC_V2:
> +		nr_vcpus = atomic_read(&kvm->online_vcpus);
> +		if (nr_vcpus > 8) {
> +			pr_warn_ratelimited("VGICv2 supports only up to 8 vCPUs\n");
> +			return false;
> +		}
> +
>  		vm_ops->get_lr = vgic_v3_get_lr;
>  		vm_ops->set_lr = vgic_v3_set_lr;
> +		kvm->arch.max_vcpus = 8;

This is exactly the same code as above, and it feels a bit weird to have
this code be dependent on which host gic you have, unless you plan on
supporting a frankenvgicv2 in the guest with more than 8 vcpus?

Don't we have some common place for gicv2 emulation where we can stick
this, set the max_vcpus (perhaps using a #define) and then compare the
nr_vcpus to the max_vcpus?

>  		return true;
>  	}
>  	return false;
> -- 
> 1.7.9.5
> 

Thanks,
-Christoffer
