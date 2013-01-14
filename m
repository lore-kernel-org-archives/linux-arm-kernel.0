From: will.deacon@arm.com (Will Deacon)
Date: Mon, 14 Jan 2013 15:42:31 +0000
Subject: [PATCH v5 07/12] ARM: KVM: VGIC virtual CPU interface management
In-Reply-To: <20130108184211.46558.74646.stgit@ubuntu>
References: <20130108184116.46558.3558.stgit@ubuntu>
 <20130108184211.46558.74646.stgit@ubuntu>
Message-ID: <20130114154231.GG18935@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 08, 2013 at 06:42:11PM +0000, Christoffer Dall wrote:
> From: Marc Zyngier <marc.zyngier@arm.com>
> 
> Add VGIC virtual CPU interface code, picking pending interrupts
> from the distributor and stashing them in the VGIC control interface
> list registers.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
> ---
>  arch/arm/include/asm/kvm_vgic.h |   30 ++++
>  arch/arm/kvm/vgic.c             |  327 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 356 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/include/asm/kvm_vgic.h b/arch/arm/include/asm/kvm_vgic.h
> index 9ff0d9c..b3133c4 100644
> --- a/arch/arm/include/asm/kvm_vgic.h
> +++ b/arch/arm/include/asm/kvm_vgic.h
> @@ -110,8 +110,33 @@ struct vgic_dist {
>  };
> 
>  struct vgic_cpu {
> +#ifdef CONFIG_KVM_ARM_VGIC
> +       /* per IRQ to LR mapping */
> +       u8              vgic_irq_lr_map[VGIC_NR_IRQS];
> +
> +       /* Pending interrupts on this VCPU */
> +       DECLARE_BITMAP( pending_percpu, VGIC_NR_PRIVATE_IRQS);
> +       DECLARE_BITMAP( pending_shared, VGIC_NR_SHARED_IRQS);
> +
> +       /* Bitmap of used/free list registers */
> +       DECLARE_BITMAP( lr_used, 64);
> +
> +       /* Number of list registers on this CPU */
> +       int             nr_lr;
> +
> +       /* CPU vif control registers for world switch */
> +       u32             vgic_hcr;
> +       u32             vgic_vmcr;
> +       u32             vgic_misr;      /* Saved only */
> +       u32             vgic_eisr[2];   /* Saved only */
> +       u32             vgic_elrsr[2];  /* Saved only */
> +       u32             vgic_apr;
> +       u32             vgic_lr[64];    /* A15 has only 4... */

Have a #define for the maximum number of list registers.

> +#endif
>  };
> 
> +#define LR_EMPTY       0xff
> +
>  struct kvm;
>  struct kvm_vcpu;
>  struct kvm_run;
> @@ -119,9 +144,14 @@ struct kvm_exit_mmio;
> 
>  #ifdef CONFIG_KVM_ARM_VGIC
>  int kvm_vgic_set_addr(struct kvm *kvm, unsigned long type, u64 addr);
> +void kvm_vgic_sync_to_cpu(struct kvm_vcpu *vcpu);
> +void kvm_vgic_sync_from_cpu(struct kvm_vcpu *vcpu);

Same comment as for the arch timer (flush/sync).

