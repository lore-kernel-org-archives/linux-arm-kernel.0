From: joshc@ni.com (Josh Cartwright)
Date: Thu, 19 Mar 2015 08:33:52 -0500
Subject: [PATCH v3 1/2] ARM: zynq: use restart_handler mechanism for slcr reset
In-Reply-To: <BN1BFFO11FD008F29B247339CE49EAEA6AE2010@BN1BFFO11FD008.protection.gbl>
References: <BN1BFFO11FD008F29B247339CE49EAEA6AE2010@BN1BFFO11FD008.protection.gbl>
Message-ID: <1426772033-29277-1-git-send-email-joshc@ni.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

By making use of the restart_handler chain mechanism, the SLCR-based
reset mechanism can be prioritized amongst other mechanisms available on
a particular board.

Choose a default high-ish priority of 192 for this restart mechanism.

Signed-off-by: Josh Cartwright <joshc@ni.com>
---
v2 -> v3: Don't drop the kerneldoc
v1 -> v2: Also drop zynq_slcr_system_reset prototype from common.h
 arch/arm/mach-zynq/common.c |  6 ------
 arch/arm/mach-zynq/common.h |  1 -
 arch/arm/mach-zynq/slcr.c   | 15 +++++++++++++--
 3 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
index 58ef2a7..616d584 100644
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
diff --git a/arch/arm/mach-zynq/common.h b/arch/arm/mach-zynq/common.h
index 382c60e..f2f0bf2 100644
--- a/arch/arm/mach-zynq/common.h
+++ b/arch/arm/mach-zynq/common.h
@@ -21,7 +21,6 @@ void zynq_secondary_startup(void);
 
 extern int zynq_slcr_init(void);
 extern int zynq_early_slcr_init(void);
-extern void zynq_slcr_system_reset(void);
 extern void zynq_slcr_cpu_stop(int cpu);
 extern void zynq_slcr_cpu_start(int cpu);
 extern bool zynq_slcr_cpu_state_read(int cpu);
diff --git a/arch/arm/mach-zynq/slcr.c b/arch/arm/mach-zynq/slcr.c
index c3c24fd8..fa4c796 100644
--- a/arch/arm/mach-zynq/slcr.c
+++ b/arch/arm/mach-zynq/slcr.c
@@ -15,6 +15,7 @@
  */
 
 #include <linux/io.h>
+#include <linux/reboot.h>
 #include <linux/mfd/syscon.h>
 #include <linux/of_address.h>
 #include <linux/regmap.h>
@@ -92,9 +93,11 @@ u32 zynq_slcr_get_device_id(void)
 }
 
 /**
- * zynq_slcr_system_reset - Reset the entire system.
+ * zynq_slcr_system_restart - Restart the entire system.
  */
-void zynq_slcr_system_reset(void)
+static
+int zynq_slcr_system_restart(struct notifier_block *nb,
+			     unsigned long action, void *data)
 {
 	u32 reboot;
 
@@ -113,8 +116,14 @@ void zynq_slcr_system_reset(void)
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
@@ -219,6 +228,8 @@ int __init zynq_early_slcr_init(void)
 	/* unlock the SLCR so that registers can be changed */
 	zynq_slcr_unlock();
 
+	register_restart_handler(&zynq_slcr_restart_nb);
+
 	pr_info("%s mapped to %p\n", np->name, zynq_slcr_base);
 
 	of_node_put(np);
-- 
2.3.3
