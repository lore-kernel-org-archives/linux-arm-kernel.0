From: will.deacon@arm.com (Will Deacon)
Date: Wed, 28 Nov 2012 13:21:04 +0000
Subject: [PATCH v4 06/13] ARM: KVM: VGIC distributor handling
In-Reply-To: <20121110154458.3061.28629.stgit@chazy-air>
References: <20121110154358.3061.16338.stgit@chazy-air>
 <20121110154458.3061.28629.stgit@chazy-air>
Message-ID: <20121128132104.GH21671@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 10, 2012 at 03:44:58PM +0000, Christoffer Dall wrote:
> From: Marc Zyngier <marc.zyngier@arm.com>
> 
> Add the GIC distributor emulation code. A number of the GIC features
> are simply ignored as they are not required to boot a Linux guest.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
> ---
>  arch/arm/include/asm/kvm_vgic.h |  167 ++++++++++++++
>  arch/arm/kvm/vgic.c             |  471 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 637 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/include/asm/kvm_vgic.h b/arch/arm/include/asm/kvm_vgic.h
> index 9ca8d21..9e60b1d 100644
> --- a/arch/arm/include/asm/kvm_vgic.h
> +++ b/arch/arm/include/asm/kvm_vgic.h
> @@ -19,10 +19,177 @@
>  #ifndef __ASM_ARM_KVM_VGIC_H
>  #define __ASM_ARM_KVM_VGIC_H
> 
> +#include <linux/kernel.h>
> +#include <linux/kvm.h>
> +#include <linux/kvm_host.h>
> +#include <linux/irqreturn.h>
> +#include <linux/spinlock.h>
> +#include <linux/types.h>
> +
> +#define VGIC_NR_IRQS           128

#define VGIC_NR_PRIVATE_IRQS	32?

> +#define VGIC_NR_SHARED_IRQS    (VGIC_NR_IRQS - 32)

then subtract it here

> +#define VGIC_MAX_CPUS          NR_CPUS

We already have KVM_MAX_VCPUS, why do we need another?

> +
> +/* Sanity checks... */
> +#if (VGIC_MAX_CPUS > 8)
> +#error Invalid number of CPU interfaces
> +#endif
> +
> +#if (VGIC_NR_IRQS & 31)
> +#error "VGIC_NR_IRQS must be a multiple of 32"
> +#endif
> +
> +#if (VGIC_NR_IRQS > 1024)
> +#error "VGIC_NR_IRQS must be <= 1024"
> +#endif

Maybe put each check directly below the #define being tested, to make it
super-obvious to people thinking of changing the constants?

> +/*
> + * The GIC distributor registers describing interrupts have two parts:
> + * - 32 per-CPU interrupts (SGI + PPI)
> + * - a bunch of shared interrups (SPI)

interrupts

> + */
> +struct vgic_bitmap {
> +       union {
> +               u32 reg[1];
> +               unsigned long reg_ul[0];
> +       } percpu[VGIC_MAX_CPUS];
> +       union {
> +               u32 reg[VGIC_NR_SHARED_IRQS / 32];
> +               unsigned long reg_ul[0];
> +       } shared;
> +};

Whoa, this is nasty!

Firstly, let's replace the `32' with sizeof(u32) for fun. Secondly, can
we make the reg_ul arrays sized using the BITS_TO_LONGS macro?

