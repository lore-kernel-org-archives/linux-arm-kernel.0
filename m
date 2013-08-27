From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 27 Aug 2013 23:28:10 +0200
Subject: [PATCH RFC v2 16/16] ARM: zynq: Don't call of_clk_init()
In-Reply-To: <1376964271-22715-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1376964271-22715-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1377638890-371-17-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Soren Brinkmann <soren.brinkmann@xilinx.com>

of_clk_init() has been moved to be called from common code, therefore
remove it from Zynq's clock init routine. Since the Zynq's clock setup
routine relies on an initialized SLCR, zynq_slcr_init() is moved to
init_irq() instead.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: Mike Turquette <mturquette@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/mach-zynq/common.c |    9 ++++-----
 drivers/clk/zynq/clkc.c     |    4 +++-
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
index 5f25256..9f79ebb 100644
--- a/arch/arm/mach-zynq/common.c
+++ b/arch/arm/mach-zynq/common.c
@@ -19,8 +19,7 @@
 #include <linux/cpumask.h>
 #include <linux/platform_device.h>
 #include <linux/clk.h>
-#include <linux/clk/zynq.h>
-#include <linux/clocksource.h>
+#include <linux/irqchip.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
@@ -58,10 +57,10 @@ static void __init zynq_init_machine(void)
 	of_platform_bus_probe(NULL, zynq_of_bus_ids, NULL);
 }
 
-static void __init zynq_timer_init(void)
+static void __init zynq_init_irq(void)
 {
+	irqchip_init();
 	zynq_slcr_init();
-	clocksource_of_init();
 }
 
 static struct map_desc zynq_cortex_a9_scu_map __initdata = {
@@ -104,8 +103,8 @@ static const char * const zynq_dt_match[] = {
 DT_MACHINE_START(XILINX_EP107, "Xilinx Zynq Platform")
 	.smp		= smp_ops(zynq_smp_ops),
 	.map_io		= zynq_map_io,
+	.init_irq	= zynq_init_irq,
 	.init_machine	= zynq_init_machine,
-	.init_time	= zynq_timer_init,
 	.dt_compat	= zynq_dt_match,
 	.restart	= zynq_system_reset,
 MACHINE_END
diff --git a/drivers/clk/zynq/clkc.c b/drivers/clk/zynq/clkc.c
index 089d3e3..53b851e 100644
--- a/drivers/clk/zynq/clkc.c
+++ b/drivers/clk/zynq/clkc.c
@@ -206,6 +206,9 @@ static void __init zynq_clk_setup(struct device_node *np)
 
 	pr_info("Zynq clock init\n");
 
+	if (WARN_ON(!zynq_slcr_base_priv))
+		return;
+
 	/* get clock output names from DT */
 	for (i = 0; i < clk_max; i++) {
 		if (of_property_read_string_index(np, "clock-output-names",
@@ -532,5 +535,4 @@ CLK_OF_DECLARE(zynq_clkc, "xlnx,ps7-clkc", zynq_clk_setup);
 void __init zynq_clock_init(void __iomem *slcr_base)
 {
 	zynq_slcr_base_priv = slcr_base;
-	of_clk_init(NULL);
 }
-- 
1.7.2.5
