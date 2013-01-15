From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 15 Jan 2013 11:00:44 +0000
Subject: [PATCH v5 07/12] ARM: KVM: VGIC virtual CPU interface management
In-Reply-To: <CANM98qJ_Pb5bT0k7bAhv6i1YTj6GxvNE6vvY49OZrqsKpF3xOA@mail.gmail.com>
References: <20130108184116.46558.3558.stgit@ubuntu>
 <20130108184211.46558.74646.stgit@ubuntu>
 <20130114154231.GG18935@mudshark.cambridge.arm.com>
 <CANM98qJ_Pb5bT0k7bAhv6i1YTj6GxvNE6vvY49OZrqsKpF3xOA@mail.gmail.com>
Message-ID: <50F536DC.2060702@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/01/13 22:02, Christoffer Dall wrote:
> On Mon, Jan 14, 2013 at 10:42 AM, Will Deacon <will.deacon@arm.com> wrote:
>> On Tue, Jan 08, 2013 at 06:42:11PM +0000, Christoffer Dall wrote:
>>> From: Marc Zyngier <marc.zyngier@arm.com>
>>>
>>> Add VGIC virtual CPU interface code, picking pending interrupts
>>> from the distributor and stashing them in the VGIC control interface
>>> list registers.
>>>
>>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>>> Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
>>> ---
>>>  arch/arm/include/asm/kvm_vgic.h |   30 ++++
>>>  arch/arm/kvm/vgic.c             |  327 +++++++++++++++++++++++++++++++++++++++
>>>  2 files changed, 356 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm/include/asm/kvm_vgic.h b/arch/arm/include/asm/kvm_vgic.h
>>> index 9ff0d9c..b3133c4 100644
>>> --- a/arch/arm/include/asm/kvm_vgic.h
>>> +++ b/arch/arm/include/asm/kvm_vgic.h
>>> @@ -110,8 +110,33 @@ struct vgic_dist {
>>>  };
>>>
>>>  struct vgic_cpu {
>>> +#ifdef CONFIG_KVM_ARM_VGIC
>>> +       /* per IRQ to LR mapping */
>>> +       u8              vgic_irq_lr_map[VGIC_NR_IRQS];
>>> +
>>> +       /* Pending interrupts on this VCPU */
>>> +       DECLARE_BITMAP( pending_percpu, VGIC_NR_PRIVATE_IRQS);
>>> +       DECLARE_BITMAP( pending_shared, VGIC_NR_SHARED_IRQS);
>>> +
>>> +       /* Bitmap of used/free list registers */
>>> +       DECLARE_BITMAP( lr_used, 64);
>>> +
>>> +       /* Number of list registers on this CPU */
>>> +       int             nr_lr;
>>> +
>>> +       /* CPU vif control registers for world switch */
>>> +       u32             vgic_hcr;
>>> +       u32             vgic_vmcr;
>>> +       u32             vgic_misr;      /* Saved only */
>>> +       u32             vgic_eisr[2];   /* Saved only */
>>> +       u32             vgic_elrsr[2];  /* Saved only */
>>> +       u32             vgic_apr;
>>> +       u32             vgic_lr[64];    /* A15 has only 4... */
>>
>> Have a #define for the maximum number of list registers.
>>
>>> +#endif
>>>  };
>>>
>>> +#define LR_EMPTY       0xff
>>> +
>>>  struct kvm;
>>>  struct kvm_vcpu;
>>>  struct kvm_run;
>>> @@ -119,9 +144,14 @@ struct kvm_exit_mmio;
>>>
>>>  #ifdef CONFIG_KVM_ARM_VGIC
>>>  int kvm_vgic_set_addr(struct kvm *kvm, unsigned long type, u64 addr);
>>> +void kvm_vgic_sync_to_cpu(struct kvm_vcpu *vcpu);
>>> +void kvm_vgic_sync_from_cpu(struct kvm_vcpu *vcpu);
>>
>> Same comment as for the arch timer (flush/sync).
>>
>>> +int kvm_vgic_vcpu_pending_irq(struct kvm_vcpu *vcpu);
>>>  bool vgic_handle_mmio(struct kvm_vcpu *vcpu, struct kvm_run *run,
>>>                       struct kvm_exit_mmio *mmio);
>>>
>>> +#define irqchip_in_kernel(k)   (!!((k)->arch.vgic.vctrl_base))
>>> +
>>>  #else
>>>  static inline int kvm_vgic_hyp_init(void)
>>>  {
>>> diff --git a/arch/arm/kvm/vgic.c b/arch/arm/kvm/vgic.c
>>> index bd2bd7f..58237d5 100644
>>> --- a/arch/arm/kvm/vgic.c
>>> +++ b/arch/arm/kvm/vgic.c
>>> @@ -152,6 +152,34 @@ static int vgic_irq_is_enabled(struct kvm_vcpu *vcpu, int irq)
>>>         return vgic_bitmap_get_irq_val(&dist->irq_enabled, vcpu->vcpu_id, irq);
>>>  }
>>>
>>> +static int vgic_irq_is_active(struct kvm_vcpu *vcpu, int irq)
>>> +{
>>> +       struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
>>> +
>>> +       return vgic_bitmap_get_irq_val(&dist->irq_active, vcpu->vcpu_id, irq);
>>> +}
>>> +
>>> +static void vgic_irq_set_active(struct kvm_vcpu *vcpu, int irq)
>>> +{
>>> +       struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
>>> +
>>> +       vgic_bitmap_set_irq_val(&dist->irq_active, vcpu->vcpu_id, irq, 1);
>>> +}
>>> +
>>> +static void vgic_irq_clear_active(struct kvm_vcpu *vcpu, int irq)
>>> +{
>>> +       struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
>>> +
>>> +       vgic_bitmap_set_irq_val(&dist->irq_active, vcpu->vcpu_id, irq, 0);
>>> +}
>>> +
>>> +static int vgic_dist_irq_is_pending(struct kvm_vcpu *vcpu, int irq)
>>> +{
>>> +       struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
>>> +
>>> +       return vgic_bitmap_get_irq_val(&dist->irq_state, vcpu->vcpu_id, irq);
>>> +}
>>> +
>>>  static void vgic_dist_irq_set(struct kvm_vcpu *vcpu, int irq)
>>>  {
>>>         struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
>>> @@ -711,7 +739,30 @@ static void vgic_dispatch_sgi(struct kvm_vcpu *vcpu, u32 reg)
>>>
>>>  static int compute_pending_for_cpu(struct kvm_vcpu *vcpu)
>>>  {
>>> -       return 0;
>>> +       struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
>>> +       unsigned long *pending, *enabled, *pend_percpu, *pend_shared;
>>> +       unsigned long pending_private, pending_shared;
>>> +       int vcpu_id;
>>> +
>>> +       vcpu_id = vcpu->vcpu_id;
>>> +       pend_percpu = vcpu->arch.vgic_cpu.pending_percpu;
>>> +       pend_shared = vcpu->arch.vgic_cpu.pending_shared;
>>> +
>>> +       pending = vgic_bitmap_get_cpu_map(&dist->irq_state, vcpu_id);
>>> +       enabled = vgic_bitmap_get_cpu_map(&dist->irq_enabled, vcpu_id);
>>> +       bitmap_and(pend_percpu, pending, enabled, VGIC_NR_PRIVATE_IRQS);
>>> +
>>> +       pending = vgic_bitmap_get_shared_map(&dist->irq_state);
>>> +       enabled = vgic_bitmap_get_shared_map(&dist->irq_enabled);
>>> +       bitmap_and(pend_shared, pending, enabled, VGIC_NR_SHARED_IRQS);
>>> +       bitmap_and(pend_shared, pend_shared,
>>> +                  vgic_bitmap_get_shared_map(&dist->irq_spi_target[vcpu_id]),
>>> +                  VGIC_NR_SHARED_IRQS);
>>> +
>>> +       pending_private = find_first_bit(pend_percpu, VGIC_NR_PRIVATE_IRQS);
>>> +       pending_shared = find_first_bit(pend_shared, VGIC_NR_SHARED_IRQS);
>>> +       return (pending_private < VGIC_NR_PRIVATE_IRQS ||
>>> +               pending_shared < VGIC_NR_SHARED_IRQS);
>>>  }
>>>
>>>  /*
>>> @@ -737,6 +788,280 @@ static void vgic_update_state(struct kvm *kvm)
>>>         }
>>>  }
>>>
>>> +#define LR_CPUID(lr)   \
>>> +       (((lr) & GICH_LR_PHYSID_CPUID) >> GICH_LR_PHYSID_CPUID_SHIFT)
>>> +#define MK_LR_PEND(src, irq)   \
>>> +       (GICH_LR_PENDING_BIT | ((src) << GICH_LR_PHYSID_CPUID_SHIFT) | (irq))
>>> +/*
>>> + * Queue an interrupt to a CPU virtual interface. Return true on success,
>>> + * or false if it wasn't possible to queue it.
>>> + */
>>> +static bool vgic_queue_irq(struct kvm_vcpu *vcpu, u8 sgi_source_id, int irq)
>>> +{
>>> +       struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
>>> +       int lr;
>>> +
>>> +       /* Sanitize the input... */
>>> +       BUG_ON(sgi_source_id & ~7);
>>> +       BUG_ON(sgi_source_id && irq > 15);
>>
>> You can use your new NR_SGIS definition here.
>>
> 
> This should address the remaining comments:
> 
> commit 43957095ec5476beb198f4c4630dfc3e2f3951db
> Author: Christoffer Dall <c.dall@virtualopensystems.com>
> Date:   Mon Jan 14 16:59:38 2013 -0500
> 
>     KVM: ARM: vgic: Define VGIC_MAX_LRS
> 
>     Define maximum number of link registers we can handle instead of using
>     literals in the code.  If an architecture reports more link registers
>     than we support, only use the number we can support.
> 
>     Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
> 
> diff --git a/arch/arm/include/asm/kvm_vgic.h b/arch/arm/include/asm/kvm_vgic.h
> index 1ace491..f9d1977 100644
> --- a/arch/arm/include/asm/kvm_vgic.h
> +++ b/arch/arm/include/asm/kvm_vgic.h
> @@ -33,6 +33,7 @@
>  #define VGIC_NR_PRIVATE_IRQS	(VGIC_NR_SGIS + VGIC_NR_PPIS)
>  #define VGIC_NR_SHARED_IRQS	(VGIC_NR_IRQS - VGIC_NR_PRIVATE_IRQS)
>  #define VGIC_MAX_CPUS		KVM_MAX_VCPUS
> +#define VGIC_MAX_LRS		64

Consider this instead (for the reason below)
#define VGIC_MAX_LRS	(1 << 7)

>  /* Sanity checks... */
>  #if (VGIC_MAX_CPUS > 8)
> @@ -120,7 +121,7 @@ struct vgic_cpu {
>  	DECLARE_BITMAP(	pending_shared, VGIC_NR_SHARED_IRQS);
> 
>  	/* Bitmap of used/free list registers */
> -	DECLARE_BITMAP(	lr_used, 64);
> +	DECLARE_BITMAP(	lr_used, VGIC_MAX_LRS);
> 
>  	/* Number of list registers on this CPU */
>  	int		nr_lr;
> @@ -132,7 +133,7 @@ struct vgic_cpu {
>  	u32		vgic_eisr[2];	/* Saved only */
>  	u32		vgic_elrsr[2];	/* Saved only */
>  	u32		vgic_apr;
> -	u32		vgic_lr[64];	/* A15 has only 4... */
> +	u32		vgic_lr[VGIC_MAX_LRS];
>  #endif
>  };
> 
> diff --git a/arch/arm/kvm/vgic.c b/arch/arm/kvm/vgic.c
> index a0d283c..90a99fd 100644
> --- a/arch/arm/kvm/vgic.c
> +++ b/arch/arm/kvm/vgic.c
> @@ -1345,6 +1345,8 @@ int kvm_vgic_hyp_init(void)
> 
>  	vgic_nr_lr = readl_relaxed(vgic_vctrl_base + GICH_VTR);
>  	vgic_nr_lr = (vgic_nr_lr & 0x1f) + 1;

There is a bug here. It should be:
        vgic_nr_lr = (vgic_nr_lr & 0x2f) + 1;

> +	if (vgic_nr_lr > VGIC_MAX_LRS)
> +		vgic_nr_lr = VGIC_MAX_LRS; /* TODO: Clear remaining LRs */

Why? VGIC_MAX_LRS isn't a configurable value, but a maximum value
defined by the specification. This is the maximum you can fit in a 6 bit
field, plus one (1 << 7, exactly).

>  	ret = create_hyp_io_mappings(vgic_vctrl_base,
>  				     vgic_vctrl_base + resource_size(&vctrl_res),
> --
> 
> Thanks,
> -Christoffer
> 


-- 
Jazz is not dead. It just smells funny...