> +
> +static inline u32 *vgic_bitmap_get_reg(struct vgic_bitmap *x,
> +                                      int cpuid, u32 offset)
> +{
> +       offset >>= 2;
> +       BUG_ON(offset > (VGIC_NR_IRQS / 32));

Hmm, where is offset sanity-checked before here? Do you just rely on all
trapped accesses being valid?

> +       if (!offset)
> +               return x->percpu[cpuid].reg;
> +       else
> +               return x->shared.reg + offset - 1;

An alternative to this would be to have a single array, with the per-cpu
interrupts all laid out at the start and a macro to convert an offset to
an index. Might make the code more readable and the struct definition more
concise.

> +}
> +
> +static inline int vgic_bitmap_get_irq_val(struct vgic_bitmap *x,
> +                                        int cpuid, int irq)
> +{
> +       if (irq < 32)

VGIC_NR_PRIVATE_IRQS (inless you go with the suggestion above)

> +               return test_bit(irq, x->percpu[cpuid].reg_ul);
> +
> +       return test_bit(irq - 32, x->shared.reg_ul);
> +}
> +
> +static inline void vgic_bitmap_set_irq_val(struct vgic_bitmap *x,
> +                                          int cpuid, int irq, int val)
> +{
> +       unsigned long *reg;
> +
> +       if (irq < 32)
> +               reg = x->percpu[cpuid].reg_ul;
> +       else {
> +               reg =  x->shared.reg_ul;
> +               irq -= 32;
> +       }

Likewise.

> +
> +       if (val)
> +               set_bit(irq, reg);
> +       else
> +               clear_bit(irq, reg);
> +}
> +
> +static inline unsigned long *vgic_bitmap_get_cpu_map(struct vgic_bitmap *x,
> +                                                    int cpuid)
> +{
> +       if (unlikely(cpuid >= VGIC_MAX_CPUS))
> +               return NULL;
> +       return x->percpu[cpuid].reg_ul;
> +}
> +
> +static inline unsigned long *vgic_bitmap_get_shared_map(struct vgic_bitmap *x)
> +{
> +       return x->shared.reg_ul;
> +}
> +
> +struct vgic_bytemap {
> +       union {
> +               u32 reg[8];
> +               unsigned long reg_ul[0];
> +       } percpu[VGIC_MAX_CPUS];
> +       union {
> +               u32 reg[VGIC_NR_SHARED_IRQS  / 4];
> +               unsigned long reg_ul[0];
> +       } shared;
> +};

Argh, it's another one! :)

