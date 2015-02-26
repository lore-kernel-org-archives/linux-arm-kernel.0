From: joshc@ni.com (Josh Cartwright)
Date: Thu, 26 Feb 2015 14:14:17 -0600
Subject: [PATCH] ARM: zynq: use restart_handler mechanism for slcr reset
Message-ID: <1424981657-26930-1-git-send-email-joshc@ni.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

By making use of the restart_handler chain mechanism, the SLCR-based
reset mechanism can be prioritized amongst other mechanisms available on
a particular board.

Choose a default high-ish priority of 192 for this restart mechanism.

Signed-off-by: Josh Cartwright <joshc@ni.com>
---
 arch/arm/mach-zynq/common.c |  6 ------
 arch/arm/mach-zynq/slcr.c   | 16 ++++++++++++----
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
index c887196..39c1c7d4 100644
--- a/arch/arm/mach-zynq/common.c
+++ b/arch/arm/mach-zynq/common.c
@@ -190,11 +190,6 @@ static void __init zynq_irq_init(void)
 	irqchip_init();
 }
 
-static void zynq_system_reset(enum reboot_mode mode, const char *cmd)
-{
-	zynq_slcr_system_reset();
-}
-
 static const char * const zynq_dt_match[] = {
 	"xlnx,zynq-7000",
 	NULL
@@ -212,5 +207,4 @@ DT_MACHINE_START(XILINX_EP107, "Xilinx Zynq Platform")
 	.init_time	= zynq_timer_init,
 	.dt_compat	= zynq_dt_match,
 	.reserve	= zynq_memory_init,
-	.restart	= zynq_system_reset,
 MACHINE_END
diff --git a/arch/arm/mach-zynq/slcr.c b/arch/arm/mach-zynq/slcr.c
index c3c24fd8..e92b319 100644
--- a/arch/arm/mach-zynq/slcr.c
+++ b/arch/arm/mach-zynq/slcr.c
@@ -15,6 +15,7 @@
  */
 
 #include <linux/io.h>
+#include <linux/reboot.h>
 #include <linux/mfd/syscon.h>
 #include <linux/of_address.h>
 #include <linux/regmap.h>
@@ -91,10 +92,9 @@ u32 zynq_slcr_get_device_id(void)
 	return val;
 }
 
-/**
- * zynq_slcr_system_reset - Reset the entire system.
- */
-void zynq_slcr_system_reset(void)
+static
+int zynq_slcr_system_restart(struct notifier_block *nb,
+			     unsigned long action, void *data)
 {
 	u32 reboot;
 
@@ -113,8 +113,14 @@ void zynq_slcr_system_reset(void)
 	zynq_slcr_read(&reboot, SLCR_REBOOT_STATUS_OFFSET);
 	zynq_slcr_write(reboot & 0xF0FFFFFF, SLCR_REBOOT_STATUS_OFFSET);
 	zynq_slcr_write(1, SLCR_PS_RST_CTRL_OFFSET);
+	return 0;
 }
 
+static struct notifier_block zynq_slcr_restart_nb = {
+	.notifier_call	= zynq_slcr_system_restart,
+	.priority	= 192,
+};
+
 /**
  * zynq_slcr_cpu_start - Start cpu
  * @cpu:	cpu number
@@ -219,6 +225,8 @@ int __init zynq_early_slcr_init(void)
 	/* unlock the SLCR so that registers can be changed */
 	zynq_slcr_unlock();
 
+	register_restart_handler(&zynq_slcr_restart_nb);
+
 	pr_info("%s mapped to %p\n", np->name, zynq_slcr_base);
 
 	of_node_put(np);
-- 
2.3.0
