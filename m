From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Thu, 31 Oct 2013 09:10:17 -0700
Subject: [PATCH 4/6] arm: zynq: Use of_platform_populate instead of bus_probe
In-Reply-To: <1383235819-2552-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1383235819-2552-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <1383235819-2552-5-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All new boards should be using this function instead of
of_platform_bus_probe.

Two side effects:
1. Possible to probe node which are not in the bus
2. Remove bus_id table from platform code

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
 arch/arm/mach-zynq/common.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
index 5f252569c689..5690925519bf 100644
--- a/arch/arm/mach-zynq/common.c
+++ b/arch/arm/mach-zynq/common.c
@@ -39,11 +39,6 @@
 
 void __iomem *zynq_scu_base;
 
-static struct of_device_id zynq_of_bus_ids[] __initdata = {
-	{ .compatible = "simple-bus", },
-	{}
-};
-
 /**
  * zynq_init_machine - System specific initialization, intended to be
  *		       called from board specific initialization.
@@ -55,7 +50,7 @@ static void __init zynq_init_machine(void)
 	 */
 	l2x0_of_init(0x02060000, 0xF0F0FFFF);
 
-	of_platform_bus_probe(NULL, zynq_of_bus_ids, NULL);
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
 static void __init zynq_timer_init(void)
-- 
1.8.4.1
