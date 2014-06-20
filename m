From: andre.przywara@arm.com (Andre Przywara)
Date: Fri, 20 Jun 2014 09:46:12 +0100
Subject: [PATCH 13/14] arm/arm64: KVM: enable kernel side of GICv3
 emulation
In-Reply-To: <7783833e172b468a89c53fa18c3f3bc5@BY2PR07MB203.namprd07.prod.outlook.com>
References: <1403171152-24067-1-git-send-email-andre.przywara@arm.com>
 <1403171152-24067-14-git-send-email-andre.przywara@arm.com>
 <7783833e172b468a89c53fa18c3f3bc5@BY2PR07MB203.namprd07.prod.outlook.com>
Message-ID: <53A3F4D4.5080202@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 19/06/14 22:43, Chalamarla, Tirumalesh wrote:
>
>
> -----Original Message-----
> From: kvmarm-bounces at lists.cs.columbia.edu [mailto:kvmarm-bounces at lists.cs.columbia.edu] On Behalf Of Andre Przywara
> Sent: Thursday, June 19, 2014 2:46 AM
> To: linux-arm-kernel at lists.infradead.org; kvmarm at lists.cs.columbia.edu; kvm at vger.kernel.org
> Cc: christoffer.dall at linaro.org
> Subject: [PATCH 13/14] arm/arm64: KVM: enable kernel side of GICv3 emulation
>
> With all the necessary GICv3 emulation code in place, we can now connect the code to the GICv3 backend in the kernel.
> The LR register handling is different depending on the emulated GIC model, so provide different implementations for each.
> Also allow non-v2-compatible GICv3 implementations (which don't provide MMIO regions for the virtual CPU interface in the DT), but restrict those hosts to use GICv3 guests only.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  virt/kvm/arm/vgic-v3.c |  138 ++++++++++++++++++++++++++++++++++++++----------
>  virt/kvm/arm/vgic.c    |    2 +
>  2 files changed, 112 insertions(+), 28 deletions(-)
>
> diff --git a/virt/kvm/arm/vgic-v3.c b/virt/kvm/arm/vgic-v3.c index 7d9c85e..d26d12f 100644
> --- a/virt/kvm/arm/vgic-v3.c
> +++ b/virt/kvm/arm/vgic-v3.c
> @@ -34,6 +34,7 @@
>  #define GICH_LR_VIRTUALID            (0x3ffUL << 0)
>  #define GICH_LR_PHYSID_CPUID_SHIFT   (10)
>  #define GICH_LR_PHYSID_CPUID         (7UL << GICH_LR_PHYSID_CPUID_SHIFT)
> +#define ICH_LR_VIRTUALID_MASK                (BIT_ULL(32) - 1)
>
>  /*
>   * LRs are stored in reverse order in memory. make sure we index them @@ -43,7 +44,35 @@
>
>  static u32 ich_vtr_el2;
>
> -static struct vgic_lr vgic_v3_get_lr(const struct kvm_vcpu *vcpu, int lr)
> +static u64 sync_lr_val(u8 state)
> +{
> +     u64 lr_val = 0;
> +
> +     if (state & LR_STATE_PENDING)
> +             lr_val |= ICH_LR_PENDING_BIT;
> +     if (state & LR_STATE_ACTIVE)
> +             lr_val |= ICH_LR_ACTIVE_BIT;
> +     if (state & LR_EOI_INT)
> +             lr_val |= ICH_LR_EOI;
> +
> +     return lr_val;
> +}
> +
> +static u8 sync_lr_state(u64 lr_val)
> +{
> +     u8 state = 0;
> +
> +     if (lr_val & ICH_LR_PENDING_BIT)
> +             state |= LR_STATE_PENDING;
> +     if (lr_val & ICH_LR_ACTIVE_BIT)
> +             state |= LR_STATE_ACTIVE;
> +     if (lr_val & ICH_LR_EOI)
> +             state |= LR_EOI_INT;
> +
> +     return state;
> +}
> +
> +static struct vgic_lr vgic_v2_on_v3_get_lr(const struct kvm_vcpu *vcpu,
> +int lr)
>  {
>       struct vgic_lr lr_desc;
>       u64 val = vcpu->arch.vgic_cpu.vgic_v3.vgic_lr[LR_INDEX(lr)];
> @@ -53,30 +82,53 @@ static struct vgic_lr vgic_v3_get_lr(const struct kvm_vcpu *vcpu, int lr)
>               lr_desc.source  = (val >> GICH_LR_PHYSID_CPUID_SHIFT) & 0x7;
>       else
>               lr_desc.source = 0;
> -     lr_desc.state   = 0;
> +     lr_desc.state   = sync_lr_state(val);
>
> -     if (val & ICH_LR_PENDING_BIT)
> -             lr_desc.state |= LR_STATE_PENDING;
> -     if (val & ICH_LR_ACTIVE_BIT)
> -             lr_desc.state |= LR_STATE_ACTIVE;
> -     if (val & ICH_LR_EOI)
> -             lr_desc.state |= LR_EOI_INT;
> +     return lr_desc;
> +}
> +
> +static struct vgic_lr vgic_v3_on_v3_get_lr(const struct kvm_vcpu *vcpu,
> +int lr) {
> +     struct vgic_lr lr_desc;
> +     u64 val = vcpu->arch.vgic_cpu.vgic_v3.vgic_lr[LR_INDEX(lr)];
> +
> +     lr_desc.irq     = val & ICH_LR_VIRTUALID_MASK;
> +     lr_desc.source  = 0;
> +     lr_desc.state   = sync_lr_state(val);
>
>       return lr_desc;
>  }
>
> -static void vgic_v3_set_lr(struct kvm_vcpu *vcpu, int lr,
> -                        struct vgic_lr lr_desc)
> +static void vgic_v3_on_v3_set_lr(struct kvm_vcpu *vcpu, int lr,
> +                              struct vgic_lr lr_desc)
>  {
> -     u64 lr_val = (((u32)lr_desc.source << GICH_LR_PHYSID_CPUID_SHIFT) |
> -                   lr_desc.irq);
> +     u64 lr_val;
>
> -     if (lr_desc.state & LR_STATE_PENDING)
> -             lr_val |= ICH_LR_PENDING_BIT;
> -     if (lr_desc.state & LR_STATE_ACTIVE)
> -             lr_val |= ICH_LR_ACTIVE_BIT;
> -     if (lr_desc.state & LR_EOI_INT)
> -             lr_val |= ICH_LR_EOI;
> +     lr_val = lr_desc.irq;
> +
> +     /*
> +      * currently all guest IRQs are Group1, as Group0 would result
> +      * in a FIQ in the guest, which it wouldn't expect.
> +      * Eventually we want to make this configurable, so we may revisit
> +      * this in the future.
> +      */
> +     lr_val |= ICH_LR_GROUP;
> +
> +     lr_val |= sync_lr_val(lr_desc.state);
> +
> +     vcpu->arch.vgic_cpu.vgic_v3.vgic_lr[LR_INDEX(lr)] = lr_val; }
> +
> +static void vgic_v2_on_v3_set_lr(struct kvm_vcpu *vcpu, int lr,
> +                              struct vgic_lr lr_desc)
> +{
> +     u64 lr_val;
> +
> +     lr_val = lr_desc.irq;
> +
> +     lr_val |= (u32)lr_desc.source << GICH_LR_PHYSID_CPUID_SHIFT;
> +
> +     lr_val |= sync_lr_val(lr_desc.state);
>
>       vcpu->arch.vgic_cpu.vgic_v3.vgic_lr[LR_INDEX(lr)] = lr_val;  } @@ -145,9 +197,8 @@ static void vgic_v3_set_vmcr(struct kvm_vcpu *vcpu, struct vgic_vmcr *vmcrp)
>
>  static void vgic_v3_enable(struct kvm_vcpu *vcpu)  {
> -     struct vgic_v3_cpu_if *vgic_v3;
> +     struct vgic_v3_cpu_if *vgic_v3 = &vcpu->arch.vgic_cpu.vgic_v3;
>
> -     vgic_v3 = &vcpu->arch.vgic_cpu.vgic_v3;
>       /*
>        * By forcing VMCR to zero, the GIC will restore the binary
>        * points to their reset values. Anything else resets to zero @@ -155,7 +206,14 @@ static void vgic_v3_enable(struct kvm_vcpu *vcpu)
>        */
>       vgic_v3->vgic_vmcr = 0;
>
> -     vgic_v3->vgic_sre       = 0;
> +     /*
> +      * Set the SRE_EL1 value depending on the configured
> +      * emulated vGIC model.
> +      */
> +     if (vcpu->kvm->arch.vgic.vgic_model == KVM_DEV_TYPE_ARM_VGIC_V3)
> +             vgic_v3->vgic_sre       = ICC_SRE_EL1_SRE;
> +     else
> +             vgic_v3->vgic_sre       = 0;
>
>       /* Get the show on the road... */
>       vgic_v3->vgic_hcr = ICH_HCR_EN;
> @@ -173,6 +231,15 @@ static const struct vgic_ops vgic_v3_ops = {
>       .enable                 = vgic_v3_enable,
>  };
>
> +static void init_vgic_v3_emul(struct kvm *kvm) {
> +     struct vgic_vm_ops *vm_ops = &kvm->arch.vgic.vm_ops;
> +
> +     vm_ops->get_lr = vgic_v3_on_v3_get_lr;
> +     vm_ops->set_lr = vgic_v3_on_v3_set_lr;
> +     kvm->arch.max_vcpus = KVM_MAX_VCPUS;
> +}
> +
>  static bool vgic_v3_init_emul_compat(struct kvm *kvm, int type)  {
>       struct vgic_vm_ops *vm_ops = &kvm->arch.vgic.vm_ops; @@ -184,14 +251,28 @@ static bool vgic_v3_init_emul_compat(struct kvm *kvm, int type)
>               if (nr_vcpus > 8)
>                       return false;
>
> -             vm_ops->get_lr = vgic_v3_get_lr;
> -             vm_ops->set_lr = vgic_v3_set_lr;
> +             vm_ops->get_lr = vgic_v2_on_v3_get_lr;
> +             vm_ops->set_lr = vgic_v2_on_v3_set_lr;
>               kvm->arch.max_vcpus = 8;
>               return true;
> +     case KVM_DEV_TYPE_ARM_VGIC_V3:
> +             init_vgic_v3_emul(kvm);
> +             return true;
>       }
>       return false;
>  }
>
> +static bool vgic_v3_init_emul(struct kvm *kvm, int type) {
> +     switch (type) {
> +     case KVM_DEV_TYPE_ARM_VGIC_V3:
> +             init_vgic_v3_emul(kvm);
> +             return true;
> +     }
> +
> +     return false;
> +}
> +
>  static struct vgic_params vgic_v3_params;
>
>  /**
> @@ -233,12 +314,13 @@ int vgic_v3_probe(struct device_node *vgic_node,
>
>       gicv_idx += 3; /* Also skip GICD, GICC, GICH */
>       if (of_address_to_resource(vgic_node, gicv_idx, &vcpu_res)) {
> -             kvm_err("Cannot obtain GICV region\n");
> -             ret = -ENXIO;
> -             goto out;
> +             kvm_info("GICv3: GICv2 emulation not available\n");
> +             vgic->vcpu_base = 0;
> +             vgic->init_emul = vgic_v3_init_emul;
> +     } else {
> +             vgic->vcpu_base = vcpu_res.start;
> +             vgic->init_emul = vgic_v3_init_emul_compat;
>       }
>
> Are we returning error while GICv2 emulation is request from user when it is not supported, I might have missed the code.

