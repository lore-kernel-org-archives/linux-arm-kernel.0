From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sun, 23 Nov 2014 14:21:55 +0100
Subject: [PATCH v4 08/19] arm/arm64: KVM: make the maximum number of
 vCPUs a per-VM value
In-Reply-To: <1415959683-26027-9-git-send-email-andre.przywara@arm.com>
References: <1415959683-26027-1-git-send-email-andre.przywara@arm.com>
 <1415959683-26027-9-git-send-email-andre.przywara@arm.com>
Message-ID: <20141123132155.GW3401@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 14, 2014 at 10:07:52AM +0000, Andre Przywara wrote:
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
> Changelog v3...v4:
> - initialize max_vcpus with limit based on host GIC
> - remove *_init_emul_* from VGIC backend
> - refine VCPU limit on VGIC creation
> - print warning when userland tries to create more VCPUs than supported
> 
>  arch/arm/include/asm/kvm_host.h   |    1 +
>  arch/arm/kvm/arm.c                |    8 ++++++++
>  arch/arm64/include/asm/kvm_host.h |    3 +++
>  include/kvm/arm_vgic.h            |    2 ++
>  virt/kvm/arm/vgic-v2.c            |    1 +
>  virt/kvm/arm/vgic-v3.c            |    1 +
>  virt/kvm/arm/vgic.c               |   22 ++++++++++++++++++++++
>  7 files changed, 38 insertions(+)
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
> index 8817fbd..c3d0fbd 100644
> --- a/arch/arm/kvm/arm.c
> +++ b/arch/arm/kvm/arm.c
> @@ -132,6 +132,9 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
>  	/* Mark the initial VMID generation invalid */
>  	kvm->arch.vmid_gen = 0;
>  
> +	/* The maximum number of VCPUs is limited by the host's GIC model */
> +	kvm->arch.max_vcpus = kvm_vgic_get_max_vcpus();

I think you forgot to declare this one in arm_vgic.h for
v7-without-vgic-but-with-kvm-configure-case
(which-we-should-have-gotten-rid-of-a-while-back-perhaps).

> +
>  	return ret;
>  out_free_stage2_pgd:
>  	kvm_free_stage2_pgd(kvm);
> @@ -213,6 +216,11 @@ struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm, unsigned int id)
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
> diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
> index bfb660a..09344ac 100644
> --- a/include/kvm/arm_vgic.h
> +++ b/include/kvm/arm_vgic.h
> @@ -132,6 +132,7 @@ struct vgic_params {
>  	unsigned int	maint_irq;
>  	/* Virtual control interface base address */
>  	void __iomem	*vctrl_base;
> +	int		max_hw_vcpus;

nit: max_vcpus or max_gic_vcpus would be more meaningful imho.

>  };
>  
>  struct vgic_vm_ops {
> @@ -287,6 +288,7 @@ struct kvm_exit_mmio;
>  #ifdef CONFIG_KVM_ARM_VGIC
>  int kvm_vgic_addr(struct kvm *kvm, unsigned long type, u64 *addr, bool write);
>  int kvm_vgic_hyp_init(void);
> +int kvm_vgic_get_max_vcpus(void);
>  int kvm_vgic_init(struct kvm *kvm);
>  int kvm_vgic_create(struct kvm *kvm, u32 type);
>  void kvm_vgic_destroy(struct kvm *kvm);
> diff --git a/virt/kvm/arm/vgic-v2.c b/virt/kvm/arm/vgic-v2.c
> index e1cd3cb..49fb288 100644
> --- a/virt/kvm/arm/vgic-v2.c
> +++ b/virt/kvm/arm/vgic-v2.c
> @@ -237,6 +237,7 @@ int vgic_v2_probe(struct device_node *vgic_node,
>  		 vctrl_res.start, vgic->maint_irq);
>  
>  	vgic->type = VGIC_V2;
> +	vgic->max_hw_vcpus = 8;

define GIC_V2_MAX_CPUS ?

>  	*ops = &vgic_v2_ops;
>  	*params = vgic;
>  	goto out;
> diff --git a/virt/kvm/arm/vgic-v3.c b/virt/kvm/arm/vgic-v3.c
> index d14c75f..acd256c7 100644
> --- a/virt/kvm/arm/vgic-v3.c
> +++ b/virt/kvm/arm/vgic-v3.c
> @@ -235,6 +235,7 @@ int vgic_v3_probe(struct device_node *vgic_node,
>  	vgic->vcpu_base = vcpu_res.start;
>  	vgic->vctrl_base = NULL;
>  	vgic->type = VGIC_V3;
> +	vgic->max_hw_vcpus = KVM_MAX_VCPUS;
>  
>  	kvm_info("%s@%llx IRQ%d\n", vgic_node->name,
>  		 vcpu_res.start, vgic->maint_irq);
> diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
> index 4aa0b2f..4c72c66 100644
> --- a/virt/kvm/arm/vgic.c
> +++ b/virt/kvm/arm/vgic.c
> @@ -1841,6 +1841,17 @@ static int vgic_vcpu_init_maps(struct kvm_vcpu *vcpu, int nr_irqs)
>  }
>  
>  /**
> + * kvm_vgic_get_max_vcpus - Get the maximum number of VCPUs allowed by HW
> + *
> + * The host's GIC naturally limits the maximum amount of VCPUs a guest
> + * can use.
> + */
> +int kvm_vgic_get_max_vcpus(void)
> +{
> +	return vgic->max_hw_vcpus;
> +}
> +
> +/**
>   * kvm_vgic_vcpu_init - Initialize per-vcpu VGIC state
>   * @vcpu: pointer to the vcpu struct
>   *
> @@ -2056,6 +2067,8 @@ static int vgic_v2_init_emulation(struct kvm *kvm)
>  	dist->vm_ops.add_sgi_source = vgic_v2_add_sgi_source;
>  	dist->vm_ops.vgic_init = vgic_v2_init;
>  
> +	kvm->arch.max_vcpus = 8;

reuse the define here

> +
>  	return 0;
>  }
>  
> @@ -2072,6 +2085,15 @@ static int init_vgic_model(struct kvm *kvm, int type)
>  		break;
>  	}
>  
> +	if (ret)
> +		return ret;
> +
> +	if (kvm->arch.max_vcpus < atomic_read(&kvm->online_vcpus)) {

I would invert this check; if (online_vcpus > max_vcpus) ...

> +		pr_warn_ratelimited("VGIC model only supports up to %d vCPUs\n",
> +			kvm->arch.max_vcpus);
> +		ret = -EINVAL;
> +	}
> +
>  	return ret;
>  }
>  
> -- 
> 1.7.9.5
> 

So let me see if I got this right:

When you create the VM you set the maximum number of vcpus to whatever
the underlying vgic hardware allows.

Then, when you start creating vcpus, you complain if the user tries to
create more than what the hardware allows (check against
kvm->arch.max_vcpus).

Then, when you create the vgic, you further limit kvm->arch.max_vcpus
and check if you already created too many vcpus for the vgic model you
are trying to create, and error out in that case, and now also check
against the new value when user space is trying to create more vcpus.

Some questions:

(1) Is there currently a way to tell user space what the maximum number
of vcpus for a given setup is?

(2) Would it be simpler to just have kvm_vgic_max_vcpus() return its
best guess and always check against that from the outside?  Hmmm, maybe
not, but thought I'd throw it out there.

Thanks,
-Christoffer
