From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 25 May 2011 17:50:05 +0100
Subject: [RFC PATCH v3 10/13] ARM: exynos4: use remapped PPI interrupts for
	local timer
In-Reply-To: <1306342208-32754-1-git-send-email-marc.zyngier@arm.com>
References: <1306342208-32754-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1306342208-32754-11-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the normal interrupt scheme for the local timers by using
a remapped PPI interrupt.

Tested on a SMDK-S5PV310 board.

Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-exynos4/include/mach/entry-macro.S |   12 +-----------
 arch/arm/mach-exynos4/localtimer.c               |    3 ++-
 arch/arm/plat-s5p/Kconfig                        |    1 +
 3 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-exynos4/include/mach/entry-macro.S b/arch/arm/mach-exynos4/include/mach/entry-macro.S
index d8f38c2..f007168 100644
--- a/arch/arm/mach-exynos4/include/mach/entry-macro.S
+++ b/arch/arm/mach-exynos4/include/mach/entry-macro.S
@@ -50,7 +50,7 @@
 
 		bic     \irqnr, \irqstat, #0x1c00
 
-		cmp     \irqnr, #29
+		cmp     \irqnr, #15
 		cmpcc	\irqnr, \irqnr
 		cmpne	\irqnr, \tmp
 		cmpcs	\irqnr, \irqnr
@@ -72,13 +72,3 @@
 		cmpcs	\irqnr, \irqnr
 		.endm
 
-		/* As above, this assumes that irqstat and base are preserved.. */
-
-		.macro test_for_ltirq, irqnr, irqstat, base, tmp
-		bic	\irqnr, \irqstat, #0x1c00
-		mov	\tmp, #0
-		cmp	\irqnr, #29
-		moveq	\tmp, #1
-		streq	\irqstat, [\base, #GIC_CPU_EOI]
-		cmp	\tmp, #0
-		.endm
diff --git a/arch/arm/mach-exynos4/localtimer.c b/arch/arm/mach-exynos4/localtimer.c
index 6bf3d0a..315de6f 100644
--- a/arch/arm/mach-exynos4/localtimer.c
+++ b/arch/arm/mach-exynos4/localtimer.c
@@ -14,13 +14,14 @@
 
 #include <asm/irq.h>
 #include <asm/localtimer.h>
+#include <asm/hardware/gic.h>
 
 /*
  * Setup the local clock events for a CPU.
  */
 int __cpuinit local_timer_setup(struct clock_event_device *evt)
 {
-	evt->irq = IRQ_LOCALTIMER;
+	evt->irq = gic_ppi_to_vppi(IRQ_LOCALTIMER);
 	twd_timer_setup(evt);
 	return 0;
 }
diff --git a/arch/arm/plat-s5p/Kconfig b/arch/arm/plat-s5p/Kconfig
index 6751bcf..0e30e25 100644
--- a/arch/arm/plat-s5p/Kconfig
+++ b/arch/arm/plat-s5p/Kconfig
@@ -11,6 +11,7 @@ config PLAT_S5P
 	default y
 	select ARM_VIC if !ARCH_EXYNOS4
 	select ARM_GIC if ARCH_EXYNOS4
+	select ARM_GIC_VPPI if ARCH_EXYNOS4
 	select NO_IOPORT
 	select ARCH_REQUIRE_GPIOLIB
 	select S3C_GPIO_TRACK
-- 
1.7.0.4
