From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 15 Feb 2013 22:00:59 +0900
Subject: [PATCH 3/5] ARM: shmobile: sh73a0: Remove sh73a0_init_irq_dt()
In-Reply-To: <1360933261-6359-1-git-send-email-horms+renesas@verge.net.au>
References: <1360933261-6359-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1360933261-6359-4-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is not needed as irq_set_wake is
only used for suspend to ram which is not
a requirement for bringing up boards using DT.

Reported-by: Magnus Damm <magnus.damm@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-kzm9g-reference.c |    3 ++-
 arch/arm/mach-shmobile/intc-sh73a0.c           |    8 --------
 arch/arm/mach-shmobile/setup-sh73a0.c          |    3 ++-
 3 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-kzm9g-reference.c b/arch/arm/mach-shmobile/board-kzm9g-reference.c
index bce2a49..b9e40b6 100644
--- a/arch/arm/mach-shmobile/board-kzm9g-reference.c
+++ b/arch/arm/mach-shmobile/board-kzm9g-reference.c
@@ -24,6 +24,7 @@
 #include <linux/gpio.h>
 #include <linux/io.h>
 #include <linux/irq.h>
+#include <linux/irqchip.h>
 #include <linux/input.h>
 #include <linux/of_platform.h>
 #include <mach/sh73a0.h>
@@ -103,7 +104,7 @@ DT_MACHINE_START(KZM9G_DT, "kzm9g-reference")
 	.map_io		= sh73a0_map_io,
 	.init_early	= sh73a0_add_early_devices_dt,
 	.nr_irqs	= NR_IRQS_LEGACY,
-	.init_irq	= sh73a0_init_irq_dt,
+	.init_irq	= irqchip_init,
 	.init_machine	= kzm_init,
 	.init_late	= shmobile_init_late,
 	.init_time	= shmobile_timer_init,
diff --git a/arch/arm/mach-shmobile/intc-sh73a0.c b/arch/arm/mach-shmobile/intc-sh73a0.c
index 91faba6..a81a1d8 100644
--- a/arch/arm/mach-shmobile/intc-sh73a0.c
+++ b/arch/arm/mach-shmobile/intc-sh73a0.c
@@ -460,11 +460,3 @@ void __init sh73a0_init_irq(void)
 	sh73a0_pint1_cascade.handler = sh73a0_pint1_demux;
 	setup_irq(gic_spi(34), &sh73a0_pint1_cascade);
 }
-
-#ifdef CONFIG_OF
-void __init sh73a0_init_irq_dt(void)
-{
-	irqchip_init();
-	gic_arch_extn.irq_set_wake = sh73a0_set_wake;
-}
-#endif
diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
index f7ecb0b..fc0c73c 100644
--- a/arch/arm/mach-shmobile/setup-sh73a0.c
+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
@@ -22,6 +22,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/irqchip.h>
 #include <linux/platform_device.h>
 #include <linux/of_platform.h>
 #include <linux/delay.h>
@@ -865,7 +866,7 @@ DT_MACHINE_START(SH73A0_DT, "Generic SH73A0 (Flattened Device Tree)")
 	.map_io		= sh73a0_map_io,
 	.init_early	= sh73a0_add_early_devices_dt,
 	.nr_irqs	= NR_IRQS_LEGACY,
-	.init_irq	= sh73a0_init_irq_dt,
+	.init_irq	= irqchip_init,
 	.init_machine	= sh73a0_add_standard_devices_dt,
 	.init_time	= shmobile_timer_init,
 	.dt_compat	= sh73a0_boards_compat_dt,
-- 
1.7.10.4
