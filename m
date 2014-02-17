From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 17 Feb 2014 10:10:39 -0800
Subject: [PATCH 01/18] arm64: initial support for GICv3
In-Reply-To: <53023BCF.5010504@arm.com>
References: <1391607050-540-1-git-send-email-marc.zyngier@arm.com>
 <1391607050-540-2-git-send-email-marc.zyngier@arm.com>
 <20140217011925.GB21070@cbox> <53023BCF.5010504@arm.com>
Message-ID: <20140217181039.GD21070@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 17, 2014 at 04:41:51PM +0000, Marc Zyngier wrote:
> Hi Christoffer,
> 
> On 17/02/14 01:19, Christoffer Dall wrote:
> > On Wed, Feb 05, 2014 at 01:30:33PM +0000, Marc Zyngier wrote:
> >> The Generic Interrupt Controller (version 3) offers services that are
> >> similar to GICv2, with a number of additional features:
> >> - Affinity routing based on the CPU MPIDR (ARE)
> >> - System register for the CPU interfaces (SRE)
> >> - Support for more that 8 CPUs
> >> - Locality-specific Peripheral Interrupts (LPIs)
> >> - Interrupt Translation Services (ITS)
> >>
> >> This patch adds preliminary support for GICv3 with ARE and SRE,
> >> non-secure mode only. It relies on higher exception levels to grant ARE
> >> and SRE access.
> >>
> >> Support for LPI and ITS will be added at a later time.
> >>
> >> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> >> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> >> ---
> >>  arch/arm64/Kconfig                 |   1 +
> >>  arch/arm64/kernel/head.S           |  14 +
> >>  arch/arm64/kernel/hyp-stub.S       |  41 ++-
> >>  drivers/irqchip/Kconfig            |   5 +
> >>  drivers/irqchip/Makefile           |   1 +
> >>  drivers/irqchip/irq-gic-v3.c       | 665 +++++++++++++++++++++++++++++++++++++
> >>  include/linux/irqchip/arm-gic-v3.h | 190 +++++++++++
> >>  7 files changed, 915 insertions(+), 2 deletions(-)
> >>  create mode 100644 drivers/irqchip/irq-gic-v3.c
> >>  create mode 100644 include/linux/irqchip/arm-gic-v3.h
> >>
> >> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> >> index dd4327f..3a7e26d 100644
> >> --- a/arch/arm64/Kconfig
> >> +++ b/arch/arm64/Kconfig
> >> @@ -9,6 +9,7 @@ config ARM64
> >>       select ARM_AMBA
> >>       select ARM_ARCH_TIMER
> >>       select ARM_GIC
> >> +     select ARM_GIC_V3
> >>       select BUILDTIME_EXTABLE_SORT
> >>       select CLONE_BACKWARDS
> >>       select COMMON_CLK
> >> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> >> index 0b281ff..522649b 100644
> >> --- a/arch/arm64/kernel/head.S
> >> +++ b/arch/arm64/kernel/head.S
> >> @@ -22,6 +22,7 @@
> >>
> >>  #include <linux/linkage.h>
> >>  #include <linux/init.h>
> >> +#include <linux/irqchip/arm-gic-v3.h>
> >>
> >>  #include <asm/assembler.h>
> >>  #include <asm/ptrace.h>
> >> @@ -183,6 +184,19 @@ CPU_LE(  bic     x0, x0, #(3 << 24)      )       // Clear the EE and E0E bits for EL1
> >>       msr     cnthctl_el2, x0
> >>       msr     cntvoff_el2, xzr                // Clear virtual offset
> >>
> >> +     /* GICv3 system register access */
> >> +     mrs     x0, id_aa64pfr0_el1
> >> +     ubfx    x0, x0, #24, #4
> >> +     cmp     x0, #1
> >> +     b.ne    3f
> >> +
> >> +     mrs     x0, ICC_SRE_EL2                 // Set ICC_SRE_EL2.SRE==1
> >> +     orr     x0, x0, #1
> >> +     msr     ICC_SRE_EL2, x0
> >> +     isb                                     // Make sure SRE is now 1
> >> +     msr     ICH_HCR_EL2, xzr                // Reset ICC_HCR_EL2 to defaults
> >
> > Why do we not just set ICC_SRE_EL2.Enable here, but instead do the whole
> > exception dance below?
> 
> That's a very good question. The more I think of it, the more I believe
> it to be completely unnecessary.
> 
> I'm going to remove the trapping and see what breaks. Or who screams.
> 
> >> +
> >> +3:
> >>       /* Populate ID registers. */
> >>       mrs     x0, midr_el1
> >>       mrs     x1, mpidr_el1
> >> diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
> >> index 0959611..c850d1e 100644
> >> --- a/arch/arm64/kernel/hyp-stub.S
> >> +++ b/arch/arm64/kernel/hyp-stub.S
> >> @@ -19,6 +19,7 @@
> >>
> >>  #include <linux/init.h>
> >>  #include <linux/linkage.h>
> >> +#include <linux/irqchip/arm-gic-v3.h>
> >>
> >>  #include <asm/assembler.h>
> >>  #include <asm/ptrace.h>
> >> @@ -51,16 +52,52 @@ ENDPROC(__hyp_stub_vectors)
> >>
> >>       .align 11
> >>
> >> +#define sysreg_to_iss(op0, op1, crn, crm, op2)       \
> >> +     (((op0 & 3) << 20) | ((op2 & 7 ) << 17) | \
> >> +      ((op1 & 7 ) << 14) | ((crn & 15) << 10) | \
> >> +      ((crm & 15) << 1))
> >> +
> >>  el1_sync:
> >> +     // Hack alert: we don't have a stack, and we can't use the one
> >> +     // from EL1 because our MMU is off. Thankfully, we have
> >> +     // tpidr_el2, which is under our complete control, and
> >> +     // tpidr_el0, which can be used as long as we haven't reached
> >> +     // userspace. Oh hum...
> >
> > Hmmm.  I feel like either we should tone down the hack alert claim,
> > because this is after all safe and we just explain what's going on, or
> > we should just allocate a small stack space following el1_sync and set
> > the SP upon entry to this handler?
> 
> Allocating a stack here is something I'd rather avoid (how big?). But
> yeah, I can probably tone the horror down a notch - I got used to see
> that code... ;-)
> 
> > Hopefully none of the code that will ever call into the sysregs trap
> > ever makes the same assumption that user space is not called yet ;)
> 
> Well, I'm going to nuke that code anyway. I'm almost convinced that we
> don't need it.
> 
> >> +     msr     tpidr_el2, x1                   // Preserve x1
> >> +
> >>       mrs     x1, esr_el2
> >>       lsr     x1, x1, #26
> >>       cmp     x1, #0x16
> >> -     b.ne    2f                              // Not an HVC trap
> >> +     b.ne    3f                              // Not an HVC trap
> >> +
> >> +     // Handle getting/setting vbar_el2
> >>       cbz     x0, 1f
> >>       msr     vbar_el2, x0                    // Set vbar_el2
> >>       b       2f
> >>  1:   mrs     x0, vbar_el2                    // Return vbar_el2
> >> -2:   eret
> >> +2:   mrs     x1, tpidr_el2                   // Restore x1
> >> +     eret
> >> +
> >> +3:   cmp     x1, #0x18                       // MSR/MRS?
> >> +     b.ne    2b
> >> +
> >> +     // Handle trapped sys reg access
> >> +     msr     tpidr_el0, x0                   // Preserve x0
> >> +     mrs     x1, esr_el2
> >> +     ldr     x0, =sysreg_to_iss(3, 7, 15, 15, 7)
> >> +     and     x1, x1, x0
> >> +     ldr     x0, =sysreg_to_iss(3, 0, 12, 12, 5)
> >> +     eor     x0, x0, x1                      // Check for ICC_SRE_EL1
> >> +     cbnz    x0, 4f                          // Something bad happened
> >
> > Shouldn't we try to do something here, like go to panic on the
> > exception return here, or not worth it?
> 
> Code is now gone... ;-)
> 
> >> +
> >> +     // Set ICC_SRE_EL1 access enable
> >> +     mrs     x1, ICC_SRE_EL2
> >> +     orr     x1, x1, #(1 << 3)
> >> +     msr     ICC_SRE_EL2, x1
> >> +
> >> +4:   mrs     x0, tpidr_el0                   // Restore x0
> >> +     mrs     x1, tpidr_el2                   // Restore x1
> >> +     eret
> >>  ENDPROC(el1_sync)
> >>
> >>  .macro invalid_vector        label
> >> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> >> index 61ffdca..5b55c46 100644
> >> --- a/drivers/irqchip/Kconfig
> >> +++ b/drivers/irqchip/Kconfig
> >> @@ -10,6 +10,11 @@ config ARM_GIC
> >>  config GIC_NON_BANKED
> >>       bool
> >>
> >> +config ARM_GIC_V3
> >> +     bool
> >> +     select IRQ_DOMAIN
> >> +     select MULTI_IRQ_HANDLER
> >> +
> >>  config ARM_NVIC
> >>       bool
> >>       select IRQ_DOMAIN
> >> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> >> index 86b484c..e6ac9fd 100644
> >> --- a/drivers/irqchip/Makefile
> >> +++ b/drivers/irqchip/Makefile
> >> @@ -14,6 +14,7 @@ obj-$(CONFIG_ORION_IRQCHIP)         += irq-orion.o
> >>  obj-$(CONFIG_ARCH_SUNXI)             += irq-sun4i.o
> >>  obj-$(CONFIG_ARCH_SPEAR3XX)          += spear-shirq.o
> >>  obj-$(CONFIG_ARM_GIC)                        += irq-gic.o
> >> +obj-$(CONFIG_ARM_GIC_V3)             += irq-gic-v3.o
> >>  obj-$(CONFIG_ARM_NVIC)                       += irq-nvic.o
> >>  obj-$(CONFIG_ARM_VIC)                        += irq-vic.o
> >>  obj-$(CONFIG_IMGPDC_IRQ)             += irq-imgpdc.o
> >> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> >> new file mode 100644
> >> index 0000000..487e061
> >> --- /dev/null
> >> +++ b/drivers/irqchip/irq-gic-v3.c
> >> @@ -0,0 +1,665 @@
> >> +/*
> >> + * Copyright (C) 2013 ARM Limited, All Rights Reserved.
> >> + * Author: Marc Zyngier <marc.zyngier@arm.com>
> >> + *
> >> + * This program is free software; you can redistribute it and/or modify
> >> + * it under the terms of the GNU General Public License version 2 as
> >> + * published by the Free Software Foundation.
> >> + *
> >> + * This program is distributed in the hope that it will be useful,
> >> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> >> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> >> + * GNU General Public License for more details.
> >> + *
> >> + * You should have received a copy of the GNU General Public License
> >> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> >> + */
> >> +
> >> +#include <linux/cpu.h>
> >> +#include <linux/interrupt.h>
> >> +#include <linux/of.h>
> >> +#include <linux/of_address.h>
> >> +#include <linux/of_irq.h>
> >> +#include <linux/percpu.h>
> >> +#include <linux/slab.h>
> >> +
> >> +#include <linux/irqchip/arm-gic-v3.h>
> >> +
> >> +#include <asm/cputype.h>
> >> +#include <asm/exception.h>
> >> +#include <asm/smp_plat.h>
> >> +
> >> +#include "irqchip.h"
> >> +
> >> +struct gic_chip_data {
> >> +     void __iomem            *dist_base;
> >> +     void __iomem            **redist_base;
> >> +     void __percpu __iomem   **rdist;
> >> +     struct irq_domain       *domain;
> >> +     u64                     redist_stride;
> >> +     u32                     redist_regions;
> >> +     unsigned int            irq_nr;
> >> +};
> >> +
> >> +static struct gic_chip_data gic_data __read_mostly;
> >> +
> >> +#define gic_data_rdist_rd_base()     (*__this_cpu_ptr(gic_data.rdist))
> >> +#define gic_data_rdist_sgi_base()    (gic_data_rdist_rd_base() + SZ_64K)
> >> +
> >> +static DEFINE_RAW_SPINLOCK(dist_lock);
> >> +
> >> +#define DEFAULT_PMR_VALUE    0xf0
> >> +
> >> +static inline void __iomem *gic_dist_base(struct irq_data *d)
> >> +{
> >> +     if (d->hwirq < 32)      /* SGI+PPI -> SGI_base for this CPU */
> >> +             return gic_data_rdist_sgi_base();
> >> +
> >> +     if (d->hwirq <= 1023)   /* SPI -> dist_base */
> >> +             return gic_data.dist_base;
> >> +
> >> +     if (d->hwirq >= 8192)
> >> +             BUG();          /* LPI Detected!!! */
> >> +
> >> +     return NULL;
> >> +}
> >> +
> >> +static inline unsigned int gic_irq(struct irq_data *d)
> >> +{
> >> +     return d->hwirq;
> >> +}
> >> +
> >> +static void gic_do_wait_for_rwp(void __iomem *base)
> >> +{
> >> +     u32 val;
> >> +
> >> +     do {
> >> +             val = readl_relaxed(base + GICD_CTLR);
> >> +             cpu_relax();
> >> +     } while (val & GICD_CTLR_RWP);
> >> +}
> >> +
> >> +/* Wait for completion of a distributor change */
> >> +static void gic_dist_wait_for_rwp(void)
> >> +{
> >> +     gic_do_wait_for_rwp(gic_data.dist_base);
> >> +}
> >> +
> >> +/* Wait for completion of a redistributor change */
> >> +static void gic_redist_wait_for_rwp(void)
> >> +{
> >> +     gic_do_wait_for_rwp(gic_data_rdist_rd_base());
> >> +}
> >> +
> >> +static void gic_wait_for_rwp(int irq)
> >> +{
> >> +     if (irq < 32)
> >> +             gic_redist_wait_for_rwp();
> >> +     else
> >> +             gic_dist_wait_for_rwp();
> >> +}
> >> +
> >> +/* Low level accessors */
> >> +static u64 gic_read_iar(void)
> >> +{
> >> +     u64 irqstat;
> >> +
> >> +     asm volatile("mrs %0, " reg(ICC_IAR1_EL1) : "=r" (irqstat));
> >> +     return irqstat;
> >> +}
> >> +
> >> +static void gic_write_pmr(u64 val)
> >> +{
> >> +     asm volatile("msr " reg(ICC_PMR_EL1) ", %0" : : "r" (val));
> >> +     isb();
> >> +}
> >> +
> >> +static void gic_write_ctlr(u64 val)
> >> +{
> >> +     asm volatile("msr " reg(ICC_CTLR_EL1) ", %0" : : "r" (val));
> >> +     isb();
> >> +}
> >> +
> >> +static void gic_write_grpen1(u64 val)
> >> +{
> >> +     asm volatile("msr " reg(ICC_GRPEN1_EL1) ", %0" : : "r" (val));
> >> +     isb();
> >> +}
> >> +
> >> +static void gic_write_sgi1r(u64 val)
> >> +{
> >> +     asm volatile("msr " reg(ICC_SGI1R_EL1) ", %0" : : "r" (val));
> >> +     isb();
> >> +}
> >> +
> >> +static void gic_enable_sre(void)
> >> +{
> >> +     u64 val;
> >> +
> >> +     /* This access is likely to trap into EL2 */
> >> +     asm volatile("mrs %0, " reg(ICC_SRE_EL1) : "=r" (val));
> >> +     val |= GICC_SRE_EL1_SRE;
> >> +     asm volatile("msr " reg(ICC_SRE_EL1) ", %0" : : "r" (val));
> >> +     isb();
> >> +}
> >> +
> >> +static void gic_enable_redist(void)
> >> +{
> >> +     void __iomem *rbase;
> >> +     u32 val;
> >> +
> >> +     rbase = gic_data_rdist_rd_base();
> >> +
> >> +     /* Wake up this CPU redistributor */
> >> +     val = readl_relaxed(rbase + GICR_WAKER);
> >> +     val &= ~GICR_WAKER_ProcessorSleep;
> >> +     writel_relaxed(val, rbase + GICR_WAKER);
> >> +
> >> +     do {
> >> +             val = readl_relaxed(rbase + GICR_WAKER);
> >> +             cpu_relax();
> >> +     } while (val & GICR_WAKER_ChildrenAsleep);
> >> +}
> >> +
> >> +/*
> >> + * Routines to acknowledge, disable and enable interrupts
> >> + */
> >> +static void gic_mask_irq(struct irq_data *d)
> >> +{
> >> +     u32 mask = 1 << (gic_irq(d) % 32);
> >> +
> >> +     raw_spin_lock(&dist_lock);
> >> +     writel_relaxed(mask, gic_dist_base(d) + GICD_ICENABLER + (gic_irq(d) / 32) * 4);
> >> +     gic_wait_for_rwp(gic_irq(d));
> >> +     raw_spin_unlock(&dist_lock);
> >> +}
> >> +
> >> +static void gic_unmask_irq(struct irq_data *d)
> >> +{
> >> +     u32 mask = 1 << (gic_irq(d) % 32);
> >> +
> >> +     raw_spin_lock(&dist_lock);
> >> +     writel_relaxed(mask, gic_dist_base(d) + GICD_ISENABLER + (gic_irq(d) / 32) * 4);
> >> +     gic_wait_for_rwp(gic_irq(d));
> >> +     raw_spin_unlock(&dist_lock);
> >> +}
> >> +
> >> +static void gic_eoi_irq(struct irq_data *d)
> >> +{
> >> +     gic_write_eoir(gic_irq(d));
> >> +}
> >> +
> >> +static int gic_set_type(struct irq_data *d, unsigned int type)
> >> +{
> >> +     void __iomem *base = gic_dist_base(d);
> >> +     unsigned int irq = gic_irq(d);
> >> +     u32 enablemask = 1 << (irq % 32);
> >> +     u32 enableoff = (irq / 32) * 4;
> >> +     u32 confmask = 0x2 << ((irq % 16) * 2);
> >> +     u32 confoff = (irq / 16) * 4;
> >> +     bool enabled = false;
> >> +     u32 val;
> >> +
> >> +     /* Interrupt configuration for SGIs can't be changed */
> >> +     if (irq < 16)
> >> +             return -EINVAL;
> >> +
> >> +     if (type != IRQ_TYPE_LEVEL_HIGH && type != IRQ_TYPE_EDGE_RISING)
> >> +             return -EINVAL;
> >> +
> >> +     raw_spin_lock(&dist_lock);
> >> +
> >> +     val = readl_relaxed(base + GICD_ICFGR + confoff);
> >> +     if (type == IRQ_TYPE_LEVEL_HIGH)
> >> +             val &= ~confmask;
> >> +     else if (type == IRQ_TYPE_EDGE_RISING)
> >> +             val |= confmask;
> >> +
> >> +     /*
> >> +      * As recommended by the spec, disable the interrupt before changing
> >> +      * the configuration
> >> +      */
> >> +     if (readl_relaxed(base + GICD_ISENABLER + enableoff) & enablemask) {
> >> +             writel_relaxed(enablemask, base + GICD_ICENABLER + enableoff);
> >> +             gic_wait_for_rwp(irq);
> >> +             enabled = true;
> >> +     }
> >> +
> >> +     writel_relaxed(val, base + GICD_ICFGR + confoff);
> >> +
> >> +     if (enabled) {
> >> +             writel_relaxed(enablemask, base + GICD_ISENABLER + enableoff);
> >> +             gic_wait_for_rwp(irq);
> >> +     }
> >> +
> >> +     raw_spin_unlock(&dist_lock);
> >> +
> >> +     return 0;
> >> +}
> >> +
> >> +static int gic_retrigger(struct irq_data *d)
> >> +{
> >> +     return -ENXIO;
> >> +}
> >> +
> >> +static u64 gic_mpidr_to_affinity(u64 mpidr)
> >> +{
> >> +     /* Make sure we don't broadcast the interrupt */
> >> +     return mpidr & ~GICD_IROUTER_SPI_MODE_ANY;
> >> +}
> >> +
> >> +static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs)
> >> +{
> >> +     u64 irqnr;
> >> +
> >> +     do {
> >> +             irqnr = gic_read_iar();
> >> +
> >> +             if (likely(irqnr > 15 && irqnr < 1021)) {
> >> +                     irqnr = irq_find_mapping(gic_data.domain, irqnr);
> >> +                     handle_IRQ(irqnr, regs);
> >> +                     continue;
> >> +             }
> >> +             if (irqnr < 16) {
> >> +                     gic_write_eoir(irqnr);
> >> +#ifdef CONFIG_SMP
> >> +                     handle_IPI(irqnr, regs);
> >> +#else
> >> +                     WARN_ONCE(true, "Unexpected SGI received!\n");
> >> +#endif
> >> +                     continue;
> >> +             }
> >> +     } while (irqnr != 0x3ff);
> >> +}
> >> +
> >> +static void __init gic_dist_init(void)
> >> +{
> >> +     unsigned int i;
> >> +     u64 affinity;
> >> +     int gic_irqs = gic_data.irq_nr;
> >> +     void __iomem *base = gic_data.dist_base;
> >> +
> >> +     /* Disable the distributor */
> >> +     writel_relaxed(0, base + GICD_CTLR);
> >> +
> >> +     /*
> >> +      * Set all global interrupts to be level triggered, active low.
> >> +      */
> >> +     for (i = 32; i < gic_data.irq_nr; i += 16)
> >> +             writel_relaxed(0, base + GICD_ICFGR + i / 4);
> >> +
> >> +     /*
> >> +      * Set priority on all global interrupts.
> >> +      */
> >> +     for (i = 32; i < gic_irqs; i += 4)
> >> +             writel_relaxed(0xa0a0a0a0, base + GICD_IPRIORITYR + i);
> >> +
> >> +     /*
> >> +      * Disable all interrupts.  Leave the PPI and SGIs alone
> >> +      * as these enables are banked registers.
> >
> > as these are enabled through banked registers?
> 
> "The enable bits are banked registers", but I can see where the
> confision comes from. I'll rewrite this comment.
> 
> > also, should banked registers be redistributor registers?
> 
> Yup.
> 
> >> +      */
> >> +     for (i = 32; i < gic_irqs; i += 32)
> >> +             writel_relaxed(0xffffffff, base + GICD_ICENABLER + i / 8);
> >> +
> >> +     gic_dist_wait_for_rwp();
> >> +
> >> +     writel_relaxed(GICD_CTLR_ARE_NS | GICD_CTLR_ENABLE_G1A | GICD_CTLR_ENABLE_G1,
> >> +                    base + GICD_CTLR);
> >
> > why set GICD_CTLR_ENABLE_G1 ?
> 
> Believe it or not, some people insist on running in secure mode.
> 

Ah, didn't consider this.  Maybe because the cover-letter ssays this
patch only supports "Non-Secure Group-1 interrupts only".

> >> +
> >> +     /*
> >> +      * Set all global interrupts to the boot CPU only. ARE must be
> >> +      * enabled.
> >> +      */
> >> +     affinity = gic_mpidr_to_affinity(read_cpuid_mpidr());
> >> +     for (i = 32; i < gic_data.irq_nr; i++)
> >> +             writeq_relaxed(affinity, base + GICD_IROUTER + i * 8);
> >> +}
> >> +
> >> +static int __init gic_populate_rdist(void)
> >> +{
> >> +     u64 mpidr = cpu_logical_map(smp_processor_id());
> >> +     u64 typer;
> >> +     u64 aff;
> >> +     int i;
> >> +
> >> +     aff  = mpidr & ((1 << 24) - 1);
> >> +     aff |= (mpidr >> 8) & (0xffUL << 24);
> >
> > Some defines would be nice for this if it makes sense in any way.
> 
> There is at least 3 methods GICv3 uses to express affinity. At some
> point, I gave up and decided that I needed mental support.
> 
> I'll update it with the appropriate macros (MPIDR_AFFINITY_LEVEL and co).
> 

I don't feel strongly about it, maybe we need giant diagrams on A1 paper
instead :)

