From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 12 Jun 2014 17:09:32 +0200
Subject: [PATCHv5 3/3] ARM: mvebu: update L2/PCIe deadlock workaround after
 L2CC cleanup
In-Reply-To: <1402585772-10405-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1402585772-10405-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1402585772-10405-4-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 497a92308af8e9385fa3d135f7f416a997e4b93b ("ARM: mvebu:
implement L2/PCIe deadlock workaround") introduced some logic in
coherency.c to adjust the PL310 cache controller Device Tree node of
Armada 375 and Armada 38x platform to include the 'arm,io-coherent'
property if the system is running with hardware I/O coherency enabled.

However, with the L2CC driver cleanup done by Russell King, the
initialization of the L2CC driver has been moved earlier, and is now
part of the init_IRQ() ARM function in
arch/arm/kernel/irq.c. Therefore, calling coherency_init() in
->init_time() is now too late, as the Device Tree property gets added
too late (after the L2CC driver has been initialized).

In order to fix this, this commit removes the ->init_time() callback
use in board-v7.c and replaces it with an ->init_irq() callback. We
therefore no longer use the default ->init_irq() callback, but we now
use the default ->init_time() callback.

In this newly introduced ->init_irq() callback, we call irqchip_init()
which is the default behavior when ->init_irq() isn't defined, and
then do the initialization related to the coherency: SCU, coherency
fabric, and mvebu-mbus (which is needed to start secondary CPUs).

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/board-v7.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-mvebu/board-v7.c b/arch/arm/mach-mvebu/board-v7.c
index 804c952..b2524d6 100644
--- a/arch/arm/mach-mvebu/board-v7.c
+++ b/arch/arm/mach-mvebu/board-v7.c
@@ -23,6 +23,7 @@
 #include <linux/mbus.h>
 #include <linux/signal.h>
 #include <linux/slab.h>
+#include <linux/irqchip.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -71,10 +72,9 @@ static int armada_375_external_abort_wa(unsigned long addr, unsigned int fsr,
 	return 1;
 }
 
-static void __init mvebu_timer_and_clk_init(void)
+static void __init mvebu_init_irq(void)
 {
-	of_clk_init(NULL);
-	clocksource_of_init();
+	irqchip_init();
 	mvebu_scu_enable();
 	coherency_init();
 	BUG_ON(mvebu_mbus_dt_init(coherency_available()));
@@ -194,7 +194,7 @@ DT_MACHINE_START(ARMADA_370_XP_DT, "Marvell Armada 370/XP (Device Tree)")
 	.l2c_aux_mask	= ~0,
 	.smp		= smp_ops(armada_xp_smp_ops),
 	.init_machine	= mvebu_dt_init,
-	.init_time	= mvebu_timer_and_clk_init,
+	.init_irq       = mvebu_init_irq,
 	.restart	= mvebu_restart,
 	.dt_compat	= armada_370_xp_dt_compat,
 MACHINE_END
@@ -207,7 +207,7 @@ static const char * const armada_375_dt_compat[] = {
 DT_MACHINE_START(ARMADA_375_DT, "Marvell Armada 375 (Device Tree)")
 	.l2c_aux_val	= 0,
 	.l2c_aux_mask	= ~0,
-	.init_time	= mvebu_timer_and_clk_init,
+	.init_irq       = mvebu_init_irq,
 	.init_machine	= mvebu_dt_init,
 	.restart	= mvebu_restart,
 	.dt_compat	= armada_375_dt_compat,
@@ -222,7 +222,7 @@ static const char * const armada_38x_dt_compat[] = {
 DT_MACHINE_START(ARMADA_38X_DT, "Marvell Armada 380/385 (Device Tree)")
 	.l2c_aux_val	= 0,
 	.l2c_aux_mask	= ~0,
-	.init_time	= mvebu_timer_and_clk_init,
+	.init_irq       = mvebu_init_irq,
 	.restart	= mvebu_restart,
 	.dt_compat	= armada_38x_dt_compat,
 MACHINE_END
-- 
2.0.0
