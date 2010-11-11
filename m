From: kmpark@infradead.org (Kyungmin Park)
Date: Thu, 11 Nov 2010 17:46:46 +0900
Subject: [PATCH] ARM: Common GIC entry macro code V2
In-Reply-To: <20101111074955.29633.80160.sendpatchset@t400s>
References: <20101111074955.29633.80160.sendpatchset@t400s>
Message-ID: <AANLkTimJfZwRx_H4KC+WfXeYONiUMN39VfnT9R54Sh4c@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Can you include the "arch/arm/mach-s5pv310/include/mach/entry-macro.S" also?

Thank you,
Kyungmin Park

On Thu, Nov 11, 2010 at 4:49 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
> From: Magnus Damm <damm@opensource.se>
>
> This patch is the identical GIC demux implementation
> merge V2. Instead of implementing same code over and
> over simply share it in entry-macro-gic.S. The shared
> code is based on the realview implementation.
>
> Each GIC demux instance still has to setup the base address
> of the controller using the get_irqnr_preamble macro. The
> rest of the GIC specific code can be shared.
>
> The omap code is excluded due to complexity and lack of
> hardware - the CONFIG_SMP macros are used for multi-omap
> and the omap4 case - this makes is difficult to share code.
>
> The s5pv310 subarch is excluded due to the special "addne"
> instruction in the get_irqnr_and_base macro.
>
> The msm subarch is excluded as well since it treats PPIs
> differently than other platforms and needs a different
> version of the get_irqnr_and_base macro.
>
> Signed-off-by: Magnus Damm <damm@opensource.se>
> Acked-by: Srinidhi Kasagar<srinidhi.kasagar@stericsson.com>
> ---
>
> ?Changes since V1:
> ?- dropped msm as requested by Abhijeet, thank you.
>
> ?This patch is almost identical to 6284/1 in the RMKs patch
> ?tracker. The main difference is that this patch requires
> ?each platform to specify base address using the macro
> ?get_irqnr_preable. This patch includes tegra, but drops
> ?omap support due to multi-omap complexity.
>
> ?Thanks to Shilimkar, Santosh and Srinidhi Kasagar for feedback.
>
> ?arch/arm/include/asm/hardware/entry-macro-gic.S ? | ? 68 +++++++++++++++++++++
> ?arch/arm/mach-cns3xxx/include/mach/entry-macro.S ?| ? 61 ------------------
> ?arch/arm/mach-realview/include/mach/entry-macro.S | ? 60 ------------------
> ?arch/arm/mach-tegra/include/mach/entry-macro.S ? ?| ? 64 -------------------
> ?arch/arm/mach-ux500/include/mach/entry-macro.S ? ?| ? 67 --------------------
> ?arch/arm/mach-vexpress/include/mach/entry-macro.S | ? 57 -----------------
> ?6 files changed, 73 insertions(+), 304 deletions(-)
>
> --- /dev/null
> +++ work/arch/arm/include/asm/hardware/entry-macro-gic.S ? ? ? ?2010-11-10 16:06:26.000000000 +0900
> @@ -0,0 +1,68 @@
> +/*
> + * arch/arm/include/asm/hardware/entry-macro-gic.S
> + *
> + * Low-level IRQ helper macros for GIC
> + *
> + * This file is licensed under ?the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#include <asm/hardware/gic.h>
> +
> +/*
> + * The interrupt numbering scheme is defined in the
> + * interrupt controller spec. ?To wit:
> + *
> + * Interrupts 0-15 are IPI
> + * 16-28 are reserved
> + * 29-31 are local. ?We allow 30 to be used for the watchdog.
> + * 32-1020 are global
> + * 1021-1022 are reserved
> + * 1023 is "spurious" (no interrupt)
> + *
> + * For now, we ignore all local interrupts so only return an interrupt if it's
> + * between 30 and 1020. ?The test_for_ipi routine below will pick up on IPIs.
> + *
> + * A simple read from the controller will tell us the number of the highest
> + * priority enabled interrupt. ?We then just need to check whether it is in the
> + * valid range for an IRQ (30-1020 inclusive).
> + */
> +
> + ? ? ? .macro ?get_irqnr_and_base, irqnr, irqstat, base, tmp
> +
> + ? ? ? ldr ? ? \irqstat, [\base, #GIC_CPU_INTACK]
> + ? ? ? /* bits 12-10 = src CPU, 9-0 = int # */
> +
> + ? ? ? ldr ? ? \tmp, =1021
> + ? ? ? bic ? ? \irqnr, \irqstat, #0x1c00
> + ? ? ? cmp ? ? \irqnr, #29
> + ? ? ? cmpcc ? \irqnr, \irqnr
> + ? ? ? cmpne ? \irqnr, \tmp
> + ? ? ? cmpcs ? \irqnr, \irqnr
> + ? ? ? .endm
> +
> +/* We assume that irqstat (the raw value of the IRQ acknowledge
> + * register) is preserved from the macro above.
> + * If there is an IPI, we immediately signal end of interrupt on the
> + * controller, since this requires the original irqstat value which
> + * we won't easily be able to recreate later.
> + */
> +
> + ? ? ? .macro test_for_ipi, irqnr, irqstat, base, tmp
> + ? ? ? bic ? ? \irqnr, \irqstat, #0x1c00
> + ? ? ? cmp ? ? \irqnr, #16
> + ? ? ? strcc ? \irqstat, [\base, #GIC_CPU_EOI]
> + ? ? ? cmpcs ? \irqnr, \irqnr
> + ? ? ? .endm
> +
> +/* As above, this assumes that irqstat and base are preserved.. */
> +
> + ? ? ? .macro test_for_ltirq, irqnr, irqstat, base, tmp
> + ? ? ? bic ? ? \irqnr, \irqstat, #0x1c00
> + ? ? ? mov ? ? \tmp, #0
> + ? ? ? cmp ? ? \irqnr, #29
> + ? ? ? moveq ? \tmp, #1
> + ? ? ? streq ? \irqstat, [\base, #GIC_CPU_EOI]
> + ? ? ? cmp ? ? \tmp, #0
> + ? ? ? .endm
> --- 0001/arch/arm/mach-cns3xxx/include/mach/entry-macro.S
> +++ work/arch/arm/mach-cns3xxx/include/mach/entry-macro.S ? ? ? 2010-11-10 16:06:25.000000000 +0900
> @@ -9,7 +9,7 @@
> ?*/
>
> ?#include <mach/hardware.h>
> -#include <asm/hardware/gic.h>
> +#include <asm/hardware/entry-macro-gic.S>
>
> ? ? ? ? ? ? ? ?.macro ?disable_fiq
> ? ? ? ? ? ? ? ?.endm
> @@ -21,62 +21,3 @@
>
> ? ? ? ? ? ? ? ?.macro ?arch_ret_to_user, tmp1, tmp2
> ? ? ? ? ? ? ? ?.endm
> -
> - ? ? ? ? ? ? ? /*
> - ? ? ? ? ? ? ? ?* The interrupt numbering scheme is defined in the
> - ? ? ? ? ? ? ? ?* interrupt controller spec. ?To wit:
> - ? ? ? ? ? ? ? ?*
> - ? ? ? ? ? ? ? ?* Interrupts 0-15 are IPI
> - ? ? ? ? ? ? ? ?* 16-28 are reserved
> - ? ? ? ? ? ? ? ?* 29-31 are local. ?We allow 30 to be used for the watchdog.
> - ? ? ? ? ? ? ? ?* 32-1020 are global
> - ? ? ? ? ? ? ? ?* 1021-1022 are reserved
> - ? ? ? ? ? ? ? ?* 1023 is "spurious" (no interrupt)
> - ? ? ? ? ? ? ? ?*
> - ? ? ? ? ? ? ? ?* For now, we ignore all local interrupts so only return an interrupt if it's
> - ? ? ? ? ? ? ? ?* between 30 and 1020. ?The test_for_ipi routine below will pick up on IPIs.
> - ? ? ? ? ? ? ? ?*
> - ? ? ? ? ? ? ? ?* A simple read from the controller will tell us the number of the highest
> - ? ? ? ? ? ? ? ? * priority enabled interrupt. ?We then just need to check whether it is in the
> - ? ? ? ? ? ? ? ?* valid range for an IRQ (30-1020 inclusive).
> - ? ? ? ? ? ? ? ?*/
> -
> - ? ? ? ? ? ? ? .macro ?get_irqnr_and_base, irqnr, irqstat, base, tmp
> -
> - ? ? ? ? ? ? ? ldr ? ? \irqstat, [\base, #GIC_CPU_INTACK] /* bits 12-10 = src CPU, 9-0 = int # */
> -
> - ? ? ? ? ? ? ? ldr ? ? \tmp, =1021
> -
> - ? ? ? ? ? ? ? bic ? ? \irqnr, \irqstat, #0x1c00
> -
> - ? ? ? ? ? ? ? cmp ? ? \irqnr, #29
> - ? ? ? ? ? ? ? cmpcc ? \irqnr, \irqnr
> - ? ? ? ? ? ? ? cmpne ? \irqnr, \tmp
> - ? ? ? ? ? ? ? cmpcs ? \irqnr, \irqnr
> -
> - ? ? ? ? ? ? ? .endm
> -
> - ? ? ? ? ? ? ? /* We assume that irqstat (the raw value of the IRQ acknowledge
> - ? ? ? ? ? ? ? ?* register) is preserved from the macro above.
> - ? ? ? ? ? ? ? ?* If there is an IPI, we immediately signal end of interrupt on the
> - ? ? ? ? ? ? ? ?* controller, since this requires the original irqstat value which
> - ? ? ? ? ? ? ? ?* we won't easily be able to recreate later.
> - ? ? ? ? ? ? ? ?*/
> -
> - ? ? ? ? ? ? ? .macro test_for_ipi, irqnr, irqstat, base, tmp
> - ? ? ? ? ? ? ? bic ? ? \irqnr, \irqstat, #0x1c00
> - ? ? ? ? ? ? ? cmp ? ? \irqnr, #16
> - ? ? ? ? ? ? ? strcc ? \irqstat, [\base, #GIC_CPU_EOI]
> - ? ? ? ? ? ? ? cmpcs ? \irqnr, \irqnr
> - ? ? ? ? ? ? ? .endm
> -
> - ? ? ? ? ? ? ? /* As above, this assumes that irqstat and base are preserved.. */
> -
> - ? ? ? ? ? ? ? .macro test_for_ltirq, irqnr, irqstat, base, tmp
> - ? ? ? ? ? ? ? bic ? ? \irqnr, \irqstat, #0x1c00
> - ? ? ? ? ? ? ? mov ? ? \tmp, #0
> - ? ? ? ? ? ? ? cmp ? ? \irqnr, #29
> - ? ? ? ? ? ? ? moveq ? \tmp, #1
> - ? ? ? ? ? ? ? streq ? \irqstat, [\base, #GIC_CPU_EOI]
> - ? ? ? ? ? ? ? cmp ? ? \tmp, #0
> - ? ? ? ? ? ? ? .endm
> --- 0001/arch/arm/mach-realview/include/mach/entry-macro.S
> +++ work/arch/arm/mach-realview/include/mach/entry-macro.S ? ? ?2010-11-10 16:06:25.000000000 +0900
> @@ -8,7 +8,7 @@
> ?* warranty of any kind, whether express or implied.
> ?*/
> ?#include <mach/hardware.h>
> -#include <asm/hardware/gic.h>
> +#include <asm/hardware/entry-macro-gic.S>
>
> ? ? ? ? ? ? ? ?.macro ?disable_fiq
> ? ? ? ? ? ? ? ?.endm
> @@ -21,61 +21,3 @@
> ? ? ? ? ? ? ? ?.macro ?arch_ret_to_user, tmp1, tmp2
> ? ? ? ? ? ? ? ?.endm
>
> - ? ? ? ? ? ? ? /*
> - ? ? ? ? ? ? ? ?* The interrupt numbering scheme is defined in the
> - ? ? ? ? ? ? ? ?* interrupt controller spec. ?To wit:
> - ? ? ? ? ? ? ? ?*
> - ? ? ? ? ? ? ? ?* Interrupts 0-15 are IPI
> - ? ? ? ? ? ? ? ?* 16-28 are reserved
> - ? ? ? ? ? ? ? ?* 29-31 are local. ?We allow 30 to be used for the watchdog.
> - ? ? ? ? ? ? ? ?* 32-1020 are global
> - ? ? ? ? ? ? ? ?* 1021-1022 are reserved
> - ? ? ? ? ? ? ? ?* 1023 is "spurious" (no interrupt)
> - ? ? ? ? ? ? ? ?*
> - ? ? ? ? ? ? ? ?* For now, we ignore all local interrupts so only return an interrupt if it's
> - ? ? ? ? ? ? ? ?* between 30 and 1020. ?The test_for_ipi routine below will pick up on IPIs.
> - ? ? ? ? ? ? ? ?*
> - ? ? ? ? ? ? ? ?* A simple read from the controller will tell us the number of the highest
> - ? ? ? ? ? ? ? ? * priority enabled interrupt. ?We then just need to check whether it is in the
> - ? ? ? ? ? ? ? ?* valid range for an IRQ (30-1020 inclusive).
> - ? ? ? ? ? ? ? ?*/
> -
> - ? ? ? ? ? ? ? .macro ?get_irqnr_and_base, irqnr, irqstat, base, tmp
> -
> - ? ? ? ? ? ? ? ldr ? ? \irqstat, [\base, #GIC_CPU_INTACK] /* bits 12-10 = src CPU, 9-0 = int # */
> -
> - ? ? ? ? ? ? ? ldr ? ? \tmp, =1021
> -
> - ? ? ? ? ? ? ? bic ? ? \irqnr, \irqstat, #0x1c00
> -
> - ? ? ? ? ? ? ? cmp ? ? \irqnr, #29
> - ? ? ? ? ? ? ? cmpcc ? \irqnr, \irqnr
> - ? ? ? ? ? ? ? cmpne ? \irqnr, \tmp
> - ? ? ? ? ? ? ? cmpcs ? \irqnr, \irqnr
> -
> - ? ? ? ? ? ? ? .endm
> -
> - ? ? ? ? ? ? ? /* We assume that irqstat (the raw value of the IRQ acknowledge
> - ? ? ? ? ? ? ? ?* register) is preserved from the macro above.
> - ? ? ? ? ? ? ? ?* If there is an IPI, we immediately signal end of interrupt on the
> - ? ? ? ? ? ? ? ?* controller, since this requires the original irqstat value which
> - ? ? ? ? ? ? ? ?* we won't easily be able to recreate later.
> - ? ? ? ? ? ? ? ?*/
> -
> - ? ? ? ? ? ? ? .macro test_for_ipi, irqnr, irqstat, base, tmp
> - ? ? ? ? ? ? ? bic ? ? \irqnr, \irqstat, #0x1c00
> - ? ? ? ? ? ? ? cmp ? ? \irqnr, #16
> - ? ? ? ? ? ? ? strcc ? \irqstat, [\base, #GIC_CPU_EOI]
> - ? ? ? ? ? ? ? cmpcs ? \irqnr, \irqnr
> - ? ? ? ? ? ? ? .endm
> -
> - ? ? ? ? ? ? ? /* As above, this assumes that irqstat and base are preserved.. */
> -
> - ? ? ? ? ? ? ? .macro test_for_ltirq, irqnr, irqstat, base, tmp
> - ? ? ? ? ? ? ? bic ? ? \irqnr, \irqstat, #0x1c00
> - ? ? ? ? ? ? ? mov ? ? \tmp, #0
> - ? ? ? ? ? ? ? cmp ? ? \irqnr, #29
> - ? ? ? ? ? ? ? moveq ? \tmp, #1
> - ? ? ? ? ? ? ? streq ? \irqstat, [\base, #GIC_CPU_EOI]
> - ? ? ? ? ? ? ? cmp ? ? \tmp, #0
> - ? ? ? ? ? ? ? .endm
> --- 0001/arch/arm/mach-tegra/include/mach/entry-macro.S
> +++ work/arch/arm/mach-tegra/include/mach/entry-macro.S 2010-11-10 16:06:25.000000000 +0900
> @@ -17,7 +17,7 @@
>
> ?#if defined(CONFIG_ARM_GIC)
>
> -#include <asm/hardware/gic.h>
> +#include <asm/hardware/entry-macro-gic.S>
>
> ? ? ? ?/* Uses the GIC interrupt controller built into the cpu */
> ?#define ICTRL_BASE (IO_CPU_VIRT + 0x100)
> @@ -32,68 +32,6 @@
>
> ? ? ? ?.macro ?arch_ret_to_user, tmp1, tmp2
> ? ? ? ?.endm
> -
> - ? ? ? /*
> - ? ? ? ?* The interrupt numbering scheme is defined in the
> - ? ? ? ?* interrupt controller spec. ?To wit:
> - ? ? ? ?*
> - ? ? ? ?* Interrupts 0-15 are IPI
> - ? ? ? ?* 16-28 are reserved
> - ? ? ? ?* 29-31 are local. ?We allow 30 to be used for the watchdog.
> - ? ? ? ?* 32-1020 are global
> - ? ? ? ?* 1021-1022 are reserved
> - ? ? ? ?* 1023 is "spurious" (no interrupt)
> - ? ? ? ?*
> - ? ? ? ?* For now, we ignore all local interrupts so only return an interrupt
> - ? ? ? ?* if it's between 30 and 1020. ?The test_for_ipi routine below will
> - ? ? ? ?* pick up on IPIs.
> - ? ? ? ?*
> - ? ? ? ?* A simple read from the controller will tell us the number of the
> - ? ? ? ?* highest priority enabled interrupt. ?We then just need to check
> - ? ? ? ?* whether it is in the valid range for an IRQ (30-1020 inclusive).
> - ? ? ? ?*/
> -
> - ? ? ? .macro ?get_irqnr_and_base, irqnr, irqstat, base, tmp
> -
> - ? ? ? /* bits 12-10 = src CPU, 9-0 = int # */
> - ? ? ? ldr ? ? \irqstat, [\base, #GIC_CPU_INTACK]
> -
> - ? ? ? ldr ? ? ? ? ? ? \tmp, =1021
> -
> - ? ? ? bic ? ? \irqnr, \irqstat, #0x1c00
> -
> - ? ? ? cmp ? ? \irqnr, #29
> - ? ? ? cmpcc ? \irqnr, \irqnr
> - ? ? ? cmpne ? \irqnr, \tmp
> - ? ? ? cmpcs ? \irqnr, \irqnr
> -
> - ? ? ? .endm
> -
> - ? ? ? /* We assume that irqstat (the raw value of the IRQ acknowledge
> - ? ? ? ?* register) is preserved from the macro above.
> - ? ? ? ?* If there is an IPI, we immediately signal end of interrupt on the
> - ? ? ? ?* controller, since this requires the original irqstat value which
> - ? ? ? ?* we won't easily be able to recreate later.
> - ? ? ? ?*/
> -
> - ? ? ? .macro test_for_ipi, irqnr, irqstat, base, tmp
> - ? ? ? bic ? ? \irqnr, \irqstat, #0x1c00
> - ? ? ? cmp ? ? \irqnr, #16
> - ? ? ? strcc ? \irqstat, [\base, #GIC_CPU_EOI]
> - ? ? ? cmpcs ? \irqnr, \irqnr
> - ? ? ? .endm
> -
> - ? ? ? /* As above, this assumes that irqstat and base are preserved.. */
> -
> - ? ? ? .macro test_for_ltirq, irqnr, irqstat, base, tmp
> - ? ? ? bic ? ? \irqnr, \irqstat, #0x1c00
> - ? ? ? mov ? ? \tmp, #0
> - ? ? ? cmp ? ? \irqnr, #29
> - ? ? ? moveq ? \tmp, #1
> - ? ? ? streq ? \irqstat, [\base, #GIC_CPU_EOI]
> - ? ? ? cmp ? ? \tmp, #0
> - ? ? ? .endm
> -
> ?#else
> ? ? ? ?/* legacy interrupt controller for AP16 */
> ? ? ? ?.macro ?disable_fiq
> --- 0001/arch/arm/mach-ux500/include/mach/entry-macro.S
> +++ work/arch/arm/mach-ux500/include/mach/entry-macro.S 2010-11-10 16:06:25.000000000 +0900
> @@ -11,7 +11,7 @@
> ?* warranty of any kind, whether express or implied.
> ?*/
> ?#include <mach/hardware.h>
> -#include <asm/hardware/gic.h>
> +#include <asm/hardware/entry-macro-gic.S>
>
> ? ? ? ? ? ? ? ?.macro ?disable_fiq
> ? ? ? ? ? ? ? ?.endm
> @@ -22,68 +22,3 @@
>
> ? ? ? ? ? ? ? ?.macro ?arch_ret_to_user, tmp1, tmp2
> ? ? ? ? ? ? ? ?.endm
> -
> - ? ? ? ? ? ? ? /*
> - ? ? ? ? ? ? ? ?* The interrupt numbering scheme is defined in the
> - ? ? ? ? ? ? ? ?* interrupt controller spec. ?To wit:
> - ? ? ? ? ? ? ? ?*
> - ? ? ? ? ? ? ? ?* Interrupts 0-15 are IPI
> - ? ? ? ? ? ? ? ?* 16-28 are reserved
> - ? ? ? ? ? ? ? ?* 29-31 are local. ?We allow 30 to be used for the watchdog.
> - ? ? ? ? ? ? ? ?* 32-1020 are global
> - ? ? ? ? ? ? ? ?* 1021-1022 are reserved
> - ? ? ? ? ? ? ? ?* 1023 is "spurious" (no interrupt)
> - ? ? ? ? ? ? ? ?*
> - ? ? ? ? ? ? ? ?* For now, we ignore all local interrupts so only return an
> - ? ? ? ? ? ? ? ?* interrupt if it's between 30 and 1020. The test_for_ipi
> - ? ? ? ? ? ? ? ?* routine below will pick up on IPIs.
> - ? ? ? ? ? ? ? ?*
> - ? ? ? ? ? ? ? ?* A simple read from the controller will tell us the number
> - ? ? ? ? ? ? ? ?* of the highest priority enabled interrupt. We then just
> - ? ? ? ? ? ? ? ?* need to check whether it is in the valid range for an
> - ? ? ? ? ? ? ? ?* IRQ (30-1020 inclusive).
> - ? ? ? ? ? ? ? ?*/
> -
> - ? ? ? ? ? ? ? .macro ?get_irqnr_and_base, irqnr, irqstat, base, tmp
> -
> - ? ? ? ? ? ? ? /* bits 12-10 = src CPU, 9-0 = int # */
> - ? ? ? ? ? ? ? ldr ? ? \irqstat, [\base, #GIC_CPU_INTACK]
> -
> - ? ? ? ? ? ? ? ldr ? ? \tmp, =1021
> -
> - ? ? ? ? ? ? ? bic ? ? \irqnr, \irqstat, #0x1c00
> -
> - ? ? ? ? ? ? ? cmp ? ? \irqnr, #29
> - ? ? ? ? ? ? ? cmpcc ? \irqnr, \irqnr
> - ? ? ? ? ? ? ? cmpne ? \irqnr, \tmp
> - ? ? ? ? ? ? ? cmpcs ? \irqnr, \irqnr
> -
> - ? ? ? ? ? ? ? .endm
> -
> - ? ? ? ? ? ? ? /* We assume that irqstat (the raw value of the IRQ
> - ? ? ? ? ? ? ? ?* acknowledge register) is preserved from the macro above.
> - ? ? ? ? ? ? ? ?* If there is an IPI, we immediately signal end of
> - ? ? ? ? ? ? ? ?* interrupt on the controller, since this requires the
> - ? ? ? ? ? ? ? ?* original irqstat value which we won't easily be able
> - ? ? ? ? ? ? ? ?* to recreate later.
> - ? ? ? ? ? ? ? ?*/
> -
> - ? ? ? ? ? ? ? .macro test_for_ipi, irqnr, irqstat, base, tmp
> - ? ? ? ? ? ? ? bic ? ? \irqnr, \irqstat, #0x1c00
> - ? ? ? ? ? ? ? cmp ? ? \irqnr, #16
> - ? ? ? ? ? ? ? strcc ? \irqstat, [\base, #GIC_CPU_EOI]
> - ? ? ? ? ? ? ? cmpcs ? \irqnr, \irqnr
> - ? ? ? ? ? ? ? .endm
> -
> - ? ? ? ? ? ? ? /* As above, this assumes that irqstat and base
> - ? ? ? ? ? ? ? ?* are preserved..
> - ? ? ? ? ? ? ? ?*/
> -
> - ? ? ? ? ? ? ? .macro test_for_ltirq, irqnr, irqstat, base, tmp
> - ? ? ? ? ? ? ? bic ? ? \irqnr, \irqstat, #0x1c00
> - ? ? ? ? ? ? ? mov ? ? \tmp, #0
> - ? ? ? ? ? ? ? cmp ? ? \irqnr, #29
> - ? ? ? ? ? ? ? moveq ? \tmp, #1
> - ? ? ? ? ? ? ? streq ? \irqstat, [\base, #GIC_CPU_EOI]
> - ? ? ? ? ? ? ? cmp ? ? \tmp, #0
> - ? ? ? ? ? ? ? .endm
> --- 0001/arch/arm/mach-vexpress/include/mach/entry-macro.S
> +++ work/arch/arm/mach-vexpress/include/mach/entry-macro.S ? ? ?2010-11-10 16:06:25.000000000 +0900
> @@ -1,4 +1,4 @@
> -#include <asm/hardware/gic.h>
> +#include <asm/hardware/entry-macro-gic.S>
>
> ? ? ? ?.macro ?disable_fiq
> ? ? ? ?.endm
> @@ -10,58 +10,3 @@
>
> ? ? ? ?.macro ?arch_ret_to_user, tmp1, tmp2
> ? ? ? ?.endm
> -
> - ? ? ? /*
> - ? ? ? ?* The interrupt numbering scheme is defined in the
> - ? ? ? ?* interrupt controller spec. ?To wit:
> - ? ? ? ?*
> - ? ? ? ?* Interrupts 0-15 are IPI
> - ? ? ? ?* 16-28 are reserved
> - ? ? ? ?* 29-31 are local. ?We allow 30 to be used for the watchdog.
> - ? ? ? ?* 32-1020 are global
> - ? ? ? ?* 1021-1022 are reserved
> - ? ? ? ?* 1023 is "spurious" (no interrupt)
> - ? ? ? ?*
> - ? ? ? ?* For now, we ignore all local interrupts so only return an interrupt if it's
> - ? ? ? ?* between 30 and 1020. ?The test_for_ipi routine below will pick up on IPIs.
> - ? ? ? ?*
> - ? ? ? ?* A simple read from the controller will tell us the number of the highest
> - ? ? ? ?* priority enabled interrupt. ?We then just need to check whether it is in the
> - ? ? ? ?* valid range for an IRQ (30-1020 inclusive).
> - ? ? ? ?*/
> -
> - ? ? ? .macro ?get_irqnr_and_base, irqnr, irqstat, base, tmp
> - ? ? ? ldr ? ? \irqstat, [\base, #GIC_CPU_INTACK] /* bits 12-10 = src CPU, 9-0 = int # */
> - ? ? ? ldr ? ? \tmp, =1021
> - ? ? ? bic ? ? \irqnr, \irqstat, #0x1c00
> - ? ? ? cmp ? ? \irqnr, #29
> - ? ? ? cmpcc ? \irqnr, \irqnr
> - ? ? ? cmpne ? \irqnr, \tmp
> - ? ? ? cmpcs ? \irqnr, \irqnr
> - ? ? ? .endm
> -
> - ? ? ? /* We assume that irqstat (the raw value of the IRQ acknowledge
> - ? ? ? ?* register) is preserved from the macro above.
> - ? ? ? ?* If there is an IPI, we immediately signal end of interrupt on the
> - ? ? ? ?* controller, since this requires the original irqstat value which
> - ? ? ? ?* we won't easily be able to recreate later.
> - ? ? ? ?*/
> -
> - ? ? ? .macro test_for_ipi, irqnr, irqstat, base, tmp
> - ? ? ? bic ? ? \irqnr, \irqstat, #0x1c00
> - ? ? ? cmp ? ? \irqnr, #16
> - ? ? ? strcc ? \irqstat, [\base, #GIC_CPU_EOI]
> - ? ? ? cmpcs ? \irqnr, \irqnr
> - ? ? ? .endm
> -
> - ? ? ? /* As above, this assumes that irqstat and base are preserved.. */
> -
> - ? ? ? .macro test_for_ltirq, irqnr, irqstat, base, tmp
> - ? ? ? bic ? ? \irqnr, \irqstat, #0x1c00
> - ? ? ? mov ? ? \tmp, #0
> - ? ? ? cmp ? ? \irqnr, #29
> - ? ? ? moveq ? \tmp, #1
> - ? ? ? streq ? \irqstat, [\base, #GIC_CPU_EOI]
> - ? ? ? cmp ? ? \tmp, #0
> - ? ? ? .endm
> -
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