> >> +
> >> +     for (i = 0; i < gic_data.redist_regions; i++) {
> >> +             void __iomem *ptr = gic_data.redist_base[i];
> >> +             u32 reg;
> >> +
> >> +             reg = readl_relaxed(ptr + GICR_PIDR2) & GIC_PIDR2_ARCH_MASK;
> >> +             if (reg != 0x30 && reg != 0x40) { /* We're in trouble... */
> >> +                     pr_warn("No redistributor present @%p\n", ptr);
> >> +                     break;
> >> +             }
> >> +
> >> +             do {
> >> +                     typer = readq_relaxed(ptr + GICR_TYPER);
> >> +                     if ((typer >> 32) == aff) {
> >> +                             gic_data_rdist_rd_base() = ptr;
> >> +                             pr_info("CPU%d: found redistributor %llx @%p\n",
> >> +                                     smp_processor_id(),
> >> +                                     (unsigned long long) mpidr, ptr);
> >> +                             return 0;
> >> +                     }
> >> +
> >> +                     if (gic_data.redist_stride) {
> >> +                             ptr += gic_data.redist_stride;
> >> +                     } else {
> >> +                             ptr += SZ_64K * 2; /* Skip RD_base + SGI_base */
> >> +                             if (typer & GICR_TYPER_VLPIS)
> >> +                                     ptr += SZ_64K * 2; /* Skip VLPI_base + reserved page */
> >> +                     }
> >> +             } while (!(typer & GICR_TYPER_LAST));
> >> +     }
> >> +
> >> +     /* We couldn't even deal with ourselves... */
> >> +     WARN(true, "CPU%d: mpidr %lx has no re-distributor!\n",
> >> +          smp_processor_id(), (unsigned long)mpidr);
> >> +     return -ENODEV;
> >> +}
> >> +
> >> +static void __init gic_cpu_init(void)
> >> +{
> >> +     void __iomem *rbase;
> >> +     int i;
> >> +
> >> +     /* Register ourselves with the rest of the world */
> >> +     if (gic_populate_rdist())
> >> +             return;
> >> +
> >> +     gic_enable_redist();
> >> +
> >> +     rbase = gic_data_rdist_sgi_base();
> >> +
> >> +     /*
> >> +      * Set priority on PPI and SGI interrupts
> >> +      */
> >> +     for (i = 0; i < 32; i += 4)
> >> +             writel_relaxed(0xa0a0a0a0, rbase + GICR_IPRIORITYR0 + i * 4 / 4);
> >
> > (i * 4) / 4 == i, last I checked.
> 
> Recurring comment. I decided to keep it inline with the GICv2 practice.
> Read it as i * increment / interrupt-per-word. Maybe not worth it if it
> causes more problem than anything else...
> 

Yeah, I noticed it in the GICv2 code afterwards, but I don't think
you're consistent with this approach throughout the file.  I personaly
find this notation mind-boggingly-difficult, but that is a personal
observation.

> >> +
> >> +     /*
> >> +      * Disable all PPI interrupts, ensure all SGI interrupts are
> >> +      * enabled.
> >
> > Why do we disable all PPIs?
> 
> Because interrupts should default to being disabled? They will get
> enabled when you do a request_irq.
> 

Duh, yeah, and SGI don't need to be disabled because we're in control of
generating them I guess.  Thanks for the explanation.

> >> +      */
> >> +     writel_relaxed(0xffff0000, rbase + GICR_ICENABLER0);
> >> +     writel_relaxed(0x0000ffff, rbase + GICR_ISENABLER0);
> >> +
> >> +     gic_redist_wait_for_rwp();
> >> +
> >> +     /* Enable system registers */
> >> +     gic_enable_sre();
> >> +
> >> +     /* Set priority mask register */
> >> +     gic_write_pmr(DEFAULT_PMR_VALUE);
> >> +
> >> +     /* EOI drops priority too (mode 0) */
> >
> > you mean deactives the interrupt too, right? It always performs a
> > priority drop doesn't it?
> 
> Yup. Just my usual brainfart.
> 
> >> +     gic_write_ctlr(GICC_CTLR_EL1_EOImode_drop_dir);
> >> +
> >> +     /* ... and let's hit the road... */
> >> +     gic_write_grpen1(1);
> >> +}
> >> +
> >> +#ifdef CONFIG_SMP
> >> +static int __init gic_secondary_init(struct notifier_block *nfb,
> >> +                                  unsigned long action, void *hcpu)
> >> +{
> >> +     if (action == CPU_STARTING || action == CPU_STARTING_FROZEN)
> >> +             gic_cpu_init();
> >> +     return NOTIFY_OK;
> >> +}
> >> +
> >> +/*
> >> + * Notifier for enabling the GIC CPU interface. Set an arbitrarily high
> >> + * priority because the GIC needs to be up before the ARM generic timers.
> >
> > I actually don't understand this bit, but it also sits in the original
> > code, so I assume it's correct.
> 
> GIC and timer on the secondary CPUs are intialized using the CPU
> notifiers. Since the need the GIC to be up and running before the timers
> can enable their interrupts, we use the relative priorities of the
> notifiers to order them.
> 

thanks again for the explanation.

> >> + */
> >> +static struct notifier_block __initdata gic_cpu_notifier = {
> >> +     .notifier_call = gic_secondary_init,
> >> +     .priority = 100,
> >> +};
> >> +
> >> +static u16 gic_compute_target_list(int *base_cpu, const struct cpumask *mask,
> >> +                                u64 cluster_id)
> >> +{
> >> +     int cpu = *base_cpu;
> >> +     u64 mpidr = cpu_logical_map(cpu);
> >> +     u16 tlist = 0;
> >> +
> >> +     while (cpu < nr_cpu_ids) {
> >> +             /*
> >> +              * If we ever get a cluster of more than 16 CPUs, just
> >> +              * scream and skip that CPU.
> >> +              */
> >> +             if (WARN_ON((mpidr & 0xff) >= 16))
> >> +                     goto out;
> >> +
> >> +             tlist |= 1 << (mpidr & 0xf);
> >> +
> >> +             cpu = cpumask_next(cpu, mask);
> >> +             mpidr = cpu_logical_map(cpu);
> >
> > Are you not accessing memory beyond the __cpu_logical_map array here
> > when the cpu is the last one at the beginning of the loop?
> 
> Nice catch! I need to test cpu here before carrying on...
> 

You could also simply use for_each_cpu_mask here and in the beginning of
the loop increment the first cpu to *base_cpu if it makes the code
cleaner.  Not sure.

> >> +
> >> +             if (cluster_id != (mpidr & ~0xffUL)) {
> >> +                     cpu--;
> >> +                     goto out;
> >> +             }
> >> +     }
> >> +out:
> >> +     *base_cpu = cpu;
> >> +     return tlist;
> >> +}
> >> +
> >> +static void gic_send_sgi(u64 cluster_id, u16 tlist, unsigned int irq)
> >> +{
> >> +     u64 val;
> >> +
> >> +     val  = (cluster_id & 0xff00ff0000UL) << 16; /* Aff3 + Aff2 */
> >> +     val |= (cluster_id & 0xff00) << 8;          /* Aff1 */
> >> +     val |= irq << 24;
> >> +     val |= tlist;
> >> +
> >> +     pr_debug("CPU%d: ICC_SGI1R_EL1 %llx\n", smp_processor_id(), val);
> >> +     gic_write_sgi1r(val);
> >> +}
> >> +
> >> +static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
> >> +{
> >> +     int cpu;
> >> +
> >> +     if (WARN_ON(irq >= 16))
> >> +             return;
> >> +
> >> +     /*
> >> +      * Ensure that stores to Normal memory are visible to the
> >> +      * other CPUs before issuing the IPI.
> >> +      */
> >> +     dsb();
> >> +
> >> +     for_each_cpu_mask(cpu, *mask) {
> >> +             u64 cluster_id = cpu_logical_map(cpu) & ~0xffUL;
> >> +             u16 tlist;
> >> +
> >> +             tlist = gic_compute_target_list(&cpu, mask, cluster_id);
> >
> > I think it would be potentially slightly prettier if this function
> > returned the last cpu in the cluster so the loop iterator mangling was
> > kept local to this function and took a pointer to the tlist it was to
> > fill instead, but, this is a minor detail.
> 
> Yeah, maybe. I'll try that and see how it looks. it's quite messy anyway...
> 

yeah, nothing I feel strongly about anyway.

> >> +             gic_send_sgi(cluster_id, tlist, irq);
> >> +     }
> >> +}
> >> +
> >> +static void gic_smp_init(void)
> >> +{
> >> +     set_smp_cross_call(gic_raise_softirq);
> >> +     register_cpu_notifier(&gic_cpu_notifier);
> >> +}
> >> +
> >> +static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
> >> +                         bool force)
> >> +{
> >> +     unsigned int cpu = cpumask_any_and(mask_val, cpu_online_mask);
> >> +     void __iomem *reg;
> >> +     u64 val;
> >> +
> >> +     if (gic_irq(d) < 32)
> >> +             return -EINVAL;
> >> +
> >> +     reg = gic_dist_base(d) + GICD_IROUTER + (gic_irq(d) * 8);
> >> +     val = gic_mpidr_to_affinity(cpu_logical_map(cpu));
> >> +
> >> +     writeq_relaxed(val, reg);
> >> +
> >> +     return IRQ_SET_MASK_OK;
> >> +}
> >> +#else
> >> +#define gic_set_affinity     NULL
> >> +#define gic_smp_init()               do { } while(0)
> >> +#endif
> >> +
> >> +static struct irq_chip gic_chip = {
> >> +     .name                   = "GICv3",
> >> +     .irq_mask               = gic_mask_irq,
> >> +     .irq_unmask             = gic_unmask_irq,
> >> +     .irq_eoi                = gic_eoi_irq,
> >> +     .irq_set_type           = gic_set_type,
> >> +     .irq_retrigger          = gic_retrigger,
> >> +     .irq_set_affinity       = gic_set_affinity,
> >> +};
> >> +
> >> +static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
> >> +                             irq_hw_number_t hw)
> >> +{
> >> +     if (hw < 32) {
> >> +             irq_set_percpu_devid(irq);
> >> +             irq_set_chip_and_handler(irq, &gic_chip,
> >> +                                      handle_percpu_devid_irq);
> >> +             set_irq_flags(irq, IRQF_VALID | IRQF_NOAUTOEN);
> >> +     } else {
> >> +             irq_set_chip_and_handler(irq, &gic_chip,
> >> +                                      handle_fasteoi_irq);
> >> +             set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
> >
> > will this ever be compiled for arch/arm?  If not, does it make sense to
> > keep the set_irq_flags calls?
> 
> Not impossible at all, by the look of it. That will require some effort,
> but if someone feels like it, I don't see the point in actuvely removing
> that code.
> 

ok

> >> +     }
> >> +     irq_set_chip_data(irq, d->host_data);
> >> +     return 0;
> >> +}
> >> +
> >> +static int gic_irq_domain_xlate(struct irq_domain *d,
> >> +                             struct device_node *controller,
> >> +                             const u32 *intspec, unsigned int intsize,
> >> +                             unsigned long *out_hwirq, unsigned int *out_type)
> >> +{
> >> +     if (d->of_node != controller)
> >> +             return -EINVAL;
> >> +     if (intsize < 3)
> >> +             return -EINVAL;
> >> +
> >> +     switch(intspec[0]) {
> >> +     case 0:                 /* SPI */
> >> +             *out_hwirq = intspec[1] + 32;
> >> +             break;
> >> +     case 1:                 /* PPI */
> >> +             *out_hwirq = intspec[1] + 16;
> >> +             break;
> >> +     default:
> >> +             return -EINVAL;
> >> +     }
> >> +
> >> +     *out_type = intspec[2] & IRQ_TYPE_SENSE_MASK;
> >> +     return 0;
> >> +}
> >> +
> >> +static const struct irq_domain_ops gic_irq_domain_ops = {
> >> +     .map = gic_irq_domain_map,
> >> +     .xlate = gic_irq_domain_xlate,
> >> +};
> >> +
> >> +static int __init gic_of_init(struct device_node *node, struct device_node *parent)
> >> +{
> >> +     void __iomem *dist_base;
> >> +     void __iomem **redist_base;
> >> +     u64 redist_stride;
> >> +     u32 redist_regions;
> >> +     u32 reg;
> >> +     int gic_irqs;
> >> +     int err;
> >> +     int i;
> >> +
> >> +     dist_base = of_iomap(node, 0);
> >> +     if (!dist_base) {
> >> +             pr_warn("%s: unable to map gic dist registers\n",
> >> +                     node->full_name);
> >
> > shouldn't these be pr_err?
> 
> Indeed.
> 
> >> +             return -ENXIO;
> >> +     }
> >> +
> >> +     reg = readl_relaxed(dist_base + GICD_PIDR2) & GIC_PIDR2_ARCH_MASK;
> >> +     if (reg != 0x30 && reg != 0x40) {
> >
> > Is everything we do going to work with a GICv4? Anything else we need to
> > initialize if it's a GICv4?
> 
> GICv4 is a strict superset of GICv3, and it should all just work as long
> as you don't try to use GICv4 specific features. *Should*.
> 

cool

> >> +             pr_warn("%s: no distributor detected, giving up\n",
> >> +                     node->full_name);
> >> +             err = -ENODEV;
> >> +             goto out_unmap_dist;
> >> +     }
> >> +
> >> +     if (of_property_read_u32(node, "#redistributor-regions", &redist_regions))
> >> +             redist_regions = 1;
> >> +
> >> +     redist_base = kzalloc(sizeof(*redist_base) * redist_regions, GFP_KERNEL);
> >> +     if (!redist_base) {
> >> +             err = -ENOMEM;
> >> +             goto out_unmap_dist;
> >> +     }
> >> +
> >> +     for (i = 0; i < redist_regions; i++) {
> >> +             redist_base[i] = of_iomap(node, 1 + i);
> >> +             if (!redist_base[i]) {
> >> +                     pr_warn("%s: couldn't map region %d\n",
> >> +                             node->full_name, i);
> >> +                     err = -ENODEV;
> >> +                     goto out_unmap_rdist;
> >> +             }
> >> +     }
> >> +
> >> +     if (of_property_read_u64(node, "redistributor-stride", &redist_stride))
> >> +             redist_stride = 0;
> >
> > The binding doesn't specify this as a two-cell property, so I assume
> > this won't work if you follow the example in the bindings doc.
> 
> Yup. I'll update the DT. Nice catch.
> 
> >> +
> >> +     gic_data.dist_base = dist_base;
> >> +     gic_data.redist_base = redist_base;
> >> +     gic_data.redist_regions = redist_regions;
> >> +     gic_data.redist_stride = redist_stride;
> >> +
> >> +     /*
> >> +      * Find out how many interrupts are supported.
> >> +      * The GIC only supports up to 1020 interrupt sources (SGI+PPI+SPI)
> >> +      */
> >> +     gic_irqs = readl_relaxed(gic_data.dist_base + GICD_TYPER) & 0x1f;
> >> +     gic_irqs = (gic_irqs + 1) * 32;
> >> +     if (gic_irqs > 1020)
> >> +             gic_irqs = 1020;
> >> +     gic_data.irq_nr = gic_irqs;
> >> +
> >> +     gic_data.domain = irq_domain_add_linear(node, gic_irqs - 16,
> >> +                                             &gic_irq_domain_ops, &gic_data);
> >> +     gic_data.rdist = alloc_percpu(typeof(*gic_data.rdist));
> >> +
> >> +     if (WARN_ON(!gic_data.domain) || WARN_ON(!gic_data.rdist)) {
> >> +             err = -ENOMEM;
> >> +             goto out_free;
> >> +     }
> >> +
> >> +     set_handle_irq(gic_handle_irq);
> >> +
> >> +     gic_smp_init();
> >> +     gic_dist_init();
> >> +     gic_cpu_init();
> >> +
> >> +     return 0;
> >> +
> >> +out_free:
> >> +     free_percpu(gic_data.rdist);
> >> +out_unmap_rdist:
> >> +     for (i = 0; i < redist_regions; i++)
> >> +             if (redist_base[i])
> >> +                     iounmap(redist_base[i]);
> >> +     kfree(redist_base);
> >> +out_unmap_dist:
> >> +     iounmap(dist_base);
> >> +     return err;
> >> +}
> >> +
> >> +IRQCHIP_DECLARE(gic_v3, "arm,gic-v3", gic_of_init);
> >> diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
> >> new file mode 100644
> >> index 0000000..e4d060a
> >> --- /dev/null
> >> +++ b/include/linux/irqchip/arm-gic-v3.h
> >> @@ -0,0 +1,190 @@
> >> +/*
> >> + * Copyright (C) 2013 ARM Limited, All Rights Reserved.
> >> + * Author: Marc Zyngier <marc.zyngier@arm.com>
> >> + *
> >> + *
> >> + * This program is free software; you can redistribute it and/or modify
> >> + * it under the terms of the GNU General Public License version 2 as
> >> + * published by the Free Software Foundation.
> >> + *
> >> + * This program is distributed in the hope that it will be useful,
> >> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> >> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> >> + * GNU General Public License for more details.
> >> + *
> >> + * You should have received a copy of the GNU General Public License
> >> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> >> + */
> >> +#ifndef __LINUX_IRQCHIP_ARM_GIC_V3_H
> >> +#define __LINUX_IRQCHIP_ARM_GIC_V3_H
> >> +
> >> +/*
> >> + * Distributor registers. We assume we're running non-secure, with ARE
> >> + * being set. Secure-only and non-ARE registers are not described.
> >> + */
> >> +#define GICD_CTLR                    0x0000
> >> +#define GICD_TYPER                   0x0004
> >> +#define GICD_IIDR                    0x0008
> >> +#define GICD_STATUSR                 0x0010
> >> +#define GICD_SETSPI_NSR                      0x0040
> >> +#define GICD_CLRSPI_NSR                      0x0048
> >> +#define GICD_SETSPI_SR                       0x0050
> >> +#define GICD_CLRSPI_SR                       0x0058
> >> +#define GICD_SEIR                    0x0068
> >> +#define GICD_ISENABLER                       0x0100
> >> +#define GICD_ICENABLER                       0x0180
> >> +#define GICD_ISPENDR                 0x0200
> >> +#define GICD_ICPENDR                 0x0280
> >> +#define GICD_ISACTIVER                       0x0300
> >> +#define GICD_ICACTIVER                       0x0380
> >> +#define GICD_IPRIORITYR                      0x0400
> >> +#define GICD_ICFGR                   0x0C00
> >> +#define GICD_IROUTER                 0x6000
> >> +#define GICD_PIDR2                   0xFFE8
> >> +
> >> +#define GICD_CTLR_RWP                        (1U << 31)
> >> +#define GICD_CTLR_ARE_NS             (1U << 4)
> >> +#define GICD_CTLR_ENABLE_G1A         (1U << 1)
> >> +#define GICD_CTLR_ENABLE_G1          (1U << 0)
> >> +
> >> +#define GICD_IROUTER_SPI_MODE_ONE    (0U << 31)
> >> +#define GICD_IROUTER_SPI_MODE_ANY    (1U << 31)
> >> +
> >> +#define GIC_PIDR2_ARCH_MASK          0xf0
> >> +
> >> +/*
> >> + * Re-Distributor registers, offsets from RD_base
> >> + */
> >> +#define GICR_CTLR                    GICD_CTLR
> >> +#define GICR_IIDR                    0x0004
> >> +#define GICR_TYPER                   0x0008
> >> +#define GICR_STATUSR                 GICD_STATUSR
> >> +#define GICR_WAKER                   0x0014
> >> +#define GICR_SETLPIR                 0x0040
> >> +#define GICR_CLRLPIR                 0x0048
> >> +#define GICR_SEIR                    GICD_SEIR
> >> +#define GICR_PROPBASER                       0x0070
> >> +#define GICR_PENDBASER                       0x0078
> >> +#define GICR_INVLPIR                 0x00A0
> >> +#define GICR_INVALLR                 0x00B0
> >> +#define GICR_SYNCR                   0x00C0
> >> +#define GICR_MOVLPIR                 0x0100
> >> +#define GICR_MOVALLR                 0x0110
> >> +#define GICR_PIDR2                   GICD_PIDR2
> >> +
> >> +#define GICR_WAKER_ProcessorSleep    (1U << 1)
> >> +#define GICR_WAKER_ChildrenAsleep    (1U << 2)
> >> +
> >> +/*
> >> + * Re-Distributor registers, offsets from SGI_base
> >> + */
> >> +#define GICR_ISENABLER0                      GICD_ISENABLER
> >> +#define GICR_ICENABLER0                      GICD_ICENABLER
> >> +#define GICR_ISPENDR0                        GICD_ISPENDR
> >> +#define GICR_ICPENDR0                        GICD_ICPENDR
> >> +#define GICR_ISACTIVER0                      GICD_ISACTIVER
> >> +#define GICR_ICACTIVER0                      GICD_ICACTIVER
> >> +#define GICR_IPRIORITYR0             GICD_IPRIORITYR
> >> +#define GICR_ICFGR0                  GICD_ICFGR
> >> +
> >> +#define GICR_TYPER_VLPIS             (1U << 1)
> >> +#define GICR_TYPER_LAST                      (1U << 4)
> >
> > nit: why are these TYPER definitions down here when the TYPER register
> > is defined above and so the WAKER bit definitions?
> 
> I'll group them in the next version.
> 
> >> +
> >> +/*
> >> + * CPU interface registers
> >> + */
> >> +#define GICC_CTLR_EL1_EOImode_drop_dir       (0U << 1)
> >> +#define GICC_CTLR_EL1_EOImode_drop   (1U << 1)
> >> +#define GICC_SRE_EL1_SRE             (1U << 0)
> >> +
> >> +/*
> >> + * Hypervisor interface registers (SRE only)
> >> + */
> >> +#define GICH_LR_VIRTUAL_ID_MASK              ((1UL << 32) - 1)
> >> +
> >> +#define GICH_LR_EOI                  (1UL << 41)
> >> +#define GICH_LR_GROUP                        (1UL << 60)
> >> +#define GICH_LR_STATE                        (3UL << 62)
> >> +#define GICH_LR_PENDING_BIT          (1UL << 62)
> >> +#define GICH_LR_ACTIVE_BIT           (1UL << 63)
> >> +
> >> +#define GICH_MISR_EOI                        (1 << 0)
> >> +#define GICH_MISR_U                  (1 << 1)
> >> +
> >> +#define GICH_HCR_EN                  (1 << 0)
> >> +#define GICH_HCR_UIE                 (1 << 1)
> >> +
> >> +#define GICH_VMCR_CTLR_SHIFT         0
> >> +#define GICH_VMCR_CTLR_MASK          (0x21f << GICH_VMCR_CTLR_SHIFT)
> >> +#define GICH_VMCR_BPR1_SHIFT         18
> >> +#define GICH_VMCR_BPR1_MASK          (7 << GICH_VMCR_BPR1_SHIFT)
> >> +#define GICH_VMCR_BPR0_SHIFT         21
> >> +#define GICH_VMCR_BPR0_MASK          (7 << GICH_VMCR_BPR0_SHIFT)
> >> +#define GICH_VMCR_PMR_SHIFT          24
> >> +#define GICH_VMCR_PMR_MASK           (0xffUL << GICH_VMCR_PMR_SHIFT)
> >> +
> >> +#define ICC_EOIR1_EL1                        S3_0_C12_C12_1
> >> +#define ICC_IAR1_EL1                 S3_0_C12_C12_0
> >> +#define ICC_SGI1R_EL1                        S3_0_C12_C11_5
> >> +#define ICC_PMR_EL1                  S3_0_C4_C6_0
> >> +#define ICC_CTLR_EL1                 S3_0_C12_C12_4
> >> +#define ICC_SRE_EL1                  S3_0_C12_C12_5
> >> +#define ICC_GRPEN1_EL1                       S3_0_C12_C12_7
> >> +
> >> +#define ICC_SRE_EL2                  S3_4_C12_C9_5
> >> +
> >> +#define ICH_VSEIR_EL2                        S3_4_C12_C9_4
> >> +#define ICH_HCR_EL2                  S3_4_C12_C11_0
> >> +#define ICH_VTR_EL2                  S3_4_C12_C11_1
> >> +#define ICH_MISR_EL2                 S3_4_C12_C11_2
> >> +#define ICH_EISR_EL2                 S3_4_C12_C11_3
> >> +#define ICH_ELSR_EL2                 S3_4_C12_C11_5
> >> +#define ICH_VMCR_EL2                 S3_4_C12_C11_7
> >> +
> >> +#define __LR0_EL2(x)                 S3_4_C12_C12_ ## x
> >> +#define __LR8_EL2(x)                 S3_4_C12_C13_ ## x
> >> +
> >> +#define ICH_LR0_EL2                  __LR0_EL2(0)
> >> +#define ICH_LR1_EL2                  __LR0_EL2(1)
> >> +#define ICH_LR2_EL2                  __LR0_EL2(2)
> >> +#define ICH_LR3_EL2                  __LR0_EL2(3)
> >> +#define ICH_LR4_EL2                  __LR0_EL2(4)
> >> +#define ICH_LR5_EL2                  __LR0_EL2(5)
> >> +#define ICH_LR6_EL2                  __LR0_EL2(6)
> >> +#define ICH_LR7_EL2                  __LR0_EL2(7)
> >> +#define ICH_LR8_EL2                  __LR8_EL2(0)
> >> +#define ICH_LR9_EL2                  __LR8_EL2(1)
> >> +#define ICH_LR10_EL2                 __LR8_EL2(2)
> >> +#define ICH_LR11_EL2                 __LR8_EL2(3)
> >> +#define ICH_LR12_EL2                 __LR8_EL2(4)
> >> +#define ICH_LR13_EL2                 __LR8_EL2(5)
> >> +#define ICH_LR14_EL2                 __LR8_EL2(6)
> >> +#define ICH_LR15_EL2                 __LR8_EL2(7)
> >> +
> >> +#define __AP0Rx_EL2(x)                       S3_4_C12_C8_ ## x
> >> +#define ICH_AP0R0_EL2                        __AP0Rx_EL2(0)
> >> +#define ICH_AP0R1_EL2                        __AP0Rx_EL2(1)
> >> +#define ICH_AP0R2_EL2                        __AP0Rx_EL2(2)
> >> +#define ICH_AP0R3_EL2                        __AP0Rx_EL2(3)
> >> +
> >> +#define __AP1Rx_EL2(x)                       S3_4_C12_C9_ ## x
> >> +#define ICH_AP1R0_EL2                        __AP1Rx_EL2(0)
> >> +#define ICH_AP1R1_EL2                        __AP1Rx_EL2(1)
> >> +#define ICH_AP1R2_EL2                        __AP1Rx_EL2(2)
> >> +#define ICH_AP1R3_EL2                        __AP1Rx_EL2(3)
> >
> > That was fun to review.
> 
> If you think so, then you're ready to join the lucky team of madmen
> reviewing DT patches... ;-)
> 
I could not have been more sarcastic in that last comment.  It required
a full liter of Haagen-Dazs to get through.

-Christoffer
