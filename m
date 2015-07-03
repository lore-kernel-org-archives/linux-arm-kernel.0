From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri,  3 Jul 2015 13:55:52 +0200
Subject: [PATCH v3 3/4] ARM: mvebu: Allow using the GIC for wakeup in standby
 mode
In-Reply-To: <1435924553-22428-1-git-send-email-gregory.clement@free-electrons.com>
References: <1435924553-22428-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1435924553-22428-4-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On the Armada 375/38x/39x SoCs, in standby mode the SoCs stay powered
and it is possible to wake-up from any interrupt sources. This patch
adds flag to the GIC irqchip driver to let linux know this.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/mach-mvebu/board-v7.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/mach-mvebu/board-v7.c b/arch/arm/mach-mvebu/board-v7.c
index e5911defccac..b789f7037445 100644
--- a/arch/arm/mach-mvebu/board-v7.c
+++ b/arch/arm/mach-mvebu/board-v7.c
@@ -18,6 +18,7 @@
 #include <linux/of_address.h>
 #include <linux/of_fdt.h>
 #include <linux/of_platform.h>
+#include <linux/irq.h>
 #include <linux/io.h>
 #include <linux/clocksource.h>
 #include <linux/dma-mapping.h>
@@ -26,6 +27,7 @@
 #include <linux/signal.h>
 #include <linux/slab.h>
 #include <linux/irqchip.h>
+#include <linux/irqchip/arm-gic.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -129,6 +131,13 @@ static int armada_375_external_abort_wa(unsigned long addr, unsigned int fsr,
 
 static void __init mvebu_init_irq(void)
 {
+	struct device_node *np;
+
+	np = of_find_compatible_node(NULL, NULL, "arm,cortex-a9-gic");
+	if (np)
+		gic_set_irqchip_flags(IRQCHIP_SKIP_SET_WAKE |
+				      IRQCHIP_MASK_ON_SUSPEND);
+	of_node_put(np);
 	irqchip_init();
 	mvebu_scu_enable();
 	coherency_init();
-- 
2.1.0
