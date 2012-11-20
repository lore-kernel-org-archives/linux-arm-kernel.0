From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 20 Nov 2012 23:01:01 +0100
Subject: [PATCH 10/16] ARM: highbank: use common irqchip_init
In-Reply-To: <1353448867-15008-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353448867-15008-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1353448867-15008-11-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Now that we have common irqchip init, use it on highbank platform.

[Thomas Petazzoni: remove .handle_irq from DT_MACHINE_STRUCT, as it is
set by the the irq-gic driver].

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-highbank/highbank.c |    9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-highbank/highbank.c b/arch/arm/mach-highbank/highbank.c
index 40e36a5..45314ea 100644
--- a/arch/arm/mach-highbank/highbank.c
+++ b/arch/arm/mach-highbank/highbank.c
@@ -18,6 +18,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/io.h>
 #include <linux/irq.h>
+#include <linux/irqchip.h>
 #include <linux/irqdomain.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
@@ -82,11 +83,6 @@ void highbank_set_cpu_jump(int cpu, void *jump_addr)
 			  HB_JUMP_TABLE_PHYS(cpu) + 15);
 }
 
-const static struct of_device_id irq_match[] = {
-	{ .compatible = "arm,cortex-a9-gic", .data = gic_of_init, },
-	{}
-};
-
 #ifdef CONFIG_CACHE_L2X0
 static void highbank_l2x0_disable(void)
 {
@@ -97,7 +93,7 @@ static void highbank_l2x0_disable(void)
 
 static void __init highbank_init_irq(void)
 {
-	of_irq_init(irq_match);
+	irqchip_init();
 
 #ifdef CONFIG_CACHE_L2X0
 	/* Enable PL310 L2 Cache controller */
@@ -219,7 +215,6 @@ DT_MACHINE_START(HIGHBANK, "Highbank")
 	.map_io		= highbank_map_io,
 	.init_irq	= highbank_init_irq,
 	.timer		= &highbank_timer,
-	.handle_irq	= gic_handle_irq,
 	.init_machine	= highbank_init,
 	.dt_compat	= highbank_match,
 	.restart	= highbank_restart,
-- 
1.7.9.5