Yes, we do. Actually it is right here, with the different init_emul()
functions. Check their implementations above, we only allow
KVM_DEV_TYPE_ARM_VGIC_V3 for the fist case here.

Cheers,
Andre.

>
>
> -     vgic->init_emul = vgic_v3_init_emul_compat;
> -     vgic->vcpu_base = vcpu_res.start;
>       vgic->vctrl_base = NULL;
>       vgic->type = VGIC_V3;
>
> diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c index fa150c7..8a584e0 100644
> --- a/virt/kvm/arm/vgic.c
> +++ b/virt/kvm/arm/vgic.c
> @@ -1424,6 +1424,8 @@ static bool init_emulation_ops(struct kvm *kvm, int type)
>       switch (type) {
>       case KVM_DEV_TYPE_ARM_VGIC_V2:
>               return vgic_v2_init_emulation_ops(kvm, type);
> +     case KVM_DEV_TYPE_ARM_VGIC_V3:
> +             return vgic_v3_init_emulation_ops(kvm, type);
>       }
>       return false;
>  }
> --
> 1.7.9.5
>
> _______________________________________________
> kvmarm mailing list
> kvmarm at lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
>

-- IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium.  Thank you.

ARM Limited, Registered office 110 Fulbourn Road, Cambridge CB1 9NJ, Registered in England & Wales, Company No:  2557590
ARM Holdings plc, Registered office 110 Fulbourn Road, Cambridge CB1 9NJ, Registered in England & Wales, Company No:  2548782