> +
> +static inline u32 *vgic_bytemap_get_reg(struct vgic_bytemap *x,
> +                                       int cpuid, u32 offset)
> +{
> +       offset >>= 2;
> +       BUG_ON(offset > (VGIC_NR_IRQS / 4));
> +       if (offset < 4)
> +               return x->percpu[cpuid].reg + offset;
> +       else
> +               return x->shared.reg + offset - 8;
> +}
> +
> +static inline int vgic_bytemap_get_irq_val(struct vgic_bytemap *x,
> +                                          int cpuid, int irq)
> +{
> +       u32 *reg, shift;
> +       shift = (irq & 3) * 8;
> +       reg = vgic_bytemap_get_reg(x, cpuid, irq);
> +       return (*reg >> shift) & 0xff;
> +}
> +
> +static inline void vgic_bytemap_set_irq_val(struct vgic_bytemap *x,
> +                                           int cpuid, int irq, int val)
> +{
> +       u32 *reg, shift;
> +       shift = (irq & 3) * 8;
> +       reg = vgic_bytemap_get_reg(x, cpuid, irq);
> +       *reg &= ~(0xff << shift);
> +       *reg |= (val & 0xff) << shift;
> +}
> +
>  struct vgic_dist {
> +#ifdef CONFIG_KVM_ARM_VGIC
> +       spinlock_t              lock;
> +
> +       /* Virtual control interface mapping */
> +       void __iomem            *vctrl_base;
> +
>         /* Distributor and vcpu interface mapping in the guest */
>         phys_addr_t             vgic_dist_base;
>         phys_addr_t             vgic_cpu_base;
> +
> +       /* Distributor enabled */
> +       u32                     enabled;
> +
> +       /* Interrupt enabled (one bit per IRQ) */
> +       struct vgic_bitmap      irq_enabled;
> +
> +       /* Interrupt 'pin' level */
> +       struct vgic_bitmap      irq_state;
> +
> +       /* Level-triggered interrupt in progress */
> +       struct vgic_bitmap      irq_active;
> +
> +       /* Interrupt priority. Not used yet. */
> +       struct vgic_bytemap     irq_priority;

What would the bitmap component of the bytemap represent for priorities?

> +
> +       /* Level/edge triggered */
> +       struct vgic_bitmap      irq_cfg;
> +
> +       /* Source CPU per SGI and target CPU */
> +       u8                      irq_sgi_sources[VGIC_MAX_CPUS][16];

Ah, I guess my VGIC_NR_PRIVATE_IRQS interrupt should be further divided...

> +       /* Target CPU for each IRQ */
> +       u8                      irq_spi_cpu[VGIC_NR_SHARED_IRQS];
> +       struct vgic_bitmap      irq_spi_target[VGIC_MAX_CPUS];
> +
> +       /* Bitmap indicating which CPU has something pending */
> +       unsigned long           irq_pending_on_cpu;
> +#endif
>  };
> 
>  struct vgic_cpu {
> diff --git a/arch/arm/kvm/vgic.c b/arch/arm/kvm/vgic.c
> index f85b275..82feee8 100644
> --- a/arch/arm/kvm/vgic.c
> +++ b/arch/arm/kvm/vgic.c
> @@ -22,6 +22,42 @@
>  #include <linux/io.h>
>  #include <asm/kvm_emulate.h>
> 
> +/*
> + * How the whole thing works (courtesy of Christoffer Dall):
> + *
> + * - At any time, the dist->irq_pending_on_cpu is the oracle that knows if
> + *   something is pending
> + * - VGIC pending interrupts are stored on the vgic.irq_state vgic
> + *   bitmap (this bitmap is updated by both user land ioctls and guest
> + *   mmio ops) and indicate the 'wire' state.
> + * - Every time the bitmap changes, the irq_pending_on_cpu oracle is
> + *   recalculated
> + * - To calculate the oracle, we need info for each cpu from
> + *   compute_pending_for_cpu, which considers:
> + *   - PPI: dist->irq_state & dist->irq_enable
> + *   - SPI: dist->irq_state & dist->irq_enable & dist->irq_spi_target
> + *   - irq_spi_target is a 'formatted' version of the GICD_ICFGR
> + *     registers, stored on each vcpu. We only keep one bit of
> + *     information per interrupt, making sure that only one vcpu can
> + *     accept the interrupt.
> + * - The same is true when injecting an interrupt, except that we only
> + *   consider a single interrupt at a time. The irq_spi_cpu array
> + *   contains the target CPU for each SPI.
> + *
> + * The handling of level interrupts adds some extra complexity. We
> + * need to track when the interrupt has been EOIed, so we can sample
> + * the 'line' again. This is achieved as such:
> + *
> + * - When a level interrupt is moved onto a vcpu, the corresponding
> + *   bit in irq_active is set. As long as this bit is set, the line
> + *   will be ignored for further interrupts. The interrupt is injected
> + *   into the vcpu with the VGIC_LR_EOI bit set (generate a
> + *   maintenance interrupt on EOI).
> + * - When the interrupt is EOIed, the maintenance interrupt fires,
> + *   and clears the corresponding bit in irq_active. This allow the
> + *   interrupt line to be sampled again.
> + */
> +
>  #define VGIC_ADDR_UNDEF                (-1)
>  #define IS_VGIC_ADDR_UNDEF(_x)  ((_x) == (typeof(_x))VGIC_ADDR_UNDEF)
> 
> @@ -38,6 +74,14 @@
>  #define ACCESS_WRITE_VALUE     (3 << 1)
>  #define ACCESS_WRITE_MASK(x)   ((x) & (3 << 1))
> 
> +static void vgic_update_state(struct kvm *kvm);
> +static void vgic_dispatch_sgi(struct kvm_vcpu *vcpu, u32 reg);
> +
> +static inline int vgic_irq_is_edge(struct vgic_dist *dist, int irq)
> +{
> +       return vgic_bitmap_get_irq_val(&dist->irq_cfg, 0, irq);
> +}

so vgic_bitmap_get_irq_val returns 0 for level and anything else for edge?
Maybe an enum or something could make this clearer? Also, why not take a vcpu
or cpuid parameter to pass through, rather than assuming 0?

> +
>  /**
>   * vgic_reg_access - access vgic register
>   * @mmio:   pointer to the data describing the mmio access
> @@ -101,6 +145,280 @@ static void vgic_reg_access(struct kvm_exit_mmio *mmio, u32 *reg,
>         }
>  }
> 
> +static bool handle_mmio_misc(struct kvm_vcpu *vcpu,
> +                            struct kvm_exit_mmio *mmio, u32 offset)
> +{
> +       u32 reg;
> +       u32 u32off = offset & 3;

u32off? Bitten by a regex perhaps?

> +
> +       switch (offset & ~3) {
> +       case 0:                 /* CTLR */
> +               reg = vcpu->kvm->arch.vgic.enabled;
> +               vgic_reg_access(mmio, &reg, u32off,
> +                               ACCESS_READ_VALUE | ACCESS_WRITE_VALUE);
> +               if (mmio->is_write) {
> +                       vcpu->kvm->arch.vgic.enabled = reg & 1;
> +                       vgic_update_state(vcpu->kvm);
> +                       return true;
> +               }
> +               break;
> +
> +       case 4:                 /* TYPER */
> +               reg  = (atomic_read(&vcpu->kvm->online_vcpus) - 1) << 5;
> +               reg |= (VGIC_NR_IRQS >> 5) - 1;
> +               vgic_reg_access(mmio, &reg, u32off,
> +                               ACCESS_READ_VALUE | ACCESS_WRITE_IGNORED);
> +               break;
> +
> +       case 8:                 /* IIDR */
> +               reg = 0x4B00043B;
> +               vgic_reg_access(mmio, &reg, u32off,
> +                               ACCESS_READ_VALUE | ACCESS_WRITE_IGNORED);
> +               break;
> +       }
> +
> +       return false;
> +}
> +
> +static bool handle_mmio_raz_wi(struct kvm_vcpu *vcpu,
> +                              struct kvm_exit_mmio *mmio, u32 offset)
> +{
> +       vgic_reg_access(mmio, NULL, offset,
> +                       ACCESS_READ_RAZ | ACCESS_WRITE_IGNORED);
> +       return false;
> +}
> +
> +static bool handle_mmio_set_enable_reg(struct kvm_vcpu *vcpu,
> +                                      struct kvm_exit_mmio *mmio, u32 offset)
> +{
> +       u32 *reg = vgic_bitmap_get_reg(&vcpu->kvm->arch.vgic.irq_enabled,
> +                                      vcpu->vcpu_id, offset);
> +       vgic_reg_access(mmio, reg, offset,
> +                       ACCESS_READ_VALUE | ACCESS_WRITE_SETBIT);
> +       if (mmio->is_write) {
> +               vgic_update_state(vcpu->kvm);
> +               return true;
> +       }
> +
> +       return false;
> +}
> +
> +static bool handle_mmio_clear_enable_reg(struct kvm_vcpu *vcpu,
> +                                        struct kvm_exit_mmio *mmio, u32 offset)
> +{
> +       u32 *reg = vgic_bitmap_get_reg(&vcpu->kvm->arch.vgic.irq_enabled,
> +                                      vcpu->vcpu_id, offset);
> +       vgic_reg_access(mmio, reg, offset,
> +                       ACCESS_READ_VALUE | ACCESS_WRITE_CLEARBIT);
> +       if (mmio->is_write) {
> +               if (offset < 4) /* Force SGI enabled */
> +                       *reg |= 0xffff;
> +               vgic_update_state(vcpu->kvm);
> +               return true;
> +       }
> +
> +       return false;
> +}
> +
> +static bool handle_mmio_set_pending_reg(struct kvm_vcpu *vcpu,
> +                                       struct kvm_exit_mmio *mmio, u32 offset)
> +{
> +       u32 *reg = vgic_bitmap_get_reg(&vcpu->kvm->arch.vgic.irq_state,
> +                                      vcpu->vcpu_id, offset);
> +       vgic_reg_access(mmio, reg, offset,
> +                       ACCESS_READ_VALUE | ACCESS_WRITE_SETBIT);
> +       if (mmio->is_write) {
> +               vgic_update_state(vcpu->kvm);
> +               return true;
> +       }
> +
> +       return false;
> +}
> +
> +static bool handle_mmio_clear_pending_reg(struct kvm_vcpu *vcpu,
> +                                         struct kvm_exit_mmio *mmio, u32 offset)
> +{
> +       u32 *reg = vgic_bitmap_get_reg(&vcpu->kvm->arch.vgic.irq_state,
> +                                      vcpu->vcpu_id, offset);
> +       vgic_reg_access(mmio, reg, offset,
> +                       ACCESS_READ_VALUE | ACCESS_WRITE_CLEARBIT);
> +       if (mmio->is_write) {
> +               vgic_update_state(vcpu->kvm);
> +               return true;
> +       }
> +
> +       return false;
> +}
> +
> +static bool handle_mmio_priority_reg(struct kvm_vcpu *vcpu,
> +                                    struct kvm_exit_mmio *mmio, u32 offset)
> +{
> +       u32 *reg = vgic_bytemap_get_reg(&vcpu->kvm->arch.vgic.irq_priority,
> +                                       vcpu->vcpu_id, offset);
> +       vgic_reg_access(mmio, reg, offset,
> +                       ACCESS_READ_VALUE | ACCESS_WRITE_VALUE);
> +       return false;
> +}

