From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  5 Jul 2011 09:49:07 +0100
Subject: [PATCH v8 06/14] ARM: shmobile: use remapped PPI interrupts for local
	timer
In-Reply-To: <1309855755-6261-1-git-send-email-marc.zyngier@arm.com>
References: <1309855755-6261-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1309855755-6261-7-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the normal interrupt scheme for the local timers by using
a remapped PPI interrupt.

Cc: Paul Mundt <lethal@linux-sh.org>
Cc: Magnus Damm <magnus.damm@gmail.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-shmobile/Kconfig                    |    1 +
 arch/arm/mach-shmobile/entry-intc.S               |    3 ---
 arch/arm/mach-shmobile/include/mach/entry-macro.S |    3 ---
 arch/arm/mach-shmobile/localtimer.c               |    3 ++-
 4 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 0c8f6cf..ca8e06c 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -26,6 +26,7 @@ config ARCH_SH73A0
 	select SH_CLK_CPG
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_GIC
+	select ARM_GIC_PPI_MAP
 
 comment "SH-Mobile Board Type"
 
diff --git a/arch/arm/mach-shmobile/entry-intc.S b/arch/arm/mach-shmobile/entry-intc.S
index cac0a7a..1a1c00c 100644
--- a/arch/arm/mach-shmobile/entry-intc.S
+++ b/arch/arm/mach-shmobile/entry-intc.S
@@ -51,7 +51,4 @@
 	.macro  test_for_ipi, irqnr, irqstat, base, tmp
 	.endm
 
-	.macro  test_for_ltirq, irqnr, irqstat, base, tmp
-	.endm
-
 	arch_irq_handler shmobile_handle_irq_intc
diff --git a/arch/arm/mach-shmobile/include/mach/entry-macro.S b/arch/arm/mach-shmobile/include/mach/entry-macro.S
index d791f10..8d4a416 100644
--- a/arch/arm/mach-shmobile/include/mach/entry-macro.S
+++ b/arch/arm/mach-shmobile/include/mach/entry-macro.S
@@ -27,8 +27,5 @@
 	.macro  test_for_ipi, irqnr, irqstat, base, tmp
 	.endm
 
-	.macro  test_for_ltirq, irqnr, irqstat, base, tmp
-	.endm
-
 	.macro  arch_ret_to_user, tmp1, tmp2
 	.endm
diff --git a/arch/arm/mach-shmobile/localtimer.c b/arch/arm/mach-shmobile/localtimer.c
index ad9ccc9..b6166d8 100644
--- a/arch/arm/mach-shmobile/localtimer.c
+++ b/arch/arm/mach-shmobile/localtimer.c
@@ -14,13 +14,14 @@
 #include <linux/clockchips.h>
 #include <asm/smp_twd.h>
 #include <asm/localtimer.h>
+#include <asm/hardware/gic.h>
 
 /*
  * Setup the local clock events for a CPU.
  */
 int __cpuinit local_timer_setup(struct clock_event_device *evt)
 {
-	evt->irq = 29;
+	evt->irq = gic_ppi_map(29);
 	twd_timer_setup(evt);
 	return 0;
 }
-- 
1.7.0.4
