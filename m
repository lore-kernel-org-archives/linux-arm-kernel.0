From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue,  3 Mar 2015 08:38:07 +0100
Subject: [PATCH v2] ARM: at91: pm: fix SRAM allocation
Message-ID: <1425368287-4971-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On some platforms, there are multiple SRAM nodes defined in the device tree but
some of them are disabled, leading to allocation failure. Try to find the first
enabled SRAM node and allocate from it.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Tested-by: Wenyou Yang <wenyou.yang@atmel.com>
---
Changes in v2:
 - initialize pdev to NULL

 arch/arm/mach-at91/pm.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 5e34fb143309..aa4116e9452f 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -270,37 +270,35 @@ static void __init at91_pm_sram_init(void)
 	phys_addr_t sram_pbase;
 	unsigned long sram_base;
 	struct device_node *node;
-	struct platform_device *pdev;
+	struct platform_device *pdev = NULL;
 
-	node = of_find_compatible_node(NULL, NULL, "mmio-sram");
-	if (!node) {
-		pr_warn("%s: failed to find sram node!\n", __func__);
-		return;
+	for_each_compatible_node(node, NULL, "mmio-sram") {
+		pdev = of_find_device_by_node(node);
+		if (pdev) {
+			of_node_put(node);
+			break;
+		}
 	}
 
-	pdev = of_find_device_by_node(node);
 	if (!pdev) {
 		pr_warn("%s: failed to find sram device!\n", __func__);
-		goto put_node;
+		return;
 	}
 
 	sram_pool = dev_get_gen_pool(&pdev->dev);
 	if (!sram_pool) {
 		pr_warn("%s: sram pool unavailable!\n", __func__);
-		goto put_node;
+		return;
 	}
 
 	sram_base = gen_pool_alloc(sram_pool, at91_slow_clock_sz);
 	if (!sram_base) {
 		pr_warn("%s: unable to alloc ocram!\n", __func__);
-		goto put_node;
+		return;
 	}
 
 	sram_pbase = gen_pool_virt_to_phys(sram_pool, sram_base);
 	slow_clock = __arm_ioremap_exec(sram_pbase, at91_slow_clock_sz, false);
-
-put_node:
-	of_node_put(node);
 }
 #endif
 
-- 
2.1.0