What do you gain from returning a bool from the MMIO handlers? Why not assume
that state has always been updated and kick the vcpus if something is pending?

> +
> +static u32 vgic_get_target_reg(struct kvm *kvm, int irq)
> +{
> +       struct vgic_dist *dist = &kvm->arch.vgic;
> +       struct kvm_vcpu *vcpu;
> +       int i, c;
> +       unsigned long *bmap;
> +       u32 val = 0;
> +
> +       BUG_ON(irq & 3);
> +       BUG_ON(irq < 32);

Again, these look scary because I can't see the offset sanity checking for
the MMIO traps...

> +
> +       irq -= 32;
> +
> +       kvm_for_each_vcpu(c, vcpu, kvm) {
> +               bmap = vgic_bitmap_get_shared_map(&dist->irq_spi_target[c]);
> +               for (i = 0; i < 4; i++)

Is that 4 from sizeof(unsigned long)?

> +                       if (test_bit(irq + i, bmap))
> +                               val |= 1 << (c + i * 8);
> +       }
> +
> +       return val;
> +}
> +
> +static void vgic_set_target_reg(struct kvm *kvm, u32 val, int irq)
> +{
> +       struct vgic_dist *dist = &kvm->arch.vgic;
> +       struct kvm_vcpu *vcpu;
> +       int i, c;
> +       unsigned long *bmap;
> +       u32 target;
> +
> +       BUG_ON(irq & 3);
> +       BUG_ON(irq < 32);
> +
> +       irq -= 32;
> +
> +       /*
> +        * Pick the LSB in each byte. This ensures we target exactly
> +        * one vcpu per IRQ. If the byte is null, assume we target
> +        * CPU0.
> +        */
> +       for (i = 0; i < 4; i++) {
> +               int shift = i * 8;

Is this from BITS_PER_BYTE?

> +               target = ffs((val >> shift) & 0xffU);
> +               target = target ? (target - 1) : 0;

__ffs?

> +               dist->irq_spi_cpu[irq + i] = target;
> +               kvm_for_each_vcpu(c, vcpu, kvm) {
> +                       bmap = vgic_bitmap_get_shared_map(&dist->irq_spi_target[c]);
> +                       if (c == target)
> +                               set_bit(irq + i, bmap);
> +                       else
> +                               clear_bit(irq + i, bmap);
> +               }
> +       }
> +}
> +
> +static bool handle_mmio_target_reg(struct kvm_vcpu *vcpu,
> +                                  struct kvm_exit_mmio *mmio, u32 offset)
> +{
> +       u32 reg;
> +
> +       /* We treat the banked interrupts targets as read-only */
> +       if (offset < 32) {
> +               u32 roreg = 1 << vcpu->vcpu_id;
> +               roreg |= roreg << 8;
> +               roreg |= roreg << 16;
> +
> +               vgic_reg_access(mmio, &roreg, offset,
> +                               ACCESS_READ_VALUE | ACCESS_WRITE_IGNORED);
> +               return false;
> +       }
> +
> +       reg = vgic_get_target_reg(vcpu->kvm, offset & ~3U);
> +       vgic_reg_access(mmio, &reg, offset,
> +                       ACCESS_READ_VALUE | ACCESS_WRITE_VALUE);
> +       if (mmio->is_write) {
> +               vgic_set_target_reg(vcpu->kvm, reg, offset & ~3U);
> +               vgic_update_state(vcpu->kvm);
> +               return true;
> +       }
> +
> +       return false;
> +}
> +
> +static u32 vgic_cfg_expand(u16 val)
> +{
> +       u32 res = 0;
> +       int i;
> +
> +       for (i = 0; i < 16; i++)
> +               res |= (val >> i) << (2 * i + 1);

Ok, you've lost me on this one but replacing some of the magic numbers with
the constants they represent would be much appreciated, please!

> +
> +       return res;
> +}
> +
> +static u16 vgic_cfg_compress(u32 val)
> +{
> +       u16 res = 0;
> +       int i;
> +
> +       for (i = 0; i < 16; i++)
> +               res |= (val >> (i * 2 + 1)) << i;
> +
> +       return res;
> +}
> +
> +/*
> + * The distributor uses 2 bits per IRQ for the CFG register, but the
> + * LSB is always 0. As such, we only keep the upper bit, and use the
> + * two above functions to compress/expand the bits
> + */
> +static bool handle_mmio_cfg_reg(struct kvm_vcpu *vcpu,
> +                               struct kvm_exit_mmio *mmio, u32 offset)
> +{
> +       u32 val;
> +       u32 *reg = vgic_bitmap_get_reg(&vcpu->kvm->arch.vgic.irq_cfg,
> +                                      vcpu->vcpu_id, offset >> 1);
> +       if (offset & 2)
> +               val = *reg >> 16;
> +       else
> +               val = *reg & 0xffff;
> +
> +       val = vgic_cfg_expand(val);
> +       vgic_reg_access(mmio, &val, offset,
> +                       ACCESS_READ_VALUE | ACCESS_WRITE_VALUE);
> +       if (mmio->is_write) {
> +               if (offset < 4) {
> +                       *reg = ~0U; /* Force PPIs/SGIs to 1 */
> +                       return false;
> +               }
> +
> +               val = vgic_cfg_compress(val);
> +               if (offset & 2) {
> +                       *reg &= 0xffff;
> +                       *reg |= val << 16;
> +               } else {
> +                       *reg &= 0xffff << 16;
> +                       *reg |= val;
> +               }
> +       }
> +
> +       return false;
> +}
> +
> +static bool handle_mmio_sgi_reg(struct kvm_vcpu *vcpu,
> +                               struct kvm_exit_mmio *mmio, u32 offset)
> +{
> +       u32 reg;
> +       vgic_reg_access(mmio, &reg, offset,
> +                       ACCESS_READ_RAZ | ACCESS_WRITE_VALUE);
> +       if (mmio->is_write) {
> +               vgic_dispatch_sgi(vcpu, reg);
> +               vgic_update_state(vcpu->kvm);
> +               return true;
> +       }
> +
> +       return false;
> +}
> +
>  /* All this should be handled by kvm_bus_io_*()... FIXME!!! */
>  struct mmio_range {
>         unsigned long base;
> @@ -110,6 +428,66 @@ struct mmio_range {
>  };
> 
>  static const struct mmio_range vgic_ranges[] = {
> +       {                       /* CTRL, TYPER, IIDR */
> +               .base           = 0,
> +               .len            = 12,
> +               .handle_mmio    = handle_mmio_misc,
> +       },
> +       {                       /* IGROUPRn */
> +               .base           = 0x80,
> +               .len            = VGIC_NR_IRQS / 8,
> +               .handle_mmio    = handle_mmio_raz_wi,
> +       },
> +       {                       /* ISENABLERn */
> +               .base           = 0x100,
> +               .len            = VGIC_NR_IRQS / 8,
> +               .handle_mmio    = handle_mmio_set_enable_reg,
> +       },
> +       {                       /* ICENABLERn */
> +               .base           = 0x180,
> +               .len            = VGIC_NR_IRQS / 8,
> +               .handle_mmio    = handle_mmio_clear_enable_reg,
> +       },
> +       {                       /* ISPENDRn */
> +               .base           = 0x200,
> +               .len            = VGIC_NR_IRQS / 8,
> +               .handle_mmio    = handle_mmio_set_pending_reg,
> +       },
> +       {                       /* ICPENDRn */
> +               .base           = 0x280,
> +               .len            = VGIC_NR_IRQS / 8,
> +               .handle_mmio    = handle_mmio_clear_pending_reg,
> +       },
> +       {                       /* ISACTIVERn */
> +               .base           = 0x300,
> +               .len            = VGIC_NR_IRQS / 8,
> +               .handle_mmio    = handle_mmio_raz_wi,
> +       },
> +       {                       /* ICACTIVERn */
> +               .base           = 0x380,
> +               .len            = VGIC_NR_IRQS / 8,
> +               .handle_mmio    = handle_mmio_raz_wi,
> +       },
> +       {                       /* IPRIORITYRn */
> +               .base           = 0x400,
> +               .len            = VGIC_NR_IRQS,
> +               .handle_mmio    = handle_mmio_priority_reg,
> +       },
> +       {                       /* ITARGETSRn */
> +               .base           = 0x800,
> +               .len            = VGIC_NR_IRQS,
> +               .handle_mmio    = handle_mmio_target_reg,
> +       },
> +       {                       /* ICFGRn */
> +               .base           = 0xC00,
> +               .len            = VGIC_NR_IRQS / 4,
> +               .handle_mmio    = handle_mmio_cfg_reg,
> +       },
> +       {                       /* SGIRn */
> +               .base           = 0xF00,
> +               .len            = 4,
> +               .handle_mmio    = handle_mmio_sgi_reg,
> +       },

Why not #define the offset values for the base fields instead of commenting
the literals?

Will
