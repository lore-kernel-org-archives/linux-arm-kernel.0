From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Wed, 10 Nov 2010 12:46:09 +0530
Subject: [PATCH] ARM: Common GIC entry macro code
In-Reply-To: <20101110070043.18735.53764.sendpatchset@t400s>
References: <20101110070043.18735.53764.sendpatchset@t400s>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB030D4FAF4A@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-
> kernel-bounces at lists.infradead.org] On Behalf Of Magnus Damm
> Sent: Wednesday, November 10, 2010 12:31 PM
> To: linux at arm.linux.org.uk
> Cc: tony at atomide.com; kgene.kim at samsung.com; Magnus Damm; linux-arm-
> kernel at lists.infradead.org
> Subject: [PATCH] ARM: Common GIC entry macro code
>
> From: Magnus Damm <damm@opensource.se>
>
> This patch merges identical GIC demux implementations
> in the file entry-macro-gic.S. The shared code in the
> header file is based on the realview implementation.
>
> Each GIC demux instance still has to setup the base address
> of the controller using the get_irqnr_preamble macro. The
> rest of the GIC specific code can be shared.
>
> The omap code is excluded due to multi-omap complexity
> and s5pv310 is excluded as well due to the special
> "addne" instruction in the get_irqnr_and_base macro.
>
I guess this was attempted by below patch as well.
http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=6284%2F1

6284/1 in the RMKs patch system. This was also addressing OMAP and the
patch was tested OK.

Looks like it needs to be rebased because the state I see in the patch
System is

- - Note 2 submitted by Russell King on 02 Sep 2010 15:43:12 (UTC) - - -
Moved to Discarded.

Doesn't apply:


> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
>
>  arch/arm/include/asm/hardware/entry-macro-gic.S   |   68
> +++++++++++++++++++++
>  arch/arm/mach-cns3xxx/include/mach/entry-macro.S  |   61 ----------------
> --
>  arch/arm/mach-msm/include/mach/entry-macro-qgic.S |   67 ----------------
> ----
>  arch/arm/mach-realview/include/mach/entry-macro.S |   60 ----------------
> --
>  arch/arm/mach-tegra/include/mach/entry-macro.S    |   64 ----------------
> ---
>  arch/arm/mach-ux500/include/mach/entry-macro.S    |   67 ----------------
> ----
>  arch/arm/mach-vexpress/include/mach/entry-macro.S |   57 ----------------
> -
>  7 files changed, 74 insertions(+), 370 deletions(-)
>
> --- /dev/null
> +++ work/arch/arm/include/asm/hardware/entry-macro-gic.S      2010-11-10
> 15:20:15.000000000 +0900
> @@ -0,0 +1,68 @@
> +/*
> + * arch/arm/include/asm/hardware/entry-macro-gic.S
> + *
> + * Low-level IRQ helper macros for GIC
> + *
> + * This file is licensed under  the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#include <asm/hardware/gic.h>
> +
> +/*
> + * The interrupt numbering scheme is defined in the
> + * interrupt controller spec.  To wit:
> + *
> + * Interrupts 0-15 are IPI
> + * 16-28 are reserved
> + * 29-31 are local.  We allow 30 to be used for the watchdog.
> + * 32-1020 are global
> + * 1021-1022 are reserved
> + * 1023 is "spurious" (no interrupt)
> + *
> + * For now, we ignore all local interrupts so only return an interrupt if
> it's
> + * between 30 and 1020.  The test_for_ipi routine below will pick up on
> IPIs.
> + *
> + * A simple read from the controller will tell us the number of the
> highest
> + * priority enabled interrupt.  We then just need to check whether it is
> in the
> + * valid range for an IRQ (30-1020 inclusive).
> + */
> +
> +     .macro  get_irqnr_and_base, irqnr, irqstat, base, tmp
> +
> +     ldr     \irqstat, [\base, #GIC_CPU_INTACK]
> +     /* bits 12-10 = src CPU, 9-0 = int # */
> +
> +     ldr     \tmp, =1021
> +     bic     \irqnr, \irqstat, #0x1c00
> +     cmp     \irqnr, #29
> +     cmpcc   \irqnr, \irqnr
> +     cmpne   \irqnr, \tmp
> +     cmpcs   \irqnr, \irqnr
> +     .endm
> +
> +/* We assume that irqstat (the raw value of the IRQ acknowledge
> + * register) is preserved from the macro above.
> + * If there is an IPI, we immediately signal end of interrupt on the
> + * controller, since this requires the original irqstat value which
> + * we won't easily be able to recreate later.
> + */
> +
> +     .macro test_for_ipi, irqnr, irqstat, base, tmp
> +     bic     \irqnr, \irqstat, #0x1c00
> +     cmp     \irqnr, #16
> +     strcc   \irqstat, [\base, #GIC_CPU_EOI]
> +     cmpcs   \irqnr, \irqnr
> +     .endm
> +
> +/* As above, this assumes that irqstat and base are preserved.. */
> +
> +     .macro test_for_ltirq, irqnr, irqstat, base, tmp
> +     bic     \irqnr, \irqstat, #0x1c00
> +     mov     \tmp, #0
> +     cmp     \irqnr, #29
> +     moveq   \tmp, #1
> +     streq   \irqstat, [\base, #GIC_CPU_EOI]
> +     cmp     \tmp, #0
> +     .endm
> --- 0001/arch/arm/mach-cns3xxx/include/mach/entry-macro.S
> +++ work/arch/arm/mach-cns3xxx/include/mach/entry-macro.S     2010-11-10
> 15:24:56.000000000 +0900
> @@ -9,7 +9,7 @@
>   */
>
>  #include <mach/hardware.h>
> -#include <asm/hardware/gic.h>
> +#include <asm/hardware/entry-macro-gic.S>
>
>               .macro  disable_fiq
>               .endm
> @@ -21,62 +21,3 @@
>
>               .macro  arch_ret_to_user, tmp1, tmp2
>               .endm
> -
> -             /*
> -              * The interrupt numbering scheme is defined in the
> -              * interrupt controller spec.  To wit:
> -              *
> -              * Interrupts 0-15 are IPI
> -              * 16-28 are reserved
> -              * 29-31 are local.  We allow 30 to be used for the watchdog.
> -              * 32-1020 are global
> -              * 1021-1022 are reserved
> -              * 1023 is "spurious" (no interrupt)
> -              *
> -              * For now, we ignore all local interrupts so only return an
> interrupt if it's
> -              * between 30 and 1020.  The test_for_ipi routine below will
> pick up on IPIs.
> -              *
> -              * A simple read from the controller will tell us the number
> of the highest
> -                 * priority enabled interrupt.  We then just need to
> check whether it is in the
> -              * valid range for an IRQ (30-1020 inclusive).
> -              */
> -
> -             .macro  get_irqnr_and_base, irqnr, irqstat, base, tmp
> -
> -             ldr     \irqstat, [\base, #GIC_CPU_INTACK] /* bits 12-10 = src
> CPU, 9-0 = int # */
> -
> -             ldr     \tmp, =1021
> -
> -             bic     \irqnr, \irqstat, #0x1c00
> -
> -             cmp     \irqnr, #29
> -             cmpcc   \irqnr, \irqnr
> -             cmpne   \irqnr, \tmp
> -             cmpcs   \irqnr, \irqnr
> -
> -             .endm
> -
> -             /* We assume that irqstat (the raw value of the IRQ
> acknowledge
> -              * register) is preserved from the macro above.
> -              * If there is an IPI, we immediately signal end of interrupt
> on the
> -              * controller, since this requires the original irqstat value
> which
> -              * we won't easily be able to recreate later.
> -              */
> -
> -             .macro test_for_ipi, irqnr, irqstat, base, tmp
> -             bic     \irqnr, \irqstat, #0x1c00
> -             cmp     \irqnr, #16
> -             strcc   \irqstat, [\base, #GIC_CPU_EOI]
> -             cmpcs   \irqnr, \irqnr
> -             .endm
> -
> -             /* As above, this assumes that irqstat and base are preserved..
> */
> -
> -             .macro test_for_ltirq, irqnr, irqstat, base, tmp
> -             bic     \irqnr, \irqstat, #0x1c00
> -             mov     \tmp, #0
> -             cmp     \irqnr, #29
> -             moveq   \tmp, #1
> -             streq   \irqstat, [\base, #GIC_CPU_EOI]
> -             cmp     \tmp, #0
> -             .endm
> --- 0001/arch/arm/mach-msm/include/mach/entry-macro-qgic.S
> +++ work/arch/arm/mach-msm/include/mach/entry-macro-qgic.S    2010-11-10
> 15:27:06.000000000 +0900
> @@ -9,7 +9,7 @@
>   */
>
>  #include <mach/hardware.h>
> -#include <asm/hardware/gic.h>
> +#include <asm/hardware/entry-macro-gic.S>
>
>       .macro  disable_fiq
>       .endm
> @@ -21,68 +21,3 @@
>
>       .macro  arch_ret_to_user, tmp1, tmp2
>       .endm
> -
> -     /*
> -      * The interrupt numbering scheme is defined in the
> -      * interrupt controller spec.  To wit:
> -      *
> -      * Migrated the code from ARM MP port to be more consistant
> -      * with interrupt processing , the following still holds true
> -      * however, all interrupts are treated the same regardless of
> -      * if they are local IPI or PPI
> -      *
> -      * Interrupts 0-15 are IPI
> -      * 16-31 are PPI
> -      *   (16-18 are the timers)
> -      * 32-1020 are global
> -      * 1021-1022 are reserved
> -      * 1023 is "spurious" (no interrupt)
> -      *
> -      * A simple read from the controller will tell us the number of the
> -      * highest priority enabled interrupt.  We then just need to check
> -      * whether it is in the valid range for an IRQ (0-1020 inclusive).
> -      *
> -      * Base ARM code assumes that the local (private) peripheral
> interrupts
> -      * are not valid, we treat them differently, in that the privates
> are
> -      * handled like normal shared interrupts with the exception that
> only
> -      * one processor can register the interrupt and the handler must be
> -      * the same for all processors.
> -      */
> -
> -     .macro  get_irqnr_and_base, irqnr, irqstat, base, tmp
> -
> -     ldr  \irqstat, [\base, #GIC_CPU_INTACK] /* bits 12-10 =srcCPU,
> -                                                9-0 =int # */
> -
> -     bic     \irqnr, \irqstat, #0x1c00       @mask src
> -     cmp     \irqnr, #15
> -     ldr             \tmp, =1021
> -     cmpcc   \irqnr, \irqnr
> -     cmpne   \irqnr, \tmp
> -     cmpcs   \irqnr, \irqnr
> -
> -     .endm
> -
> -     /* We assume that irqstat (the raw value of the IRQ acknowledge
> -      * register) is preserved from the macro above.
> -      * If there is an IPI, we immediately signal end of interrupt on the
> -      * controller, since this requires the original irqstat value which
> -      * we won't easily be able to recreate later.
> -      */
> -     .macro test_for_ipi, irqnr, irqstat, base, tmp
> -    bic \irqnr, \irqstat, #0x1c00
> -    cmp \irqnr, #16
> -    strcc   \irqstat, [\base, #GIC_CPU_EOI]
> -    cmpcs   \irqnr, \irqnr
> -     .endm
> -
> -     /* As above, this assumes that irqstat and base are preserved.. */
> -
> -     .macro test_for_ltirq, irqnr, irqstat, base, tmp
> -    bic \irqnr, \irqstat, #0x1c00
> -    mov     \tmp, #0
> -    cmp \irqnr, #16
> -    moveq   \tmp, #1
> -    streq   \irqstat, [\base, #GIC_CPU_EOI]
> -    cmp \tmp, #0
> -     .endm
> --- 0001/arch/arm/mach-realview/include/mach/entry-macro.S
> +++ work/arch/arm/mach-realview/include/mach/entry-macro.S    2010-11-10
> 15:14:41.000000000 +0900
> @@ -8,7 +8,7 @@
>   * warranty of any kind, whether express or implied.
>   */
>  #include <mach/hardware.h>
> -#include <asm/hardware/gic.h>
> +#include <asm/hardware/entry-macro-gic.S>
>
>               .macro  disable_fiq
>               .endm
> @@ -21,61 +21,3 @@
>               .macro  arch_ret_to_user, tmp1, tmp2
>               .endm
>
> -             /*
> -              * The interrupt numbering scheme is defined in the
> -              * interrupt controller spec.  To wit:
> -              *
> -              * Interrupts 0-15 are IPI
> -              * 16-28 are reserved
> -              * 29-31 are local.  We allow 30 to be used for the watchdog.
> -              * 32-1020 are global
> -              * 1021-1022 are reserved
> -              * 1023 is "spurious" (no interrupt)
> -              *
> -              * For now, we ignore all local interrupts so only return an
> interrupt if it's
> -              * between 30 and 1020.  The test_for_ipi routine below will
> pick up on IPIs.
> -              *
> -              * A simple read from the controller will tell us the number
> of the highest
> -                 * priority enabled interrupt.  We then just need to
> check whether it is in the
> -              * valid range for an IRQ (30-1020 inclusive).
> -              */
> -
> -             .macro  get_irqnr_and_base, irqnr, irqstat, base, tmp
> -
> -             ldr     \irqstat, [\base, #GIC_CPU_INTACK] /* bits 12-10 = src
> CPU, 9-0 = int # */
> -
> -             ldr     \tmp, =1021
> -
> -             bic     \irqnr, \irqstat, #0x1c00
> -
> -             cmp     \irqnr, #29
> -             cmpcc   \irqnr, \irqnr
> -             cmpne   \irqnr, \tmp
> -             cmpcs   \irqnr, \irqnr
> -
> -             .endm
> -
> -             /* We assume that irqstat (the raw value of the IRQ
> acknowledge
> -              * register) is preserved from the macro above.
> -              * If there is an IPI, we immediately signal end of interrupt
> on the
> -              * controller, since this requires the original irqstat value
> which
> -              * we won't easily be able to recreate later.
> -              */
> -
> -             .macro test_for_ipi, irqnr, irqstat, base, tmp
> -             bic     \irqnr, \irqstat, #0x1c00
> -             cmp     \irqnr, #16
> -             strcc   \irqstat, [\base, #GIC_CPU_EOI]
> -             cmpcs   \irqnr, \irqnr
> -             .endm
> -
> -             /* As above, this assumes that irqstat and base are preserved..
> */
> -
> -             .macro test_for_ltirq, irqnr, irqstat, base, tmp
> -             bic     \irqnr, \irqstat, #0x1c00
> -             mov     \tmp, #0
> -             cmp     \irqnr, #29
> -             moveq   \tmp, #1
> -             streq   \irqstat, [\base, #GIC_CPU_EOI]
> -             cmp     \tmp, #0
> -             .endm
> --- 0001/arch/arm/mach-tegra/include/mach/entry-macro.S
> +++ work/arch/arm/mach-tegra/include/mach/entry-macro.S       2010-11-10
> 15:28:39.000000000 +0900
> @@ -17,7 +17,7 @@
>
>  #if defined(CONFIG_ARM_GIC)
>
> -#include <asm/hardware/gic.h>
> +#include <asm/hardware/entry-macro-gic.S>
>
>       /* Uses the GIC interrupt controller built into the cpu */
>  #define ICTRL_BASE (IO_CPU_VIRT + 0x100)
> @@ -32,68 +32,6 @@
>
>       .macro  arch_ret_to_user, tmp1, tmp2
>       .endm
> -
> -     /*
> -      * The interrupt numbering scheme is defined in the
> -      * interrupt controller spec.  To wit:
> -      *
> -      * Interrupts 0-15 are IPI
> -      * 16-28 are reserved
> -      * 29-31 are local.  We allow 30 to be used for the watchdog.
> -      * 32-1020 are global
> -      * 1021-1022 are reserved
> -      * 1023 is "spurious" (no interrupt)
> -      *
> -      * For now, we ignore all local interrupts so only return an
> interrupt
> -      * if it's between 30 and 1020.  The test_for_ipi routine below will
> -      * pick up on IPIs.
> -      *
> -      * A simple read from the controller will tell us the number of the
> -      * highest priority enabled interrupt.  We then just need to check
> -      * whether it is in the valid range for an IRQ (30-1020 inclusive).
> -      */
> -
> -     .macro  get_irqnr_and_base, irqnr, irqstat, base, tmp
> -
> -     /* bits 12-10 = src CPU, 9-0 = int # */
> -     ldr     \irqstat, [\base, #GIC_CPU_INTACK]
> -
> -     ldr             \tmp, =1021
> -
> -     bic     \irqnr, \irqstat, #0x1c00
> -
> -     cmp     \irqnr, #29
> -     cmpcc   \irqnr, \irqnr
> -     cmpne   \irqnr, \tmp
> -     cmpcs   \irqnr, \irqnr
> -
> -     .endm
> -
> -     /* We assume that irqstat (the raw value of the IRQ acknowledge
> -      * register) is preserved from the macro above.
> -      * If there is an IPI, we immediately signal end of interrupt on the
> -      * controller, since this requires the original irqstat value which
> -      * we won't easily be able to recreate later.
> -      */
> -
> -     .macro test_for_ipi, irqnr, irqstat, base, tmp
> -     bic     \irqnr, \irqstat, #0x1c00
> -     cmp     \irqnr, #16
> -     strcc   \irqstat, [\base, #GIC_CPU_EOI]
> -     cmpcs   \irqnr, \irqnr
> -     .endm
> -
> -     /* As above, this assumes that irqstat and base are preserved.. */
> -
> -     .macro test_for_ltirq, irqnr, irqstat, base, tmp
> -     bic     \irqnr, \irqstat, #0x1c00
> -     mov     \tmp, #0
> -     cmp     \irqnr, #29
> -     moveq   \tmp, #1
> -     streq   \irqstat, [\base, #GIC_CPU_EOI]
> -     cmp     \tmp, #0
> -     .endm
> -
>  #else
>       /* legacy interrupt controller for AP16 */
>       .macro  disable_fiq
> --- 0001/arch/arm/mach-ux500/include/mach/entry-macro.S
> +++ work/arch/arm/mach-ux500/include/mach/entry-macro.S       2010-11-10
> 15:23:50.000000000 +0900
> @@ -11,7 +11,7 @@
>   * warranty of any kind, whether express or implied.
>   */
>  #include <mach/hardware.h>
> -#include <asm/hardware/gic.h>
> +#include <asm/hardware/entry-macro-gic.S>
>
>               .macro  disable_fiq
>               .endm
> @@ -22,68 +22,3 @@
>
>               .macro  arch_ret_to_user, tmp1, tmp2
>               .endm
> -
> -             /*
> -              * The interrupt numbering scheme is defined in the
> -              * interrupt controller spec.  To wit:
> -              *
> -              * Interrupts 0-15 are IPI
> -              * 16-28 are reserved
> -              * 29-31 are local.  We allow 30 to be used for the watchdog.
> -              * 32-1020 are global
> -              * 1021-1022 are reserved
> -              * 1023 is "spurious" (no interrupt)
> -              *
> -              * For now, we ignore all local interrupts so only return an
> -              * interrupt if it's between 30 and 1020. The test_for_ipi
> -              * routine below will pick up on IPIs.
> -              *
> -              * A simple read from the controller will tell us the number
> -              * of the highest priority enabled interrupt. We then just
> -              * need to check whether it is in the valid range for an
> -              * IRQ (30-1020 inclusive).
> -              */
> -
> -             .macro  get_irqnr_and_base, irqnr, irqstat, base, tmp
> -
> -             /* bits 12-10 = src CPU, 9-0 = int # */
> -             ldr     \irqstat, [\base, #GIC_CPU_INTACK]
> -
> -             ldr     \tmp, =1021
> -
> -             bic     \irqnr, \irqstat, #0x1c00
> -
> -             cmp     \irqnr, #29
> -             cmpcc   \irqnr, \irqnr
> -             cmpne   \irqnr, \tmp
> -             cmpcs   \irqnr, \irqnr
> -
> -             .endm
> -
> -             /* We assume that irqstat (the raw value of the IRQ
> -              * acknowledge register) is preserved from the macro above.
> -              * If there is an IPI, we immediately signal end of
> -              * interrupt on the controller, since this requires the
> -              * original irqstat value which we won't easily be able
> -              * to recreate later.
> -              */
> -
> -             .macro test_for_ipi, irqnr, irqstat, base, tmp
> -             bic     \irqnr, \irqstat, #0x1c00
> -             cmp     \irqnr, #16
> -             strcc   \irqstat, [\base, #GIC_CPU_EOI]
> -             cmpcs   \irqnr, \irqnr
> -             .endm
> -
> -             /* As above, this assumes that irqstat and base
> -              * are preserved..
> -              */
> -
> -             .macro test_for_ltirq, irqnr, irqstat, base, tmp
> -             bic     \irqnr, \irqstat, #0x1c00
> -             mov     \tmp, #0
> -             cmp     \irqnr, #29
> -             moveq   \tmp, #1
> -             streq   \irqstat, [\base, #GIC_CPU_EOI]
> -             cmp     \tmp, #0
> -             .endm
> --- 0001/arch/arm/mach-vexpress/include/mach/entry-macro.S
> +++ work/arch/arm/mach-vexpress/include/mach/entry-macro.S    2010-11-10
> 15:22:09.000000000 +0900
> @@ -1,4 +1,4 @@
> -#include <asm/hardware/gic.h>
> +#include <asm/hardware/entry-macro-gic.S>
>
>       .macro  disable_fiq
>       .endm
> @@ -10,58 +10,3 @@
>
>       .macro  arch_ret_to_user, tmp1, tmp2
>       .endm
> -
> -     /*
> -      * The interrupt numbering scheme is defined in the
> -      * interrupt controller spec.  To wit:
> -      *
> -      * Interrupts 0-15 are IPI
> -      * 16-28 are reserved
> -      * 29-31 are local.  We allow 30 to be used for the watchdog.
> -      * 32-1020 are global
> -      * 1021-1022 are reserved
> -      * 1023 is "spurious" (no interrupt)
> -      *
> -      * For now, we ignore all local interrupts so only return an
> interrupt if it's
> -      * between 30 and 1020.  The test_for_ipi routine below will pick up
> on IPIs.
> -      *
> -      * A simple read from the controller will tell us the number of the
> highest
> -      * priority enabled interrupt.  We then just need to check whether
> it is in the
> -      * valid range for an IRQ (30-1020 inclusive).
> -      */
> -
> -     .macro  get_irqnr_and_base, irqnr, irqstat, base, tmp
> -     ldr     \irqstat, [\base, #GIC_CPU_INTACK] /* bits 12-10 = src CPU,
> 9-0 = int # */
> -     ldr     \tmp, =1021
> -     bic     \irqnr, \irqstat, #0x1c00
> -     cmp     \irqnr, #29
> -     cmpcc   \irqnr, \irqnr
> -     cmpne   \irqnr, \tmp
> -     cmpcs   \irqnr, \irqnr
> -     .endm
> -
> -     /* We assume that irqstat (the raw value of the IRQ acknowledge
> -      * register) is preserved from the macro above.
> -      * If there is an IPI, we immediately signal end of interrupt on the
> -      * controller, since this requires the original irqstat value which
> -      * we won't easily be able to recreate later.
> -      */
> -
> -     .macro test_for_ipi, irqnr, irqstat, base, tmp
> -     bic     \irqnr, \irqstat, #0x1c00
> -     cmp     \irqnr, #16
> -     strcc   \irqstat, [\base, #GIC_CPU_EOI]
> -     cmpcs   \irqnr, \irqnr
> -     .endm
> -
> -     /* As above, this assumes that irqstat and base are preserved.. */
> -
> -     .macro test_for_ltirq, irqnr, irqstat, base, tmp
> -     bic     \irqnr, \irqstat, #0x1c00
> -     mov     \tmp, #0
> -     cmp     \irqnr, #29
> -     moveq   \tmp, #1
> -     streq   \irqstat, [\base, #GIC_CPU_EOI]
> -     cmp     \tmp, #0
> -     .endm
> -
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