> +int kvm_vgic_vcpu_pending_irq(struct kvm_vcpu *vcpu);
>  bool vgic_handle_mmio(struct kvm_vcpu *vcpu, struct kvm_run *run,
>                       struct kvm_exit_mmio *mmio);
> 
> +#define irqchip_in_kernel(k)   (!!((k)->arch.vgic.vctrl_base))
> +
>  #else
>  static inline int kvm_vgic_hyp_init(void)
>  {
> diff --git a/arch/arm/kvm/vgic.c b/arch/arm/kvm/vgic.c
> index bd2bd7f..58237d5 100644
> --- a/arch/arm/kvm/vgic.c
> +++ b/arch/arm/kvm/vgic.c
> @@ -152,6 +152,34 @@ static int vgic_irq_is_enabled(struct kvm_vcpu *vcpu, int irq)
>         return vgic_bitmap_get_irq_val(&dist->irq_enabled, vcpu->vcpu_id, irq);
>  }
> 
> +static int vgic_irq_is_active(struct kvm_vcpu *vcpu, int irq)
> +{
> +       struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
> +
> +       return vgic_bitmap_get_irq_val(&dist->irq_active, vcpu->vcpu_id, irq);
> +}
> +
> +static void vgic_irq_set_active(struct kvm_vcpu *vcpu, int irq)
> +{
> +       struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
> +
> +       vgic_bitmap_set_irq_val(&dist->irq_active, vcpu->vcpu_id, irq, 1);
> +}
> +
> +static void vgic_irq_clear_active(struct kvm_vcpu *vcpu, int irq)
> +{
> +       struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
> +
> +       vgic_bitmap_set_irq_val(&dist->irq_active, vcpu->vcpu_id, irq, 0);
> +}
> +
> +static int vgic_dist_irq_is_pending(struct kvm_vcpu *vcpu, int irq)
> +{
> +       struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
> +
> +       return vgic_bitmap_get_irq_val(&dist->irq_state, vcpu->vcpu_id, irq);
> +}
> +
>  static void vgic_dist_irq_set(struct kvm_vcpu *vcpu, int irq)
>  {
>         struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
> @@ -711,7 +739,30 @@ static void vgic_dispatch_sgi(struct kvm_vcpu *vcpu, u32 reg)
> 
>  static int compute_pending_for_cpu(struct kvm_vcpu *vcpu)
>  {
> -       return 0;
> +       struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
> +       unsigned long *pending, *enabled, *pend_percpu, *pend_shared;
> +       unsigned long pending_private, pending_shared;
> +       int vcpu_id;
> +
> +       vcpu_id = vcpu->vcpu_id;
> +       pend_percpu = vcpu->arch.vgic_cpu.pending_percpu;
> +       pend_shared = vcpu->arch.vgic_cpu.pending_shared;
> +
> +       pending = vgic_bitmap_get_cpu_map(&dist->irq_state, vcpu_id);
> +       enabled = vgic_bitmap_get_cpu_map(&dist->irq_enabled, vcpu_id);
> +       bitmap_and(pend_percpu, pending, enabled, VGIC_NR_PRIVATE_IRQS);
> +
> +       pending = vgic_bitmap_get_shared_map(&dist->irq_state);
> +       enabled = vgic_bitmap_get_shared_map(&dist->irq_enabled);
> +       bitmap_and(pend_shared, pending, enabled, VGIC_NR_SHARED_IRQS);
> +       bitmap_and(pend_shared, pend_shared,
> +                  vgic_bitmap_get_shared_map(&dist->irq_spi_target[vcpu_id]),
> +                  VGIC_NR_SHARED_IRQS);
> +
> +       pending_private = find_first_bit(pend_percpu, VGIC_NR_PRIVATE_IRQS);
> +       pending_shared = find_first_bit(pend_shared, VGIC_NR_SHARED_IRQS);
> +       return (pending_private < VGIC_NR_PRIVATE_IRQS ||
> +               pending_shared < VGIC_NR_SHARED_IRQS);
>  }
> 
>  /*
> @@ -737,6 +788,280 @@ static void vgic_update_state(struct kvm *kvm)
>         }
>  }
> 
> +#define LR_CPUID(lr)   \
> +       (((lr) & GICH_LR_PHYSID_CPUID) >> GICH_LR_PHYSID_CPUID_SHIFT)
> +#define MK_LR_PEND(src, irq)   \
> +       (GICH_LR_PENDING_BIT | ((src) << GICH_LR_PHYSID_CPUID_SHIFT) | (irq))
> +/*
> + * Queue an interrupt to a CPU virtual interface. Return true on success,
> + * or false if it wasn't possible to queue it.
> + */
> +static bool vgic_queue_irq(struct kvm_vcpu *vcpu, u8 sgi_source_id, int irq)
> +{
> +       struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
> +       int lr;
> +
> +       /* Sanitize the input... */
> +       BUG_ON(sgi_source_id & ~7);
> +       BUG_ON(sgi_source_id && irq > 15);

You can use your new NR_SGIS definition here.

Will
