From: linux@prisktech.co.nz (Tony Prisk)
Date: Sun, 24 Mar 2013 14:12:25 +1300
Subject: [PATCH RESEND] irqchip: vt8500: Convert arch-vt8500 to new irqchip
 infrastructure
Message-ID: <1364087545-8388-1-git-send-email-linux@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves the arch-vt8500 irq code to drivers/irqchip and converts
it to use the new IRQCHIP_DECLARE and irqchip_init. This allows the removal
of some more functions from common.h

Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
---
Resend due to incorrect arm mailing list address in original git-send.

 arch/arm/mach-vt8500/Makefile                      |    2 +-
 arch/arm/mach-vt8500/common.h                      |    6 ------
 arch/arm/mach-vt8500/vt8500.c                      |   14 ++------------
 drivers/irqchip/Makefile                           |    1 +
 .../irq.c => drivers/irqchip/irq-vt8500.c          |    6 ++++++
 5 files changed, 10 insertions(+), 19 deletions(-)
 rename arch/arm/mach-vt8500/irq.c => drivers/irqchip/irq-vt8500.c (97%)

diff --git a/arch/arm/mach-vt8500/Makefile b/arch/arm/mach-vt8500/Makefile
index 92ceb24..4c8a846 100644
--- a/arch/arm/mach-vt8500/Makefile
+++ b/arch/arm/mach-vt8500/Makefile
@@ -1 +1 @@
-obj-$(CONFIG_ARCH_VT8500) += irq.o vt8500.o
+obj-$(CONFIG_ARCH_VT8500) += vt8500.o
diff --git a/arch/arm/mach-vt8500/common.h b/arch/arm/mach-vt8500/common.h
index 77611a6..087787a 100644
--- a/arch/arm/mach-vt8500/common.h
+++ b/arch/arm/mach-vt8500/common.h
@@ -18,13 +18,7 @@
 
 #include <linux/of.h>
 
-int __init vt8500_irq_init(struct device_node *node,
-				struct device_node *parent);
-
 /* defined in drivers/clk/clk-vt8500.c */
 void __init vtwm_clk_init(void __iomem *pmc_base);
 
-/* defined in irq.c */
-asmlinkage void vt8500_handle_irq(struct pt_regs *regs);
-
 #endif
diff --git a/arch/arm/mach-vt8500/vt8500.c b/arch/arm/mach-vt8500/vt8500.c
index 49e8005..1dd281e 100644
--- a/arch/arm/mach-vt8500/vt8500.c
+++ b/arch/arm/mach-vt8500/vt8500.c
@@ -20,6 +20,7 @@
 
 #include <linux/clocksource.h>
 #include <linux/io.h>
+#include <linux/irqchip.h>
 #include <linux/pm.h>
 
 #include <asm/mach-types.h>
@@ -166,16 +167,6 @@ void __init vt8500_init(void)
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
-static const struct of_device_id vt8500_irq_match[] __initconst = {
-	{ .compatible = "via,vt8500-intc", .data = vt8500_irq_init, },
-	{ /* sentinel */ },
-};
-
-static void __init vt8500_init_irq(void)
-{
-	of_irq_init(vt8500_irq_match);
-};
-
 static const char * const vt8500_dt_compat[] = {
 	"via,vt8500",
 	"wm,wm8650",
@@ -187,10 +178,9 @@ static const char * const vt8500_dt_compat[] = {
 DT_MACHINE_START(WMT_DT, "VIA/Wondermedia SoC (Device Tree Support)")
 	.dt_compat	= vt8500_dt_compat,
 	.map_io		= vt8500_map_io,
-	.init_irq	= vt8500_init_irq,
+	.init_irq	= irqchip_init,
 	.init_machine	= vt8500_init,
 	.init_time	= clocksource_of_init,
 	.restart	= vt8500_restart,
-	.handle_irq	= vt8500_handle_irq,
 MACHINE_END
 
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 98e3b87..b563535 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -9,3 +9,4 @@ obj-$(CONFIG_ARCH_SPEAR3XX)		+= spear-shirq.o
 obj-$(CONFIG_ARM_GIC)			+= irq-gic.o
 obj-$(CONFIG_ARM_VIC)			+= irq-vic.o
 obj-$(CONFIG_VERSATILE_FPGA_IRQ)	+= irq-versatile-fpga.o
+obj-$(CONFIG_ARCH_VT8500)		+= irq-vt8500.o
diff --git a/arch/arm/mach-vt8500/irq.c b/drivers/irqchip/irq-vt8500.c
similarity index 97%
rename from arch/arm/mach-vt8500/irq.c
rename to drivers/irqchip/irq-vt8500.c
index b9cf5ce..d970595 100644
--- a/arch/arm/mach-vt8500/irq.c
+++ b/drivers/irqchip/irq-vt8500.c
@@ -37,6 +37,9 @@
 
 #include <asm/irq.h>
 #include <asm/exception.h>
+#include <asm/mach/irq.h>
+
+#include "irqchip.h"
 
 #define VT8500_ICPC_IRQ		0x20
 #define VT8500_ICPC_FIQ		0x24
@@ -225,6 +228,8 @@ int __init vt8500_irq_init(struct device_node *node, struct device_node *parent)
 		goto out;
 	}
 
+	set_handle_irq(vt8500_handle_irq);
+
 	vt8500_init_irq_hw(intc[active_cnt].base);
 
 	pr_info("vt8500-irq: Added interrupt controller\n");
@@ -251,3 +256,4 @@ out:
 	return 0;
 }
 
+IRQCHIP_DECLARE(vt8500_irq, "via,vt8500-intc", vt8500_irq_init);
-- 
1.7.9.5
