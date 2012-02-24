From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 24 Feb 2012 18:32:17 +0100
Subject: [PATCH] ARM: integrator: convert to sparse irqs
Message-ID: <1330104737-22782-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This converts the Integrator AP/CP to use sparse IRQs.
Tested on both machines.

Cc: Rob Herring <rob.herring@calxeda.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/Kconfig                             |    1 +
 arch/arm/mach-integrator/core.c              |    3 ++-
 arch/arm/mach-integrator/include/mach/irqs.h |    3 ++-
 arch/arm/mach-integrator/integrator_ap.c     |    3 ++-
 arch/arm/mach-integrator/integrator_cp.c     |    3 ++-
 arch/arm/mach-integrator/pci.c               |    3 ++-
 arch/arm/mach-integrator/pci_v3.c            |    3 ++-
 7 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 4852a6b..fc10ed8 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -266,6 +266,7 @@ config ARCH_INTEGRATOR
 	select PLAT_VERSATILE
 	select PLAT_VERSATILE_FPGA_IRQ
 	select NEED_MACH_MEMORY_H
+	select SPARSE_IRQ
 	help
 	  Support for ARM's Integrator platform.
 
diff --git a/arch/arm/mach-integrator/core.c b/arch/arm/mach-integrator/core.c
index 15b87f2..304dfb2 100644
--- a/arch/arm/mach-integrator/core.c
+++ b/arch/arm/mach-integrator/core.c
@@ -25,8 +25,9 @@
 
 #include <mach/hardware.h>
 #include <mach/platform.h>
-#include <asm/irq.h>
 #include <mach/cm.h>
+#include <mach/irqs.h>
+
 #include <asm/system.h>
 #include <asm/leds.h>
 #include <asm/mach-types.h>
diff --git a/arch/arm/mach-integrator/include/mach/irqs.h b/arch/arm/mach-integrator/include/mach/irqs.h
index 1fbe6d1..a19a1a2 100644
--- a/arch/arm/mach-integrator/include/mach/irqs.h
+++ b/arch/arm/mach-integrator/include/mach/irqs.h
@@ -78,5 +78,6 @@
 #define IRQ_SIC_CP_LMINT7		46
 #define IRQ_SIC_END			46
 
-#define NR_IRQS                         47
+#define NR_IRQS_INTEGRATOR_AP		34
+#define NR_IRQS_INTEGRATOR_CP		47
 
diff --git a/arch/arm/mach-integrator/integrator_ap.c b/arch/arm/mach-integrator/integrator_ap.c
index 4dde28b..871f148 100644
--- a/arch/arm/mach-integrator/integrator_ap.c
+++ b/arch/arm/mach-integrator/integrator_ap.c
@@ -38,13 +38,13 @@
 #include <mach/hardware.h>
 #include <mach/platform.h>
 #include <asm/hardware/arm_timer.h>
-#include <asm/irq.h>
 #include <asm/setup.h>
 #include <asm/param.h>		/* HZ */
 #include <asm/mach-types.h>
 #include <asm/sched_clock.h>
 
 #include <mach/lm.h>
+#include <mach/irqs.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/irq.h>
@@ -475,6 +475,7 @@ MACHINE_START(INTEGRATOR, "ARM-Integrator")
 	.atag_offset	= 0x100,
 	.reserve	= integrator_reserve,
 	.map_io		= ap_map_io,
+	.nr_irqs	= NR_IRQS_INTEGRATOR_AP,
 	.init_early	= integrator_init_early,
 	.init_irq	= ap_init_irq,
 	.timer		= &ap_timer,
diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
index be9ead4..48a115a 100644
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-integrator/integrator_cp.c
@@ -26,7 +26,6 @@
 
 #include <mach/hardware.h>
 #include <mach/platform.h>
-#include <asm/irq.h>
 #include <asm/setup.h>
 #include <asm/mach-types.h>
 #include <asm/hardware/arm_timer.h>
@@ -34,6 +33,7 @@
 
 #include <mach/cm.h>
 #include <mach/lm.h>
+#include <mach/irqs.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/irq.h>
@@ -464,6 +464,7 @@ MACHINE_START(CINTEGRATOR, "ARM-IntegratorCP")
 	.atag_offset	= 0x100,
 	.reserve	= integrator_reserve,
 	.map_io		= intcp_map_io,
+	.nr_irqs	= NR_IRQS_INTEGRATOR_CP,
 	.init_early	= intcp_init_early,
 	.init_irq	= intcp_init_irq,
 	.timer		= &cp_timer,
diff --git a/arch/arm/mach-integrator/pci.c b/arch/arm/mach-integrator/pci.c
index 520b6bf..e15aa43 100644
--- a/arch/arm/mach-integrator/pci.c
+++ b/arch/arm/mach-integrator/pci.c
@@ -26,11 +26,12 @@
 #include <linux/interrupt.h>
 #include <linux/init.h>
 
-#include <asm/irq.h>
 #include <asm/system.h>
 #include <asm/mach/pci.h>
 #include <asm/mach-types.h>
 
+#include <mach/irqs.h>
+
 /* 
  * A small note about bridges and interrupts.  The DECchip 21050 (and
  * later) adheres to the PCI-PCI bridge specification.  This says that
diff --git a/arch/arm/mach-integrator/pci_v3.c b/arch/arm/mach-integrator/pci_v3.c
index 3c82566..65e5896 100644
--- a/arch/arm/mach-integrator/pci_v3.c
+++ b/arch/arm/mach-integrator/pci_v3.c
@@ -30,7 +30,8 @@
 
 #include <mach/hardware.h>
 #include <mach/platform.h>
-#include <asm/irq.h>
+#include <mach/irqs.h>
+
 #include <asm/signal.h>
 #include <asm/system.h>
 #include <asm/mach/pci.h>
-- 
1.7.7.6
