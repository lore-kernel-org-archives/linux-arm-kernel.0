From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  3 Jun 2011 15:15:56 +0100
Subject: [PATCH v6 12/14] ARM: gic: add compute_irqnr macro for exynos4
In-Reply-To: <1307110558-29710-1-git-send-email-marc.zyngier@arm.com>
References: <1307110558-29710-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1307110558-29710-13-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

exynos4 has a full copy of entry-macro-gic.S, just for the sake
of an offset added to the IRQ number read from the GIC.

Add a compute_irqnr macro to entry-macro-gic.S so that any platform
can add it's own hook without having to copy the whole file again.

Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/hardware/entry-macro-gic.S  |    3 +
 arch/arm/mach-exynos4/include/mach/entry-macro.S |   60 ++--------------------
 2 files changed, 8 insertions(+), 55 deletions(-)

diff --git a/arch/arm/include/asm/hardware/entry-macro-gic.S b/arch/arm/include/asm/hardware/entry-macro-gic.S
index db83287..a01dc80 100644
--- a/arch/arm/include/asm/hardware/entry-macro-gic.S
+++ b/arch/arm/include/asm/hardware/entry-macro-gic.S
@@ -50,6 +50,9 @@
 	cmpcc	\irqnr, \irqnr
 	cmpne	\irqnr, \tmp
 	cmpcs	\irqnr, \irqnr
+#ifdef HAVE_GIC_BASE_OFFSET
+	compute_irqnr	\irqnr, \tmp
+#endif
 	.endm
 
 /* We assume that irqstat (the raw value of the IRQ acknowledge
diff --git a/arch/arm/mach-exynos4/include/mach/entry-macro.S b/arch/arm/mach-exynos4/include/mach/entry-macro.S
index f007168..7d87d4e 100644
--- a/arch/arm/mach-exynos4/include/mach/entry-macro.S
+++ b/arch/arm/mach-exynos4/include/mach/entry-macro.S
@@ -9,66 +9,16 @@
  * warranty of any kind, whether express or implied.
 */
 
-#include <mach/hardware.h>
-#include <asm/hardware/gic.h>
+#define HAVE_GIC_BASE_OFFSET	1
+#include <asm/hardware/entry-macro-gic.S>
 
-		.macro	disable_fiq
+		.macro	compute_irqnr, irqnr, tmp
+		addne	\irqnr, #32
 		.endm
 
-		.macro  get_irqnr_preamble, base, tmp
-		ldr	\base, =gic_cpu_base_addr
-		ldr	\base, [\base]
+		.macro	disable_fiq
 		.endm
 
 		.macro  arch_ret_to_user, tmp1, tmp2
 		.endm
 
-		/*
-		 * The interrupt numbering scheme is defined in the
-		 * interrupt controller spec.  To wit:
-		 *
-		 * Interrupts 0-15 are IPI
-		 * 16-28 are reserved
-		 * 29-31 are local.  We allow 30 to be used for the watchdog.
-		 * 32-1020 are global
-		 * 1021-1022 are reserved
-		 * 1023 is "spurious" (no interrupt)
-		 *
-		 * For now, we ignore all local interrupts so only return an interrupt if it's
-		 * between 30 and 1020.  The test_for_ipi routine below will pick up on IPIs.
-		 *
-		 * A simple read from the controller will tell us the number of the highest
-                 * priority enabled interrupt.  We then just need to check whether it is in the
-		 * valid range for an IRQ (30-1020 inclusive).
-		 */
-
-		.macro  get_irqnr_and_base, irqnr, irqstat, base, tmp
-
-		ldr     \irqstat, [\base, #GIC_CPU_INTACK] /* bits 12-10 = src CPU, 9-0 = int # */
-
-		ldr	\tmp, =1021
-
-		bic     \irqnr, \irqstat, #0x1c00
-
-		cmp     \irqnr, #15
-		cmpcc	\irqnr, \irqnr
-		cmpne	\irqnr, \tmp
-		cmpcs	\irqnr, \irqnr
-		addne	\irqnr, \irqnr, #32
-
-		.endm
-
-		/* We assume that irqstat (the raw value of the IRQ acknowledge
-		 * register) is preserved from the macro above.
-		 * If there is an IPI, we immediately signal end of interrupt on the
-		 * controller, since this requires the original irqstat value which
-		 * we won't easily be able to recreate later.
-		 */
-
-		.macro test_for_ipi, irqnr, irqstat, base, tmp
-		bic	\irqnr, \irqstat, #0x1c00
-		cmp	\irqnr, #16
-		strcc	\irqstat, [\base, #GIC_CPU_EOI]
-		cmpcs	\irqnr, \irqnr
-		.endm
-
-- 
1.7.0.4
