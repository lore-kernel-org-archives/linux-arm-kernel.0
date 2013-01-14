From: will.deacon@arm.com (Will Deacon)
Date: Mon, 14 Jan 2013 15:39:55 +0000
Subject: [PATCH v5 06/12] ARM: KVM: VGIC distributor handling
In-Reply-To: <20130108184204.46558.51956.stgit@ubuntu>
References: <20130108184116.46558.3558.stgit@ubuntu>
 <20130108184204.46558.51956.stgit@ubuntu>
Message-ID: <20130114153955.GF18935@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 08, 2013 at 06:42:04PM +0000, Christoffer Dall wrote:
> From: Marc Zyngier <marc.zyngier@arm.com>
> 
> Add the GIC distributor emulation code. A number of the GIC features
> are simply ignored as they are not required to boot a Linux guest.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
> ---
>  arch/arm/include/asm/kvm_vgic.h |   82 +++++
>  arch/arm/kvm/vgic.c             |  593 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 674 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/include/asm/kvm_vgic.h b/arch/arm/include/asm/kvm_vgic.h
> index 270dcd2..9ff0d9c 100644
> --- a/arch/arm/include/asm/kvm_vgic.h
> +++ b/arch/arm/include/asm/kvm_vgic.h
> @@ -19,12 +19,94 @@
>  #ifndef __ASM_ARM_KVM_VGIC_H
>  #define __ASM_ARM_KVM_VGIC_H
> 
> +#include <linux/kernel.h>
> +#include <linux/kvm.h>
> +#include <linux/kvm_host.h>
> +#include <linux/irqreturn.h>
> +#include <linux/spinlock.h>
> +#include <linux/types.h>
>  #include <asm/hardware/gic.h>
> 
> +#define VGIC_NR_IRQS           128
> +#define VGIC_NR_SGIS           16

Now that you have this, you can use it in a few places (see also the BUG_ONs
in vgic_queue_irq).

> +#define VGIC_NR_PPIS           16
> +#define VGIC_NR_PRIVATE_IRQS   (VGIC_NR_SGIS + VGIC_NR_PPIS)
> +#define VGIC_NR_SHARED_IRQS    (VGIC_NR_IRQS - VGIC_NR_PRIVATE_IRQS)
> +#define VGIC_MAX_CPUS          KVM_MAX_VCPUS
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
> +
> +/*
> + * The GIC distributor registers describing interrupts have two parts:
> + * - 32 per-CPU interrupts (SGI + PPI)
> + * - a bunch of shared interrupts (SPI)
> + */
> +struct vgic_bitmap {
> +       union {
> +               u32 reg[VGIC_NR_PRIVATE_IRQS / 32];
> +               DECLARE_BITMAP(reg_ul, VGIC_NR_PRIVATE_IRQS);
> +       } percpu[VGIC_MAX_CPUS];
> +       union {
> +               u32 reg[VGIC_NR_SHARED_IRQS / 32];
> +               DECLARE_BITMAP(reg_ul, VGIC_NR_SHARED_IRQS);
> +       } shared;
> +};
> +
> +struct vgic_bytemap {
> +       u32 percpu[VGIC_MAX_CPUS][VGIC_NR_PRIVATE_IRQS / 4];
> +       u32 shared[VGIC_NR_SHARED_IRQS  / 4];
> +};
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
> +
> +       /* Level/edge triggered */
> +       struct vgic_bitmap      irq_cfg;
> +
> +       /* Source CPU per SGI and target CPU */
> +       u8                      irq_sgi_sources[VGIC_MAX_CPUS][16];

VGIC_NR_SGIS


> +static u32 vgic_get_target_reg(struct kvm *kvm, int irq)
> +{
> +       struct vgic_dist *dist = &kvm->arch.vgic;
> +       struct kvm_vcpu *vcpu;
> +       int i, c;
> +       unsigned long *bmap;
> +       u32 val = 0;
> +
> +       irq -= VGIC_NR_PRIVATE_IRQS;
> +
> +       kvm_for_each_vcpu(c, vcpu, kvm) {
> +               bmap = vgic_bitmap_get_shared_map(&dist->irq_spi_target[c]);
> +               for (i = 0; i < GICD_IRQS_PER_ITARGETSR; i++)
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
> +       BUG_ON(irq < VGIC_NR_PRIVATE_IRQS);

This is now different to vgic_Get_target_reg, which doesn't have the
BUG_ONs. Can we remove these ones too?

> +       irq -= VGIC_NR_PRIVATE_IRQS;
> +
> +       /*
> +        * Pick the LSB in each byte. This ensures we target exactly
> +        * one vcpu per IRQ. If the byte is null, assume we target
> +        * CPU0.
> +        */
> +       for (i = 0; i < GICD_IRQS_PER_ITARGETSR; i++) {
> +               int shift = i * GICD_CPUTARGETS_BITS;
> +               target = ffs((val >> shift) & 0xffU);
> +               target = target ? (target - 1) : 0;
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

[...]

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
>         {}
>  };

You've added named definitions for these constants to the GIC header file,
so please replace these immediates with those and delete the comments.

Will
