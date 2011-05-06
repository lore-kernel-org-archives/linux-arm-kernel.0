From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  6 May 2011 11:33:08 +0100
Subject: [RFC PATCH v2 03/12] ARM: omap4: use remapped PPI interrupts for
	local timer
In-Reply-To: <1304677997-26947-1-git-send-email-marc.zyngier@arm.com>
References: <1304677997-26947-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1304677997-26947-4-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the normal interrupt scheme for the local timers by using
a remapped PPI interrupt.

Tested on a Pandaboard.

Cc: Tony Lindgren <tony@atomide.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-omap2/Kconfig                    |    1 +
 arch/arm/mach-omap2/include/mach/entry-macro.S |   14 +-------------
 arch/arm/mach-omap2/timer-mpu.c                |    3 ++-
 3 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index b997a35..8282921 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -44,6 +44,7 @@ config ARCH_OMAP4
 	depends on ARCH_OMAP2PLUS
 	select CPU_V7
 	select ARM_GIC
+	select ARM_GIC_VPPI
 	select LOCAL_TIMERS if SMP
 	select PL310_ERRATA_588369
 	select PL310_ERRATA_727915
diff --git a/arch/arm/mach-omap2/include/mach/entry-macro.S b/arch/arm/mach-omap2/include/mach/entry-macro.S
index a48690b..22d86ef 100644
--- a/arch/arm/mach-omap2/include/mach/entry-macro.S
+++ b/arch/arm/mach-omap2/include/mach/entry-macro.S
@@ -78,7 +78,7 @@
 4401:		ldr     \irqstat, [\base, #GIC_CPU_INTACK]
 		ldr     \tmp, =1021
 		bic     \irqnr, \irqstat, #0x1c00
-		cmp     \irqnr, #29
+		cmp     \irqnr, #15
 		cmpcc   \irqnr, \irqnr
 		cmpne   \irqnr, \tmp
 		cmpcs   \irqnr, \irqnr
@@ -101,18 +101,6 @@
 		it	cs
 		cmpcs	\irqnr, \irqnr
 		.endm
-
-		/* As above, this assumes that irqstat and base are preserved */
-
-		.macro test_for_ltirq, irqnr, irqstat, base, tmp
-		bic	\irqnr, \irqstat, #0x1c00
-		mov 	\tmp, #0
-		cmp	\irqnr, #29
-		itt	eq
-		moveq	\tmp, #1
-		streq	\irqstat, [\base, #GIC_CPU_EOI]
-		cmp	\tmp, #0
-		.endm
 #endif	/* CONFIG_SMP */
 
 #else	/* MULTI_OMAP2 */
diff --git a/arch/arm/mach-omap2/timer-mpu.c b/arch/arm/mach-omap2/timer-mpu.c
index 31c0ac4..1fd5ca5 100644
--- a/arch/arm/mach-omap2/timer-mpu.c
+++ b/arch/arm/mach-omap2/timer-mpu.c
@@ -22,6 +22,7 @@
 #include <asm/irq.h>
 #include <asm/smp_twd.h>
 #include <asm/localtimer.h>
+#include <asm/hardware/gic.h>
 
 /*
  * Setup the local clock events for a CPU.
@@ -32,7 +33,7 @@ int __cpuinit local_timer_setup(struct clock_event_device *evt)
 	if (omap_rev() == OMAP4430_REV_ES1_0)
 		return -ENXIO;
 
-	evt->irq = OMAP44XX_IRQ_LOCALTIMER;
+	evt->irq = gic_ppi_to_vppi(OMAP44XX_IRQ_LOCALTIMER);
 	twd_timer_setup(evt);
 	return 0;
 }
-- 
1.7.0.4
