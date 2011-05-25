From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 25 May 2011 17:50:02 +0100
Subject: [RFC PATCH v3 07/13] ARM: ux500: use remapped PPI interrupts for
	local timer
In-Reply-To: <1306342208-32754-1-git-send-email-marc.zyngier@arm.com>
References: <1306342208-32754-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1306342208-32754-8-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the normal interrupt scheme for the local timers by using
a remapped PPI interrupt.

Cc: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
Cc: Linus Walleij <linus.walleij@stericsson.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-ux500/Kconfig      |    1 +
 arch/arm/mach-ux500/localtimer.c |    3 ++-
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-ux500/Kconfig b/arch/arm/mach-ux500/Kconfig
index 5862601..6f3eb99 100644
--- a/arch/arm/mach-ux500/Kconfig
+++ b/arch/arm/mach-ux500/Kconfig
@@ -4,6 +4,7 @@ config UX500_SOC_COMMON
 	bool
 	default y
 	select ARM_GIC
+	select ARM_GIC_VPPI
 	select HAS_MTU
 	select NOMADIK_GPIO
 	select ARM_ERRATA_753970
diff --git a/arch/arm/mach-ux500/localtimer.c b/arch/arm/mach-ux500/localtimer.c
index 5ba1133..f027cef 100644
--- a/arch/arm/mach-ux500/localtimer.c
+++ b/arch/arm/mach-ux500/localtimer.c
@@ -17,13 +17,14 @@
 #include <asm/irq.h>
 #include <asm/smp_twd.h>
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
-- 
1.7.0.4
